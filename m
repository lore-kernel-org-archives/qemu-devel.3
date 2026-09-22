Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2110CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98TH-0003KV-4N; Tue, 22 Sep 2026 17:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98TE-0003H8-GX
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:13 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98TC-0000ww-5B
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:12 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664c2da6so158350eec.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790114169; x=1790718969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FFu1GWUOTl4gGw9oxLcpuVAdjKyzH7fM1wcdIhlx/50=;
 b=rL1JGwkfncG8j2h4BX8+L2QbBhlfbLC6A/zEeeXEBU+M9NWrhKjGG4ESkpj/Mm1jwQ
 XMXcSxpLLfnTM1JgptPjTIoSp+b6wI5SD+dhZDjYaz2c63XgD3Opn0npYGtGeshzS0oc
 yJjnY/4ravYrn3VbuIZrujjnG6ZINk4C/t2rsE18l5pk7EYABhxWqeVYfigoNNlJOaBV
 +tEcUJ27A5X5m3P0R3JbF/EmAb/cxNC1m6kGBRyJdA06FgVY9BhZsQmrF1/AxqhnT/Zy
 3NUdutUMymccRV631L3sn4A9LpgsJ48aBZk7aGS3Yje7cfPis9bMVZcJ27jLusrflxwX
 z34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790114169; x=1790718969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FFu1GWUOTl4gGw9oxLcpuVAdjKyzH7fM1wcdIhlx/50=;
 b=H4xTev1j1rqyLNh+uHHZ1JfsVfilKKGgMm2O0mA/1xxVgBOWo3iE0bZY9uiybWQSMz
 5Ri5+mDQGoMEyeD8fYGZudeOenHmmWniJSASY4lHbjuUpo7y3zbkTzNiP21sNJnuDasl
 OLtuKphg433abzofA0z0qYkGHq4Gi0mtZb9z3Vq89sGy78L1GGT3JJaDt2NSGUgsMepW
 g4biqsa2FAY6hwdZQEy0guYm1GwdEd8lhKekKv/DwsM92WbC8VDAmRWicuOEP0rHde4n
 VlnoQHJ7UgNXBucFRQVSe5yKftkrNfDhte20RfkbPHzFjTlm00oeI6ix3QBx3chwk6Nf
 cJow==
X-Gm-Message-State: AFuF++lZE1J66Dig88zTKEoZF4TQUgkf36eXTk0orF6jD+dSrjSzW4kw
 eippkS5WgCIRNgq0RcIicTfIYpVpZ72UobHBdl90bS2QW7soxgVyQA7ZLwVXY0MWKgo=
X-Gm-Gg: AYBFou22iI1sBC+QsX3bpJUw8c2+0S4R1Oxe/7Xxi8oIsaeBsyhOcwFy415cPwh4wy2
 tOLQMkB7rQzcs9GwQLzyOfXYWs2/TCMOmz19Rl30c5OIs6c6iW4OwJ50mxCFdu4xU82Der51UVZ
 xQwa+U7lIuDHn0PnwHpi3IF2rKoV23sLLtl+ZASVxYSatkFKU1zqMQtWXTn1C6t12AZuA2yJh8k
 UeJ/Bel5v5I3eKBB5J1hAaXk4N8s1+5x4U7h5oJDMwhaWLMzfVf9DwblMZYcjlcEXEftuSNgzrq
 ZjKYxMBuunD6Wjih4HX0WXiVqm6lgi/wX/fzaolO/qMPL9TsKCby9gswz+0n9AqAyNqIuw7H8M9
 6kJC3mmovPfEUbfbz7xlEud0GosS6i0Fs+1lNxfoZUXOtoVAjqHSk0c3Pq0ofD0Elcec0HTwe23
 jXeyerjc6O1MBrO9r2mg4vNLjxkhXtEsuPzW29vVSYTFousYC9LqE2IzILdzv0Pk2CVk+HIQ4E/
 uxBQtCbIetimnh6q6fVaAHfG1bJXto=
X-Received: by 2002:a05:7022:fa9:b0:143:296a:4e57 with SMTP id
 a92af1059eb24-144f915c8fcmr1037399c88.26.1790114168519; 
 Tue, 22 Sep 2026 14:56:08 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144f949e60dsm1001153c88.2.2026.09.22.14.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 14:56:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>,
 Markus Armbruster <armbru@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 4/9] hw/or1k/virt: use unique QOM name
Date: Wed, 23 Sep 2026 05:55:27 +0800
Message-ID: <20260922215533.641-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260922215533.641-1-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("or1k-virt") so OpenRISC
virt no longer collides with other virt-machine types in one process.
Keep the -M / help / migration name as virt via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/or1k/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 2ff5c084a2b..35884252379 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -34,7 +34,7 @@
 #define VIRT_CPUS_MAX 4
 #define VIRT_CLK_MHZ 20000000
 
-#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("or1k-virt")
 #define VIRT_MACHINE(obj) \
     OBJECT_CHECK(OR1KVirtState, (obj), TYPE_VIRT_MACHINE)
 
@@ -548,6 +548,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "or1k virtual machine";
+    machine_class_set_name(mc, "virt");
     mc->init = openrisc_virt_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
-- 
2.52.0.windows.1


