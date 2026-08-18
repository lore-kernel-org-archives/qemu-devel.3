Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457F1C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQWq-0008RG-Uf; Tue, 18 Aug 2026 16:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwQWi-0008Ny-Ps
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:35:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwQWe-0004xr-4N
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:35:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJZY3G2586781
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nyi7sVDt/BLemwucOjma8srISQFBcZUB77EYg0daxS4=; b=n5uXpz6fxHeKsUFj
 93J0HZYmoPbr/NYr5AC4MjkQC5yq99ycValj2/hDJqRLABdfLVVMxuGxPtGLcCM+
 h2vPHwlt5a4x3jEnQWwMBVkbm2jtM+ho43jku+/vJwtVTOQ/jwE/1YrGYQsDhURu
 HR3fLNVRPo6U6SdQVGss5dK17Wzs7yXMNuHUXO4pOFEAOJXeXKlKPRByN75XJmKn
 /cdn6QMVVOy+Xys61FmfWCZpJp/g4BJdcRSVRg4rAyqpmXKYZ8pfjOi7UtM3msky
 Sv4mBTh4x7pQJGpAPdPDUxo9v4ktHx40a+Sdg2fOSy4IkiQCk5TiARGfCF7DhXgf
 sPPqKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uhd1061-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:35:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936d067836eso44325485a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787085310; x=1787690110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nyi7sVDt/BLemwucOjma8srISQFBcZUB77EYg0daxS4=;
 b=fD8gkdElazUtpzCsppW5TAW8psmhzzTBguCCvCNGXQHqeEtXwQy+ITPCyPrqvrL6jQ
 WTSOuEhulypvSsPcSeuOC7zUE7jNjXKDfx3iQr9lt9VImNJJShqRULK1//4OwJ273alN
 n4t1urhBF+hkzVvvReM5+nfLcE66SE4OTUNThmTr52vyARaTPjx7HczLWqxtxZ1zTvKG
 FOlu2yP9X7C9Li0c0wMAxBVABMPPZbtN4Z3JwDkaVlBCnvhgm6BzjMGm2+9GS977mfb5
 caS3ytvTj3IMPQUye++HMSh6pnVEpORelo+HLoRnBk9ch3U1WY+0z/O0uKhbkZGWqtlR
 qf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085310; x=1787690110;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyi7sVDt/BLemwucOjma8srISQFBcZUB77EYg0daxS4=;
 b=fDyV9rMNUM2oJ54a+smmvtK15ASXwnvM/T+sWWUKB3FQLyZDsguMP8+LMxNfsnKxmH
 pMvsmvoooGr0gM5EZZ9AqTZM9YaAB5q64eV0rVAJtutjFKC5WtrtpHjrhx8L8xMoEyNw
 0rjl71TOh1EniwB8uOEA/79j3mPIIJU9abC6cw0OsHa0oT9WfXr9RQ8Tg/IeHVRgH6wn
 uUAF8PmvznD48NmbKT3g9EuiXlDHvab3yB8EU8IpmlTaprn37X9UnI0XMgL3CtMfCJFx
 6zWtG/bqwV0OURDpLWmVvQne7j/J8ToyUMeSDj0YZDw02i19pfwuAtO4t8B42xO4HKGD
 2qpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSXFXSW6ELyKOOQ/l2EHdlHNjt3wH0P4sfjfe8Z5Kd3AXOBdwxoBg2Fy+xLba5ryZV+jV0XVc/pTN0@nongnu.org
X-Gm-Message-State: AOJu0YwLcSrrxKLVzm/mviARmjVRGTWNSXqYFnhUFB3AbmHk5Pb0Hk2P
 ZxsEE9+9mVvlHuGk+h/43oJWsmF4h1CAkCh/cJFcajBm8r8hyRBGhSGvKTgKoh3UDFVm6/epgyB
 R8/5isgWr2dklnedHO3eGKXKzM/JVncNwmcntVONl0kxFwmY2GglMGEb7sXgNKqlpPg==
