Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16156606A68E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g+2jtXEd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GAPaa/Lf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzs4-0001Ir-Lf; Fri, 27 Nov 2026 12:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzry-0001Bd-3g
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:36:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzrv-0001Nb-0g
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:36:20 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFp3nQ3328702
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 grLJyj1LRjfXd1q1J9JbjXFmyCAAwPVMFOuTxu/J3oE=; b=g+2jtXEdm8BBYolr
 jRQ3EMuTinEFtLmOTghow1GXx9fpts62QdHE+eqJOcbYEp/LPvc9mU6mIo3jGqjz
 gfGMUQsmlxn+3ZzX8MPD8mQVMKOUZBq59RzD9AjLVNK3BuROA02AAfSwrAsu/yVx
 U53vp7hmSov8iCD/8uwFXZAF1HggcmK7Bq3qCGQ0OF1ubcz1TjOTEnG0gfaiqfJ6
 /NsB95gc5nf204vH3qv+2iVDPvWWY0O2jlX8466famlv1SrAwpqQy3tMLDWY/NLO
 Et2TxtUdps4zsN3270Epdt8k1nLEM394Ug9lnLb5cTcv4iU1oZeSxycuvmRzYPWZ
 t/3fYQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74ghacuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:36:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so5601710c88.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795800975; x=1796405775; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=grLJyj1LRjfXd1q1J9JbjXFmyCAAwPVMFOuTxu/J3oE=;
 b=GAPaa/Lf42ApSoybqRvSemIq4nH00j2v1F1YcQSVOPk3t266KvXPnFJKMI575p1GIE
 YJ0x/qkmXnL6U14UtWh7fL3+uGSq7HF2rR3xbUPW2jx5eL76pFOrGnJcBtPePOnPv62m
 H46msx80YmnFmq1IwJj7U95rINDUixyEI+EsCERoGLtBhXNZNBMsAZHXknPeOtdSH6Wq
 OuaN85CbmpsCJ0dgqDptbG4/7lYkL0INxJan8fbs9AO0GkFJHqX4EPRu3HwVRmogvSvG
 8pLO2sz1Vo9efvbBU4JxmpTDxfKpyUlGTn2Nz/IVQvjpiUCdLQUjE0yGOo6RxyBVL4Hz
 OBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800975; x=1796405775;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grLJyj1LRjfXd1q1J9JbjXFmyCAAwPVMFOuTxu/J3oE=;
 b=UaH+Us/fEGQJAkFvZZ8KxpGgpWmon7P8+mlo7xePL63BRu8htk22tGje40AGCaLSgH
 wvNIn8ODrdAwQk+fmMcXkbl2le5Z+FnjW2EPObCrBqiS/rHFWiof19e4iEuw4LihUQYF
 kUnEzVyvzzPEhqaEnXDKqLX6K18LcG1piXy6gzTZJyIP2ICKToeCWQI26jaVFuEuEdTH
 Ym1IG24qmR3oiBCZUODIBuGM12Go7COKhesmtfjIszS3r9ggmGRxmIeyaRSX2AiLx0nW
 DV75P/GHyoDlJDEHs+hTf1WiQLwVfLGbjQwv03EfqQi39GBqdma2GFV9bdxU+V4i79sf
 gJ6w==
X-Forwarded-Encrypted: i=1;
 AL+hErEZbnnvH7c7DFSIbo+lniq6yGa4IWRZcFRdOLmyu29zr5E9MHvx+zbNUCmlBIUbhRXOJ24lcnh03MwV@nongnu.org
X-Gm-Message-State: APuU4Z/3+DUDOqH9/zkriYxZ3jxhUKMAPBQOISoxbbQn1i0j5t6TvKVm
 KqZclk1n+n28QPTd32jDvSDW2N5llOVPjlfJNutghMqsJlLdXbO6fxJALDQwB4pZd3FZTjNZ0ml
 vDQ7H5ZUGKj8RhoksvC++SRT+KOaWmX85mhT6OfX7UoMy1Olr+IPS6pzM3A==
