Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB151D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsdE-0007Oo-Bh; Thu, 08 Jan 2026 11:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscz-0006oH-Lk
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscy-0002uR-6t
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477770019e4so27546065e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767888766; x=1768493566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZYXIefjG3vv0B8BkvXHa3cG6Saexu6FniUqafexem4=;
 b=eJxnkj+N54kxN8zSqVLHjNbuRvQNPdD1nTAd+iJVqWHZEdNhGruUlQFaCPA/zuFBUR
 V198uB4ozDiG/ebm71pvCu6ik29uA7E6lHNL7/TpiBbkVCBwVeHctDmOC+ZFMYd1dcjR
 RjBkKUDAdb1W7Unb/+KItgGKKVSO0wb9h6/HA7dc7VoalgZBGF7z13/gBHqHP9tTMXIb
 5Bmorj29K5+dsdD1A3WdPS1VD6hCTbN3k+i2m533coJ4NP7dhBwDtLvBfUzQD2Buvv2B
 c26YDrbE55bTKxxx7vmDMBivd9xt4Y5KIOOdlaSu6HLk7PJEz8AMHHrfPJ8CXvLzNlXY
 KwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888766; x=1768493566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ZYXIefjG3vv0B8BkvXHa3cG6Saexu6FniUqafexem4=;
 b=Gb3AcPhWh+6LuPFwAcw2mldYOhmPLAhH1zk1BQRI73L4Rhac4+eKAQXqcly0Ow55mq
 cUFpExVVKGB39U3jbfkEaA6OufJMgyvn7eSh+Zdcqz5p9XcAtYWPeXF9u1hN4+v8P511
 qGtLZWMhosIV8s+aFVSDqeEOD4DlvFHS/ZrwrsSwDIs8NykvF5VSn2DPP7Mz77HV3C9y
 SMORSpoG6KZ6b8Ynt7IO+GkC1qYr5DGpqpxzkteU43PGpk8QSeoWamLvNgN+eHzsqm8b
 KaEsKV1HQjqG5O/D+QEoFxvzwOfkJYddtnaQPUlJWdVujFyDTFDyot7KBwkFUwtxqxIl
 oxig==
X-Gm-Message-State: AOJu0YwySVj0rcbp982oWlF2as+tkpBKKeNDJSJ83vooXwA8xL15Bowt
 ugXh8pbYQvrSSaaI2izVr+qL46KxhKgQyIta3v10p912P+o47GYtLpPLvRMbvdBxB9L33F3Aewc
 y5GaEC7Y=
X-Gm-Gg: AY/fxX7gx7ajhY/9jgbygszxhCwJq91ORXSoga/RBZmdiZQsQIXLYMRLZ6T6vxBy4X7
 n6fLb91xzqIAY1MzbUWkjUE+qVWhsWJyC58icHYHa7WI6fWn+VVHYseCaUVlWIc5sMUMOnpnBCt
 eC6NaMWB76o32Nq+5vMuAiQfJTw0/43wEwnz5G4X6RHBaLWfTiLMTYpG/XY2S/Yo46vxEIqi53X
 kUlaaRFvhxzPhsyXBp9+9z7mdfScgMCmUALmIMHIqwD3CcE1Rb4gVlGJxJD7d7Bt3kQiR4oJXYU
 NqlsAebMg5mceN6KVaz9lhsNnGgxhlb8fzlHK84mq/709F/CNjIS3vLAKs5DW0Ng4oACuAIbNQy
 b5CoeyJJljTXek1F6wfJHqoSlGJ0WqTEU9PhvbApjuwj7f9SycwL5wuZcpiYT/rsInM4Z4dlwnx
 vhYwUkXBgjd6nvalYWxHQmBa+aB9UGdumi87QGFFBjT5MJNLme8H7sXRMR/k6j
X-Google-Smtp-Source: AGHT+IENgN4IyYGBtZ3Y1FqXsp+HAYZTfs3r6StaL+RhD0WU29pGSnd+X2pxQFUX/owectZLwz/VCQ==
X-Received: by 2002:a05:6000:2dc1:b0:430:f3ab:56af with SMTP id
 ffacd0b85a97d-432c379f196mr8833535f8f.48.1767888765821; 
 Thu, 08 Jan 2026 08:12:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm17658306f8f.22.2026.01.08.08.12.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 08:12:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] dump: Abort in create_win_dump() on non-x86 guests
Date: Thu,  8 Jan 2026 17:12:18 +0100
Message-ID: <20260108161220.15146-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161220.15146-1-philmd@linaro.org>
References: <20260108161220.15146-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

qmp_dump_guest_memory() checks win_dump_available()
before calling create_win_dump(). On non-x86 targets
calling it would be a programming error, so abort.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/win_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index d42427feb22..e5fdc12ad34 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -506,7 +506,7 @@ bool win_dump_available(DumpState *s, Error **errp)
 
 void create_win_dump(DumpState *s, Error **errp)
 {
-    win_dump_available(s, errp);
+    g_assert_not_reached();
 }
 
 #endif
-- 
2.52.0


