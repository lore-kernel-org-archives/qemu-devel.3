Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCCBCA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHQU-0006Td-8Q; Mon, 12 Oct 2026 10:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHQ6-00063v-O3
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:54:32 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHQ3-0004pZ-93
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:54:29 -0400
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so13596915e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816866; x=1792421666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pWk7MV0WjBOJc/s9RX0ZBDFXEdiiCKZ4mANozxUHjQs=;
 b=pjF7UKcoQiyLaWkmbh9jqEeLTkmPa2r261DXi9YKcHKz3QTTj7dcDLczdzrF6AJ76P
 ud8YiRX/bKz2nPTX3/8iYjGyQwbQr/wfUTo/72UTaDETHz4cuqgeH19jeAr+YI4iNMBR
 qsNMan7L0OQgjo11tDfknZSb5o53cfoSJzilnJdsQ3DN+ZaSRmVzy5Go4rXvr+5kaBzi
 Umaw8jU4+v8B5UP6zghJmEDn8sfSL3l/Z2QycpDrqTcWGA9QMGlwQM3m19nUhNvnF5Uf
 gqJjxEQOl9/9FOijk8qdhE+XwnAURp315iSksmNByMf7s8VXe/i8UAsaK4dwCRRV34ff
 4cdA==
X-Gm-Message-State: AFq9FYIZit03N4pOftdGvWUJAKM8RPxb7SkPMhLliCqVuVmhAXyF/WnD
 v1qKQKUCaiOpHpbw+riPV+Xi2pNtxY0Btv8J1UpDEYX5pQ3r8FfzDDYQR9++puig
X-Gm-Gg: AYBFou0oc0W/WjXi+gJMLSCWGDPY2I+HpH84SeTG7zwQHe1RpUC/QmzV7HuGUP8wl0+
 baAVoNNMzvHBl8i9zlfC98ZDCw7xSKIEFSniemW6D9InhGvGgr6XQbPtaol9SVYILl5whtmCIMs
 NIvHhy1IBmDeO0BpfqZGvDVi1nqNPO3IoMU1MmSP4ljaHScgRdzmB2WsTuSbROQTkZPMIjb4xyb
 gRA1EZ01d+bPvtdvs0FYhlMzfp5K8Z3qBST1EqMnigtZ38tOh/3XF9n4d/3D0imkNSnG0Z+0jv2
 +vR3XCJHWmoTG0IulPKa72hnNj1GUJIvgKjw8BdtKwa7J71EsKw4MctpR/Dxsi36XgBMyQe6mPR
 e3KrLjtj5kdjdmbIKZQ6jynSfWfEOCz0q/yfZRlqV1urArwu1aR516yiGM0yt6OqGI2IgsYir1/
 Oxqn4blOHqDoE5RbMCOCBNtVEN+hqLYVkVavmFv7HHXxKss86Wi2J5nqesmSB//lqTdXYH7p5nr
 ESu6v/J8+3fUuCzrcybxT5FwZnWZmzo1LVbGFz9RUEcFw==
X-Received: by 2002:a05:600c:3f06:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-4a18e4a3bfbmr201172005e9.8.1791816865607; 
 Mon, 12 Oct 2026 07:54:25 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm545123275e9.9.2026.10.12.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:54:24 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:31:55 +0200
Subject: [PATCH v2 02/50] docs/system/arm/aspeed: add the sanmiguel-bmc machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-2-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815519; l=827;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=OuuDyLAyQiERaSazvNIfVs0crUzUw8PgfLhgJ7loAvM=;
 b=pDhb/aaq1Q7JVtjkYsscfH2BbmpFFdn+Egv5r4iRD6RKiUf10/g2BFeWayUp/whjJkXOprlY5
 a39annO85fdDkYxQr2IuDSUGmQGNCpjHT+fptASOKc6s7NsU5ok6MKe
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f54.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Facebook SanMiguel BMC machine is supported by hw/arm but has never
been listed in the Aspeed documentation. Add it to the AST2600 machine
table.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 docs/system/arm/aspeed.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 933df41f96..f38f33cbe1 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -34,6 +34,7 @@ AST2600 SoC based machines :
 - ``bletchley-bmc``        Facebook Bletchley BMC
 - ``fby35-bmc``            Facebook fby35 BMC
 - ``catalina-bmc``         Facebook Catalina BMC
+- ``sanmiguel-bmc``        Facebook SanMiguel BMC
 - ``anacapa-bmc``          Facebook Anacapa BMC
 - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
 

-- 
2.50.1


