Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9F1C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXrf-0006S9-Og; Fri, 23 Feb 2024 10:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXit-0005cC-CH; Fri, 23 Feb 2024 10:44:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXir-0006Lk-Ks; Fri, 23 Feb 2024 10:44:26 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d73066880eso3905245ad.3; 
 Fri, 23 Feb 2024 07:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703063; x=1709307863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNkOh3VPNtlgospyMybpdwKaxmKzTmiXNUjVZD0tHkg=;
 b=k9J6hDVwU2nA/UTdtpttJxK3P+2cUTqhg/a7DJ535TqoKvyeWuEjP+fbW1/Il/cBC0
 zZBzRHEZTzUNipVMInGoG1AXKTHVCyXg2L+8H9Yjs6Qd9S8n9VAbR9rQfhBwfIPVA+nH
 6y4jUfzrncpWd2ykz6OAD7oTeu+NQ8yAshS7MpNE5GiI8pHR+LooWbc4oZH9zYgaRJzV
 BnzGW5XY44TlDzXspXATbPnTGaqk+EmYW2GIaO7xpq4/s7NcuDAMUSpNeWsVLXH/SNZt
 WkKePDVPhYdMjYNchhWNMGCOTix2YqECbnIczTv9ZUbKQ3hO7LmQdzaWJ6DC/Dea7YLf
 RdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703063; x=1709307863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNkOh3VPNtlgospyMybpdwKaxmKzTmiXNUjVZD0tHkg=;
 b=HcioXU4Mvugrq7Tmd8mx0TtYADlqYVVd8EFW8SqdJujGj+Js6dp2FsNFqLyKU9h70y
 OIq6PJ6m5fqcm+3VHaUrTHKKYvIlF7ZMFQ5fdT7wS2lQVrHN2RVDGYuLX1/jVikKYpbV
 LI6ik/UlvBU6Fc0QPEx1+tdrT0hhDMQTaVc+c/p9H0lgNa7IcN9noZXHwj+kyTFGmBXx
 6HiAdjbcP4Bscj5un64wyzk+de7CvySzIdTgzPyV5h4JOP+ufSvF/ALh4zwD/zXqoP/n
 it5RsihZTz/4phr+kBk3kyzRQOQ1x3XBv6WF+0JiRZWcnIrOVADtXh77H/ywwn65b4kV
 ysnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtO4s7BiTdnozmjMwyL3fcyCOyBYCB0kpFK30Acqon/fg5T3U5VyqeJdaNgVsMdq94vA/2HerIiv4Id7WvD9hf0Nh
X-Gm-Message-State: AOJu0YyOm4V9+T38MdLcwE6ro0YrukQ6imYHnnAGEUEdBmdI3y2+h6rl
 8SMTUFYh3JtC6Ajq8P/bF8o8c/gVHV0CbCaYMpjIOE89ZFgNPawHNSGpBKaS
X-Google-Smtp-Source: AGHT+IEA7QJuaE8EC9DDAu8gzA62+wlOE/tHDRRGGj9SIY/M+dXmNFCU3Aznphx2gPi/BhwOTHWYWA==
X-Received: by 2002:a17:903:11d2:b0:1dc:7279:8a3e with SMTP id
 q18-20020a17090311d200b001dc72798a3emr243778plh.21.1708703063616; 
 Fri, 23 Feb 2024 07:44:23 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 18/47] ppc/spapr: change pseries machine default to POWER10 CPU
Date: Sat, 24 Feb 2024 01:41:37 +1000
Message-ID: <20240223154211.1001692-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

POWER10 is the latest pseries CPU.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0028ce0b67..b442d18317 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4664,7 +4664,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->update_dt_enabled = true;
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
-- 
2.42.0


