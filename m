Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C563C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uClfZ-0007R9-VC; Wed, 07 May 2025 16:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfR-0007Mu-Hs
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:47:01 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfP-000387-EW
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:47:01 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-604ad0347f5so91389eaf.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746650816; x=1747255616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9X5YlAX5hZZRj1bHKGnAqtuguXh/5Kuv3WoZqq6wDMY=;
 b=J5LOJbmCBY2kNs5XrvJV1/XIWunEegAxHY/VlqigdIC8T+KP2Sq8mF6zVfF/Lj178m
 rClBkfoqdpoHUnl14rCxUB1nvg7j+ZcAO3M6+2uhVV0ibKl6FMX3uQsTRd9uAY+DDKLi
 0q96Pqi5FqVwUHEJvfmwgAsxqZQ6P36m2Y7C0HRk4EUSe5iMvnapUhhI1aZZYmckqyUQ
 ClByHmlhGxiOkr2f1WqabwkOjba5EgjC+GM3aP1dgvg8eYs3XEkx+XHCfBkHY+L/HmOe
 5nNQvtU39kjkoc2OnsBPZkcfgc2WkBu8CQiMiRHpjeb3cOV8UA70dOVWOdKTMIR9OIfo
 qPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746650816; x=1747255616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9X5YlAX5hZZRj1bHKGnAqtuguXh/5Kuv3WoZqq6wDMY=;
 b=GGNPyMhi1Arfd/gMZ2WC4R93gdQuh1mzASjOuLTKXyq1nQ8kxyhpNCYzVn2lhEZS/n
 oH/6a4hIDXWo/MnxhnDvCiKSOEjY8GRxhBjql6+1dqB21IB7dQQ2L98TFrpr7L9ZgCcc
 RrayI6HJROLiuQFQpkTsPcCUMxpe80GNPgDfJ0Z+Kg9Lq4hRBGHCBUjUJoRWlJr7KFb7
 8c2CErD+gsZj0FYJG8rhP0YvXhYouteKJGMo4Iwq1MWCtAZ4gS1Cqj5SHEUelZJCUgEy
 493x0vd9Uh37KzzLH0SMOqbTSVLrvkhS/S11kLdlt19OdEp0K7jKGtW4b7zmrBkR/lmf
 IwLg==
X-Gm-Message-State: AOJu0Yxfv5fk9w+a36kAEZG/NN4v1JFQkbH797SJtDN4245FGsuoc/RS
 nBzKvo8J5h+ZCfed2uGoQXZNjLSsLddYJP47a+BLQVHixbU7wpkRmou2kNF2tM8OOJHqFEoXVDL
 ga4M=
X-Gm-Gg: ASbGnctOfFuhDGXhFwN7yG4as8PDiKMPhMn+Us2uyn1I4aHQNAXvbWOoOjGg0/UKYbT
 lRN3Hg3+ArDd48Cr7JFQKFPppl8BnsyF21bEN0aD/i+De0Nx53s5pSwo2D1T2FRPXr5UPS1wkeP
 YOR0LMcxLQJQZkMx/u52pAI6sZZ89MGPwc82gzPbWEwbdocIf6RrxrS42BLouSrm9UR3jHE4MSu
 9ECDWJ2iUhfCoxAaIqJC95TxLN3rbqMs+AVZ5rJj+iFPXfEisOJAUo2jeRwrBgYflIyywbtyEDE
 jx2SILCYYiK6fZZyJVe6Yr8E0/Wri0kFc0+nYZ+ad7jEvrY+
X-Google-Smtp-Source: AGHT+IHTxYqW4lQZOBxH+deLgwoMHTIfpvcRsWcAhaSh4m8JgywEvo0bfyvdUiv4X+rnUPFucaKp0w==
X-Received: by 2002:a05:6870:a449:b0:2d8:957a:5176 with SMTP id
 586e51a60fabf-2db5bd76631mr3279626fac.5.1746650816499; 
 Wed, 07 May 2025 13:46:56 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbc7d1fsm920933fac.11.2025.05.07.13.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 13:46:56 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 2/3] Fix typo in comments
Date: Wed,  7 May 2025 20:46:25 +0000
Message-Id: <20250507204626.139507-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507204626.139507-1-gustavo.romero@linaro.org>
References: <20250507204626.139507-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix the duplicate "the" article in various comments.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 block.c                             | 4 ++--
 hw/xen/xen-hvm-common.c             | 2 +-
 include/exec/cpu-common.h           | 2 +-
 include/hw/xen/interface/io/blkif.h | 2 +-
 qapi/qom.json                       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 0ece805e41..2bac802da8 100644
--- a/block.c
+++ b/block.c
@@ -3153,8 +3153,8 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
      * stop new requests from coming in. This is fine, we don't care about the
      * old requests here, they are not for this child. If another place enters a
      * drain section for the same parent, but wants it to be fully quiesced, it
-     * will not run most of the the code in .drained_begin() again (which is not
-     * a problem, we already did this), but it will still poll until the parent
+     * will not run most of the code in .drained_begin() again (which is not a
+     * problem, we already did this), but it will still poll until the parent
      * is fully quiesced, so it will not be negatively affected either.
      */
     bdrv_parent_drained_begin_single(new_child);
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 9a677e8ed7..78e0bc8f64 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -711,7 +711,7 @@ static int xen_map_ioreq_server(XenIOState *state)
     /*
      * If we fail to map the shared page with xenforeignmemory_map_resource()
      * or if we're using buffered ioreqs, we need xen_get_ioreq_server_info()
-     * to provide the the addresses to map the shared page and/or to get the
+     * to provide the addresses to map the shared page and/or to get the
      * event-channel port for buffered ioreqs.
      */
     if (state->shared_page == NULL || state->has_bufioreq) {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index dab1e7e580..a68485547d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -182,7 +182,7 @@ void list_cpus(void);
  * @host_pc: the host pc within the translation
  * @data: output data
  *
- * Attempt to load the the unwind state for a host pc occurring in
+ * Attempt to load the unwind state for a host pc occurring in
  * translated code.  If @host_pc is not in translated code, the
  * function returns false; otherwise @data is loaded.
  * This is the same unwind info as given to restore_state_to_opc.
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
index 22f1eef0c0..c5527999d1 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -324,7 +324,7 @@
  *      access (even when it should be read-only). If the frontend hits the
  *      maximum number of allowed persistently mapped grants, it can fallback
  *      to non persistent mode. This will cause a performance degradation,
- *      since the the backend driver will still try to map those grants
+ *      since the backend driver will still try to map those grants
  *      persistently. Since the persistent grants protocol is compatible with
  *      the previous protocol, a frontend driver can choose to work in
  *      persistent mode even when the backend doesn't support it.
diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24cd8d..04c118e4d6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -871,7 +871,7 @@
 #     link characteristics read from PCIe Configuration space.
 #     To get the full path latency from CPU to CXL attached DRAM
 #     CXL device:  Add the latency from CPU to Generic Port (from
-#     HMAT indexed via the the node ID in this SRAT structure) to
+#     HMAT indexed via the node ID in this SRAT structure) to
 #     that for CXL bus links, the latency across intermediate switches
 #     and from the EP port to the actual memory.  Bandwidth is more
 #     complex as there may be interleaving across multiple devices
-- 
2.34.1


