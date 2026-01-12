Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29016CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQlT-0002WL-U9; Mon, 12 Jan 2026 17:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlH-0002NM-8y
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:47 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlF-00037T-FF
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:46 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432755545fcso4075456f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258304; x=1768863104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FKuOoG1jgYzpcb2u6zMgGDZgvCbjfYRrFUzbXjD+byo=;
 b=jS81WmFaahh1rt8A1up1UplMv8UvwLPAgxH62Gi28AcIgq7IN/rGuKBsEEWi6a2aBT
 Gktt9iS3uTo//tWdqXywbEIwk4zpE2g65756eA5NhcOWpk/0mF3Y48En/GVzNkqfTvEk
 X+3xM0YJc3bmP3FAv2oj1OIty4WURA7Pwevxmobfg5fTIdZbmU5qI+exL3jQV25YHgXM
 TSmdsipEc4UL9bPKNJ4GKX+TT+Gyp55g80eT//MA1qTRBAcDIHHpL8CoSgGe/d06JUod
 mv4sqUiI8SP9ehq9melBm3TxHwQH2J6VhXC4aL1LQIkHvsmfGSEx6tDb76vmxwfqB8wd
 TDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258304; x=1768863104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FKuOoG1jgYzpcb2u6zMgGDZgvCbjfYRrFUzbXjD+byo=;
 b=DTGNMCsDMOjR1K1lYhr3bWo5Znd6kTviZgSlRZxjOaUWKxmYdrzYALh1pKUTMYaVC6
 PuU/r0QPI0uHdMTS7VSnujBezWG0Q7dM3J/IDPMrZn0ROUsx6H7CYA06qnz8j2rjcswJ
 LXUgP/7TNJ3JB2ZwT3RhE0kz9cYjgYs8UqVQ5E5x/OCt3bA/v2z5rX6Z2DTwVgjtO2kd
 y3RDEA7FMHP1e1npRAGB0pWYwkkFDjPbsp+Ib8GQdGIsfMwWhggtkmwTGFzthri+h7Yd
 J0XEJ5h4hzhHLWKGeWRL1EP9KMXo3xs3KQQiFw+6B4OpuQZj4xWAguUk+cswZjeMwg4l
 5ZCg==
X-Gm-Message-State: AOJu0Yz4oi1VIDec7MPRnj9oY8VeSummKTf3jikV+YO3RkK4r2yfUMyT
 4mXtueNo7mKxOwjlbPN++TvP4CQ+SbNZcS9EZOp/XCFYNWVXFY2gszO6OsEk+6PnhfmxY2xU9Fx
 KTkrj3Jo=
X-Gm-Gg: AY/fxX5FntjUP3m92p2WQOCnG65hRbhTgKaT+3+10HWOcYc0HAYGmsnM6aUwylizuNa
 9/0w5zj2KXXeu4cEP8X/HHLKEO0LoOQbWRwHIKapfWsjqrBQ6k6CjPCmlUVhOOyd94/C2lpFSxg
 yKqqvey2nyMQdL0dzPoZfm9gOrUbW6WJnevmQlX/WHkUvl8AqBh+pRYKaIXBjlLQ0fT+RqGjpqf
 b7cmka0fVdP1SpCjfXLXl7p3YmnJuL7DrN/GuAusZe2jbuCBjoNhHIe78iHPa14kr8C9TLEl5ph
 RnqzJu6y4pGOPqdhHSvVhCsZV8MXbrqS6eZGoutFt86bFssrxZFt4OWFluhW81wTY2c7Y3oc+RF
 cpfO36dXilEsgn2tek+4g6iQs+CUo8W8CGWjs6DVweVyPb0wED1s1pXqC48GD8Sq3E76tDH5Hsx
 8jPMF8Izb6mSO19Uq7Pfx9nUDSfcUwMzhImS7Uod0BNzsJkFVq06GPSn7jIEVd+6hsZTJS2N4=
X-Google-Smtp-Source: AGHT+IG3DmcFgrhy2FOQYD0CVBpGc1AwVNQkLhGxcX2sUDJGsnfgYvdNI/4qjQQjoZ0mwQrZ3SIFVw==
X-Received: by 2002:a5d:66cc:0:b0:431:384:15d2 with SMTP id
 ffacd0b85a97d-432c3760d13mr19313128f8f.53.1768258303755; 
 Mon, 12 Jan 2026 14:51:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee893sm40307164f8f.37.2026.01.12.14.51.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/61] target/hppa: Remove target_ulong use in disas_log()
 handler
Date: Mon, 12 Jan 2026 23:48:19 +0100
Message-ID: <20260112224857.42068-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
virtual addresses") the DisasContextBase::pc_first field is a vaddr
type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-9-philmd@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0b7074649b7..0f8a66f7732 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4864,7 +4864,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 static bool hppa_tr_disas_log(const DisasContextBase *dcbase,
                               CPUState *cs, FILE *logfile)
 {
-    target_ulong pc = dcbase->pc_first;
+    vaddr pc = dcbase->pc_first;
 
     switch (pc) {
     case 0x00:
-- 
2.52.0


