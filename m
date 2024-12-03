Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65A7E64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8d-0000PE-4N; Tue, 03 Dec 2024 06:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8R-0000BZ-Fx
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8P-0000Zu-Kh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4349fd77b33so44086345e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225524; x=1733830324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6jtl4bH2aw1ntBc/Q9c6zL2bli8TxIIjMRIPbMQt+E=;
 b=BW565gGQLSELBoMheP/JMpfHRO6JYKUxfRwoC2G6RZ2TqZcFI4OXd5kautigg4UZZK
 5nyqlkUn6NdEdgpOt8m7i2VLA4o8mK1WKU2y8xXcE0gYZR6yl+huiqWZ2uwDc1Ieok9C
 VhZoI9HnP9/wcbG1ulFlx17n/3sgaxZWZnmPdDfwy82ZLi+Lrn1kUVqx+y6a1A2FqoZJ
 mOvqX5Rc6WWnxrj5VN4IVf7XmndK8MgeidKFGw0mh+61CCaDU+iQMZNXnZspuAk3KY0i
 ST2KZNfFSM2LQSYFv4qMHdW7+V4qCMi8IzkxxPzy8xDvUNu0u/yx4Ni0fImpHS+rZlDU
 tdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225524; x=1733830324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6jtl4bH2aw1ntBc/Q9c6zL2bli8TxIIjMRIPbMQt+E=;
 b=MHD3G6iCNTNVqPqbFJjV5VkspTlgIkreokBqMCsg6lhckXHwQ4Wv2RCWKc8z11MBRZ
 nnzsS6uUHe8rZ7m8K9ubX7p45wei/tXPk2XPX4qkKWQv74WiWf2NqEMHtC1Io8qMJIIi
 jB7LuOWdeIcrPUovR8NQp76Kl84oIQ67dQn4nMaZlxpWh1zUFG+mN6yOVVzIpNIT3qXT
 wrVBGhZ1mHcmtlN9Judfh9aGY7xSWXBpjcBWXBujbjVFQyjJvTDk2iLOxw9vP4TWZGBH
 YjaSC7/QymAMqeD6gWyl4OiBrcj+UM4VSCOpPykWTQlSZNVVE/gDOr9mzf57wmLyhIwz
 XpjA==
X-Gm-Message-State: AOJu0YyuZXxKewd8qXE9dkBZf8v7OyLtcpVKZfpgWrhKJiZCOuNq0yro
 EAd2C7kC+Vz11FWFIiBGZNhrGEd0leSva1XBJFwvYVkjn4mfIbu1p8nKOSMZScT9KgZHVAYpnvy
 h2rI=
X-Gm-Gg: ASbGncuwfs4tEtOoktoizQt52+S1To8LrLmNMexR3ricNbC2ls/hWVvDpElvcUc9d8t
 eiOmI/oM5DQlCgRC78OvYJ2jtq1st9MXgXAwXa5wQljiI6V8jZXKlLsf/5+RIWgW9pmEkaiZiBJ
 SB5XBegTBYt3rz0VqIh58Prf4KU6lDTARBlVg7SjW6aagsrPBo2Hhl6nB9gbISqNE5VZ01LnyiD
 gB4OUsFa+AMEtSaQ8S3+tAoKIZnAKAeSPv40pAQKSNQXshUGcRwW/+4M1no5RhZne5maFD/
X-Google-Smtp-Source: AGHT+IGXp+Y1EQ2//qthmZhv5T8E0FY1fVEZ3aqTLN2cfHck2Lrsk3F1/bYv+QlLZ7N0L+0/FYnEFQ==
X-Received: by 2002:a05:600c:1553:b0:431:93dd:8e77 with SMTP id
 5b1f17b1804b1-434d0a16c18mr19991785e9.31.1733225523724; 
 Tue, 03 Dec 2024 03:32:03 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f70ea8sm191267755e9.40.2024.12.03.03.32.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/13] MAINTAINERS: add myself as the maintainer for LoongArch
 VirtMachine
Date: Tue,  3 Dec 2024 12:31:31 +0100
Message-ID: <20241203113140.63513-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Song Gao is will be sick leave for a long time, I apply for maintainer
for LoongArch Virt Machine during this period, LoongArch TCG keeps unchanged
since I am not familiar with it. The maintainer duty will transfer to him
after he comes back to work.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241112073714.1953481-1-maobibo@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1c4abed65..3d6194684f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1199,6 +1199,7 @@ LoongArch Machines
 ------------------
 Virt
 M: Song Gao <gaosong@loongson.cn>
+M: Bibo Mao <maobibo@loongson.cn>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: docs/system/loongarch/virt.rst
-- 
2.45.2


