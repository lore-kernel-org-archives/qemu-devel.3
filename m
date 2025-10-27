Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C6CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDGV8-00041e-Lj; Mon, 27 Oct 2025 02:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDGV6-00040v-65
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:14:40 -0400
Received: from sg-1-22.ptr.blmpb.com ([118.26.132.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDGV0-0004Ye-5F
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761545593;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=nAAzy7K8617RXzO4KIFYWu7N4lA9UBflj5l0bnqU4Ks=;
 b=1gKh+MM/ZamX1I+lLtp8MI5ovsaxh/Q8CKWWWn/qamYSfG7YzD9nBiwaqf1xPY+QtQZ3+M
 eMfrOVQOuAqB2a7mBkxZfLGkPQ5lptJuFVLdhDCHIVIDKKTMqNwoXLsDrSOqoK2r0tQ2G3
 m9DSeIOF35qfE5ZXfQwjBZGN5LTJcda5WIUqGejQKR0r1QyiP2E0m/0iFH2w2bLHXq5u3r
 6et/T3FZXo8aORlMuRavrQjNE7CKNgHyeMBBPDwj+x0w3B3vsH/wWA6LoffCnxti8nK1fg
 T0mWzM+H+mYCN1FwRUIkIijwIR5NCOdkd0UYO8379rysOKT19m4EaOqDnRIrJQ==
References: <20251025123853.63139-2-chenmiao@openatom.club>
 <aP8P2H0qk0yJMPe3@intel.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <aP8P2H0qk0yJMPe3@intel.com>
Cc: <pbonzini@redhat.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>
Message-Id: <fb4729e0-5d74-4a7d-88f1-55f94cb87059@openatom.club>
Content-Transfer-Encoding: 7bit
Received: from [198.18.0.1] ([114.249.194.57]) by smtp.feishu.cn with ESMTPS;
 Mon, 27 Oct 2025 14:13:10 +0800
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+268ff0d77+45ad17+nongnu.org+chenmiao@openatom.club>
From: "Chen Miao" <chenmiao@openatom.club>
Date: Mon, 27 Oct 2025 14:13:08 +0800
X-Original-From: Chen Miao <chenmiao@openatom.club>
To: "Zhao Liu" <zhao1.liu@intel.com>
Subject: Re: [RFC 1/5] rust: hw: core: Add the BusState of rust version
Received-SPF: pass client-ip=118.26.132.22;
 envelope-from=chenmiao@openatom.club; helo=sg-1-22.ptr.blmpb.com
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

On 10/27/2025 2:23 PM, Zhao Liu wrote:
> On Sat, Oct 25, 2025 at 12:38:49PM +0000, chenmiao wrote:
>> Date: Sat, 25 Oct 2025 12:38:49 +0000
>> From: chenmiao <chenmiao@openatom.club>
>> Subject: [RFC 1/5] rust: hw: core: Add the BusState of rust version
>> X-Mailer: git-send-email 2.43.0
>>
>> A Rust version implementation has been designed for BusState,
>> which will be used for the subsequent I2CBus implementation.
>>
>> Signed-off-by: chenmiao <chenmiao@openatom.club>
>> ---
>>   rust/hw/core/meson.build |  1 +
>>   rust/hw/core/src/bus.rs  | 51 ++++++++++++++++++++++++++++++++++++++++
>>   rust/hw/core/src/lib.rs  |  3 +++
>>   3 files changed, 55 insertions(+)
>>   create mode 100644 rust/hw/core/src/bus.rs
> After a quick glance, I think this BusState is implemented quite well.
>
> Only a few minor nits inline:
>
> ...
>
>> +pub trait BusStateImpl: DeviceImpl + IsA<BusState> {}
>> +
>> +impl BusClass {
>> +    pub fn class_init<T: BusStateImpl>(self: &mut BusClass) {
>> +        self.parent_class.class_init::<T>();
>> +    }
>> +}
>> +
>> +pub trait BusStateMethods: ObjectDeref
> This can be named BusMethods - just like DeviceMethods did.
>
>> +where
>> +    Self::Target: IsA<BusState>,
>> +{
>> +    fn bus_realize(&self) {
> "bus_" prefix is not needed:
>
> dummy_bus.realize() is clear and enough.
>
>> +        assert!(bql::is_locked());
> It's better to add safety comment from beginning (// SAFETY: xxx).
>
>> +        unsafe {
>> +            bindings::qbus_realize(
>> +                self.upcast().as_mut_ptr(),
>> +                addr_of_mut!(util::bindings::error_fatal),
>> +            );
>> +        }
>> +    }
>> +}
> Regards,
> Zhao

Hi Zhao,

Thanks for your review, I'll revisions based on your suggestions after all the 
patches reviewed.

Regards,

Chen Miao

