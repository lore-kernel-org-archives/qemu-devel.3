Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8337ED3CCAE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFNh-0001y4-PD; Wed, 14 Jan 2026 23:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNg-0001v7-0h
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:48 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNe-00072I-CS
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:47 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81f4c0e2b42so285897b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 20:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768452885; x=1769057685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZnaNNsZCNmN4jqFYzbrceDrs1tItqnZdPNYCcrgRIU=;
 b=dd+czx1Sbzn6VZVF6IdYXez1TaguCWq0sHZ1vf6RmmnPpm9IIUlEpofxXD8OJTOk95
 AjccPa+s/msB+pXGKga6KByBOvFP1dhXJQvpwXrrTPcsieoDY6RaeddO01E+iavdfHvH
 icPuSC1MUjZmOJ3Az/nQOsxI5/SpkJmPLDNWdTjSbieatdrOnUFWzkAlId/TLnWQr2Zm
 HnVHmtmbrg4LE8w+ORQFoGp/2f66GWvmFTKgVIQ2j6lpaTu7ktURnsfCz+rI+OYd7zY5
 Tf56BjQprsPMeMdlQgwi8Q9eMSOaucS55c4mxw4Yn6o2lpEBDw6UTcojuDpHE+SJYZ2x
 nteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768452885; x=1769057685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZnaNNsZCNmN4jqFYzbrceDrs1tItqnZdPNYCcrgRIU=;
 b=XJHVsEfyXUEknXzoHr7eKnxA3To30VS9u2ODg6HHa5XxDIu1caN28S4q/2lFHxwmoh
 yxY4fPYkk0b7zgcMlefkleWT7544jxUAMBzsKCm/7qdTDRURsjNF+M75enmtCNi7CU77
 Tx+hRKB1CF61OJnvI0rp08C5adjGMoR4eXK4loYUS9Hm7vFHVmZYlY1v5Rkjn7RfkUdy
 UixIVwrvI83wgYe9KkL9tjN6ymu50A3f+BFef0zHYkQClZr5FlK9Pu+Loe9O54p0TdQ/
 jTPCkBKBCAMJIdJ+EGq48MqHgeJUqVLalSKGFV0y7sb2Nm1BMpao+CNqdK55iFTnKlNE
 G4Yg==
X-Gm-Message-State: AOJu0YyH8YNgO510dMf8ORZMY7B8P5l81rYbc9/MnT481xlr5bqjefez
 gYcNTHwGtIDQ+5PY8Y3b2J7YJoOReLBVlD/lps25YE+jwCEMutOVZVutyh2MXQ==
X-Gm-Gg: AY/fxX7tRsLahMtbA62GcEAkbuKs8uzYbRC8lL2BJZHk14qSC17eXNadegZNm6mN432
 rYv2MqNSajXzyaBzPP0/3eZCK7TSXrc7uRd3GpoiJCiRcEzMID2MLOHpd4rRda3waBbudWzp8bp
 +jMoSZhNQCPyAalnkWvpmFsy9roOIFfO+9UoW56T2RTO3SNtgkLxGErxNS6VVJFI0D877//VJkh
 2Zop/V/6xtFEXNnoDubvSfNy50lPgWx/duRA6XOs52V/PepOD+41UL9L+WYqB7QlPX4Jvolkfg6
 VlQhRwyVmGhsDN7P+oGP+avuorTboMrnFYqZat9fscV04O7EQyRLEzFCjsv0ZA/soAl22QmMwbu
 Wd36cdc1cEM8Np6JnlZ+FyAPkUpGiH3y+Eq6qfQ7em124rC8melyWLB5SkynQU2GUq6xi5AblyC
 Lm19A7W8nNCQaxKg==
X-Received: by 2002:a05:6a00:ab84:b0:81f:5acb:55eb with SMTP id
 d2e1a72fcca58-81f81d1356emr5342454b3a.6.1768452884570; 
 Wed, 14 Jan 2026 20:54:44 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f8e4b4110sm1141426b3a.10.2026.01.14.20.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 20:54:44 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PULL 1/3] hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
Date: Thu, 15 Jan 2026 13:53:59 +0900
Message-ID: <a508208eda9711c8779ce4fbab28c98999e628d6.1768452598.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768452598.git.jeuk20.kim@samsung.com>
References: <cover.1768452598.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The UFS spec defines the PRDT data byte count as an 18-bit field. This
commit masks the value to the lower 18 bits to prevent incorrect
transfer lengths and ensure compliance.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index cab42ae7b6..4ee6755d82 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -224,7 +224,8 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
 
     for (uint16_t i = 0; i < prdt_len; ++i) {
         hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
-        uint32_t data_byte_count = le32_to_cpu(prd_entries[i].size) + 1;
+        uint32_t data_byte_count =
+            le32_to_cpu(prd_entries[i].size & 0x3ffff) + 1;
         qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
         req->data_len += data_byte_count;
     }
-- 
2.43.0


