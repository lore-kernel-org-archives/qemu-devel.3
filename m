Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RwVUblXi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=greZnAB7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKrn-0000aA-G4; Fri, 23 Oct 2026 15:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKrl-0000Zk-I0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:23:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKri-0002dP-2G
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:23:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZuKW3259774
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0RIq4jJ06Gx29BCdGy2lGG1bj4yP/lpwn/B7lrSdX5w=; b=RwVUblXixXvlbX6N
 zstyklCvVaYoQJlXxS+0CSr05U/jGsIvaNYULmg10GH3pL57yfVr5SdAhAz8moX9
 /yQWc9B6QunmhYnRRf/AZg7sbsKHxrgcapdjOzTxO8yCDVNEARXClM5bFDX0Ctlu
 6B+5m3K/Mq0KjM7oiqLe2JFU1hRsrQO68f/M/Z4P+u3mVfiOFRCFGwOQCb7dEa5H
 zdD+Uq+lVtsxVgPzuZAAkkmro17EMEXYjAV7b1HXSUe7+TkN2Z5//uCeWJH+7lZ4
 /NLFO4TwfOubDvKgdShf4qVoL+FDF8tAJXJ4AIxAwtTc8e0qBkiyyrPKdrwqkghk
 n+OD8Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6rq87-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:23:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53664bfb2baso20211301cf.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792783424; x=1793388224; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0RIq4jJ06Gx29BCdGy2lGG1bj4yP/lpwn/B7lrSdX5w=;
 b=greZnAB73kJ5X+L0bQpGYzjnKckyzjLdixk7y04jypYs7+z5bMmEK39/1861GE8CGz
 jKkREFvPrOj3X+ShN6rPEmjkgYjyGYd8fKJCCF9oJbnkd1eqaVG4N/5yJBGtKfnsCHEz
 09fRp/Lh8ZsVrfhAK6Zmo1hSSd8DBfLs5miiDovGlk7+U8aajDWGnMPR7jdKoGDx5r/A
 +WQDxk1p6HgaoaNYTOhOVeL/3Isb6Q3zWruZUpjU7oeKsYKRwaWS2IX6vpPxp/aRcKmz
 GC/IRh3qgYIr5C8WgdZa5m08OAEMGzi2acgahzO5QKXhAq7vgGskvssHQPUM+dsj0pWC
 7Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792783424; x=1793388224;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0RIq4jJ06Gx29BCdGy2lGG1bj4yP/lpwn/B7lrSdX5w=;
 b=0D3BbC4jNnRHR9qkGoqQVDHw/iX2LUuFx72d2qac8nVtITIx1SiRh4/2k3R9odtwxz
 h/uuQjgRTi9Ty1W8Xh2bqf+MzB8zvThHA/NUZy7sabqmGQBZQkGAmD+3qzGSHkOIZd81
 ACovKWfoWncCvMaQ1jxJ701UmfYwgyUFUoY1xRNlPWnjeMFDhesugaDsThpXfo3R1ie7
 LiS426QfTuOoQR3uoDySYIGmY6cVv2KyN3hzbIlNFrvgKi0635F3tnaTbvhtNTHGbYZZ
 wxTZCiGD5ak895blsfxbotsNvBIGeLw00gIAWbimN2zmQ3zItuIJNpT0q7kbSMfTwkUn
 m6cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2QSXyNxHUDmjzeDLzi3V1Zj232jNm9Ta6LKdscDUvrcZfdklfZM3ZisH9VB5Ok/wH0/8mczucfSQS@nongnu.org
X-Gm-Message-State: AFq9FYJEyt02zdb1g4UDdCPkXr2hElTpetptu/HjH0dvJVkYU+LeRtJM
 MIfce9rjSLqvnYC8E094rrRjIDzj+vZZiPMbtrzad7Cx5FZgxBAAvqZBtz/nbQvzVf0sZagAXV/
 SbS1G/QdFZnt7bRvkWgVlhMdYfYWfZTE/KqVHCrFsFyzmgdLtDFb46AgZAQ==
