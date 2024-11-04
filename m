Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38748D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpz-0000ap-8h; Sun, 03 Nov 2024 19:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpv-0000OS-32; Sun, 03 Nov 2024 19:20:51 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpt-0002di-Ic; Sun, 03 Nov 2024 19:20:50 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so3084310b3a.2; 
 Sun, 03 Nov 2024 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679647; x=1731284447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsXjKxU1bjOa3emgDarpFagIJHml/BMiYk9jtSRp10o=;
 b=ArdF+SJMK2QEW+tpxjMdkEpd9vh7fcoHv7CLlpuNUOwMTA+JfgEoTo1QUkAl0qZiv2
 hJWrKxBfGuiFh+4JD4XeQ5IrbNhWqZXPdvRRhTkf8O9MFFDwNOX3xfrAkiatz0fODpw+
 70apGiq1iZ1BZyNl4Hn5EBe/ZhT77awBAqClrgEqV8MQHXb2lAA/EHarne0EWbLd3+IW
 Z++0dA/4E5gMNmVKHDM4cgGPuZewK6nzN2hGkJQG6EpR3BcF9DRvLgjSwimdMiWKWYaH
 Xg0APtnPEbPx+QUOEOoE1yRylt25PCX4yJr6LHja2FzEUSqEeBGmRbjDv8GIBluAqWKK
 OzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679647; x=1731284447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsXjKxU1bjOa3emgDarpFagIJHml/BMiYk9jtSRp10o=;
 b=eqyt0QsG06A2vJG4vfirFIx3QozEsOqQAY5ApYC09bXe2qt9TDTyGzT9ck76izBpQN
 lXq1QvcaPlwClv0a6IS467P31gYuVzj0Sg33VP9EmOOHO2yPVxbEQuUIeCNQR81OuIsY
 KSSy3cNEgq8tN0DqNMc9q3VixJjUzrRNvabWW7nhxP0vLZVAVMxrP4kWy/1XevjBl375
 hBPet2lSx4tgW/L3ziMvuRmGmQo4V0DEP2hbAwhRhpaFHUQFMlvTZ1xAqqOin79kl22V
 2OFD47+uaBW6cyt6/auMDZ5gW1RUifc3AUPub/qxdJ5Fx23eViQnUA7T5Ts+rEe1HIZE
 Fpew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXix1yDkVwlnasUdMco/2T5apNCXW3m+limYy3P9vAWI7aiZ2SgFVSxBp5h15O8T8fJs+xNvYHEPQ==@nongnu.org
X-Gm-Message-State: AOJu0YxS9SBHdileu5qy5dtaumu1yfa3ITSQ7o+XnT+AuJSrZnRrrdST
 b7C1JBrUhyCnuUB6HBdw8ym3ZOXSPl1TuRV9yF1x3H9m/IM2r8ltsZZgqg==
X-Google-Smtp-Source: AGHT+IGe+ddvFnEjBFTs68W6rKEOhfw0bSfGFlYigmYv0IKFHpu9ZpmcNKFK2ZBPPNQh6lxEPbBLvQ==
X-Received: by 2002:a05:6a20:918a:b0:1db:e509:c0a8 with SMTP id
 adf61e73a8af0-1dbe509c0c3mr58087637.21.1730679647257; 
 Sun, 03 Nov 2024 16:20:47 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/67] ppc/spapr: remove deprecated machine pseries-2.10
Date: Mon,  4 Nov 2024 10:18:15 +1000
Message-ID: <20241104001900.682660-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.10 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 14a1314af6..4c76d2841c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5069,18 +5069,6 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 11);
 
-/*
- * pseries-2.10
- */
-
-static void spapr_machine_2_10_class_options(MachineClass *mc)
-{
-    spapr_machine_2_11_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
-}
-
-DEFINE_SPAPR_MACHINE(2, 10);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


