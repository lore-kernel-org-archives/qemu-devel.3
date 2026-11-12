Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74163606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mHUdx0Ri;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gAOIrNTH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMIR-0008Hd-MM; Wed, 11 Nov 2026 23:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRMIQ-0008HQ-6M
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 23:20:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRMIO-0000OZ-KR
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 23:20:21 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZiE33061624
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /jxu9WqVprySRwq29SWyrrQu84txg6vjUmMUMj38+08=; b=mHUdx0RirvF0xQ7J
 S3sWCa4Hok8QZrWMAo1nE83NTdP9YCYr2rFlX+w3myyll9840YgclZ4rc7wa+2gM
 U6Ek/oKDQ3RVz8VP9SSMnicE6FiebXfwoAM6eQGDH5rRlSI60zaRtUXnDs4PL3rI
 WPA39rQomEVsX9ou75pFrJels1pe5v7MPrYbrlykFtlKleq1osKrC4zrUDlvAE08
 Rj/RSWtR8jgw2FKlzhQOaon72OknMG+CMjiftVnpPIaTVBIUZLManOR7mUUkt88e
 FMdtww6X+FvJkoL83y4cb7KLlrin/+50TeVI+Ijuuh3yBzUNPoc6hwJg76uKBnp6
 Wfx5og==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvs4m37mq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:20:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f62934ef6so877709385a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 20:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794457217; x=1795062017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/jxu9WqVprySRwq29SWyrrQu84txg6vjUmMUMj38+08=;
 b=gAOIrNTHf4q+weLs2S0XKSVJpieWeaLtxknWP7fK0nPcSWYTXsBrymZ5Ybeh+5B7Eh
 cx73Zqhwwc5Kg1V6biNE8/oXEnxoTJ+Sauvfkwxt4uHcjmgVqWq/04gLlezjoEcKvkVX
 dBxvbzBydEMg/onH0VN4LLa35zphE7bP2RkbTDcm/5/HmUi6R9OJTE1uMvCCXrieumYH
 2wFLpPBvopxD0rz0uVcRUaEQucWxmRgG/BFJCGr3duDW1qcaoPL/Za/lxKpfaS30gIfP
 5TeITRcSI22o9hX9tCX9QyK9h6iSvIGWTqkts20Swb8hxyjS3hK6CPy/wrCcKQB0Ivnz
 A6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794457217; x=1795062017;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/jxu9WqVprySRwq29SWyrrQu84txg6vjUmMUMj38+08=;
 b=asrkUi7FuegkQclhczklTFeDhRNfAx467NbpwiCHXNwFu3qfxsb4h5vw1if9wmG+0q
 Awvo2FqYATY3wZp2g5r+4XmLd1qWWVCsESJh1X450QTDU6UcKw2huFRyF6jDgFpCka8W
 qPY7jxYhpzMUug9vkPRRxrj1eNb3/PqiJ6j4pymU+hx546XdN40gdOm8qb+pvOzx+qXd
 BPbv8KBRJfoAMG8pvScn6i7bnVhGqQzhREEmfn4HhUtXT3YFBWjZgkQn9QYTotkfLFOf
 aeoqQtvRJEi2/AK+sB/OcTen4piAPmgf03nKXjfqzNVvKT41zEtPo9qFqc2aIaZKM4ey
 KOPg==
X-Forwarded-Encrypted: i=1;
 AL+hErFkRLR15CxYEyVEZI9RLrlIrwyJPM5pyr520lLK1vqXx1gsovOiytBl7sIaOKteRp2OIu44L80TGZkC@nongnu.org
X-Gm-Message-State: APuU4Z9z8wtOkIAACMDP0ZY2IHHLKVYAMeDdc5/cTwNF9FE0P3PEzptp
 3kjVM23xnRx73/7TrIOkCcG63dWws8hWlYguV3BM60YogS7WL1b+iIgetbsWq8aHS1XjTRoa6GQ
 pVsbrBM+xJuci+Sg15Rhu4Cu8y+0RzL8UwPKOLUL+sgW78yidicEOD26tUA==
