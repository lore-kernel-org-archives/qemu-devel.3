Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FD9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkKz-0003Od-MD; Tue, 28 Oct 2025 10:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDkKp-0003OA-Tj; Tue, 28 Oct 2025 10:06:04 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDkKi-00009n-T2; Tue, 28 Oct 2025 10:06:03 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHzZmzzQBpUz1gAQ--.15S2;
 Tue, 28 Oct 2025 22:05:39 +0800 (CST)
Received: from [192.168.31.224] (unknown [113.246.234.35])
 by mail (Coremail) with SMTP id AQAAfwAXfOmmzQBp2E10AA--.56166S2;
 Tue, 28 Oct 2025 22:05:36 +0800 (CST)
Message-ID: <e8f5b192-8f26-4fdd-a862-02f03adfbe16@phytium.com.cn>
Date: Tue, 28 Oct 2025 22:05:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] hw/misc: Introduce a new SMMUv3 test framework
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
 <CAFEAcA92dTDn+Zf-GZVv9zQ3_mwJHZY5hrkdgrRyE7XUio4Sjw@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA92dTDn+Zf-GZVv9zQ3_mwJHZY5hrkdgrRyE7XUio4Sjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXfOmmzQBp2E10AA--.56166S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWj-054GFAAAsd
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKFW7AryfZF4fJw18XrWrKrg_yoW7Cr4xpF
 W0gF15Kr1DCFWxZw4xZw4IvFWa9w4fJwsxArs8Jw1j93s8uFyjvr109rWYvF98ZrWkW3W0
 va12kFyqvF9YvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alex, Peter, Pierrick:


Thank you all again for the outstanding feedback.


As Peter said in mail 
[1](https://lore.kernel.org/qemu-devel/CAFEAcA92dTDn+Zf-GZVv9zQ3_mwJHZY5hrkdgrRyE7XUio4Sjw@mail.gmail.com/): 


On 2025/10/27 21:58, Peter Maydell wrote:
> On Tue, 30 Sept 2025 at 17:53, tangtao1634 <tangtao1634@phytium.com.cn> wrote:
>> The smmu-testdev is intentionally not a conformant, general-purpose PCIe
>> or platform device. It is a purpose-built, highly simplified "DMA engine."
>> I've designed it to be analogous to a minimal PCIe Root Complex that
>> bypasses the full, realistic topology (Host Bridges, Switches, Endpoints)
>> to provide a direct, programmable path for a DMA request to reach the SMMU.
>> Its sole purpose is to trigger a DMA transaction when its registers are
>> written to, making it perfectly suited for direct control from a test
>> environment like qtest.
> This makes sense to me. But looking at the code it looks like the
> device itself has a lot of code for setting up IOMMU page tables in
> guest memory when the test code writes to its registers. That
> surprised me, as I was expecting the test device to essentially
> be "do DMA on command". Is there a reason why we can't have the
> test code do the setting up of the IOMMU page tables itself
> using the qtest functions for writing guest memory? (Obviously
> you'd abstract this out into functions for the purpose in
> libqos/ somewhere.)
>
> If we did it that way, we could use the same test device as
> part of non-SMMUv3 iommu emulation tests too -- the qtest
> test case code would just set up the different IOMMU in
> the way that IOMMU expects before triggering DMA.
>
> thanks
> -- PMM


And Alex's guidance in another 
mail [2](https://lore.kernel.org/qemu-devel/87jz0gxw01.fsf@draig.linaro.org/):

> Yes - generally I think having a single test device that can be used to
> test multiple models will be useful. I guess each qtest will be very
> tied to the SMMU it is modelling as it needs to program both sides but
> if we take care to encapsulate the programming of the test device and
> verification of the results we should be able to ensure good code
> re-use.
>
>> I'll admit this is an area I haven't looked into. I'm very
>> open to ideas—do you or others have suggestions on how this
>> test-device pattern could be generalized or what would be needed to
>> make it useful across different architectures?
> My only initial thought is the device might be better called
> iommu-testdev (as in a device to test IOMMUs, of which the SMMU is one).
>
You nailed the core problem. I hadn't properly thought through the 
separation of concerns, leading to a device that was doing work it 
shouldn't. As Alex pointed out in [2], this architectural refactoring 
allows us to build a generic iommu-testdev to ensure good code re-use. 
This elevates the work from a single-purpose tool into a framework that 
can benefit all IOMMU implementations, which I understand is a far more 
valuable contribution.


Furthermore,  Pierrick's comment in mail 
[3](https://lore.kernel.org/qemu-devel/792a06cd-302c-46a5-997c-026cb67f8f2e@linaro.org/):

> We have to start somewhere, so something simple and not trying to 
> solve all use cases is the right approach. It can even just be 
> read/write config/registers before trying to add any DMA scenario. 

Also as Alex said in mail 
[4](https://lore.kernel.org/qemu-devel/87ecqoxohg.fsf@draig.linaro.org/):

> We should be thinking of targeted unit tests. The difference between
> this and a full OS is we don't need to manage multiple shifting memory
> maps over time. Setup a page (or two) with the permissions you expect
> and check that works.

The goal is to avoid "accidentally rewriting a driver." Instead, we 
should start simple and provide "targeted unit tests." The idea of 
setting up a simple, static state ("a page or two") to verify atomic 
features and edge cases that are hard to trigger in a dynamic OS is 
exactly the right philosophy for this framework.


Based on this, my plan for V3 maybe now much clearer:

- Refactor the device: It will be renamed iommu-testdev and become a 
"dumb," generic DMA engine. All architecture-specific logic, including 
the construction of page tables and other structures, will be moved into 
the qtest.

- Abstract for reuse: Following Peter's and Alex's advice, the 
table-building logic will be abstracted into reusable helper functions 
within the libqos/ library.

- Limit the initial scope: As you all suggested, the first set of tests 
will be simple unit tests, focusing on the core paths like different 
security states and translation stages


One final question to manage the scope of this large refactoring: my 
plan is to implement the generic iommu-testdev framework in V3, but 
provide only the SMMUv3-specific qtest helpers and tests for now. We can 
leave the implementation for other architectures (like VT-d) to future 
work. Does this seem like a reasonable approach?

Thanks again for helping to shape this work.

Best regards,

Tao


[1] 
(https://lore.kernel.org/qemu-devel/CAFEAcA92dTDn+Zf-GZVv9zQ3_mwJHZY5hrkdgrRyE7XUio4Sjw@mail.gmail.com/)
[2] (https://lore.kernel.org/qemu-devel/87jz0gxw01.fsf@draig.linaro.org/)
[3] 
(https://lore.kernel.org/qemu-devel/792a06cd-302c-46a5-997c-026cb67f8f2e@linaro.org/)
[4] (https://lore.kernel.org/qemu-devel/87ecqoxohg.fsf@draig.linaro.org/)


