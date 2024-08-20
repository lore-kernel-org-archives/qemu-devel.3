Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C95BC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgRJN-0002mi-EQ; Tue, 20 Aug 2024 12:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sgQGW-0007E0-8b
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:55:20 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sgQGU-00073n-IK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:55:20 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f3f07ac2dcso7600071fa.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724165716; x=1724770516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YMi8DrVycOLvdw6yYgwYc/xGvgpSlzsOz+MpW7aB4iI=;
 b=E8gQK/C/HEzgA54ZoN0g0nLHS5cM1zO7EqQpzhX8JUCPayoZxn3fwr2UglCDp7N8ID
 ac37SMI1jhPkhjyGCAAiQ+7X1U3NGBwt1vOw0AFFFTN1rrx7fIqjD+jUNpj8oAlU53zY
 je3Fz0Dhbc3YFYrSJ/lfOQgMSb7/cUUczEQM2P4ihyYbpO4mdclvDtfDSwnB41XuaLb7
 BqMcjzqrTlXgBSH+d8jA9qdqPUOFYlmb663A+98FXdkpKz0pjUuZxmkE+wdgABurQsqu
 AasbUbqUmBsxMjIF2R3EjrTg6Kos9YFVt0uze3UKG0jkBDgMU9mwbdF8CLh5+91FoiW9
 VhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165716; x=1724770516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YMi8DrVycOLvdw6yYgwYc/xGvgpSlzsOz+MpW7aB4iI=;
 b=Ft2xwbUoG3ctQegFW3SAtVjYkFLnuPh59z3ifZ1pYxSnCpMCe9LJg+hqnaPxvSNEz3
 x/e12eRQIkAGTuYJc6qXa09BGD4+AUcbZcc/CAEaJ8V93V6/O+bGX/kp2Vir14VoY7Zk
 Erl+wl/PLk48pVC7ELRygOqJC0Qa6u6hv84txVpvdb1aQBBVoptpBlsb5sHpBsqH8TdU
 jOjq+CsclhQF2KZqF24P9+pn4qZY3tHlU3XbgE6p0NXTJ6EJZnXZZtyJlDHyAG0u/iRQ
 XbLKNiFQkMfVWaAH20/Dvq9eQ3DW9d3nIkzunyXI/wlpkBTHw73TMzASnsO8aGkE5pYO
 abbg==
X-Gm-Message-State: AOJu0YyVZpw9gOnJ4QnGgLk3/Bqidehi7/n5nZkrKM8JU+MhA0RIhy+C
 VXuW7vx16FnNpPdi1kyxdFLjRAdmQaWNrq1h2HpUtJGRjeQP2PAWG1pNEb1W
X-Google-Smtp-Source: AGHT+IGSrivFLxvmMGtcHXtRKYrztoG6hMsVsewFfm+LHj6rzycEmrBOS5b/pzI2PNOEyWn79KOcLA==
X-Received: by 2002:a05:6512:10cd:b0:52c:dbee:bdb0 with SMTP id
 2adb3069b0e04-5331c6f0578mr9970551e87.59.1724165715301; 
 Tue, 20 Aug 2024 07:55:15 -0700 (PDT)
Received: from armanpc.intra.ispras.ru ([145.255.10.144])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-533416b40c1sm196028e87.111.2024.08.20.07.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:55:14 -0700 (PDT)
From: nabiev.arman13@gmail.com
To: qemu-devel@nongnu.org
Cc: armanincredible <nabiev.arman13@gmail.com>
Subject: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
Date: Tue, 20 Aug 2024 17:55:14 +0300
Message-Id: <20240820145514.63046-1-nabiev.arman13@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=nabiev.arman13@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Aug 2024 12:02:10 -0400
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

From: armanincredible <nabiev.arman13@gmail.com>

Signed-off-by: armanincredible <nabiev.arman13@gmail.com>
---
 target/ppc/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 731dd8df35..d433fd45fc 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)
 }
 
 static const VMStateDescription vmstate_tlbemb = {
-    .name = "cpu/tlb6xx",
+    .name = "cpu/tlbemb",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tlbemb_needed,
-- 
2.34.1


