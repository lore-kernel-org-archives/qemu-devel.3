Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AC9C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTe-0005jp-Bk; Mon, 12 May 2025 15:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTF-0005Tb-0T
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTB-0007V9-Lr
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkMjV1RCdSvZc3UqwgDRzKPR4GFZsy1t1ux2ynl8Z10=;
 b=IeW4fZOZ+xeZgZTR1uNHcqKhqIwGbx1AzOaqH6JET5BEh9nESyxjZXKrxAOdZqp7nF5Brp
 OETveJVZAKIRtRvyHSukSg160VbRUiMbdx2X8WalQenmYAtT5mR5u8kKukldbxDnA9rq79
 qjfKZrBb8UlSlkggOhqqMtPyB0fcBQk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-NtFOSWBbOHGThgW4o39Zhw-1; Mon, 12 May 2025 15:05:43 -0400
X-MC-Unique: NtFOSWBbOHGThgW4o39Zhw-1
X-Mimecast-MFC-AGG-ID: NtFOSWBbOHGThgW4o39Zhw_1747076742
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-326c70002d0so19829531fa.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076741; x=1747681541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkMjV1RCdSvZc3UqwgDRzKPR4GFZsy1t1ux2ynl8Z10=;
 b=ENr83XhD1Xk3uzObM3i4MHDeB8uawugJ+QEGen6PgN7UJbvtKQ8wdKZnkW01YehUEr
 sZAxC6BUmeACA+cXkZpxglgPnAIBisrclrnuBd8v7jcA0wTCzyHCaQwYWO9j5EAAM3al
 B1/lkd4qCHJVw/Rr8WfugAy9b1VKLunQ8Te01mzGJgdkyUsE/HrCeuCsAw0yuy0hfcUe
 vgxEMRtD1FfJllVpXVt0P4KtUrEj4FYuL0TOR2nASnGUf1gnLhdit6TEl7tHLXMMO+dh
 TOekDKroQpPxpCDukkmatjHo850y+wUnYdndwPJ9QvAr4sKLOo10i184fV13AWR/n8KN
 4nKA==
X-Gm-Message-State: AOJu0YxT3Fo1td3xH5PCdECwK7n2X0GiuRgRDYQTvi9nm0E3bcotScgP
 cflOozc6SKRaPrn5angpyVKVapS7poxacUxrvhYH9ojYiVa6pPSZ7QnDuN5hdz3300/NcrO11+7
 NBnFQQGO/3XGP9keb1e/4SiPqaVRiyH1T8mf5yKO34UltYXzssZJlZsYQH2k5g9e0f90e3saCdk
 2/tIBDJPbyJkjT5SsWB2BkwCfmbK2jEGF/zUN6
X-Gm-Gg: ASbGncvcnprJB0CLelzZfDltnE4ixC9DMAdzXkIF/zX/OE6+yc1JPjJJYFj5UxsNSfm
 DWf9x4RUmhXj74vd6E5HOpIjU06ZIRkLeeK4S8K0Fnp/WX/FERRn9HZ9JNoVO+EhiNXqMPGo6I4
 O5vQyv8THTOxYJPqqu5DGVgAJV3lNm1cZVsGv8VOmrY86RSHRtlRmUTdwVuj7EqPD0U85NDLGhR
 XtuHq2IInMGepfFecZRNsFUiYsLY5CYyTlnOKoKtIHKMxgg8yRXgDsqVJptfsuKpr+V56ss2FVg
 gslOxgMBvfny9bY=
X-Received: by 2002:a05:651c:211b:b0:30b:b7c3:ea4d with SMTP id
 38308e7fff4ca-326c457b321mr53831271fa.12.1747076741265; 
 Mon, 12 May 2025 12:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBagYP3U/AIInxvHPx8D2AYQidcBM0jf/W6zRUqMq8SRfLNlWmpa80jPGA3ylh1981LtUiWw==
X-Received: by 2002:a05:600c:5118:b0:43c:fcb1:528a with SMTP id
 5b1f17b1804b1-442d6cf30fbmr114230625e9.6.1747076730001; 
 Mon, 12 May 2025 12:05:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d5c35sm136078075e9.5.2025.05.12.12.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/16] meson: do not check supported TCG architecture if no
 emulators built
Date: Mon, 12 May 2025 21:05:10 +0200
Message-ID: <20250512190524.179419-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Errors about TCI are pointless if only tools are being built; suppress
them even if the user did not specify --disable-tcg.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           | 10 ++++++----
 accel/tcg/meson.build |  2 +-
 tcg/meson.build       |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index f20a172299b..a2cebd44656 100644
--- a/meson.build
+++ b/meson.build
@@ -247,6 +247,8 @@ have_vhost_net_vdpa = have_vhost_vdpa and get_option('vhost_net').allowed()
 have_vhost_net_kernel = have_vhost_kernel and get_option('vhost_net').allowed()
 have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_vdpa
 
+have_tcg = get_option('tcg').allowed() and (have_system or have_user)
+
 have_tools = get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
@@ -863,7 +865,7 @@ elif host_os == 'haiku'
             cc.find_library('network'),
             cc.find_library('bsd')]
 elif host_os == 'openbsd'
-  if get_option('tcg').allowed() and target_dirs.length() > 0
+  if have_tcg
     # Disable OpenBSD W^X if available
     emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
   endif
@@ -904,7 +906,7 @@ if host_os == 'netbsd'
 endif
 
 tcg_arch = host_arch
-if get_option('tcg').allowed()
+if have_tcg
   if host_arch == 'unknown'
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
@@ -2534,7 +2536,7 @@ config_host_data.set('CONFIG_PIXMAN', pixman.found())
 config_host_data.set('CONFIG_SLIRP', slirp.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', host_os == 'sunos')
-if get_option('tcg').allowed()
+if have_tcg
   config_host_data.set('CONFIG_TCG', 1)
   config_host_data.set('CONFIG_TCG_INTERPRETER', tcg_arch == 'tci')
 endif
@@ -4959,7 +4961,7 @@ if host_arch == 'unknown'
   message('compile or work on this host CPU. You can help by volunteering')
   message('to maintain it and providing a build host for our continuous')
   message('integration setup.')
-  if get_option('tcg').allowed() and target_dirs.length() > 0
+  if have_tcg
     message()
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index d6f533f9a1f..97d5e5a7112 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,4 +1,4 @@
-if not get_option('tcg').allowed()
+if not have_tcg
    subdir_done()
 endif
 
diff --git a/tcg/meson.build b/tcg/meson.build
index 7df378d7735..bd2821e4b54 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -1,4 +1,4 @@
-if not get_option('tcg').allowed()
+if not have_tcg
    subdir_done()
 endif
 
-- 
2.49.0


