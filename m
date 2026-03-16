Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02382F53D8A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Cy0-0000CW-1S; Mon, 16 Mar 2026 14:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2Cxy-0000Bo-7c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:47:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2Cxw-0006Bz-MA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:47:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aae4816912so32416385ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773686819; x=1774291619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAF+Ctc/n8rztxL19g6KwtSiXS2fa1crOXpQVEMXVww=;
 b=LbOJWHAzGEzRIxeV7qZzZCKf1A/Fg/hKb1QieHZ6OMUZQGkcPPdZ38OmW0OZVvbIep
 xwdTonHZLwUNN8s9B2lw0yra8ux7QdG9RF/sKOs+EN9+gqkofhsrSvz9353ku3hzf/Uk
 rdc9NfPq3ID2WRiZBgSlwNNQvYMY4UOebmCVQYMjzb36Fu+gHYNAgdETB514nsDDU8+x
 RdpEqhJwDasQPAspOFwoVGaPJYJ/1l9+DAnUUtU2r5cjQjgcfkrN1raYCH2WdZmeA79e
 2MwMBTs5dhy/2+OOa0qDNg3KKjaoV4VWqQ3pQntS1r+BeUXoEtc8K/4XGLcfJfhpZTlx
 qktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686819; x=1774291619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RAF+Ctc/n8rztxL19g6KwtSiXS2fa1crOXpQVEMXVww=;
 b=B2QKLx+Tj8mrRvHBFGI5FqzrGFRGt/bR+ON8fTWRvyV0U7dMDf3BNu+16Sg4s/fu4R
 IFvzdEz93bX7nbBQEweD+41FaNyUpH2OzxgrBMIE8HNok6TfDeyaA2xqbmvgemeogkwj
 gguMAjJuKjLDb3VwmiX4iCOmtvz5I2xYb2lLZTbmwtzUrvXu4Q4ICv4KlDfdc28SJrpg
 3GKFBJ7MIycPHhG+5y96O8DgDRTGA6u+QuoJnYagLomp4odOYU6kooyZWcLjM5oNM3yL
 Y8K8Mr6mefQpvk0xywDU701vUhrAanM3kPzM6ENdKRKr4eMZHBE5jtS08mQTec3Pq+Of
 omNA==
X-Gm-Message-State: AOJu0YwbToaNY/nrjrCczKO6jr++yjBOHsCr43CSxmr3b0xKVhTstImp
 dvf+PBrMw3Lje+5Lt7udTsqWeiUUt6LJEe/8IJa61SfDQ/DOvaGTZ09KBiVMc9Ic
X-Gm-Gg: ATEYQzxkrAypFmFCMg9eHwbgN2lEHU2jHRK2/ruH7WNP609jC92AXNXg23+KijOE6m0
 g5iO5doxCmEEkvhTJoZiM9p4n+gMxNb+8ykIp9vi7S2dOe49p0bRXXMciCQ4rj2kRYZOToLVsyv
 sanRBZuGmvmk3vn5AsXRa5vrd1QUD74WdN2yStp5cUaokhIR+HzKrkqhD/HNGPCpi6iE9q+dNOf
 m+BbIL5Qb1naLD4+IFnIdPwoIFAvbQ/FqSv+HCpMPbENqqXyT/+MWyTGzmMVNQbcaIFcSixvkMR
 h1ozm9oU1xpuXAra8v5geISafUsDIcyIuKQgUeJXWVsR0+dgsfklhBpxwq4MMDbw2vQnXsJ2cMN
 mJbvsgKqWUUFdxBvNeGwOlMt30l/FoBRevKtd4buixkbqJOPzYLRoa7TRJh8BjJQl3KIgVWDQDc
 l8WnD/fx725J872tamvDjn3nNBazmekVbjwwf7TWAi8WLdJ0OrGP9SA32Rj8X13T373opokbYVt
 rLumYvpfQ==
X-Received: by 2002:a17:903:907:b0:2ad:bd4c:a5 with SMTP id
 d9443c01a7336-2aeca9b90bemr134492195ad.1.1773686818827; 
 Mon, 16 Mar 2026 11:46:58 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b04f40f515sm77284145ad.74.2026.03.16.11.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:46:58 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH v3 v3 2/4] hw/core/loader: fix error handling for
 get_image_size callers
Date: Tue, 17 Mar 2026 03:46:38 +0900
Message-ID: <20260316184644.68116-3-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316184644.68116-1-vikingtc4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260316184644.68116-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Check the return value of get_image_size() and report failures
for non-mandatory file such as FRU image.

- Use ret < 0 to detect failures in getting image size.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 012e2ee4fe..fd875491f5 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
             g_free(fru->data);
             fru->data = NULL;
         }
+    } else {
+        error_report("Could not get file size '%s'", fru->filename);
     }
 
 out:
-- 
2.43.0


