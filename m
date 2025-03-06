Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B43CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4vN-00020u-Of; Thu, 06 Mar 2025 01:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vC-0001yx-Sf
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:30 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vB-0006FE-7W
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223959039f4so4517275ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243287; x=1741848087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wT8pzATX7z0g510B/bcUtetzdKIxpUlAXqTAPEA9Pmo=;
 b=TX9YD6JUYameHKisYMzsZHECxTV8cv/iY96XkR4ANkGSj4h2zZEcd2vPeU0OHwG93s
 ze7mxt0qDg0soI3ni5FocjqJPnu9hjqC+bEuCWFVKLJrHj9VtE5/7o91mat0G2t4YTin
 qht8fqsf2eNO++3pU+f42cUtAxnGcszDLCMxQxCKUcD3cQIBlNnxq/lDGtZFffFTFxl2
 wUiApHvOP7XiXN8+sUEshQXedaj49i8miqY3cyW9ylssyfUWHsgdGUGb8aX6c5cX6q5U
 Sep2XxglVNsloiLPyg5JZa1eqOUOkMPAk8H39zJQL+J+NtDyV2x35loyXPgfjQ9LBVQm
 FzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243287; x=1741848087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wT8pzATX7z0g510B/bcUtetzdKIxpUlAXqTAPEA9Pmo=;
 b=fJpAcb57YE9CH0YtuFgC+lFlM+IvUiuTN66P0ZfptvsuEewsdLi+BqTdiPPGaVM9y3
 Q4i523PiYiqQ0PKfiR1bj3kml2SQlFyb84Y/LTiQUPGPFrcF6WEGZEDuO0G3Ma5MooD1
 shWkrZF0Tw9iKZkTF3tyedFspSZY5hZoHH7Do2GBvUpSeEfm7NLg8W0g7PJbaw41v0My
 R2xEKa0QPL91sxVAMlRah1iHpUlWVLxsuHvpGIChDAzKrvUdQjvjoituo4WHYnKbwKWp
 +Oz+r2bpladnR4AWL758C+cU73tLs4fWEDBQeRvLAplzrE6hD6axv2e9fKv02Iiz+Eeb
 8yFw==
X-Gm-Message-State: AOJu0YzYkJ9IYFv3dD5zNG3RawPR2xATwlxSRRpU02SUB0ogaik/g/di
 FLf6xt/XXQvx+gPsLxHGe+ZTCX9T7QUzBdj5oDckBrCRTapCIohDs1qsCY+66vi3hBTBPo4a6Np
 C
X-Gm-Gg: ASbGnctZ5brq+z9MRE3SDOtsG/N+3G8sdr776L+ORi0pqv/dMjvrN/DVxgdI8h7HMwM
 LIj5EqhoJXDhMLiLV0W2sbOiBMogACwK2P85Yt0HVNw9HbyGq/7oI0ZB04ZQarUPrybkqiSV1aV
 usZnsbiFuTrI2TX5CiqO85c8pcu7XfIX7AdohrJaMg6B+QwhjPiEXE2tlCfpP5HUJpjmDjIcXbl
 Cvjzip5q9FuDLkTub412Buuin+z0Crixae94Hvb52jw/1aa6/ob8oM1ngGx7kQtH9mIwo19JaQp
 uBHUB0aQWM2X+Qon1RDZ5GM4QbVnz1vSx/ApggxbqXyl
X-Google-Smtp-Source: AGHT+IFLB8iv4RFayusNn/dU8XKbHiB/II8ZC0o6pkKlvCRP8oMz/PdatWDGujnk6B+WsfH2+JYe+Q==
X-Received: by 2002:a17:902:d2ca:b0:224:10a2:cae1 with SMTP id
 d9443c01a7336-22410a2cdafmr13816755ad.37.1741243287140; 
 Wed, 05 Mar 2025 22:41:27 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cffsm4769355ad.174.2025.03.05.22.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:41:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
Subject: [PATCH 1/7] hw/hyperv/hv-balloon-stub: common compilation unit
Date: Wed,  5 Mar 2025 22:41:12 -0800
Message-Id: <20250306064118.3879213-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index d3d2668c71a..f4aa0a5ada9 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,4 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'), if_false: files('hv-balloon-stub.c'))
+specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


