Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E9C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 01:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1talwl-0001oG-9F; Wed, 22 Jan 2025 20:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1talwj-0001ng-Vw
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:23:50 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1talwi-0005Di-EN
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:23:49 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so677405a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 17:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737595427; x=1738200227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ckxcijDWQdo6hhk1+UnBUuMPGA0VrKDFuMLAdkxewA=;
 b=cORJUw7OjnWGu9RdCBRvLfnrcTChmaAtCyML1YnfyJh0owRIA9JIlpWk0RILcusr9Z
 Fts1n5otTNAuyk7pU9KBETPMXmq+ZjEThRrq8OZfiOLWNcfgTmyNOgwa/STXYdWFCynJ
 jnyRyS0ytV3g1hcRVVgsCq7Vh5PA415Q8bnMF+kC9067jU+4fvgLpT9Krlicyl+qd+76
 keRctkpszHR3VcUIOieyP0njW2lcTrnduYbNXLM6xcsZatsEG+xJsVY1Qlqa5yhuPnb8
 ODnrpI1j/I+VydXXTq8QQ9K7vT+n6JnLvmB+WHQX53VHbYhlJ9RkUWEhMi06LCMdK74i
 3j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737595427; x=1738200227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ckxcijDWQdo6hhk1+UnBUuMPGA0VrKDFuMLAdkxewA=;
 b=lH9wquV3MSzkqbkNYjZZbYQJSBj+oWlshYfAUiiXDcLGzrf3acpgz0hKu0BMQRhb9S
 NzPZ8wDaujeEuHdrLYGWF+G6/CpqRQYTOHq5uHTscY1nQl/1LEs9VlLYRrOZ0S9/OuUS
 6uf0FPYAPdWNHcPUuRN7P6ysbXHIv633WTkVQ6okk62pd+lFklNbeHeI8Y1Z8c5OsUfR
 CuT0XarZ10c3Bjq/+HEvR3Yctd21dA1sITne/aID0TxE/OWmt+F8986bQVQ6c3gwIGb2
 Ga1/OUncj5DHnKLahLCS28vOTytSFDczMVWq0lIrsFQgMCAFp5rtiXZc08ZWN1qQ5YyI
 xahw==
X-Gm-Message-State: AOJu0Yxpqvd7FAkUKudT+iRjSPMODqUL6qhFbOd9A7HgSwkMwJA4+1Bv
 PmZ0Jj2e7YkQ8cfXkN6q9/rfdhxIv7KHLomUB59fRKp2qLlSTRqaex/OhgBkvpnwLPYmrhUWxMy
 k
X-Gm-Gg: ASbGnctZ+FKaHZZPfa7c4iGuxJgK32TTG24fLOqBhyplZodtbyGumfMf83HwogC6Rsj
 QWD+e3iONAHNYsp5xIkbhEbO78Xz/yQBx/PfFLfkBlXe+GWS/sYXGHrHbslh3r7tSS6o5lOJ4xJ
 iiCj11l27gQjrH8iFRLAmb5kqUb+6mio1Mu2/Ifn3rxVGeA32cN9KncLNASvA7tJVCxUd7LR9Xz
 WnPkQVU+8dfku0xt6Dey3QFstRenIYgubnLyw6bq1w/fHgG39i2iKhPNrES90Um3RyZU6bmUB1O
 S9mdkOpi0cM=
X-Google-Smtp-Source: AGHT+IEGYIhRBjtfQUh9QzAErpvDSdHFC0wzxIdPHI/SEUQGGnH6bTB2FI9vM3oUENz3MS/tele/Aw==
X-Received: by 2002:a17:90a:f947:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-2f7f176b184mr2461471a91.8.1737595426808; 
 Wed, 22 Jan 2025 17:23:46 -0800 (PST)
Received: from gromero0.. ([191.205.214.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7e6a5e389sm2498793a91.4.2025.01.22.17.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 17:23:46 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org,
	armbru@redhat.com
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 2/2] MAINTAINERS: Add me as the maintainer for ivshmem-pci
Date: Thu, 23 Jan 2025 01:22:12 +0000
Message-Id: <20250123012212.716499-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123012212.716499-1-gustavo.romero@linaro.org>
References: <20250123012212.716499-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102a.google.com
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

Add me as the maintainer for the ivshmem-pci device and for the ivshmem
server and client tool.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 846b81e3ec..8327ce9c79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2789,12 +2789,19 @@ F: hw/hyperv/hv-balloon*.h
 F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
-ivshmem-flat
+ivshmem
 M: Gustavo Romero <gustavo.romero@linaro.org>
 S: Maintained
+F: hw/misc/ivshmem-pci.c
 F: hw/misc/ivshmem-flat.c
+F: include/hw/misc/ivshmem-pci.h
 F: include/hw/misc/ivshmem-flat.h
+F: docs/system/devices/ivshmem-pci.rst
 F: docs/system/devices/ivshmem-flat.rst
+F: docs/specs/ivshmem-spec.rst
+F: tests/qtest/ivshmem-test.c
+F: contrib/ivshmem-client/
+F: contrib/ivshmem-server/
 
 Subsystems
 ----------
-- 
2.34.1


