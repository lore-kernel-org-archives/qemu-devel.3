Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DB1F55425
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 01:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv3qy-0003vF-RV; Tue, 24 Feb 2026 20:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vv3qr-0003uv-Po; Tue, 24 Feb 2026 20:38:09 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vv3qo-0003gS-51; Tue, 24 Feb 2026 20:38:09 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnb2NwUp5p6iBxBw--.1636S2;
 Wed, 25 Feb 2026 09:37:52 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB30O1rUp5pBuwcAA--.50570S2;
 Wed, 25 Feb 2026 09:37:47 +0800 (CST)
Message-ID: <42f92f30-315b-4862-8876-cd8c41339fc5@phytium.com.cn>
Date: Wed, 25 Feb 2026 09:37:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] tests/qtest: Support for memory access with
 secure/space attr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
 <20260222082529.491384-2-tangtao1634@phytium.com.cn>
 <CAFEAcA-L2oQ2p3nQVDcqpZSjhtU123Sep+ou8xOH-0jFug9LNA@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA-L2oQ2p3nQVDcqpZSjhtU123Sep+ou8xOH-0jFug9LNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB30O1rUp5pBuwcAA--.50570S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWmcw6oEYwACst
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWrWrWw45Xr4DZw1UGryxAFb_yoWrCF1kpr
 ZrA3ZIgF4DGF18t3Z7Xws0gFyxK393KF42qrZ5JryjyF9xCr1xCryF9r15Cry2gws7W3Wq
 9r4j9r43JFn8J37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2026/2/24 23:54, Peter Maydell wrote:
> On Sun, 22 Feb 2026 at 08:26, Tao Tang <tangtao1634@phytium.com.cn> wrote:
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
>
>
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
> Rather than creating two new separate families of commands
> for this, we could instead have an extra optional parameter
> to the existing read/write/etc commands, so for example:
>
>    readb ADDR              # read, with MEMTXATTRS_UNSPECIFIED
>    readb ADDR secure       # ditto, but set the attrs for secure
>    readb ADDR space=realm  # ditto but for a security space
>
> This patch has a lot of duplication of the existing code,
> and I think that doing it this way round will help reduce that.


Thanks for the feedback.


I'll refactor this in V2.


>
>
>> +        if (attrs.secure) {
>> +            as = cpu_get_address_space(first_cpu, 1);
>> +            /* Secure AddressSpace must be available when issuing secure commands */
>> +            g_assert(as);
>> +        } else {
>> +            as = first_cpu->as;
>> +        }
> You can't assume that the first address space is the secure one.
> To get the right address space for a given MemTxAttrs you do
> what cpu_memory_rw_debug() does:
>
>          asidx = cpu_asidx_from_attrs(cpu, attrs);
>          res = address_space_rw(cpu->cpu_ases[asidx].as, ....);


I'll fix it in next version.

>
>
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
>> +        attrs.space = space & 3;
>> +        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
> I think that because include/hw/arm/arm-security.h is a completely
> standalone header that is safe to include in compiled-once-for-all-targets
> code, we can include it in this file. Then we can use
> arm_space_is_secure(), and also the ARMSS_* constants for
> the space names rather than hardcoded numbers.


Well I did hesitate initially about including 
include/hw/arm/arm-security.h, because I wasn’t fully sure what the 
rules are in QTest for pulling in target-related headers like this.

But since you’ve confirmed, I’ll fix it in the next version.


Thanks again.

Tao


