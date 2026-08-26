Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25759C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbV-0007nq-CW; Wed, 26 Aug 2026 07:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbT-0007mU-AD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:35 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbR-0004GY-CU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:34 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so989719a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742932; x=1788347732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4OvjEK79iipyYsErass3i3smJBr1fz2J2WXOxSNzKOM=;
 b=uE30UZhSOitISQ20PHbQe9utOCD4zQx0t3s7tUsrhuan7meAhKFMtA7L66/UFcx5Ud
 00oetdwomjuUT3DsDEOQq39eqpORNUiD4DWkrxQ71W3EV0P3sgpLh7xX0GnhB9JJn7EU
 QqoI4Io+gp9ZRKk9zh9FqID7FE7m5YzIdoDm4QOKtzEQFcmqCTd+a37g3jm+8SzcWn0C
 /g7N1p2O3cnWxEwttD9W8RY5LhAzLg579L4sJ+2jM43gQ3mMkairhb4uZg9KoXGMsHNy
 j9AEg2aafhsBVxQ0o61CqIdroVgu4NtIhnQb+fmxPltBcAyP9CgzlzI05qYM5Lal1dJ/
 lx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742932; x=1788347732;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4OvjEK79iipyYsErass3i3smJBr1fz2J2WXOxSNzKOM=;
 b=Gcy/amly1qbGB6K0jVbwjX6aKRvsPRDqoNpccjqDoDYqPq8f0hYEnMsoQMWBR5yzlq
 Yv7IayyUPuqYmN75Ry1rgyMWji+EQs+eIA2oIt/75cK5jzQH7ZXv8IP5T+3y1aR2EpBc
 pHFZgQZVWpS8YTsjuyACmJ6Cgs3pABGvJl0ZnhdIyXoqqhixsn09QWWmpYAiQDqHsDn5
 ftJZD7Z2j5wJE2s2LW0Rn52cMNuacPybrC6V5UInz3TiHhkelvLAg4ztQNGVSvy1APhw
 z7j+sk41pdH2CyoqKrwjY29Y+0+Kcc7lSuuy1Ir6Dk5+tpd0Zp1OhxtWMIZ2VAWqNJQE
 dJVw==
X-Gm-Message-State: AFuF++m9AWk28+zHciew697+J/Zee6XwP4bt4XFVmbLxqQSG2QFHM33e
 foH9WeSPUXBjUyhSKK9HmsMLBbkNTdSBL4zFJSoMr8mM/WEfPd5pRAAcIAg0XeLLIzPuPZFrHIk
 Rc6MU
X-Gm-Gg: AR+sD110Kl4wRdEcHfNIwyp5eqV4nOrxibag5mne8SuMeF8ObjFNZB/qT0FBPm4xweM
 s6WH2CpCuUwOh4m0HjnFK5lThWfITtSUk4+rfrq3r9nHsWuIRW33Z5LCBctlGaQLlpIenqyJNCh
 PwF2xTxNz3r1NPHO+fPFLf9+tzg0yVZ2PIfGAq4Mbnqh45ZhzSqVmgxSmuN49V3oRgRsVg1DJQw
 tupcwc+FRi9OAV3ds0o5CnsxVXOunJxlHZDb4T/BnH0LyPyre394RiOT+Ml8qrDC0s3StIYfOSr
 3XQ3UoPJxqreIxvrHdkli0Hp/xoc70smhNVYVjT/q+UAaIM2oNuGVUOeLY6KUU/OnLzGO/ElpVw
 V3373Th0SibxJMlF6Z4lrUiPfoTTV3tvypSHMUidZL82cG3rMdYd2Vzfr8mjimVdMqVUTDgZzlA
 cM2azNjKfvdrNHlzHimxXn12dW1hhnHyQ5EdfpMdA/e+m8XZ62
X-Received: by 2002:a05:6402:a3da:b0:6a1:f8ad:6c0c with SMTP id
 4fb4d7f45d1cf-6a5df6a3028mr5467675a12.16.1787742931715; 
 Wed, 26 Aug 2026 04:15:31 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 03/28] tests/qtest/libqos/ahci: allow a count and an expected
 error
