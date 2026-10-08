Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE15CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvIz-0003PV-Uj; Thu, 08 Oct 2026 17:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvIv-0003MQ-HH
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:05:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvIu-0001DX-2A
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:05:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0NIY3386987
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C8O+7IeTfzCHpsoPpg0paiiXIWwahTbUrfBqRLTGIlk=; b=DSSaHvTxaIKXf7eo
 X5AvIl3Na+7zk2+1RtM6O5An+CLqAOG8JWbpQp6Am4mbB+UC6l8+CPEBRcAXsQVS
 yidm6J2z43jcMwjpTEcQjvSEVfyWPql0CFjAojgLH4E400ujamZks4eFX1ep/Xrf
 GLGkcyAGtsap3vMfxWgbLlro6oKMsEG9ENh5JPSj5G8J9istXNRsRHR75ThCQ/Oy
 QZMkTdUw6kTx0ktCvisKYMFLjthGc4PAZ4oFRaTqJrQdrIw7xChYZvRtGnBbLAe2
 mbeFXzxjJGP9mq7ArtDTnEOwPH/zoJZ2qcuI/KmKOrJ+wsFJdBfcUpsy5H9hgJWP
 SALRwg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrrnts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:05:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3535c27d880so754093eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493526; x=1792098326; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C8O+7IeTfzCHpsoPpg0paiiXIWwahTbUrfBqRLTGIlk=;
 b=KjiYsupNNl44EInAR0DKgShiOE1P4K4ARpKbYTjhTxEcK/Zx6U2ypxWCtrzGa5zhxS
 0A8cUobgmPxRbGXw77JwSLgnoo1ylMi3KwxduwrrF3LwD+Skc0afsKdGjstdB76NS+Cm
 Olry/oSlND3e9WjAAlhZhDmtIbixVnsUyO3SlsYB1DEFCCB1rG6OYJkuiRf1SoR0u4KJ
 NXRtT51C4eSkSPfdMdsuFfA3YilqEjbCVA5riiocZx782hR+T+frVugwE6ItMKStz7ad
 pIF+TwxxsJKOeQoz8DOd9oTlNYj2cqQFtrmk7UM0hdzEHwmpKjYTJ5WOTFI8+FNb4oaE
 mx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493526; x=1792098326;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C8O+7IeTfzCHpsoPpg0paiiXIWwahTbUrfBqRLTGIlk=;
 b=I5S1m1dHjBV1q5P/4tZi0m6BEOmvlIGhancOPPu357E0MuNYNUdiOIk6z0GeXtka01
 1EATBVS+kDlyzSjozabCH82dutmdBCey1B352wE7ydbDSD+4R5A29MEZi6vuljIbQVSZ
 qE5BBhbxb6YcororJ5P6uk9ZnF+tVES9Au9lQGZqbP5HVBoZy01nmE36IDcG9n1a1FOM
 6i4zEJUa9XjNbbjStuJcCSeaUjl5QFcCKsfkYFMZcWVtXfnvXK65j2CveFcFzhR2ymG1
 ZucccG4UkDEUZI0ERtBir9o2ZcR69w6emSzan14JOhziNkbz7xW34gNOASbbccPNEs/U
 Dx2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEu3/YK5P9xzNPobYILPtwML9X5BGx/t2IpvmrYpt/CAhgngqyKLo0TvtmqYE0k1kev+XStcKaYGPM@nongnu.org
X-Gm-Message-State: AFq9FYLl6n9wD4aSJelePt2jzojMHKKRcNTER5BmWHcs1qPLLQ5R4EVb
 dLEpHybIjoepAb5rV+ANRlBZ4ZH1QRoFY7Wc3KcbTtqoeXdDChvtfj2AU/6Po78yviMOQhy9WfH
 Uyz8e99sVPqmz5sde/2FmqEd9Ti7SjnroDQhdKEJHGu5ThCAvFjjt24G/Jg==
