Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF8ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqz-0006Eg-87; Tue, 13 Oct 2026 23:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqu-00065T-Lt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:28 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqt-0001dn-7W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:28 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cd5e2d696e0so355849a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949226; x=1792554026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CmyD6lY57V+HOwn6C0x+f/UFPrshUSJ5Ppnc/XtHel4=;
 b=B2WfLtd2ZBa+VcfqcL78uqylIybMi07IgY6r5xrhrwzBFOG+bDvuS8cazrSZkRLSeY
 eYQVcoQL6wLeup9C5FKmNe9PDpBX7vk8DwEDcAzN3Z6Wpp/p2OJcKrQKsjFf9niYxXk7
 /hN5My0ctDrrkNGmsUwCkHFFAztIVTsRi8ZWA2K6sjWK03jfkcwOpOU/tOl3zf6AVjhB
 HcGKTdKbhDTbTJdm6NUZ9EkD8t9szjiZ0/lZvqn+8u4COX9cnWt+yV1qEMUJBTL/Dvhi
 3ttgShvHPg8o5YyKnGgdYJWva9TIyD0TeR6IwXzvF4CpGdWjwsil1APXziJKiHmBKmbg
 bADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949226; x=1792554026;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CmyD6lY57V+HOwn6C0x+f/UFPrshUSJ5Ppnc/XtHel4=;
 b=lL0EyzX5yZwlWw8KbmCpI608BfKo5YH0zVvK4KxOkhm7+ezkabOU6raGMcjrF4eyUU
 ivg3wQ4I3Tz3Pdq+zguWYcraMsLeW0tkABK9+t+Sznf6DHJ2neP/7lXlfdWv4eUH4VxF
 0ogQ5zq8l+MPpbpQpKIFoTsHWILB8Cz031nlwo4LZUWDK0tyTcQwyNpcpIpnT5DRkvs/
 59DqZqwCBj2FUIEmmhMzlOJziTkGggV0cy7wIU7i57b3sYYJUw5EHrK6P5rV+pslQF+n
 KJalKbBxFkTzzrmZpX/Z9qIvLDBfldOWGzJY2gVQkIxId3yPL+n5qoZj/TYTPKQ+TH7a
 U1/A==
X-Gm-Message-State: AFq9FYJ0PzDCoj+bmVTsOQJtT16eLc9LAraGosNmnXrgQI4iUz5ilGV/
 TZ2BBN6nep01nJ/OgLK0f2CRcYyshGuZz54VCnMW53ZEy4OmPg/eYf6IFXOH1g==
X-Gm-Gg: AYBFou3hdK0/wAJhr8ITS6v4a5ztK2grR23p4I4Y1az3r7ZgOx3swPFj6pDcfOUqU9Y
 dZDPb9eNbWGlYWLm52gSfz1QJtafZOxMmSbAtWeq5yObpNkYZVvqY2LaHm/45Z2C5+EHO/2ZB2I
 6UnQCbb71ct5Xs8ZJhdpPs8jidetozox0gN6nERSop6toYC9QbSDwDJRLeKoCaMMEZGczakrUhT
 ayREv82PTRyM4H1tg0aTUTFempA5Hby/iuwuupPFgEJLKC4gSu6eXtNVbhi4RnJrUikgueLUAMP
 oTbTO6GGlUVUM44ggJl5XxEIopaDFgw4Bm2GeSW+flq7jEYNPRv878Ep/4fRJL1Uy3FlEjnuDQW
 R65MYXdPZUZt+hD99EUNe3sS4UGIr+dx0sCg5DJGgy0rEkx5OC5ICf+2qfwFMWvFCbSOuHaipI3
 V9VwUEGj193J0G9d08CPVU2l4MA6WJxEuIXTgF0qxTdbf0X0Ui3zWJx5+P/VOjBGJbs2qlLGz7W
 k1VdaBh7M6X9URl
X-Received: by 2002:a17:90b:50:b0:3a7:d9d9:b305 with SMTP id
 98e67ed59e1d1-3ab3acfd905mr11033358a91.52.1791949225909; 
 Tue, 13 Oct 2026 20:40:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/52] target/riscv: Document riscv_cpu_update_mip()
Date: Wed, 14 Oct 2026 13:38:36 +1000
Message-ID: <20261014033907.3332383-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-2-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5489c564ae..24b22032e1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -688,6 +688,20 @@ bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
+/**
+ * riscv_cpu_update_mip:
+ * @env: CPURISCVState
+ * @mask: Mask of the MIP bits to update
+ * @value: New values for the bits set in @mask.
+ *         Use BOOL_TO_MASK() for boolean values.
+ *
+ * Set or clear the Machine Interrupt Pending register (MIP)
+ * bits selected by @mask.
+ *
+ * Note: VSTIP is not maintained in MIP, so it is ignored here.
+ *
+ * Returns: the value of mip before the update.
+ */
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
-- 
2.55.0


