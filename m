Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958B7CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 01:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEzW4-0002CY-K3; Thu, 08 Oct 2026 21:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEzVA-00027v-HD
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 21:34:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEzV6-00073u-Qf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 21:34:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990PwZV1348616
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 01:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ePqhMWHgzW0fB1/f5d45ETtC64GzdeYph9diEtnD1AE=; b=Tlt7sIRn8xSoRhIB
 T0cSAn0KQT8gB72Wki5FXYdEgCwwTAZdYSszLmKIY/aSne1LD6WtCuRcebenNJGT
 xqZ5cFZS4soj/4zjSnFF3fKIIyXhQb9FK4RX20GzlPHqYjv3aMZW5uhv1bl15Hbe
 Ckswq6StooMoo1f4S9fjZcNsWk+7CdDuIbsiA71xsx4s00aVSEfWomzbnC6pCOQW
 pNd3E8YDgkO2AxwuW7/SbB92B1MG7YX5iLTOYV6vZoLVbZNV9UalFwSugwXuDGVq
 Ew4gI7Gs94C+hyiksPwcoMahQs6rv6St5tpi0SzAm6QpambwjPS0J88eoSaGTBBn
 jhtJwg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxw9brb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 01:34:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso332479885a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791509656; x=1792114456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ePqhMWHgzW0fB1/f5d45ETtC64GzdeYph9diEtnD1AE=;
 b=E4KNeqpJcBVHL+It5IyT0+uH7iHctjxMo0kfapS385VnBc2md3aK/aBbK1sIpWvlmP
 9RbnaThaecXRI8dN1kA83ILa0rzxjZYpnWDm1HrqDIKzPHyvExRNorI3jeYm7Y9eC7Ot
 0HTojMajSl7uX33KrXou6zI9u+f2rTDyUkJHv7Ovk87YKhpLav0JlyjGldnTjX58HIq4
 vp8JU7LixBaLeFxdFlIXuBdxfYsc109/i2sHe9fAXupgz9WXolZh39eSEtgkFUcVMXz+
 aXZVjvMXtX8NhmPSTFWENGbv6PCT3BPiDakJMrnIgu7SOitNA7bmbvyaDhmXGycVZZMr
 kp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791509656; x=1792114456;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ePqhMWHgzW0fB1/f5d45ETtC64GzdeYph9diEtnD1AE=;
 b=oCY0QKcb//Rvb2RNnF8XQdW6hUJSyOmcWFHj28jDnLT7fCymtkC6rckmjDy+UcC3By
 X5DH9VQFHLtp4dNUAnRuUJdioZrOqxOBDELs3hSlm8FbvmoqQvBbIj11Ha/hPSmt76WE
 qkb20y8uLR8kaHamFSVIiRQgKbbxdFs31n9wTH4l2CpXQS6Wqe+sibMXpg6G0i8UIhPU
 5TS9lrW5hv3t7zSdjeEAri3VXW4a1gqZLSGwJwFT6NCfJXB+lx9tVeH477pkWj36JspP
 zlQOAowxPRU3S3SCxOKg0FiBG4KjKU6kEjuddZRyJcrshnXZysfIX7NCsJizqClbKGSg
 nTNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBysVX1n1FlZ28pf3IexmWi6Lhgqs3ZzHgzMs6mzzEgq1oVbDxS48dFnuLdw6SCdnNeWNckBbfgJzAzd@nongnu.org
X-Gm-Message-State: AFuF++mVeWQScKTxnT5ZmnvZlL03zCpj4z5uMlLzBhWaJTArzFjin4Qo
 UZ09QUyPUNNkEET3iGzipQNVHyWGYQRcRcHM2pIAuy9mZyHMxfYRm9jPQH7l4K78ND5ti1Dd0Ue
 y0L0xjH9ciCyx+CH+J/dlBDTvf0m3OF454vIw7XKlZGIwnJV8YIheDYEaOw==
X-Gm-Gg: AYBFou3Op8PNgcyIYnvcpkYLnGHj3Dh19flFXEh419559O04CCaS3SS4LxpSSVCePoM
 iPkfwwSCALfn+qRUdKrthkHPKhJiVhhPOL6+9iCtDTNDMq53z/Lqydvx5Gzcv68QbPANS1/d5vs
 R0XXuQdaPm2Gmwq4hJ96c3+uJHsiHhVLlCV4UHBFu+O7mvg4Q/bFs9P3uPyXHksw+l3krMZUQGn
 RzU5X2wONjbAPycyaD5kDJThw7uoGhaBe9+oWVK/acO3vnHp/P8uV8IKPriW4ns2scTsLAPMLVt
 gdWZFEzjM4qdiSgjvwEZiMDdQot+0Pn6fVzD1Qw8rQOmqcJbnQr4ILQXIm7aSlsv2Ixi5ZxlUpW
 rvs1Ljaet4/k5f7a9GL2PnM83Xrws9PHsWPSNDrs16H+HKjkAAU2HHbhnNQ==
X-Received: by 2002:a05:620a:468d:b0:93c:b895:6109 with SMTP id
 af79cd13be357-93eb95e2a74mr142282385a.9.1791509655999; 
 Thu, 08 Oct 2026 18:34:15 -0700 (PDT)
X-Received: by 2002:a05:620a:468d:b0:93c:b895:6109 with SMTP id
 af79cd13be357-93eb95e2a74mr142280785a.9.1791509655507; 
 Thu, 08 Oct 2026 18:34:15 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-237-68.myvzw.com. [174.237.68.16])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb98ff9d8sm69088185a.44.2026.10.08.18.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 18:34:13 -0700 (PDT)