X-Gm-Gg: AR+sD10E6qBuwNxwE8QqtUgmb4FA9OxDDKGjVgtQ7FXbc6st6y8OEo6RCZIGmJAOvCP
 MbpvUMQAIethLwD1KN+Oa8Z8W95SX7hOrrdrTLmvK1evc80nW5pUWQ0Buygr6kE8tG7wH1gU39Q
 b3bNPQS1u+GOIXcYtv+LqOxA35VPUQeRpOCBaxHR1PeA3pK3lkhMqHUbApDTsizPaHSGd3ogFSp
 KXd78DAatrTQ0/z9VO8VPSxqBUQZR5LK1kW4f1rJ696soyPGWs5cPaOsns8HKbN6ojD3tkfvplM
 QNXnTn/a+QrNPSn+MVTs8oEX3vjQ88gzmYZjvyqVU+3rvvEBWhQzkK+1Rx+DzwAGCcKN52A3Pef
 7fKmtjRk8Zl7RMW54OcN6vr/gurfJcBFXOuPxrkmPhodkuQxVU4l99KWToQ==
X-Received: by 2002:a05:620a:2985:b0:92e:5b45:b572 with SMTP id
 af79cd13be357-9371e2542a0mr4499085a.1.1787085310395; 
 Tue, 18 Aug 2026 13:35:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:92e:5b45:b572 with SMTP id
 af79cd13be357-9371e2542a0mr4495685a.1.1787085309934; 
 Tue, 18 Aug 2026 13:35:09 -0700 (PDT)
Received: from [10.96.27.162] (246.sub-174-224-21.myvzw.com. [174.224.21.246])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937034324d0sm378415785a.47.2026.08.18.13.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 13:35:09 -0700 (PDT)
Message-ID: <d1b4c236-a284-44bf-97e3-0062d56aefd2@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:35:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 38/49] hexagon: make dump_mmu() take MonitorHMP
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-38-e53fc35bc550@redhat.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-38-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX+7fDgeGd4ZxB
 UbEGiFxRPBpjE3LkZD2EsXG/rmbEgEx/c3Gkzw4v1xCmwP7qWLwvA7dFHbWuBvgDoVnkhPacgtZ
 5/RqbGBFK4I3TqmgUj/xpVqrg4BCyXVf6emwIfDdggIfUfRCC6rlzaGCyKMp3j9+KZ2vw0XYkWs
 gN+RBKpVV3xL0pvttiw/M6kChrZObbB2ZMRR9RGnx20gmCBGHZLw0LssBiUYN7sQUhyyKnb+jX8
 TxBDL6go0TB0/I8mNlXdUku7CDJdYRQ+Q1dK7FrP+b1PWdwcbz+DbjRNaUGLWh//WTnJz9HQvIy
 gol7mCIOMy2qu8lgEOizRfyxi30faFpRyDp7MRhbWKvUtcmI3ybx219m9xInJUp8PrYgeDgVVeh
 /iCspLFBgUc9aJgzz/OhrabUUpOqBzxyrRF3u2gRwUDoRLUg48B4smwkWPQ0Gqp2Pj0LJSV1FJG
 xwXfytHJ/v6bh3l4luA==
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a84c1ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=zpb6me6fL2PcLasmGntylA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=gc6DyLOaUzCWpx2KdV4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 3knAT5Yn-y5173yVim51PTlBpJOs9rEw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX4JrS7MM6hul5
 net0csPGqiF7zsxcbZtrAQYEZXsdYiPD2rfBBdQeiCaEjBS4GJglm6KviBVTuxVCXk9ReuxJO1S
 vO3fpaLbVW2gb1kyCiORHCseAlUbKf8=
