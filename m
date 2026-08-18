Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDDEC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQW7-00081W-I1; Tue, 18 Aug 2026 16:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwQW0-00081B-OV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:34:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwQVy-0004hT-Tv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:34:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJZd1t2066948
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fF+xBm/x89KGld/AZ+WtpqxjhTb8Tua3eCPWR1FZ8pY=; b=M7ZVe6X/khEQskwV
 5l/912Eqpch4MmvB3qNAAThUX5ZJqZct9k/7r1flaU/7EYV61sdwnJxwGU6G1M4T
 BCP59sSy0eE1OKdReH6T9KS1MFvRi2FhIfLoEldhe8+aRozdLifrJ5bYW0ziPOMn
 kIZ5rm+4GHIdxtTQTePomFmolaboBV9p85Tgcp4X/P/edUk5sRyjZiPOKJPx5ktU
 7yTTXLxiRZYhYybWHacFyUh7zKh9ZRF5OTVmVUlkpE7LJoMnljo/o+OyUn2Ek5fQ
 Lf4AsBaHXNgOemAjFYvVNZyvsTdbzb10T6AVclWt3M393cWeVBwmJXy09ol5sZFq
 5WNIqQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu0f06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:34:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso4008231cf.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787085267; x=1787690067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fF+xBm/x89KGld/AZ+WtpqxjhTb8Tua3eCPWR1FZ8pY=;
 b=S3++DHNZuAm66ZszR54uMiVv/5FRPv8QruTKW0PE+VByhjsoTTTKdTk8iUTAZ9fscp
 alwz7PuJiNd6sKddAiY9mbzTQfn++gO6v6wehSi/xcMhcK14+gaUzUC8OtUtGWeinKV3
 aARG3V50UwGhNKTruEYHZvbaH2t1Ch87bl/qWbhSB6bdsO0WQJ7U+DfLUY9cnQ9hzE9L
 ueftPAstHSdJgvqxRxM2fhYdqoSbD+pg8oRJLoSVqTvFhW9X46hZy6D8tZd2baItMrU7
 Wa3dPvTapfzdbwBtqIZnhXdTo7SGM4rAQfb2nWZJ15PnppQ8oIAsmrQtIyFbecMMXe8t
 OGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085267; x=1787690067;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fF+xBm/x89KGld/AZ+WtpqxjhTb8Tua3eCPWR1FZ8pY=;
 b=DaFdV0hVvRM4DkgEBsk39GHNBopFi4NdcVUePXWGad2svSTSytYi65cxl8v9cOGdrf
 JzM43oTIJpwBX3g8+IMVLY3FoC0Mkp3JEkmkOHhe7TEDGE3WeED53UH8xL6Ciawl+Q/4
 SqsXmeDxnMrhQTqrQvhZuvHrTRM5xdoS1RToI5tYaRS0dBbevDx16HOtT9L9ulQwgbsa
 DxcJDqGrfdCHsMhsNwmQSo50GUhJjnHRhe+yvca73Yiq5nOGNSs/VMv1rmXhVZmeg7vo
 ArKA6CuBVIBUQWcVY0uxW3PYbqoLcvUxqZuYGE8ikRnhUJ7bVrk+vFXYf8YkNxJoBjJi
 sZzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqetLAoNSk/vT/2SyzHw2M17BF9aWNcrya/7wQziM0yannJRZ7WSqgcgZ/vWzfoGhvzdg4NPV5wLIbY@nongnu.org
X-Gm-Message-State: AOJu0YyPqe0HO4QIwJ1I2wLCrpAb+DzuvOdzusyvGnXRLZGUbAIHMblo
 7/rRRoDdkazNgo0uE2OAS6bzeDOZ5ueJX9ubi1tFD15B2xfyVRxx0ILVA3gRF2zmTn9neNi8fgD
 +c79gL9MImq22k1zo6tTbBsQdtU0yTuUg2fsFjc1nw/h17MSojeVXnS5FFQ==
X-Gm-Gg: AR+sD10e8huSzrdzGdyLmARjFCh9qt+ype8NCUglSlhWxCLlY9nUl5ViJzF+83NCYOh
 0FPeQJMoS7LO5F9BGo0f4VWNmYFpVyFN8EaWEGsY2L3I42OFx9iLvYFvo0PAguDPrri8xr+oRae
 lcfZ0pjYVp8NGZKKulL/gwXP77LSLv80SUlMqfhcC6MVpUrLFhQkP2ge9sz4i6/R8T5E/Ulox9M
 3FsGASp0MrrTQY0QPBU8creV0K03s92JEICaZKZpGBNBbkyy+01NrFzV1Hl6AlLQ+8Ox9sJGZdC
 bBISn8YX8EigtHQQd38Hw7hNa2lP0AFrWkS9JZNU2Yz8A9qmxnKDOQgxQ/QVYmfq3hP7JkwmNwR
 G5YO4xDxziOAkn2QfSQwvRRrtYdPsZTi8H99+QK08NnJMsqxjzRX1gVPHCA==
X-Received: by 2002:ac8:5a12:0:b0:52d:70b4:2e1a with SMTP id
 d75a77b69052e-52dd30d0e05mr8641841cf.1.1787085267368; 
 Tue, 18 Aug 2026 13:34:27 -0700 (PDT)
