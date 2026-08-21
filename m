Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D14EC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMnf-0003Fa-M7; Fri, 21 Aug 2026 06:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wxMne-0003Es-4D
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:48:38 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wxMnc-0002iM-Ac
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:48:37 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a3fda88184so1550208a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1787309314; x=1787914114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F+0CD52geVbAnj+JLHfj3iZ7QCvQAELc6Kfran7U1FM=;
 b=Atc3wTth7kAIqEOpzBbLsbftFuxt8CFcKcy5l+ZAyHtGlVYyJD4UDuHn3KkITU1WdR
 RJMRqphRqNg2FbKAkWY7FyLH5Ke1TrZFBg0HfXe03bh2p7euiI40GpryVt1nDbls2ab2
 DSHJvzP9b2xwFjrEFyfVZJ0a2t9gkV5dzgrIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309314; x=1787914114;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+0CD52geVbAnj+JLHfj3iZ7QCvQAELc6Kfran7U1FM=;
 b=ZJUIqpUvYopUayXJj4fv01UQCe/GiNGFxiukDMBd5UqF2KYZYugCrWJWGpk+cugSKH
 LR9aglTf7YF5nKbF0muksgxbYtKHeHXxDMEc0TlrbQpBLwwftTZdiD6gwm7RP+EBkHXN
 OSWkCdxR6dCeVuxKUf8gd4iTwqtOc9X0wAw3h06GczMZzfIywEiFWQhIullGfHVeeYt1
 G+nZtYISCAYpMUXByIqp3ndP7sYPnFVAh2rl4b5bDMi+GSGESvkLYJNUU8XCMnSpfsVa
 d8xp8xvRu9cYrD1mWOxGhmbQ6mKvM53TRJhvhc4t6iojQlCgnUNbgX400Haqj0wBuDGo
 U2MQ==
X-Gm-Message-State: AFuF++kQr6ufdvUSGIP7mytVS/MPQ14cK0ZB4/U5M/KVf8UBTgo0zbEG
 wO6m9B5Jxg4roHFCH75PGhIkNFSOz6gOavrOKI+uTXaPSLx79n2HkO6+b0a6ls5K23QsM7AcDMF
 ZoeFg
X-Gm-Gg: AR+sD12ZGKPd41T00wzqsj8btRW+aOvBi63gK0ZOmjTBg83FeZtHZnAe9LZzvR8Wlrj
 oEsE6/Ed3VNXtsLZ4jQGcDAZRMOwuKk4RFqhqfej+qrEd4Oifjk4a+67hwkx4icHIR81GrzBMdK
 V6d5yzLRRKFfP+IKYRLib4H/4Osy4IcwZH+MYGgFyhfGpMm2YRncjcZTfwVM+jhewowJJlr1AjX
 lCC8miTNHx+fmWVU8O/LZRxY/Aw2ay4ToWmHIjoPIkdTEmVVN6DC8ppswl3Fj2Ch/UMrBEYMIKY
 oWh2415GNTbB9dk/W2pmdu0C6rMY/V7nqqdQ6efZUG1JPX3yl2XbRWS+wVi6p6GNN1e5YImNPNh
 thNJIjHIU2xsAzWJByYb4WuaGuWdLe4Mh0EKFmXz7v9OmiM2Usbl8uwOlUn9lJWhBoLw5bMZyhX
 F1tmUzWg4uB+6fwByljeb99iSX1ZZgpgNBDFr8Bg3CLrjonkszXx7pwx5chx9djO3Vxmnu1IpoJ
 qvuvml9BZcWex8aAoDq8bC9I5K4fR0buJnYuGi27i1FxpU+3LA24+mSxmI=
X-Received: by 2002:a17:907:d649:b0:c19:6d4a:425b with SMTP id
 a640c23a62f3a-c246a626403mr490436766b.18.1787309314396; 
 Fri, 21 Aug 2026 03:48:34 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf573be100f155523960c6bbe7.dip0.t-ipconnect.de.
 [2003:cf:573b:e100:f155:5239:60c6:bbe7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459223816sm459070266b.57.2026.08.21.03.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 03:48:33 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4] hw/char/pl011: support backend hotswap
Date: Fri, 21 Aug 2026 12:48:32 +0200
Message-ID: <20260821104832.151452-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x52c.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Currently, when Incus issues "chardev-change" QMP command to change
chardev backend from ringbuf to socket it receives an error (with aarch64 VM):
"Chardev user does not support chardev hotswap" [1], [2]

Let's fix this by properly implementing BackendChangeHandler for pl011.

Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, because
if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is true),
then after change we need to send break to a new backend too.

Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-console-on-arm-architecture/23096/3 [1]
Link: https://github.com/lxc/distrobuilder/issues/892 [2]
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
v4:
	- changed pl011_set_break() signature
	  [ as suggested by Peter Maydell ]
v3:
	- introduced pl011_set_handlers()
	  [ as suggested by Alex Bennée ]
	- introduced pl011_set_break()
	  [ as suggested by Philippe Mathieu-Daudé ]
v2:
	- fixed a typo in commit author name
	  [ I did `git format-patch` and copied this patch from my Raspberry PI
	    dev/test machine and it turns out that I have a stupid typo in my
	    `git config get user.name` on that machine. ]
	- added RWB tag from Alex Bennée
	- adjusted a commit message
---
 hw/char/pl011.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cb12c3e224f..5ad9e7358d5 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -425,6 +425,11 @@ static void pl011_loopback_break(PL011State *s, int brk_enable)
     }
 }
 
+static inline void pl011_set_break(PL011State *s, int brk_enable)
+{
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK, &brk_enable);
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
@@ -462,9 +467,8 @@ static void pl011_write(void *opaque, hwaddr offset,
             pl011_reset_tx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
-            int break_enable = value & LCR_BRK;
-            qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
-                              &break_enable);
+            bool break_enable = value & LCR_BRK;
+            pl011_set_break(s, break_enable);
             pl011_loopback_break(s, break_enable);
         }
         s->lcr = value;
@@ -660,12 +664,29 @@ static void pl011_init(Object *obj)
     s->id = pl011_id_arm;
 }
 
+static int pl011_be_change(void *opaque);
+
+static inline void pl011_set_handlers(PL011State *s)
+{
+    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
+                             pl011_event, pl011_be_change, s, NULL, true);
+}
+
+static int pl011_be_change(void *opaque)
+{
+    PL011State *s = opaque;
+
+    pl011_set_handlers(s);
+    pl011_set_break(s, s->lcr & LCR_BRK);
+
+    return 0;
+}
+
 static void pl011_realize(DeviceState *dev, Error **errp)
 {
     PL011State *s = PL011(dev);
 
-    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
-                             pl011_event, NULL, s, NULL, true);
+    pl011_set_handlers(s);
 }
 
 static void pl011_reset(DeviceState *dev)
-- 
2.47.3


