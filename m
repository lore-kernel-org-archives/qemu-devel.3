Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B27DE92722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 06:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaSyq-0006ow-JJ; Tue, 30 Dec 2025 01:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaSyj-0006na-LJ
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:13:10 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaSyi-00047c-6n
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:13:09 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7aa9be9f03aso7977364b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 22:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767075186; x=1767679986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttAWMQ0gKIkTdIzv8pg1GpC3gksBpHCGYQzy6KD8wSQ=;
 b=i9xOuOC/w7EG9UKUBwlK+hUEZNy4/HvQcQWuJR77n2XHfMKQ9YLKUtYFj/JZlwiujF
 YdDUvY6It4HukAK4Fj/pdEw2j/IYKA9PyJexcl9ZhZVG2PO4aYIPy1+ATGVNK6NMHE/g
 F7OAdHBRhIoWwhESTfDmsGFoxdaEt7F6ieTxSJ17fCfd/E1qUKX1kWMJTTx8J6YxU60I
 Dy51rxGw+j71r9aUYkdvpezQllQnfPtXIGb/hDdiIZe0vYaEY+wE+bvMcyiz+9/z7EEM
 F//wKbJEcydoqYQ3YybMGrb8BQCKVXWxXlJ/wZz5julXwkaG3e79pf+2l9Zkpuw44YF6
 ccgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767075186; x=1767679986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ttAWMQ0gKIkTdIzv8pg1GpC3gksBpHCGYQzy6KD8wSQ=;
 b=pKM1b6qlUpInFz8PzIfXhuvHjryehBVG0bLVpRonJuw1W5q3Ue63S6sHLXpGVKFPCr
 AS1nPN7js3PGhbANy76Av8DlKJ2+b1yVA27WjGIwrCJuhpyXEiPh/82HJ348v/1BJHuz
 oF4/H1woyBkkJ55T8X+b7J/dkjTTQI4p2Af6rLNCBmmxkQLMCsl0qWHTB8b+p7WTlj6c
 LKXVTItdllZwFJO7svJO0hGCeIIL1cn2b6zT235rvym0HL1tpLgPvg+/CFK8wDU0VKCE
 bEb4jcVvnYSVqrpW3QvxAOaQMCje13DPJYr83k/96vLCCrF1EV/O4Hfz0+DdU7fUhtyu
 gJWw==
X-Gm-Message-State: AOJu0Yw0D9WBepNtq1Y2sEIwf8/9b82T5+IVe4Bqn7dzcWN6df98hApG
 N5rS4vGFVCx404hPGAlNG9JxckuJke/+h4C2WxwAK802ElzND0MApMchu/M0NhzcJAZzKBS/md/
 sfOB7BYK4HkairrS+xlSndSI8VdAR9DZ8Lk4YmNuCqQN9i5EGbEwZDmq+RmTaxG3nlHynONbGX3
 49wGk6VDEyHhszfAV7QusfoW9I6NMcRLh5WxWS5KiLkZA=
X-Gm-Gg: AY/fxX5TIaAzSqKcCzkxL8+NppuogA3tijC2GfDE5OuJrgZkVV9Xns+43uRV7T54D9C
 mxZQ0oXeGEsDNIHmMFlZQ087SfKv8U039poYhLitTqeULUd2OMLX+PeHxSsPuu0UpJG3aDZumrS
 hXHLKr7gIqLpVBPdNLeU4fUQ9905wmVjh3irrCbxD0DJo5oFzE3uV/8kI/pR6rVCw2DLwYIuGGP
 jQaV1HYyhCos7KgBJCZINplY9sGWzKCrdyxiwvODL+Mjo4G8QJVT/Zeylui/C2rIs1hkfSmiD6B
 RHPUqDPWzrK5vf4VUqHz85ANAwEZz6zW81LQZSA8MEQ2SshYd38PcAM5Abg+zBylSMqAp+YGHGK
 jR4JPItQEYhouffG5Xxe9Sf1TEUOFZlgEc/XKfwTpnVcK8SGa+Ggt6b4RqPM8Cs1LAPrNwgfR/2
 mUVHV4rlVOYKfjRO0WSgPEs9cX1t19UlL5OGGdMrQPgaXXrRuxdQ==
X-Google-Smtp-Source: AGHT+IHrpYL3siDp414fDsuZY6VQkd0i1Z9w4nDaCN2zKgO6Bf/yVQsbA2hyAFBW0NMOzMyiNj3kvg==
X-Received: by 2002:a05:6a21:33a2:b0:366:14b0:4b02 with SMTP id
 adf61e73a8af0-376aa1e7c2dmr26394923637.62.1767075186401; 
 Mon, 29 Dec 2025 22:13:06 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e79a1778esm26960906a12.13.2025.12.29.22.13.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 22:13:06 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 1/2] target/riscv: Align pmp size to pmp-granularity
Date: Tue, 30 Dec 2025 14:12:57 +0800
Message-ID: <20251230061258.15596-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251230061258.15596-1-jay.chang@sifive.com>
References: <20251230061258.15596-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x433.google.com
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

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/pmp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..01b337f529 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -167,11 +167,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             uint8_t a_field = pmp_get_a_field(val);
             /*
              * When granularity g >= 1 (i.e., granularity > 4 bytes),
-             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
+             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
+             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
              */
             if ((riscv_cpu_cfg(env)->pmp_granularity >
                 MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
-                    return false;
+                    val |= PMP_AMATCH;
             }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
@@ -251,6 +252,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_NAPOT:
+        /* Align to pmp_granularity */
+        if (g >= 2) {
+            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);
+        }
+
         pmp_decode_napot(this_addr, &sa, &ea);
         break;
 
-- 
2.48.1


