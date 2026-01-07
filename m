Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8904D0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZoT-0000oN-E0; Wed, 07 Jan 2026 15:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoQ-0000nX-TK
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoO-0002Dv-Of
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so21227915e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816438; x=1768421238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y77AJCQerUsc6vJoOGDSRwakqxaj1xNXQN0kQZ4hBPY=;
 b=C1ymKC+os1tgj05mu8FrUabHfNqnHBYauOCwV1AN+/uD7UtzH8RqMCE9kTwULAgr4v
 PXsGgij++yutzpWk3x5lPN6R4RGyyGUHTZotOToMrc7k7fD0RNNXpuurjgWaRujUOFdT
 /y8dNr0KSKSpEiBfiv0ylklnGrhC1ztohVkfLZAnRTao5fytHETj/OcLL/lztRiCsB/Q
 V4gjO5+VmylJZVgigRN/BlInou/p9y3rH7/QW+zs9EB3TZ4CcFhZk5ReGin56fBXKP3w
 WZzmQ3rqLq1esgEWPJKs9mZrCL9fx5m+9SVwZvkTDeydbd7lVrJAC1NhH0kBjTC0c5GF
 mBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816438; x=1768421238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y77AJCQerUsc6vJoOGDSRwakqxaj1xNXQN0kQZ4hBPY=;
 b=LHu7c+sZbqjfFhRfSRdAuHkvWimCuuGAwvqm9uzrGVJ9u+SwU/C30CE12ysfpSb+mh
 HDRJmGk1aksZgQUuIZtQ67nJD6rZv+Yt/xWIfIsZ6S24Tbkh++UlrSJ6z9Lmp8dmyAUo
 GtP8KwgmNEkkWJxrM2cPVCJf5jJM0xN2BJ3bBkpPGsphPxe5MS8mV35dNP/dEjnzyGmu
 mbNELxs7e1WN96CQXpPDwUYTUnCKuB2wW8Wx8y5Ps1Fqnfw5s2FHk1TOBnwapnvtld56
 XinXaTteKo5TfEdnoss2Ny2srjEJFdBw5geaDD131PKjBibZNbF0I45dBx+elNc9BoxH
 8cIw==
X-Gm-Message-State: AOJu0Yy1nUBOBJWD8gaOqedMUNi7yOa2InJ1wPpSUhBzoc7/mm/SwEsE
 keWI75JHZt66wOvGOpa7w0kfWTTfxExb+6NkecpfLfvT9ISRktZF52oWnmF5gXK5yxHJBnTNjdB
 bDIw1+Nc=
X-Gm-Gg: AY/fxX78lpC0088leS6Ds3BqZPWtT88Nszib7YYSlY3HmeyZiZqfeMdFCwWGIq6Xrj1
 rXC68gCAUzm4a4N9gFSmlbTmxd7QnLyvxjxG5E/G6Yd9p5yZyrZMymPxNVnxlnXofRokNFRJ4S1
 Fykqy15clzTxhHUT/+J2+3hjxOjc2VWugICxM04rMan/6VVJ3YsXRYTAf2id3UMaTcNtyBmMvoR
 fTpoaz6q83jc9mosETiLvtWwSNHEO3EeYwycgFMLWLvSBQM9CLIwAWda6K9o/eWX0VxQiAGKORq
 8AbhDUimkfENKV7Mao9XGOUR99BaM2S23z1tyXMhxxEptMpUz+U3ZRVca6bt5RfD8srEMFhb6tZ
 yM6XwBe0vjpbEb8nxO5imwsI1+hFnbbzGyDeCLX2QePGQUTgZOMHxzrp/w/jHTrGHpqI/BmhlNW
 iAUcWfvAByz+SYYP2EXwheVCCQMiMNr5woEjQwwg6NsYErxny89B0dGkogGWR3
X-Google-Smtp-Source: AGHT+IGPTY1pI3aco6cVqsvQGnrWlWXM4LYVfxMWw7DNKUl8H5skynBQXYEG4nqwfBPI7sV/YYdZjw==
X-Received: by 2002:a05:600c:3556:b0:477:63b5:6f3a with SMTP id
 5b1f17b1804b1-47d84b3bc7amr43508015e9.27.1767816438342; 
 Wed, 07 Jan 2026 12:07:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm115593655e9.0.2026.01.07.12.07.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/9] target/sh4: Build system units in common source set
Date: Wed,  7 Jan 2026 21:06:55 +0100
Message-ID: <20260107200702.54582-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since commit range 42c90609b8f..82a1e739010 we remove all
uses of the target_ulong type in target/rx/. Use the meson
target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index fe09f96684b..221700bcf8c 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -11,4 +11,4 @@ sh4_system_ss = ss.source_set()
 sh4_system_ss.add(files('monitor.c'))
 
 target_arch += {'sh4': sh4_ss}
-target_system_arch += {'sh4': sh4_system_ss}
+target_common_system_arch += {'sh4': sh4_system_ss}
-- 
2.52.0


