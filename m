Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B6FCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIU9Y-00063o-Lj; Thu, 30 Apr 2026 12:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIU9W-00063M-6L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:22:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIU9U-0004Qp-0n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:22:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UFXKa32907475
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E6zWTBhDmQs3iHZ1Xg+GuxZFdfi0hXAP16BZQPSCezU=; b=LTypAmLqOMNkNjxU
 C3imhVAL+S+DGB/FFdDOBGAQJuVSLAYx6s0fm4dWFZeUbOwb/ZIr4v6DOvGaSF5j
 mUEdH04b6tw0IRCJafsNCchLx3eAYFJ74DQSYfYJn5HTvh4eb6Euh3rYZpc/AWVZ
 aLXq1kXZp4ceTiKcnX1+OA4TQY1nIivfB1yFpQHEWb0GADil4ygN1T+QiSOUMoco
 7lwg6re+WfZs1H0a8GL4lxSPCddynlCpJEAv84uPA93FioFEDjupx1oY6c/aOBv/
 fSftkZoDw/WM4kqBdxeNGPyX9lTIcChgr0w2FPCPENvjvVczhMzmTp8A6QlDcrJV
 OnooWQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv0pfb3pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:22:09 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c726f4055so1751456c88.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777566129; x=1778170929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6zWTBhDmQs3iHZ1Xg+GuxZFdfi0hXAP16BZQPSCezU=;
 b=df4JGCoWLDNs61bVhE/X4MpbGal/Vw4dMGwLHX53IVpkfMBlZBYLsVHm9tXAJiLHuG
 AIqUf+zLcJNdDHm4oIsRYp357yHnEprUE8ikwqOmDOlVTIby2mX/gubG+l/OPF+wRc09
 F4IVfoOCSeoHY7XpvW2/klIvMxvvBi4LIjLRh6K8XALzYnjxwaRdjG7dkVkTvCL4Tpw9
 LlI30XW4F5yqVLCC7QxSOCS14UUTT4p3XX6He6VU3nan6Y+7h8Slk5AkivHmLajm1MFE
 nfq9hH5kfGYE7/5ehGU7zhc2cav2iXQee93ifmsCWv1k9Vx/BlduW36+mZ67RavQ1UJx
 PhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777566129; x=1778170929;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6zWTBhDmQs3iHZ1Xg+GuxZFdfi0hXAP16BZQPSCezU=;
 b=p8OkMmK2kF3y9I+G8yjaX/YkwD242DadpHxkwdnA2VNbwa70319JvvdfHFhK5wIB6Q
 PE/vM1ynWFBeyzHpzlZzL/EN73bTizFzw8jcvaRGtPP7uKCGaJdpxOMBWx2zPhOuPPrC
 STPDdBDBaayd3gCE99zoOEPCjxKr0RkYZtahJc+z5W6odCdJYMmXwRIo5uCCoXYMQ5ub
 JBY2n8oZpk7MaEteM75LP+DeUotbw/5Sl5DLZECrDw5sXd4wvFxhXpTK/P1n78W6KUzA
 b6Kf+YO9+pv/9mTkFHiznAHNQBLkdiy4QRgEPqtuZyBDE81s8W3raqZgv0LsIwBaiNaq
 nLTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sP2sUNxxXY0S/PekCgRoJjiUprWhBc1wFYcLaLS0hhTSAoxy55JQ3Rf35nQI6rGquJN1p8TlQJq7N@nongnu.org
X-Gm-Message-State: AOJu0Yy/XuWlTE9eQGU6fiGi5EEl9faOJudoxXjr0smmmt+bfCsTwMpu
 Iw3g6wL73RGuNlPoBzUx6L8Bs61Wj4H3n7eseY++1NdAVovGFrlDf7WaRsvouVM8NJk0kmtt/qP
 92ECnNhrCzLFMGaO07mGJ7wdtCWSJ3g7/EAcUiRWi6RCAwC60jdQ5KvCkqw==
