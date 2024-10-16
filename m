Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F234AD1AD42
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11GU-0003i5-Gi; Wed, 16 Oct 2024 06:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GR-0003hJ-Ui
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GP-00048u-Qa
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso1189611a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729074500; x=1729679300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZr22C6GyP2zNyIOBJrfarPfi36zfJfEl98MesRI/BA=;
 b=lf7Xaia6tmnLRzlYAcbbDkJ649pLHVHjo0Q5RxanuPOY1ok9dvUf6HZrjcTnfN4DM5
 zF2/ChA2ePazWr5zt6o3wD+ADxODRtfDRlYmmj9OLS7Y2pFqLumexaV4OVxNfKFaK39r
 WrUBaGHokfuILV2UsAuCXDZ3Z0ubILZxxO1Ma+o/fUvpdoUE/e1wRaGoBy66CJ2B5cxi
 OBjmXSyRwrCAlLA0wtMNKLvPuGG+6kcDv4KA2Vravryk703B5JkgviAoKrvuAaojMJ2O
 bKR+wa6u00Ur/bb7Ud+lRuicfKlJDRhc1ok0DXSFLoECrHL42NSqNgPV2HJe+sOnFEtt
 tERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729074500; x=1729679300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZr22C6GyP2zNyIOBJrfarPfi36zfJfEl98MesRI/BA=;
 b=SA5JFRMYZ4o0ol2sZl5uLDZU6kK3YS2Vx27qqVVtnDqCk/GfTx2vHjGX3Pv+9ceT4N
 s07GgGifjYb3C1H01K4R2HAv45AEpbNFDJ9DO0qYzxZjEoFAkYU4H1d8zvNnEVGduDI+
 5FMlysdvV4Byqt7Aku6/ltUcL+q0sxgeawSoOOl9usUq0vWQkiUedG64s4ugG/2yIgoV
 AIJJ15HgSXerhKfBByNWyceERQwqB7jnIcDqEj13UkFCQhPUOXe9emqGl67F1cB2MPm6
 MzvXTxg4CCGTCiHoO1TGNc7Le9wbQt2Urk0TqqXsn/b+4N2eQrSsX6kLXUcw8Xd36FQD
 vAyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgEgJSfxhlv3g+WZ4jk1gnDVwdjPfawUjprenqdI+Udd37xzGzbMJF5Nw6E9xKBDduS01olLSW2haT@nongnu.org
X-Gm-Message-State: AOJu0Ywm9ShmBZdBBashq3c9njzlECmAfnyIowMChkxJSyU4p1VLn8SJ
 YraTf9xtk1B5vE6ydASRHYMd549oSMi/bkRFF86PPRjKxY228Kkazz4vRw==
X-Google-Smtp-Source: AGHT+IHBUPL5nz7OqvsUPE8Y1i5VLjcvSprM81EOfQEbK6fjcc/rFdyFy/rWCu9mivWCXbT6kh6Z8g==
X-Received: by 2002:a05:6402:42ca:b0:5c9:85ce:d9cd with SMTP id
 4fb4d7f45d1cf-5c985cedb2cmr8335958a12.3.1729074499927; 
 Wed, 16 Oct 2024 03:28:19 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f85dcsm1566680a12.22.2024.10.16.03.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:28:19 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 2/8] chardev/char: rename `char-mux.c` to `char-mux-fe.c`
Date: Wed, 16 Oct 2024 12:25:59 +0200
Message-Id: <20241016102605.459395-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016102605.459395-1-r.peniaev@gmail.com>
References: <20241016102605.459395-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x532.google.com
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


