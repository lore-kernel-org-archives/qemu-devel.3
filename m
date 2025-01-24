Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0FEC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGH3-0008O2-Hr; Fri, 24 Jan 2025 04:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFp-00074D-FE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFk-0003u3-3t
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JnJ4uWdXLKH0BSsQ/cswZ3Sl3lzRSubbNSrDL/OSsc=;
 b=IJ0+zQyqP4nt7ZT/McAfOfU0+yDlRsijfdJ8TzQcUXN+uqW39DQ9dxeQoedzDGQbGpL29c
 +33FNM4ZLiUdx6wDtfBMUntx27OEpON4lhiZvLCcKhduIKhhrXaal9G7GtehTN8rgPIi8P
 Wy31fqZT+OjAuxy+DhaqADqZZBPnW9w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-o3gp6_WuNdCDUSH75oRt1A-1; Fri, 24 Jan 2025 04:45:25 -0500
X-MC-Unique: o3gp6_WuNdCDUSH75oRt1A-1
X-Mimecast-MFC-AGG-ID: o3gp6_WuNdCDUSH75oRt1A
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so1028618f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711923; x=1738316723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JnJ4uWdXLKH0BSsQ/cswZ3Sl3lzRSubbNSrDL/OSsc=;
 b=fI9WaGXarkiSarFvs9AE9ExkTjE8FbuGfDg2f73KVLcb0hztVM9c1v9jh3x3tIP9Lo
 RYXlt9VMHQRitGrDyTYuD0Ab848wwjOtIzJIkGGcQz5+qQtTDWfF1c3CXyjj+tk3f5nE
 WkWogN1TsPJ/JHfM/hdSHTBdpWckxDbD5PLJq05uyA2qU+3+hTHYlluYDpOF6A18H6kX
 wlzwhJYhdc8xFs4Us/Pzu9gH+vbiLMn16MhpMb5xtz2xQbksbd1/oEzoEo6G7xlxnTQ7
 RWL+9ttsW0oHdNVx6jF9S1hG24dRvAYYWh/ZHWBr5bC0QfMcOkxDPsZN58H1z7tg1iWa
 by+w==
X-Gm-Message-State: AOJu0Yy6PnuPa1bfCNqOoQFar2kZgULHoYwbqvGfw63t87trl3b+zBxr
 d66Um6swzJy8+ermiiiN4ktx/WgcnuZtPjTqpEZsVFb5Z8T0VaZcjwWIQryey/3MTep6qVc2Z0z
 psj+wJ0m9eahI0F6rHx6EKE390UheUMvhqBxUWXje9/VqvqvJ4HAIbiShha51ZoP1kVn3GT36RX
 2RjTaVSdA9awY23ZJ1gY2G2stzlJ34tKrMekZtbmM=
X-Gm-Gg: ASbGncs9Qb5tIa+Dvr7mw5cFQslpGuY2xxXJyzTyRPnVZGitGR/ymOLTwWvIMJGVHYX
 YmcTPeQDXEMfTNuHlwxhLhpeSobbc/9juODb/4TmyUSzp2ReqMklySsDgdsJIVYq47bQ69ZxTbf
 ZnifIftA0hG2qxv9e545Q/wMgb+uTj29UJq9U0fyQ84hOmIAahL/a4Pf4SW0n2Z1o4j64ysdZ/N
 2CIaeo3VfdkJlZRygzlnTAk3u977Dz6jeVIxNFUWa4o8GqhrXRfbEuSXKnc94TmLyhQoX5g4g==
X-Received: by 2002:a05:6000:1a8c:b0:38b:ed6f:f00f with SMTP id
 ffacd0b85a97d-38bf56635a1mr25565338f8f.17.1737711923231; 
 Fri, 24 Jan 2025 01:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvviF5m5Le9uIdKQug3cLYtChw3LC78akqAs4EDVOcfJv4Ook5jum8vK/EBgn/itTU+PobvA==
X-Received: by 2002:a05:6000:1a8c:b0:38b:ed6f:f00f with SMTP id
 ffacd0b85a97d-38bf56635a1mr25565307f8f.17.1737711922794; 
 Fri, 24 Jan 2025 01:45:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b1da8d4asm47818215e9.3.2025.01.24.01.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	qemu-stable@nongnu.org
Subject: [PULL 20/48] stub: Fix build failure with --enable-user
 --disable-system --enable-tools
Date: Fri, 24 Jan 2025 10:44:14 +0100
Message-ID: <20250124094442.13207-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

From: Zhao Liu <zhao1.liu@intel.com>

Configuring "--enable-user --disable-system --enable-tools" causes the
build failure with the following information:

/usr/bin/ld: libhwcore.a.p/hw_core_qdev.c.o: in function `device_finalize':
/qemu/build/../hw/core/qdev.c:688: undefined reference to `qapi_event_send_device_deleted'
collect2: error: ld returned 1 exit status

To fix the above issue, add qdev.c stub when build with `have_tools`.

With this fix, QEMU could be successfully built in the following cases:
 --enable-user --disable-system --enable-tools
 --enable-user --disable-system --disable-tools
 --enable-user --disable-system

Cc: qemu-stable@nongnu.org
Fixes: 388b849fb6c3 ("stubs: avoid duplicate symbols in libqemuutil.a")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2766
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121154318.214680-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index e91614a874d..a8b3aeb5645 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -57,8 +57,8 @@ if have_user
   stub_ss.add(files('cpu-synchronize-state.c'))
 
   # Stubs for QAPI events.  Those can always be included in the build, but
-  # they are not built at all for --disable-system --disable-tools builds.
-  if not (have_system or have_tools)
+  # they are not built at all for --disable-system builds.
+  if not have_system
     stub_ss.add(files('qdev.c'))
   endif
 endif
-- 
2.48.1


