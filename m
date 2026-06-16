Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E37DCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYaQ-00024p-8h; Tue, 16 Jun 2026 14:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYaK-00023r-Rw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:32:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYaI-00060S-Ck
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:32:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOYRq331236
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2I54DYQOHkuEFYPbLbZRZfiUbmNK70LJOEQyteb7Lcg=; b=alL3fjRkCWzjndEN
 gL1T/h/AsBc/TbZlnx4nDHI+V0ucAvae9kP4nHpR+pzTuRoXDf94edgkf7xiMuc7
 6v/0KuCwB6v9FCYGyvLV/1jgokho2DalkD+D9XL5yqDW4Z02RHs8OZ4MypWpOQsb
 4VoB1kGpKC4H1R9pO7HvV6qnmj270x3rVHEIY/ywkiIk81QWhdjojnETudsmJ3vF
 sDN9qYsd8TVws2MmWkhT1otsG24hYBa4EMGc3/3GZK+xMEkW2VQGIwuM7AVRkBMJ
 NJMG57Xnvb27Ewmbc1iQ04bhlgs03TiZnGzcVv9wVW9tHdwcrfwTeyHwwtuPmDOk
 5XHTRA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09gbj3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:32:24 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13980b6561dso4160594c88.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781634743; x=1782239543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2I54DYQOHkuEFYPbLbZRZfiUbmNK70LJOEQyteb7Lcg=;
 b=Db5nkNrwef+cpeUaY9PUnQSvlRKWagZnz9khL+z5bPoUbP2XQl4jKNVTzpdshnRO9b
 m8cHHbHOomSyIVi2pIBRsFpP9Ks7gQ7taqHJtKcwv/kuHVI3o2gtRAFySqUhzs3mItXx
 5V+EquFYyPsZeoSAoSuPLq0bGRNcOajQcFQKzsfB34N7Y2YJZe6QItvUWLTvXHIgq/rH
 /gaGvG85v6l5FGfQp4hO9gGlDjhl+FaNpOKtDX7CKBv+RNSKw+8CktBUJ6kirhaI4sCU
 mJjFtCSWY4zh7YxfPeeHpC1dHaHSnAIMoGdkQ8FBxt5B+KgXelAoruayN/+tH/OZBEko
 OTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781634743; x=1782239543;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2I54DYQOHkuEFYPbLbZRZfiUbmNK70LJOEQyteb7Lcg=;
 b=Te3IqWZCu0BNnDO6ZSFGiQ2kL8Evs2P4DUp+JKV9wUOcoZ6gjtwdYv7txE1zldON05
 QWKRfe4z8L0RWkp6WEZZnADPZpo2aU/ESBf87c0FxHXLQNWDui+fPUBpcLq7NAa7p0oK
 gQltn9t916P6EMlQ7I73B2BaV9GZAymR9F7ERXuRNRTAgrLhgCuk1lvaAhPkAZzzkG+k
 yiIt7Z+QxC+1AIVf98amt2GSIPTnsNueT6aNkJaCHX+hIq8ivGgpkHU6I+as5MVZ+Fzf
 YK+k0s8yyaMqwLRj0hA4b/WrfRdZmvcQ5M9pIEEfiW871ETE7u6m0wP69muL6VhW4s+2
 vKaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TofWrmZYMzmyyFJVCrQcIPJbjOHCh/ea63yi2ySPTcIHdKXmeUWGuspORug+Xtvjk0uePjYy8p3Zw@nongnu.org
X-Gm-Message-State: AOJu0Yx8mShPoz72enjH8kpusDHCGDkqkUSAXgvN6TSWz69XZYRmp7dc
 ZCaoB5h0+H/rtEfANQzYceOi99vyfSQF7s7sV7qAznbPDUvW50X5ZMXsA0uW/tki2xhij9QBYva
 XDawMkAMpiEzfl8uO3vvuRaWkUH8Patw4pQos1L82P9QqkvBtyzDSbrlhnQ==
