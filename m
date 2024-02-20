Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD6CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsV-0000Gb-VP; Tue, 20 Feb 2024 03:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsT-000082-Ns
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:26 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsN-0008CH-Le
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:25 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so630827266b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419197; x=1709023997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o89E/Ku3KzR64hkojq1CtXI0Qta+vdWxO3OzuZ7eBoY=;
 b=pWJsZVTSXObnowGiGoI+AgoHsUQgh/F4wP446N9Y++va8hY++enuomAdsVgyl2irrE
 558y7Pyu3dP3vBfz3GDl4wvJZCbc2lju54dREfARTzEUFmlP0pLb+LP4+UQheF+rwMQ0
 Zte/AiwiHtP+oE/2A6XvIUrLWdTjeLvWHCvvJMzJZs6IdWE3cazDpnasNpAYIgTgi2dC
 PqNtUhUiHmu6w7kCTx/daxz0YdeBPBVg0ZyGRpkt+Sq/Fquhs5uhhpMHUU52Jb5JbQFo
 DBKL+OaEWwqeFp4UGCka0qVkO5AGtOKD5nBf+1jrd5tw7a3NepiddsaliYnsgnTApejr
 7UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419197; x=1709023997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o89E/Ku3KzR64hkojq1CtXI0Qta+vdWxO3OzuZ7eBoY=;
 b=YI7AsZ5ZYeQHscph+FqTlVKzv7wTQ/yiGSb+B/YCJKUC1bkxRRm8++xK3AReTgpIw+
 2qmmRO3yUNGofFb1W1B4RUMqlU+qn0w1yw0B/qm/iylbRcYSJDuHtjeQQ9qEdnXtg8VG
 DUhj6OjH5Gk+byzijK2BgCdMGqSbDfyUgb4MwR3NXOf1ljKNl0Yt6w5rVISWIQjwzYXr
 Vkd3gLueJxNNc/VMBLcgX59iJnKgk8w8EE1KjnKy2pb9j8Fx/LSHl3NPHS9x8AY5/Lci
 HAnFuFfW+uDDa+3k8C9l0OR+imYrbMo6LC9Yh4E4WFo/ZmIbxi1t2+IXDvJlJxwbpCJ+
 hIAA==
X-Gm-Message-State: AOJu0YxktkH6UDLJkSau+kS2zvCM8oyKHN1OEayZ2lLhkz3N6Pv9GuEf
 wqWL+XD66/5LRjq8uNN/nfgK/g2Ton/G4EpyMygsTumejenyDn5EWHCp5MzUDasNbmk+DrkNcwe
 0GYs=
X-Google-Smtp-Source: AGHT+IHZ/5+wJaE8BswIiI13qF638fQ84Xq68mx6bhNQPrYduawqHNgg3bpQsy0Pa63H+aZDMetv3w==
X-Received: by 2002:a17:906:2657:b0:a3e:46f3:ac92 with SMTP id
 i23-20020a170906265700b00a3e46f3ac92mr4182933ejc.21.1708419197251; 
 Tue, 20 Feb 2024 00:53:17 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:17 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 08/21] include/exec/memory.h: correct typos
Date: Tue, 20 Feb 2024 10:52:15 +0200
Message-Id: <16e84fbb3dec43ee349a8ea5dd945c9630630bb3.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/exec/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 177be23db7..8626a355b3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3146,7 +3146,7 @@ int ram_block_discard_require(bool state);
 
 /*
  * See ram_block_discard_require(): only inhibit technologies that disable
- * uncoordinated discarding of pages in RAM blocks, allowing co-existance with
+ * uncoordinated discarding of pages in RAM blocks, allowing co-existence with
  * technologies that only inhibit uncoordinated discards (via the
  * RamDiscardManager).
  */
-- 
γαῖα πυρί μιχθήτω


