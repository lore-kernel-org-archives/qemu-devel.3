Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9C4C9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMW4-0002Y9-Eq; Sat, 26 Sep 2026 03:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSE-0005db-KM
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:19 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSB-0000ia-IU
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:13 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-33be7dfcfc1so2110431eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406249; x=1791011049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RNlqCeZxxjHAxzDk9z7qImwINCBhWsreM3aP9qjpGBI=;
 b=c0on/Pv0GVJ4/31GKofUVlJ4V0qM1Bms/ELoH87hLngFz0ZuvPO6qhoucDO2siqRCg
 GDqephXtY6fqfvrczM5wMwigUQ4zRX9hZ5yN7YOy7F8WTUOvSBsLlw3ZxiZZp5OxtkCO
 8syg2x0Z3UXELkxmu+/jDqYaavFPP6kqW6MLd9Zez4aN/1n72eM4battLcUj8WRIUXpB
 Oi9eqUZtwRvnw4IAhnyRyMMnmDGyO2Y+JXGzxoMz0MnGBswyguCf/JRRCJwCT81eHUzJ
 VKJXu62WcIo6hOrC+47A1dDJWk3W/IyjFn5x7Lor69nj0jt8TNiFUOx/n7aPl/mjJm9q
 AHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406249; x=1791011049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RNlqCeZxxjHAxzDk9z7qImwINCBhWsreM3aP9qjpGBI=;
 b=nrc6kj0Y91IHmu7ctv3afQKK5lJ0WahVxiFhJawdlSUSdgsXkx2SlaQy13x06zaQoI
 dbkIPlrhAfqac4iGcyZs4Ak03D6y0pcOGocfZPJcc6a2za0xD1kxvZ9EdW8aAr1Jl0B6
 JiF0RWZJq8P45MNcnc4jDG7DHbon0uVhOkV5M4sxX8xFXxNtTuTBtMgcn9qt0C++DIBG
 83tatnJ4RD/fOjdiWT6qina1s7feTYQWnTV2vHj/6sqpz5LHwIfmmECdPK+VpblF1xOB
 qGwpO9qA7DQLcFaRL55yvD4R1jxZV1Ly2JA22wbAu+qCYpz6JH4GV6bHcaKa2I0J/yYi
 kIEw==
X-Gm-Message-State: AFuF++kokvn4nNYlH6wtNdfEiVA1Q2ZNr1p3x8V3j5uGVRq5oSBYhire
 j+dUbY94Zy0C3uR3LXGdfHGh3J61BqnfvBYZpJxW3xXevsPMiQyye7EiCnNsOspV
X-Gm-Gg: AYBFou22MqhV8mHfmBJPawX+z81n02UDQKyr6BbELF8ZafTg+o2bUuwn7cJdUhi2zsU
 GCaQh1fyMrL3QVf0wSbyuhaiL9uW85pd5kvUQB435jTrU5yJIqf+6FwecxgcS6Is2+gY+ghrAsR
 ExCpdc2NAKlhQm7K8PmfeYDR1imZFROwNDnQm8IN0NuxohReSGnLAU4YleF8ZCTdOgG1T6cfQ11
 RG4Qx+7XB+uVGlzGKyOA/n7IZasW09YSzKbqAi6abHsnfaDqkvT10qIrPetoSQ6LNBWDKPmBoFM
 HaEjWdNHwn+RVV1+PN00alqfTCr5Q72mOL8FVXxowELJyrqETVXHibWKF8xxFB/bzHkLlMe40Ps
 QfTvpBk8MjBLunLUAlA6ukpFWhtxX8Y4PXSZ8OBQTUPN2chHLQfeKpZ7U4Q64s5sHMLIyG3++nn
 a8sJewCgoVmYHz6l/4MFGPWXXO+GdOvIBcnVdb3tE6Q3VlY2EBqIgwqJsqOTikc4tJn/0A6w/1A
 Sk49vc4PIPt9Rb0mc5cQE6mKEUuuOI=
X-Received: by 2002:a05:7300:a987:b0:333:fe81:85dd with SMTP id
 5a478bee46e88-3426fbbe744mr3025019eec.3.1790406249289; 
 Sat, 26 Sep 2026 00:04:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:04:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 47/55] target-info: add target_is_microblaze
Date: Sat, 26 Sep 2026 15:00:46 +0800
Message-ID: <20260926070057.1234-48-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add target_is_microblaze() and target_microblaze(). The first
reports SYS_EMU_TARGET_MICROBLAZE. The second checks the current
TargetInfo.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 15 +++++++++++++++
 target-info.c              | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 812e4b04a7b..17fafa0888e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -210,6 +210,21 @@ bool target_is_s390x(const TargetInfo *ti);
  */
 bool target_s390x(void);
 
+/**
+ * target_is_microblaze:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is Microblaze.
+ */
+bool target_is_microblaze(const TargetInfo *ti);
+
+/**
+ * target_microblaze:
+ *
+ * Returns whether the target architecture is Microblaze.
+ */
+bool target_microblaze(void);
+
 /**
  * target_is_base_riscv:
  * @ti: TargetInfo to inspect
diff --git a/target-info.c b/target-info.c
index b25e2ada438..0716e2021b8 100644
--- a/target-info.c
+++ b/target-info.c
@@ -204,6 +204,16 @@ bool target_s390x(void)
     return target_is_s390x(target_info());
 }
 
+bool target_is_microblaze(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_MICROBLAZE;
+}
+
+bool target_microblaze(void)
+{
+    return target_is_microblaze(target_info());
+}
+
 bool target_is_base_riscv(const TargetInfo *ti)
 {
     switch (ti->target_arch) {
-- 
2.52.0.windows.1


