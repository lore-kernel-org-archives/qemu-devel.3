Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AB2D5B86D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5G-0003lv-6Z; Wed, 30 Oct 2024 11:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5E-0003jr-C8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5D-0007pN-0U
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yT8lUIBKet6fbgptE6xA8GhBp1fdHflDGVquMTNAch4=;
 b=QX/4hs9lLefTS7kMTc5H2NE790Wb+ARSan6VeGGRPD5aKmNqGfBM67jGlUxwXXaXP6MF5z
 HUgOLzSZQTXa86fj2Zc+M9ZeC7fukwiA6Mr1TSobGiAUgmZlGnoq2qACNy92buE/UN+Axi
 vep+4ZXn/pfFyY3StiICAEsr2lqVGl0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-7ByceYOuNhSLx-DjwpRpBw-1; Wed, 30 Oct 2024 11:58:04 -0400
X-MC-Unique: 7ByceYOuNhSLx-DjwpRpBw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3e601bc6ddaso6605053b6e.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303883; x=1730908683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yT8lUIBKet6fbgptE6xA8GhBp1fdHflDGVquMTNAch4=;
 b=LFHUtDx0rnIgLvY603/TlRIzHnXMeSfdX8FueywA8jejsHw0u5J8M8RKVNH43tQ+f7
 LpctCX2Z7V3s5WbZtzQEcgBsjo5oXBMLiBagQv/COJE12vfzbhdGgYzQD7JxPOws29zu
 5zhNlDTCrzlPkTRRTjrI199t/m6e/7zq83mc0GhtPkqkkVmiN988tgQ0Lp3WjYCXyGaE
 /IdgpsoIUC6rtiB0i+tE3jLJoApcjIVY/SzM/KJRkTeTcRNCjMcSeC64+mPGHlMoSZeN
 rl/tBXr25r4Fe7uHVX4EPS8MZmicV7G4GuoqXsMP9ukRUAhvMTjLalWKVjYGYmYai9Dv
 pEqw==
X-Gm-Message-State: AOJu0Ywg4k0ltnkdpTWjcL5jCtFGoaFMylwLNxT0JGTkAgqfnG0ndvY0
 8M4uQsWRgmkT68pKPRPaiNFN4HsKEyDn7iNOk6562RXWLpU5cchP5BttH19I61GiHYXRTPuxGhK
 SyQtKb/hcZx5J3oUDYFhz85W6oXhtWt918Prl0OgWuytzVT+4U9VGsckWELRdSO4H3zLeR2kBzf
 H+sH+3X8VAnYgWGoO2Ef9iVy0OI/sI1XO2nQ==
X-Received: by 2002:a05:6808:1812:b0:3e4:d683:c24d with SMTP id
 5614622812f47-3e6384cb1aamr13902976b6e.43.1730303881535; 
 Wed, 30 Oct 2024 08:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERI0OV8OSpAGe4Y7v6MLFTthvZUkoiUcrFyAkVum4xQPHelymS+o6v8fX6BTYTC+h7wsjXyw==
X-Received: by 2002:a05:6808:1812:b0:3e4:d683:c24d with SMTP id
 5614622812f47-3e6384cb1aamr13902945b6e.43.1730303881108; 
 Wed, 30 Oct 2024 08:58:01 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:58:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/18] migration: Unexport ram_mig_init()
Date: Wed, 30 Oct 2024 11:57:30 -0400
Message-ID: <20241030155734.2141398-15-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

It's only used within migration/.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241024213056.1395400-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/ram.h          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index df57be6b5e..e8490e3af5 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -39,7 +39,6 @@ void precopy_add_notifier(NotifierWithReturn *n);
 void precopy_remove_notifier(NotifierWithReturn *n);
 int precopy_notify(PrecopyNotifyReason reason, Error **errp);
 
-void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 bool migrate_ram_is_ignored(RAMBlock *block);
 
diff --git a/migration/ram.h b/migration/ram.h
index bc0318b834..0d1981f888 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -44,6 +44,7 @@ extern XBZRLECacheStats xbzrle_counters;
     INTERNAL_RAMBLOCK_FOREACH(block)                   \
         if (!qemu_ram_is_migratable(block)) {} else
 
+void ram_mig_init(void);
 int xbzrle_cache_resize(uint64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
-- 
2.45.0