X-Gm-Gg: AYBFou2UnvikMSZHR39L3ydf9PKS5kDepw+YvVmulxDqLWZgvUs2E7qBWja2Mk9ZuBF
 6KcJzBxnwh5oa6lERTyc1d8cR58Py4io/jSGFFVjLHjFYWCtzoeIzNEcql8p90LdPisshRfSr0Z
 NNNIeopl3JN/gnQQooPWc68YbRLu3vjSk3oYhotBMYF8SCvBQwqu5sqXVVvQzV0diyxhSCAtURd
 REXYQnKIhsSb6JVOoHFemZb/Sf4h6f2lH2D61tWLhhbppKnFNZnf/91mZVfS9pFalALZBFEKd4l
 VHT3fHAnvOEAvCAjr1wh4zTRZZfDRYVN133DDTm+KpvtB6TJac+yKKaT1WyQsvxpyRqlfuYOtFF
 qQR+Fm62+52uHzbuTEEkHqHcpOvSI40Pp3gsuPIpx1W0PT5lmnTKgoqIpaJ3bIQ+nyXnevg==
X-Received: by 2002:a05:693c:8954:20b0:351:8cc4:e18b with SMTP id
 5a478bee46e88-3537dfb8632mr88980eec.20.1791493525820; 
 Thu, 08 Oct 2026 14:05:25 -0700 (PDT)
X-Received: by 2002:a05:693c:8954:20b0:351:8cc4:e18b with SMTP id
 5a478bee46e88-3537dfb8632mr88939eec.20.1791493525154; 
 Thu, 08 Oct 2026 14:05:25 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm762242eec.9.2026.10.08.14.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:05:24 -0700 (PDT)
Message-ID: <c5729944-6345-4122-891f-215a0376def6@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:05:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] target/hexagon: reserve internal HVX vector
 state for QFloat
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
 <20261008003711.3984454-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008003711.3984454-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac80596 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=nHjld7bP6O_WocLDLakA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: o5ot9ncD2ZHaoHfhEjZ_OLhObfTpJCGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXziU2B+cM+bQT
 2yB2KQvc1MTQKaxFJndGBLIf8/qK+V3G/xa3xEnV0/NhJVsbNn76GBEOm7HvMVVfJWsVC4tS1jS
 T+H3jh53Ehi/uK7OzF6N+6DcWc5NcTFhsB8atMnt9aDFq2CrUgDKaRZEh8TJzkbBksQt6jeDt+k
 qO6j46/Xgdxrkn123zKV0ezXuTXiOzLzn3zHqQDG/LmUD30xIlOtbbJ+EfJncuSqzooxGdZ9vfG
 yVTw0JSYsCUvQXZsN1k/HR1GLeTLYbaGKlGtHk6OaYHsYPAqNNUYJs0OPfZpL0SEC/aDycyvZGd
 KAXJAhz+wVouAmHvwt/Dfq3KR/XFBCVGY01TV9lR8aO8bpivW6F/KlI1hBiFObiSqK0nmnVljxg
 xA8bfzq0Umw32UNF5/4Y8CYEV1rKcTx582tOBz6A4ZXE+bZTdXKlvNtaOsh4VVnIMY30XITmaJ6
 kyQ6I2IdI24rMJZqjvA==
X-Proofpoint-ORIG-GUID: o5ot9ncD2ZHaoHfhEjZ_OLhObfTpJCGX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX0wjSzpjNFxEX
 Mh71wDbn/VuumjNHDPPsi5fl71XhIG1crlpu0XuqPtxuYGFlEfkU8vbbkjqxXTAl77bAluo7NlO
 rBZdSVIcCuFew9hkwYhLsR3J2CSb0hI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

On 10/7/2026 5:37 PM, Brian Cain wrote:
> Add MMVector.ext as internal QFloat state following the register content.
> Preserve it in full MMVector state transfers, clear it for non-QFloat writes.
> 
> Keeping the extended bits separate from the payload lets ordinary HVX ops
> use VECTOR_SIZE_BYTE while pair layouts use sizeof(MMVector) as their object
> stride.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/mmvec.h     | 55 ++++++++++++++++++++------------
>  hw/hexagon/hexagon_hvx_context.c |  5 +++
>  target/hexagon/hex_common.py     | 32 +++++++++++++++++++
>  3 files changed, 71 insertions(+), 21 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

