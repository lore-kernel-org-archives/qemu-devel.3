Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BDBCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYhR-0003OT-Q5; Tue, 16 Jun 2026 14:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYhM-0003O3-Ks
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:39:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYhE-00081F-Ce
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:39:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOdVK2544013
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o86u1uhZthcQzAC2kG+dfGxVuI/fvL3x4jETWidNciY=; b=N68bp4MxKqt4OHOh
 PaPLvzHjPDxtBJcn5j7qb2V6Xospw38aACVWBOPTESoPFoAhrR046SOBNq0qLrvc
 Kc6epRAPM+T3KvmFKr2+k9ER3myBxySNyPai71FjTe6cjKqdzWtIaXfiFtcP43C2
 vqMWFJmbsnoP3WsSzKITC5FSrYo5yrSOnHO4FvoR6D9A+XrPhSItxASMRAj0iAWL
 fZ+cybecyFKPwusTm7d37Mi9cfZXjfc57qhFboMOiXXIkyDwKFEi/qpZvEfullee
 oNUyRh6mN6EWYU6IE9kuQgKDaK7nLMriYNYEEb7PocJ6IoUZxPA1xJSGy0YSFjBE
 Xyzwhw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu3ct2ppf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:39:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so582376eec.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635170; x=1782239970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o86u1uhZthcQzAC2kG+dfGxVuI/fvL3x4jETWidNciY=;
 b=GiWmFvzPMbhkq/wOOP7VDH4DSpSROxtutohFS9lkDLB51CRHL7YcqoWxbI3MUMnXhf
 FcewwzM1XhUVQxjfLloz5X34hZ65EPkS3bMV9kfOizv6725oaxm0OTmSLqPzLVWTm0UZ
 QwYlQPPCnn3OkApJrcpibdhyPcl3uBoPa0vciS7HjMVtQVAlWWPOMANqMd2yTxMh7U7x
 3ILqDAZTuQSdsmaa1XcDhNtGAsHxXpICBEvnRAN/2uwlvJjm5H7ov4Q54TU9VCLA6IjR
 Vccd8EE+o+D75zApON4krlOpg0/WEcMEfUmzZuhrbFpAU9izhrC4T6wRijZ7izLh08b+
 93zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635170; x=1782239970;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o86u1uhZthcQzAC2kG+dfGxVuI/fvL3x4jETWidNciY=;
 b=Z/0XLlZYt+OwDqmoAmKWfp7OGZp/P6JVARTK6tccXL87l8aC8rcOnP+soGicWxSoRa
 lcnYB0mg8DZlp3e3RwY7m2bXSXqBlhlOt5osNznBRXqK+2g5xlscSAJCfrHF4tvIzlpU
 w3DF3JLTFr2RyRCAm5pTa7lek1swcZpQJjZnrPWihnDDjpBruDLRDrShWXrKRJUmb1CD
 HojXQQPsXq0qjj60+gADeAW+3TRcCor7hzzrwmHtcwc682UBJjxHBJFABNX7Traxc8um
 84x0uvlFMVdIUAgJ9CkIsI1Ir7IUcThakmythWisuvCl1wdjhomLm+AdostsEPbA8DPX
 a/qw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oKA6hCNp6pqrrfnb3N7TaOwSgnBsQEr0KXjR2IwqSxw32uG8OzVhYPZ/oHukH8ro/AwpgPh5TAjIW@nongnu.org
X-Gm-Message-State: AOJu0YzXNkykc3bfu+ZpN2PF30+MfRHWn5FBKTsktrgDggeepk/g+k7F
 Rxuz6F4dG6aQPUdE6cBud2uXU3CMrNHqrJlyqPDyw6DYlTJs7bNJqof1x+BAL69hDcqegU73r4c
 hVxMFzpTzw8nvYgP4QgEpk2YTgjUgasbW6gxK4CZVQyEPxFpFmFacJcYx2g==
