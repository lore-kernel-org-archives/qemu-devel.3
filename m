Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F821C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRO-0006cp-GF; Fri, 21 Feb 2025 12:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRN-0006Z9-4N
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRL-0001O4-0c
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4D1rS6LJ8uetAUltK3BGbFAyS6KEzRUZM0URC1DoiWU=;
 b=O911rVMMswNSaWiTe8hl6fxnj1w9u2yUWFvepMUpFhxesuE6e/dZVpYRmj+gbNRUG0CfIW
 1gWt4S7BLryY3OBsZlBLzRt+ZsAjyKtzRMDRdYTQ7ut9MG/Vd8AKf3JqiAMBN+qEWlwE+s
 QW8OGREB+lC5XJpc2Lc3crfycWjHWFY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-CkVSUBb-NHqYtwpS5arO4g-1; Fri, 21 Feb 2025 12:03:46 -0500
X-MC-Unique: CkVSUBb-NHqYtwpS5arO4g-1
X-Mimecast-MFC-AGG-ID: CkVSUBb-NHqYtwpS5arO4g_1740157426
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so12161675e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157424; x=1740762224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4D1rS6LJ8uetAUltK3BGbFAyS6KEzRUZM0URC1DoiWU=;
 b=Ll28sObXdzBl2sp7Ug5BFy3BMjxY2h47wBAdlPC/kKGqEPm5BOLa2ICQsMWmiXxXcS
 MxeiQS9OZILfueMBouY1G/0OULAHQGa1VLVRwIRJKEIPAeQTaLGu7LT2YXSI8FsoucZ/
 bMYfI7aKKupbDCUd6n7ULhBrDw3taUVbjQK7nPLfJ7RXb1sUY9GNjYbUKCJFBF4ckQim
 cjBKrjFKDpl5PQOGu8+EsxYeKX15vTXgULwpwAQBB4jSE0DvC6BV74bZNkN/RARBZbX9
 74Q0v3cOhPGoWGoTGJoQs+wmAyXj+SQbk6l810DEEBvctV94CKFmejiC4i7vEDLaiFnD
 LQ1g==
X-Gm-Message-State: AOJu0Yxr/uwzR0u98GxQleX1xN0KJJ5eWrH+w3NHr7ZahsgPCBIqHlVc
 vIXN0LYduHKBANGW/zP5easNZSJhTYiWpSmYTY3spcO0kISXEqLuNg4EQbdLXY8EYX5j3jVvcTi
 IEFpcaXn4YYZNx29bR54TjpiWzcSFn5z3G4LeHu1OnAmTd3I6NwI9R9MxLiyArTj1aP9mdTm4M1
 aqeLqWnBeNFl0ty+seOVO4pUPi9PvVbLY+gCNyAr8=
X-Gm-Gg: ASbGncvczb8ysOU0gP4EPEqyHpVZuMiYFqHoAhZqTse6bV/tZX8k3RRVEnWgh2/LfLr
 aeP3Auf674XNrlW/hw1K7o2g0W2CPVnoicgWwmmBQtir6kHE19+kug2TCByQGUuAHDnUW/FKAZH
 XoLtAL5A10vm++TTYAULgcqHW/wyyRhlGzVz3g3Rt1eMmDDoXIZXWJbiuGcCMl0HaMPxNa0j+m8
 fKvp51e0j7Kq8RHyilr4TzMR6nRK6WXe/3z4ENQJ7ZFY1AL4HFsma9n7Omcn5GCDHJNPpCAuZxf
 2EOfm5dz7UU5+B2lnwo=
X-Received: by 2002:a05:600c:1f8c:b0:439:88bb:d020 with SMTP id
 5b1f17b1804b1-439ae1e66f8mr29825985e9.8.1740157424299; 
 Fri, 21 Feb 2025 09:03:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL1QNKtVNsYYu2DzODP1Qt6vrjg89Q9V0r6w2kBwKtZV0SF6/7qQPuZ1BBaJKO4gMQV70qJg==
X-Received: by 2002:a05:600c:1f8c:b0:439:88bb:d020 with SMTP id
 5b1f17b1804b1-439ae1e66f8mr29825275e9.8.1740157423525; 
 Fri, 21 Feb 2025 09:03:43 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce38csm23773225e9.6.2025.02.21.09.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:03:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 00/15] rust: prepare for splitting crates
Date: Fri, 21 Feb 2025 18:03:27 +0100
Message-ID: <20250221170342.63591-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series is logically split in two parts.  The first one is more
strictly tied to the objective of splitting qemu_api into multiple crates,
as it breaks the QOM bindings free of the constraints imposed by Rust
orphan rules.  The second one instead completes another task that was on
my todo list, namely ensuring that rustc sees the possible changes that
C functions can make when a shared reference &bindings::Foo is passed
via *mut bindings::Foo.

