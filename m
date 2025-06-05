Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA93C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7ZR-0003yp-CU; Thu, 05 Jun 2025 06:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZO-0003y4-Pb
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZM-0000To-CH
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xGJok4ar4KVyPbGQlvZ9sR0i7cZSDEGPhs8lHacKmKo=;
 b=NJJs+5h9c8SXCtG8BQult5tdhNDGtm4tDGvJndUcoYHrOdvAdBJDkjV8mA83jlN8pEiera
 mVycTHuB7Y+hirzTJiunqf6FGqk6Khug+wlJOLOjObBkKPlNBHWw9Onr5MI2aJx3X19jkB
 gK9hcO9lgnXeZ8LyjH0DcrsHP/BT1X0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12--EYrsoafOQqDFgynfFZwiA-1; Thu, 05 Jun 2025 06:11:29 -0400
X-MC-Unique: -EYrsoafOQqDFgynfFZwiA-1
X-Mimecast-MFC-AGG-ID: -EYrsoafOQqDFgynfFZwiA_1749118288
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450cb8ff0c6so3605185e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118287; x=1749723087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xGJok4ar4KVyPbGQlvZ9sR0i7cZSDEGPhs8lHacKmKo=;
 b=OcP1fG5bJsguKt8UgxlRQMoo7SXc2/KnPV03s6WloxZ9JzGEq6uVRFm8s1tb2YgpTZ
 DzEJp6butefnR9pnPb+TlJbWCxo+VQQYQC2pbavFAQo1/vOlSUOXqAAudj3Wye6qTz5V
 RnL9w18eq1BphmaUikKvsuiFXBYFAc6Fh+sTLPhCBnG8pSYAAjqU2Sici5pU292WpXoy
 2LvVqJ7O1Gqsw2nMPDi91eSZuxXgNwYVMic9mtTs49Yj6isMBbUOXB3hDeY+hp8NAk9d
 Y078DXB/eewCfDjo3/N9W4seRvMIa7+JRbPBJP+UrPrNHglJI7ojUoYFCEuTBR4F4Yl2
 7R9g==
X-Gm-Message-State: AOJu0Yy/SWvhrJiVgGX9x3DQA6Fb5cXJRT9OH7AFLIK9wn3GxYA4mmAm
 n5SmQcwIYzpJPLI1xmLweL0kvNU5UI0A2x34jCSDESyQE6y5pOWxUcP8ySKnk9a0gO2BhiZw9UH
 P07V8ksvnMV0XznzKXUjCopifgxQlLzB874tFKhczdnmThs7jnSH3B3P/O1+P3Pi1vzDChil+uL
 CygKuSK0A55spiUd3xLW7Jh/Omdqap58WaQqZrZKqZ
X-Gm-Gg: ASbGnctQ5SKya7/C/lLGvJw6hm9aYjO9HlQ6VAGRDet2DW+zSzzMcKYcqVOvONVSDC6
 xTmS02TwO572oHbWav5OxiWnEDEIb2usF7qpSjz4D/s7UjVCR0hSzmFWYBUlStLCHHwr4K/XdFq
 bg8Zj+J2+6ZOwBZW2wIq+/rwu6GQAEaKkM34Fv/in+v64Yty8E3Z07O1dkFhjTnPjydTjZ8lXKz
 sUcPRmsDCyjaLvCONWAnn+9zL+K8gnrGuQVo9HcsRaCVdQTVAPVtuDaoSWeKU6JOsaEkRq+6DT8
 6okQfN7SZCM2HyZmxwxQm9pP
X-Received: by 2002:a05:600c:1c29:b0:441:d437:e3b8 with SMTP id
 5b1f17b1804b1-451f0b256e6mr51276525e9.23.1749118286670; 
 Thu, 05 Jun 2025 03:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcYpNOknwHhCDppbGuTnWbslbd758u7i1B1Whn61rsJvLpSAYC0WWvq4h43N730ICCbToKsw==