X-Proofpoint-GUID: 3knAT5Yn-y5173yVim51PTlBpJOs9rEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
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
> Avoid unsafe MONITOR_HMP() casts.
>
> The function has no caller since its introduction and could
> be dropped if it is not wired to a HMP command.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   hw/hexagon/hexagon_tlb.c         | 8 +++-----
>   include/hw/hexagon/hexagon_tlb.h | 5 +++--
>   target/hexagon/hex_mmu.c         | 4 ++--
>   target/hexagon/hex_mmu.h         | 3 ++-
>   4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
> index 576929ff224b..584c606a22c5 100644
> --- a/hw/hexagon/hexagon_tlb.c
> +++ b/hw/hexagon/hexagon_tlb.c
> @@ -122,10 +122,8 @@ static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
>       return (uint64_t)GET_PTE_VPN(entry) << qemu_target_page_bits();
>   }
>   
> -bool hexagon_tlb_dump_entry(Monitor *mon, uint64_t entry)
> +bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry)
>   {
> -    MonitorHMP *hmp = MONITOR_HMP(mon);
> -
>       if (GET_PTE_V(entry)) {
>           uint64_t PA = hex_tlb_phys_addr(entry);
>           uint64_t VA = hex_tlb_virt_addr(entry);
> @@ -379,10 +377,10 @@ int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
>       return -1;
>   }
>   
> -void hexagon_tlb_dump(Monitor *mon, HexagonTLBState *tlb)
> +void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb)
>   {
>       for (uint32_t i = 0; i < tlb->num_entries; i++) {
> -        hexagon_tlb_dump_entry(mon, tlb->entries[i]);
> +        hexagon_tlb_dump_entry(hmp, tlb->entries[i]);
>       }
>   }
>   
> diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
> index 760dc1ea811b..c3f0fc599fdd 100644
> --- a/include/hw/hexagon/hexagon_tlb.h
> +++ b/include/hw/hexagon/hexagon_tlb.h
> @@ -12,6 +12,7 @@
>   #include "qom/object.h"
>   #include "exec/hwaddr.h"
>   #include "exec/mmu-access-type.h"
> +#include "monitor/hmp.h"
>   
>   #define TYPE_HEXAGON_TLB "hexagon-tlb"
>   OBJECT_DECLARE_SIMPLE_TYPE(HexagonTLBState, HEXAGON_TLB)
> @@ -37,9 +38,9 @@ uint32_t hexagon_tlb_lookup(HexagonTLBState *tlb, uint32_t asid,
>   int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
>                                 uint64_t index);
>   
> -void hexagon_tlb_dump(Monitor *mon, HexagonTLBState *tlb);
> +void hexagon_tlb_dump(MonitorHMP *hmp, HexagonTLBState *tlb);
>   
> -bool hexagon_tlb_dump_entry(Monitor *mon, uint64_t entry);
> +bool hexagon_tlb_dump_entry(MonitorHMP *hmp, uint64_t entry);
>   
>   uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb);
>   
> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
> index 81d64a6146cc..242de06eaad2 100644
> --- a/target/hexagon/hex_mmu.c
> +++ b/target/hexagon/hex_mmu.c
> @@ -107,10 +107,10 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
>       return hexagon_tlb_check_overlap(cpu->tlb, entry, index);
>   }
>   
> -void dump_mmu(Monitor *mon, CPUHexagonState *env)
> +void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
>   {
>       HexagonCPU *cpu = env_archcpu(env);
> -    hexagon_tlb_dump(mon, cpu->tlb);
> +    hexagon_tlb_dump(hmp, cpu->tlb);
>   }
>   
>   static inline void print_thread(const char *str, CPUState *cs)
> diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
> index 6aa450b94136..56b2c4a89d0c 100644
> --- a/target/hexagon/hex_mmu.h
> +++ b/target/hexagon/hex_mmu.h
> @@ -10,6 +10,7 @@
>   #include "exec/hwaddr.h"
>   #include "exec/mmu-access-type.h"
>   #include "cpu.h"
> +#include "monitor/hmp.h"
>   
>   extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
>   extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
> @@ -23,5 +24,5 @@ extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
>                                    uint64_t index);
>   extern void hex_tlb_lock(CPUHexagonState *env);
>   extern void hex_tlb_unlock(CPUHexagonState *env);
> -void dump_mmu(Monitor *mon, CPUHexagonState *env);
> +void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
>   #endif
>

