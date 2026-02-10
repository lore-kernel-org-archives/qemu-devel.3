Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4B6EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoA6-0001z8-Ba; Tue, 10 Feb 2026 08:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA4-0001wl-Ch
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA2-0006K1-ST
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so43254925e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731533; x=1771336333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R0wmLJLjqxq45RUQOtCvknbHxTskZboCDzivlPkD7iw=;
 b=cuYQPKXrroVjzJB4EEjENiwP0GT2YgVFjkJuyh/k4Oie3cGYofIHM8dj5ksaGn2FGa
 /At1sl9SN9HnR/h4/3vyDi+Qzf1SQ9xcIqFPczMa/nhnhOwEOeB+jYsMnntAPvqO982q
 diDYMb/G1eSW1xi6sqOp2xwniVC0y3JyqyfwdWOl5BJeX6b+k5dxoHS+qJ1V2YejczhP
 uj1CXPqrAqmFJ4KgOpypYMxdZzcJ4fpXfT8LL5kWKwlxleXvDKQwytsceq1IJO5xA+G6
 zqnyUSP885iQZvApm6YFjIi/+Te+4DPkppZCr0Vn3n7fKHasxghmu7Qmzm4gh6h65tXa
 VXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731533; x=1771336333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R0wmLJLjqxq45RUQOtCvknbHxTskZboCDzivlPkD7iw=;
 b=F7Fhdm50nY4JQ1RCwsAPohVjO8c2nqZOQoHtknRxQEkWwWwoznEXwns9LlMsUvMf/+
 v0CW2adwhB741gdB7SgSfFbqLcLs2Mns3EWYct6ZBSazxEbkdXpftyKf7FwDK9QJGm6e
 jiePp+pU41IRRM8u7KiFaxRhbEMF7NGIgnNA3IDlLWd8ChegfWIbyI9tgOCzYPxxdegD
 lI7/yN+XMzYVnxjKrn5BXDCTKLbFwBXgich8jqyJYVWFHZfjVLZvMRS5pv/Fr0IOiD0y
 KkUxLL4g6uajfiYfn0mvFJwSDzYjzLaslXFlcmm1xc7h5EMbr3BD70hTYEPliLXh/SOY
 2Y3g==
X-Gm-Message-State: AOJu0YxLoOx+JvOSFSlSWWM2PGwqCLoe3DDuljnA171ycKmzg28LATG4
 ZIMfzH54uPHZe1evx+9TSQrtjRX72+9PWJlUMdQXsSTJtxyP59jJSHZYnRh9nKV9ksLnVzmjADp
 697s8
X-Gm-Gg: AZuq6aJ7SgQ3y+E32UO/rQ8cg5F7Vx/CYg++rpCeJHLpcCJ9u7n0rx67liQEGlH3Rsx
 IOtINqCDOO92QLh8aZELe9We4Hl7Bd2Mc2foTx24zhF6jbFm+uZTtYr0e7GwExTfLZkHZY6yEj7
 yX6iqYafDyRYoRrF0lNDvqabn6Nn/qGJKbtQ/2s8emCuM+3702DUyvwJ7p7AMEB4LmS5oQcXmaS
 ymcHnWbPMFKdS/mI+3wLSUh6A9j1dOs0UIBkRq2+n1tZkP1po/7ORRYPeHg+rOZwDTSCMdd0aoP
 eZABhacOonr6dPcEkjIiYjJcdtqli7SOKc0LLkfgJffKBW2eVdubUslvwp2ZNXViuy79GEQCFCE
 lqLrM5rWuZ56WApfC98FNxe5uZdiG9iaV9XP0IrRcmfHkr1cBddwKMYhmPI0Ga6aogyohJQkkT2
 UwKkE2fcML8vDyD/Fx6nk0p2esG12r0e/EmA3mbhB0cFEmjXK8BMHCaghpiqLR7V/UXhsT08iTy
 67kpUSzWai8VhrHT7C6MPPrmjotahU=
X-Received: by 2002:a05:600c:1548:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-483507cff93mr33300125e9.8.1770731532886; 
 Tue, 10 Feb 2026 05:52:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] qtest: hw/arm: virt: add ACPI tables for new GICv3 +
 GICv2m test case
Date: Tue, 10 Feb 2026 13:51:46 +0000
Message-ID: <20260210135206.229528-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m | Bin 0 -> 188 bytes
 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m | Bin 0 -> 172 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m

diff --git a/tests/data/acpi/aarch64/virt/APIC.msi_gicv2m b/tests/data/acpi/aarch64/virt/APIC.msi_gicv2m
new file mode 100644
index 0000000000000000000000000000000000000000..16a01a17c0af605daf64f3cd2de3572be9e60cab
GIT binary patch
literal 188
zcmZ<^@O0k8z`(#_;N<V@5v<@85#X!<1dKp25F13p0FMNW#lQh$F#{Rg0Wcl|15CX*
dLWpD*p8!Y;7u1e#47_lAnZRNoI~*7S7y#H%2>}2A

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.msi_gicv2m b/tests/data/acpi/aarch64/virt/IORT.msi_gicv2m
new file mode 100644
index 0000000000000000000000000000000000000000..0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3
GIT binary patch
literal 172
zcmebD4+>esz`(#d)yd!4BUr&HBEVSz2pEB4AU23*0%8Lo1_2fq1{MelMzV5(SRi%i
nAPXpv4aB)XoP#9EWWm4;QV+r^P#Q=v12GslK<WQb8fG^DHhT*J

literal 0
HcmV?d00001

-- 
2.43.0


