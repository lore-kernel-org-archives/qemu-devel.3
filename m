Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991CCD1039E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mmu-0002M0-K0; Fri, 25 Oct 2024 12:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MmZ-00029q-8O
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MmV-0004qX-MB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDYuK9gssUSWouiyNUfyuA4WH+J2VX1Jg4Z7natGato=;
 b=AUoDnLUTgF/8IT7REyb50dfQIM/r89jyrJWHWuvPhbOMdKUnl8cWNe4R9JIzf8m3A9DgCy
 PTGP9O1WKXdsEhYDtKkRCIu3vmVUPfLqiZMKixIaW2JqBkwg0AFP312R2GvHa+1JK6y5UG
 75DHtZEbPYDXquQAdykyHOjNktoXJDw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-WbWbFuuYPN-qk1V1iCH0pQ-1; Fri, 25 Oct 2024 12:03:14 -0400
X-MC-Unique: WbWbFuuYPN-qk1V1iCH0pQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a9a157d028fso85330766b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872193; x=1730476993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDYuK9gssUSWouiyNUfyuA4WH+J2VX1Jg4Z7natGato=;
 b=IZ6HJqoBc1JaJ1tRlBPQHrjUe3j28HYo1paDrnfDb0ko9F2gPprV5+BVkKhqcN7KAT
 6HzizHmyL0XjuiecXhvQftgT2uuP5rbTzOI36RYRvVRc2H7W0OGc+e3asVgbEXRZkuS5
 0u4tkvyZKQbxkBjDM73k/+nmEvKeTz73HtVJFbucQuosbzNIE1Vx0K2timj32KyrbPIQ
 mEhRatJ4y/Yf2k+jAycfHXkEzt32V+O5PAZ8hcBrUZEn8O5L0JAwmCXyAQoxQf4u/p4j
 pTOhUKXFi80frdjZCnL/98/Zw/a1lTbX6GuIKhO+MXhhazJXeDi3aK0FonvAXkLxXVMT
 QoDA==
X-Gm-Message-State: AOJu0Yzfe1K7gDPrZW4QxZvMUuM86zmN39vAvvWP9HtdNzSY6hHyGWzm
 HH1peZKNG8zvdDyTRJOvH8X1ktelngyjWKCuRyBpC2jMmsH9YVKSEHNoKZUo01PMyZjyh1px5Aq
 4sWCoH/NZe85OmtWh2pB5/lk8zhyAmTBSFW+OfMew1s9bLpCtE/JUEz0j7d/rbp+ueXP7EnGQ1J
 U3Hf8PjMt8UoguKR7xWGd6uhbl65BPFcCbC/kxZ3I=
X-Received: by 2002:a05:6402:e85:b0:5ca:ef8:bff8 with SMTP id
 4fb4d7f45d1cf-5cb8b28ecf9mr10555642a12.33.1729872192629; 
 Fri, 25 Oct 2024 09:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9tY32/KpL413ToKYTKOpkoo1H3ehqqRaC03JWMM5R5s37sAyef4a7zbNaf5aMUWMl8bCDHQ==
X-Received: by 2002:a05:6402:e85:b0:5ca:ef8:bff8 with SMTP id
 4fb4d7f45d1cf-5cb8b28ecf9mr10555589a12.33.1729872192154; 
 Fri, 25 Oct 2024 09:03:12 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb6255be3sm759977a12.3.2024.10.25.09.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:03:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 09/23] rust: fix cfgs of proc-macro2 for 1.63.0
Date: Fri, 25 Oct 2024 18:01:54 +0200
Message-ID: <20241025160209.194307-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replay the configuration that would be computed by build.rs when compiling
on a 1.63.0 compiler.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/packagefiles/proc-macro2-1-rs/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subpro=
jects/packagefiles/proc-macro2-1-rs/meson.build
index 818ec59336b..8e601b50ccc 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -15,7 +15,9 @@ _proc_macro2_rs =3D static_library(
   rust_abi: 'rust',
   rust_args: [
     '--cfg', 'feature=3D"proc-macro"',
-    '--cfg', 'span_locations',
+    '--cfg', 'no_literal_byte_character',
+    '--cfg', 'no_literal_c_string',
+    '--cfg', 'no_source_text',
     '--cfg', 'wrap_proc_macro',
   ],
   dependencies: [
--=20
2.47.0


