Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9411DC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rev93-0001Nw-4m; Tue, 27 Feb 2024 05:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rev90-0001NZ-NS
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:57:08 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rev8y-0004I0-Kj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:57:06 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e43ee3f6fbso3707132b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 02:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709031422; x=1709636222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wDjOtd7wZa57IfACqE7dRgmQo+uMNM1V1VRYq5Oj+eU=;
 b=DkrU/4sXj7RR6d7jM0HGfWWiskylleC3IOmf0w9vS4Zo92RChuX8OzIqym2/pYmDMD
 4QOwaDk5TgW2gHiE+tqS1yeOg50MJ15yZnbLeF7/JTr/8QPL0vRszo2e/b5DQpgqVhTA
 pHIpQh6ShJDPNHjSZA6h3vxY6oPpCnJUjsx/A5V5mCRuPq5Qk2FiKyy2GCno3EHn7dA/
 Rc50U7m0aK4UC9qDC8Ugv9IwBMQ5PPYB3Q2NV7mq5n4Ex5hWqy37UooVkI/WvVADNoKb
 qAarda4T9PuIm/UFwg8ZEbzKnUsw6p08x8AEZSEgvMMRqw1Zg0W7BSyg3KdyUQzqTnad
 tmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709031422; x=1709636222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wDjOtd7wZa57IfACqE7dRgmQo+uMNM1V1VRYq5Oj+eU=;
 b=FOY6JhUuHhRtmn+WWXGaRObdjfsPNcCCxhd05T7rAaEgXHW/AZjaJQyGrP9+cW+fy8
 vv7HhxxjNLhHdIadL/PdQpITq1l2F8Cmzy9c0Icp8J7505a0mHn5za6YOHFKxl18r6Bl
 XJck34ieIJWFZpBvPygbHo5DFhaIGWkZKgD3YEzopM720wDflwIrrFh/YnbfeVe61R/P
 Tu9NgdyGLC7ah/lixTZ4iS8TsVYYpem29vwcxJL0QuqIG5pYAD26DXUg2cdmnYdUsEaI
 e00llIEM0OWb1/SZFgmabRILEUfkDZDbBFQZkEJplw4Z8DX0GHNtvYQT1mbg8yA77rFU
 wk1g==
X-Gm-Message-State: AOJu0Yyj7+4a37pU5BH3fyqVO+ptdAC3xoh7U5S+aiQVLAljz1uHBVG5
 ivXpimi6BuFinFmpaf0MIhShMFKYjCIqs5KCbGmDpRuwSKYM+ntS+oRV+gwNXgI=
X-Google-Smtp-Source: AGHT+IHx0+SdoPaDxMK8eWZpRUskghhsPcB0McSD+Vkw6cU2Ggvn4p+oj2Tb5iOOETEsqMexspci6g==
X-Received: by 2002:a62:6307:0:b0:6e1:338d:e01c with SMTP id
 x7-20020a626307000000b006e1338de01cmr9134058pfb.1.1709031422568; 
 Tue, 27 Feb 2024 02:57:02 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 y10-20020aa79e0a000000b006e4de4f663asm5611813pfq.193.2024.02.27.02.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:57:02 -0800 (PST)
Message-ID: <354a01af-c2e2-4f24-80a5-158547015805@linaro.org>
Date: Tue, 27 Feb 2024 14:56:50 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Zd2sxjxegajy7ZbF@luc-work-vm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Luc,

On 2/27/24 1:35 PM, Luc Michel wrote:
> Hi Pierrick,
> 
> On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   tests/plugin/mem.c | 40 +++++++++++++++++++++++++---------------
>>   1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
>> index 44e91065ba7..d4729f5e015 100644
>> --- a/tests/plugin/mem.c
>> +++ b/tests/plugin/mem.c
>> @@ -16,9 +16,14 @@
>>
>>   QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>
>> -static uint64_t inline_mem_count;
>> -static uint64_t cb_mem_count;
>> -static uint64_t io_count;
>> +typedef struct {
>> +    uint64_t mem_count;
>> +    uint64_t io_count;
>> +} CPUCount;
>> +
>> +static struct qemu_plugin_scoreboard *counts;
>> +static qemu_plugin_u64 mem_count;
>> +static qemu_plugin_u64 io_count;
> 
> I see that you merged inline and callback counts into the same variable.
> 
> I wonder... For this test don't you want to keep a plain uint64_t for
> callback counts? I have the feeling that this test was made so one can
> make sure inline and callback counts match.
> 

Indeed, the new API guarantees thread safety (current inline 
implementation was racy), so this plugin now gives the exact same result 
whether you use inline ops or callbacks. In more, callback based 
approach can be implemented without any lock, as we are counting per 
vcpu. Thus, it's faster and safer.

Regarding the "testing" side, this series introduce a new plugin 
tests/plugin/inline.c that allows to test all thoses cases in a single 
plugin. Thus, it's not needed that other plugins offer a way to test this.

Thanks for your review.

> Luc
> 
>>   static bool do_inline, do_callback;
>>   static bool do_haddr;
>>   static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
>> @@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>   {
>>       g_autoptr(GString) out = g_string_new("");
>>
>> -    if (do_inline) {
>> -        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inline_mem_count);
>> -    }
>> -    if (do_callback) {
>> -        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\n", cb_mem_count);
>> +    if (do_inline || do_callback) {
>> +        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
>> +                        qemu_plugin_u64_sum(mem_count));
>>       }
>>       if (do_haddr) {
>> -        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
>> +        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
>> +                               qemu_plugin_u64_sum(io_count));
>>       }
>>       qemu_plugin_outs(out->str);
>> +    qemu_plugin_scoreboard_free(counts);
>>   }
>>
>>   static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>> @@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>>           struct qemu_plugin_hwaddr *hwaddr;
>>           hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
>>           if (qemu_plugin_hwaddr_is_io(hwaddr)) {
>> -            io_count++;
>> +            qemu_plugin_u64_add(io_count, cpu_index, 1);
>>           } else {
>> -            cb_mem_count++;
>> +            qemu_plugin_u64_add(mem_count, cpu_index, 1);
>>           }
>>       } else {
>> -        cb_mem_count++;
>> +        qemu_plugin_u64_add(mem_count, cpu_index, 1);
>>       }
>>   }
>>
>> @@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
>>
>>           if (do_inline) {
>> -            qemu_plugin_register_vcpu_mem_inline(insn, rw,
>> -                                                 QEMU_PLUGIN_INLINE_ADD_U64,
>> -                                                 &inline_mem_count, 1);
>> +            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>> +                insn, rw,
>> +                QEMU_PLUGIN_INLINE_ADD_U64,
>> +                mem_count, 1);
>>           }
>>           if (do_callback) {
>>               qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
>> @@ -117,6 +123,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>           }
>>       }
>>
>> +    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
>> +    mem_count = qemu_plugin_scoreboard_u64_in_struct(
>> +        counts, CPUCount, mem_count);
>> +    io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
>>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>       return 0;
>> --
>> 2.43.0
>>
>>
> 

