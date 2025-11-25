Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ED4D0EE00
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNx8i-0000cR-0s; Tue, 25 Nov 2025 12:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNx7v-00005N-6B
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:46:55 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNx7s-000418-Rx
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:46:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42bb288c17bso3541553f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764092810; x=1764697610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qfi1CLXG4bOvuYzMTaadJLv82gpDk+wZiPuzwyT2Xww=;
 b=GioSrk1RuDrNAaGak3MJVDR5htR7R+gHzhOqBTzfZwtjd7W35cC4IT5hdo6tVLmz2C
 GxCzT++QvQwuzflbeWHEoXgTu4JgtNW9X6KOt15D691UkZdAHJCnWnq5qBZFlD7/W0Z9
 tDeZml9qPB24HmFEH72RVOMZwe4HbHrtS9agvBAVYxeMpXqIz2Ly5CopMrAUfGdvM0qN
 8X2bPLmSR8HSrSJN2zYHEM7NkZ5xW8KiUj3g1sCSkb4X5mxti9ok1Y/8y4jidTBYURfu
 rtGEz0LLnP4fwCAoUpJrG80yua6NS0btC7avnm4qc91n3pK3Y6OwHi9bO27272HC3Aya
 OPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764092810; x=1764697610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfi1CLXG4bOvuYzMTaadJLv82gpDk+wZiPuzwyT2Xww=;
 b=V/FsJPofLdpmDAf+msgqOW8yE9q0/bEPF+rNq6z5UZoick7gpsZDW0nVWz50AOVv/j
 TiwaJULddHpezrS7InErVmZ5SL82lW25EFoZXZfJmqodTdnBxNLctBqKoPSbSDmn3gR5
 JUAWaWKfYoLKCIh1NXFVszP70dhwNtDCqYR8d8C1l47G67tpDldRXee/nSl2OETgontD
 J4C5siY2iRaC2bxtcvbs+gniYSoChGPednBAlkA6VXDWXVAftE346r5QGE01/MUjdYad
 W05gPdjeprfwfYdTffl5klEDNPrOXUZlI2+uXgUy+9TTFWkhIvjumaa6/0hKag85xOfY
 pccg==
X-Gm-Message-State: AOJu0YxOfvi9c4oRXDCGG6qcCvYgjsou7IqV0YRzZ9xQelLBYgNRNE/U
 L/AbLsVHl3k4gY5HFI0jvXSr3Rtnhr0cdA6IZI+IJHT9+7CwMHQwXps+QOC9IiHDg+KU4A==
X-Gm-Gg: ASbGncvAW7YtcZtohZly/v2LlZPc3E4tk/i6U2VNBfznJlCLdX2kqp90nIFlzh5maix
 LkGJVLL/41znsca0DkucghsX+9cx0NGYIZBrzV6U9ogSnaPTgqZBDsTFze7zwz2PNB+YnzQN+Sb
 Sg9ZIQQELc5zFNgssWZnKRSiRSqlwZKFgfbx23e5skGMt588QrHV5IFKgGr5FnFz3vTfKidISOX
 orJYdX/Dr6wZQgNzXQ9hekZXdxS3pcftPvMHE3ZYR2OUYo1ojGiEVGdhDc/8YU8LRW7vqfuiZjA
 cL9LeuJH2Dr7Qp6w+VR0UbPJ4ya0a+qeDmaXMHhD+EVGfYAtLUdqp06H0PwFWooS5OJES8utEVE
 lUXuI3DgAW/aNR0OKu401iT/ba4H0diWm3IyAYe8kc47fa5pnZaTwELBhkvTkU2Snig26
X-Google-Smtp-Source: AGHT+IGK+hgPDPMS1ByVztR0jWBt5qj1h6kubvRJyQR2aljtxLb2MJR16g49rWvuzrmARocIRYyWSA==
X-Received: by 2002:a05:6000:18a9:b0:42b:3e60:18e9 with SMTP id
 ffacd0b85a97d-42cc1ab8bf8mr17184720f8f.10.1764092810545; 
 Tue, 25 Nov 2025 09:46:50 -0800 (PST)
Received: from localhost ([51.37.163.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa35b7sm36301530f8f.20.2025.11.25.09.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 09:46:50 -0800 (PST)
From: Pawel Zmarzly <pzmarzly0@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	michel@michel-slm.name
Subject: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
Date: Tue, 25 Nov 2025 17:46:49 +0000
Message-ID: <20251125174649.257457-1-pzmarzly0@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=pzmarzly0@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Snapshots made with mapped-ram and x-ignore-shared flags are
not parsed properly.

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
---
 migration/ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..85fdc810ab 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4277,6 +4277,11 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
         id[len] = 0;
         length = qemu_get_be64(f);
 
+        if (migrate_ignore_shared()) {
+            /* Read and discard the x-ignore-shared memory region address */
+            qemu_get_be64(f);
+        }
+
         block = qemu_ram_block_by_name(id);
         if (block) {
             ret = parse_ramblock(f, block, length);
-- 
2.52.0


