Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845C5E677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 11:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7C14-0004uN-3f; Sat, 02 Nov 2024 07:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7C0x-0004tK-3O
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:09:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7C0v-00048y-HY
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:09:54 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9abe139088so397832666b.1
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730545790; x=1731150590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+e1UCV9sC+7MKmqq+o/2EnyB+QFYYlBmdgE54YAXIDg=;
 b=VXj/gAuRhsRLTAXm2NPfTqrHtMN/XwixzKIm0B1hGE2B3RAUAYWgWcqKocMtMuNxi9
 GtttcSiUrHM9ThTNVHjLCrW8QupN6WlPDcWWdVAaIE+oN9sNcK0h9PfZGWVcj2DxCQG/
 L2edyDtowY3YuDK9tSPx5Cb4mcXkTI4qp2ZAtfGFUklXfG+wwYQzJEGkACfxC2Am2TkD
 Sif03PiplVNXdmK4dIu6BvFzNUAOV+nrNHHt7Dc9s8Cq/F0CIxLSF8AgLzJSKZuvX0jm
 hCW5uzAgqY6mFKfPu7ADF6gXgfQFlDFCIy5pAq8396a9JASjANqLuGm8H1z3hRSD7LEa
 Wrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730545790; x=1731150590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+e1UCV9sC+7MKmqq+o/2EnyB+QFYYlBmdgE54YAXIDg=;
 b=QVabZyCoIrvH7S5PbF6yMVIwfwmhPYv86ztG34BRUOMN+QfR+sMLnFOjkWW085Nrgp
 fvrXOgNaH5armDzOvHl62AjAqhrHByIsf9HYgL0w7un5P3UjOJSvYFqm8mW95i6nk36I
 662Grdh1/UQMPgdjphGKdgJcOquzLlDn3EmyqxRdkGiRajJgaw34PA98S5gFQ38Dl8Ue
 Z2SkRhaf5Qqfmq6N0mvVnTQyGbxjJUCWh1xGiZPBpn2KGXgak2MaPrdZXLDIZ1CF61Zj
 CYDbuMhaedelv1SyxCjUFn9btREYZtJiT08xh72mQQxSz4fAh/DqLgh48YTt2DDkb1G5
 gZGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvNGmfSiZcpRuYwOCaun4p8mQSad4ooh8gcDP8pHXXdZZvsO6dh6P1D30r1jCzn6XnZztDr3E3tA+J@nongnu.org
X-Gm-Message-State: AOJu0YzYH0KEody5UBjsASQ9VPcChgxh/Rx0QjnWh7ZznkoeLDMpNcXj
 TTA0wL+Cyn97sNyv4zvTZeo0indgOfyyuxHqLJiCAF2jKj8AtNmm
X-Google-Smtp-Source: AGHT+IEXcMy+wztDGK3eHNlZz4MFAGNQGnpWoYKDbiXe/EGke9iufwkZwKoUkb+fd2YGGFdw69jMPQ==
X-Received: by 2002:a17:907:7286:b0:a99:fc3d:7c76 with SMTP id
 a640c23a62f3a-a9de5f305f0mr2403158966b.37.1730545789422; 
 Sat, 02 Nov 2024 04:09:49 -0700 (PDT)
Received: from finn.fritz.box ([185.237.96.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e56684912sm294991066b.200.2024.11.02.04.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 04:09:49 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] chardev/char-mux: make boolean bit check instead of
 find_next_bit()
Date: Sat,  2 Nov 2024 12:07:19 +0100
Message-Id: <20241102110719.682399-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241102110719.682399-1-r.peniaev@gmail.com>
References: <20241102110719.682399-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x636.google.com
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
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
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


