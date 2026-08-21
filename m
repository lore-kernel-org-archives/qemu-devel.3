Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D075C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxL0W-000553-MB; Fri, 21 Aug 2026 04:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxL0T-00054l-Du; Fri, 21 Aug 2026 04:53:45 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxL0R-0002iG-9V; Fri, 21 Aug 2026 04:53:45 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwA3PvYMEohqrH0GAQ--.17747S2; 
 Fri, 21 Aug 2026 16:53:32 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwKXIGEohqSmthAA--.11117S2;
 Fri, 21 Aug 2026 16:53:26 +0800 (CST)
Message-ID: <d2a1ce7f-89c2-4ac2-aac7-a96992ded274@phytium.com.cn>
Date: Fri, 21 Aug 2026 16:53:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 4/5] tests/qtest: Add qtest-attrs-test for memory access
 attrs
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, Chao Liu
 <chao.liu@processmission.com>, Jim MacArthur <jim.macarthur@linaro.org>
References: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
 <20260814035628.3924513-5-tangtao1634@phytium.com.cn>
 <87tsoqkxin.fsf@suse.de>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <87tsoqkxin.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwKXIGEohqSmthAA--.11117S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWqGBEsJpwALsP
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7trWfGF1fWFy8ur4rWrW3Wrg_yoW8uFWDpa
 y5u3WY9a18JF1xJw43Xr48X3WYkrs7Jr1DJF9xtF1UurW5AF1aqr12kw1jgr9xZrWkXrWr
 C3WvyF9xGrn8tFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Fabiano,

On 2026/8/19 22:14, Fabiano Rosas wrote:
> Tao Tang <tangtao1634@phytium.com.cn> writes:
>
>> Add qtest-attrs-test to exercise qtest memory access commands with attrs
>> on both aarch64 and x86.
>>
>> The test covers:
>> - Arm virt,secure=on: scalar and bulk accesses across non-secure,
>>    secure, and root spaces, plus negative coverage for realm and for
>>    non-secure accesses into secure-only RAM
>> - x86 q35: normal accesses
>> - libqtest-single *_attrs shortcut wrappers
>>
>> Add reusable response assertion helpers and structured attrs failure
>> helpers to libqtest.
> Can't you re-order patch 3/5 before 2/5 and put these generic changes in
> 2/5 as well?

Yes, that makes sense. I'll reorder them in V6.


>
>> Use the structured APIs for negative memory access
>> tests, while retaining raw protocol commands for malformed command
>> shapes that the typed APIs cannot express.
>>
>> On Arm, the test targets the virt machine's secure-only RAM window so
>> that the requested attrs must select the correct address space.
>>
>> Also wire qtest-attrs-test into the aarch64 and i386/x86_64 qtest
>> builds.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   tests/qtest/libqtest.c         | 156 +++++++++++++++++
>>   tests/qtest/libqtest.h         | 111 ++++++++++++
>>   tests/qtest/meson.build        |   7 +-
>>   tests/qtest/qtest-attrs-test.c | 305 +++++++++++++++++++++++++++++++++
>>   4 files changed, 577 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/qtest/qtest-attrs-test.c
>>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 37aa69e1297..533b6f34599 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
> The repetition introduced in this part is annoying, but let's not suffer
> because of it, we can clean it up later. We could probably unify the
> attrs and non-attrs versions using variadic functions as with the qmp
> helpers.

Agreed. I'll leave the cleanup for a follow-up and keep this version 
focused on the attrs support.

Thanks for the review!

Tao

>
> For libqtest:
> Reviewed-by: Fabiano Rosas <farosas@suse.de>


