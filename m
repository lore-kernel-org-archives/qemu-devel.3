Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83875CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEz-0006rl-AA; Tue, 14 Oct 2025 09:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEf-0006AH-Ng
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEV-00018v-AX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DH1bizREULH/WG9xuqrDeS8NQ+ogE+YNguyt7l1zqcg=;
 b=Lh8/JBh6z6t6SDHz7dyuH6iv5BEFmEBOSsEkAh65STnnZ4ZGkYhtg3EUbWbt6IW0TlR77z
 H299qm4ZZdv53WFPwUadAtlS0gWJdyxdt7GuE4av/lhw93YmO9ZRnPWPOvKOie8Nmbi+O0
 luoQP5p3mHu15QAAaVP+pdLv4eWHLSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-n59sMFHnNRuoO7IkcmHoxQ-1; Tue, 14 Oct 2025 09:38:22 -0400
X-MC-Unique: n59sMFHnNRuoO7IkcmHoxQ-1
X-Mimecast-MFC-AGG-ID: n59sMFHnNRuoO7IkcmHoxQ_1760449098
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3af78819so27849765e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449097; x=1761053897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DH1bizREULH/WG9xuqrDeS8NQ+ogE+YNguyt7l1zqcg=;
 b=YBkMGSbFtrIE/jZmKS0swlpMNuTCXBj7Rc7w9TjRmG5HRXv0RDpJy/mvTDQ6MMss0f
 RfDX87dPfn5XFC49k0rLNIWt6vIxVRn9upuA9y9DZNnBx5Srx/ErhBQd3EWeinv2A/U7
 hwcduRLrrmlpMn+f20OtXyAJ22b7LQbp2zqX6e6bJGfui/mJJUzTAexj+RTJU67j4RY3
 AHJed4DKL1onOv8k8PSj2Pc2OTWt8A0xUBzkedUjvv5hFUIrMnApLPNI2upCO6zzJ8SI
 fRFKDwj7b58R4zxvzEah3fDhGnUFw9axb9B4Re4kODvyD0ubEFimOtJe33d2a0hPq9fY
 rLiw==
X-Gm-Message-State: AOJu0YwFTtEhsZ9feUeR3hLBvA7PCB/GpJ8cBaXl6ovjwTJyRh2bdcn6
 Rl3WnulggNjfOcDeyZcB8hf6H0WvWOqRyBXgOD/LuGvHdcqOHHH71+ZAw0pSVvWpvOqEgxSAkJQ
 NrNNXvoMC23yRa+I7nJ3eOzKzn1PvsVrpOTKc/WI/g0BCe5f1fAUnVyIaP7YNn8wnmRJieHBAfZ
 G+kyw/NdFINP+c/Q+N1jYHi1YgyU0RxjhM+n/qxDL7
X-Gm-Gg: ASbGncts4VniYrh0Ndryrf4WMUR5wXTOHXKiMYY+rAfsz0AdKr+yiMfpXKdqOXRFGVT
 FIhbOo9p7n9i+cJ26X+8YUJyKbMeMd+FdKyu11NUvZEbyPaWv9oi4R2kbpqacUBHm6gy+0a4W5z
 shuTviXyPtwKGqbEax8aIY6iELajdmXQEUjcvNutMyfwHuYo+zqsdQ466xnSDEeQm0ZRHCmmcbk
 BvvuvYIQmBy+69rs3GkMj/s2ZHgboTLmeT0gWlE1UCXALmQg8LwL0m7P70DsuOmwkF6hRHEN3qO
 IGF2sUtk9DTwvBaRhKvvB7rA/aMyjRunQPf+zYjUnKo4efMJtU8JOLWw5zGD+DEdrlb63pdGeUJ
 fvrVixUlCFVoVGtjNJsaZ6XRRYTHnjggwWs7OBbtcf7U=
X-Received: by 2002:a05:600c:8505:b0:46e:67c8:729f with SMTP id
 5b1f17b1804b1-46fa9a9447cmr171105315e9.7.1760449097312; 
 Tue, 14 Oct 2025 06:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYOztwgOT13rvHE2mf5PxBGljnRR/9sEXVPvfu/1TCK5dYzLqcGyUVoCC7ZxX21bxQcSXbfQ==
X-Received: by 2002:a05:600c:8505:b0:46e:67c8:729f with SMTP id
 5b1f17b1804b1-46fa9a9447cmr171105175e9.7.1760449096929; 
 Tue, 14 Oct 2025 06:38:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583424sm23447160f8f.21.2025.10.14.06.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/28] rust: migration: validate termination of subsection
 arrays
Date: Tue, 14 Oct 2025 15:37:07 +0200
Message-ID: <20251014133713.1103695-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For consistency with fields(), validate the value (at least to some extent)
before passing it to C.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index a6ee7e93853..6b0f96c4da8 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -675,6 +675,9 @@ pub const fn fields(mut self, fields: &'static [VMStateField]) -> Self {
 
     #[must_use]
     pub const fn subsections(mut self, subs: &'static VMStateSubsections) -> Self {
+        if subs[subs.len() - 1].is_some() {
+            panic!("subsections are not terminated, use vmstate_subsections!");
+        }
         let subs: *const Option<&bindings::VMStateDescription> = subs.as_ptr();
         self.0.subsections = subs.cast::<*const bindings::VMStateDescription>();
         self
-- 
2.51.0


