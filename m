Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AA3FD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdZ4-00036H-QK; Thu, 26 Feb 2026 10:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vvdYr-00035W-OJ; Thu, 26 Feb 2026 10:46:06 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vvdYo-0000rf-B4; Thu, 26 Feb 2026 10:45:57 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC30qimaqBpvMeIBw--.4S2;
 Thu, 26 Feb 2026 23:45:42 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.232.133])
 by mail (Coremail) with SMTP id AQAAfwBXruukaqBpRHsdAA--.36559S2;
 Thu, 26 Feb 2026 23:45:40 +0800 (CST)
Message-ID: <2391877e-4346-48bf-848d-3a08b90a4e6d@phytium.com.cn>
Date: Thu, 26 Feb 2026 23:45:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] tests/qtest: Support for memory access with
 secure/space attr
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
 <20260222082529.491384-2-tangtao1634@phytium.com.cn>
 <aZ8ABZwi_RVQUEj8@ZEVORN-PC.localdomain>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aZ8ABZwi_RVQUEj8@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXruukaqBpRHsdAA--.36559S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQASBWmfZugExgABst
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3ury5AF4rArWxuw13Zw4DXFb_yoW8Ww1fCo
 WFgFn2v3sxtr17uryq9ryktr13GFZ8WrnrAw4Fkw13J3WFqF4Uua45JFWUZFWUAayrKr9r
 J3WxJa4FyFWjvrs8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

Hi Chao,

