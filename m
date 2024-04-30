Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CBAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgm-00070w-7M; Tue, 30 Apr 2024 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgM-00065g-Tr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:18 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgL-000613-5i
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:18 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516d4d80d00so7533226e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495814; x=1715100614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwamhPCUJY+N7YTIaqBuMDMNKLfZW1hiEtgPXWAFdNA=;
 b=KHu8E7Ce3mzwBSP6a12asR/K7jlppdxkI3tLleB/xYy4PkNQ+yQVotHXda2CuCa8wt
 Zys0CTE2f6CUaQV9quzqkSpHjteOxjo9BcWa2hSq81v4udc76KUGP3cbifpM0DckJutn
 c6e7VMA85fsVwrkKG+69Hpc1OsGzL6ICrZZ22j79PZvs0djzxVKBt8EpSEYZFzHgNgFa
 TMSS20DkBHMXs1ty9yPkTYj1IHr/D6C78AOFxo8TJWTWqBMnZvvampFhyvXh6qWq3eru
 HLbotiVsTbnw8dGLsRBBYbaPpjWPgOxH1eFhUXAuAUp8CJpqwuLqyZu4D27DS5U1VUPw
 7uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495814; x=1715100614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwamhPCUJY+N7YTIaqBuMDMNKLfZW1hiEtgPXWAFdNA=;
 b=MxuNycirDClUFwcIoaWMH0mX9qQ7Y9fYrkPKSyqxxA0rIQvn26StXVyxU8QSI0qlnd
 dovbFSaGPWW6DHtsufJvFN4nJuATGZy2w0QuI1htp6FOl7eM9MXHzTDBDf6JeUvJjg4m
 Gz6ID8foNLTD36nh8CaAvgdy/lQkujfSRAdp2Rcfm9Pe+2QC35YR1hNNL3ywJXptRJW8
 VerKvkU16TcDMqiNHoXH3UF2xaKy8tA2d12oxsHoiFWxPCkwXpk9XDLKtav76VxluXaD
 bbMI9BJqb8bq8zxUZvMrpFMz0TXfB9+cDUEF5fCVuHHGI9nZQ0tEHB26YqdB3t+AA/nK
 8o3A==
X-Gm-Message-State: AOJu0Yw+au6n1tyPKXnHl3hdycNnMi+JNQRQlJDOjwv5zBWmyvoSq/mm
 D170GM0vNHurSGq/VdeE9Zy+uLe7dMFKsWUB1EKaHIUOAkQV3GGXDQ0gB9i+
X-Google-Smtp-Source: AGHT+IHoJlSMsC6sfM5UXupD/S6braHFg22PmZ7CRhw+67o7aWoTbAdWexTYOX7plCeimOm047+9GQ==
X-Received: by 2002:ac2:5a5b:0:b0:519:6a93:ed3a with SMTP id
 r27-20020ac25a5b000000b005196a93ed3amr25393lfn.23.1714495812082; 
 Tue, 30 Apr 2024 09:50:12 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a19e045000000b0051bf283570dsm2372896lfj.254.2024.04.30.09.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:10 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 02/17] xen: let xen_ram_addr_from_mapcache() return -1 in
 case of not found entry
Date: Tue, 30 Apr 2024 18:49:24 +0200
Message-Id: <20240430164939.925307-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Juergen Gross <jgross@suse.com>

Today xen_ram_addr_from_mapcache() will either abort() or return 0 in
case it can't find a matching entry for a pointer value. Both cases
are bad, so change that to return an invalid address instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 7f59080ba7..b7cefb78f7 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -394,13 +394,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         }
     }
     if (!found) {
-        trace_xen_ram_addr_from_mapcache_not_found(ptr);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            trace_xen_ram_addr_from_mapcache_found(reventry->paddr_index,
-                                                   reventry->vaddr_req);
-        }
-        abort();
-        return 0;
+        mapcache_unlock();
+        return RAM_ADDR_INVALID;
     }
 
     entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
@@ -409,7 +404,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     }
     if (!entry) {
         trace_xen_ram_addr_from_mapcache_not_in_cache(ptr);
-        raddr = 0;
+        raddr = RAM_ADDR_INVALID;
     } else {
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
-- 
2.40.1


