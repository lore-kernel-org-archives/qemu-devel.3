Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8D4CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB817-0005Kz-FC; Mon, 28 Sep 2026 05:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB80r-0005G8-5i
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:51:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB80o-00082D-Rj
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:51:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M5qf322577
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HvNP/BAI0o9lknC2+cucXpbe5AwnBLZsgbDgZa7YMos=; b=ieMesbYCfnY1oGSU
 XiAbyMqjD7pfXBHwxG+/mEnKwfI/D8fx8hmlmLB6gGmOrFgc1Ecb34bjvzZjvAtv
 NmPIfRkuR/Ph9hxy1a9q0kImYg2mTK/mNW+DQrAflTe/talJWOvVTmz+yspA14gh
 JmRvU5SZEVwaDSVXvlkG9zJes3CWZ9YmTx2UuDSLFBqYhpIELt7sISPdP8+1lyoW
 J2Hg5s5DEU1ALEMVkGVQx+mXxHmUD+IwF0ZWRMxegBZhNn+FnHqu7MBJjnvKO+fn
 s8NkzsII6BJcQSaZAuhX8Ycw6DFtjQUNqw5gf05LKNzu1QKp+gURyzsFVsQrimpt
 UPNgag==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1jr9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:51:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c599e3d3bso398345785a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589064; x=1791193864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HvNP/BAI0o9lknC2+cucXpbe5AwnBLZsgbDgZa7YMos=;
 b=V0MQLrO6TNMdhzOnKAD7E7sVuQRuN2AOwDQ1V5IsBmOsYM+SNRjZCMG1xp+c2/TJWh
 wHDRb3WzisughI43aBLcrINVNYzwfGXChl/IQzhAeQWYriqTfKG9zOWOvVcHiIU+fwb1
 vpICL5OGxJ1FKxdh7IGXsHjEz2NBfVLknNI613xn+8EhuxPxa6NvESpH2lVXBb/MD9yY
 gH1OrMgROu1XEHhKSw8t+LH2OAKkS1Qj7j1h77MSkO5TMMzToiJYxxoCZSqgX0G0aLK8
 fBt0/QTX0Uq8Asoj8DPGHFNpy2Aq7lvgTS7PG+sSxF+lMC1yVwLulHyS4GwosTcgKX/L
 AaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589064; x=1791193864;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HvNP/BAI0o9lknC2+cucXpbe5AwnBLZsgbDgZa7YMos=;
 b=b5VVfbmEdGtAgqYezLrx/xXG9qxQDOLsxYYl/trNJQoTWV5vB09HYy/jknw0SLpFJG
 a9/VWQpPhjVem+XCwBuw9d6QpWOqO3ubgLpi/EnPktE3VvbJd94y22iIYAc7QZQuDeAX
 dQudkzHqhSoEtK4mw8oPR9FuDOkw3E70iNcRqb7KI0YKoN7GSJ4SuJIn1upk7pD4h9Zf
 iRn+55o7TwWiEuPMcLetWHABzzPjrsAIILu8CZWAvAtThMJtUSeAy6C9k+xCOJHlgWSi
 DP3mSeojjEFmLhA3IE+gEocj+ffKpetnVbzK4Ei3/Rt63XwzTljVcJqckpeEZPXOhwNh
 r+tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBybHLR3mE/w5HhgecYuVvLGOuuEJkt67Hou/TEy2eQv5BQkOg/KuYTL/BsR456woE8jpJYiF2Fe5TXn@nongnu.org
X-Gm-Message-State: AFuF++ngCBF/3NB3QVoNTg4Inr8OiOvq1XEPHZpSPWdzZpxCBX5myrWP
 SWn4abmayyxR1XnOlPmfJrlG3XI3bFjZrYugniZkShoRDfqZRaJHO03eUEp/2yGtJsREAQKbgmm
 Cp4JZqBDorowwExXr5y4UAWsm2VkcejhuWXvnpIt+cbU30HKM0AXG43ay9fQHtAWsYg==
X-Gm-Gg: AYBFou1mTT9yQEc9gjB5FSgZZ0sNhQVdWcbj1W/nvefJA+91atybDiVCyjKstNPZjuy
 LrbeBi5VPxxFxGrXoEutlwasIQaEqwgko1IbySL6unH/5wVXyfPAtbU+ounKbjDTrIAjqUQ2wii
 fpeL6TFNHFnOQNM5aMLA2wL+sFCD/4wVDgbLEVkxFS9qaLd4xBzGZN/friETvGzXM8WDMgiHe2Y
 +1VUPOJPG+X+Z1e7EYeql1iDyTZrbrKJ9vvE1cav/xXegsLBuBTKqdyvzuCuc2hOGMHCMuvDSD2
 L5ZKOW3J3cx4IdVE+52sFInjLYrVPaC9zZJk+2v9mPLcHVWLYKIfpeAWlcqUMc4I8pLHB+TT96C
 cXU5riqQc4WsvBpZuy7Kz2vRX4lMpTmcYuQ==
X-Received: by 2002:a05:620a:4808:b0:93c:6c6e:1772 with SMTP id
 af79cd13be357-93c6c6e2009mr846607685a.10.1790589064392; 
 Mon, 28 Sep 2026 02:51:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4808:b0:93c:6c6e:1772 with SMTP id
 af79cd13be357-93c6c6e2009mr846604585a.10.1790589063931; 
 Mon, 28 Sep 2026 02:51:03 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a36189bsm25461614f8f.21.2026.09.28.02.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:51:03 -0700 (PDT)
Message-ID: <be52c649-9e1c-443d-973f-af7723d80526@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 038/101] tcg: Generic expansion of tcg_gen_andc_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-39-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q9dmi89EQcdS8XPp5RKqxzAZ0-pjK_KI
X-Proofpoint-GUID: Q9dmi89EQcdS8XPp5RKqxzAZ0-pjK_KI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX6Jk4Wmlw7qcg
 UYvlcAi/X8XvKAkjbS7ofB9rM66YJWNz1hy3dDZhdgSAqu6EUNBbq3EpKWO/e82Py7zoGkEQiDQ
 ncC5dKdOlP15w0Qsxw21MCq1DziGN3o=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba3889 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXwi38+9CqqIya
 Cg7Z0wQGNkVylWjSnUr2GJZ9VNecdQ7iMXaGXN+GRGRItSdiirLHXeMJp/0QahoIvoNeUsHcUBR
 R+e0wDskzU6GuJ5cHRQ0V5Rz2wl8vfR8gT8BRNrQmIXiAZfEXPsJi2nxc5hqIDXXXlaQ5cvG1vv
 oCrilOSP3Te4t9gb109E/MBtXxoNuOaasVFZDoUXuA9R7/MYZZhOwUX81P6TaJPvNDtF8VqyijP
 5fH+3i2NsXdOXsKZZ8rEF0eN6TGCJmk3uoTwatJl/hv1qlmol+AMXqwwYGx0nx5NegO+y5rdTwE
 OP6qNogzJfsv+YFPZAV7pSOQVZVVHmOYfdo+DvFBvBsZQxjrZFcXONudY2OCyh4ztfKibrEXpuu
 Ru8TEQydgIJawYG5CT9ROV5zMUW9ctaqJrFSHNlxmR49eLAyXHF5izUXiL2+BBo5rVhepbEwUNs
 XGYZch0/wo0A89JrExw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 36 ++++++++++++------------------------
>   3 files changed, 13 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