On 2026/2/25 22:23, Chao Liu wrote:
> Hi Tao,
>
> Some additional comments on top of Peter's review:
>
> On Sun, Feb 22, 2026 at 04:25:28PM +0800, Tao Tang wrote:
>> Introduce `*_secure` and `*_space` commands to the qtest protocol and
>> libqtest API. This allows testing devices that behave differently based
>> on security state (e.g., ARM TrustZone/CCA or x86 SMM).
>>
>> - `*_secure` commands specify the SECURE parameter (0 or 1) and are
>>    compatible with x86 and ARM.
>> - `*_space` commands specify the ARM security space (0-3) and are
>>    ARM-specific.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   system/qtest.c                | 482 ++++++++++++++++++++++++++++++++++
>>   tests/qtest/libqtest-single.h | 133 ++++++++++
>>   tests/qtest/libqtest.c        | 249 ++++++++++++++++++
>>   tests/qtest/libqtest.h        | 281 ++++++++++++++++++++
>>   4 files changed, 1145 insertions(+)
>>
>> diff --git a/system/qtest.c b/system/qtest.c
>> index e42b83ce67..2140aaac99 100644
>> --- a/system/qtest.c
>> +++ b/system/qtest.c
>> @@ -217,6 +217,60 @@ static void *qtest_server_send_opaque;
>>    * B64_DATA is an arbitrarily long base64 encoded string.
>>    * If the sizes do not match, the data will be truncated.
>>    *
>> + * Memory access with MemTxAttrs:
>> + * """"""""""""""""""""""""""""""
>> + *
>> + * The following commands allow specifying memory transaction attributes,
>> + * which is useful for testing devices that behave differently based on
>> + * security state (e.g., ARM TrustZone/CCA or System Management Mode in x86).
>> + *
>> + * Two variants are available:
>> + *
>> + * 1. ``*_secure`` commands: Available on x86 and ARM.
>> + * Only specifies the SECURE parameter (0 or 1).
>> + * When SECURE=1, uses the secure AddressSpace. The asidx argument to
>> + * cpu_get_address_space() can only be 1 on x86 (SMM mode, X86ASIdx_SMM) and
>> + * ARM (Secure state, ARMASIdx_S); all other targets always use 0 for the asidx
>> + * parameter. When issuing ``*_secure`` commands, we assert that the secure
>> + * AddressSpace must exist.
>> + *
>> + * 2. ``*_space`` commands: ARM-specific.
>> + * Only specifies the SPACE parameter (0-3).
>> + * SECURE is auto-derived: secure=1 for Secure(0)/Root(2), secure=0 for
>> + * NonSecure(1)/Realm(3), following ARM's arm_space_is_secure() semantics.
>> + *
>> + * Secure variants with .secure attribute (x86/ARM):
>> + * ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > writeb_secure ADDR VALUE SECURE
>> + *  < OK
>> + *  > readb_secure ADDR SECURE
>> + *  < OK VALUE
>> + *  > read_secure ADDR SIZE SECURE
>> + *  < OK DATA
>> + *  > write_secure ADDR SIZE DATA SECURE
>> + *  < OK
>> + *  > memset_secure ADDR SIZE VALUE SECURE
>> + *  < OK
>> + *
>> + * Space variants with .space attribute (ARM-specific):
>> + * ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > writeb_space ADDR VALUE SPACE
>> + *  < OK
>> + *  > readb_space ADDR SPACE
>> + *  < OK VALUE
>> + *  > read_space ADDR SIZE SPACE
>> + *  < OK DATA
>> + *  > write_space ADDR SIZE DATA SPACE
>> + *  < OK
>> + *  > memset_space ADDR SIZE VALUE SPACE
>> + *  < OK
>> + *
>>    * IRQ management:
>>    * """""""""""""""
>>    *
>> @@ -668,6 +722,434 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>>               g_free(data);
>>           }
>>   
>> +        qtest_send(chr, "OK\n");
>> +    } else if (strcmp(words[0], "writeb_secure") == 0 ||
>> +               strcmp(words[0], "writew_secure") == 0 ||
>> +               strcmp(words[0], "writel_secure") == 0 ||
>> +               strcmp(words[0], "writeq_secure") == 0) {
>> +        /*
>> +         * *_secure commands: x86/ARM compatible.
>> +         * Only specifies SECURE parameter.
>> +         */
>> +        uint64_t addr, value, secure;
>> +        MemTxAttrs attrs;
> MemTxAttrs is declared on the stack without initialization here.
> This struct has many fields (user, memory, debug, requester_id,
> unspecified, etc.) that will all contain garbage values. This
> happens in every single new command handler (all 12 branches).
>
> You need either:
>
> ```
>      MemTxAttrs attrs = {};
> ```
>
> or build on top of MEMTXATTRS_UNSPECIFIED and then set the
> specific fields you need. As-is this is a real bug that could
> cause unpredictable behavior depending on what garbage ends up
> in the other attribute fields.


Thanks for the feedback. I'll fix it in V2.

>
>> +        AddressSpace *as;
>> +        int ret;
>> +
>> +        g_assert(words[1] && words[2] && words[3]);
>> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[2], NULL, 0, &value);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[3], NULL, 0, &secure);
>> +        g_assert(ret == 0);
>> +
>> +        attrs.secure = secure & 1;
>> +
>> +        if (attrs.secure) {
>> +            as = cpu_get_address_space(first_cpu, 1);
>> +            /* Secure AddressSpace must be available when issuing secure commands */
>> +            g_assert(as);
>> +        } else {
>> +            as = first_cpu->as;
>> +        }
>> +
> As Peter already pointed out, hardcoding asidx=1 is wrong. But I
> want to add: once you properly initialize attrs, you can unify the
> AS lookup for both *_secure and *_space into a single helper:
>
> ```
>      static AddressSpace *qtest_get_as_for_attrs(MemTxAttrs attrs)
>      {
>          int asidx = cpu_asidx_from_attrs(first_cpu, attrs);
>          AddressSpace *as = cpu_get_address_space(first_cpu, asidx);
>          g_assert(as);
>          return as;
>      }
> ```
>
> This eliminates the duplicated if/else AS lookup in every branch.
>
> Also, the *_secure commands have no architecture guard at all. If


Thanks for the suggestion. Calling cpu_asidx_from_attrs and then 
cpu_get_address_space and with an assertion following up is a good idea. 
We do not need to add extra guard code as the assertion itself is the 
guard.


> someone runs `readb_secure ADDR 1` on RISC-V or MIPS (which only
> have one address space), cpu_get_address_space(first_cpu, 1) will
> return NULL and hit the g_assert. You should either add a guard
> similar to what *_space does, or (better) rely on
> cpu_asidx_from_attrs() which will naturally return 0 for
> architectures that don't understand the secure attribute.
>
>> +        if (words[0][5] == 'b') {
>> +            uint8_t data = value;
>> +            address_space_write(as, addr, attrs, &data, 1);
>> +        } else if (words[0][5] == 'w') {
>> +            uint16_t data = value;
>> +            tswap16s(&data);
>> +            address_space_write(as, addr, attrs, &data, 2);
>> +        } else if (words[0][5] == 'l') {
>> +            uint32_t data = value;
>> +            tswap32s(&data);
>> +            address_space_write(as, addr, attrs, &data, 4);
>> +        } else if (words[0][5] == 'q') {
>> +            uint64_t data = value;
>> +            tswap64s(&data);
>> +            address_space_write(as, addr, attrs, &data, 8);
>> +        }
> This byte-swap + address_space_write block is copy-pasted verbatim
> from the existing writeb/writew/writel/writeq handler, and then
> duplicated again for *_space. Same for the read side. Please
> extract a common helper, e.g.:
>
> ```
>      static void qtest_do_typed_write(AddressSpace *as, MemTxAttrs attrs,
>                                       uint64_t addr, uint64_t value,
>                                       char size_char)
> ```
>
> This would let the existing non-secure commands share the same
> code path too, which aligns with Peter's suggestion of extending
> the existing commands with optional parameters.


Sure. I've refactored this logic after receiving Peter's feedback. The 
current code is someting like:


static bool qtest_parse_mem_attrs(CharFrontend *chr, const char *arg,
                                   MemTxAttrs *attrs)
{
     if (!arg) {
         *attrs = MEMTXATTRS_UNSPECIFIED;
         return true;
     }

     if (strcmp(arg, "secure") == 0) {
         *attrs = (MemTxAttrs){ .secure = 1 };
         return true;
     }

     if (strncmp(arg, "space=", 6) == 0) {
         const char *space = arg + 6;

....

}

....

     } else if (strcmp(words[0], "readb") == 0 ||
                strcmp(words[0], "readw") == 0 ||
                strcmp(words[0], "readl") == 0 ||
                strcmp(words[0], "readq") == 0) {
         uint64_t addr;
         uint64_t value = UINT64_C(-1);
         MemTxAttrs attrs;
         AddressSpace *as;
         int ret;

....

static void qtest_process_command(CharFrontend *chr, gchar **words)
{

....

         if (!qtest_parse_mem_attrs(chr, words[2], &attrs) ||
             !qtest_get_mem_as(chr, attrs, &as)) {
             return;
         }

         if (words[0][4] == 'b') {
             uint8_t data;
             address_space_read(as, addr, attrs, &data, 1);
             value = data;

......


>
>> +        qtest_send(chr, "OK\n");
>> +    } else if (strcmp(words[0], "readb_secure") == 0 ||
>> +               strcmp(words[0], "readw_secure") == 0 ||
>> +               strcmp(words[0], "readl_secure") == 0 ||
>> +               strcmp(words[0], "readq_secure") == 0) {
>> +        uint64_t addr, secure;
>> +        uint64_t value = UINT64_C(-1);
>> +        MemTxAttrs attrs;
>> +        AddressSpace *as;
>> +        int ret;
>> +
>> +        g_assert(words[1] && words[2]);
>> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[2], NULL, 0, &secure);
>> +        g_assert(ret == 0);
>> +
>> +        attrs.secure = secure & 1;
>> +
>> +        if (attrs.secure) {
>> +            as = cpu_get_address_space(first_cpu, 1);
>> +            g_assert(as);
>> +        } else {
>> +            as = first_cpu->as;
>> +        }
>> +
>> +        if (words[0][4] == 'b') {
>> +            uint8_t data;
>> +            address_space_read(as, addr, attrs, &data, 1);
>> +            value = data;
>> +        } else if (words[0][4] == 'w') {
>> +            uint16_t data;
>> +            address_space_read(as, addr, attrs, &data, 2);
>> +            value = tswap16(data);
>> +        } else if (words[0][4] == 'l') {
>> +            uint32_t data;
>> +            address_space_read(as, addr, attrs, &data, 4);
>> +            value = tswap32(data);
>> +        } else if (words[0][4] == 'q') {
>> +            address_space_read(as, addr, attrs, &value, 8);
>> +            tswap64s(&value);
>> +        }
>> +        qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
>> +    } else if (strcmp(words[0], "read_secure") == 0) {
>> +        g_autoptr(GString) enc = NULL;
>> +        uint64_t addr, len, secure;
>> +        uint8_t *data;
>> +        MemTxAttrs attrs;
>> +        AddressSpace *as;
>> +        int ret;
>> +
>> +        g_assert(words[1] && words[2] && words[3]);
>> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[3], NULL, 0, &secure);
>> +        g_assert(ret == 0);
>> +        g_assert(len);
>> +
>> +        attrs.secure = secure & 1;
>> +
>> +        if (attrs.secure) {
>> +            as = cpu_get_address_space(first_cpu, 1);
>> +            g_assert(as);
>> +        } else {
>> +            as = first_cpu->as;
>> +        }
>> +
>> +        data = g_malloc(len);
>> +        address_space_read(as, addr, attrs, data, len);
>> +
>> +        enc = qemu_hexdump_line(NULL, data, len, 0, 0);
>> +        qtest_sendf(chr, "OK 0x%s\n", enc->str);
>> +        g_free(data);
>> +    } else if (strcmp(words[0], "write_secure") == 0) {
>> +        uint64_t addr, len, i, secure;
>> +        uint8_t *data;
>> +        size_t data_len;
>> +        MemTxAttrs attrs;
>> +        AddressSpace *as;
>> +        int ret;
>> +
>> +        g_assert(words[1] && words[2] && words[3] && words[4]);
>> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[4], NULL, 0, &secure);
>> +        g_assert(ret == 0);
>> +
>> +        data_len = strlen(words[3]);
>> +        if (data_len < 3) {
>> +            qtest_send(chr, "ERR invalid argument size\n");
>> +            return;
>> +        }
>> +
>> +        attrs.secure = secure & 1;
>> +
>> +        if (attrs.secure) {
>> +            as = cpu_get_address_space(first_cpu, 1);
>> +            g_assert(as);
>> +        } else {
>> +            as = first_cpu->as;
>> +        }
>> +
>> +        data = g_malloc(len);
>> +        for (i = 0; i < len; i++) {
>> +            if ((i * 2 + 4) <= data_len) {
>> +                data[i] = hex2nib(words[3][i * 2 + 2]) << 4;
>> +                data[i] |= hex2nib(words[3][i * 2 + 3]);
>> +            } else {
>> +                data[i] = 0;
>> +            }
>> +        }
>> +        address_space_write(as, addr, attrs, data, len);
>> +        g_free(data);
>> +
>> +        qtest_send(chr, "OK\n");
>> +    } else if (strcmp(words[0], "memset_secure") == 0) {
>> +        uint64_t addr, len, secure;
>> +        uint8_t *data;
>> +        unsigned long pattern;
>> +        MemTxAttrs attrs;
>> +        AddressSpace *as;
>> +        int ret;
>> +
>> +        g_assert(words[1] && words[2] && words[3] && words[4]);
>> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtoul(words[3], NULL, 0, &pattern);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[4], NULL, 0, &secure);
>> +        g_assert(ret == 0);
>> +
>> +        attrs.secure = secure & 1;
>> +
>> +        if (attrs.secure) {
>> +            as = cpu_get_address_space(first_cpu, 1);
>> +            g_assert(as);
>> +        } else {
>> +            as = first_cpu->as;
>> +        }
>> +
>> +        if (len) {
>> +            data = g_malloc(len);
>> +            memset(data, pattern, len);
>> +            address_space_write(as, addr, attrs, data, len);
>> +            g_free(data);
>> +        }
>> +
>> +        qtest_send(chr, "OK\n");
>> +    } else if (strcmp(words[0], "writeb_space") == 0 ||
>> +               strcmp(words[0], "writew_space") == 0 ||
>> +               strcmp(words[0], "writel_space") == 0 ||
>> +               strcmp(words[0], "writeq_space") == 0) {
>> +        /* *_space commands: ARM-specific. */
>> +        uint64_t addr, value, space;
>> +        MemTxAttrs attrs;
>> +        AddressSpace *as;
>> +        int ret;
>> +
>> +        if (!target_arm() && !target_aarch64()) {
>> +            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
>> +            return;
>> +        }
>> +
>> +        g_assert(words[1] && words[2] && words[3]);
>> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[2], NULL, 0, &value);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[3], NULL, 0, &space);
>> +        g_assert(ret == 0);
>> +
>> +        attrs.space = space & 3;
>> +        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
>> +
>> +        if (attrs.secure) {
>> +            as = cpu_get_address_space(first_cpu, 1);
>> +            g_assert(as);
>> +        } else {
>> +            as = first_cpu->as;
>> +        }
>> +
>> +        if (words[0][5] == 'b') {
>> +            uint8_t data = value;
>> +            address_space_write(as, addr, attrs, &data, 1);
>> +        } else if (words[0][5] == 'w') {
>> +            uint16_t data = value;
>> +            tswap16s(&data);
>> +            address_space_write(as, addr, attrs, &data, 2);
>> +        } else if (words[0][5] == 'l') {
>> +            uint32_t data = value;
>> +            tswap32s(&data);
>> +            address_space_write(as, addr, attrs, &data, 4);
>> +        } else if (words[0][5] == 'q') {
>> +            uint64_t data = value;
>> +            tswap64s(&data);
>> +            address_space_write(as, addr, attrs, &data, 8);
>> +        }
>> +        qtest_send(chr, "OK\n");
>> +    } else if (strcmp(words[0], "readb_space") == 0 ||
>> +               strcmp(words[0], "readw_space") == 0 ||
>> +               strcmp(words[0], "readl_space") == 0 ||
>> +               strcmp(words[0], "readq_space") == 0) {
>> +        uint64_t addr, space;
>> +        uint64_t value = UINT64_C(-1);
>> +        MemTxAttrs attrs;
>> +        AddressSpace *as;
>> +        int ret;
>> +
>> +        if (!target_arm() && !target_aarch64()) {
>> +            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
>> +            return;
>> +        }
>> +
>> +        g_assert(words[1] && words[2]);
>> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
>> +        g_assert(ret == 0);
>> +        ret = qemu_strtou64(words[2], NULL, 0, &space);
>> +        g_assert(ret == 0);
>> +
>> +        attrs.space = space & 3;
>> +        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
>> +
> Two issues here:
>
> 1. If the user passes space=5, it gets silently truncated to 1
>     (NonSecure) via `& 3`. You should validate space <= 3 before
>     masking and return an error for out-of-range values.


I'll add an assertion here.


> 2. As Peter noted, you should use arm_space_is_secure() from
>     include/hw/arm/arm-security.h instead of open-coding the
>     mapping. That header is safe to include in compiled-once code.
>
> More broadly, the *_space commands are defined as "ARM-specific"
> with hardcoded numeric values 0-3 mapping to ARM security spaces.
> But other architectures may have analogous concepts in the future
> (e.g., RISC-V has Machine/Supervisor/User privilege levels and
> PMP-based memory isolation). Baking ARM's specific space encoding
> into the qtest protocol makes it harder to extend later.
>
> This is another reason Peter's suggestion of using optional named
> parameters on existing commands is a better design:
>
>      readb ADDR space=realm     # ARM
>      readb ADDR secure          # generic secure bit
>
> Named parameters are self-documenting, architecture-neutral at the
> protocol level, and trivially extensible for new architectures
> without inventing new command families each time.


I'll refactor this like code below:

     val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x1, "secure");
     g_assert_cmpuint(val, ==, 0x22);

     qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x2, 0x33, "space=realm");
     val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x2, "space=realm");
     g_assert_cmpuint(val, ==, 0x33);

     qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x3, 0x44, "space=root");
     val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x3, "space=root");


Thanks again for the review!

Tao



