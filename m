Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10331C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9P-0006V9-8f; Mon, 06 May 2024 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9H-0006H4-FN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9F-0001ig-Uc
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/prTIhlaPSYU+OZp1YLxgxehGwBhQi8DUGU7rgz56I=;
 b=JaMx4ITZRdAs1Tdl56hfaPrMBbnFxJz78kfguDsVIlf//Bk+44eix0ru63nM6h6/nN0p78
 BtakKYyfgjE5ulby5IDLzexQ+280317MiUA2K2Issjlp+FA3jNIjI6zsDAyQNcLz2LBiPT
 YxflRVPsjFywCqIPH5lgwQwl2A5A+j4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-BzWjIcbHMLSZtkma2H_GqQ-1; Mon, 06 May 2024 03:52:30 -0400
X-MC-Unique: BzWjIcbHMLSZtkma2H_GqQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59ad2436f8so123919066b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981949; x=1715586749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/prTIhlaPSYU+OZp1YLxgxehGwBhQi8DUGU7rgz56I=;
 b=KHBYPXMULE/0sazJLdM23APgM/uVjXo3Znr2TrwvfpRdaG9LUd2Zl168KkvtrdAVdi
 SfrfA3gT4rSB56vnHtl5AmKgxh8+P0R7FCzk6b/vcV1TDbHRjsPvhsOQC/5vPnoSP/gP
 bTlNYu/EyLnJfmkhH48FGMn4jthtrk4uYHaxJMQ/zC0OR2DBYVRCMLoONZnpAitQSbWQ
 i4idB6RYzqnmqm3oUQOsmrVk+8gESK49dfnmNXehj0LUgPI423Pv4yV15ltIeUasHtHp
 cnjzNAiuTcGeOb0iRwFBy9alkLV1RAPKkPCSRXHyiQCFPcn/DlVusPnzbXpvgDEDLXL1
 068w==
X-Gm-Message-State: AOJu0YyWTUkQr9JZEgszKWHD+mZkU5MVD6CzyhD/pmua3wmWRLbrGNuU
 1IABjr3btO5cKVpOoh4QjiQ+0ZaBg6kMToYrihEtiPoEi8CHh2KXApToOnAGkgL7XymeCIxwlEE
 taXvAYU11d8WQKD8wECupOe3urcv6yCrNDRtDlIRafaQQaJbg5iUI6kfAGzbPQY0VpiT7l+AkLc
 S11J4p8Pjj4snz9WYux8QVnk2XuFMkzAMKV6Ha
X-Received: by 2002:a17:907:8688:b0:a59:c872:191c with SMTP id
 qa8-20020a170907868800b00a59c872191cmr2009566ejc.38.1714981949411; 
 Mon, 06 May 2024 00:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDxQWhiMJzkARYFHd+RIR47ElwCCBpvn9LMsqbplIrOEAtxB69IbcoExKJSeUoiArofpnF3A==
X-Received: by 2002:a17:907:8688:b0:a59:c872:191c with SMTP id
 qa8-20020a170907868800b00a59c872191cmr2009547ejc.38.1714981948689; 
 Mon, 06 May 2024 00:52:28 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 mb15-20020a170906eb0f00b00a59cc6d06f2sm1125940ejb.218.2024.05.06.00.52.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/46] tricore: switch boards to "default y"
Date: Mon,  6 May 2024 09:51:04 +0200
Message-ID: <20240506075125.8238-26-pbonzini@redhat.com>
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
Continue with TriCore.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/tricore-softmmu/default.mak | 7 +++++--
 .gitlab-ci.d/buildtest.yml                  | 2 +-
 hw/tricore/Kconfig                          | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/configs/devices/tricore-softmmu/default.mak b/configs/devices/tricore-softmmu/default.mak
index cb8fc286eb2..c7ab542244b 100644
--- a/configs/devices/tricore-softmmu/default.mak
+++ b/configs/devices/tricore-softmmu/default.mak
@@ -1,2 +1,5 @@
-CONFIG_TRICORE_TESTBOARD=y
-CONFIG_TRIBOARD=y
+# Default configuration for tricore-softmmu
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_TRICORE_TESTBOARD=n
+# CONFIG_TRIBOARD=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 5d2ce161187..bdd4dc49b17 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -666,7 +666,7 @@ build-without-defaults:
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
       mips-softmmu mips64-softmmu mipsel-softmmu sparc-softmmu
-      sparc64-softmmu
+      sparc64-softmmu tricore-softmmu
       hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
index 33c1e852c33..6c04f64949d 100644
--- a/hw/tricore/Kconfig
+++ b/hw/tricore/Kconfig
@@ -1,8 +1,12 @@
 config TRICORE_TESTBOARD
+    default y
+    depends on TRICORE
     bool
 
 config TRIBOARD
     bool
+    default y
+    depends on TRICORE
     select TC27X_SOC
 
 config TC27X_SOC
-- 
2.44.0


