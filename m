Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E138DC79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cQs-0007Es-5Z; Mon, 07 Sep 2026 12:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cQq-0007E3-MC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:42:56 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cQp-0002n1-2P
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:42:56 -0400
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so30213565e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799373; x=1789404173;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pWk7MV0WjBOJc/s9RX0ZBDFXEdiiCKZ4mANozxUHjQs=;
 b=gRZHZaVoAFPDGrWIOJeH3YDwCB1RpBAlgOcGfqOyJdkM+E4ViGe2hQ6JOZa0yE5s3A
 npFYGDi2REjLbiBdrl4YiyCQNwucheSC8CKeVqQ906kaHo6L0zv1fADO676mxpKLveZC
 uV0FKUKTmdi1zRTMvzBHpi+rrDmUIf7yx0vbzCK0G3CEtFXxUPz1EuNXyytKpjX3pGlY
 uSgYRCzF4+l2XZemuXidlPXMjQsW5FFU/pvlHDr6JvGmFZgi/km4xRD/Wo5204QL+Q3y
 HDMdxdbP1/wbK1jRf3httZx09S6i4aWFOAaUg/PcoyyB4ekFnDpFgh3UKZ2iVNWYBUM8
 7AkQ==
X-Gm-Message-State: AFuF++lX20R83+2B68nTYlT8QFs7OuPzLhCDS+yaBOGUGQC7FPK4iqK9
 eSc9Yr1lCAsQoM+wcBCKeGd/SQD1SNo3kg1nXr7P6M8R7LFQENTDuCOqbMNJYJGq
X-Gm-Gg: AYBFou2BVeNMULIRvfzEmE8isI8C/85s/efIO5de0pNF6yiiA1v7xMKoSYdr67Jtm5l
 STdIjzmLcF4zYLF/UqRHBsGrsCRDq+Cw3DZ/KLbwRsd79QtPB24kKkmcNjRMQatuRm5hrUwlOWG
 PU0HwKC7508HACVO2OymH9/3RS4yt8hE2ipluNaqD7rU+joULOnRByn+U1cu7E0aAq2n2OcN2ru
 bfhpC+y4YI9S2gMd6EZb+hsGbaPO2QuBPp0ghcpVHDQhGdkHWijGEisobikZ4SeiCJCPznp2aQS
 NSn4XWqpWrmCSMqyFsYDqJPF4d16h4onD5PTpDRlvLarm3MgPEqKcus0BbqmPNJ2GIn0Ut9aiFl
 QlUYi0vSw9fxB940xFF7hHhE/MbrcuKlT/DazO1uRjRQOTOqrF3Hw/b6/yuKMd7K54cjAJnc9vK
 3yHWOm0mX4PCsx3cwkmCdhYx+RjDxx3MBN/S+20L1IMsDU97C5AhZGfbVYp2HWFTKantCF/jgZj
 y1rV6VEL/vsOry1zgwy42UgpJ11rC0B3ck=
X-Received: by 2002:a05:600c:4e49:b0:49c:fa20:cc05 with SMTP id
 5b1f17b1804b1-49cfa20ccd2mr220297615e9.28.1788799373426; 
 Mon, 07 Sep 2026 09:42:53 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm408228125e9.1.2026.09.07.09.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:42:53 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:41:52 +0200
Subject: [PATCH 02/50] docs/system/arm/aspeed: add the sanmiguel-bmc
 machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-2-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799319; l=827;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=OuuDyLAyQiERaSazvNIfVs0crUzUw8PgfLhgJ7loAvM=;
 b=4YbwkbfJ2rItupdRU7HedBVqsWVfaM8izdAwpE+mCra/75bjWknMooS+YmE3J9KMGUJk009cz
 FywRamSunRYAlL52c0gu+MNFZxhDlTwBpa+DwIH5lxMDsHStk8d0Hst
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.53; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f53.google.com
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


