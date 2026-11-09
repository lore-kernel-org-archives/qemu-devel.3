Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0797606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nMCE/wcR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NZzsswEL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPOu-00040V-Bm; Mon, 09 Nov 2026 08:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQPOo-00040N-W5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:27:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQPOm-00045h-8P
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:27:01 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEph91322920
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 13:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qtt/RfHlem6EbqHoXAPY6CJ7IrJAMiS7twUTN4efTEA=; b=nMCE/wcR6O2QN4Qp
 ch8ge47D8OKD9fT7kEK/V7C3Ut86UA4AUqD/rG2+XL/ed9L6AeGw2rDF/XY0kafu
 C2eh5l9Db1vcURKv+iTWYOJwgI/M69CtdgIAbaIOwdj9gvikCUs5ieel2gEEgESP
 73nXhbEh2Nmfra2TJnWkTLhGrxqvJVAnbzjlrfC2Di/XtQx1zkflJoAeboyPI+1P
 IQ5MAOWZNIGIG7xBJQu6eUOKXxPJnunGzXH3ggJz7ux1/NXJLplBHw0cSJxm4RTR
 uGbkvuS+Zf/xNOOHYTjzsBUIiwVtsLmPyP+EMtVCvSwhf2/gB7ByNAeyKa67NY6P
 eM9QxA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qr7n4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 13:26:47 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99b8fbf29a9so412821241.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794230806; x=1794835606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qtt/RfHlem6EbqHoXAPY6CJ7IrJAMiS7twUTN4efTEA=;
 b=NZzsswELFBaJWYrsOCBCdYkAO4x8W9PJLOTA48I03D8w/G7jGF0ToAKpwiy4+hKiqW
 MqM5VqnUI9WjlBA47ShEVWImOfyrhuwomOdp49EV0zbAbvlHKLD1TpgBo3kE92NCmoHR
 +riAa9LQE/Wt5gzRqQ7GNi8O0hoo46zT3/qsN1nMmFDxF7u07ZzH+yf8CRiri12yDFmu
 itC8e978apTYCka7l8EGwAoS69wfUupPvEr8ziEewm941KvLxD2p+pG7ojIHwOkc09Tv
 GWsLLd7ziZfniykXQg4OnnoXISl0dTWmouT8MyBigYbKM4R5QiI1o3lLuIIv8NiVn7Rd
 tw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794230806; x=1794835606;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qtt/RfHlem6EbqHoXAPY6CJ7IrJAMiS7twUTN4efTEA=;
 b=eGHB/5UI+JPXMHOUEOeAqmzhHwVCpL+tpmYaU+KgT3AYclMsG9eycb6E+SEeLbPfkC
 QbFErpLD/K47OBIKYZKVUyEUbnmo1MVqw7beyPzvD9GqHHKjdZbudZgeCxZfsHn0aA/I
 xy8+ScRVoOjfaaYjYJrVyrkHJ8uAoLXBOxtzIvHZ0si1jX8Ysc83knKD5KRJ0hIQKLIm
 SYIrMFJDfM6SdUZNgPc5lzobpfWdgcG0k4ChAVcVKDv95J2QmfYrXDicqjoVkHZz6zEL
 LOfRP2lhBsbQapduHmECIdD4Fqoh0GZOO3DZDMnIYlI6LyB7t8HExhxOuYDE+dJHxbbo
 5zGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEzXenW9CT2+GPiOP6lX+3/0QXmpF3TY7Po5gVOe3Wc8RY3RaVskGFc5YhbciaGFkqgIPor+pTjl/0N@nongnu.org
X-Gm-Message-State: APuU4Z9uDy58sXClJlD0S8OzbUeC1FA7zvLrxNrlEJ+/OHqmsup3c3zN
 u484SaeT81Sl/Nzqg8MvKiiNd5rkj5Imbnswe1mDYMTtwUibvIkQMAvqZ9lEf9HFLJ+Nj0gxSew
 F58VGXa3WV3xRXf8eMtYapNY/qwyyqqgri1xhs1cYN4GOWVkq4NtVyKoLKg==
