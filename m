Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9078EC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SBb-00039s-3j; Wed, 23 Sep 2026 14:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9SBU-00036K-59
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:59:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9SBS-0003gZ-GJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:59:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGU3543106210
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SaeoL+LAdUD1UShX79FWgCP2lOA43waeiO8thU1+3XM=; b=lK7G3D8NBNd7O+U0
 oW3uWHdV6/L+lfHfQMgE7nhHXOLojw4SkgPOUqTT0+dqV4cBOwZWah5mhj5s6tqc
 AWN7lx+meEUgXncUE7vo4lJisXXDjbiitz/9t60YDSI/+LdG3+QmqmLeI2yi5zPL
 tdZ8fiBR9ZUGg5nWJHM3SUlG2jtVWxXeouxJCfxLp8EchEHHZHq2cSfA/QY5VlpE
 OxDKO8+TOwjPEAu9xJoeeojcqeDqcmukE1L6docRYfIQglJgEbEDZOaf3+VBC/9w
 ayhP/EFv1C3LtSdE1dRxsozTgZEB+0Sx9qJ61u+xgFD8tZLlrhovyTeFZPUFQ+PJ
 d4V0aw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwhfpp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:59:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33310847fcaso2185826eec.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189948; x=1790794748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SaeoL+LAdUD1UShX79FWgCP2lOA43waeiO8thU1+3XM=;
 b=ZySor4cctZQ9ieuF6rZ+OD6WS97T+UpJfyGaJBY0X//mSaOlcu+y+wcI91EEo13Gg0
 RDgXXki8gNc1shVYUMPgnEQP5nrFGhE7+qpy/JRIcQWwniVZFo43thdfvr1OItVuqDBx
 7aXqVZCY9+UxBRW2J83Y+pZ78hHk6qKpT1yAAa+z5pEtUE9JX8Gth0HUB0+36OyACa9t
 xs0W++TKpC2b6+WSlUqGZJUnITvBWtjyrtWniiMm8z30P7JJB/7Ytao1r2VR29BofqgS
 12p0zIUB/WdJNTA6ix3QqAZahNFbDvrudoRps0CuFYnhgcX2ACJqRij3+elzJQjTb3AW
 I7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189948; x=1790794748;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SaeoL+LAdUD1UShX79FWgCP2lOA43waeiO8thU1+3XM=;
 b=SsCyjBf3vwSDj3sGvW93RppTA8X7Zl6mIiTLEfDruMVptqEoDsaPpDDaZHrSh1pupH
 5HTCY96j9kU5jr9zYvVOeI7ocKpwia8uCZBtdECDXAEp50y4PdPzIT71RZY1owDHE9W3
 Ko0YHWV2oKcCTMgIf6a+tD/3OLHVWiXYLP2TadcdSwoGYuTnG+2X8m6cp7y0lyeT5LLE
 Iye3zrRhSwDS0B2OYjEl1OifnK/bAPNzCy+h/GWyTXjEAkLCyoZeC/7wmuDeyzjs2jNX
 /P8Jt7nnm/dGpakyNerD6bXUVP5hKSSSL4Uia34aj9Gx2e2eVEoQfto49WZwwJEX7y57
 FpCA==
X-Gm-Message-State: AFuF++kMAgipjyI4vE/V3azoOMsIfCJzVyRL0RE6fwPabrBgv3ggaiU5
 AfhUBMGS+gKiRBOyFtjkRs/+Lm9OsBhrncWw+K0UEqoNGQjhr0vz8vJtcCNJPq2pXaIokANGSD1
 XvD9xpmnk7xDb1doEqUm5FJLJ6DxIss4W8+eMzACKXTmuTMWEnkkrwgptnmvbXbGHfw==
X-Gm-Gg: AYBFou0rCJlqASisoba3nJWuh8CMZP5QwOR/tZqiuuFG4CCyVa5VH4rqfG81I+93CGt
 AsuxuWOQ9PWmtRWM9q0roagJAdeu/kqGHwawQv3c0CND+jEoNSJN2K4rLTY9sAjsTMJGmet7SLt
 TCp9y2JA3b9pKXxIszHEDImU6jQ+aZBLL5lNZ1Z0MAgR8jPG+c/cd4QDuiW9pUmUp2EaOSdYSv5
 ZsMZLZR/dZ5eTh7F+7DkD7vSG1Ng0X6DbgzP7fDjURlu/ZljaxKGuV/OZcL9pUK8mhZZojOChRT
 i+VcLvduvSYyvpFMzsERH09gTknVbNTBBY/qjJoCpxxZlZMSEgn1YTr4RecLqn0XU2p2Y2DnvyS
 p50LdYygAu510K/zMKl7luQGVJmQso8q/bVJMj/RFmAQywP948uWjZabQaMXDGuoVRNk=
