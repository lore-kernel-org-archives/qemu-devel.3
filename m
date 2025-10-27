Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084DBCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMUS-00065Y-Um; Mon, 27 Oct 2025 08:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMUI-00063E-PT
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:38:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMU9-0006QT-Tr
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:38:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so3460623f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568679; x=1762173479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oa5aQxRYPo9Nd1dGHw3Wox9JI4dBESZln5Zp2k//GTA=;
 b=ZfdCAXw4FDdWumiv9y/kcNYvWW6mrC/eMI/L9pLls+jqRSyFbskOhgqqjeKpqA+2Sy
 GaS7LzIwFKcMr9uhPfMP+IhKzR2ZuCDIm7/obkVxa8LKuD2ztjKENU1Up+krlRaqHcYV
 2eV/bF0VskALF+I4SXfk/NQjjH0Mtrznu87f6cui2nWtxGa9SthhoppQkUsoOcbCN9Le
 BwLNrqts6tqPusTJB14IIRjry0BBAttXcBc3JFY0PiKf91Tf+Yy2tcytrMSYwdppJToy
 sS7j8FI4LKQoWDDySZi31WzA1x5VzVm1TNsmMMsDL2Q2hx6tAXjcMrpPHjrFBDm0N/bw
 XZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568679; x=1762173479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oa5aQxRYPo9Nd1dGHw3Wox9JI4dBESZln5Zp2k//GTA=;
 b=c8F0BtbBshBJAuN3wGBD1T2mMuwdxLOD1z9Hwf3GfAHo5wL03EGDrArFJqh48QwEBY
 6w9KC8LnZosBGSLx/JmaP04SAAqGyFXNyrusVNC3YBJNSdHM8mboERrSNPCbh01FGKgB
 77WiN6oe0qeS2t02/+X8K+PrDpBuOWH0jK3L9RoBgA+IPdTyElKdaPEPFUyWeZM8ruDO
 xyZ6tylIRlbRZa8J7Vyf8YewlkEgeUHVwhT5FaONGIA63SdOZ6hRgNZSuAZrhrlc8wW8
 nVjUBnuQxQN64IN8x98fKJNFlAlWkwPwdREq7/XQEw2H9oFXT/BFoWlSRAuoK2aY0xFE
 Cv/Q==
X-Gm-Message-State: AOJu0YzF7lBeoqZEjXCce1JsdTVhUNeW0lOxHcGfH8cDQK2plxbVFM+o
 6VckMVJXyiDjQ3/WDVyQsVJCT6r1ev2ykqV8x92CY9C26TneDNgnEUkvwkULi+e8JTQbg9vM0ny
 CiZkvAZ8=
X-Gm-Gg: ASbGncur7eGjpn7ckKF3/sR0tHICyT4VkHYYvkm3hoXsbrrTtZRqPNcmuu+pjoRfgvj
 pAIOzMLuPfRXreKVoDvd3SJ6URyH/vr8AtK9g3I2SIj8Elf3vnfBJsZDiQcs4uVbUJT1s1QT0+P
 IcIqaUdBzKdOurVVkKjMFSKM99mmdTxJb2jubUxqCFV4quO7K2+2+5n4FHk+Fi9r2gi2X7P1yyA
 +VMElVHIVpnPd2qOrvyo3o1G/3ebbT48kie1r5rryhN07HbvpabLtuRNBBD1frqVvUUk9E+IXjO
 +5WIMAe5EJQ8dB+kwh9r8ZUPGeWogctc88lDu6NHqKsGxR7sf0tHDtCDqP+yiwjRwpk1tU8hQ9g
 CbCHGc4uJ9bhfL1rw0s4JWdr/Eq5oxguJnZW5BJ9V20HICbWYHaTQ0Qs1GzgB8P35Mqa/TfRnJi
 BF+XMrVR1YhkSm5INnc7kl82lojYrr2ruQCdjeKoh2Y6zYfchRTQ==
X-Google-Smtp-Source: AGHT+IFnQVrSiGZZvXhqxIqDrh5o+Z52J2z6xQ+sXC6tpiz74mh6oATYobctlPMOFZJouBZIyIdbyA==
X-Received: by 2002:a05:6000:40ca:b0:427:45f:ee21 with SMTP id
 ffacd0b85a97d-4299071f96bmr9266716f8f.27.1761568678787; 
 Mon, 27 Oct 2025 05:37:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5678sm14031058f8f.22.2025.10.27.05.37.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 05:37:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH 6/6] hw/sparc64/ebus: Log unassigned MMIO accesses with
 unassigned_mem_ops
Date: Mon, 27 Oct 2025 13:36:43 +0100
Message-ID: <20251027123644.63487-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027123644.63487-1-philmd@linaro.org>
References: <20251027123644.63487-1-philmd@linaro.org>
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

Replace unassigned_io_ops -> unassigned_mem_ops to log
accesses as MMIO ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc64/sun4u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index e9f9b0a4cb9..87cf1c6c0bd 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -360,7 +360,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
      * memory access to this region to succeed which allows the OpenBSD kernel
      * to boot.
      */
-    memory_region_init_io(&s->bar0, OBJECT(s), &unassigned_io_ops, s,
+    memory_region_init_io(&s->bar0, OBJECT(s), &unassigned_mem_ops, s,
                           "bar0", 0x1000000);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
     memory_region_init_alias(&s->bar1, OBJECT(s), "bar1",
-- 
2.51.0