X-Received: by 2002:a05:600c:1c29:b0:441:d437:e3b8 with SMTP id
 5b1f17b1804b1-451f0b256e6mr51276175e9.23.1749118286143; 
 Thu, 05 Jun 2025 03:11:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f9662cd1sm19986725e9.0.2025.06.05.03.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:11:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-rust@nongnu.org, armbru@redhat.com,
 mkletzan@redhat.com
Subject: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
Date: Thu,  5 Jun 2025 12:11:21 +0200
Message-ID: <20250605101124.367270-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is just an extremely minimal extraction from the patches at
https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/,
limited to generating structs and enums from the QAPI schema.
It does not include them in any crate and does not compile them.

While I'm not going to work on this, I was curious how much work it
was to produce *some* kind of Rust QAPI struct, which could be a first
step towards using serde as an interface to C visitors, like this:

trait QapiType: FreeForeign {
    unsafe fn visit(v: bindings::Visitor, name: *const c_char, obj: *mut <Self as FreeForeign>::Foreign, errp: *mut *mut bindings::Error);
}

fn to_c<T: QAPIType>(obj: &T) -> *mut <T as FreeForeign>::Foreign {
    let mut ptr = libc::calloc(...);
    let mut ser = QapiSerializer::<T>::new(ptr);
    obj.serialize(&mut ser).unwrap();
    ptr.cast()
}

unsafe fn from_c<T: QAPIType>(obj: *const <T as FreeForeign>::Foreign) -> T {
    let mut de = QapiDeserializer::new(T::visit, obj as *const c_void);
    let value = de::Deserialize::deserialize(&mut de).unwrap();
    de.end().unwrap();
    value
}

/* Generated code below: */

impl QapiType for UefiVariable {
    unsafe fn visit(v: bindings::Visitor, name: *const c_char, obj: *mut bindings::UefiVariable, errp: *mut *mut bindings::Error) {
        unsafe extern "C" visit_type_DumpGuestMemoryFormat(v: bindings::Visitor, name: *const c_char, obj: *mut bindings::UefiVariable, errp: *mut *mut bindings::Error) {
        unsafe { visit_type_DumpGuestMemoryFormat(v, name, obj, errp); }
    }
}

impl FreeForeign for UefiVariable {
    type Foreign = bindings::UefiVariable;

    unsafe fn free_foreign(p: *mut bindings::UefiVariable) {
        unsafe extern "C" qapi_free_UefiVariable(p: *mut bindings::UefiVariable);
        unsafe { qapi_free_UefiVariable(p); }
    }
}

impl CloneToForeign for UefiVariable {
    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
        OwnedPointer::new(qapi::to_c(self))
    }
}

impl FromForeign for UefiVariable {
    unsafe fn cloned_from_foreign(obj: *const bindings::UefiVariable) -> Self {
        qapi::from_c(obj)
    }
}

The FFI types could be generated by qapi-gen, as in Marc-André's
proposal, or from bindgen.

I am not sure what approach is better---whether to use serde or to
automatically generate the marshaling and unmarshaling code; and whether
to use bindgen or generate C-compatible FFI types---but it made sense,
from the point of view of extracting "some" code from Marc-André's
proof of concept and enticing other people, :) to start from high-level
types.

Paolo

Marc-André Lureau (2):
  scripts/qapi: add QAPISchemaIfCond.rsgen()
  scripts/qapi: generate high-level Rust bindings

Paolo Bonzini (1):
  rust: make TryFrom macro more resilient

 meson.build                     |   4 +-
 rust/qemu-api-macros/src/lib.rs |   7 +-
 scripts/qapi/backend.py         |   4 +-
 scripts/qapi/common.py          |  16 ++
 scripts/qapi/main.py            |   4 +-
 scripts/qapi/rs.py              | 183 ++++++++++++++++++
 scripts/qapi/rs_types.py        | 320 ++++++++++++++++++++++++++++++++
 scripts/qapi/schema.py          |   4 +
 8 files changed, 535 insertions(+), 7 deletions(-)
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_types.py

-- 
2.49.0


