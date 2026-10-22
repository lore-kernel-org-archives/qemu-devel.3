Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PDIWtmJZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJn90-0001KI-LW; Thu, 22 Oct 2026 03:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn8y-0001Ju-Ok
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn8x-0008NR-CO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso658971b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792653797; x=1793258597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=PDIWtmJZPKLzvMgXeTsJ3iYWcDvDUHwHkN7Bgg/kV7rFZNGcuEY+emsjR4Gql8/973
 qTWjguq2QTNUdsm0MCS0vUmF3edO82LmlDG1T1NY8C3tl1pudkePpSq7iPoYnzCDAfeF
 w2Idgh0UmDdbiQ04vd5cA7hPjQKuo2yAZAYdCE4IaqL8gqsp0uSlj5n9MZBD2n7l+21A
 pIfDqEuq1HEA5IUwfKPPlclOcekY9Sfqj5vjrlMPx0gMBbeZH3SYqZxaFMx/uDmXaPP3
 rUR+5oHJj1tSItRYkgQjvJFioLCAQPiWylPoAthGFKp8xIjjef7yIam5QDuZw71uOsGm
 Kgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653797; x=1793258597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=RGC+/oEZOM19QAEML7y6hzkvXST+VOemQd0oq6BVg4czKcsn/7fzeqZ9rvR5Bxqu0c
 yM7mp66uBoLfJ1UWSDoQ0+3F9SM8bu2R+Kc3v9Nj9pivPXZfRpnnivr7pHaGPraViQI+
 +2fjQKt60Gx5c7GnER+zyQKANYEe3aRL9zeKA6MoOL139hLqYws3PmgzRWYZkTHT5Smk
 IFCpUuAq9dwauCq6rkTsUPn+czAHeIgxhw7MsRVi10KXIeOculI2lr842i9LbK+xMc+C
 C75bbSNrjbdxjRWsIejEbgEeYpoEY2/FsHgQlWXehA6NsTvsL7gMpZHOSLN9FGY9mI95
 x0NA==
X-Gm-Message-State: AFq9FYJrIFEl/esQkaZhcOmF3oYMelQGmYzvlsx2m7m/SKCfrXuUyUj3
 kf46pAD15NgtIL0AU/DgE+AuM//Megd6oYADbVVECiSljDUq88g+DvFD59SU32Jad2Y=
X-Gm-Gg: AYBFou2wH2p3++lif5bSPkGqC3vNNfyBU+dCKRFMjH4cnjcFaV7EwbupaIkBe+19EWN
 WWDOCH3BAoOlHfR+WdHFSYRbBMATvTNxXoe6OXezh38raGt0HhOLwsWBvzCUhDKJsoD7kRV1q7J
 FfEIa4EtHWLYK1okbkkpWBtx9wZ3EwSil1rUhk7RnoYTPDtVliCEemBk7Fhd1lU+4H1R6qolQBF
 kQhjqNsXiTxANcTFLt+O4XlYXT6BLqac2LQ4MmZN9HlkaS4fLn5olws8B/WDAuAUMV3zu55ZhjU
 cmTT9pykz/EM8Wn+9Bsberazubu+jWyaqDfqaDfmbi8ZoGhNlHwxveE0nJoQ9lytgbIdWNuhXcL
 cvn3UZQxlhK4cyrqBJ0zERwlSjzjnqB7acA95FQOoVhMkz2xx8EAfEG7ABhr6EP0fDb7zHCuS8M
 RokhOEpsap8Z6PbrmErisMhSmAelncptmXyXnLp6YZTVo4EnmDvcx5gI8ctIQUPgOoEJbgPpa5I
 uvZmlo3qoMzUiuIIjqE6szbU7AyjC1nSc053ok7WBcYKKSeEtAlDxh/o3OVWmYHPxeRc/xWgbQl
 2yNydA==
X-Received: by 2002:a05:6a00:e84:b0:886:3a6c:a9da with SMTP id
 d2e1a72fcca58-8a089d03a15mr3406224b3a.26.1792653797372; 
 Thu, 22 Oct 2026 00:23:17 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0894b49dcsm1699776b3a.16.2026.10.22.00.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:23:17 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v4 1/4] bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
Date: Thu, 22 Oct 2026 15:22:35 +0800
Message-ID: <20261022072238.319308-2-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022072238.319308-1-waysorrypub@gmail.com>
References: <20261022072238.319308-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=waysorrypub@gmail.com; helo=mail-pf1-x435.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,TVD_SPACE_RATIO,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


