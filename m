Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B6C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26Nm-0005JL-4s; Tue, 08 Apr 2025 06:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NS-0005CE-0B
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NO-0008Rz-Bo
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso5125397b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108815; x=1744713615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3kIK3SPZ+6nNlN6c3rIDoA+sKT5kyUnVw4pY5gTecA=;
 b=BC3TBEVMoVoCxfCPlfSC1TPQukR+bh4D5h/JiJa/P95gfhkbuAHon2I0N+SASs+YMZ
 Ot74hJzTHdMswTCXgzf+HENR/cshyzoubLQUI7RXY07mWX5hgS2Bz7danIkOtKlF7vV7
 UfJDWweNOBWi/DhtzZNhR0Wf9yz9gCwGVFgaMuXvIY/G7gJksndjLfEtuYNOvtEhoYn7
 znD6TLonBKhtRZ4qF5Ag0N3SbvUmMdjMZTMmgwMKNhYepRJNsTDZ+rDjyElR+XDnKnna
 QOrIrkivq9DrRdDpVSXXsWZ6JqDDf6RHPyxm7Z8P/yWyIrBTkQbSfz0voC/iM1g5KRf9
 adyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108815; x=1744713615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3kIK3SPZ+6nNlN6c3rIDoA+sKT5kyUnVw4pY5gTecA=;
 b=ITgd6bKGreU2HMH+9AohCN7cVAFfcM1sIzF6PfZrFplBObN8nBgQaURGVeI3TIQ+Lo
 Q+ORHs/pHdaMy17/+jhiXD3teCav4HqkpjXQCfihfJPqFE7xfJoG+346I1WW1andk5t4
 Dl5csk8wBZMHdwQbMYYg4/MuH5t8fXyl+gVOq3/HkVlhaY214fTia+DopydunK9InxCI
 vBLMH14I1UA+C/dGP5ejaOaUtR2kYYZVTppNfbj28+3qvQsYyNjPvZk3b8CI37ISQ3Y5
 LQ5MaRA5OttCg54gWz2DOyoNYTTdFVoIdWpMBviMkAoPQXN2iH38eRaSG0NJoGMFgP07
 2llw==
X-Gm-Message-State: AOJu0YwCZXk8GMfN3OHgija79dfUzdau5THjvbd5Aqbr/2/gJuUMF3+g
 FxfAndd3XeeUbCJKg+1BtkrqL4FEKYHpOY3TQ+KczaTHj2dzlrdibWkksu3gBVZGcw2rB3l6lTR
 aSz2Lg4OxeUDCCJ4FJ8djVnxw40O60qM/W0zoz6yQO45x3Nh7sIRKLeAc8tX/Wir8Oy+rqX4nxa
 4K02Qptp4tc8d/1z7k3MPQnDpdN1DvLDexCt2lDtDf
X-Gm-Gg: ASbGncsd5yzPLh9ioM19qOWbRUQZTJOFDE1vDGIkskq7CN/ZUUX7rhXEkMYw3BKJX71
 vJTMBUNd5+VQa7IVeuHu/nu7cUIPFphoMMG8BUeYqlqRWFqGZJG0oSrIDwtzwXmh+cgkAzal6kB
 +N4LeN0+GdQpsTrmCxDDNaMuCKImYHIPYCimxovPTHgYYu5VQpxEYnXl962QaqR1ADbyHG5rjRy
 iMx9zBZZwdgmD8NUopNRgXCzw6Vozqx6D3FqsADHpB7fzMa5dqxWLkfni6zhdxH1APiEwXyOFqN
 /MpsM3dxJy6RrJS8bGEWt/KFSExI5KQlkwj3622HOxy9J1kk8qhNA7xovrkFZ9ZakUVaSjExEsd
 XviowVkIO+aYhQQ==
X-Google-Smtp-Source: AGHT+IEvXWo0yvhk+JuMdsMB12/7jA6+6BVDdPzs0RuQQNvt3QjtzG+5W8qnFslMuCKwj2Wl79E1UA==
X-Received: by 2002:a05:6a00:390a:b0:736:53bc:f1ab with SMTP id
 d2e1a72fcca58-739e4b49b9emr25589340b3a.12.1744108815396; 
 Tue, 08 Apr 2025 03:40:15 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:40:15 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 09/10] target/riscv: rvv: Apply vext_check_input_eew to
 vector indexed load/store instructions
Date: Tue,  8 Apr 2025 18:39:37 +0800
Message-ID: <20250408103938.3623486-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408103938.3623486-1-max.chou@sifive.com>
References: <20250408103938.3623486-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42f.google.com
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

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2d067a59e27..445a0b72a56 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1043,7 +1043,8 @@ static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew);
+           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew) &&
+           vext_check_input_eew(s, -1, 0, a->rs2, eew, a->vm);
 }
 
 GEN_VEXT_TRANS(vlxei8_v,  MO_8,  rnfvm, ld_index_op, ld_index_check)
@@ -1095,7 +1096,8 @@ static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew);
+           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew) &&
+           vext_check_input_eew(s, a->rd, s->sew, a->rs2, eew, a->vm);
 }
 
 GEN_VEXT_TRANS(vsxei8_v,  MO_8,  rnfvm, st_index_op, st_index_check)
-- 
2.43.0