X-Gm-Gg: AeBDieuwUSPgaJA3BsAlMQep5dlVPRFKuUBK2y3zAWlJ5uSHJ8JQGWgU+xGY7Al8dQO
 Hyob85IVJgeiahIGrdMwkkQDP9bNWPLqXOUjUYJP3LO0dPgUHGDrupeyhSIwG3Dw5jAzAsNDIpc
 l/WSnflcX38u55w13LmisVWaG+6zcHRYuiJxT9TJyJYJbvFyjUZoY9kclo03C/yLnfcfnSZhPGT
 BP158ZYbGVyy6Y/M4ubdt+UGNbaSWHrYSwIxndZGiafTuDISNsDzV/lSXs3g+qjsQdnCLx1voYB
 5zTAJcL2WaWD9A348PuHhu49B71VONsPjgYNF+v1eHgd+u5C16sxW7Fw+VUQC9HNpp1med2rfLi
 fudzo4LFaZiauRwu7jsoBvQuVdz7pWmRwKEnVBjnFjoxj1zmO3QMaX8cTF8Ixjqmke5p7ly75Vm
 6sUfSnVdhGsWLWZm8sGq/0KSsR
X-Received: by 2002:a05:7022:60a1:b0:12d:de3f:f3e7 with SMTP id
 a92af1059eb24-12dead2b85emr1659146c88.39.1777566128947; 
 Thu, 30 Apr 2026 09:22:08 -0700 (PDT)
X-Received: by 2002:a05:7022:60a1:b0:12d:de3f:f3e7 with SMTP id
 a92af1059eb24-12dead2b85emr1659127c88.39.1777566128303; 
 Thu, 30 Apr 2026 09:22:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de326a583sm10045921c88.14.2026.04.30.09.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 09:22:07 -0700 (PDT)
Message-ID: <ce92e959-1194-441d-a900-44004bf56d4a@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:22:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pythondeps: require Meson 1.11.x for Rust support
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260430083411.807762-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260430083411.807762-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2OSBTYWx0ZWRfX2vgtIX4m5Nrn
 2//sSh+OzYp8o7F8H/eZyPZu25HHecgCz0pSmBlcFlWymGlNqsBG3WLZ2cNkY2FV9YEx+iPBMzW
 c17t1ouRks/pScMQcG8H4CUKCTnsY7rkRDugzupxi9/UOayp2j97hbfhGmdukXU1yXKOzkp+djI
 pSNHfabH57je0iL3PnJH/3+Clbj/bvuZF1uvwtIRF0BxLL1rG0dgAri6EWlPjO3YHEVKH3j24Kr
 EfKTOgBRUyiXHd5EcV7JyWpP7/aNSx1YDEd8lDMpS5gW1W5tVDsi4KkRCJYz85LuUW8FdfVI7+n
 ImdDBN3D/jXqSSOYzIlPrnZrji8JVmxuuO1trt5lrTJh/wLpYeK3cE7pX6coL8IEtCozSRs7WRO
 fBf8x5zsomSL/4hb3oYxE9WWjd45UcNb0dCJDoYETy4+tYZycIFWPmZh1UQ1nlpaIFZjCGVXDA9
 F9TSZEsn3KvsyRnv+LQ==
X-Authority-Analysis: v=2.4 cv=Zrnd7d7G c=1 sm=1 tr=0 ts=69f381b1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=veUHhjnA31O5rSrM5GUA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: Aay4EilPTGOqWwVlBZffu9Gn9448Wi0I
X-Proofpoint-GUID: Aay4EilPTGOqWwVlBZffu9Gn9448Wi0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/30/2026 1:34 AM, Paolo Bonzini wrote:
> This fixes plugin and module support, thanks to improved support for
> passing linker arguments via rustc.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  pythondeps.toml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index d0e86425313..47d4caefa90 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -24,7 +24,7 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
>  
>  [meson-rust]
>  # The install key should match the version in python/wheels/
> -meson = { accepted = ">=1.10.0", installed = "1.11.1", canary = "meson" }
> +meson = { accepted = ">=1.11.0", installed = "1.11.1", canary = "meson" }
>  
>  [docs]
>  # Please keep the installed versions in sync with docs/requirements.txt

I sent a patch yesterday but not sure why it didn't reach the mailing
list. It contained the 1.11.0 wheel.

Should you update configure and the wheel file also?

