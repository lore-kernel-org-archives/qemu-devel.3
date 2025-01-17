Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3537EC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiDw-0001pq-9n; Fri, 17 Jan 2025 04:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiDs-0001pF-6G
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiDm-000828-8p
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lochbdNwgn2xiZvOYaiCH7K0XCGeWnITWJQQX3Wahbs=;
 b=KC72wE1djLjpf0wCNVUTTw1xWw8xmd8hJvmMQGmmT0bXpW3haY3NYnzBupg2y0fjH++8f1
 mSvyiFqgWb5OAm2hrjCCtFmp4pfB6GfbsXtW+s93+YT5+kSHfCI39Zje37IwC1KGZuSAdU
 ZH+RpyyUdje1kxOR/4ut1sEtVjxKu6g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-_uw4hkzgOpC7Gv7UEDcs_Q-1; Fri, 17 Jan 2025 04:00:52 -0500
X-MC-Unique: _uw4hkzgOpC7Gv7UEDcs_Q-1
X-Mimecast-MFC-AGG-ID: _uw4hkzgOpC7Gv7UEDcs_Q
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa68203d288so144594466b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104450; x=1737709250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lochbdNwgn2xiZvOYaiCH7K0XCGeWnITWJQQX3Wahbs=;
 b=dpDmrh3/hGSbSGrasSnTRfqEB5PoDLPVV/jUdVD9u5vpR3mGPbkQ77KsXAnV0yeZHD
 lX6RC1HGkNo42hcEIh9FfyoSRai0MwMhraWMo3IspgXVY+wmFPLZEUVCbqpO/SYjABKJ
 DvLtOJwy86MoQ1BA8qThYFh4f2D2oeLyMszsTzN4/SN5VapsjgdRiD6qOz0OH0NZNa3N
 JLYD0rr9iLneNJRWiR0z5ftDT0L2u8Y9ZMZUjDUORUeiQfhZhYoziI6tKCM5LfvcXL+2
 7TwTHynYF7ed0mWbYJT8iL9JXgrWkLvjZl9XpPyt24taCKosZAAEeTo//7kShWyfXAka
 IonA==
X-Gm-Message-State: AOJu0Yz70pPofjv6A3BHEMz3u9Am6rwZVpwRQNGVLj6w1mOGClJueVYB
 rMkIHBUf0/lwcMopntqTKm6kpGVUmSHXqeO/39jEbn7gqFrg7TZqVEFBFHdLBFoT8EiKmxQLya9
 hZk1NIJnSnS0tu6FbCyuQw7VLw38aRLsH5xq6Smwxy+zAgMNN1v6ptIzuxry0mMfDmTIo9gXP8j
 +LSwAqfDyX7wxBKV6Xm9vn6ID7nGOzFR1Cs4eINrI=
X-Gm-Gg: ASbGncsLx+EFWt8c6MflHkmi9iMPLRZOrdbJrSt7suD3JXhVRkGpxNfQRSU8WHthSwX
 IVzVeq7JirNdZ2oFwrbd9+82jU+W8E1fF+VET7ymFLWccZxz1kVIlkh0pONdDEmRewfdNrSCzfR
 CVV9ZF67BKbvh2sEuauU4qtdPfwXoVS+GVhJXLYY9PHGnKoDMYnDv16iCyHMOwN79Xj4acIQYNh
 nGLaElBriaKKNvzhUYgeU1BHK9hrtK9a7DuvX4rCwGiD8ohiNwlEbeV7wUr
X-Received: by 2002:a17:907:d9f:b0:aa6:7ec4:8bac with SMTP id
 a640c23a62f3a-ab38b1100c3mr185350466b.17.1737104450091; 
 Fri, 17 Jan 2025 01:00:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVqysmZdh7m+Yxpv5bZN7QirBE8CFDC3dWjk3FJjb/61G4m9IY/jAcuPz+/uZzGNNqNRK7zg==