X-Gm-Gg: AYBFou15gX9i/Vcqvel9cuvDKI9dbx2tRYDckGJffa18mzrHoAS3LPBa7BGkeg14Rvj
 UOv1qe9wUY67GCBcdxPDw5RauJ1AskTjMf8X6QoZSgkFgj+DSK8T5q6pZXQ519u/oSUsMc/Ls1A
 4W9axt7J8kTEZ7OUK88Wlp8oyF+9sD7ArWjO5ZM/xM9cdyOIGb26r0tuQBRcAobTVboJ+qt6hzb
 +2DcG5MUmFx14Op6bI7N3+NybbheINfJc2ZGYmOdjPhqemogTdUq85LGDNrpAizR0bGSENnYENr
 7iNgJf+OKduf8Zr6xTSWQUZ6iM0WyenjZ7pHPw2yr9lFKPArhshtNzkSbhWKpIZr8ojANKFGcKd
 Id6AeJqlxe5XNCMmh2jwjVMdINX8V8tIleVDM
X-Received: by 2002:a05:622a:1ba7:b0:535:a5f7:d59b with SMTP id
 d75a77b69052e-536ae202205mr101564461cf.42.1792783424023; 
 Fri, 23 Oct 2026 12:23:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba7:b0:535:a5f7:d59b with SMTP id
 d75a77b69052e-536ae202205mr101564241cf.42.1792783423602; 
 Fri, 23 Oct 2026 12:23:43 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c6f3bcsm2539586d6.29.2026.10.23.12.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 12:23:43 -0700 (PDT)
Message-ID: <0c6acaea-4990-4723-9e25-0ea0d11e0530@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:23:40 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] target/riscv: Only save vmstate_debug when TCG is
 enabled
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
 <20261023021237.486091-5-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261023021237.486091-5-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3NiBTYWx0ZWRfX7GdI2SBIAYIA
 z+lvgYTFavoHwdAX93sMkY0hFtdISQGFKGIWlXl48YJn1kP5HkcUstPXdvVVLV+C21gd6yz9gt/
 7GLJrr1qb7TZ1OJyHyjjreIE0WoOIY8hWzLdJ1FX/sx0u1dOSZy4Ha32uZXmbRvwGYpLoEE2ef0
 vyNNvx7QNXWPWNxmuaUPFRjP+Uo87D7XAuqNtQjNQLB3coeswGVbR4JAR8Wmws0WOPNza5u97WA
 U30j1ESrj/Y5r/t6EY8a8MmGhUSslivt7P43TpFaC2XsWjrIL5sr8HUrNwXJelZ8OYmuHJY2tPA
 dwfoRJp8blmoNV5gjuv1vf8ykKOcVfxACjkB6PbDwrdy0vzicHTuLE03omvxG5Ahm2SoqHiwqK2
 IVRYsCTCh7u7pdqWPg3EG5NqIj5n3VaFCm3uiSbdJkjtcU5DUfzwJQu0HnWG+1yUEUcBp6VF1CX
 H7wMpd3pB2B0//gs5SA==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adbb440 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=vNpfg47zEZen4TmNQBwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: ft5F9A50eWSzPtLG8jkEGnZzWVXW-KdQ
X-Proofpoint-ORIG-GUID: ft5F9A50eWSzPtLG8jkEGnZzWVXW-KdQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3NiBTYWx0ZWRfX/pdnz0yAEf8s
 kF45tI7EyTI/fDFcJDgZ+a51SzfrRFItSbtPGYa+vD+eyyfodjsPtWbjX+WAIlohzSajUm90cOP
 b8qeZCVrRuvhvgjGuU2pCh1O+YgiT9E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230076
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/2026 11:12 PM, Wang Yechao wrote:
> Commit d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
> moved the TCG-only files into the tcg/ subdirectory, so env->tdataX is
> now only allocated and valid when TCG is enabled.
> 
> However, cfg.debug is always true in riscv_cpu_properties, so
> debug_needed() unconditionally returned true and the debug vmstate
> subsection was always considered needed. On --disable-tcg builds the
> corresponding fields are uninitialized, and attempting to save them
> triggers an assertion failure in vmstate_save_state_v:
> 
>    qemu-system-riscv64: ../migration/vmstate.c:737:
>    vmstate_save_state_v: Assertion `first_elem || !n_elems || !size' failed.
> 
> Fix this by making debug_needed() also require tcg_enabled(), so the
> debug subsection is only saved when the TCG-only state actually exists.
> 
> Fixes: d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


Alistair, I believe this patch can be queued separately from the rest of the
series since it's fixing TCG vmstate that isn't related to the rest of the
AIA changes being made.


Thanks,
Daniel


>   target/riscv/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0de06e9588..c5f0261ba7 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -324,7 +324,7 @@ static bool debug_needed(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
>   
> -    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
> +    return tcg_enabled() && (cpu->cfg.debug || cpu->cfg.ext_sdtrig);
>   }
>   
>   static bool sdext_needed(void *opaque)


