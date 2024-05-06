Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4E7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9S-0006ls-70; Mon, 06 May 2024 03:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9K-0006KP-Mp
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9J-0001iw-6E
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6r3byvH2Usubh0E9Dk3mThpH/HP7+bovyE0721TMtTY=;
 b=Q2KEXNaDB/UIm75Z4VMp46UOcc613e/0qQL2cnF2mrgjjA3SDy/VGqaGo5CyE8I510VWs3
 Dxx1RICqtXubbV4OFDDSBHrju0VWFVTrCPnFxHSWm2I22h2van9Y2o0paoXS2g5S2u5ctv
 JkfP4TJUyPikP+jzpoigMscIbpqVSsM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-uxnHyJMNPaurwo86pduJPA-1; Mon, 06 May 2024 03:52:33 -0400
X-MC-Unique: uxnHyJMNPaurwo86pduJPA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59ad2436f8so123924666b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981952; x=1715586752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6r3byvH2Usubh0E9Dk3mThpH/HP7+bovyE0721TMtTY=;
 b=BZ+3Luk0BDxsgjsx94PrFYylNycPoOZV+mi6aF1iHpcDATWsCOA6T3ZkmTM9gcYKIK
 tvfxxAW53w85F8Hpp9MXLvGcpmq2jqLP9ORKzlgYugdMXrVcD+epXeNcgPEaubuyBP6Z
 1GcgJ4eqKT9QaegF5oThWqd81B9ak5D0zz5anoQJ7CimK9DKUOmVplUpxiXv+fbYbtH7
 z8+qmzrYxnUhKTysPqFuc0x7jHZjB25+q6S5+BwM4pRr26EaSDZ6OIAMjLIKSYUUsKxJ
 azqakmXJzGmM65k5xEQ8wm0i6DUhPqSdSU5pXvGePWdUe+Azhmx8kUhFd/mZaSXXGQAJ
 Z3GQ==
X-Gm-Message-State: AOJu0Yz9asPW8Agf6S1LhC6jTnMZIRl/8xsiAhzo3NYRQl0dRQo4jISb
 aEvdWQRkKUTcdR5Ik8GV9fWAMvSozkPxjzw3iFLq6rtrEhR+A3ZmR/CFLISnnPRn7vqfK1WWZ7w
 BjIFXlaz1AsvBZjXyUJUxTRWzRa8R3Lid0s9xQf7TACDkEMB7PitsTCqdrRebPo6EnlM0V8AS4Q
 TsWTGG/QX8PnS8IpPWTtCET82HtqHEl2WIDrKl
X-Received: by 2002:a17:906:1c0e:b0:a59:aff8:c713 with SMTP id
 k14-20020a1709061c0e00b00a59aff8c713mr2563441ejg.10.1714981952053; 
 Mon, 06 May 2024 00:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0P7VcbRgOVdo96LcpCV8zr06zeGhw3xhA+3Pr6ytBgvoCV7ffmOIHD53jiSCqmNwyhyqLhA==
X-Received: by 2002:a17:906:1c0e:b0:a59:aff8:c713 with SMTP id
 k14-20020a1709061c0e00b00a59aff8c713mr2563430ejg.10.1714981951662; 
 Mon, 06 May 2024 00:52:31 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a170906834800b00a59b126af69sm2225365ejy.159.2024.05.06.00.52.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/46] xtensa: switch boards to "default y"
Date: Mon,  6 May 2024 09:51:05 +0200
Message-ID: <20240506075125.8238-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with Xtensa.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/xtensa-softmmu/default.mak | 9 ++++-----
 .gitlab-ci.d/buildtest.yml                 | 2 +-
 hw/xtensa/Kconfig                          | 6 ++++++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/configs/devices/xtensa-softmmu/default.mak b/configs/devices/xtensa-softmmu/default.mak
index f650cad7609..fbc3079a943 100644
--- a/configs/devices/xtensa-softmmu/default.mak
+++ b/configs/devices/xtensa-softmmu/default.mak
@@ -4,8 +4,7 @@
 #
 #CONFIG_PCI_DEVICES=n
 
-# Boards:
-#
-CONFIG_XTENSA_SIM=y
-CONFIG_XTENSA_VIRT=y
-CONFIG_XTENSA_XTFPGA=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_XTENSA_SIM=n
+# CONFIG_XTENSA_VIRT=n
+# CONFIG_XTENSA_XTFPGA=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index bdd4dc49b17..e9402a68a79 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -666,7 +666,7 @@ build-without-defaults:
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
       mips-softmmu mips64-softmmu mipsel-softmmu sparc-softmmu
-      sparc64-softmmu tricore-softmmu
+      sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
       hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index 0740657ea58..443b415c2ba 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -1,14 +1,20 @@
 config XTENSA_SIM
+    default y
+    depends on XTENSA
     bool
 
 config XTENSA_VIRT
     bool
+    default y
+    depends on XTENSA
     select XTENSA_SIM
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PCI_DEVICES
 
 config XTENSA_XTFPGA
     bool
+    default y
+    depends on XTENSA
     select OPENCORES_ETH
     select PFLASH_CFI01
     select SERIAL
-- 
2.44.0


