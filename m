Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C49CD128E
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 18:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqzkd-0004Bn-9a; Sun, 31 Mar 2024 14:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqzkY-0004B9-4l
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqzkV-0004hs-M6
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711909061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+vqxdTO2VKLgQ7KsbDKTOHrw/FHBZ8UlPh38mHZ3HDs=;
 b=P7i5e7I8xylAVdNq5rQcjxtFQVJ9Z6KZNhzUlwq8x/uCXaJYRe9h1+h1TCIoO4d4Lr7b6E
 QWmQwQoOXZeHUkWtbwtZIvoPldbCat4iKAjXG59WvQ+EYd/0M/8HdJ6bDKKBx0Y9fas90e
 ACp7Lk0INXzbnrKXUBeHCCVcpO5P3hU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-2JyiWm2LMqmRahGim5RZ-A-1; Sun, 31 Mar 2024 14:17:39 -0400
X-MC-Unique: 2JyiWm2LMqmRahGim5RZ-A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-515adcf2004so2850393e87.2
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 11:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711909057; x=1712513857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+vqxdTO2VKLgQ7KsbDKTOHrw/FHBZ8UlPh38mHZ3HDs=;
 b=cRxzdUSMy4jH5WHLXI0f7wyexp9nM2DywEG6ODMNqe6X3y2pw45E0ZMzbGvvzQoagD
 bua4wKslakYcHtUljN8+LCIU9QuoICRAVFnjjpvkbZkiLz/zrZ9sf3ffJnCiLif2gXoV
 jBkq41SY+ZrvQ/MCZiDHYPIvk0Wr3JMY9BRvQ7ebmwyuZh/oI9y4Q94m95SBC3AB33pJ
 4Wo+gpzV/+97gY40FISlDl2aMJUY4FkcBmxqLGlSKlBcnGWfW00BXSf7fJu3+iRrjTPO
 Dx/TT/VdqGnK+p6GLFcXYMyHOEu8MEBQ7EKVP2jl5cIP3rabDXTTklk6KcAushjFbOVY
 TO8w==
X-Gm-Message-State: AOJu0Yy6vLCfWPt8NgHYXc1HRw4YoXZiLJprWdcYs7CjINqwABbxRSZe
 +XNopM7lSYCUwZH0XBRorpahvysFvrRC/NiWl2wUzV+E9L1RgTRA2Vb9VGAL90GM+huCtxibBbK
 NbNuxQUtaxksT1U1NHrckiXgqZZfSR3Gis2ElT/TOGkpnIsJjwJZN5CtqVSLMIiq1mvZlOepy/E
 OgJ/uRUiJ0MeZ8vTVYXBMNbLJ2gztP3seXp27x
X-Received: by 2002:ac2:5d70:0:b0:515:c7c9:b150 with SMTP id
 h16-20020ac25d70000000b00515c7c9b150mr5833018lft.0.1711909056866; 
 Sun, 31 Mar 2024 11:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGow2RWMLprZVVEV/0e5lBOOboRdfoRgvXrfWKdkBG7DiLIV+gAQNz1Wpyy41kcGnRdG/Ludg==
X-Received: by 2002:ac2:5d70:0:b0:515:c7c9:b150 with SMTP id
 h16-20020ac25d70000000b00515c7c9b150mr5833010lft.0.1711909056433; 
 Sun, 31 Mar 2024 11:17:36 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a170906254f00b00a473362062fsm4404917ejb.220.2024.03.31.11.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 11:17:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] lsi53c895a: detect invalid Block Move instruction
Date: Sun, 31 Mar 2024 20:17:30 +0200
Message-ID: <20240331181730.150860-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The spec for the lsi53c895a says: "If the instruction is a Block Move
and a value of 0x000000 is loaded into the DBC register, an illegal
instruction interrupt occurs if the LSI53C895A is not in target mode,
Command phase".

Because QEMU only operates in initiator mode, generate the interrupt
unconditionally if the low 24 bits are 0x000000.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index eb9828dd5ef..1e18d88983b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1205,6 +1205,15 @@ again:
             break;
         }
         s->dbc = insn & 0xffffff;
+        if (!s->dbc) {
+            /*
+             * If the instruction is a Block Move and a value of 0x000000 is
+             * loaded into the DBC register, an illegal instruction interrupt
+             * occurs if the LSI53C895A is not in target mode, Command phase.
+             */
+            lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
+            break;
+        }
         s->rbc = s->dbc;
         /* ??? Set ESA.  */
         s->ia = s->dsp - 8;
-- 
2.44.0


