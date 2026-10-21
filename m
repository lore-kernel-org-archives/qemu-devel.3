Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727A606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PyojJssh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWla-0006zt-NA; Wed, 21 Oct 2026 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWlN-0006yS-KS
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:53:55 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWlL-0007f6-S8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:53:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e915887d9dso4374285ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792590830; x=1793195630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=PyojJsshnfjXl81xYZO2gYYb2/BTDUPVpK6sEbZ1im/LhrmnXYVzFLMjxmhY36RM/9
 TptPc2BF3oLZxb62OGpb4JRTj5WgvPTp7kq0gDKHl3CQ+zDXjW4XDjqifevbv6uhRFWH
 F0Lg6OIlRAQRLVNxkblZImnSVCCmYyDmcXleofxOvkxpqi1hCyT8Olkw4jI05MyrwUOy
 DgzhvqdY7tBbFAHgtIuJ4/iIxC5+E7IAeJkwUiJMMtcptIlZi9C/jzOenBZAXXp36359
 WunEOaoReEvxJbAQGXL8v0Hm3zT6ge5YueTNWI35t+Hl477VWVMMyH5BFGmojRaAPP/G
 rbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792590830; x=1793195630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVH0gvdLy7zbg+V54YHJIXHcOybC0qqa8Ry38RS5x9Q=;
 b=ChnQ0xcPylRwZPhJ62A65UQaUbD0Et6jhIu6zSkng4miDPQ1ccCdx+NU2KEzAdI7Cp
 sHWMsSOjCgtJ8bwCwIdoytc6gsKK1g18pY2GbDmiDCSqLLu+t1yvB8TfwD+YVb8BlxPf
 CCT3kO9OQP9Nt2017oFZEFQGpfJbpLDjzR7GN7teZPTOKivNhyYikO9qirWr0Sxaey9k
 1/rJkz4xzuBYMasp7BJtlKj8tAgheoBhpNth810hYA6q/oynll0zDzbmlTz1qPp9FyRq
 2TDqKmI0+ntJAUuNBJ2IMXgszk2NieoKwysCZ4Lh2HbnI2uL9Dae1wlITGnmoR4kbOGl
 Id/w==
X-Gm-Message-State: AFq9FYJvON4NXTveWIPWs0xZ2Z083ZHPWBWiHgVt5kuYxAOBSiPifk/2
 /OwrdXsMDm5wNidUsecPAyQUdaO3QKRYNLiImdoGZycil8GNOZ+Dki+tqr/3QBcssPwDsg==
X-Gm-Gg: AYBFou3hjD0e4Z23ZoqsEbJPhTRaBNG9mWcJ3vQEHX/AzG9hcxkOECj9ewhAP1iR7Fl
 MxvwIr1M/eB4BBf/FVonENJaijXKXxJh54KbIKAHe17mUdY1R8QS2rPmHs4IHf0YrD/VcLbM77d
 g1OMu8YDLQibz0948Mq40uG7wbM126IER96olPQPAM3jxyddDp3KTqsFjQlfmXeD0z719bjwPU4
 UdR2zWEwZVOBJ2ThgVFJcImjjgW73fy6IbH5oF0A3E0Js/B19nB6bnxjFx6zJX41CmSMJPVf7+F
 ZoTCd0DaXYal/HLVswBOAaalYAzFOyt3QUBy+xDJQaYR/IbFsWoJ6imiLKb/pR/pHMJ4s49tj9I
 pE/IISfJ4oh+u40NTE3IEqsUFINai3OTD0kmhkxD+V4FHEuO13RaGOxCOKztOkahkcJETmJpGmi
 CcmFNWWvsL7OPU9ONpCKSTHJz4scSQl49HkiFsOqV98AjB2KNFnjBd9XPYg5QC+30/u8WPuQrXd
 twulgol9SZQLXr7o7u1305KbeOBrADwaOB4kYnKUxZsWM56YF4OeWZtsRIOMAg0YS3yaqfFdN53
 y7WRrQ==
X-Received: by 2002:a17:902:ce8a:b0:2e9:5eee:e078 with SMTP id
 d9443c01a7336-2ea439a23d9mr15788125ad.3.1792590830138; 
 Wed, 21 Oct 2026 06:53:50 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b49caa7sm11865135ad.69.2026.10.21.06.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:53:49 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v3 1/3] bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
Date: Wed, 21 Oct 2026 21:53:20 +0800
Message-ID: <20261021135322.473781-2-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021135322.473781-1-waysorrypub@gmail.com>
References: <20261021135322.473781-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=waysorrypub@gmail.com; helo=mail-pl1-x630.google.com
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


