Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB58AF513ED
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyt9d-0005Wl-2H; Sat, 07 Mar 2026 10:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9b-0005Wa-Er
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:19 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9W-00055c-AC
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:16 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo4364183f8f.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772895672; x=1773500472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRgRoHeUJTr2eQRQbNrrHWjkqXp6I7X3mPegDHiCiNk=;
 b=JDqbOF+AN4DJLTNpF1xbIhZpB3Z93Dz5ILKxqjgPBifyv+c0lq5L5p2c/zCt5GWErA
 oP/lIkV/zIMtHQUM96Rt310KdwSfEhkT1tydNUi8anF0SkHa6/GJB8+5DzDMz3v6rGI4
 VgSzB0DfWJU1rNeQ0tvJ2AStdyS1EM5lji5sohXgf4azB14Wa5aAEBAW/38zEcSr9Ego
 ml5QyMaRYpOa/dt83+FVrwA3tK9L95CfTjC3yWgqsZTQfdDcWIT1FZXSdWjywNqLpmrj
 WBttzdYimB4OlBWr55p9TE9AR4GNLUl/cnX4TwYDiNXCHIdPkm/0FvAwzqvs1F4BVdsr
 K/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772895672; x=1773500472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yRgRoHeUJTr2eQRQbNrrHWjkqXp6I7X3mPegDHiCiNk=;
 b=UQpMU+JJwhD78iO4S4YULQo3jK3FjWIsnelxghni0MZyOu+CdMPZdsoHyNFc4TOp8z
 a0gB0Zrxq/HFc4dEy+qoOLfsOtagFFNaowIUzMklkQcVihXXzHYBgPJPI/croYsLmO0F
 60P/gda4b2ro2uGCpBekQriQKTrfjm5c1a7ePBX2zH/0fNK8/YpUFWF/odqjDX0fhGMA
 9XuHEdY/6UK47yznX5ad59mJrX3A1qKdO9wNg22KpgpfLF5U72NY9XNs8yDJfeRlSxEy
 lyQvPCpBE8I0QW+8ZlrpE0N0IhASeXoQqRBbcPX07M6JnVKnnKwm1nzDBi7MzBlMBUE1
 bCBQ==
X-Gm-Message-State: AOJu0YzhdaHVVGh5XM1b620CkEIOQ/2Dx4oI4gl4DWyhnwMaLVXFxc+i
 lGmYK9+IeICCVnR6WA3kKdbxdGi6FHv2V/+P/BuDsg9nYz7cVkUWVwmg34vzI6kuiXtOwc9vIQV
 Whcx4HZ0=
X-Gm-Gg: ATEYQzwlkD3JS+yom1fJTVXX6d4yPQZG0hx8w8pTTU1LyxcjQ2t0tSTf7Wgtz+dgJek
 2i9am1HbMq2v1PVy1nmsXub3VI8DBIhZNHl89i53RqHSkefQLMan/cfB2DZL0Ov/f/qz3jBjO6A
 U6EXww4FCoRVEAnAnqtSbAh09J8AiihjDbD5HkPOLFuA4JxsOiLn98NeQZgjg1uj1m1S6VQORNQ
 K7DuBjDESiZMG69t33JTw/YPyTS18JREXJEYjtVe+GHyOGa3MQotOLyBTICTV4xinihtNhNpjRO
 6wFp/RSXT1ai5ZJ6YVjjoP+uhJyPf/v20znMYdZ9qwwmZ4M4W3UAeLzq5CAAIaPvVse5Zdhk186
 Ko4JFx+38b7i3p55L4c+n19Zu6koqZdZ2H/51/anu+FcORQ3N5M0s8YW/B6MMoJjUZWQs2JPngy
 6bUI+gofILy8o9FMzeYaUV0d2eWwod1klJ/ZaMduuFZGbooha92WHsq+31A6Occ+GZlOVKeBcF
X-Received: by 2002:a05:6000:430e:b0:439:af0e:57a6 with SMTP id
 ffacd0b85a97d-439da66a2f0mr10242842f8f.36.1772895672488; 
 Sat, 07 Mar 2026 07:01:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9d8sm12300679f8f.21.2026.03.07.07.01.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:01:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 4/4] hw/core/machine: Remove the hw_compat_3_0[] array
Date: Sat,  7 Mar 2026 16:00:42 +0100
Message-ID: <20260307150042.78030-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307150042.78030-1-philmd@linaro.org>
References: <20260307150042.78030-1-philmd@linaro.org>
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

The hw_compat_3_0[] array was only used by the pc-q35-3.0
and pc-i440fx-3.0 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h | 3 ---
 hw/core/machine.c        | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index f4ee68bbea5..9ad2a7d5c97 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -871,7 +871,4 @@ extern const size_t hw_compat_4_0_len;
 extern GlobalProperty hw_compat_3_1[];
 extern const size_t hw_compat_3_1_len;
 
-extern GlobalProperty hw_compat_3_0[];
-extern const size_t hw_compat_3_0_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4770618b559..162600425b0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -238,9 +238,6 @@ GlobalProperty hw_compat_3_1[] = {
 };
 const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
 
-GlobalProperty hw_compat_3_0[] = {};
-const size_t hw_compat_3_0_len = G_N_ELEMENTS(hw_compat_3_0);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.52.0


