Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0424606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hz8xpRAS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tk74vDHJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKPRt-0005gY-7w; Fri, 23 Oct 2026 20:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPRr-0005gK-Jf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:17:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPRp-0002Kf-Tf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:17:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLura0877073
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S3EZYDY8AYPBGhcA7eE5WY0xxcpx6wnnDjx9ZlImP9c=; b=Hz8xpRASs32GUdu+
 dqRk9amW3spYThOBXPpmJTbLq2+4Gc1yBdRSWeZB75Le4w+0o2jP9C9SqTMOQVaZ
 RVxcH9FLMCPFvUsCExi1Vdq/n1+ed76AiLmLO8Mv87eQMRXL3o7ly6WIkDY9dOzu
 CvVIl1EsFV13Ji7kWsYCuHKykR0ereut2VzT0lkEYUsB5NDHXqRQbCvFGTeiBrkH
 oKNmmtN+2s8vCBjq30r6718ojaHka5OgONMQRnAELykXQiLgGbHnzqNlTbl9BYvv
 0L0Sr5I1uH4GshP6rXptc3teqyvO5ugcyvxk/tib9LD9Us4kn0qXV1NRSE82qWbx
 ABPqeQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr6907k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:17:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so5406800c88.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792801039; x=1793405839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S3EZYDY8AYPBGhcA7eE5WY0xxcpx6wnnDjx9ZlImP9c=;
 b=Tk74vDHJbWK34rxzaBcVeTmOyYlacLqfZFhCafo+HzrBvQAuWvwJB7mgYJ8oAkrARI
 BTK9yCUrkatkE7eCpMtrG5vmRlbiuicljhUncbY6HlRv/AsqrtUY5qG9hY8MW3QyIgGU
 QwA4YBhn/G9NHBJcQxECAnr6+E+ClJ4dw/Tglwn83/TVx1iovaxSDOi8LnkgJLSl2zEE
 m0E4l7EXnpprjdxsY2OcRsD6a/SBbz6ceQjI5NMxrpS/kHJmTWdrlT3KiRxyzzBeKDMp
 SSq7raFEbSbWGhtuOB5EITr4Ya50kk096sHbik0HI+FaqXlL2ozh7c66dUwHufd985c5
 E3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792801039; x=1793405839;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S3EZYDY8AYPBGhcA7eE5WY0xxcpx6wnnDjx9ZlImP9c=;
 b=VzDQ6PNI02WA4DpgsbTS2OH4vKm/Zv9+6omPuHKPKOz6NBmFqePIuWljAdEMWlTqSW
 0VmiRCODjOwcfKlateFoUY6kzSOm1aZQJQP8ZST5ygpnNp9+JCl+QVATrrhoJUqdqRS7
 uG5RDwmZt2Z8U+WAUBOzyQhuxGqxrrBx0/MivOVZ8EORocKwcVyGsrU7prh8a0wjoDwq
 grSyJufo988n+Y8YA6bfpbyKivxoASGsNi55kG3bc77S5LRC95KU+UQGc7ISxOBH6ac+
 FH6UtzzYDxLSxkg09Tc83K1AOX8oZWKR+VL7rYKt7Oxj7kuwQ8Yf8aZ/D/X3VUX+MF4h
 PEfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFv/dL2OMoDdOYcOy+0G6yTcwrsGr27SNI4ZmaA3QLt3+0cksryKTtpG53LQoZ1k8x26uzpreaPlrR@nongnu.org
X-Gm-Message-State: AFq9FYKJ1beFHanzi7qbpWX+032nXnDySj48kivatu3qaNCLzqh0cG/A
 KVj2wcYTOTd+uMOGDBiNFd85TCKkljdJY7y9w8lDsB0AX57UifjRRmKnAjxgqNZwS/HYu90b3tz
 kLKSVXCae1dlXFgOvKoGJYoD0UdJibRAYjK7gttx6UKvNwD0PdVI+4BPzWA==
