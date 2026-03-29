Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B629EF3D605
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 14:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6rGc-00020Z-3f; Sun, 29 Mar 2026 10:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w6rGU-0001tP-8f; Sun, 29 Mar 2026 10:37:22 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w6rGO-0006xu-4B; Sun, 29 Mar 2026 10:37:21 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHTaENOclpfukyAA--.17438S2;
 Sun, 29 Mar 2026 22:37:01 +0800 (CST)
Received: from [192.168.31.176] (unknown [222.244.183.215])
 by mail (Coremail) with SMTP id AQAAf8Dw0pILOclpE0YHAA--.16065S2;
 Sun, 29 Mar 2026 22:36:59 +0800 (CST)
Message-ID: <63e1cb8a-4653-483e-a87d-ace0c241b185@phytium.com.cn>
Date: Sun, 29 Mar 2026 22:36:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/4] tests/qtest: Add attrs support to qtest server
 memory commands
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260323133210.1523868-1-tangtao1634@phytium.com.cn>
 <20260323133210.1523868-2-tangtao1634@phytium.com.cn>
 <acH32HUGWnbF2_PY@ZEVORN-PC.localdomain>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <acH32HUGWnbF2_PY@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dw0pILOclpE0YHAA--.16065S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWnIKvkb-QAAsZ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3GF1DZr1xAF4DKrykuFW3ZFb_yoW7Kry3pr
 47AF15XFs8tF18ua4xKr13Wa43K39agr1UGr9xtF92yrn0kFn3Wr1fuw15Cr1DGry7t3ZY
 9w47J3y3C3Z8Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/24/2026 10:40 AM, Chao Liu wrote:
> On Mon, Mar 23, 2026 at 09:32:07PM +0800, Tao Tang wrote:
>> Extend qtest memory access commands to accept an optional attrs argument.
>>
>> Supported attrs:
>> - secure (x86/Arm)
>> - space=non-secure|secure|root|realm (Arm-only)
>>
>> For memory commands, parse attrs, select the corresponding AddressSpace
>> with cpu_asidx_from_attrs(), and issue accesses with the matching
>> MemTxAttrs.
>>
>> Cover scalar and bulk memory commands, including:
>> - read{b,w,l,q} / write{b,w,l,q}
>> - read / write
>> - b64read / b64write
>> - memset
>>
>> Also reject invalid attrs and excessive arguments, and document the new
>> command forms in qtest.c, and use qtest_send_memtx_error() to return
>> ERR for memory access failures.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   system/qtest.c | 517 +++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 463 insertions(+), 54 deletions(-)
>>
>> diff --git a/system/qtest.c b/system/qtest.c
>> index cf90cd53ad..30c2a95020 100644
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
>> @@ -113,6 +114,14 @@ static void *qtest_server_send_opaque;
>>    * PIO and memory access:
>>    * """"""""""""""""""""""
>>    *
>> + * Memory access commands allow specifying memory transaction attributes,
>> + * which is useful for testing devices that behave differently based on
>> + * security state (e.g., Arm TrustZone/CCA or System Management Mode in x86).
>> + *
>> + * Only the following attributes are supported by the qtest server:
>> + * ``secure`` sets MemTxAttrs.secure=1 (x86/Arm).
>> + * ``space=...`` is Arm-specific and accepts: non-secure, secure, root, realm.
>> + *
>>    * .. code-block:: none
>>    *
>>    *  > outb ADDR VALUE
>> @@ -150,13 +159,42 @@ static void *qtest_server_send_opaque;
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > writeb ADDR VALUE secure
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > writeb ADDR VALUE space=realm
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > writew ADDR VALUE
>>    *  < OK
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > writew ADDR VALUE secure
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > writew ADDR VALUE space=realm
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > writel ADDR VALUE
>>    *  < OK
>> + * .. code-block:: none
>> + *
>> + *  > writel ADDR VALUE secure
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > writel ADDR VALUE space=root
>> + *  < OK
>>    *
>>    * .. code-block:: none
>>    *
>> @@ -165,49 +203,147 @@ static void *qtest_server_send_opaque;
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > writeq ADDR VALUE secure
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > writeq ADDR VALUE space=non-secure
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > readb ADDR
>>    *  < OK VALUE
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > readb ADDR secure
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > readb ADDR space=root
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > readw ADDR
>>    *  < OK VALUE
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > readw ADDR secure
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > readw ADDR space=root
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > readl ADDR
>>    *  < OK VALUE
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > readl ADDR secure
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > readl ADDR space=root
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > readq ADDR
>>    *  < OK VALUE
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > readq ADDR secure
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > readq ADDR space=root
>> + *  < OK VALUE
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > read ADDR SIZE
>>    *  < OK DATA
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > read ADDR SIZE secure
>> + *  < OK DATA
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > read ADDR SIZE space=root
>> + *  < OK DATA
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > write ADDR SIZE DATA
>>    *  < OK
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > write ADDR SIZE DATA secure
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > write ADDR SIZE DATA space=root
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > b64read ADDR SIZE
>>    *  < OK B64_DATA
>>    *
>>    * .. code-block:: none
>>    *
>> + *  > b64read ADDR SIZE secure
>> + *  < OK B64_DATA
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > b64read ADDR SIZE space=root
>> + *  < OK B64_DATA
>> + *
>> + * .. code-block:: none
>> + *
>>    *  > b64write ADDR SIZE B64_DATA
>>    *  < OK
>> + * .. code-block:: none
> There are a few places where the blank line before
> ``.. code-block:: none`` is missing (around writel and
> b64write sections). RST requires a blank ``*`` line
> before every directive, otherwise the doc build will
> break or silently mis-render.


Thanks for the review.


I'll add the missing line in V4.

>
>> + *
>> + *  > b64write ADDR SIZE B64_DATA secure
>> + *  < OK
>> + * .. code-block:: none
>> + *
>> + *  > b64write ADDR SIZE B64_DATA space=root
>> + *  < OK
>>    *
>>    * .. code-block:: none
>>    *
>>    *  > memset ADDR SIZE VALUE
>>    *  < OK
>>    *
>> + * .. code-block:: none
>> + *
>> + *  > memset ADDR SIZE VALUE secure
>> + *  < OK
>> + *
>> + * .. code-block:: none
>> + *
>> + *  > memset ADDR SIZE VALUE space=root
>> + *  < OK
> The documentation is very thorough but also very
> repetitive -- every command x every attrs variant gets
> its own code-block. It might be worth consolidating
> this into a single description of the attrs syntax
> followed by a note that it applies to all memory
> commands. That would cut ~80 lines while keeping the
> same information.


I agree the attrs examples can be trimmed a bit. So I would prefer a 
lighter cleanup here rather than collapsing everything into a single 
generic block after an additional comment like "The optional attrs 
argument applies to all memory access commands listed below."


> Thanks,
> Chao

Best regards,

Tao