Message-ID: <93f4c7a9-26af-461e-9acb-e333c170940b@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 20:34:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/27] target/hexagon: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-7-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261007094516.75732-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfX9onCf/FZiaSi
 JtQvZQYKHo/yrjQhEmaPYKGpk2Sz15magu4LfyOOobktcu/fDIYBBteKg6vSiv2lrwsaKkux7zf
 jgFfCRnfPXIAuMsc+qVayN1ye/p2ULNCV6X9ziaBDsF0cbopm8L0XNDHJ+yvGU3FW+jbMXacCB9
 KDAiU01lfMjhu4vnreiGlmFH6zPoZcSalpnH628aXdMp2ah9sQTTN3sleBmqcfWs+tcn/Ce+Wtw
 fPOVzgkBsRMdRY1TniqYRXgltEsB4s+BEli7CEcI8ASfKLLAnVpUnj3kKEn3V3xyr4QHS+IL2b7
 qc6NzdeYSa9s1RcWwOQTyN6gznhP3e6sxt1v765TTrpvEZZI7WWZeyVuUSrTHlQODxdCpigL0HV
 IaSg6OVBnEbm9WG1FRAMT6br/BMRm8/qqCOxliymArassOKam6IrMI9A15GHLfEwUuLrDEz7ixD
 NYrTBkkil5mUJhQkBdQ==
X-Proofpoint-GUID: 0DFino2qMZ_ZlnQgvqLr3IMqmYbLv6R5
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac84499 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=cMASl6d0ORhCJ5zpoWum5g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ag6_fPei2S2tsqvut3wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfXzDD4eUpshw0f
 DhUZk9gZ9TbflmBAMP3YAp4KuyVmXEAwEpeCFfntiq5+FDYZTPZlZE3O0CsZiMu+Z3bhk+BndAU
 Bk8RYW0hZUNiYCB7g73wXzQTL5BosLk=
X-Proofpoint-ORIG-GUID: 0DFino2qMZ_ZlnQgvqLr3IMqmYbLv6R5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/7/2026 4:44 AM, Philippe Mathieu-Daudé wrote:
> Expose the hexagon event_name[] array via a hexagon_event_name()
> helper and register it as the CPUClass::exception_name() handler,
> so the common exception logging can resolve Hexagon exception
> codes to names.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/cpu_bits.h |  2 ++
>   target/hexagon/cpu.c      | 37 +++++++++++++++++++++++++++++++++++++
>   target/hexagon/hexswi.c   | 30 +-----------------------------
>   3 files changed, 40 insertions(+), 29 deletions(-)
>
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index a8fba4aa188..7d1bdfcbc71 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -61,6 +61,8 @@ enum hex_event {
>       HEX_EVENT_INTF = 0x1f,
>   };
>   
> +const char *hexagon_event_name(int event);
> +
>   enum hex_cause {
>       HEX_CAUSE_NONE = -1,
>       HEX_CAUSE_RESET = 0x000,
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 1f7d8a8df70..be286b1f2ee 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -318,6 +318,42 @@ void hexagon_debug(CPUHexagonState *env)
>       hexagon_dump(env, stdout, CPU_DUMP_FPU);
>   }
>   
> +const char *hexagon_event_name(int event)
> +{
> +    static const char *event_name[] = {
> +        [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
> +        [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
> +        [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
> +        [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
> +        [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
> +        [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
> +        [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
> +        [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
> +        [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
> +        [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
> +        [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
> +        [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
> +        [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
> +        [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
> +        [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
> +        [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
> +        [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
> +        [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
> +        [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
> +        [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
> +        [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
> +        [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
> +        [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
> +        [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
> +        [HEX_EVENT_INTF] = "HEX_EVENT_INTF",
> +    };
> +
> +    if (event < 0 || event >= ARRAY_SIZE(event_name) || !event_name[event]) {
> +        return "unknown";
> +    }
> +    return event_name[event];
> +}
> +
>   static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       cpu_env(cs)->gpr[HEX_REG_PC] = value;
> @@ -826,6 +862,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = hexagon_cpu_class_by_name;
> +    cc->exception_name = hexagon_event_name;
>       cc->dump_state = hexagon_dump_state;
>       cc->set_pc = hexagon_cpu_set_pc;
>       cc->get_pc = hexagon_cpu_get_pc;
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index 4705e915aea..be366d7a373 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -729,34 +729,6 @@ static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
>       env->gpr[HEX_REG_PC] = evb | (exception_index << 2);
>   }
>   
> -static const char *event_name[] = {
> -    [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
> -    [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
> -    [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
> -    [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
> -    [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
> -    [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
> -    [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
> -    [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
> -    [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
> -    [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
> -    [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
> -    [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
> -    [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
> -    [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
> -    [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
> -    [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
> -    [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
> -    [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
> -    [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
> -    [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
> -    [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
> -    [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
> -    [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
> -    [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
> -    [HEX_EVENT_INTF] = "HEX_EVENT_INTF"
> -};
> -
>   void hexagon_cpu_do_interrupt(CPUState *cs)
>   
>   {
> @@ -769,7 +741,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
>       qemu_log_mask(CPU_LOG_INT,
>                     "\t%s: event 0x%02x:%s, cause 0x%" PRIx32 "(%" PRIu32 ")\n",
>                     __func__, (unsigned)cs->exception_index,
> -                  event_name[cs->exception_index], env->cause_code,
> +                  hexagon_event_name(cs->exception_index), env->cause_code,
>                     env->cause_code);
>   
>       env->llsc_addr = ~0;

