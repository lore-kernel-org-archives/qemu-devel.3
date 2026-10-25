Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D4606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hCY/5M2U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKyiN-0002Mz-R5; Sun, 25 Oct 2026 09:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyiG-0002MS-3g
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:43 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyiE-0006nU-82
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:39 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3282db206d3so4116003eec.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792936597; x=1793541397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=hCY/5M2Uxw2VmBJX0qvNcG0+VrueiAtlBcqge2jdQ6JpiwcAaOsPkfiWR97kDbQ0oi
 BW9NNRA26XI8+Gi3GxQGuw03fmqkjHJSiMxLcuuvBa06LC7HxlGC7IfTgPQo1r0TTLJV
 nsAvGvJKoWyOU1BAECuS1EgZMp0L6KJtSVSuKHzDCJV3sjvEE0ijAfWb6ql+BMQamUlS
 iKjqxgrNjUnOxgAsF70Lee9HlN5AVu4ZYJIGvl49rP6nmxrdQ6h1NP8vX5joNGvgsg5Q
 k6OnJgyICyVPpkzr9j8ABl+EAXWzxQna8V+pf54v0c37yDlh4uGvr8s7tlns+MvWAdid
 oewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792936597; x=1793541397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=FbVpNeeRQSe3AGYovyn06XJjfXcUtTkB6GpY4l4ElAtYsk1R07aDNw2n+D01LZXtjE
 PVDVtgmjzJTlvOijpxACjySgjddoBWtKYUnr8HcfJgk/6QmyGM8crj+lWlwbxZkw9fbv
 tZQOrVYb5/U2Km/pAdbvD5dPsTP7IBCOMgYuscFNGQDVCole1mcKLRkwPcZ7Ahz5Mtui
 luEh0bfG/h9UB+vK+FiT74YMT03eolXx2GIOVb+qKxb/PTT9n4Jelhal4Nhf9TX0/6vG
 +w0z5l7w3JLWj0aR8OMcXOdxg3x81MmcWUn+g/dWCsXqhx6tDT+paE6RZkAzjzrsbMKc
 ec9Q==
X-Gm-Message-State: AFq9FYL5NbL7d4EbvEOerp7vz9dMYlFI13nekt8s1lkqeXdQuz7Su4c8
 1fRnKULibu8v/RH715WEGBdMNcWwhnI2WkSAQ/9E7JDsU92QpPmkwVshI1ATJbZf
X-Gm-Gg: AYBFou1hWWlGz4IZfdxBwjvSUGFc8fqNsr5DvieRMJ86F1MinPxn1c+240kTx2mdPoX
 BTknIJqp8x7AyzK7MCR0/cHeuhSuzFet50PntuDAVrCpJIuHhI0Z780ijye3Srx/eQVB/wszRls
 Vw33fHnv2ZAneF0pvcdwwNgR7BFHDGGGMfV991p3HxOwgXY+bHlfr+Bvv/nDh/U4yZD6bt5ZAZG
 rgLrUE6rNK6Q99UNvE1OMXIb4lEpHVk7LJvYaWN9MA9pRZHvgXmxftu7pUQ983lt2tebf2Ekruu
 M+E8tliAmjPpUbmlM/SDShd/uWcmM3S4TXNtw57b2M+rCLjSIe3TEBMDpN2hPzgFQrOWZ940u1g
 Q3XCgvUYab7NoBeY9Z1pB20sK5lCDqJQUcRNXg0bhELJ7vEM8tZu+shT80waziXIVF4DhG/NVMw
 omXS/bincz/rutRCjQ+bENflNk57zA1BeK3bKFvm4ktA4ES7XqgGSx+SDvh9j8qtJp4j/m7nD0v
 7GJCkAVaQdJiUwHCx2hJAK8eXUKRb9RPVBLMJnNl12JF6OgGXHJnVUcbsQDPg==
X-Received: by 2002:a05:7300:80ca:b0:369:e918:3c95 with SMTP id
 5a478bee46e88-369e9184604mr10740598eec.4.1792936596415; 
 Sun, 25 Oct 2026 06:56:36 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d845ddsm16795724eec.11.2026.10.25.06.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:56:36 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, waysorrypub@gmail.com
Subject: [PATCH v5 1/5] bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
Date: Sun, 25 Oct 2026 21:55:55 +0800
Message-ID: <20261025135559.236356-2-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025135559.236356-1-waysorrypub@gmail.com>
References: <20261025135559.236356-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=waysorrypub@gmail.com; helo=mail-dy1-x1333.google.com
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


