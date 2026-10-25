Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101D606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HgpmiPhy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKyiS-0002Nn-Tb; Sun, 25 Oct 2026 09:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyiQ-0002NM-M3
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:50 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyiO-00070Y-UL
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:50 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso6323287eec.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792936606; x=1793541406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J8nL2XUpHU92PBZzwB8xmXbY80OavinI7S3gondy/DM=;
 b=HgpmiPhy77Sn+m5iwWg+qZHCDOvuJfn9dVezFkwqunhKexA5bXdVIimRBQP5Ta23H4
 x15M9Caw9M43oWhw5S9HMs/ojfYfmWFPylyxIj+Oic/JRinytg4EN9d+PzwQ74YQ7xpM
 UHRDUPA0aBWV8M9dQBRt2kHRhkY8VKvBiCeH0xgI55D5Vu42ErHoVN/IXVzolwCLU45v
 duJMGRXBuzKrZatVmPB9LnbOry7fchRnDRFohePRegy2EOYjbUt+EcDHRX5JlEz0aSs7
 6s7fI97dQ6E0uP4QKQL/6pnm725kYxzZdkyN4FaxaFcLJzTlCx5R5XLLaH4efWGtyLrA
 QXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792936606; x=1793541406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J8nL2XUpHU92PBZzwB8xmXbY80OavinI7S3gondy/DM=;
 b=enneje7ZRz2M/hZksESPJsqpkQkU8yyP0YZFvlxA/e1BniIvf112Cdsnh5DQdnjJWF
 bmnxeH1W9y1dcm7yyLautNv4xfwJAClfZvWyQmJsSJSzcx/3jn/8uPHtUPr1leXzdpFP
 qjlK6eDeQAg5s44LLAp0RpQGsrVmHxUgAhMg6WK2gfNN7HrdDzskiPSZ/kEeeT9O1Juh
 CPqC7lEPLVYPzoYWt67pR/el+VxHPriMpg6cFbbKgjwUtQSPKYxdSfkNYu3ukHJ0Cg/X
 rY94O37oQyhc+gxkk/FNpldSPxLCtaJv1ggzehYDazKogM9DSQRrWnhHZ2vgGTcHpEWw
 EWcA==
X-Gm-Message-State: AFq9FYIvCQKu075QR9KbU0P8bgGzemO2k8RjTAAroZytbXZSl82zP6q7
 eoRcXDmNPLj2oo9h5V8EZ0G0ZSNTNwN+Z/LWNq5tihn2P8yk9jqraJBpIfQValkc
X-Gm-Gg: AYBFou1HOCO5XXGqqNNkOwCC4ZUjWqX8oLkB7X1nDLERJ53Xl3XHoW9qASkwn9LJOaG
 cdD2bVjuCin3XA6XjajcZx1/cwKtzb2ASjzYwpn6tsYGqsX/HW/Kd9sOjI/eLaBePpTRsL9sFeK
 4qLU+8mZdp+xmr6X33VpC7YZZLoeZTzglgtKRBXhH2Ffco5bpT5cEkT58FHwKuS/XFj1rQVOqPn
 9KZRqdDxgDS7KlspHfss6wWExa9Bk90J43SyX7g1utGEB7JT9JIvd9HvDrSCGH2kZkdhHrzAWMv
 /1WvsytoLYE/YcLyXRbXbTgElg7f/P5tUZRpLcC9zGyM/7J3Fq+8goTra/dwxYEzGWacydPTDOB
 3ZHlT7B6Bzaig0F3fh6RosK6MN8l2SOpaqIRwvBlEoKi0cwz+FH40o7DcYRdVlu0HY+D6OHvBMO
 TwaCqFgrroo27G2HLZCADDEvAbrfsch76o/DOHzmjovs3n/TIoqt4CVBHkaehMwexh+YISgatwF
 jHBD9ZBU+rP9mENLI6LHtVxsa0KrlsVjbPoUQkxBQ9R5eqy/E3edXvYKTJH
X-Received: by 2002:a05:693c:88c4:20b0:369:c6d8:5799 with SMTP id
 5a478bee46e88-369e86444b5mr6306589eec.41.1792936605927; 
 Sun, 25 Oct 2026 06:56:45 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d845ddsm16795724eec.11.2026.10.25.06.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:56:45 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, waysorrypub@gmail.com
Subject: [PATCH v5 2/5] hw/loongarch/virt-acpi-build: Drop invalid _DSD UART
 clock property
Date: Sun, 25 Oct 2026 21:55:56 +0800
Message-ID: <20261025135559.236356-3-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025135559.236356-1-waysorrypub@gmail.com>
References: <20261025135559.236356-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=waysorrypub@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Delete the code that constructs the _DSD property and its dedicated
variables. The original property had three problems: its name was
misspelled, the key and value order was reversed, and it described a 100
MHz clock, which does not match the device model.

The property can be removed directly because the UART model's input
clock matches the Linux 8250 PnP driver default of 1,843,200 Hz, so no
_DSD override is needed.

Signed-off-by: pillow <waysorrypub@gmail.com>
---
 hw/loongarch/virt-acpi-build.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 54965f0..981e609 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -314,7 +314,6 @@ static void build_uart_device_aml(Aml *table, int index)
 {
     Aml *dev;
     Aml *crs;
-    Aml *pkg0, *pkg1, *pkg2;
     Aml *scope;
     uint32_t uart_irq;
     uint64_t base;
@@ -335,15 +334,6 @@ static void build_uart_device_aml(Aml *table, int index)
     aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
                                   AML_SHARED, &uart_irq, 1));
     aml_append(dev, aml_name_decl("_CRS", crs));
-    pkg0 = aml_package(0x2);
-    aml_append(pkg0, aml_int(0x05F5E100));
-    aml_append(pkg0, aml_string("clock-frenquency"));
-    pkg1 = aml_package(0x1);
-    aml_append(pkg1, pkg0);
-    pkg2 = aml_package(0x2);
-    aml_append(pkg2, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
-    aml_append(pkg2, pkg1);
-    aml_append(dev, aml_name_decl("_DSD", pkg2));
     aml_append(scope, dev);
     aml_append(table, scope);
 }
-- 
2.56.0


