Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B373C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEa-00031M-FF; Fri, 21 Mar 2025 14:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEV-0002jO-Kf
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhET-00074W-Ur
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rl3sbMh8PhcAXlK/9RiOT6GC/ca8o4XQipdBcUVoe2k=;
 b=Wi+xg3z/NpJdTdvTVvFqt3jJoNX2YqAA4Q3jeeXXfGzqYPMqOaH/1OFZolspwlc88HA/qM
 6SmnFHeJlNZxLAln49gx+5TvZl17xP9T/TY76Lar7t/fddzHxpWLHmHmPpkpGONLMqPiDK
 FotPumH39mC/w/H/2fdlH0qFJpT24eE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-NdrRkrCZMQ6Pu6RnJx8VIw-1; Fri, 21 Mar 2025 14:36:35 -0400
X-MC-Unique: NdrRkrCZMQ6Pu6RnJx8VIw-1
X-Mimecast-MFC-AGG-ID: NdrRkrCZMQ6Pu6RnJx8VIw_1742582194
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so1123809f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582193; x=1743186993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rl3sbMh8PhcAXlK/9RiOT6GC/ca8o4XQipdBcUVoe2k=;
 b=gDyAe455l4EroEyAIQq8rmiwYPDXKakQOUf1u8SpbByTwwR68daUjVSg/Zm/8r+gZU
 hZt4y+ktboEvqilzBYltPwON1fmwfK22Gs7hEaqcSOOy/7Q4QqZLR3KYnDRlaOwHESWU
 1oXdS94+kllZXzvmldyd0loYXvmEoHlc6ZrptA5ixX+DpBJdDa6w3t+lUpuSibYXHTji
 EeL6YkqkqZ8INppc39bAyj5SZkMYvadf/OgaRy41/L11dkTVhd93qOQA796JZy4JkJpK
 IgZ8Oeax9q52358QM5Sq1BcomFrU0Tfr+0FeS033KCkqSDvWGuJBd1hcvcdzZ7WASmgC
 7Ebg==
X-Gm-Message-State: AOJu0Yy+SJtArxZRBzJ9vxCwXOu2mzqDqRUoPBwSP2tH7EoA2IoWqFCD
 q/5/NiN2YtFJ2YyBtlYL3qfzNvhc4yypicnndMiNnKqJ/u0UPT86bzwUhfXhGitQgLsMd2SaALH
 rSPEXzT/ZlMGepsC5RNWwxJBcDidYr4xNLAIrdqkOyncE2UrC8QjT3NjGf4cT+/OVmfnHQ3Lvh7
 tJrttyTJvGvHECQjMa9ubeEA5kWFsSmSA/xqkE
X-Gm-Gg: ASbGnct416vmpFCUwxBZJ8deusQtJcro5/RvTP/1NpN+qY9nwNq3SIuQcuSBzbKNiE8
 d+53HOl9256G2v0DdVHywts5/UjGGniqU2G0x2Qu/oDNM1QW8b6XBOovonXr+u7Sdk8/RywntTm
 DwC9QXYdRlKPE9GbTViVx6eXeGAcMOSfjEhs9oDfwPF2OowGKkJfUo8v+DHei5bCVXEHuCjMHR4
 Cg1WHp2uDlfXdZNY36z1UovkrOo/ooy/78L42icvjpzZ3kTXKcSjp12KB9pB+CVqC2m/NIkWIip
 ygGo9NtAHX/W2McoK239
X-Received: by 2002:a5d:6daa:0:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-3997f93c45dmr4407475f8f.25.1742582193217; 
 Fri, 21 Mar 2025 11:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyDzmnhNDpG1ZtLgqb789d242m21SkmGRHkW67zEKYXpF2BEkDjNyzf/gxquGzjkZwSd3R9g==
X-Received: by 2002:a5d:6daa:0:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-3997f93c45dmr4407456f8f.25.1742582192708; 
 Fri, 21 Mar 2025 11:36:32 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9956b4sm3021725f8f.7.2025.03.21.11.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/24] rust/vmstate: Fix size field of VMStateField with
 VMS_ARRAY_OF_POINTER flag
Date: Fri, 21 Mar 2025 19:35:44 +0100
Message-ID: <20250321183556.155097-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The `size` field of the VMStateField with VMS_ARRAY_OF_POINTER flag
should stores the size of pointer, which depends on platform.

Currently, `*const`, `*mut`, `NonNull`, `Box<>` and their wrapper are
supported, and they have the same size as `usize`.

Store the size (of `usize`) when VMS_ARRAY_OF_POINTER flag is set.

The size may be changed when more smart pointers are supported, but now
the size of "usize" is enough.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index e3233303f20..e2a1f7a97aa 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -256,6 +256,10 @@ pub const fn with_array_flag(mut self, num: usize) -> Self {
         if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
             self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
             self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
+            // VMS_ARRAY_OF_POINTER flag stores the size of pointer.
+            // FIXME: *const, *mut, NonNull and Box<> have the same size as usize.
+            //        Resize if more smart pointers are supported.
+            self.size = std::mem::size_of::<usize>();
         }
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
         self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
-- 
2.49.0