X-Gm-Gg: AYBFou3AIByDrutNexlhoMIxSVcn9rcxm/56DSoWM+cFxVpcwSR2ZqU5iyBniyiIRvY
 z8UKShjSoAnK3guclnGKSkpdxWYG1rJJZsr2n3zf6gfPj9tiRWm20h2XjurImINVwRupmjJaHQh
 atZa2x8hkRXdywCsRE9nvB8Ouc2eDiZPf6M5klSATZZaDYPJQKjW6yrII+Sj9w8cAGBc0hvjebl
 M5NjvR0cydL65IAndy2nO3cM2f1E2zFavL+4qXoxaLW76/FQDzWX96BnJz2o/VWs9ZPQCAOmuKp
 n6f40KLPy9+/zVHK9CerNDpD/cJZpQJGTEHTyZTJDhlmDXrUjytoNYfPicNu9dP2IhiwJgW2Nt4
 PiBtX1M21NMjisCtESylDW9zCeMrDCeUYPXOOQaaReUKqpLrpT8B0iL45CJZi2F5h3o4hMyuTyu
 2LKJD9GQ==
X-Received: by 2002:a05:6102:f9d:b0:7cd:3218:362e with SMTP id
 ada2fe7eead31-7d2db1b9b1bmr809677137.29.1794230805639; 
 Mon, 09 Nov 2026 05:26:45 -0800 (PST)
X-Received: by 2002:a05:6102:f9d:b0:7cd:3218:362e with SMTP id
 ada2fe7eead31-7d2db1b9b1bmr809671137.29.1794230805081; 
 Mon, 09 Nov 2026 05:26:45 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959755d423sm9917377f8f.40.2026.11.09.05.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 05:26:44 -0800 (PST)
Message-ID: <a7a8be6f-f715-4bab-8d05-5da5bc566ccb@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:26:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix crash when BAR has zero size
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20261109121401.973836-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109121401.973836-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX7AKcKyhkdz1y
 U6v3ts/BwLRaVt6hBC2f/ltoXt0X8Lgre+Js+S4HfAuReSEqWWqbsSvF+kpTnEqxYrpe6dMhJrw
 NHm0P4K9JI8W7TfsEmmBEYSMV/S2rXFj+n0rLgos0tuP2lkP4SVqIUhu38j2IXHMLJqSfXRH+ET
 D85XU5m1+5dzfW+WsQqQUJ8VWa/KGQ2nOob84o4Vgf5MdEgfP7oERSseUNpYBniGWiN3Y8JZFbb
 n8OjuArkN3okZor80VHWc77cQseM/GW8fyfwyFOKj+w4Vtvn3avMOdcemYVWoLv6rVwDqATVfGw
 PDQLg+F4Syg4nzupCaZV72yWnE+FQdmRKzURwDHMIzRvsq1/7gkMTPduTrjoGprCbKOg7Zg1Lrw
 o1ENMQEI7gpFy4IAWFrmorNyvKk/FPJFpOA1neVG0CKzaGGY+XBJhR+qYmOhbk9QgiFPNdFKUqA
 469K/In3JE63ndLlFCw==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af1ca17 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=CwVkp2WNeTL4dGiJ2v8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: UUa6h7BiJ3VxeA2sTnmvCui71JpPlnAo
X-Proofpoint-ORIG-GUID: UUa6h7BiJ3VxeA2sTnmvCui71JpPlnAo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX+NJWKaYxRt9P
 1TE/SKAPrgMCiKPemJNGgXrPeStn/RDJnXNLjUlZkUdfUnXEM6jq99a5qGzULuFSjfIU4ZT+e7f
 eT2Q1Et1dUy12GNVw7L7aqFNddmZM5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090053
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/11/26 13:14, CÃ©dric Le Goater wrote:
> When the host kernel fails to assign a BAR (broken BIOS "Above 4G
> Decoding" or ReBAR configuration), the VFIO kernel interface reports
> a zero size. In that case, vfio_region_setup() skips allocating
> region->mem, leaving it NULL.
> 
> Then, vfio_bar_quirk_setup() calls the BAR quirk probes and passes
> a NULL region->mem pointer to memory_region_add_subregion_overlap(),
> causing a segfault in memory_region_update_container_subregions().
> 
> Skip quirk setup in vfio_realize() for zero size regions.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2732
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

