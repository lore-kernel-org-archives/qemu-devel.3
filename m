Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6102606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZAVpvFQB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A21XM74s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjSq-0006c6-PD; Tue, 27 Oct 2026 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLjSp-0006bv-8U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:51:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLjSn-00051f-Ir
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:51:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFL9dp2549212
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IRehan8n0tGvz4jDF566iZsTf/bvYnP6iHjp6VzUn3c=; b=ZAVpvFQBOj5HXCC0
 hfmoeZMmAyJFrTlsOzyd2yWIea3oUb6olcKgB7eU1GNujlzUMT8QngVA4+sPTXKy
 ExQgIwug8ZPD62HQDnDov5rPb9gceHzAXs9jPiD+24g0AV3BPM5omi9JP+O+vKv8
 00GOd9RhxTKAe9/81OrhbYrtR8GfNUdvdkVIdRbW6hCmPkdBYFfsj/C6+IW01GN1
 CMZbGjXqv/+HNkV1z915mrzlRhNsynpM+8InO2nM9xdQMq8mq0Lxy1sGOCizwtsQ
 MBbMmVEEdXcAJgSK6TNRzPnRnsW5FCdU8vJI2sgoZSGQmFbJ0OPKjTytQDHC5tMM
 1uIk8g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq69rbr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:51:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso20081626d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793116307; x=1793721107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IRehan8n0tGvz4jDF566iZsTf/bvYnP6iHjp6VzUn3c=;
 b=A21XM74sLq0zjKSa8vJen5Xfm1hqgeVmpJZ22MU26k7PUqXaWe3aali0KYKL5KGlxx
 Z/YpExiDYf+xAlZ8m8hepo7TMpgiQzXDHknGwGrDKw/t1DO0+D0sTJ/QqCnXn1tvR7cT
 rhs3d+jKIs7rmRlwxKB6jaE2IuspGKnnfSPG/XItVHOKE2lzbyjyBw3hArilv/7FMr44
 R/GbBTUcHQgU/OjAyWRF23KRLAvUl+lyeF8LBoNcS78kjZi6rp2uAfS9E+sIA/JxBcly
 Vn6wvdTpOupxZjsUF5UCDNzqnSX9dc5TCREQXmGWiUefg3R6h4I35lAW8hl0FO6U3gsE
 IZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116307; x=1793721107;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IRehan8n0tGvz4jDF566iZsTf/bvYnP6iHjp6VzUn3c=;
 b=R9CBhzLrqrKH/B51GdgtK2pdcLIUvfRr03QgWJqFx+fiLR1yDWUtoqNYrKdQL+ebu1
 6LP+gF9p7xyIOeAY5i8ujnGuDwcID6Qoc4mEjGeIydmI7bE9cWznWTOcSx/KxviPl76e
 rp5JTigvhnuqy746y+xnu/NCO3Ucwaq4HBFli9agE7N/SleEwzPEfRlbT1vXzzX8D/1F
 IvrHNRp6z3CDd/6vUtfw4F/Sf57oDYSKuRe7ZoHils6582gUeGMsI7QH7yhCNNOAK6a6
 kwQ7tXWUfASFhCWFszQS1KUmlr7ifhCzyFWkM5QUzkC20HPDD8C6J7nxE+fPWbeNi5fU
 tedA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdBxkN19Fm3wgv2cB7jSBnTJXyKxPjiPLKD1woZvRd6T5JXxDSBIRpWkjWBAUtx8Xa2DL6Y6xUl4K1@nongnu.org
X-Gm-Message-State: AFq9FYJ93oRJl86Cy0a/Haruku0f62WSacXzA7LC/VkQ2rU5895kgd6Z
 dXPuAr10ITRyUeWrRYvYlWgxJB0FRYBa5MFue5yxSKP702W4wks7xlESv+q4Vu5xGo5go7lP9m4
 gY9U7K3+D6vAoXP/qkLVnK1FQVZhbFIZZg9jOg8OWGupMSIPFFSDFxLQq6w==
X-Gm-Gg: AYBFou0xITJ4BlSG2ADsnvqI6r4+lMWenDFN5NymZ09RS2ZugH4kt4lzk/PUoPbZ42E
 VdTWJTsokdVzYhOSabiI7diA/2pat4B4mkFKSycmF8DcbNWINbbB2+MHFMICnJPogu0ZvmdQwLl
 tKwLNZWgB8HBA+YmopP719ztN8JxXkIVtc3j9DbiT2BpswRRU0c18R7GhZ5cairxxgeP9vT96oh
 6nu+UsKrgIuSP+WopxxZsvg6RSFR46BRkYCwfeXvy5bDpwt71x+Fp6r8nR/rQCGfK/rg86WVwyf
 T8lJPvFBjX539F3/g0EtccvLV8hCibg88AGPBLhADQuCR1xWc7qDpmEYouPstbZzh2slBTmfrLU
 SJGxGrs1Gr7tO0j/Ct6tdZXm6fGD27GiAs77X2/SkkO+NR8Be6A==
