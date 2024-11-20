Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB90D6E2C9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfX4-0007SO-FH; Wed, 20 Nov 2024 02:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfX2-0007R5-DZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:53:48 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfX0-00009k-MJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:53:47 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a6acac4c3so298591566b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732089225; x=1732694025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6GJ6dUiJm9oVft1YxBq0Y3GSW+27D+0bsvHZhFvYqU=;
 b=AyvRLAsUaRpzllgMejd8IDtpiMbCrfbCasR0RIDrgMJ6ETGgvNCZ6XuGRGaa8ugodJ
 yUJq76/o94/vXROoS1WNuA1pZ2sgJ/lJQSsLR24KvDy1EzFn2cDXXZqhSSpNwqOvet7C
 1z3Dz/vS38xi1VpL/N/kx2mqXXkJLvRUsr4V3eSFHfGJcSx6MAVcOPDWeE0jmjTfbcey
 HcZ4cArpmOOZQ8VbvpNXiFxu1/Ubmwt9NNybOit+FLy7q71Lz6iK0AIlETA5sGy+tlP0
 WiwfBHEAdJ4s11MoqQbqoEAYZj1/VJzr/mMdFEpPcicUYymTfmuoSPkI2QAV0+Aehjco
 s2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732089225; x=1732694025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6GJ6dUiJm9oVft1YxBq0Y3GSW+27D+0bsvHZhFvYqU=;
 b=YdqMkAa3NuJ+nkqMrNP7aOW3rUfooObMdkcZxYHH3N45IMJ0r+rOXsb2NBJRAlum4Z
 kU/Yssg/xcJb4msvPG1q9lWOMow+bO5QLs8KeJDH+S1Ra4vNI3Jjhlw9qaPDy5ejdhGa
 jHPuvrZk+fOZox0DCuQZe9HyuOiAexM7NMtMUkQ95Ba1mfrH0VYcbz1kgdOYQFvxfzjI
 VhN5V5QdgKpxxo2My4vyKm43bTIinB0rjJ3tF+HsWAcgHX/rpB5prX+cCK9S49EbpNTt
 cNzxFEinJAQT+Vkm77xnQSIVSt8oBZdsHH00bvNadTMSK7P70fmnMPe9Vv/lTYinuRmY
 K/eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj7PyvVUwRbqc8oZ1xc3L1t0ICRDJiY5BC8w56V4bLNAm+Am8OkgivYFQXlsa5/C2/iThGyc/M14wA@nongnu.org
X-Gm-Message-State: AOJu0YwCZRwJ/uCGIkEHa4fF/4mkxa1acanRc61tzn09uApNRBbVVUzx
 UHpvD5UZdZmD3fAyPVBIHWyw0BFe5RRMnhim3Ejyqt/YchsEWaMOKAt/aA==
X-Google-Smtp-Source: AGHT+IEQSkdF3/W+1eGMG6c8GkF+qAolZKC1bWw9sZxJjwnRsndX7FTJ5F9TahzXvzuX3fJi0/qqCQ==
X-Received: by 2002:a17:907:1b02:b0:a9a:9b1:f972 with SMTP id
 a640c23a62f3a-aa4dd71b723mr158971766b.40.1732089224859; 
 Tue, 19 Nov 2024 23:53:44 -0800 (PST)
Received: from finn.fritz.box ([2a02:8109:8384:1400:37e7:543e:4254:db4f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df265bbsm738395666b.38.2024.11.19.23.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:53:44 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] chardev/char-mux: make boolean bit check instead of
 find_next_bit()
Date: Wed, 20 Nov 2024 08:53:21 +0100
Message-Id: <20241120075321.27143-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120075321.27143-1-r.peniaev@gmail.com>
References: <20241120075321.27143-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x632.google.com
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

This patch simplifies (and makes less confusing) bit checks by
replacing `find_next_bit()` calls with boolean AND operation.

Resolves: Coverity CID 1563776
Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 355520714979..f613a22e3758 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -336,15 +336,12 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
 
 bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
 {
-    unsigned int bit;
-
-    bit = find_next_bit(&d->mux_bitset, MAX_MUX, tag);
-    if (bit != tag) {
+    if (!(d->mux_bitset & (1ul << tag))) {
         return false;
     }
 
-    d->mux_bitset &= ~(1ul << bit);
-    d->backends[bit] = NULL;
+    d->mux_bitset &= ~(1ul << tag);
+    d->backends[tag] = NULL;
 
     return true;
 }
@@ -353,7 +350,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) == focus);
+    assert(d->mux_bitset & (1ul << focus));
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
-- 
2.34.1