X-Gm-Gg: AYBFou3YsiwNiOb8lSHEe4PHE7WXel4NCPXwYynVYIPdjJf8EH2izLEuBtxqwhZvUqM
 AeP1uJ6F9A+wI4H8W10rdmG0ZZ2BjhwUg/DhPHl2fewO0f75SxpuyCXiHrzzB02+6l6EPwbz+at
 DIfV2+bIsu+5yWTXSEB6xvDxL+jr1dKSwEumayNcWDkFA6p+B5ZCzU6a8qa3x2nj4YxVny1f/LK
 d6F20Qf4tsh1zLUy13Lh9yVEdSoc4ODhRyKMVE1+VVzH4E9reoEy+x4BmJgDCw+bHi2qeo6vlPW
 0G9bCQD3ZiX28T9FVTfFZQBVTz+276Ui++Xv1Exzzq3SrMGPercIrbx+bqxBogwKeUcGZGhEN0s
 CBZsJDLPcE++NLXIyHRLWDxyZumnBaDMWSKlDXhtE8KEJr07yV0pEngE8DMSz/XPyc3rdL0x6ud
 5qXo7trKI=
X-Received: by 2002:a05:620a:28d6:b0:93f:3120:6c6d with SMTP id
 af79cd13be357-947b003846cmr722143785a.35.1794457216902; 
 Wed, 11 Nov 2026 20:20:16 -0800 (PST)
X-Received: by 2002:a05:620a:28d6:b0:93f:3120:6c6d with SMTP id
 af79cd13be357-947b003846cmr722141085a.35.1794457216504; 
 Wed, 11 Nov 2026 20:20:16 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2adf53sm35307735e9.15.2026.11.11.20.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 20:20:15 -0800 (PST)
Message-ID: <1103fc46-e4de-4a10-a7b4-0341fdbeb421@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 05:20:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/vdso: make the binaries reproducible
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20261111121259.14941-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111121259.14941-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CVnBamLkDvOcrUF_eA-orl9D_GbTdsT-
X-Authority-Analysis: v=2.4 cv=OYANnRTY c=1 sm=1 tr=0 ts=6af53e81 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=9qUTvQc-AAAA:8 a=EUspDBNiAAAA:8 a=ZxYp_3U4W-SEwnDaUugA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-GUID: CVnBamLkDvOcrUF_eA-orl9D_GbTdsT-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxNiBTYWx0ZWRfX4RJOxO/6IsPf
 GzAchnEsekyzjS/6OpaZLsezvvYYWZl2XwrPzfEXlwCQuOtpSpp2tkOBRX1ciQQSeeef10TpPHi
 IKQfEPXgIf74CPiiKEG9xbWBNfJWG5JRRclRJOVLQSKIR/etSxp3MsrnOTYdfmqrtFEgDoa7G+D
 58DQj6i5xyW0DFSvRgeFNjxKrjlVNMKtC+1w4mHA9jozkbSwV02sjCIR5iX+AjYn5cjHDFKVPnt
 9HfFugYYRm3Mt9hrVNa/+3VEagakbh+xn/I/bnmsWLzGDwPlGhlzRKN84oHtINxVyODDqcHTMaS
 RdYKZh7rsMSseHTPZaYDNV3/4k+FhaFetMgwpHi6H8+ppSZ0Xr1HOF1RP4Ae/CBogUtF2wmflyR
 tddS/FUvkb3cUYduRUAwgfxtGrZ7Zklti0PmQjfcmNNSuirXPOw6C9i0Ff78ZcMZ6In2t/hVyxT
 dNY91gHgDpEhyJQNwxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxNiBTYWx0ZWRfXwpAOOr8JhV8C
 f5sJUTBpmMgdc/AfPlpYXAODHiP75I/9/KiDhPaQ1sLGhNQel32sbMwWOsFDd9U6SvHNj+v3Ly5
 XG/jX0lqD1zncrwEN4eLs+i9cB+jGQQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120016
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/11/26 13:12, Michael Tokarev wrote:
> Currently the linux-user vdso*.so files are not reproducible,
> because for one, the binaries embed a random temporary file
> name used by the compiler during compilation, such as ccuckKYd.o.
> 
> At the very least, use -pipe to avoid the need to have a temp
> file in the first place - this makes the build repeatable.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/aarch64/Makefile.vdso     | 6 ++++--
>   linux-user/arm/Makefile.vdso         | 8 +++++---
>   linux-user/hppa/Makefile.vdso        | 4 +++-
>   linux-user/i386/Makefile.vdso        | 4 +++-
>   linux-user/loongarch64/Makefile.vdso | 4 +++-
>   linux-user/ppc/Makefile.vdso         | 8 +++++---
>   linux-user/riscv/Makefile.vdso       | 6 ++++--
>   linux-user/s390x/Makefile.vdso       | 4 +++-
>   linux-user/sh4/Makefile.vdso         | 6 ++++--
>   linux-user/x86_64/Makefile.vdso      | 4 +++-
>   10 files changed, 37 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