X-Gm-Gg: Acq92OHAmO8ZvfSL4TZJHLUDg3KY87UbwB5N9nCGeODK9jCJ4qk5gfWBKhzz5ryqqD2
 Y41nwYSTlgYyMt1LYJOE0krgCqo5aahmuceyETI7IfWiKsaR0V9N+NQWnChOG/d0BwuB9EV9zOG
 gDICfuDH1Levg4j6aSuuBaEhvaDvZvshu3MsbosZQwdQEDkRhZpMjoMYaprRm4OP4tEKmlGvb9R
 CtcfRSSg/Li0NcV34KdDeBgcSz5b3KMRlY90Ytkdtw9V8inVXUBr+bBFE26LRH6xyVg9/u/vkMO
 +Hv6oYuHr1RMbkCEXnbuYDob3OTHd6AmU25JszhNvIHzesqlFUqdebec4NuHlLMKTH1HWiTYNOw
 OGWwF6mv+g3aK+buiU3vlItcAx0/eDH43oBWFPJ2U9TUYEf9FOdCdcyJw90v+GGzvKNaJX+2oWV
 1Rfchoc+RBqeN8Tg==
X-Received: by 2002:a05:7300:5b9f:b0:30b:b316:c685 with SMTP id
 5a478bee46e88-30bcae07504mr273050eec.22.1781635169741; 
 Tue, 16 Jun 2026 11:39:29 -0700 (PDT)
X-Received: by 2002:a05:7300:5b9f:b0:30b:b316:c685 with SMTP id
 5a478bee46e88-30bcae07504mr273025eec.22.1781635169171; 
 Tue, 16 Jun 2026 11:39:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bbcb11310sm2113793eec.14.2026.06.16.11.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 11:39:28 -0700 (PDT)
Message-ID: <ab967bbb-7961-4450-bdb9-06b9db905d2d@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:39:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
To: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a319862 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=OZcmDFxvAAAA:8 a=rRzZAERBmC2rzSdszuIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-GUID: zNaw82FR6T6j_Bf9iaYj66ixRYjZ6r_T
X-Proofpoint-ORIG-GUID: zNaw82FR6T6j_Bf9iaYj66ixRYjZ6r_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX4CtqHPJbW3IY
 KR5Ok2rxE95RPo45OgLv+1mksKuv3yqZPrK10NYAUhvHkfVyHfGpPZesTm3r4I3+RcXS49Vj2rd
 vOkUsr5jUdjYPwzfg9n6hCp0xJMp6RjoNmkU8aToZv4MSIU39tSTvNu7P9eJY8S19SEXzgarenm
 KRna/k+Bo2EyO/huN2tJnzLxNaEggWySwRJLzS3W8BSYtAqK1ZrZ8OJvrX94Frwsef04H8BvZLO
 kTaYb5+FAqs36Ad2108IdQZjLFOAZeY3pkNqGrN5dESxgd1UepmFQ5ft4RhV4TXwS3AmVwI5c72
 dsnl5Z7ivXA6moKts6+cxeY4lJDUYKDgqxQz55LKAzavgSgp9Am3rlBM34uPt3hvDcsgIDOVvFo
 iNG0Ml2hVgIq9XDfPU8FSvuNPODcmk59T1Tjpycr58vzbz5EgFwH5Hd79hrn2dvLrS0HzeiJRM+
 +pVOyoatkCiCWJXeGEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX1+Px7OwpzVkt
 RjzbPNChBVy6w7YjBUWhxzBI/Aymb0hwsmSSdyJmYinGs+kwv1XkQDUmq13u33iToZQ4ZacdLel
 okC6E0BfjoEfQarH+ZUmlwOYWeAPZ2o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160190
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

On 6/16/2026 9:12 AM, Harry van Haaren | OPENCHIP wrote:
> From: Harry van Haaren <harry.vanhaaren@openchip.com>
>

No needed for this From: tag since you are already the sender and have a
signed-off-by.

> The existing code in execlog was never upgraded to the Scoreboard
> API, resulting in a bespoke implementation of per-vCPU datastructure
> handling. This had some race-conditions, and causes segfaults with
> a simple multi-threaded program and two instances of execlog running.
> 
> The patch here refactors the custom GArray and GRWLock code away, and
> uses the scoreboard APIs like the other plugins. This solves the
> "printing while expanding" race-condition of two plugins with multiple
> threads in the guest, and hence fixes a segfault.
>

