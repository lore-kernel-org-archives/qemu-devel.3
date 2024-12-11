Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282E7E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPYp-0008Uh-Oi; Wed, 11 Dec 2024 11:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYl-000852-2d
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYh-0000Cz-JR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZDaJLaXxvNnfQSMhxbd05Wgutxnybe8yELIo6TkQK8=;
 b=jB8mf7PyQYyNx6g8o9sFHhJLzHK2mVNBjSRV91gML8Fgw8+rAV6H0zuFU0QfoC+oFb8ce4
 SrcB+WUAbt/8zw+fZO/Rf6uxWgcI9L4F1EL6af+FpZx7EmfJuWBLxc/7VX9IBHuf6al8az
 ld3s1dzbb7zS6NUJixY0hGywTjhg10Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ikiZBFv9OhWXBQCYIEKkRA-1; Wed, 11 Dec 2024 11:27:29 -0500
X-MC-Unique: ikiZBFv9OhWXBQCYIEKkRA-1
X-Mimecast-MFC-AGG-ID: ikiZBFv9OhWXBQCYIEKkRA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e1339790so4748292f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934448; x=1734539248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZDaJLaXxvNnfQSMhxbd05Wgutxnybe8yELIo6TkQK8=;
 b=eChwZEaZBcTpWzs64dwrQogZ4b15xbRoH9UdmWFFPyw8lT57v6RBPOdggPmF8iNXbg
 mqAmJz6czToStYPebbYjY7vWO+XaBM+TPCvhRCXj//Cvzhml7PnFpCzefF1g0tRusQ5m
 3KG/NLF3cAW4rzU+Tcfw62UN2I/IqSVzVW1jCaN4CCQIVuvLTukdiuEJnQIWiDNIfp8o
 wTkihBnNKImI8p8DHeh95HeR7V54iLnnVpP5iuJ/XkWMAw0uL8p4SACcWNTbqw6C8vsn
 duRwxTfxj67GbOte5rPXTX1LSN8cv6kS7oU9zCgOQASPqmudPnY4jpms6Qt9j/B+H/Lt
 QxDg==
X-Gm-Message-State: AOJu0YyT5XhfCzblnLuCB0/oNKa3hDu7L6Gdn9+vCdI0r62RfdzCEFax
 rjuREJMD7e7we5iWRdzEisSfNJrjeO+0+KTBbVuSBUv6gA2CH0ydu+bf6RXR00jL/wmqluBrE79
 iMbvpEBLbbxaeNaxSseGzo1zHCBS6TyVZ3qJaVrJYeZ/QZtZG1yMOOAQhN22e1R4UUBMHN6cEUl
 WdyYAYtSnG6li/nhzxbnfHI/8/dgWtqY8iJgrT
X-Gm-Gg: ASbGncvRMaa3wX75HaHcio0of3R2tQDrO+tzjw+B68/FnK+SMhH+7awVrcPSD+k1J45
 06wnOoi1MifO0jKQ8Nzfp4F7J3kADFxTMQIzzRDAlrEE/ahEz8l2q2Yy8h1p9V1VgT9sufyMy8S
 wJsMYHwslF23YMsEPIGyJZO4F6zNICn1/m1zbCXNXzt3LLgVn/zu4bztIC6MpZ4+/8Ml6YKErgN
 4v11A+k3z/3fSaLpdJwN5fCgcsik8yzyIDxQZGId43PLGzWBDC3kDg3
X-Received: by 2002:a5d:6da4:0:b0:386:1ab5:f0e1 with SMTP id
 ffacd0b85a97d-3864ce968c0mr3420058f8f.14.1733934447963; 
 Wed, 11 Dec 2024 08:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELYwlbdIdIUQ5HDugRJgsVK67zkR1rE8rwXy521OSPCaRokZLBnNJMXfZ/4Sz955gYYC3iaw==
X-Received: by 2002:a5d:6da4:0:b0:386:1ab5:f0e1 with SMTP id
 ffacd0b85a97d-3864ce968c0mr3420029f8f.14.1733934447531; 
 Wed, 11 Dec 2024 08:27:27 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434fc530a2dsm89229625e9.11.2024.12.11.08.27.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/49] rust: apply --cfg MESON to all crates
Date: Wed, 11 Dec 2024 17:26:32 +0100
Message-ID: <20241211162720.320070-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

We might have more uses for --cfg MESON, even though right now it's only
qemu-api that has generated files.  Since we're going to add more flags
to the add_project_arguments calls for Rust, it makes sense to also add
--cfg MESON everywhere.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 7 ++++---
 rust/qemu-api/meson.build | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 147097c652e..c35ce64cd61 100644
--- a/meson.build
+++ b/meson.build
@@ -3422,10 +3422,11 @@ if have_rust
   # is safe; https://github.com/rust-lang/rust/pull/54675 says that
   # passing -nodefaultlibs to the linker "was more ideological to
   # start with than anything".
-  add_project_arguments(rustc_args + ['-C', 'default-linker-libraries'],
+  add_project_arguments(rustc_args +
+      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
       native: false, language: 'rust')
-
-  add_project_arguments(rustc_args, native: true, language: 'rust')
+  add_project_arguments(rustc_args + ['--cfg', 'MESON'],
+      native: true, language: 'rust')
 endif
 
 hxtool = find_program('scripts/hxtool')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 6f637af7b1b..cad9ac4844e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,4 +1,4 @@
-_qemu_api_cfg = ['--cfg', 'MESON']
+_qemu_api_cfg = []
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
-- 
2.47.1


