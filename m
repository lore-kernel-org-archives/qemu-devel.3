Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FB5CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLV-000621-0n; Sat, 13 Sep 2025 04:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLM-0005zg-G1
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLK-00050n-BC
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfNF7of65e0ISpiPiVdlW59eULNiwvi00PI6EPOfXZE=;
 b=Ukan3f0u6zvUaPpVY5ZpTKKCEkNpfi2KZbo/4RdhAlsaIrptr10lSZzRmNwuugW9BAyTjG
 Dc/X6QHj4DQWuRwcf1VvPMlyrMPXl3WSyp56zl88UH30/aLdDIWaXsuCCy1uZuh5KIPvRM
 w/3PY7faKhxHL699lgknBkkW6EdI8Ow=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-DyOnHayRM4y5lTcwq6LcgA-1; Sat, 13 Sep 2025 04:10:42 -0400
X-MC-Unique: DyOnHayRM4y5lTcwq6LcgA-1
X-Mimecast-MFC-AGG-ID: DyOnHayRM4y5lTcwq6LcgA_1757751041
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3df19a545c2so1899794f8f.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751040; x=1758355840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfNF7of65e0ISpiPiVdlW59eULNiwvi00PI6EPOfXZE=;
 b=i+4RZSu0wl+0V4DwsLk0yVgSvrMH9Bcv3cTltj0pLLVOGBOdoifOE/Mvpf1yWJ0sWP
 WZ+8DhH382Aykyzvtnc07jD5iiIBb7IZnQgxjfJa2OzBL394gwm/FO4pl/qGuRCTd1zz
 6gzMe6vBETVJ5vLl4AswsSboPpnmzaF6NrQkwAJaBna70EPg2sDLA6YBWvhCSnwRwF2/
 C19TD6jXCK/hwOjzZophG/vaodkCnxwJ2QhcXqXRWxuNIXe1qqVdOiZdNSzyMUfzY0G/
 gxA2n2bqVnkS2uFE+D4udms04qt0Ev85+JfK1zNpN+jUGVHMkjiNVmquIaB1ep2p9PNP
 +9VA==
X-Gm-Message-State: AOJu0Yz7YKTMbtI/D9W16tTTGSJQM61BQcFTwiTtrec74ilQvMOJe0uz
 j0poOCV2hew11e5ZQWvK7PWlVpb8IWMLeKA9fx0HPerMDp5mUT98u7ssigy0UdSedk1MXm+qf7Z
 JQJhXAfjbE83lA5nNWJZctuZX2G4ksbQ/wEq0mDnpzukf2JxXQBTpKGTPso3UUDNr6XOtYGG8p4
 Dfm7/YQ4Sg/IInEgBTf2tODG/5sDkkRAJe3P3pyR+W
X-Gm-Gg: ASbGncsrD6veC6xxMgkeJx8rrCfsj0jXNmO7mW8BWstRYixKbCBszfqpDtHwGfOhu80
 pbRL8sgGgElkmL05WuJ7K79Qjun5vsFQR0P1a3ShwWgWXZHy4qft3mWnBJy+rpvG7uw9+fSN6eE
 PTWXD8LH3jpO3m4dTUaHdajneLdmmKNvwSHkvvJdm/lL8Dv2PlYhAi3LzQ7DyP+ohRQr9Shjfyt
 EJG6CtAHfGQkkPhJ1Njw1bcdPfQ8t0iroOievrfh99msflGgOYXMCv1eeLH1SlNESwGOtfKXSO+
 FXCUHen1O6BKD3ucz0+q7jv5fIYuZ1lTF5yM/7fXXe8yYeP08vgXh6Wxcn3lPD1VvIJ2byIUljz
 kWPu0s2NTurTwJwqB4h1+wbrtQ7ZTGj2lw/WAndIR4qw=
X-Received: by 2002:a05:6000:18a7:b0:3d4:eac4:9db2 with SMTP id
 ffacd0b85a97d-3e765782b5fmr6375096f8f.5.1757751040075; 
 Sat, 13 Sep 2025 01:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIx2Z9HfsZVuFRTh7uRWrqt1LHESeyttOtPUE1k8aqMDFmRPdvMb8UROAa6JgpLYUvZvM3Yg==
X-Received: by 2002:a05:6000:18a7:b0:3d4:eac4:9db2 with SMTP id
 ffacd0b85a97d-3e765782b5fmr6375065f8f.5.1757751039616; 
 Sat, 13 Sep 2025 01:10:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607cd27dsm9313599f8f.41.2025.09.13.01.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/61] ci: temporarily remove rust from Ubuntu
Date: Sat, 13 Sep 2025 10:09:01 +0200
Message-ID: <20250913080943.11710-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is for the purpose of getting an easy-to-use base for future
development.  The plan is:
- that Debian will require trixie to enable Rust usage
- that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
  (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318)

Marc-André is working on adding Rust to other CI jobs.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250908105005.2119297-2-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 83c2867295a..f01978fb40c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -39,9 +39,9 @@ build-system-ubuntu:
     job: amd64-ubuntu2204-container
   variables:
     IMAGE: ubuntu2204
-    CONFIGURE_ARGS: --enable-docs --enable-rust
+    CONFIGURE_ARGS: --enable-docs
     TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
-    MAKE_CHECK_ARGS: check-build check-doc
+    MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
   extends: .native_test_job_template
-- 
2.51.0