Great!

> Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
> ---
> 
> Hi Qemu-Devel!
> 
> This is my first contribution to QEMU itself, but I have worked on
> DPDK, OVS, and QEMU-RS a bit in the past. I have experience with
> mailing lists for patches and some QEMU internals. I've read the
> 'submitting a patch' guide, and ran checkpatch... so basics should
> be OK I hope!
> 
> Please note that LLMs were used to investigate and fix this bug,
> but all code in this patch has been reviewed by me, and I believe
> it to be a good solution.
> ---
>  contrib/plugins/execlog.c | 65 +++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 40 deletions(-)
> 
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index d00d9c4ff3..e51af9f2df 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -31,33 +31,28 @@ typedef struct CPU {
> 
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
> -static GArray *cpus;
> -static GRWLock expand_array_lock;
> +/*
> + * Per-vCPU state stored in a qemu_plugin_scoreboard. The scoreboard manages
> + * per-vCPU storage automatically, eliminating the need for manual array
> + * growth, locks, or pointer-stability workarounds.
> + */
> +static struct qemu_plugin_scoreboard *cpus;
> 
>  static GPtrArray *imatches;
>  static GArray *amatches;
>  static GPtrArray *rmatches;
>  static bool disas_assist;
>  static GMutex add_reg_name_lock;
> +static GMutex execlog_output_mutex;

QEMU log already has some locking mechanism, you just need to make sure
you output everything in a single call at a time if you want atomicity.
To help with string manipulation, you can use a GString to build a
message. (see other plugins, it's a common pattern).

So you can remove this mutex and code associated, and make sure you have
a single call to qemu_plugin_outs in every function.

>  static GPtrArray *all_reg_names;
> 
> -static CPU *get_cpu(int vcpu_index)
> -{
> -    CPU *c;
> -    g_rw_lock_reader_lock(&expand_array_lock);
> -    c = &g_array_index(cpus, CPU, vcpu_index);
> -    g_rw_lock_reader_unlock(&expand_array_lock);
> -
> -    return c;
> -}
> -
>  /**
>   * Add memory read or write information to current instruction log
>   */
>  static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
>                       uint64_t vaddr, void *udata)
>  {
> -    CPU *c = get_cpu(cpu_index);
> +    CPU *c = qemu_plugin_scoreboard_find(cpus, cpu_index);
>      GString *s = c->last_exec;
> 
>      /* Find vCPU in array */
> @@ -117,7 +112,7 @@ static void insn_check_regs(CPU *cpu)
>  /* Log last instruction while checking registers */
>  static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
>  {
> -    CPU *cpu = get_cpu(cpu_index);
> +    CPU *cpu = qemu_plugin_scoreboard_find(cpus, cpu_index);
> 
>      /* Print previous instruction in cache */
>      if (cpu->last_exec->len) {
> @@ -125,8 +120,10 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
>              insn_check_regs(cpu);
>          }
> 
> +        g_mutex_lock(&execlog_output_mutex);
>          qemu_plugin_outs(cpu->last_exec->str);
>          qemu_plugin_outs("\n");
> +        g_mutex_unlock(&execlog_output_mutex);
>      }
> 
>      /* Store new instruction in cache */
> @@ -138,7 +135,7 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
>  /* Log last instruction while checking registers, ignore next */
>  static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
>  {
> -    CPU *cpu = get_cpu(cpu_index);
> +    CPU *cpu = qemu_plugin_scoreboard_find(cpus, cpu_index);
> 
>      /* Print previous instruction in cache */
>      if (cpu->last_exec->len) {
> @@ -146,8 +143,10 @@ static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
>              insn_check_regs(cpu);
>          }
> 
> +        g_mutex_lock(&execlog_output_mutex);
>          qemu_plugin_outs(cpu->last_exec->str);
>          qemu_plugin_outs("\n");
> +        g_mutex_unlock(&execlog_output_mutex);
>      }
> 
>      /* reset */
> @@ -157,12 +156,14 @@ static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
>  /* Log last instruction without checking regs, setup next */
>  static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
>  {
> -    CPU *cpu = get_cpu(cpu_index);
> +    CPU *cpu = qemu_plugin_scoreboard_find(cpus, cpu_index);
> 
>      /* Print previous instruction in cache */
>      if (cpu->last_exec->len) {
> +        g_mutex_lock(&execlog_output_mutex);
>          qemu_plugin_outs(cpu->last_exec->str);
>          qemu_plugin_outs("\n");
> +        g_mutex_unlock(&execlog_output_mutex);
>      }
> 
>      /* Store new instruction in cache */
> @@ -378,21 +379,10 @@ static GPtrArray *registers_init(int vcpu_index)
>   *   - last_exec tracking data
>   *   - list of tracked registers
>   *   - initial value of registers
> - *
> - * As we could have multiple threads trying to do this we need to
> - * serialise the expansion under a lock.
>   */
>  static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>  {
> -    CPU *c;
> -
> -    g_rw_lock_writer_lock(&expand_array_lock);
> -    if (vcpu_index >= cpus->len) {
> -        g_array_set_size(cpus, vcpu_index + 1);
> -    }
> -    g_rw_lock_writer_unlock(&expand_array_lock);
> -
> -    c = get_cpu(vcpu_index);
> +    CPU *c = qemu_plugin_scoreboard_find(cpus, vcpu_index);
>      c->last_exec = g_string_new(NULL);
>      c->registers = registers_init(vcpu_index);
>  }
> @@ -402,16 +392,15 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>   */
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
> -    guint i;
> -    g_rw_lock_reader_lock(&expand_array_lock);
> -    for (i = 0; i < cpus->len; i++) {
> -        CPU *c = get_cpu(i);
> -        if (c->last_exec && c->last_exec->str) {
> +    int n = qemu_plugin_num_vcpus();
> +    for (int i = 0; i < n; i++) {
> +        CPU *c = qemu_plugin_scoreboard_find(cpus, i);
> +        if (c->last_exec && c->last_exec->len) {
>              qemu_plugin_outs(c->last_exec->str);
>              qemu_plugin_outs("\n");
>          }
>      }
> -    g_rw_lock_reader_unlock(&expand_array_lock);
> +    qemu_plugin_scoreboard_free(cpus);
>  }
> 
>  /* Add a match to the array of matches */
> @@ -452,12 +441,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                             const qemu_info_t *info, int argc,
>                                             char **argv)
>  {
> -    /*
> -     * Initialize dynamic array to cache vCPU instruction. In user mode
> -     * we don't know the size before emulation.
> -     */
> -    cpus = g_array_sized_new(true, true, sizeof(CPU),
> -                             info->system_emulation ? info->system.max_vcpus : 1);
> +    /* Initialize scoreboard to cache per-vCPU instruction state. */
> +    cpus = qemu_plugin_scoreboard_new(sizeof(CPU));
> 
>      for (int i = 0; i < argc; i++) {
>          char *opt = argv[i];
> --
> 2.54.0
> 
> 
> 
> The content, data, and any attached documents to this email are addressed exclusively to the addressee and are confidential and/or may be subject to a non-disclosure agreement. Any use, forwarding, disclosure, and/or copying, in whole or in part, without authorization is prohibited. If you have received this email in error, we apologize and, please notify the sender or Openchip immediately, and delete it from your system.
> 
> El contenido, los datos y cualquier documento adjunto a este correo electrónico están dirigidos exclusivamente al destinatario y son confidenciales y/o pueden estar sujetas a un acuerdo de no revelación. Está prohibido cualquier uso, reenvío, divulgación o copia, total o parcial, sin autorización. Si has recibido este correo por error, te pedimos disculpas y agradecemos que lo notifiques de inmediato al remitente o a Openchip, y lo elimines de tu sistema.
> 
> El contingut, les dades i qualsevol document adjunt a aquest correu electrònic estan dirigits exclusivament al destinatari i són confidencials i/o poden estar subjectes a un acord de no revelació. Està prohibit qualsevol ús, reenviament, divulgació o còpia, total o parcial, sense autorització. Si has rebut aquest correu per error, et demanem disculpes i agraïm que ho notifiquis d'immediat al remitent o a Openchip, i l'eliminis del teu sistema

Regards,
Pierrick

