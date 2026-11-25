Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFA606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e47k0ysd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8Rx-0006Ux-7f; Wed, 25 Nov 2026 03:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8Ru-0006Uc-NY
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:33:55 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xW8Rs-0005eG-6P
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:33:54 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-491971ac844so4927092f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 00:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795595630; x=1796200430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q9ONtqei/kmlp6pMlrNKfdiUp3kKpdEqp/1qDnBDp10=;
 b=e47k0ysdjH9vmZPznMGKXspRZ2vlbBIGaSLphXg+pMkrrwp7N2/p8f1LT8QQTJpdLQ
 Q8Nm0+m6pjIGhROjUTB9lRXTokVjmz0sYuCLUEilbA3ASvmpb7NECacd51L7AbCc9PvW
 WMAQl5ih7diPBW6/551s+GwY4h4NV22onYfkZAZm9Wc3yYOagFz16OdxvL9gA6c6xADK
 JMMDLMpYir2Xez13Xuhf+1WWX4LiYT7+xHik3YfrkiZU2d//G9ffhnXMKFeiZQfyjkXp
 YBXPR56h0Wu2qLSqaEVkNHZ5Lod2M04UgC29wW7dB3xYBNxElsSae4UQQMuaBb1LwwWU
 JW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795595630; x=1796200430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q9ONtqei/kmlp6pMlrNKfdiUp3kKpdEqp/1qDnBDp10=;
 b=BHjS0voxWQfnzspDgjRXhYT+ycz5yk89AtHGJGxTXTRH/GmUoMLHdp+uQ07PbZCZHt
 yrQdunl9YBB3s104Z40/m2k06/9ixIXZY1GOJRQxMjSo+SFA/Uwb92tprhPZU2a2LoNr
 OtZf6EmEqhUeQmRVnwMVg/fkvZouPfz0UapyeyEsq4iRxMgZBiLgGxMPkblYMZPe4E+9
 aF+i9eE78G5yb72x9txTQiXn09uKJOBfnBYLo0AH2+xPiVZ+o5BYKkCQ9rL2ABsAtKnr
 frigB7/BP0XVTDhX3+P7CNmVotRjBT+XjHGhA/uOISpQnahGGwDdqa4X6X5b3M7Cq3Cc
 Lycg==
X-Gm-Message-State: APuU4Z/LLVX9Zc6FwBQvY4z67DRshxjRazO0ikxc0PERSW9U/v9Pgx0X
 mBsrHMdLatDXrbXJKEi96F8V30CJpm3pFtAVHc5nQBr+oyvQzsBaRzPO1dWSng==
X-Gm-Gg: AZFdTZfIDt1aGRhEq8S4jfaAdXGbCjD5CCj2Gv/feKC2wacc9azX3+yycPIJzsr1Jxx
 Ylnqkboo7yR0LMoP/KehsPK6UKYPDiCnBzFekYi9PP9kBOMZRNC32OsGFOy8ZEwm0woG+kQ92OV
 GK+KgmWqnVVfDNHaKaDqBO++fMMWhQa7yhHnEV/n4/fvoj3tyl3SnqBvI7n9Cj4DQLWGy8grsNw
 lIjdXhfTlSyYUZUfyNDpP0KHmQtf+1Nb9cyTL0ksFKybO2a8d8B0Kp71ygY+FAlWK3fDghDfhSR
 Zl0lsBGGDiJR5YncxxYNGW1oLNilkhtWNh8zUHGMWIheHNYQX0SOT/bNGo1y21ts95clvndfLbq
 A+m+VCT4XbT3clQapvMk8JYICefsWO/6S3J1fePGc5Tcp7iUl6M3tDsI3Jtpx3ceI0/605ie8z3
 nhHd13Qe8ko+Pv6eKtODbdZloMnqq6GvgAYoIElCPZb6PMDqHmPAU4PrD6vuBc/BNgyOkVxKWY3
 /9ZynIgQn9XsQt87+U66GlLUdMAK9HCBLrfl1GGuAa9LPSq3tbFet05eEt3qcM6nXuJaZxDEXRX
 ohZwKG8Cs7KjsxNVZ8L+o5n2BWIm75Shd6mG3RNY50f1z1Hnl23CsLayqQ5eF+9igWSn6A8pt0B
 2TQhGAawibWadoWz0B7kRWX21GIKFWswozIifFVmAi+9GNw==
X-Received: by 2002:a05:6000:604:b0:48e:47e6:fdfb with SMTP id
 ffacd0b85a97d-4abb0c5d588mr31844266f8f.13.1795595630042; 
 Wed, 25 Nov 2026 00:33:50 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb4341sm33089656f8f.4.2026.11.25.00.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:33:49 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>
Subject: [PATCH 1/1] usb: make the VMState path of USB devices unique per MMIO
 controller
Date: Wed, 25 Nov 2026 13:33:45 +0500
Message-ID: <20261125083345.331408-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

usb_get_dev_path() builds the path of a USB device from the path of its
host controller plus the port number. A PCI controller has a bus path
("0000:00:1f.0/2"), but a controller on the system bus has none:
qdev_get_dev_path() returns NULL for it, so the path degrades to the bare
port number. device_set_realized() registers the device VMState under
"<path>/<vmsd name>", so every usb-tablet on port 2 of any MMIO controller
becomes "2/usb-ptr". With two MMIO controllers (e.g. generic-ehci and
sysbus-xhci) carrying a tablet on the same port the second registration
gets instance_id 1 and QEMU aborts:

  ../migration/savevm.c:947: vmstate_register_with_alias_id:
  Assertion `!se->compat || se->instance_id == 0' failed.

Qualify the path with the controller's own device id when the parent bus
does not provide a path. Devices on PCI controllers are unaffected, and so
are controllers created without an id (built-in boards), whose ids stay as
they were. The guest-visible USB serial number is left unchanged on purpose.

Note: for MMIO controllers that do have an id, the VMState id of devices
attached to them changes, which breaks migration of such a VM from a build
without this change.

Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 hw/usb/bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 5cc5ffec33..01b575f2cd 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -568,6 +568,20 @@ static char *usb_get_dev_path(DeviceState *qdev)
     DeviceState *hcd = qdev->parent_bus->parent;
     char *id = qdev_get_dev_path(hcd);
 
+    /*
+     * A controller on the system bus (MMIO EHCI, xHCI, ...) gets no path from
+     * its parent bus, so the port number alone would be the device's path and
+     * therefore the VMState id of e.g. a usb-tablet ("2/usb-ptr"). A second
+     * controller with a device on the same port then registers the same id,
+     * and vmstate_register_with_alias_id() fails its
+     * assert(!se->compat || se->instance_id == 0).
+     * Qualify the path with the controller's own id when it has one.
+     * Controllers without an id keep the old, unqualified path.
+     */
+    if (!id && hcd->id) {
+        id = g_strdup(hcd->id);
+    }
+
     if (id) {
         char *ret = g_strdup_printf("%s/%s", id, dev->port->path);
         g_free(id);
-- 
2.34.1


