Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A42C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfJLD-0002BR-Hw; Wed, 28 Feb 2024 07:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfJKu-00021i-KO
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:47:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfJKs-0006fQ-9V
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:46:59 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 68FA73FE49
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709124413;
 bh=2SSCG3X1bVbuFpRmxXaV7Lr4Tk+xfFRydGm79EzyPfo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=L1t3J7y7iAmNcIwRN4dmz4lfK+hn4VuOkqVd2mZ5DGs6OU03dbMYZVQETkA2udWT0
 CY/VyIHF1o4H3p7zWzIvpn8V069jnchH45i/16lefelM+9ikjkx1udNsQMFVkelv1J
 vtFUgGjs7meHa+jEjBBppfVlOmsOhJNfhM3GdR+xdG/47onQ167RSTlMdHkyYACZmo
 1R4J7N4VvX63bMB0uFJXqPfeIrk2RrMhJ8+sB3iJ4tttEvLPQOX/9Oo8xemCP13+Gr
 kUPIR4xGrgmHHhOSvIkNR3Nng+OPNxDwrZL/Wna6AYX6bVul3jnc2ojiHCbAjL7atH
 WAtWLarrVDQwQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d5e518991so2892879f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709124413; x=1709729213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2SSCG3X1bVbuFpRmxXaV7Lr4Tk+xfFRydGm79EzyPfo=;
 b=IlyHH3nxCTP1z49ubsYuTZZwwJcr1zFlFpbyrlzLFtRlB4j1/128VgQkuNrPa+eHpB
 4PyzcXEWQO+GMsmYWCu2eNzR9tWBDGGas9N2gEMclT7uuoIyhbdztGO06W5frN/EGyme
 KleANKoEQYjkN4mLi7SxWDKJpcCjVudHyHnPgB9T684BgvXBD4wWxNay7CCO3ZcU6Xkb
 F/cEUzp3XdFF/oc+SY0OQ1YII3NGFrG1f183i2wTIBXzw1cHyyz/5ZB+EMIXlDjP4dOE
 Yoh77uPtNNlbyuQTfGKiELYm95aUUFZbFIMHRErEBJ99QzaOSNY8oXaK8uvIpmfRqpDT
 x5CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcU0bVWD7x7GEUk+b1YieBAKYtC0SusRcKccLkdqsAB1TLGSvB4xpL7FHTM/L9TLx5MQLs4M0YMsSUKSvGMnFT7vKRItw=
X-Gm-Message-State: AOJu0YwdW9vXIeB9wc0kwbwQIb2G6Qsmp3WhwO+gsRq59OXre1A0ApEu
 pr4eF8WQ1iJhXXbNYqb3I218C3v2Bf/TdbCXNGN/gIwm6guFcV/e+1oy+jv/uiegiyk10RHeXwC
 MfEXNfBFz0GCbs2SDng5Vw8Juxe5GBZPnsVCD9c+2yi4qpvE/mqg14h7gJq4Vunw4l8lRVhMGkt
 mR
X-Received: by 2002:a5d:4147:0:b0:33d:3b72:d2c8 with SMTP id
 c7-20020a5d4147000000b0033d3b72d2c8mr8994585wrq.71.1709124413056; 
 Wed, 28 Feb 2024 04:46:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUMl+R8fh/R+6N6eo1PSxJOAeNs4a1Goclti/kddSkfadayfYPTz7zhsMeqIWgT8AQW0NMYA==
X-Received: by 2002:a5d:4147:0:b0:33d:3b72:d2c8 with SMTP id
 c7-20020a5d4147000000b0033d3b72d2c8mr8994573wrq.71.1709124412681; 
 Wed, 28 Feb 2024 04:46:52 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-095-222-037-056.um34.pools.vodafone-ip.de. [95.222.37.56])
 by smtp.gmail.com with ESMTPSA id
 v17-20020adfe291000000b0033d56aa4f45sm14199129wri.112.2024.02.28.04.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:46:52 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] physmem: avoid bounce buffer too small
Date: Wed, 28 Feb 2024 13:46:38 +0100
Message-ID: <20240228124638.55752-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEXHASH_WORD=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

virtqueue_map_desc() is called with values of sz exceeding that may exceed
TARGET_PAGE_SIZE. sz = 0x2800 has been observed.

We only support a single bounce buffer. We have to avoid
virtqueue_map_desc() calling address_space_map() multiple times. Otherwise
we see an error

    qemu: virtio: bogus descriptor or out of resources

Increase the minimum size of the bounce buffer to 0x10000 which matches
the largest value of TARGET_PAGE_SIZE for all architectures.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 roms/edk2         | 2 +-
 roms/seabios-hppa | 2 +-
 system/physmem.c  | 8 ++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/roms/edk2 b/roms/edk2
index edc6681206..b8a3eec88c 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit edc6681206c1a8791981a2f911d2fb8b3d2f5768
+Subproject commit b8a3eec88cc74bbfe7fb389d026cc7d1d8a989c8
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 03774edaad..e4eac85880 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 03774edaad3bfae090ac96ca5450353c641637d1
+Subproject commit e4eac85880e8677f96d8b9e94de9f2eec9c0751f
diff --git a/system/physmem.c b/system/physmem.c
index e3ebc19eef..3c82da1c86 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
             *plen = 0;
             return NULL;
         }
-        /* Avoid unbounded allocations */
-        l = MIN(l, TARGET_PAGE_SIZE);
+        /*
+         * There is only one bounce buffer. The largest occuring value of
+         * parameter sz of virtqueue_map_desc() must fit into the bounce
+         * buffer.
+         */
+        l = MIN(l, 0x10000);
         bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
         bounce.addr = addr;
         bounce.len = l;
-- 
2.43.0


