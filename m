Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5742CCF3198
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsH4-0005go-BO; Wed, 02 Oct 2024 01:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGu-0005cw-NZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGm-0004r5-Cs
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b7259be6fso35678315ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848286; x=1728453086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hbikr594/iimyg8M1wgRy/vgwVnLu0o4ezc5WEdg1Rw=;
 b=TIzsLXiIaob/nZ5d6rlgbri+dwA7GzP9sfXfU2l5BynsDdNBcOc8vhc6vI/QyD+3Nd
 F+0p3+lJSTSFueouEgIX4ZkzBJxjr8i88SnhKtM2ngO2Ee+0mcs/nVHdIRNlTCewxBOS
 E0vHYyDkDL/JSwdW8hkg9FygKgsERzXEiPA48mCX5RPsImfouRUhtxAiU4laopo9/nGd
 FjJTIkLHnqgpUfoYdJwblpX5F3K7NvXvRE9sL1IlAA39pW2adxMH2VFIdm9A5kswD9H6
 6udWwo4q3sG7lBfBKPiKaUzgUqrJYB4Bx07jaIcGEMuIIavEeGchAa8attITMxgepOUV
 ifwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848286; x=1728453086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hbikr594/iimyg8M1wgRy/vgwVnLu0o4ezc5WEdg1Rw=;
 b=qscKvZM6xqU28GR0gT4oKXMcSeeVmQWwUTnZ/TUTgxodklQokrOEA8XFc6lTA636h9
 l/TSdQ9CD088nm3xSnTcStRA+6TQomb7zUsWni5YArvKFSmiY3FVpsMSn/Mp8njSaTfK
 pBX35D9nxcPh5+QxoCs5pDRKwEK4Q5paSg4PpAwBJi9RwG7YtJuZN3sdQhCvcI40uJ1u
 EzscXwAgwgo5hMJi+G72hF80sD8PpirVzN/O2Bhe3ZWJz3TfUATyIeb1yV8uaVFPwSdF
 lrn/NDe6L+738Xntg5IGheA0pN601CvB8jUy/AppEtH7feHG4KoVp6Q0txHN4SICWV2D
 bNZA==
X-Gm-Message-State: AOJu0YyIJdyjdCC4vG1v2/OHZSo+v9uBFe3CCkgg6uzETney8efkICrK
 17eCrrSaLb8d8QhfcoBb6xz/gvg2sOUr+j2MR/pZfJmz4r945/syqZone5i8
X-Google-Smtp-Source: AGHT+IE2o5t/gBELdsspKeF4CAb9mEzS5ksRNPFlwIS8NtWQMLUkTuAWJIGBiBYx9XLERXhgL7tIgQ==
X-Received: by 2002:a17:902:c40e:b0:207:4c7c:743b with SMTP id
 d9443c01a7336-20bc54c2b37mr33355035ad.0.1727848285759; 
 Tue, 01 Oct 2024 22:51:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 09/35] target/riscv: Stop timer with infinite timecmp
Date: Wed,  2 Oct 2024 15:50:22 +1000
Message-ID: <20241002055048.556083-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

While the spec doesn't state it, setting timecmp to UINT64_MAX is
another way to stop a timer, as it's considered setting the next
timer event to occur at infinity. And, even if the time CSR does
eventually reach UINT64_MAX, the very next tick will bring it back to
zero, once again less than timecmp. For this reason
riscv_timer_write_timecmp() special cases UINT64_MAX. However, if a
previously set timecmp has not yet expired, then setting timecmp to
UINT64_MAX to disable / stop it would not work, as the special case
left the previous QEMU timer active, which would then still deliver
an interrupt at that previous timecmp time. Ensure the stopped timer
will not still deliver an interrupt by also deleting the QEMU timer
in the UINT64_MAX special case.

Fixes: ae0edf2188b3 ("target/riscv: No need to re-start QEMU timer when timecmp == UINT64_MAX")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240829084002.1805006-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 8d245bed3a..bc0d9a0c4c 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -92,6 +92,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
      * equals UINT64_MAX.
      */
     if (timecmp == UINT64_MAX) {
+        timer_del(timer);
         return;
     }
 
-- 
2.46.2