X-Received: by 2002:ac8:5a12:0:b0:52d:70b4:2e1a with SMTP id
 d75a77b69052e-52dd30d0e05mr8641141cf.1.1787085266832; 
 Tue, 18 Aug 2026 13:34:26 -0700 (PDT)
Received: from [10.96.27.162] (246.sub-174-224-21.myvzw.com. [174.224.21.246])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db613ca70sm46609961cf.13.2026.08.18.13.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 13:34:26 -0700 (PDT)
Message-ID: <1a01414d-3933-4f2f-9146-9ea2845ddbf1@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:34:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 44/49] hexagon: condition HMP-specific code
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-44-e53fc35bc550@redhat.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-44-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kd8JFchGSuQVscZ7TAOAwR31tIH1IJev
X-Proofpoint-GUID: kd8JFchGSuQVscZ7TAOAwR31tIH1IJev
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84c1d4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=zpb6me6fL2PcLasmGntylA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=tKZOxZsgTV0PK1T01DwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX5fYmD+nuJWXb
 ZvuOCT250YPYGgzRICrwVqIQ0Hek8C3nIClvxNmtYHegoDy6oAPtiDDRI8SFxt/szenTEIpv+ac
 UYF5RuCNA2t8pgViWhTdRVqBx7C5CEVV4PRX9gRegH7STgdG8gGzPqQPWNwfuDYx5cSoryyL99q
 5IojZ+dKY+tOQVROLDMzYmiv5Rhvr4LK80+pcoubjhYTgr9LY3MieLldHwpfBqHHqRb24I5TRMs
 /nM9gmHjxDbcgUF/01tTWx9ZDIvfAz5OJ/P2yKdG0AA0JfJMEFw8fq9j3kgFAppNF5LZa01xO6T
 CQLFrhkJrQBUUruC5HH4LKXVwAQwXIBjzJBDI1N3zXGAJ2zgGBtn6I3W/fLbLhrErFV2JT0eOyb
 a5DQ/YkIqzD7YFgf+MiyQ4I3b0mc4QPh5el+yWWO4+gCsUSYSEv6frNBTbh2uSzvtPY6I1qMl/9
 Mz+aWOhoKkhABaNcc/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX8/MGnm330+Xb
 Pmaw4DDua0rh4x1zaKfV3x97i7zV2YI1GXEF1oq+pt391mYwf6mdgPE90TvGaAyQODCeFtGSWaN
 Gy3NI9xVEE//wxT3b4HgYSiC8RYLABc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 8/16/2026 2:13 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   hw/hexagon/hexagon_tlb.c | 42 ++++++++++++++++++++++--------------------
>   target/hexagon/hex_mmu.c |  2 ++
>   2 files changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
> index 584c606a22c5..ed8c0a761228 100644
> --- a/hw/hexagon/hexagon_tlb.c
> +++ b/hw/hexagon/hexagon_tlb.c
> @@ -57,19 +57,6 @@ typedef enum {
>   
>   #define NUM_PGSIZE_TYPES (PGSIZE_1G + 1)
>   
> -static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
> -    "4K",
> -    "16K",
> -    "64K",
> -    "256K",
> -    "1M",
> -    "4M",
> -    "16M",
> -    "64M",
> -    "256M",
> -    "1G",
> -};
> -
>   #define INVALID_MASK 0xffffffffLL
>   
>   static const uint64_t encmask_2_mask[] = {
> @@ -122,6 +109,20 @@ static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
>       return (uint64_t)GET_PTE_VPN(entry) << qemu_target_page_bits();
>   }
>   
> +#ifdef CONFIG_HMP
> +static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
> +    "4K",
> +    "16K",
> +    "64K",
> +    "256K",
> +    "1M",
> +    "4M",
> +    "16M",
> +    "64M",
> +    "256M",
> +    "1G",
> +};
> +
>   bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry)
>   {
>       if (GET_PTE_V(entry)) {
> @@ -155,6 +156,14 @@ bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry)
>       return false;
>   }
>   
> +void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb)
> +{
> +    for (uint32_t i = 0; i < tlb->num_entries; i++) {
> +        hexagon_tlb_dump_entry(hmp, tlb->entries[i]);
> +    }
> +}
> +#endif
> +
>   static inline bool hex_tlb_entry_match_noperm(uint64_t entry, uint32_t asid,
>                                                 uint64_t VA)
>   {
> @@ -377,13 +386,6 @@ int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
>       return -1;
>   }
>   
> -void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb)
> -{
> -    for (uint32_t i = 0; i < tlb->num_entries; i++) {
> -        hexagon_tlb_dump_entry(hmp, tlb->entries[i]);
> -    }
> -}
> -
>   uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb)
>   {
>       return tlb->num_entries;
> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
> index 242de06eaad2..12bcddd000bf 100644
> --- a/target/hexagon/hex_mmu.c
> +++ b/target/hexagon/hex_mmu.c
> @@ -107,11 +107,13 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
>       return hexagon_tlb_check_overlap(cpu->tlb, entry, index);
>   }
>   
> +#ifdef CONFIG_HMP
>   void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
>   {
>       HexagonCPU *cpu = env_archcpu(env);
>       hexagon_tlb_dump(hmp, cpu->tlb);
>   }
> +#endif
>   
>   static inline void print_thread(const char *str, CPUState *cs)
>   {
>

