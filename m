Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E355EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXu9-0003rP-U8; Fri, 23 Feb 2024 10:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXiw-0005cY-NZ; Fri, 23 Feb 2024 10:44:30 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXiv-0006Me-6V; Fri, 23 Feb 2024 10:44:30 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so739112b3a.0; 
 Fri, 23 Feb 2024 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703067; x=1709307867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MQLJMvPdch8iu3qVmH7fTRcc+ezZiJrrzTjkVWYHh8=;
 b=Oog7NSsJnZW4GN7RDFzChRH83RuiB/Ze57z9sJ0O78PFQioZ6wEwOXbnvboEKKJ+3S
 LM9ysepB/JIxDLbQc+Wm4nE986/79tx3aLv/ViBcdEMcMhLkyl9d5PXyUgkG3MTjDho+
 XmRqN91lSWdX83FldLsRAObfx6lc45sX2XXLIivzmogJFxOoArV72OtpKuipEfbPKvam
 Aay/MbhQ5AXAPvi05OiIpAxc2YDZYAQXZaoLPJBhkHe9LWrDC+JCJge/vtTyBowVetJx
 ID4wzIuiT9NXUhuTagZxpZfEeiP9kFUL9B+VFGKcaTFouXFthT+W0kq/5+L8O1hqYyL4
 Ec8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703067; x=1709307867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MQLJMvPdch8iu3qVmH7fTRcc+ezZiJrrzTjkVWYHh8=;
 b=dVysnhNiuZPtFuf1S+P/5UM1G3BhB2FMSFH+nhz9wYNuqYzBWS66bpvg5F/WwfsmTq
 QRTOBCMvJTaBiv/jEFSaOW/HjThp2NsgC0L6aNAZnKXDP/eZJpXZxQKEA8ntYDCpG8nq
 qAeNOA2M2y5+Fs/9Z9lWMKZuOSVMFhAZO8/+GYqCoajtAsDXpG5ieV3/xzE264WOSPPh
 e41pOBhJ2fQAsy0oJ2uWBL4BJBukYnUyt52KwHv1fVJEDDnSyZQNcskHNo0DvZWu/T/K
 P3vBoKMiSemg6WCXARLEN8LyGFfCQt8V4UEpC5LmKaVv98KOx0zFqxzuVsOriFuFvBdC
 cCqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR6HyOIfZlCmniBIKQHH8BC9Im8JIqlBONX1OdtP5pQGpMjrgdYLoUTx6K59hYnYTZXRIJFJoua6LPGI3mULg81q1R
X-Gm-Message-State: AOJu0YzhSN5/Y8b/PGeuon2tGTdaIuX4U1dvyx/nPBq/sGUlN/yYHmNc
 3UjKnEwyqMRnxqsYiZp3cvvTZovFpDDe6J4dDqM1zn832fIBbDVXg+Kf3TZo
X-Google-Smtp-Source: AGHT+IGlYXDmmesjT9BTCvc9RhfRqAEAwZ8SonU2gLCe0TlPYTlgh340v/45DuQzhbQ/Vr4Inju8DA==
X-Received: by 2002:a05:6a21:3a44:b0:19e:99ce:6f99 with SMTP id
 zu4-20020a056a213a4400b0019e99ce6f99mr271902pzb.44.1708703067213; 
 Fri, 23 Feb 2024 07:44:27 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 19/47] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
Date: Sat, 24 Feb 2024 01:41:38 +1000
Message-ID: <20240223154211.1001692-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

pseries machines before version 2.11 have undergone many changes to
correct issues, mostly regarding migration compatibility. This is
obfuscating the code uselessly and makes maintenance more difficult.
Remove them and only keep the last version of the 2.x series, 2.12,
still in use by old distros.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/ppc/spapr.c            | 1 +
 roms/skiboot              | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5a2305ccd6..36bd3e15ef 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -229,6 +229,14 @@ The Nios II architecture is orphan.
 The machine is no longer in existence and has been long unmaintained
 in QEMU. This also holds for the TC51828 16MiB flash that it uses.
 
+``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Older pseries machines before version 2.12 have undergone many changes
+to correct issues, mostly regarding migration compatibility. These are
+no longer maintained and removing them will make the code easier to
+read and maintain. Use versions 2.12 and above as a replacement.
+
 Backend options
 ---------------
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b442d18317..d1c6d70d8d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5083,6 +5083,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
     compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
+    mc->deprecation_reason = "old and not maintained - use a 2.12+ version";
 }
 
 DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
diff --git a/roms/skiboot b/roms/skiboot
index dbd5de6624..24a7eb3596 160000
--- a/roms/skiboot
+++ b/roms/skiboot
@@ -1 +1 @@
-Subproject commit dbd5de6624d7466bb67d1eb4e57bc3a8e2ad9e87
+Subproject commit 24a7eb35966d93455520bc2debdd7954314b638b
-- 
2.42.0