X-Gm-Gg: Acq92OGgOOBlssYEobseALn2WxZK40XfEHVc5ho85eZoDTOQ4+4CjQKhg2CBKC9agwv
 NC9AdMLAuzO1mgX8jLaPuQfkJtgzQPrbxaI9TS5eW1WzYcAFSmhv6TPJylJKan3p3PRWQ0wv7r5
 tffXwDu1tSgB7BKtBdpyUZqS9ZsV7Dfb6p8jzMnXXzLYKEta5qohcFoZFJ7gkM9lNtGy9tsvXyE
 qnTDdZSwgtSdUUXlwdupX1OyluYtVcHXqPpvsyVgF1eI8XSh1x0stKWdRtRJ2cDZiPDaZDmGKeZ
 WzRx8Tu72Hojz2tOIIEBtkq5x/L6al6xVanPOYiTPakAWPgTqMJarQYjt5CNN9ZEgk5j9dskcn0
 G3wA5MqSdB76HmOFOekI/2utHK9bWC4ZhSaMt/ejotOxZDgO/AS2HZBW67fMutEkdc1MCtcT3l9
 GH9hlsYyMszDmPgg==
X-Received: by 2002:a05:7022:ef13:b0:135:608a:2864 with SMTP id
 a92af1059eb24-1398f6fb088mr43330c88.33.1781634742846; 
 Tue, 16 Jun 2026 11:32:22 -0700 (PDT)
X-Received: by 2002:a05:7022:ef13:b0:135:608a:2864 with SMTP id
 a92af1059eb24-1398f6fb088mr43313c88.33.1781634742071; 
 Tue, 16 Jun 2026 11:32:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1386f20ad25sm12714118c88.0.2026.06.16.11.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 11:32:21 -0700 (PDT)
Message-ID: <15686e53-4cab-4739-8b32-334ae567cf47@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:32:20 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4OSBTYWx0ZWRfX9jy9IVYi6ZMc
 uFJDSUFh/5OCB4fF2EuyAqyNxtnKi1lyPjRrpKu9bY9cyfZRlgEtZnpB9xvz5cqQg3eVbsM/2oF
 rrZQndMZa2VcTtKdcy8SPNGI5gCx0sQylyyqBYboOV8qfI+9xzG7910svLmBFz+lACGVHz4mDoF
 L8rOeOGbO+ESNXM/8ZXfQsCFpwTduuhbB44o7IGthRRCiNuvzOKV2j5Hr5ePL/vgvKPEdE4F3kV
 lOdyTqFDnuysty+N7731r7A+56UYay3aIZ2Xu4DPAqOQHYHGvXZNrreKdf6NrSlK/weNVKinodv
 97e9CDiiLh5JN/GtK6YhmHfeA7B8Z4/w/UvJdz7C2yImyxPb18AMv/3sFZCFuOfRdKOPJVG1oIL
 Mcy6tTZDKmbt3+H9VE4GNS2U28fQp+O7Gnpdtkb2MeVNUpnS39mxADm6Qx+G9cAJ1Tgq3faChL3
 wuGspq74kD9xyqKrzVg==
X-Proofpoint-ORIG-GUID: aWr7KjIWtJaCmhfxBmBdMNOk_txcv9sh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4OSBTYWx0ZWRfXwsjYcY5Xc8wV
 SABe3iYjQPIOO7vopBchVp3oW+RWSH4WxavU+EuXfYyuIZQRQBEU8HjIP8pST/82OdiNNALKQOW
 gFHRrtXoOVm0nQOonwtj82AAaD8odVk=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a3196b8 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=OZcmDFxvAAAA:8 a=rRzZAERBmC2rzSdszuIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-GUID: aWr7KjIWtJaCmhfxBmBdMNOk_txcv9sh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160189
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Harry,

On 6/16/2026 9:12 AM, Harry van Haaren | OPENCHIP wrote:
> From: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
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

Welcome, and thanks for taking the time to contribute this!

It seems like there is no cover letter for your series, which is where
this paragraph should go ideally. Also, I think its presence is kind of
mandatory for tools manipulating it when having more than one patch, but
not 100% sure.

I recommend you to use git-publish
(https://github.com/stefanha/git-publish) which does the right thing out
of the box and make sure your series looks like any other. Yet another
tool, sorry, but at least it's one of the "standard" here.

For the rest, I'll comment inline on the patches.

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