More in detail, patches 1-5 redo the QOM class init mechanism so that
it does not rely on the ClassInitImpl trait.  While ClassInitImpl is
very nice in theory, it practice it does not play well with classes
defined outside qemu_api (or more precisely, outside the crate that
defines ClassInitImpl itself).  This is because ClassInitImpl relies on
a blanket implementation such as

    impl<T> ClassInitImpl<ObjectClass> for T
    where
        T: ObjectImpl

and this is only possible inside the crate that defines ClassInitImpl.
With these patches the class_init methods move from ClassInitImpl<Class>
to the Class struct itself.  More precisely, before the series you
have

    <T as ClassInitImpl<ObjectClass>>::class_init

and afterwards

    ObjectClass::class_init::<T>

which is assigned to the CLASS_INIT associated const of ObjectImpl.
The problem is that even if CLASS_INIT is always defined the same
way, i.e.

    const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;

there isn't a way to tell the compiler that the above is valid *in the
definition of ObjectImpl*.  Therefore the above line has to be duplicated
in all subclasses; this however is a small issue and in the future it
could be handled by #[derive(Object)].

Patches 6-15 instead introduce a third generic type in qemu_api::cell,
Opaque<T>.  This type is similar to a same-named type in Linux; it is
basically a "disable all undefined behavior" switch for the Rust compiler
and it helps maintaining safety at the Rust/C boundary, complementing
the existing BqlCell and BqlRefCell types.

Apart from making things more formally correct, this makes it possible
to implement methods on a struct that is distinct from the one produced
by bindgen.  This has a couple of advantages:

- you do not have to disable the Copy trait on structs where you want
  to add a Drop trait.  This was already a problem for the Timer struct.

- whether Send and Sync are implemented is entirely a decision of the
  place that implements the wrapper.  Previously, a struct with no
  pointers for example would have been always both Send and Sync,
  whereas now that can be adjusted depending on the actual
  thread-safety of the Rust methods.

- more pertinent to the "multiple crates" plan, you do not have to put
  the methods in the same crate as the bindgen-generated bindings.inc.rs.

It also makes Debug output a bit less unwieldy, and in the future one
might want to add specialized implementations of Display and Debug that
are both useful and readable.

Paolo

Paolo Bonzini (15):
  rust: add IsA bounds to QOM implementation traits
  rust: add SysBusDeviceImpl
  rust: qom: add ObjectImpl::CLASS_INIT
  rust: pl011, qemu_api tests: do not use ClassInitImpl
  rust: qom: get rid of ClassInitImpl
  rust: cell: add wrapper for FFI types
  rust: qemu_api_macros: add Wrapper derive macro
  rust: timer: wrap QEMUTimer with Opaque<>
  rust: irq: wrap IRQState with Opaque<>
  rust: qom: wrap Object with Opaque<>
  rust: qdev: wrap Clock and DeviceState with Opaque<>
  rust: sysbus: wrap SysBusDevice with Opaque<>
  rust: memory: wrap MemoryRegion with Opaque<>
  rust: chardev: wrap Chardev with Opaque<>
  rust: bindings: remove more unnecessary Send/Sync impls

 docs/devel/rust.rst              |  36 +++--
 meson.build                      |   7 -
 rust/hw/char/pl011/src/device.rs |  44 +++---
 rust/hw/timer/hpet/src/hpet.rs   |   7 +-
 rust/qemu-api-macros/src/lib.rs  |  82 +++++++++++-
 rust/qemu-api/meson.build        |   7 +-
 rust/qemu-api/src/bindings.rs    |  26 +---
 rust/qemu-api/src/cell.rs        | 222 ++++++++++++++++++++++++++++++-
 rust/qemu-api/src/chardev.rs     |   8 +-
 rust/qemu-api/src/irq.rs         |  15 ++-
 rust/qemu-api/src/memory.rs      |  32 ++---
 rust/qemu-api/src/qdev.rs        | 115 ++++++++++------
 rust/qemu-api/src/qom.rs         | 203 ++++++++++++++--------------
 rust/qemu-api/src/sysbus.rs      |  45 ++++---
 rust/qemu-api/src/timer.rs       |  24 +++-
 rust/qemu-api/src/vmstate.rs     |   2 +-
 rust/qemu-api/tests/tests.rs     |  32 ++---
 17 files changed, 620 insertions(+), 287 deletions(-)

-- 
2.48.1