Date: Wed, 26 Aug 2026 13:15:18 +0200
Message-ID: <20260826111524.3383479-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=den@openvz.org; helo=mail-ed1-x52a.google.com
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

From: Denis V. Lunev <den@openvz.org>

A command that transfers no data can still take an argument in the count
register of the register FIS, and a test may well expect such a command
to be aborted. AHCICommand is private to the library, so add two
setters: ahci_command_set_count() writes the count of a non-data
command, and ahci_command_expect_error() records the error register bits
the command is expected to complete with, which is what
ahci_atapi_test_ready() does inline for a sense key today.

INITIALIZE DEVICE PARAMETERS is the first user of both, so describe it
in the command properties table as well.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/libqos/ahci.c | 14 ++++++++++++++
 tests/qtest/libqos/ahci.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index e3019a1eca..50b63239c2 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -74,6 +74,7 @@ AHCICommandProp ahci_command_properties[] = {
     { .cmd = CMD_READ_MAX,       .lba28 = true },
     { .cmd = CMD_READ_MAX_EXT,   .lba48 = true },
     { .cmd = CMD_FLUSH_CACHE,    .data = false },
+    { .cmd = CMD_INIT_DP,        .data = false },
     { .cmd = CMD_PACKET,         .data = true,  .size = 16,
                                  .atapi = true, .pio = true },
     { .cmd = CMD_PACKET_ID,      .data = true,  .pio = true,
@@ -1180,6 +1181,19 @@ void ahci_command_set_prd_size(AHCICommand *cmd, unsigned prd_size)
     ahci_command_set_sizes(cmd, cmd->xbytes, prd_size);
 }
 
+/* For a no-data command, whose count carries an argument of its own */
+void ahci_command_set_count(AHCICommand *cmd, uint16_t count)
+{
+    g_assert(!cmd->props->data);
+    cmd->fis.count = count;
+}
+
+void ahci_command_expect_error(AHCICommand *cmd, uint8_t err)
+{
+    cmd->interrupts |= AHCI_PX_IS_TFES;
+    cmd->errors |= err;
+}
+
 void ahci_command_adjust(AHCICommand *cmd, uint64_t offset, uint64_t buffer,
                          uint64_t xbytes, unsigned prd_size)
 {
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 2a48a7523d..6d861c79ee 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -278,6 +278,7 @@ enum {
     CMD_READ_MAX       = 0xF8,
     CMD_READ_MAX_EXT   = 0x27,
     CMD_FLUSH_CACHE    = 0xE7,
+    CMD_INIT_DP        = 0x91, /* INITIALIZE DEVICE PARAMETERS */
     CMD_IDENTIFY       = 0xEC,
     CMD_PACKET         = 0xA0,
     CMD_PACKET_ID      = 0xA1,
@@ -324,6 +325,9 @@ enum {
 #define ATA_DEVICE_DRIVE 0x10
 #define ATA_DEVICE_HEAD  0x0F
 
+/* ATA error register bits */
+#define ATA_ERR_ABRT     0x04
+
 /*** Structures ***/
 
 typedef struct AHCIPortQState {
@@ -638,6 +642,8 @@ void ahci_command_set_size(AHCICommand *cmd, uint64_t xbytes);
 void ahci_command_set_prd_size(AHCICommand *cmd, unsigned prd_size);
 void ahci_command_set_sizes(AHCICommand *cmd, uint64_t xbytes,
                             unsigned prd_size);
+void ahci_command_set_count(AHCICommand *cmd, uint16_t count);
+void ahci_command_expect_error(AHCICommand *cmd, uint8_t err);
 void ahci_command_set_acmd(AHCICommand *cmd, void *acmd);
 void ahci_command_enable_atapi_dma(AHCICommand *cmd);
 void ahci_command_adjust(AHCICommand *cmd, uint64_t lba_sect, uint64_t gbuffer,
-- 
2.53.0


