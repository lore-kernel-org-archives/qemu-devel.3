Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBC5D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghql-0007Jk-Vp; Fri, 16 Jan 2026 06:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqN-00076v-Sk
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqM-0005eh-BV
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:19 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so10376185e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562296; x=1769167096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Py+D4Z2jLFhk0Imy0zLvCVBhfBDbviITMroIchXNosY=;
 b=IiSirVriiZajLw8Tall+4smF+IwWHEKxWGfNNXPYMt1ZKCvBnZQySDPEO73zY9W88O
 b44VTIWxrGeSgFxN4TKeE1T/izMBos5wO28Oy0Xm05RqaL3UaPGG2c1C98ynt6Jtp9U4
 SxyhVcHBIuMm6jHHRsSQSrMvWGDjjTMWdIeUWz+BxfABAJDcbtrCg0elnlCaESbSYYty
 BJ0BT5HFj65RaShrUXeXuurjOUpR0+PGwHnDdQ1nYJX3tZ5D2l2MLrctvir7o6ODd4uW
 1ORWju7MT03a8IjBwZqhYS3vlJOdll+yKYMyBTTiMl1LGnKLbkaRNr2bIRk8vXNnVMZ3
 AroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562296; x=1769167096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Py+D4Z2jLFhk0Imy0zLvCVBhfBDbviITMroIchXNosY=;
 b=oSLvp48n1127vgJVt1uJ2ZK/5jm4WK8VcCoRCxWlWeIaQ6AZtogMgmhgyLxKb7P95q
 Mz1UmV3vstC12KKluECPLuNXI2Zf+5b9xtkEp1/s9xbUvPdtPTNu/GfnfPPLCpUEXxs+
 JTbex228Tv2n60gMXt351hGUHbpZhJ0GVLVC76k8QSqE2i+W0UxQFlnTM2Kzq1R7Mc49
 gkcuPINbX2LlblAL8+M88+wjstySmWY7T0HxSGT9BIfCUU1MF4N0CywJEYHXuTYhLxfr
 yqEKqpa0CoDUn2x1G//dgP+4qjjX/Rkw8G2ijbRk2WRU2QppzuS/+a8S2H3o3Bu8NkFe
 TUpQ==
X-Gm-Message-State: AOJu0YzRiMJ0+EBPuQNFFK3sy6idXLJ3KTpfKNKYoPommU1xRCYXh7hO
 pVSSnUk1errWbktS+05tn3xYesqpVUdONdSe9/EcCFMsck4XL9YhaNWT4kgVpbNzXjC4uaNJKBz
 Z0MBOeQc=
X-Gm-Gg: AY/fxX7dJv7XPr17gstRPZ1a/fesBRhQwKM1byl1qbHIkWa1UF/6eB7KJiAYlWwUe0I
 X7z4fT8xWjBHESgUlmSRLyJoQTqVSx+zaXOgET2aAlCI2ey8+FeG1+tUTMtogKdrjRivLAOSwZ1
 m6Le2mRq4d1H7i5AhmLlBRJogUzQe241SaNJbYEvJHqJLE87mtDk5EWZcPID6AlXNUxzLeGh9Ie
 xzHZZ/kmXUk3FzC2FjimavO8XEv55CqC+4EVeMO0YC9lWMMnMneuK+QQOHiFlCh/wJXvhp/nRQu
 qQCaRX1MkwVOnuNmaWmtuMbDsWVvDWL1Z6Rphzxj1Ha2n1BcnVxmCW7sFGSUNcTu7IPoitZ3JaP
 10YwpIhccOGqPC44nXqblTnQ0MYraSP8kt2EkM8sluOzGAawJgOT91INaQIdXQvdkjff7ykvFBz
 XTUZKH3T6s5LOrcXr4EH5XW6aoghB+0Zb+Be0A231XrdtYjc/SIY3xrtCY2Iyd
X-Received: by 2002:a05:600c:6209:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-48023ea2fc7mr11261285e9.4.1768562295829; 
 Fri, 16 Jan 2026 03:18:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm93855695e9.9.2026.01.16.03.18.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/30] migration/dirtyrate: Do not unlock cpu_list lock twice
Date: Fri, 16 Jan 2026 12:17:38 +0100
Message-ID: <20260116111807.36053-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

&qemu_cpu_list_lock is locked within the WITH_QEMU_LOCK_GUARD()
context, then unlocked. No need to manually unlock it.

Fixes: 370ed600296 ("cpu: expose qemu_cpu_list_lock for lock-guard use")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250128135429.8500-2-philmd@linaro.org>
---
 migration/dirtyrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 986624c79a1..58f04670629 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -174,7 +174,6 @@ retry:
         if (gen_id != cpu_list_generation_id_get()) {
             g_free(records);
             g_free(stat->rates);
-            cpu_list_unlock();
             goto retry;
         }
         vcpu_dirty_stat_collect(records, false);
-- 
2.52.0