X-Received: by 2002:a17:907:d9f:b0:aa6:7ec4:8bac with SMTP id
 a640c23a62f3a-ab38b1100c3mr185345866b.17.1737104449556; 
 Fri, 17 Jan 2025 01:00:49 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcb262sm133248166b.169.2025.01.17.01.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:00:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 00/10] rust: (mostly) type safe VMState
Date: Fri, 17 Jan 2025 10:00:36 +0100
Message-ID: <20250117090046.1045010-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The existing translation of the C macros for vmstate does not make
any attempt to type-check vmstate declarations against the struct, so
introduce a new system that computes VMStateField based on the actual
struct declaration.

Macros do not have full access to the type system, therefore a full
implementation of this scheme requires a helper trait to analyze the type
and produce a VMStateField from it; the trait stores the VMStateField
as ana associated const.  Then, a macro "vmstate_of!" accepts arguments
similar to "offset_of!" and tricks the compiler into looking up the
trait for the right type.

Structs and cells have their own sub-VMStateDescription.  This poses
a problem in that references can only be included in associated consts
starting with Rust 1.83.0, when the const_refs_static was stabilized.
So for now structs and cells cannot be done in a type-safe manner,
but arrays, pointers and scalars can.

Technically, scalar types have the same issue in that they point to a
VMStateInfo.  For this case however there is onlyya limited list of
VMStateInfos, so I am placing them in an enum, and going from enum
to &VMStateInfo only when building the VMStateField (i.e. in a static's
value rather than in an associated const, and in a macro rather than in
a const fn).  This isn't great, but it's easily removed when QEMU starts
accepting a newer Rust version.

The series also introduces the pattern of applying changes to a struct
using methods with a fn(mut self) -> Self signature, for example

    pub const fn with_version_id(mut self, version_id: i32) -> Self {
        self.version_id = version_id;
        self
    }

This is not quite the builder pattern because there is no need for a
final ".build()" call, but it's similar/related.

The unfavorable diffstat comes half from the const_refs_static workaround,
half from new documentation (so in that case it's a plus rather than
a minus).  And also, there is more functionality and extensibility in
the new mechanism, whereas only a subset of the C macros was included
in the previous implementation.  The exception is "field_exists", which
may be added later if needed as a modifier, similar to with_version_id().

Paolo

v1->v2:
- add attribution for call_func_with_field macro
- add VMS_VARRAY_FLAGS, check it in with_array_flag
- remove Option<NonNull<T>> support, add Box<T>
- fix cut and paste typo in vmstate_varray_flag
- fix rustfmt
- move SCALAR_TYPE definitions to the right patch
- keep $num as an ident rather than tt
- remove vmstate_cell
- make order of parameters consistent in vmstate_clock (last patch, new)

Paolo Bonzini (10):
  rust: vmstate: add new type safe implementation
  rust: vmstate: implement VMState for non-leaf types
  rust: vmstate: add varray support to vmstate_of!
  rust: vmstate: implement Zeroable for VMStateField
  rust: vmstate: implement VMState for scalar types
  rust: vmstate: add public utility macros to implement VMState
  rust: qemu_api: add vmstate_struct
  rust: pl011: switch vmstate to new-style macros
  rust: vmstate: remove translation of C vmstate macros
  rust: vmstate: make order of parameters consistent in vmstate_clock

 rust/hw/char/pl011/src/device.rs       |   3 +-
 rust/hw/char/pl011/src/device_class.rs |  38 +-
 rust/hw/char/pl011/src/lib.rs          |   6 +
 rust/qemu-api/src/prelude.rs           |   2 +
 rust/qemu-api/src/vmstate.rs           | 700 ++++++++++++++++---------
 rust/qemu-api/src/zeroable.rs          |  31 ++
 6 files changed, 504 insertions(+), 276 deletions(-)

-- 
2.47.1


