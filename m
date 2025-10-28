Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECCBCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDho7-0000Y0-Cv; Tue, 28 Oct 2025 07:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDho5-0000Xc-BO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:24:05 -0400
Received: from sg-1-38.ptr.blmpb.com ([118.26.132.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDho2-0003Ad-8y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761650630;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=okkQPTIn8xVQoTWg/aBWS1Ba5DwDCOwnBRa/qRJtI4w=;
 b=HrHY3zP2aIMdlc8LTYmf+0Np0xXh6s0elw3h/zqEaPc5jstdov5eoK8GAsHsru4j9rFdU/
 dWkGldfdExqijMKwOPDeg7MZyCTHApgsE5irLEc+FH83ilqJ6JwVqP/T+rVnvSZ2MC/CRs
 eKSwr/gTYd4+L7lTlaQoAHqcS7HD1fyw8Xj0mhlVeQGBz9LwM4gn8k927BfDZIDMHVQjVD
 /GHVgSkCmYuy8x9OJtrcW7d7wni+bjAdfzfUCOcirXS1Tso0j2T1bgxGS6pCU9hH/y0HTk
 8r+tjw1+ZnjSSSwFQ4hv7L71UiVea3pzZh/BfsxW16/b5+oPxnWGqcFCJUOIfA==
Mime-Version: 1.0
References: <45032bb11a9006cb7a6e1c30ca6299d40cef614c.1761644606.git.chenmiao@openatom.club>
 <CABgObfbeka+fKixBH8F_Fkprvk8oi+dTss21Vn5kYgm4sY0A8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [RFC PATCH v2 4/5] rust/hw/core: Provide some interfaces for the
 GPIO device
Message-Id: <f8ec1dad-2654-4db8-b994-0ecd2a1943e9@openatom.club>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
In-Reply-To: <CABgObfbeka+fKixBH8F_Fkprvk8oi+dTss21Vn5kYgm4sY0A8g@mail.gmail.com>
X-Lms-Return-Path: <lba+26900a7c4+7533a0+nongnu.org+chenmiao@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
To: "Paolo Bonzini" <pbonzini@redhat.com>
Received: from [198.18.0.1] ([114.249.194.57]) by smtp.feishu.cn with ESMTPS;
 Tue, 28 Oct 2025 19:23:47 +0800
Date: Tue, 28 Oct 2025 19:23:46 +0800
Cc: <zhao1.liu@intel.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <chao.liu@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
From: "Chen Miao" <chenmiao@openatom.club>
Received-SPF: pass client-ip=118.26.132.38;
 envelope-from=chenmiao@openatom.club; helo=sg-1-38.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
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

On 10/28/2025 6:49 PM, Paolo Bonzini wrote:
> On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.club=
> wrote:
>> In irq.rs, we added a new get method for the InterruptSource type to det=
ermine
>> whether an InterruptSource is null. This eliminates the need to repeated=
ly
>> call self.cell.get().is_null() for null checks during comparisons.
>> Additionally, we exposed the slice_as_ptrmethod to support external usag=
e with
>> the &[InterruptSource]type.
>>
>> In qdev.rs, we implemented the init_gpio_out_namedfunction, which corres=
ponds
>> to the C function qdev_init_gpio_out_named. We also refactored the
>> init_gpio_outfunction to reuse the init_gpio_out_namedinterface.
>>
>> Signed-off-by: chenmiao <chenmiao@openatom.club>
>> ---
>>   rust/hw/core/src/irq.rs  |  6 +++++-
>>   rust/hw/core/src/qdev.rs | 12 +++++++++---
>>   2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
>> index e0d7784d97..dd5d0cadbc 100644
>> --- a/rust/hw/core/src/irq.rs
>> +++ b/rust/hw/core/src/irq.rs
>> @@ -71,6 +71,10 @@ pub fn pulse(&self) {
>>       pub fn raise(&self) {
>>           self.set(true);
>>       }
>> +
>> +    pub fn get(&self) -> bool {
>> +        !self.cell.get().is_null()
>> +    }
> This should not be get(), but "is_connected()". Also it should be
> implemented for any T, therefore in the "impl<T> InterruptSource<T>"
> block below.
I'll fix it later.
>>   }
>>
>>   impl<T> InterruptSource<T>
>> @@ -91,7 +95,7 @@ pub(crate) const fn as_ptr(&self) -> *mut *mut binding=
s::IRQState {
>>           self.cell.as_ptr()
>>       }
>>
>> -    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindi=
ngs::IRQState {
>> +    pub const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IR=
QState {
>>           assert!(!slice.is_empty());
>>           slice[0].as_ptr()
>>       }
> Since you are not using this, you don't need to expose it outside the cra=
te.
>
> Paolo

I have used this function in the next patch.

Chen Miao