X-Received: by 2002:a05:620a:402:b0:943:e872:f521 with SMTP id
 af79cd13be357-943f4b422afmr383527185a.9.1793116307094; 
 Tue, 27 Oct 2026 08:51:47 -0700 (PDT)
X-Received: by 2002:a05:620a:402:b0:943:e872:f521 with SMTP id
 af79cd13be357-943f4b422afmr383524785a.9.1793116306684; 
 Tue, 27 Oct 2026 08:51:46 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bb112sm293318515e9.8.2026.10.27.08.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 08:51:45 -0700 (PDT)
Message-ID: <87a9d1c9-728b-41c0-8fe7-d188d3b8da53@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 16:51:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/25] target/mips: accept Octeon PageMask encodings
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
References: <20261027104433.25720-1-kirill@korins.ky>
 <20261027104433.25720-7-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027104433.25720-7-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0c893 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=mP7XnoS4S2fQfbuYTI0A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: dwoJ_jMJ5sgUVPOC3fR-eLJV2CUEOf5I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXx6EcoxFeCJoQ
 dbyB/ig3VX8clgszjFz+iUg96AWgCbVPoJvuvgBdKrwWufwrdZD4gdk3k+X/LiVFMMpxlbQVJNi
 AXvDbHrbUWREPuEVvGz4Q0eiKTvQ0RY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX0PEt4pDvv8P9
 nIWT2wv9o+meZhYP3QhcNLQGLWGU+iFZgCQ8iSVr7dkduJt/Xq70jaKUEsnaOani+vbSNZk2x0s
 ZHyOzWdbi5ttaMmFGcCKRDSt4e6krlHNNp/6TB3JMxr+1Z36YUGALZtHqwjai87cCmy36gf2BZ8
 efehsHV3k4+ju+jj9sKAgSXiN7pgWSHTO1mLTDfV0ihw0R0X+n+hMCCC7c0tF6eWypTwfhZaSSW
 gB3vZNZ8PHRwIoTykx2xVRoyiSbaREVVMBPapKPVH02ziacN97NyBcZpYxhDGtnpnqNosISCVDu
 w5FHjrSaNV7IejxxSyz9I4fbeyUicwmG/8HbQplEdq64PBM+tpNWaessDOIvSO/03GXUuJsjM9J
 7Yf3C/GrSoQP/wFyv5qiyKUV64pcCVFCybrJ0BFpd2zpQbMJaZGYnRGjDVbDwzC0P/9a7tXB7OT
 qWgaVoV+bdGAGPjDpfQ==
X-Proofpoint-ORIG-GUID: dwoJ_jMJ5sgUVPOC3fR-eLJV2CUEOf5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 11:41, Kirill A. Korinsky wrote:
> Octeon firmware programs contiguous PageMask values that do not follow
> the generic R4K even maskbits rule.
> 
> Keep the generic validation rule for other MIPS CPUs, while allowing
> Octeon CPUs to use the contiguous masks accepted by hardware.
> ---
>   target/mips/tcg/system/cp0_helper.c | 15 ++++++++++-----
>   target/mips/tcg/system/tlb_helper.c |  2 +-
>   target/mips/tcg/tcg-internal.h      |  2 +-
>   3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
> index 33fb7365d7..046fea6234 100644
> --- a/target/mips/tcg/system/cp0_helper.c
> +++ b/target/mips/tcg/system/cp0_helper.c
> @@ -882,14 +882,19 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
>       }
>   }
>   
> -uint32_t compute_pagemask(uint32_t val)
> +uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)
>   {
>       /* Don't care MASKX as we don't support 1KB page */
> -    uint32_t mask = extract32(val, CP0PM_MASK, 16);
> +    uint32_t mask = val >> CP0PM_MASK;

This changes behaviour for every CPU, not just Octeon.

>       int maskbits = cto32(mask);
>   
> -    /* Ensure no more set bit after first zero, and maskbits even. */
> -    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
> +    /*
> +     * Generic R4K PageMask values use two mask bits per size step.
> +     * Octeon accepts contiguous byte masks such as 0x003fffff for
> +     * two 2 MiB pages.
> +     */
> +    if ((mask & (mask + 1)) == 0 &&
> +        ((env->insn_flags & INSN_OCTEON) || maskbits % 2 == 0)) {
>           return mask << CP0PM_MASK;
>       } else {
>           /* When invalid, set to default target page size. */
> @@ -899,7 +904,7 @@ uint32_t compute_pagemask(uint32_t val)
>   
>   void HELPER(mtc0_pagemask)(CPUMIPSState *env, target_ulong arg1)
>   {
> -    env->CP0_PageMask = compute_pagemask(arg1);
> +    env->CP0_PageMask = compute_pagemask(env, arg1);
>   }

Preferrably pass @env to compute_pagemask() in a preliminary patch.

