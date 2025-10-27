Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BDECCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDH6M-0002B5-Hm; Mon, 27 Oct 2025 02:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vDH6J-0002Ad-KF
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:53:07 -0400
Received: from sg-1-18.ptr.blmpb.com ([118.26.132.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vDH6B-00026j-CQ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761547899;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=w4DPMJx2QcgLAyD0bk+VnwoxePUaq51L2eXtq8mZqKI=;
 b=X76uAM04xa2o/8bVYzjY+dEbt275CQ47gpwl0O2qVXeXVg40V/cFY16CaJ2N6j5C1fAfq4
 0EmKjF1iB/eAHdYeuF1z0+Zu7Q9Hwh43128FwP5eLuijj0zMQHvjxEDSPUuVoxw04g7pMb
 oSrdu/oK7q6mc7Ede2Lv+BYA/01X+X8B+AOT+VSyGOQjA3NrgTL/bEEdjbN6g8KnMPMuNS
 G7JhPBBmDY0FUZJV4rvXF6/zpSYVUsa+aHLyEo8QgxsV4nc/ird+aJiKce3PZ8214vgBT9
 31L2pGdj53jQhD6s3PqDgw25WEXLEl/qvwLbjP8HsNFFnuQv+PL9V0mvgaxfTQ==
From: "Chao Liu" <chao.liu@openatom.club>
Subject: Re: [RFC 1/5] rust: hw: core: Add the BusState of rust version
Message-Id: <e8ee8afa-26c5-4936-be91-4e2790dca915@openatom.club>
Content-Transfer-Encoding: quoted-printable
References: <aP8P2H0qk0yJMPe3@intel.com>
User-Agent: Mozilla Thunderbird
To: <zhao1.liu@intel.com>
Received: from [10.13.14.160] ([218.81.29.112]) by smtp.feishu.cn with ESMTPS;
 Mon, 27 Oct 2025 14:51:36 +0800
X-Lms-Return-Path: <lba+268ff1679+c46e54+nongnu.org+chao.liu@openatom.club>
Content-Type: text/plain; charset=UTF-8
Cc: <chenmiao@openatom.club>, <hust-os-kernel-patches@googlegroups.com>, 
 <manos.pitsidianakis@linaro.org>, <pbonzini@redhat.com>, 
 <philmd@linaro.org>, <qemu-devel@nongnu.org>, <qemu-rust@nongnu.org>, 
 <richard.henderson@linaro.org>
In-Reply-To: <aP8P2H0qk0yJMPe3@intel.com>
Mime-Version: 1.0
X-Original-From: Chao Liu <chao.liu@openatom.club>
Date: Mon, 27 Oct 2025 14:51:35 +0800
Received-SPF: pass client-ip=118.26.132.18;
 envelope-from=chao.liu@openatom.club; helo=sg-1-18.ptr.blmpb.com
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
Thanks, hh. Paolo also provided many good suggestions regarding the
implementation of BusState.

>Only a few minor nits inline:
>
>...
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
>
>This can be named BusMethods - just like DeviceMethods did.
>

Thank you for pointing this out. I=E2=80=99ve noted the Rust In QEMU docs a=
lso include
relevant coding styles, and we=E2=80=99ll update the related naming convent=
ions in the
next version.

>> +where
>> +    Self::Target: IsA<BusState>,
>> +{
>> +    fn bus_realize(&self) {
>
>"bus_" prefix is not needed:
>
>dummy_bus.realize() is clear and enough.
>
Ok, qbus_realize() is internally called by the C part during object
instantiation, so there is indeed no need for additional exporting.

>> +        assert!(bql::is_locked());
>
>It's better to add safety comment from beginning (// SAFETY: xxx).
>
Get~

>> +        unsafe {
>> +            bindings::qbus_realize(
>> +                self.upcast().as_mut_ptr(),
>> +                addr_of_mut!(util::bindings::error_fatal),
>> +            );
>> +        }
>> +    }
>> +}
>
>Regards,
>Zhao
>

Thanks,
Chao

