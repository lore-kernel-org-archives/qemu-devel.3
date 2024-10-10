Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1696CF11C6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHd-0006RK-KX; Thu, 10 Oct 2024 06:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHb-0006QR-Tq
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:35 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHa-0003Xg-9F
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso119595866b.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728555632; x=1729160432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZr22C6GyP2zNyIOBJrfarPfi36zfJfEl98MesRI/BA=;
 b=lXL/MEWBxjy7Lv6Gdwuv8yohK1f5mN7R6lx9HQMP43wgablvUhFm4eVmMNWfvxC+X/
 QBds6U0kcCNzPBNSf6oYGZfT9iwwymN5lkxVzgoPOfTeIJE+5QepBso9YXJ7llIEIB6K
 7Gn/6waiFWMr2hS7WPMC0/ENke/GVIyVzvzgeTym/kR9CchJDmC+2tgcj/+lISD8Mic8
 Jgyl2QsPWQ5kpABN+xKV2P+oh9/34hdGsGrgOV8LGBjykvXIulPB/a4uMOJR9a/b4gDH
 hogBCEMzo5w13qFl4pjbmaC7qmnk7a892bzuTEXmNgBsCT4pCGjPYYLpBSd38qKqYErv
 n3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555632; x=1729160432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZr22C6GyP2zNyIOBJrfarPfi36zfJfEl98MesRI/BA=;
 b=vzt92ZmmZ4P76yzwEGehVnr8e7SrhV2Af9+L7HIWUQaJHoBMbrizDFXzCoz2JFXYyG
 Y14oCdxa/H0GgllqBlNieqoqvmgGGVlLIFQU4Rehjduea8iJGuKCIrvFZK0+FDDkC4h8
 5QZqkHW+13kTtDEN97NhwFncxLiI+UZCZ43WPhvri3TFYOvNQD4ex+9dLFyRo88GBBl9
 SGWR2zNw9NwL+mqNN+ZPxf3F03CKAXuHqMAO6lmsPHF89UEU3bNv2sD3wAjfZrhgsZV8
 hY2jJzXEWPWfJdDUmg/hE/G7tggCZ5Z3C2cXdn/c1byu0METM0Q8ICyGw5sTuChvPwHg
 AsgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMc6LGCQ9Y1IB5o0x3TS9OswuUiqoIONbjGl+k+qsrUBKZXnaFUQPrOLbtxFkRf1I60CkuoJ13pKow@nongnu.org
X-Gm-Message-State: AOJu0YwYu+xv19wd66XD6ZwNJX3YqpPD4eLO9XL0zLS2jhfzJJSHIbz7
 8wlPedEb/jmx4Fi/vreimLGHV5re1PRGcgez/0PsEW1cYBZQPQ8t
X-Google-Smtp-Source: AGHT+IF66KnSarY4tEERSdoeZ3NcK1JPl1l8E5rZ5HZGG4ugXPRq5Tg/2q+ac4hxvYDoGSTb9jJrcQ==
X-Received: by 2002:a17:907:7b9e:b0:a8d:fa3:bb24 with SMTP id
 a640c23a62f3a-a998d19fc52mr483919066b.23.1728555631809; 
 Thu, 10 Oct 2024 03:20:31 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2436fsm68240266b.53.2024.10.10.03.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 03:20:31 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] chardev/char: rename `char-mux.c` to `char-mux-fe.c`
Date: Thu, 10 Oct 2024 12:18:32 +0200
Message-Id: <20241010101838.331032-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010101838.331032-1-r.peniaev@gmail.com>
References: <20241010101838.331032-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x635.google.com
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

In the following patches backend multiplexer will be
introduced and the implementation will be named as
follows: `char-mux-be.c`. This patch renames the
frontend multiplexer from `char-mux.c` to
`char-mux-fe.c`.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/{char-mux.c => char-mux-fe.c} | 0
 chardev/meson.build                   | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename chardev/{char-mux.c => char-mux-fe.c} (100%)

diff --git a/chardev/char-mux.c b/chardev/char-mux-fe.c
similarity index 100%
rename from chardev/char-mux.c
rename to chardev/char-mux-fe.c
diff --git a/chardev/meson.build b/chardev/meson.build
index 70070a8279a9..778444a00ca6 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -2,7 +2,7 @@ chardev_ss.add(files(
   'char-fe.c',
   'char-file.c',
   'char-io.c',
-  'char-mux.c',
+  'char-mux-fe.c',
   'char-null.c',
   'char-pipe.c',
   'char-ringbuf.c',
-- 
2.34.1


