Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E516107BCFC
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 07:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1JWX-0004M1-HK; Sat, 14 Mar 2026 03:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w1JWT-0004Lb-6d; Sat, 14 Mar 2026 03:34:58 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w1JWN-0003wo-IK; Sat, 14 Mar 2026 03:34:56 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnb9OPD7VpNsbVAA--.55244S2;
 Sat, 14 Mar 2026 15:34:39 +0800 (CST)
Received: from [172.16.105.53] (unknown [113.247.196.231])
 by mail (Coremail) with SMTP id AQAAf8DwF5KID7VpjWUBAA--.704S2;
 Sat, 14 Mar 2026 15:34:33 +0800 (CST)
Message-ID: <ae3befa9-3559-4e9c-aa5f-46c14a9440a7@phytium.com.cn>
Date: Sat, 14 Mar 2026 15:34:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] tests/qtest: Add attrs argument support to memory
 access commands
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
 <20260311154934.1575429-2-tangtao1634@phytium.com.cn>
 <CAFEAcA8_ymW_5ZRYfJNdrajATYbNCsnD8xbV3-6t7fpecrhAdw@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA8_ymW_5ZRYfJNdrajATYbNCsnD8xbV3-6t7fpecrhAdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwF5KID7VpjWUBAA--.704S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWm0ZHkAQwADsK
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3uFWrXr4xuw4UCF45GrWrGrg_yoWDZr45pF
 Z8AFn0gF48tF1fXrnxXF4DW3WrKr4fKr1Yy3yDtr1jyrZ8Aw1IkFyqkw4Y9rnrZrZ7Wr4j
 va15Xrn3GFnIvFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Peter,

On 2026/3/13 03:15, Peter Maydell wrote:
> On Wed, 11 Mar 2026 at 15:50, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>> Extend qtest memory access commands to accept an optional attrs argument.
>>
>> Supported attrs:
>> - secure (ARM/x86-only, lowercase)
>> - space=non-secure|secure|root|realm (ARM-only, lowercase)
>>
>> For memory commands, parse attrs and select AddressSpace via
>> cpu_asidx_from_attrs(), then issue accesses with the corresponding
>> MemTxAttrs.
>>
>> Expose matching libqtest APIs:
>> - qtest_{read,write}{b,w,l,q}_attrs()
>> - qtest_mem{read,write,set}_attrs()
>>
>> Also add libqtest-single wrappers for the *_attrs helpers.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   system/qtest.c                | 266 ++++++++++++++++++++++++++++------
>>   tests/qtest/libqtest-single.h |  61 ++++++++
>>   tests/qtest/libqtest.c        | 148 +++++++++++++++++++
>>   tests/qtest/libqtest.h        |  25 ++++
>>   4 files changed, 453 insertions(+), 47 deletions(-)
> This is a pretty large patch. Please could you split it in two?
>   (1) add support for the new commands to system/qtest.c
>   (2) add support to libqtest for sending the new commands

Thanks for your suggestion.


Sure. I'll split it in V3.


>
>> diff --git a/system/qtest.c b/system/qtest.c
>> index cf90cd53ad..dbf3a63c57 100644
>> --- a/system/qtest.c
>> +++ b/system/qtest.c
>> @@ -22,6 +22,7 @@
>>   #include "hw/core/qdev.h"
>>   #include "hw/core/irq.h"
>>   #include "hw/core/cpu.h"
>> +#include "hw/arm/arm-security.h"
>>   #include "qemu/accel.h"
>>   #include "system/cpu-timers.h"
>>   #include "qemu/config-file.h"
>> @@ -218,6 +219,39 @@ static void *qtest_server_send_opaque;
>>    * B64_DATA is an arbitrarily long base64 encoded string.
>>    * If the sizes do not match, the data will be truncated.
>>    *
>> + * Memory access with MemTxAttrs:
>> + * """"""""""""""""""""""""""""""
>> + *
>> + * The following commands allow specifying memory transaction attributes,
>> + * which is useful for testing devices that behave differently based on
>> + * security state (e.g., ARM TrustZone/CCA or System Management Mode in x86).
> A small nit, but "Arm" is not all-caps these days.


Good catch. I hadn't paid enough attention to this before, including in 
some of my earlier series. I'll use the preferred "Arm" 
capitalization going forward.