X-Gm-Gg: AZFdTZfOjzHILQL2mg4SIcvLmQLadT5Xt+AadJdZj1idu7GCvqjLXqCWkRg37uxEBoI
 MOQORNrZmkpIZPr1RgAwsk4GSyhxGulEsRiGsOsQ8nVE2XjSU24I5eGxyVwM7X1ZRRN3G4GccMK
 LO2dmdnaySyt/hul8zIEv7gU+yK7EdM24dPfzRSdjss+J03yZNbS/Bv6Y5cELKjJpYGQPUmmpYt
 +5OQvkwMHFqkr3JG2QBL1MdaDIAdhoRMW61HnFnvYYRpvCtGwLetKrb859bPJqAw6ui0iey1GFr
 LeayDK5BMSYl/QhG+4U0fUHEcwINasWrPYPhsVneatuBuKnvqJDCqbkHPkOMHN/P7TboR6asGGi
 EfoaEl4DO1FGQ+vedGeXm8T7UW9UToajSximVLWJVJzElgsoumcc7YEtkkgOQ9+o6k6ZAm8xQfx
 AVdc+xTru4yCM/JGl7gseQ4MmBYu0nUnid1HXyIRZez/M=
X-Received: by 2002:a05:701b:428a:20b0:1b5:1a0d:b544 with SMTP id
 a92af1059eb24-1b5568a145bmr26835413c88.7.1795800974834; 
 Fri, 27 Nov 2026 09:36:14 -0800 (PST)
X-Received: by 2002:a05:701b:428a:20b0:1b5:1a0d:b544 with SMTP id
 a92af1059eb24-1b5568a145bmr26835383c88.7.1795800974163; 
 Fri, 27 Nov 2026 09:36:14 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm57191551c88.2.2026.11.27.09.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:36:13 -0800 (PST)
Message-ID: <51f1f08c-9463-4b33-8792-ca71cd6ecde8@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:36:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 5/5] target/hexagon: dump vector and sys regs in
 cores
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <20261125194855.3154845-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261125194855.3154845-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3MCBTYWx0ZWRfX0MDZNAGwc50/
 tNC/smhKBKNawlzzFy3M3Ga/tFClQw00/RvNZU13JZjhWpClXX/SYJnPF9Bm+V+r7+dtsZQ4PTb
 NUJ61T7MDwndJo6zGOZUqWwt8mOydd0=
X-Proofpoint-GUID: vR9rXV0vnA3Nt5fQsaoHM1BqAeFEmW8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3MCBTYWx0ZWRfX4G9YvsVjuqWF
 Cz44dbkl+/FfuHQi6hl+7F4nricflfN7ehxh/GLz0bV2cDpJq8Pud4P+X2Toad4ghUQ7NHdmDh4
 BkBnIranBTru4Yugl3SWd5imuIYQ/4lN75cK9i5bSVDdvwtIv2+8Z4DnP8nksn37qihshh0zXJF
 CvaoykoyizuzdZ3CnXsZOAclQ2pwgI+2KPj9Bw62Wi3U8i779tG3QHiiLlJdZD0jkcA2HR6ozoz
 6U27CILMLm/3HNPOZzCrQRXYOho+E+ITuzjzoZ1FDl8+gBE/bJqbXqUg1ffuTrBj8ZTjiLXRMb3
 629jYRPO4/FJ13vzbAALJSqv3vbyTsGETE2E6qaQ6gb/zEyENtm2Q7hUo9r0yhEP/3YrxIR7ZaM
 p+ki+mYKx3euIB7bj5mMC3K813mjUgIAW7SO0l0NLJi0fHIgCoAC+EPmrPRCEQlHcbJEwJpbF46
 lOAn9FA5JsJ2VeEtucw==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09bf90 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QrVDFRbvumA2nojZpmEA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: vR9rXV0vnA3Nt5fQsaoHM1BqAeFEmW8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270070
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

On 11/25/2026 11:48 AM, Brian Cain wrote:
> Add the HVX/HLX and system states to the core file as notes.  HMX has no
> architectural state that software can read directly, so it is omitted.
> 
> The global registers and the TLB are the same for every thread.  They are
> repeated in each thread's notes so that a thread's notes are
> self-contained.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/target_elf.h |   1 +
>  target/hexagon/core-dump.h      |  16 +++
>  target/hexagon/cpu.h            |   2 +-
>  linux-user/hexagon/elfload.c    |  10 ++
>  target/hexagon/arch_dump.c      |  23 ++-
>  target/hexagon/core_notes.c     | 245 ++++++++++++++++++++++++++++++++
>  target/hexagon/cpu.c            |   4 +-
>  target/hexagon/meson.build      |   1 +
>  8 files changed, 296 insertions(+), 6 deletions(-)
>  create mode 100644 target/hexagon/core_notes.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

