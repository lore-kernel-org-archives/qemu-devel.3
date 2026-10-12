Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD1CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEal-0001QG-5D; Mon, 12 Oct 2026 07:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEOY-0007Rr-Rg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:40:42 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xGEOX-000826-A0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:40:42 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cd60c5da24cso286947a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791805239; x=1792410039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=qkvhhiwrfcV4c8I8ec/R/VuZU+2e1GGjRmUD0MhtmZjEFApKwCx3zHD6mu4emQazNL
 bC2eEUohqj2aUuTKd8fIPMZjesIBre5wevEg7c5yu5WzhUy3HTztJ3Nw4KwtB1GKuOKZ
 Ddkd2dkCtfOgz0Bs+Lv4B3Swji95UK06MQx9XNuC12SI5KtAYgYyH8+U2PSCkwwgHtRS
 C9+W+Zj8oM5007zYa5pfkfpvfF5+/gByXCkGxgKK+kKIMYeSttF4H2ofhMzHzcHeEbs4
 mOVnaNGWqK+Go8C6/wxEcpKx1Ne/jibGpfm0ibhBU3Hqb0OQCuFm1V+WBEXmotxdlrlp
 wh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805239; x=1792410039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=P261Qjgh8PKrdulPifxgQdeVgRhOK0SNexFp0f6j2Lq6/V1YhIw4VQR3F50bQR92Ix
 iWIn5zMb7tVU2nlyHwk9s/Lq+XrC8zbjkrwT/Zg6wgUsJEqteBKmB9FDgCTUm/qskPiX
 BkGgClVYMWqj8Pz/PCEb/Inc6slVWH6d9iCx22y9EOyzaKr4MWQGE5DpkwGQM8y4JQGx
 pZbogEs8cgxKotk7SGQCLq5n67r/isTID2XiAcQ2MEx97ax9OvSycj5SR3aRthM/jZoU
 q7YDqyL6UlgJ6M6cMLbsP4ZbO9QP1HWHqWKhbDRnVFEjrPNKqsM/71xOxDFwzm/pByzc
 zVcw==
X-Gm-Message-State: AFq9FYJx/FHu9/Tvm+QM06kRBj7FCVlR8Y6xsTr7S6bMcA1DTgnPMdSM
 gwno5VBa76nQa1E8N0P7twMZXAbd0DKj9bLnxvTdMX0dE4e2R5mxT5tms9/p7da8Pj3pvg==
X-Gm-Gg: AYBFou0DLQLm3Ppn8pjfYCBjyBTJSHVzcbJ3MgNNjiMPlj9eshGBIRXKSbY7a1bUspq
 iX7w0LqCmeeLjYpa3G39Ny2EeHq8oYogG/l9iEVI0CAjBsTBqmNaRmbaeOOHv+SlzgA33e7DCh7
 woycONwWl9aKx95MUHBeTdq4jjrHPmRiTW1SB38Ksi4WqErmlZ5gHaiTTIZTFHXwtLqIPCYnzEM
 DHGdkb9Jnw0xb+BAIL1+GxoMhXQsE8gHSM0aY8zqgoiWGiD25+4aoXsv9uGdhiPoZEZzrsUVe2/
 VNQqIumRv1n/xyuvi0EP62O+4EkNyWZetjGnig5jwkrSiCE7StET86ML0jRC/EB+rXXKpDzJsHx
 XLkLKnAGvD/Coagw0tQ2QiUKZDk281C2ZdcrrTDDe/bWd+7zXCUDDYGikHXB0UgQFPFrNn4W3oB
 l7PC7US2XrP+LFZYi+0UBoikloPZLTnQeMd9Mys6vn6YhtXF+L9+ayWzp09LNvpIpWqHICH83ZI
 A==
X-Received: by 2002:a17:90a:d2ce:b0:3a4:97ea:f0da with SMTP id
 98e67ed59e1d1-3ab3a735fbcmr7348234a91.17.1791805238945; 
 Mon, 12 Oct 2026 04:40:38 -0700 (PDT)
Received: from archlinux ([2409:8949:4c50:eb:9b22:b05b:94dc:7aa0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab421566acsm8614008a91.3.2026.10.12.04.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:40:38 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH 1/3] bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
Date: Mon, 12 Oct 2026 19:39:56 +0800
Message-ID: <fd3d51a71d9d057d83524bbd02d2544fcfa5cafc.1791803914.git.waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791803914.git.waysorrypub@gmail.com>
References: <cover.1791803914.git.waysorrypub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=waysorrypub@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:53:15 -0400
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

Signed-off-by: pillow <waysorrypub@gmail.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523..2ed837f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/loongarch64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/DSDT.memhp",
+"tests/data/acpi/loongarch64/virt/DSDT.numamem",
+"tests/data/acpi/loongarch64/virt/DSDT.topology",
-- 
2.56.0