X-Gm-Gg: AYBFou2ZGiRTiu/IIDfme2Rfl+A1C91MwERXFdWnpJXFi6HzWCQyGRUpkLoPtcXYJis
 pfwP0MB/qzdvvubzTo4Ju6nwMgsvHX4jmpqjq+M25pMgBSgd/xTcXkyDmm8bhrp63+hiWpim3EC
 mbattoiG54jzLNj3AV+l092CSLRY19i2fe5bdE1wIW83X87UsY+PPJev1IJbK++m6s5XS+nynDU
 xcP6REAF/5nsluOZg7WLxgJi2X03uvFxtAOzCK6XE3Fyk40/8cD+QfQdKsLz7j3EMmbXp+98AYh
 zw3nU7V7S9aqDiIumHAhBDcZCDpSEiBmpTr1g539BLq/iE9Jso7f6zCCwxW/st19AVDaZ7WcVEC
 59FZEEWu9JzTRl8kQNjxLMpmweaVNfOgLWl/fA/BgnkrSa3zddupAraMLSqpQ8PTNkk5XoQ==
X-Received: by 2002:a05:7022:3d81:b0:153:7a27:b7d with SMTP id
 a92af1059eb24-199375eac5fmr953578c88.20.1792801039265; 
 Fri, 23 Oct 2026 17:17:19 -0700 (PDT)
X-Received: by 2002:a05:7022:3d81:b0:153:7a27:b7d with SMTP id
 a92af1059eb24-199375eac5fmr953552c88.20.1792801038717; 
 Fri, 23 Oct 2026 17:17:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm3567057c88.17.2026.10.23.17.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 17:17:17 -0700 (PDT)
Message-ID: <ec4e8c96-f82b-4cc5-83cc-a80574cc1e01@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:17:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/tcg/hexagon: tests for v{79,81} HVX
 vcvt2,fp8,qf16
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>
References: <20261023225820.330905-1-brian.cain@oss.qualcomm.com>
 <20261023225820.330905-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261023225820.330905-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbf910 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=UfGKfHwNc9Myl_vir4YA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX5xpHhSfbGtEH
 ynN7RUKr54SLF0wXRuPzg1c7keRVotyPhx7q7AlLd9tC2fBV6ckYK6t4+8E96SmTFBq402jV0ze
 XI3xf4KpwZrn/15IyoAYuOP2LzUYakW5YTNIC/yACJhdeWxD3fLKNv1NCqqx/nbmY7+ui9ZGFP0
 QarmrS2Cj8v74onx6hZ8uLaLU9kiZuogMEBpjYLXXoy8ehrH0SOU/qThgW1XJkH95BwzzQtEkBR
 Ep3ThSpx0bMCi2fnXSA56CsSH4+Zcy9+C+wcW/T0uA7+48hZQE84bi4MBOtMlq6V3KzG14/Zlz3
 /BpYx7FMsGEio5gGirNfSluGiHbeCqvLpyDp5L0kMzOjxiYWstTNWbP49RnmxRsPD6TPDeB7G5p
 r0OSMHBXEi/FT7SqhmUMTZDkdN8zDaLhLXaBF3EsZbtUKTTB5sPyJCSow0C+R6WmROThkmCzGBK
 0wO3W7DUzeNEZfH17Mw==
X-Proofpoint-ORIG-GUID: jMimRAoVQjqudKsWnxCcgcSbQPy3TWBY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX3nh24kBlkyRp
 Sa7r6FSpxGq5pgwfWKR9k4s/H8FVFgw1ojD2D22FLtf4lKvUgEWb3LQ8W2d82DmD7owdr3ei6Fq
 5u8e9+kRUAVc3jyPmJhVAaNhzLyi6K4=
X-Proofpoint-GUID: jMimRAoVQjqudKsWnxCcgcSbQPy3TWBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240000
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 3:58 PM, Brian Cain wrote:
> Cover the V6_vcvt2_*, V6_*_f8, V6_vconv_qf16_f8, V6_vconv_f8_qf16
> instructions with tests.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/check_rev_gating.c |  30 ++
>  tests/tcg/hexagon/fp_hvx_v79.c       | 478 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/qfloat_v81.c       | 121 +++++++
>  tests/tcg/hexagon/meson.build        |   2 +
>  4 files changed, 631 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx_v79.c
> 

Would that be possible to split and squash that with each concerned patch?

Regards,
Pierrick

