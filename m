Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D90C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9C-0005y5-1j; Mon, 06 May 2024 03:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8c-0005jM-KM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Z-0001Yf-Mt
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwhnI0R3GJbUfLrtmrA6X5iWICM26TYwYhxih3BiOs4=;
 b=EFIQ9pvv5UXFnP+LX9ipDgFnH+ypME2ndU8QwKgr0C1D0XEnEqRuX1k8kely1g98shiok7
 0tOwJ7KzwhjJrzqr9E/KonGE1ahzpcyGSK5yXDif2g8qN82Dm9qifhZMlNqNEQ8LpIbqoD
 HrLsFfd/ZKgRgEyuxiy3+ykDe5bVgFI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-aR6RhZp2OLijQ4mCBq1Q4g-1; Mon, 06 May 2024 03:51:48 -0400
X-MC-Unique: aR6RhZp2OLijQ4mCBq1Q4g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-516d46e1bafso496252e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981906; x=1715586706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwhnI0R3GJbUfLrtmrA6X5iWICM26TYwYhxih3BiOs4=;
 b=j3MEaz/QTU8DDbFWdSlZ7jRjPEEzSuqYMdY0TwXvrHQxqgmz83D4SNqbAdbvHyvQ6d
 qIycmm1IA6NPbo67+QyZSq6ePJ8n4bvJQzykmzyMhnC4/QcPq+le54ltUCXuHKa9c3V6
 aA4hyqCXGf44RvEcmEyCCVj8GRf1WOGYV9LxmoWkwf3pqgN4hetGX6SUz2Y9ZXy+e3kZ
 /AoTpjpNnstObBDiJOTxuc3tDb8t6H6g6s5e34iS2rRU/3pZPwkl2S5vkw3+15myDjqu
 KfMBU1jogX9fSEDlWEYsi2uNbJN9L2NEUlmpn8AUm7xJXYNL20fNMLwsDH7Zbs9GZtut
 zcLw==
X-Gm-Message-State: AOJu0YxoXM/p+fgPwrnApRgGousBqRwbfFo9YA+WRCvam7p+kOE4/A8d
 ko4VNf6VUrkgIJOvPjwKWHhzlZVLKEqtExJq2Al5nIUFTH/OjUPDO9uKRCjCPhi7t1q5k3ouCX0
 5apwJhqaZUV/M7iLUbSEozuDqA0eYKCtmznOsJlenqVaVz9q4PQyzW8yQORVVP055HIIHqOLZzU
 OPbHREoPEf+0JS76mb3z6sdGu3umqGT4h12ulO
X-Received: by 2002:a05:6512:3d87:b0:51e:876d:17d0 with SMTP id
 k7-20020a0565123d8700b0051e876d17d0mr10268994lfv.52.1714981906077; 
 Mon, 06 May 2024 00:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzvB75/UivXRK0PmL+BoKxQuM6fAyZaJAclBfH0YtZutrTWkWYCvi/4O5bypeaNhMplSOU/w==
X-Received: by 2002:a05:6512:3d87:b0:51e:876d:17d0 with SMTP id
 k7-20020a0565123d8700b0051e876d17d0mr10268967lfv.52.1714981905543; 
 Mon, 06 May 2024 00:51:45 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 zj1-20020a170907338100b00a59c00edc42sm1784003ejb.73.2024.05.06.00.51.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/46] alpha: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:46 +0200
Message-ID: <20240506075125.8238-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Start with Alpha.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/alpha-softmmu/default.mak | 5 ++---
 .gitlab-ci.d/buildtest.yml                | 2 +-
 hw/alpha/Kconfig                          | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/configs/devices/alpha-softmmu/default.mak b/configs/devices/alpha-softmmu/default.mak
index d186fe8e9b1..3de6a9f5779 100644
--- a/configs/devices/alpha-softmmu/default.mak
+++ b/configs/devices/alpha-softmmu/default.mak
@@ -5,6 +5,5 @@
 #CONFIG_PCI_DEVICES=n
 #CONFIG_TEST_DEVICES=n
 
-# Boards:
-#
-CONFIG_DP264=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_DP264=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 6394b8f41e4..c6c9c242c5c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -661,7 +661,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: avr-softmmu s390x-softmmu sh4-softmmu
+    TARGETS: alpha-softmmu avr-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
diff --git a/hw/alpha/Kconfig b/hw/alpha/Kconfig
index 9af650c94ec..7f3455ce1e1 100644
--- a/hw/alpha/Kconfig
+++ b/hw/alpha/Kconfig
@@ -1,5 +1,7 @@
 config DP264
     bool
+    default y
+    depends on ALPHA
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply E1000_PCI
-- 
2.44.0


