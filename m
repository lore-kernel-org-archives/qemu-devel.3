Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C50C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1A-0005Gp-7S; Tue, 23 Apr 2024 09:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG14-0005FU-Hs
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG12-00024F-Dh
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YEcU2s7XM/BrARF/BZZCwORcPazah+ZTI8PrU4iuRoY=;
 b=FXO0k8wD3n62Y0N6XmWDsE9uMj1o+NLV0QxqGCAsbbO6Ek5hHbrBv+zqrxpGttxYQTr6Uv
 OiY6Jp9Nrzq7yGZA/xtvl68JgD1wEMsRd3wjt5q0UCrKRnQQEnvmbwYb2IolovZJ7qBNXX
 shkXGxqksOw72JP5yPKFlJt7+P7qRQk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-SKvqxo7fOvCSI9BxbG2y3A-1; Tue, 23 Apr 2024 09:16:54 -0400
X-MC-Unique: SKvqxo7fOvCSI9BxbG2y3A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51b1a65c68eso2319557e87.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878212; x=1714483012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YEcU2s7XM/BrARF/BZZCwORcPazah+ZTI8PrU4iuRoY=;
 b=JnHau0gGAWWC/t9Zekd/VsO4flcIUEJoiczL/8WPzZQ48qawROs1G9oRjp7qdBFb3/
 +EvtHahjAXoKndKtOdr/lMOIAXBkD9dzH0H8KC0nW1Q4BwWfplT3yoO1qhpaG2vOxqWR
 4jeZjD1/Yno4LxR43QpNivk+/k0dKBU2SA+G7TJHRQdi+L3cTxavlxhDwenalFMF6Bl2
 GQXsOk2L1BIK3Rvt17TyIFBF+tO8KEGMovtDpBFuwUW3wPQU3RxRfA6ZaT3Q5k7BiELd
 +QS62HlzR90wdoVPk2R7gXxVbDqCXDvqsBC8VPffUmPXcE1vYxEzzfwmOw3arwHxwtp8
 OIrQ==
X-Gm-Message-State: AOJu0Yy+yG1ng3WAWw37KqhGgUAZTQQVI29ntxxfUB11n0efI94rCQFc
 w+zHvpnirPdqO9pgstS7XqDszNeahEis2BLzjLYkQ95BUcbLULwl8DPpVYZgTAAOmcHMaoeytlg
 0kOAqs9ZckKkf8K571PUVDZ1F9AZ4I4+ugscVleoZ37KMCpsfsPF2VveykXX+9pQSIzHSi15oQF
 8XXGrqUxvX86qhcR0OBgFykwriNwc8uB2dVeal
X-Received: by 2002:a05:6512:38d2:b0:516:9eba:8f2b with SMTP id
 p18-20020a05651238d200b005169eba8f2bmr8461648lft.12.1713878212093; 
 Tue, 23 Apr 2024 06:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQmVg59PIMWjRe3RoV0rZUpDrUfYurRNbXocFY5hp7gudfU6C3OaEkYDqsGC89RC02TuLS4A==
X-Received: by 2002:a05:6512:38d2:b0:516:9eba:8f2b with SMTP id
 p18-20020a05651238d200b005169eba8f2bmr8461634lft.12.1713878211727; 
 Tue, 23 Apr 2024 06:16:51 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a170906c08700b00a51a80028e8sm7052938ejz.65.2024.04.23.06.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 14/22] openrisc: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:04 +0200
Message-ID: <20240423131612.28362-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Continue with OpenRISC.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/or1k-softmmu/default.mak | 5 ++---
 hw/openrisc/Kconfig                      | 4 ++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/configs/devices/or1k-softmmu/default.mak b/configs/devices/or1k-softmmu/default.mak
index 3aecdf9d738..efe3bc278bc 100644
--- a/configs/devices/or1k-softmmu/default.mak
+++ b/configs/devices/or1k-softmmu/default.mak
@@ -5,6 +5,5 @@
 # CONFIG_TEST_DEVICES=n
 
 # Boards:
-#
-CONFIG_OR1K_SIM=y
-CONFIG_OR1K_VIRT=y
+# CONFIG_OR1K_SIM=n
+# CONFIG_OR1K_VIRT=n
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 97af258b556..9c9015e0a5d 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -1,5 +1,7 @@
 config OR1K_SIM
     bool
+    default y
+    depends on OPENRISC
     select SERIAL
     select OPENCORES_ETH
     select OMPIC
@@ -7,6 +9,8 @@ config OR1K_SIM
 
 config OR1K_VIRT
     bool
+    default y
+    depends on OPENRISC
     imply PCI_DEVICES
     imply VIRTIO_VGA
     imply TEST_DEVICES
-- 
2.44.0


