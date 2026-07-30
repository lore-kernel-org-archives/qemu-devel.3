Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9E3C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLrq-0006a3-Ou; Thu, 30 Jul 2026 04:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpLro-0006Zr-AJ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:11:48 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wpLrm-0000QL-HL
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:11:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 3013FC0273;
 Thu, 30 Jul 2026 11:11:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:484::1:24] (unknown
 [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id gBaXtlMWC0U0-P1LzJ9PD; Thu, 30 Jul 2026 11:11:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785399102;
 bh=c0xAZE26ng6hAhkuq4NehBlB4FXE6K7LLsNNr85fKdc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pQSdMTEv/y8k1+SuqhNHFd4M5Va2cLoYT4QbWU5uIGyKMj/NTE4GSAP5SL0Uddqu/
 2FWIc54OYbiVptg8ws7EimD0YYdrDdEyFKZMcZbXsZsroHhYQf7IlcI8YMy5ja0V/S
 0M5WXDFfnBpGi5OD1G+H+mbrpWoaE3zNyuhrCklY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7ceba470-8416-475b-beca-a6c82daa4b4b@yandex-team.ru>
Date: Thu, 30 Jul 2026 11:11:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] migration: Remove redundant flags
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-4-farosas@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260729225227.1170574-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30.07.26 01:52, Fabiano Rosas wrote:
> Remove the VMS_VARRAY and VMS_VBUFFER flags that became redundant due
> to the previous commit which stores the size of the vmstate offset
> variables along with the offset itself.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---

[..]

> --- a/rust/bindings/migration-sys/lib.rs
> +++ b/rust/bindings/migration-sys/lib.rs
> @@ -47,6 +47,7 @@ fn default() -> Self {
>   unsafe impl Zeroable for VMStateFlags {}
>   unsafe impl Zeroable for VMStateField {}
>   unsafe impl Zeroable for VMStateDescription {}
> +unsafe impl Zeroable for VMStateOffset {}
>   
>   // The following higher-level helpers could be in "migration"
>   // crate when Rust has const trait impl.
> @@ -57,10 +58,7 @@ pub trait VMStateFlagsExt {
>   
>   impl VMStateFlagsExt for VMStateFlags {
>       const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
> -        VMStateFlags::VMS_VARRAY_INT32.0
> -            | VMStateFlags::VMS_VARRAY_UINT8.0
> -            | VMStateFlags::VMS_VARRAY_UINT16.0
> -            | VMStateFlags::VMS_VARRAY_UINT32.0,
> +        VMStateFlags::VMS_VARRAY.0
>       );
>   }
>   
> @@ -115,3 +113,12 @@ pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
>           self.with_varray_flag_unchecked(flag)
>       }
>   }
> +
> +impl VMStateOffset {

This looks like part of patch 01? And may be some other changes in rust.

> +    pub const fn new(off: usize, size: usize) -> Self {
> +        Self {
> +            off: off as u32,
> +            size: size as u8,
> +        }
> +    }
> +}

[..]

> diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
> index c2c12cfab52..c5baed4d40b 100644
> --- a/rust/tests/tests/vmstate_tests.rs
> +++ b/rust/tests/tests/vmstate_tests.rs
> @@ -65,7 +65,7 @@ fn test_vmstate_uint16() {
>           b"elem\0"
>       );
>       assert_eq!(foo_fields[0].offset, 16);
> -    assert_eq!(foo_fields[0].num_offset, 0);
> +    assert_eq!(foo_fields[0].num_offset.size, 0);

This too.

>       assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int8 });
>       assert_eq!(foo_fields[0].version_id, 0);
>       assert_eq!(foo_fields[0].size, 1);
> @@ -86,7 +86,7 @@ fn test_vmstate_unused() {



-- 
Best regards,
Vladimir