X-Received: by 2002:a05:693c:87d8:b0:33b:c2bc:d288 with SMTP id
 5a478bee46e88-340018132abmr53364eec.35.1790189948353; 
 Wed, 23 Sep 2026 11:59:08 -0700 (PDT)
X-Received: by 2002:a05:693c:87d8:b0:33b:c2bc:d288 with SMTP id
 5a478bee46e88-340018132abmr53350eec.35.1790189947630; 
 Wed, 23 Sep 2026 11:59:07 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e90ec54d8sm7887460eec.0.2026.09.23.11.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 11:59:07 -0700 (PDT)
Message-ID: <69bf393c-d8db-4496-ae8c-ef0b2031d8f5@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 11:59:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tests/tcg: use x86_64 cross containers on all host
 architectures
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX//+j2nk7+UuA
 tZbzG8KOTs/gyZEeZ7fJbqzfugydr8XfAXI+8Elt61JFbVOZ0w0T2xiAWAee2HI3qNAyXpK/ju+
 FYGoIvit8sEDpLG/kgkkeY9G9icJ8AtAJuTmDVkCBHAq5fQxhh0ElwT7ECRRzAGVZ4N++pDIp+d
 buffi/+K4D04p6Ikuw2NhqstdPQ0rR3DyisCQ+0yTYorZ2H/9v9to/dRKjvU5TvxhRNz0Hhp/gi
 yvpTpGMm18BmcqskGitGJLc7UJZFKkY9JZJ/KcIewDljT2ReJimaHtREvWURFtH3GZAuwi7puR9
 a4MxOlw6Klm1jOYBA44ErFz7uuAuzgduSY1X5+Jxee+nsvgxoRmsJf0yAlr1pOeePXIzF37UDxa
 vdMZJKnJXl1MJZkGuUXVeUjhLeDbtTgXHxUJac6vX8AH1tvhJfES3WNZSkd8YxyC8faoJE7O6w0
 N5dD6mtlVvOpzpaQI1Q==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab4217d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fLCAjOW_SeC3PywdR9UA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfXwMj0QzewWna8
 2bAiTkX6FXTtKS/iD5lk4CQqLA35reeSdhoEq4ktt53607d3RLmjNp+bJWknGGHV2fkv8NY2IE6
 puQfSiL6SW2eJ6xGywfleiuh68zUFo4=
X-Proofpoint-ORIG-GUID: wAKOrpfVIl74A2eAijGaWyTh9gXPraZw
X-Proofpoint-GUID: wAKOrpfVIl74A2eAijGaWyTh9gXPraZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
> To increase our testing surface on aarch64 and other hosts, and also to ease
> maintenance of docker images, this series introduces x86_64 base containers.
> We rely on qemu-user-binfmt (available at least on Fedora and Debian/Ubuntu) to
> be installed to execute x86_64 binaries on other host arch.
> With this, we can run the full tcg tests suite on any host architecture.
> 
> This series exposed an issue with on aarch64 hosts with test
> loongarch64-softmmu-memory that was reported in issue:
> https://gitlab.com/qemu-project/qemu/-/work_items/4567
> 
> Pierrick Bouvier (7):
>   tests/tcg/meson.build: force use of linux/amd64 platform for
>     containers
>   tests/docker/dockerfiles: refresh images
>   tests/lci/refresh: add parameter to override container registry
>   tests/docker/dockerfiles: use docker.io/amd64 for tcg-tests containers
>   tests/docker/dockerfiles/debian-all-test: remove arch specific bits
>   tests/tcg/meson.build: remove cc_docker_host_arch
>   tests/tcg/loongarch64/system: deactivate loongarch64-softmmu-memory
>     (hang on aarch64 host)
>

Sent v2:
https://lore.kernel.org/qemu-devel/20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