>
>> + *
>> + * The memory access commands above support one optional ATTRS argument:
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > writeb ADDR VALUE
>> + *  < OK
>> + *  > writeb ADDR VALUE secure
>> + *  < OK
>> + *  > writeb ADDR VALUE space=realm
>> + *  < OK
>> + *  > readb ADDR secure
>> + *  < OK VALUE
>> + *  > readb ADDR space=root
>> + *  < OK VALUE
>> + *  > read ADDR SIZE space=secure
>> + *  < OK DATA
>> + *  > write ADDR SIZE DATA secure
>> + *  < OK
>> + *  > memset ADDR SIZE VALUE space=non-secure
>> + *  < OK
>> + *
>> + * ``secure`` sets MemTxAttrs.secure=1 (x86/ARM).
>> + * ``space=...`` is ARM-specific and accepts:
>> + * non-secure, secure, root, realm.
>> + * ``space=non-secure`` is equivalent to omitting ATTRS.
> If the test specifically asks for the non-secure space, this is
> not the same as "doesn't specify attributes".


....


>
>> + *
>>    * IRQ management:
>>    * """""""""""""""
>>    *
>> @@ -353,6 +387,135 @@ static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name,
>>       *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
>>   }
>>
>> +static bool qtest_parse_mem_attrs(CharFrontend *chr, const char *arg,
>> +                                  MemTxAttrs *attrs)
>> +{
>> +    if (!arg) {
>> +        *attrs = MEMTXATTRS_UNSPECIFIED;
>> +        return true;
>> +    }
>> +
>> +    if (strcmp(arg, "secure") == 0) {
>> +        *attrs = (MemTxAttrs){ .secure = 1 };
>> +        return true;
>> +    }
>> +
>> +    if (strncmp(arg, "space=", 6) == 0) {
>> +        const char *space = arg + 6;
>> +        ARMSecuritySpace sec_space;
>> +
>> +        if (!target_arm() && !target_aarch64()) {
>> +            qtest_send(chr, "ERR space=<...> is ARM-specific\n");
>> +            return false;
>> +        }
>> +
>> +        if (strcmp(space, "non-secure") == 0) {
>> +            *attrs = MEMTXATTRS_UNSPECIFIED;
>> +            return true;
> Here we should set sec_space = ARMSS_NonSecure and determine
> the attributes the same way as for the other spaces.


I'll fix it so it is handled as an explicit Arm non-secure space.


>
>> +        } else if (strcmp(space, "secure") == 0) {
>> +            sec_space = ARMSS_Secure;
>> +        } else if (strcmp(space, "root") == 0) {
>> +            sec_space = ARMSS_Root;
>> +        } else if (strcmp(space, "realm") == 0) {
>> +            sec_space = ARMSS_Realm;
>> +        } else {
>> +            qtest_send(chr, "ERR invalid space value. Valid space: "
>> +                            "secure/non-secure/root/realm\n");
>> +            return false;
>> +        }
>> +
>> +        *attrs = (MemTxAttrs){
>> +            .space = sec_space,
>> +            .secure = arm_space_is_secure(sec_space),
>> +        };
>> +        return true;
>> +    }
>> +
>> +    qtest_send(chr, "ERR invalid attrs argument\n");
>> +    return false;
>> +}
> Other than that the system/qtest.c changes look good to me.
>
>> diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
>> index 851724cbcb..38d05ee61e 100644
>> --- a/tests/qtest/libqtest-single.h
>> +++ b/tests/qtest/libqtest-single.h
>> @@ -291,6 +291,67 @@ static inline void memwrite(uint64_t addr, const void *data, size_t size)
>>       qtest_memwrite(global_qtest, addr, data, size);
>>   }
>>
>> +/*
>> + * Memory commands with optional attrs argument.
>> + */
>> +static inline void writeb_attrs(uint64_t addr, uint8_t value, const char *attrs)
>> +{
>> +    qtest_writeb_attrs(global_qtest, addr, value, attrs);
>> +}
>> +
>> +static inline void writew_attrs(uint64_t addr, uint16_t value, const char *attrs)
>> +{
>> +    qtest_writew_attrs(global_qtest, addr, value, attrs);
>> +}
> All the other functions in this file have their own individual
> documentation comments describing them. Your new ones should too.


I'll add docs in v5.


>
> I wonder if we should have these functions take the attrs
> as a MemTxAttrs rather than a string? Not sure.


Just to make sure I understood your suggestion correctly: do you mean 
that the qtest wire protocol would remain text-based, but the libqtest C 
APIs would take a MemTxAttrs rather than a string, with libqtest doing 
the conversion internally?

If so, that makes sense to me as an API-shape question, even if the wire 
protocol itself still uses the textual attrs form.


>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 051faf31e1..a548331f7c 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -1447,6 +1447,154 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
>>       qtest_rsp(s);
>>   }
>>
>> +static bool qtest_has_attrs(const char *attrs)
>> +{
>> +    return attrs && attrs[0];
>> +}
>> +
>> +static void qtest_write_attrs(QTestState *s, const char *cmd,
>> +                              uint64_t addr, uint64_t value,
>> +                              const char *attrs)
>> +{
>> +    if (qtest_has_attrs(attrs)) {
>> +        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 " %s\n",
>> +                    cmd, addr, value, attrs);
>> +    } else {
>> +        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
>> +    }
>> +    qtest_rsp(s);
>> +}
>> +
>> +static uint64_t qtest_read_attrs(QTestState *s, const char *cmd,
>> +                                 uint64_t addr, const char *attrs)
>> +{
>> +    gchar **args;
>> +    int ret;
>> +    uint64_t value;
>> +
>> +    if (qtest_has_attrs(attrs)) {
>> +        qtest_sendf(s, "%s 0x%" PRIx64 " %s\n", cmd, addr, attrs);
>> +    } else {
>> +        qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
>> +    }
>> +    args = qtest_rsp_args(s, 2);
>> +    ret = qemu_strtou64(args[1], NULL, 0, &value);
>> +    g_assert(!ret);
>> +    g_strfreev(args);
>> +
>> +    return value;
>> +}
>> +
>> +void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
>> +                        const char *attrs)
>> +{
>> +    qtest_write_attrs(s, "writeb", addr, value, attrs);
>> +}
> You should also make the existing qtest_write(), qtest_writeb(), etc
> go through the new code path, by:
>    qtest_writeb() calls qtest_writeb_attrs(s, addr, value, NULL)
>    similarly qtest_writew etc etc
>    qtest_write() can be deleted as it will have no callers

.....

>
>> +void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data,
>> +                         size_t size, const char *attrs)
>> +{
>> +    uint8_t *ptr = data;
>> +    gchar **args;
>> +    size_t i;
>> +
>> +    if (!size) {
>> +        return;
>> +    }
>> +
>> +    if (qtest_has_attrs(attrs)) {
>> +        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx %s\n", addr, size, attrs);
>> +    } else {
>> +        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
>> +    }
>> +    args = qtest_rsp_args(s, 2);
>> +
>> +    for (i = 0; i < size; i++) {
>> +        ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
>> +        ptr[i] |= hex2nib(args[1][2 + (i * 2) + 1]);
>> +    }
>> +
>> +    g_strfreev(args);
>> +}
> Similarly, the qtest_memread(), qtest_memwrite(), qtest_memset()
> functions should all become wrappers that pass NULL to the
> _attrs version of the functions.


Makes sense. I'll route the existing 
qtest_write*()/qtest_read*()/qtest_mem* helpers through the new 
*_attrs(..., NULL) path.


>
>> +/*
>> + * Memory commands with optional attrs argument.
>> + */
>> +
>> +void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
>> +                        const char *attrs);
>> +void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
>> +                        const char *attrs);
>> +void qtest_writel_attrs(QTestState *s, uint64_t addr, uint32_t value,
>> +                        const char *attrs);
>> +void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
>> +                        const char *attrs);
>> +
>> +uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs);
>> +uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs);
>> +uint32_t qtest_readl_attrs(QTestState *s, uint64_t addr, const char *attrs);
>> +uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs);
>> +
>> +void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
>> +                         const char *attrs);
>> +void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
>> +                          size_t size, const char *attrs);
>> +void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t patt, size_t size,
>> +                        const char *attrs);
> Here also you should give each function its own doc comment,
> to match the way the existing functions in this header do it.


OK.


>
>> +
>>   /**
>>    * qtest_clock_step_next:
>>    * @s: #QTestState instance to operate on.
>> --
>> 2.34.1
> thanks
> -- PMM


Thanks for the review!

Tao


