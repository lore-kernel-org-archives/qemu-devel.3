Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F94C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eEI-0007l8-3R; Fri, 18 Sep 2026 15:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eE3-0007kD-7N
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:26:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eE1-00060N-DL
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:26:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoNJs1211764
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LVsfTIB5Y7UT9fiTnYVNAz39psrFU8ty8Y3fWy7XmHo=; b=GUxHzH0JA1OrD421
 rwZNn3PzmlApkNjR77wsKwkU+74uVzCfjxA3gmEqHScOucSF+aoyG/Q0XiOR1PmJ
 iw3LJuyvAYrtDexXmvV/3N84lbCvJrI9hytLDsV1243IMXkrxGy45DOBxg1he9pj
 83Slwz82N/ZYJjXWrzApjr1M+4Sc9htcGwnqPSodwMyBxauPZYO1MSNMS1d3fJv2
 BnQxdRfMc+RWojFoTsI/k7KGNfT0o9FQGxV/3EDDoWrls9oUnVpOfh715ofkWKBL
 PVXOeqh8sMF2cot15CL25Ff0fQIGnH4/ZhQ+WQuENJUYAiBqY523LJzQ5u1PU3/p
 jexlIg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs2392pga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:26:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso2136687a91.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789759579; x=1790364379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LVsfTIB5Y7UT9fiTnYVNAz39psrFU8ty8Y3fWy7XmHo=;
 b=hEdngXQcL/mStRHFGqM3cAArzYce/ipC4riB7WiKFMr0ARUf9KfR7DMq0QlmhF/ePF
 Nl73Mln5BhgJEM0eWxSVrIEO9rkY6LDvCm3zUfeEBJIbMAm4bwr5e1NuYCkleTjROmpf
 usbDazCEepw+JqUkoxpZAOawTke4izF2tgWgXYTKJx8UEos5X4MyNpwE2sFFeGuKD7TV
 IXhPmMhHV5dpXQGW/gCA3vG7ikjKNECbC5hPwJqg81V8JlD6v9AUlH5+oeLKG31ltOSo
 RQFXJ+plAH2rOs6CWmnov0B9uxRgutEsAdebu9trCI8ugngXm571I+GEIBFC4X/Uyo9J
 BhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759579; x=1790364379;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LVsfTIB5Y7UT9fiTnYVNAz39psrFU8ty8Y3fWy7XmHo=;
 b=P5ZIkODNhQbXs0CmD3o9UIAOmzelCh7MBuyxmJJQTdCDu5gtj7xEUv1dXO8zvcNf/l
 KyLJgNyjIBY/J3BvP34KSYtoVvHklnF5ETytbTBwOk18Y2uc7098sFQuqINjEkg3VFK4
 03tDqKZlgusv5xQQowCymjS/OruEv251M37ImWGFltJ9gFwRxRLtwIoYad5b9OVi/BNk
 lhxcpwcZm1wlgtwEqtgtcLxE1A5xJO/BznIorLNm9q0J4pP5yCTpUq9iH+hYZm/cjP81
 ncwndYP/gWCNsGPiyRzvoE8qeRuXx6Ls9mLauWZ4H8ettd52lIPhRY+BVfMFvi7Mzw+G
 vBlA==
X-Gm-Message-State: AFuF++nj4HNfNA542ZlkLoiGlRqUAo+48g6hYElilQZRlyb2XHWcTY6A
 //himzjDH4wMUVosy+EQcp85ql7TuCSfiJuZCsqhQpb1Ep3EuU+cnpzI/Y/VkIcoBpIwmIZW/bZ
 +zt/4opNfVl33Pf2Qx9pb6LvdZuKZgPYXyTMamYZ2MPSHgfqS2Ay7mVKzGzMF632TPg==
