Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6590BEB1043
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuc1-0000oo-Ge; Tue, 10 Mar 2026 06:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubz-0000YW-MR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuby-0005wA-4g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso11052515e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139608; x=1773744408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gG/eFUNag0sga244ZYIXxyNH3wkjdqFekZ1TsgRZSvo=;
 b=XRKheFQw3n1LRZ7tC6nVDeyUJ0EKpzPuxN8m8fmUAEuZ4KGdmKk5lGzj0Xe55/IiOT
 46HWs5a8D1n3gmou79adXdrX4JTjdavvmQgoIHI/aD2Fu1f2GhnY4CPGBW3P4vnGNoRx
 gqMQ5nSQmiZt2dtiOaXyyFEdFOXeN8YtUzG2om0Mbxv3JL2W6WcmtQZXAGV11kLcz8Ud
 BZMOXy0rs6PLjpiysP8rSDsCKLW/e8D0xaHPvGO69loZToKWpAaZfH87ZkfKbF4KsJKE
 MOiMQYMS6blZjTMg7SSN+bN8tjga9wZgO8qkOu0E9/WXfjUaa6tQrIZEexf6hQcsqtZN
 UyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139608; x=1773744408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gG/eFUNag0sga244ZYIXxyNH3wkjdqFekZ1TsgRZSvo=;
 b=QbqZVXAeVB4ibd8JfIg+sR8Mat+Hoiv3pwTSfa5Wa1kMdZkR0VEmqisFdjQihLO0AC
 dqdN33MVirkml0QiEFw0HYRKnQsZUAvcLqgeiwnbx7Wz9SStea/2qM8ctxpTXHUyPv+b
 2q0zcCAhmTLTx1dbg05K/GGy1cegWV1TWySh7sbtBvcEc/6rImc9FZHG4Rtlol49lRsw
 376qYBpYvxfWr/O2CXZvueabpyZvcYhcLxHnZIIMR/DRsmkqnLSdr/ZPV87wX7MvM0Xd
 KcgqKfSlNZBBD9wjlUWnVh2pA041oDGOUwMdW7WxXDzw3Zh+nNFXphEiJ9MEHiYL+NBH
 2qjA==
X-Gm-Message-State: AOJu0YyJOres49SmTVH3nIAE/f4oqAaNOyxAJl8QQZB8NfTdDOljKOSG
 pxD9U/0Jn/1XUUO+w4NZQMIIfvWyYWKBRE29z2gzIJV0UXnzN0tdsZICf6XayzQ4cw3M/Ue0REv
 C8JIQmVE=
X-Gm-Gg: ATEYQzzf8yMiinhQRkBgF+8PIJQXd3fMqisD2RnfRZ94pSDxYI8x5kKCslDgIBwK2QF
 Hnth32FBplikpZhyUmPfccNU/8Wv56xqlPQTCssjLjQMDokQ8wwJQpphMYaqPo/qRXWJ67zM7oM
 4SfPSxEbGu5auinQvwMeu2SNwGMNKN15A77O25V5X34lpbrLRFXddD5GSIzAFafAZ9bG51C7Eat
 r0n00AoFla/4/A2/FbGaRZLKb76lG1eNpKTrw/I2hd2Hx2WoYkFWUwTp7rI6+yiD3klPs5vogdR
 6poVos0tcyvpvcaYRyoOMkGMndWbDZPR7uxW40cQ1uKBxDVDdZDTDSyK9rChylD6uumwVP0G4Qm
 HuRKqfO6Q6Bj9X4174g5AiACRJLci9EHAP0jtfiVnWrMLys0FyHfxfVQL+6h6CzfsEmJhtXh7aZ
 tfD8GNL04j6gHx4sebgzRIjZS867f9UKWc1x+f9OPoFDCDI6fvHnbeguaNCf0lIRR6lxmzX0Qc
X-Received: by 2002:a05:600c:a12:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-48526966b07mr220958665e9.25.1773139608403; 
 Tue, 10 Mar 2026 03:46:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6b7sm88749875e9.9.2026.03.10.03.46.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] accel/hvf: Build without target-specific knowledge
Date: Tue, 10 Mar 2026 11:45:09 +0100
Message-ID: <20260310104511.12670-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Code in accel/ aims to be target-agnostic. Enforce that
by moving the HVF file units to system_ss[], which is
target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225051303.91614-5-philmd@linaro.org>
---
 accel/hvf/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/hvf/meson.build b/accel/hvf/meson.build
index fc52cb78433..6e2dcc4a5f0 100644
--- a/accel/hvf/meson.build
+++ b/accel/hvf/meson.build
@@ -1,7 +1,4 @@
-hvf_ss = ss.source_set()
-hvf_ss.add(files(
+system_ss.add(when: 'CONFIG_HVF', if_true: files(
   'hvf-all.c',
   'hvf-accel-ops.c',
 ))
-
-specific_ss.add_all(when: 'CONFIG_HVF', if_true: hvf_ss)
-- 
2.53.0


