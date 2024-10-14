Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0275D18128
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mxm-0006GZ-GZ; Mon, 14 Oct 2024 11:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxk-0006Fp-J8
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:24 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxf-0000vp-Jr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:24 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0474e70eso228740666b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728919576; x=1729524376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0qoIF6I3bv6HEho2ivi87bpY1Wjjl4fkovu0hrF0fg=;
 b=HTMYpNM9VX8iYyYV16BS5EQTWBBerbq2g4Fs/hJ4s8vTI87PCQqGQ3B6Q40NMywzTu
 68NQzpwg2nbHKRo1AK1+PDSeIZDCqzmnFRSK//y5GO+uBNdT3bRKp7nymjT4kULRYzlq
 gkcc2IDKoJ5QnGqZAMjgkV+sETjry/s599DTl/ckbtO73MK9ZdpMNOlxtF0FfIS3AlQF
 jed2FhfJrJzSi7demqaejWGGY94+TckveDgwsW4wTpnRi/957PIQ668bXizyili2NfX9
 Bux6GuCjbQyVQRKim7Szz9Ge13VQ75z993MmYeFpgUlRENQ/hXOEaOA2iKEO08ZMwNIN
 f6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919576; x=1729524376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0qoIF6I3bv6HEho2ivi87bpY1Wjjl4fkovu0hrF0fg=;
 b=stDCGrAajCD6qAGo/KWyPGzb5CWAZgC9c758W8cNOw333T5xJ/8pBsoAFXK/p16Cbv
 t53qEw+K8twXLe5zXBY/uMeK1NHbD248IM/3VqUAfOV/aYtcjNBZ1fEr65HwG+LY2ItR
 DxGsFv1KbzJzvs+mNhxBZpFNPqMl3XyOHu1Vyf85ZTeC6i/9oBq4KgYO+Yj1xuOLUM6c
 1DHMiQhfVgOBvK2ztKpBqFl2DBTIX29pdC7OUJR5qVR7tuZLVS2h7/kfZNhnzukOr8GH
 XWZarxruS/BFRK/Fzpi/ACAY+CUq9bq/Ovs1u7J0JDlJmWw/w3x3uO0RIt/O7Uk/tXz9
 9kxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpSyux8duoO25YJcDjUIc7Denu81TjQvkcfVIB5ngd2KSikaknNA3ccDpsz7m7/Pgz4vSACs6VDhbe@nongnu.org
X-Gm-Message-State: AOJu0YwtZOufcSh5E4ZSTbAusW+wLN0YfS/ZZHYMwQzz6+I+2/0/4K9W
 wnhIJ2A/DchQ9yupbcL/kXtQWwg+J6Ag9iGeXnNgp3NV9vRvcCp7
X-Google-Smtp-Source: AGHT+IHRJPO3UFktVyYkgg4UwsOVSmTlut+kzzXkzyFc/HuRIj28ILC+mV/zriTmyD1QbW7t1nCMdg==
X-Received: by 2002:a17:907:3f1f:b0:a99:a9b6:2eb6 with SMTP id
 a640c23a62f3a-a99e343b0e8mr922420366b.0.1728919575672; 
 Mon, 14 Oct 2024 08:26:15 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a13396603sm133689966b.169.2024.10.14.08.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:26:14 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] chardev/mux: implement detach of frontends from mux
Date: Mon, 14 Oct 2024 17:24:07 +0200
Message-Id: <20241014152408.427700-8-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014152408.427700-1-r.peniaev@gmail.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62c.google.com
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

With bitset management now it becomes feasible to implement
the logic of detaching frontends from multiplexer.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  2 +-
 chardev/char-mux.c         | 21 ++++++++++++++++++---
 chardev/chardev-internal.h |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 3b8771ca2ac4..8ac6bebb6f74 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         }
         if (CHARDEV_IS_MUX(b->chr)) {
             MuxChardev *d = MUX_CHARDEV(b->chr);
-            d->backends[b->tag] = NULL;
+            mux_chr_detach_frontend(d, b->tag);
         }
         if (del) {
             Object *obj = OBJECT(b->chr);
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 4fc619b2da70..bda5c45e6058 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -290,10 +290,10 @@ static void char_mux_finalize(Object *obj)
     bit = -1;
     while ((bit = find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < MAX_MUX) {
         CharBackend *be = d->backends[bit];
-        if (be) {
-            be->chr = NULL;
-        }
+        be->chr = NULL;
+        d->backends[bit] = NULL;
     }
+    d->mux_bitset = 0;
     qemu_chr_fe_deinit(&d->chr, false);
 }
 
@@ -332,6 +332,21 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
     return true;
 }
 
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
+{
+    unsigned int bit;
+
+    bit = find_next_bit(&d->mux_bitset, MAX_MUX, tag);
+    if (bit != tag) {
+        return false;
+    }
+
+    d->mux_bitset &= ~(1 << bit);
+    d->backends[bit] = NULL;
+
+    return true;
+}
+
 void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index b89aada5413b..853807f3cb88 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -61,6 +61,7 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
 
 bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
                              unsigned int *tag, Error **errp);
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
-- 
2.34.1