X-Gm-Gg: AYBFou3cZMBmN3zNLL3cNjscl8HRW1sjh/rj8PYxl2DunRKnlFAo1Xnt0zquxCXJarg
 JI5KNgKVfDevga23rFptxxcDqBUpW1k33LFoDjuz285z218dCH//WBIbRAnc0AxL/nm1CQG1CHL
 2+Y+uCtnN0jQHlk10jVYEofrvbIy5q3jvwcJaA3R4q9XzqriSIx+xqh3nyGxxxYj5CHtB/g+wav
 4rjQJ/fDGmz+dOf2U0znOEIMf1OHz/GINfgVkdU2lnC0VOiR+JYErKPxgf1dto5OWQwiBb7TJk7
 fgwBkVBq3K+SK/Ns4K/T62s0S/341aCIhsJdXm0rYS9C/WOrmZeyVnI/2kabMs7RjLzFZGz2DGC
 jdu2wJcYN533/3c9NCU8UfED4PZjRnIbcg5M7oGzSPkzgPLcM43yqrQZUQZ/a8x/QNKbM
X-Received: by 2002:a17:90b:4f81:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-39e54d8d8aemr7064948a91.9.1789759578681; 
 Fri, 18 Sep 2026 12:26:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4f81:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-39e54d8d8aemr7064928a91.9.1789759578127; 
 Fri, 18 Sep 2026 12:26:18 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55e29absm779249c88.12.2026.09.18.12.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 12:26:16 -0700 (PDT)
Message-ID: <77b5f317-458d-4905-ad35-63dc651e7046@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 12:26:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/tcg: fix more container issues
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
References: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI4MCBTYWx0ZWRfX75CNJ+blFHto
 Ig0txkTxl5Poph6R6rt+e64cmBkJD6TJX2HtDmR4Nyz60OYlcwGOBijUUr1k+fhqnok+UW/+xIp
 7XW/RPBdk8u1/s847P+DZXfv5LQPMec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI4MCBTYWx0ZWRfX1RKTN1+v1N8h
 Ndw9vI2I3+hnjBDqhxTdIOnZTknw6qtmZ+VAW6W2tmCCk+WKM8N6ALB+qVB7EEQvaAWhi5yZiUt
 SHRTb07WPMrNcIeph3S5QXpMDyNaYF7DuWduxZlKekKYYG2fz5BJbICbjYKIeFgxAdukUBvEqb7
 Cu6Gbo137+26+2TcYv0YVKOiBWajMF7FVoUhyhWSbUV3oW+e8TKTQa4fHOEtQMoOhoyrQJkngPJ
 KQTioGfCfhd4O3ZsEMlXVHZDuUBrE+Pp8WbxWxdTUyFIfxvtsNBqecphkfYCUI4w50yWxjD0pqe
 rpsircE5fMnwzGcsfPHvKuun3pjEpa5KPu+5N/sHo91Nzr2wNoDc59LmOQuyXOjeTiPHiHAy2G6
 g2M+lDLfj8bx4qglT/NP3zhZpiId8H9/EpsPkQtTRxIkniB1sGjE7wUROaTVi2b9b6eYUMPIe/D
 hSJn3k5mpOeKzmyj7Sw==
X-Proofpoint-ORIG-GUID: GePRzgkryOIcBU8TgiA0SDAfV0GV_443
X-Authority-Analysis: v=2.4 cv=I7zw19gg c=1 sm=1 tr=0 ts=6aad905b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9se8sku01-J-kCAVwN4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GePRzgkryOIcBU8TgiA0SDAfV0GV_443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180280
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

On 9/17/2026 3:11 PM, Pierrick Bouvier wrote:
> This series fix tcg tests compilation with containers.
> It fixes SELinux hosts and dev container with rootless podman.
> 
> @Alex: it's based on the v5 series and can be applied on top of it.
> It can be added for the PR coming tomorrow.
> 
> Based-on: 20260917165602.3405537-1-alex.bennee@linaro.org
> [PATCH v5 00/17] testing: various docker clean-ups post meson tcg conversion (pre-PR)
> 
> Pierrick Bouvier (3):
>   tests/tcg/meson.build: fix host fs mount on SELinux enabled systems
>   tests/docker/docker.py: fix run command with $UID == 0
>   tests/docker/docker.py: do not add-current-user if $UID == 0
> 
>  tests/docker/docker.py | 16 +++++++++-------
>  tests/tcg/meson.build  |  2 ++
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 

To pass this series as PR:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


