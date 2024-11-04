Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC9CD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rk-00053t-KH; Mon, 04 Nov 2024 12:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rh-00052K-KJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rb-00008X-IE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AON/XT4j/Jh3wZo3lxffNCb05X1SO/4GSB7Qx3W9Ekc=;
 b=eatLCB24rsPMPPR2Pkoqcz3vf5LybWYCQOFxeTNmIpLkcAiIWRhW4n8oFT2jtc0p0JPLl3
 UxIcDR8gX7rLVEdK37SpXl3+eOrBcJJag+UFwh+ANqWTMGueKF/M3IR4lEmMnE65aevuNX
 qCl4BdQQVDQ78L5iQTzfBZ/mv3NZs6U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-rL9Z6vPHNAyjlM_l-XCyjA-1; Mon, 04 Nov 2024 12:27:37 -0500
X-MC-Unique: rL9Z6vPHNAyjlM_l-XCyjA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso25364595e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741256; x=1731346056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AON/XT4j/Jh3wZo3lxffNCb05X1SO/4GSB7Qx3W9Ekc=;
 b=e0FXeFjsFl4GYKuLBowNPU6Nh9unoNhS4CIaHhXSa5J+JxklB7f140uQJKkIiZ0vLQ
 SzUdQZwVItu0kjKVvS8vJzFxLE9jo5tACJP36+LFeTYyTAhc5u2ngAoFOjdLgOBjPWlu
 C8piyIIgIUfVByewp0T8T5MW2pBVk2Do94cAa1+s8LAUphlslGx9WJbZ0m69eFJ7lTlT
 USpVEhnTjc2kxJ5EM2pIQOpzzp6aWjlf24nnFjjsJX6pfgGXn+yP6ONuRbXXZftdHF6D
 vqhnfSmOheKmP2JM10ck6FufkI72ecNz1XXkGIOHb7WwsONxT+LyDQbI2U0bEXl5cXWQ
 K0kQ==
X-Gm-Message-State: AOJu0YzxiMCs3eaPHBrkZAaF71pvbLx8/SEcetZEc+fZpHwbV3UaCpkm
 6rj+Z67lBtPi6sqEclcbImw944uNOH21wOTMSOvuJzAREkY+zdD0K8gNGSfOU0Cnc2Q+zM9L4gE
 Zd2jbNI1304Xsbo0Q1BCM8PmT9WmaAc/tH5njI9UpBD83sDP5O7cABT0hOb1D2n5UVze52c2Fb/
 SxHps1FqeRW4QmwqtGCaxKntlySlX/WUSoatwDGOE=
X-Received: by 2002:a05:600c:45cd:b0:42c:b98d:b993 with SMTP id
 5b1f17b1804b1-4327da72175mr123417985e9.2.1730741255871; 
 Mon, 04 Nov 2024 09:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA/UEY9bUiqH6wRQsM0gEtD2CU1iyDe8/8hZL7x/Hip8/PaqTIMXudNurjoDLBHOfrvF0jsw==
X-Received: by 2002:a05:600c:45cd:b0:42c:b98d:b993 with SMTP id
 5b1f17b1804b1-4327da72175mr123417745e9.2.1730741255507; 
 Mon, 04 Nov 2024 09:27:35 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116abc0sm13709942f8f.94.2024.11.04.09.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/40] meson: remove repeated search for rust_root_crate.sh
Date: Mon,  4 Nov 2024 18:26:45 +0100
Message-ID: <20241104172721.180255-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Avoid repeated lines of the form

Program scripts/rust/rust_root_crate.sh found: YES (/home/pbonzini/work/upstream/qemu/scripts/rust/rust_root_crate.sh)

in the meson logs.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index dd6193c4c37..29a8df6d5f2 100644
--- a/meson.build
+++ b/meson.build
@@ -3991,6 +3991,7 @@ endif
 
 
 feature_to_c = find_program('scripts/feature_to_c.py')
+rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
@@ -4092,7 +4093,7 @@ foreach target : target_dirs
     if crates.length() > 0
       rlib_rs = custom_target('rust_' + target.underscorify() + '.rs',
                               output: 'rust_' + target.underscorify() + '.rs',
-                              command: [find_program('scripts/rust/rust_root_crate.sh')] + crates,
+                              command: [rust_root_crate, crates],
                               capture: true,
                               build_by_default: true,
                               build_always_stale: true)
-- 
2.47.0


