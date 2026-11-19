Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C04606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=wC77PKW2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0LO-0003cd-JF; Thu, 19 Nov 2026 06:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU0LA-0003Z1-VS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:30:12 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU0L7-0006ZE-Kt
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795087801; bh=M/FkqOl2vSZ/a6VPbcvvZRVWoyCd7RdNAKM6QiCDpp4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=wC77PKW29KNCwj+ZELurEykAs0EYU+Rag3DR+lq0s5ymkOb+9Uh+GODVmgqqUCj7I
 o5eCEo1dsjv9PaGR8R2d2uoEf9LgCjQ3MWa6w5B5WAEQq/ELbGLJ8zr4P4NDVblEs5
 +oPSwJQymwSF868L4wAkJcVJ5tUWgTdUgBOYkZiJjbgzYWBnaF6UUp9spkvpjW7bhX
 Jen+EsFdyzAVsopyZrbcuALYL2SNLAvMpE0Ofg/2CQxdJSdHj1xmK5r5P15/40xlOY
 zp95ReG+SjlWp0lWjNA/64gWoZtI+5YJHsf9xBaq+gLXAU1DiFA6ps8vSLfa8D8LOB
 S7WQsrR3kIuIQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D145D1E7EF8;
 Thu, 19 Nov 2026 14:30:01 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BCD124617E3;
 Thu, 19 Nov 2026 14:30:01 +0300 (MSK)
Message-ID: <e739f7f5-8ea8-4b14-9c4f-48cf38604eac@tls.msk.ru>
Date: Thu, 19 Nov 2026 14:30:01 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2] hostmem: allow building without KVM support
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov
 <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20261119111050.1203459-1-mjt@tls.msk.ru>
 <6bc5ddb8-50f1-4087-8591-57b542d1b5c2@intel.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6bc5ddb8-50f1-4087-8591-57b542d1b5c2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 14:26, Xiaoyao Li wrote:
> On 11/19/2026 7:10 PM, Michael Tokarev wrote:
>> On architectures where KVM is not available and so including <linux/kvm.h>
>> does not work, buildnig backends/hostmem-memfd.c fails since 7ca43d7ad02f:
>>
>>   In file included from backends/hostmem-memfd.c:23:
>>   linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
>>     16 | #include <asm/kvm.h>
>>
>> Do not include <linux/kvm.h> because "system/kvm.h" already includes it for us
>> when KVM is enabled, and guard the actual code using memfd definitions with
> 
> It reads the sentence doesn't finish...

Yeah, one line slipped out, which explains..

>> Fixes: 7ca43d7ad02f ("hostmem: Support fully shared guest memfd to back a VM")
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   backends/hostmem-memfd.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
>> index 46489212a23..3164dd6198c 100644
>> --- a/backends/hostmem-memfd.c
>> +++ b/backends/hostmem-memfd.c
>> @@ -20,7 +20,6 @@
>>   #include "qom/object.h"
>>   #include "migration/cpr.h"
>>   #include "system/kvm.h"
>> -#include <linux/kvm.h>
>>   #include "qapi/qapi-type-infos-common.h"
>>   
>>   OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
>> @@ -71,10 +70,15 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>               return false;
>>           }
>>   
>> +#ifdef CONFIG_KVM
>>           fd = kvm_create_guest_memfd(backend->size,
>>                                       GUEST_MEMFD_FLAG_MMAP |
>>                                       GUEST_MEMFD_FLAG_INIT_SHARED,
>>                                       errp);
>> +#else
>> +        error_setg(errp, "guest-memfd=on requires KVM which is not enabled");
>> +        fd = -ENOSYS;
>> +#endif
> 
> There is stub implemented in kvm-stub.c. Doesn't it work?

..which explains why the stub doesn't work: we still need to provide
defines for GUEST_MEMFD_FLAG_* which are normally declared in <linux/kvm.h>.
So we still need the ifdef'fery one way or another, and in my view it's better
to #ifdef the function call to provide a more detailed error message.

Thanks,

/mjt

>>       } else {
>>           fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
>>                                  m->hugetlb, m->hugetlbsize, m->seal ?
> 


