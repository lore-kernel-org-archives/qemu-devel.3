Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C341CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbHup-0005r5-3j; Sun, 21 Jun 2026 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wbHun-0005qq-Lr
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 09:08:45 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wbHul-00027N-Kb
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 09:08:44 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso505100466b.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782047321; x=1782652121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X7fC6bEnuzC6VfRcLsUsD9EbSrL3c3//OVg1IPNcn2U=;
 b=Z9g4FRVuJck2US/VTLX2yKaw5p0M4aeSmHRwVwvSSPf+cplTdW+6wFdjOHCB99Om0O
 9/ht8LejF5oD+BCNLwd/cI6l+kPUe+wf/T/keuGwmArxzZCdakhSwemw4vEl4bDEr/h6
 z1V4fVK9pDAHS6TEfOzI6OUE5eb2qFWdLLs/2bKNVK53r5dQ9jHeJL0uX/7PPriE2UpV
 1/9rtB/JQsFnJMRHGW4B+T7eYLRUR8P25UGxrVYw/9/++rhpiy40bPE4SWF63GVzyLcv
 yxCbqnA3k6JkTkbNYrEbkTjqkw9zJWcj1tYffvsmBBWCN/mmGeRMYwOiNeCtuzZAeDw/
 GrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782047321; x=1782652121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7fC6bEnuzC6VfRcLsUsD9EbSrL3c3//OVg1IPNcn2U=;
 b=X6bEnejQI10Fsu1kwxWTpPW/++QAlwEpcBowyOkLHaqXIg2qstq9v2XJAltNhlLldr
 j2Dks9H9jqw98h0zeaWiMQzIxOFvr++tCrGSVKQG7vrHp5spPOfDRpYVXnPXF2EY74os
 MtHkQXYGODatJasEcn+zz7qmAu9CnTxX42H6EjX/oVCEh67ZdhIaSZMJ0dj6sVzp5hTo
 rTG4v7IwkwWhgiihUuWeiLtnlz5NWYyxIn0Kf0bkcwLZ+jPlD8TrdQOKJKD4reLD54K1
 FK6+GAxo7pDdrp8uxCfBR4CDjiYkekrZSwAxXcg56LiiiwdpodIbwfertrIYx8adcWwC
 OGcw==
X-Gm-Message-State: AOJu0Yxx2QNovCuxoCsH4K0E3oh2nu3jMQGHnocA0ddNE6Pj/r88Ydl2
 ts2uMgKUTYK0g/erLnkJBTVAwmQ8+MevRbHH1Y4eFEGKcWY6FTXDnzS9s4OLPg==
X-Gm-Gg: AfdE7cncWMnR5Byi/Rb5QdDWPdfyvyNeXBY/GHys8rlqJBIj6scAv0q+wMvo+GOFdIz
 xgPilO4GruZeDJTSRoSqY1p0Y6nyuxKmCl+VhdQ+j7mTkbm3IElFYfNTXBTEgURoHAbXpL4h8ml
 YAD5ephDTI5tA8yH/pzhknMnIqIOrOUT1UlGVbxKrW2Gk3wsBcqT4Hke6rJon0eTFACFXZ+CJAT
 3nlgLKZys6UVADiaAlcoNB1zL6BnJ1fUCtWKe5urncOZJhPPiiHzLqAGYs6xB0LvUrfQQsaAQxG
 jyemodVtd1boXoL9peUrn49QyvS7rp3bxBmprNRp787e3x86x0rpplAXrNx8chENhZDPteyfQnE
 +ygzkmrUtMDyTkfw/AWwGwnqecBEQzqVJopklbJsA4rxqFolfy4pxiV6jLmVIbaZwiQMGrJtO6N
 4A5ZillkAjReyDRLHi
X-Received: by 2002:a17:907:a806:b0:c07:e0b6:13ff with SMTP id
 a640c23a62f3a-c0b62136ce1mr425796466b.30.1782047321009; 
 Sun, 21 Jun 2026 06:08:41 -0700 (PDT)
Received: from machine.. ([37.113.214.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c610e53d9sm206653166b.48.2026.06.21.06.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 06:08:40 -0700 (PDT)
From: Evgeny Kolmakov <randomjack94dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de,
	Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PATCH] util/oslib-win32: Implement qemu_get_pid_name()
Date: Sun, 21 Jun 2026 16:06:26 +0300
Message-ID: <20260621130626.19073-1-randomjack94dev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=randomjack94dev@gmail.com; helo=mail-ej1-x630.google.com
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

Replace the abort() stub with a proper implementation using
QueryFullProcessImageNameW() and g_utf16_to_utf8() to retrieve
the process executable name on Windows. Returns NULL on error
to match POSIX behavior.

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
---
 util/oslib-win32.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 5f3e8f4d98..2b083b5d7a 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -287,8 +287,23 @@ bool qemu_finish_async_prealloc_mem(Error **errp)
 
 char *qemu_get_pid_name(pid_t pid)
 {
-    /* XXX Implement me */
-    abort();
+    HANDLE hProcess;
+    WCHAR path[4096];
+    DWORD size = G_N_ELEMENTS(path);
+    char *name = NULL;
+
+    hProcess = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, (DWORD)pid);
+    if (!hProcess) {
+        return NULL;
+    }
+
+    if (QueryFullProcessImageNameW(hProcess, 0, path, &size)) {
+        const WCHAR *base = wcsrchr(path, L'\\');
+        name = g_utf16_to_utf8(base ? base + 1 : path, -1, NULL, NULL, NULL);
+    }
+
+    CloseHandle(hProcess);
+    return name;
 }
 
 
-- 
2.43.0


