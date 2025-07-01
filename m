Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FC9C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 03:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWREZ-00008I-9S; Mon, 30 Jun 2025 23:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uWREX-00007o-EP
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:00:33 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uWREU-0003Qi-1w
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:00:32 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b31befde0a0so2086733a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751338827; x=1751943627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=09T3gmmeyGsvjs49fw1aTdoC45ArchSQcXEFw8JXLXs=;
 b=YqZtdBhtk0vDpqrpLXQHcfuT+gSl4Kz8Z/LM0i0ktweOBqQ8wuG2lv67VuLePPNEzn
 MT0pmO49xLGojwQ01ikZ8JTYbIafyvY+G8GxRkYOlQb3nFDmdlYluCBnSKzbNgRF6fr1
 Y4iLnszAVD+eoEVMmchXODZUoEg+MVBK/0i9xxvTXQN2hWZ3/AyPrldut2CUMdtOXQkx
 +Gyv4vslfB+CitAjTftvlGaI1b5pkCF2k84i3EVZznAlfVp15E5PqeuXj5yfPsBLG8ZK
 Vsur0fhfLA6PbHVGLNUGLfGPWjuZAlTMsLQc+w/sXqZGCJJpLgbgPVoRqomXC5QM4ebB
 A4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751338827; x=1751943627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09T3gmmeyGsvjs49fw1aTdoC45ArchSQcXEFw8JXLXs=;
 b=kpKila0gTJe7tRKSdiXIT1aH+4ihl44EU/nLLLw4X6MKQM7NYAnPgu37KNSsvWm/OA
 qC8J10SsXSyTkUCIgJMbtj/wuOCNf6E/4nw/UpD02+7v47jxliB89LveZ1NA7mL+vljH
 kYBX8aXY33XH9Mmwa4LwU7RJ693jaOf4hvKdcfFZfIsHL56MIMIkThcT5zh7yFkVO3SB
 Ozm1xwSsO7ROU6oZBhz6j9RnRf0MxXhl5PnDIlii2Y6UjyMf2btOIlh0mNAJunAkzMjC
 UlYkSKZ7A3q3PGHuBXQ+mVqopsu48nb0QAsgBQivDKRoWvSECVPxSDia8kuu2lzoDT6u
 AUZw==
X-Gm-Message-State: AOJu0YzKXa2eva+TD6+EZBh83YhF8fSJ4BKLNOeM1MxAfiaHRnNmPMIS
 eeuiNsd8EIOD+E/qzQjMfmysjtaeG9r0ffTLm7pTu4vJMHNX96KhyjYEzrLEeDxYoksVbEHnejQ
 h2hHBLOGZgbiBPBp8dmtDlKZ9fnqqfY+0qPTovWahtsdQoA207v9agpBAlJNYVKnhU11ny20gQ0
 51ZjSU4bsSA3Qvt5bRMCXWV/GsjzlqZ+OiDz2QH0/1qTM=
X-Gm-Gg: ASbGncu0pVT5eLPTBlvEZo8nvGsuzeC7qCOlqls/nrXv0w9+eZlDXdr9vY9fDqR8PSO
 TtTMQYNSE/rzook/YtSPY0lwtUEHKLCYYnVP33ZD3MPOechCi1Qx2zX/LN0w7/3LxYv03yq9myb
 Nis+YDtGToqEHVuvri3sFSipT+JPl+KKX8olwMjGeQ6K5e389AY+Yn3POytJvJGRCucNpPrTiyN
 VrUBGCfhwtqOLfoab+lM0cFqigkjmlvzsFcnsHwT+NtWjlg02EscPYJ1qOnYC4PxVfDubZM2+5d
 Aj0rt9SGrQKdqW9BcHe0QnCp8Py7FBXne44laU7hXor6xVysKDutwXfmnFsqcORiZyOvCWh69rN
 sk7cZeOfOk6sPtGNl49l42UOG2FoBPsv2uO7+
X-Google-Smtp-Source: AGHT+IE/jEoUqAMn6Lz386foTYdgGAibufSL9spHHSfOoBmWv970KTMMt8zmsG8PFycg6Ewayc11/w==
X-Received: by 2002:a17:902:da84:b0:234:d431:ec6e with SMTP id
 d9443c01a7336-23ac3dec2ecmr196693695ad.3.1751338827085; 
 Mon, 30 Jun 2025 20:00:27 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3bf1f6sm95966565ad.204.2025.06.30.20.00.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 20:00:26 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v3 0/2] Add S-mode checks for delegation-related CSRs
Date: Tue,  1 Jul 2025 11:00:19 +0800
Message-ID: <20250701030021.99218-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x531.google.com
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

Patch 1 adds a predicate to restrict access to "medeleg, mideleg, and 
medelegh" to harts that support S-mode. 

Patch 2 adds a privilege check for the "midelegh" CSR, which is defined by 
the AIA extension and only valid when Smaia is supported. This is enforced 
via an updated predicate in aia_smode32. 

Change log:
  V3:
    * Add cover letter

Jay Chang (2):
  target/riscv: Restrict mideleg/medeleg/medelegh access to S-mode harts
  target/riscv: Restrict midelegh access to S-mode harts

 target/riscv/csr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.48.1


