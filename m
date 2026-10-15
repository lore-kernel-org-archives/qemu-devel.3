Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9417CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIdf-0000Zy-51; Thu, 15 Oct 2026 06:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdM-0000WL-F4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:26 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdK-0003D5-7u
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:24 -0400
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so17029025e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059861; x=1792664661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Pey2/h5d4egpWMShENSUMjJQuRdUBUW9uGkG9/qdms=;
 b=QvZeDBn1Bo8iQjIrbc9j0ewVxVcSyvYAUZrTjR8JND956+Iik+ZyraftxabQSnt/Wh
 DeciFHfueTZoGgcCvGU8kNyscUBZhFgAuX/+SpkTDRfBhuxJWNlMhEntkGVrzahZyI4+
 GPFmmx3ZfEwGn8DzcKIIPSyezOFBICA+gI2ZXbxQIZ0cZLCzssMMpfCc2VvNHd+pkTvH
 jq1w6Ko6oOk+OwAtxKG5Mhkh5QyrkK7ow2stXvwjDIoGszkCVj/dMf25vAVR7j3ynUZV
 Ee7bPvK+ammNLEKybYJH/n1iv2Z6zDtST0Fjc7I7kjrnljyLCjtUJKMa5cO6kZGVdh9N
 D88g==
X-Gm-Message-State: AFq9FYK3qGYIclT1v7GDC7QYP8dY11nMNTUStlsnZb6E+X9J2WSG/2ho
 vBca/bdqkhFQpmLMpbeps/zfLG7WResxvVx0YKvmIjZ7yM8NSbjZNjrLYZ0ywatG
X-Gm-Gg: AYBFou2dpmG2T09sWytMtQMsboAq91D9DW50tJdcM7HwreiikqvXq3qAp8WPEjvVdLT
 kJS1ekoCyDg3pFwW/cvuaSuRyxVpmdn24wUXf4F5zyUoHN8Sm+XiNt5skxM9XrzfueYA5Dz9uf7
 Vk19Wk/FVEWZ0/nh6m1kIyc1Xax3WNCZzlThHu6jam0iRJ1YaN38XaZCLyZ/JPKx4H2jE81gLzI
 tdwxMmje/cNGhlsJc/O8uTBsE2wZxZh/u1jbC3+FEkhppguj+g2T4PeM6XZE+xDQPMa2Oqx37/2
 LVLrQDVEYaEdNxr/FSPqMLqTx05+s+j4IKAIV+hHq74BVqq+pxs3g5mNv1Cp0G6QB94MCQxLYxt
 yvnl3SVMQMrLWqHy6VjEAvHiFvdRAqo3PwZ03eMzWPiWYgA7eZoZa1SrUcGDeVKFNEBKYqe/fEZ
 S2brEBopgY2WoipFZOwT6pyki9npZZeh1Vm+2GjhVgFZsemO4Qlm79w2P7iYn3vihpC9UCYCl7b
 Mwtc2sR/cNa7dXps5223Bx2Z26b/mPnsvJv5HJ+rpt4NQ==
X-Received: by 2002:a05:600c:1d11:b0:4a0:25db:4591 with SMTP id
 5b1f17b1804b1-4a18e4a4c33mr393827345e9.23.1792059860573; 
 Thu, 15 Oct 2026 03:24:20 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd96fed4sm61274505e9.2.2026.10.15.03.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:24:20 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:27:49 +0200
Subject: [PATCH v3 02/50] docs/system/arm/aspeed: add the sanmiguel-bmc machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-bmc-minerva-v3-2-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
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
 Emmanuel Blot <emmanuel.blot@free.fr>, Jamin Lin <jaminlin1207@gmail.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056474; l=930;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=f+ewNztwtHsQvjNwITmtmh2RHXZRe5TnF0pSYWV+BZo=;
 b=n/hPuH2OEZgEqvXG6jHRYPpF9OlmfLfbELivf7KRVn5BQ+oqc7dr1sZZmfoggz0VECaiEa2uW
 RReHHGEWT46CyBc+PauWC/CC/Di9uE27c3SaS/WDKTwCS3fFywj+scs
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f50.google.com
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

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
2.53.0-Meta


