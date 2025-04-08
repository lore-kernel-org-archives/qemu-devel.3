Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EB2C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26Nl-0005IO-D5; Tue, 08 Apr 2025 06:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NM-00058e-9O
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NI-0008P0-At
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:14 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so4532236b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108810; x=1744713610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84Pg5k3kPb6VBRYPhaykRy/0d1WngbDRO9uptt6t9xc=;
 b=hlTXeGkpYNSqpMyRFV+LBTGtRHCJKZwiXeToiIo79gHC14YoLn4zL4SeOj34N4gWwr
 15iTw4ZzLf6LYv12PgVvqw5X3b6c+DR+nJhrIYuSJcq4Izsn6luFIQdMMH1NGdDtLM1J
 CniMYapfUIp45gP5jNru75ACH6+TNrkJxUEsox5VPNfUxae65J1OdY0MFRyd9kv1pV4l
 PhilNGEOyFAL+gT4pMlnjws46/kjRy5hoERmKUj2oEyfuT+uQRS8BW0tSoZqTG2mIFbK
 Wi4PSh0DBxlrzIRohB2kPRtcCpfGM70APV856DlatDbQWdQ/BfDeQxApGf140n9TTCOK
 gKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108810; x=1744713610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84Pg5k3kPb6VBRYPhaykRy/0d1WngbDRO9uptt6t9xc=;
 b=vAJGD1tok6LZg9Db4m7fss3+Aj1KceVKiT2Nr7Yog9//TDQ9APLRkxWwmR7zJztezM
 UJXE7jej4Dt8g+0XgGoe87+1hdu1XmCWDNbTL4sm6pVGYMRScM3UsgcTs7W9NhRn1pkj
 S8ZB+5+M0bR2dvi+m3lDaiTWBGXB+tZyBOEp0AqYjeLY/MoVUPNt7lmBId3uuGxmIIOo
 OmBwUpnH/XxJwbmdHGlUb+35kT3l0Rmwm1L7bkW9UO5C9EOqS8BoHhx8OejpiIBxu0pZ
 cziAGDHwEZPLZHMPAflS6TYMqbsVCMCiS4an0ue4SFa3TUaa1UEGWioWCpsBKmnmyX4o
 WfhQ==
X-Gm-Message-State: AOJu0YzHhShg35Wvx5ryDlrjqsEzKKBcdXMqRuEvJ8TCh5Kn8/b/isFA
 1H0X2x27blCpLOMn8ekgobFT/S885GLZAYEBhpJk+8CMT0jSWWIN4ryVu22aSKq29lybPc4XeeL
 +G8V7dpCIktb8iPyJAQXtIVWlmo2qmrALnh2RDvWGTi22kB5qHOl2qFhz8f6J194aRkL8hE4xkQ
 yGn0kKjDjDjgEHsTwMtZiFlKcLpAx9kA+xylxiVfJ4
X-Gm-Gg: ASbGnctcPHROJCSUj3NVIomE6kW4NNNsEHTD2JU1XVYGYufA8Y4ihyaSq120sPOohK0
 S699fP1BA9v88Fl3N6XcbrFXeVnYb5X9DdCWlrZCUjblcaqNUhkJseiFhpX3Dv3FNwa7xyl2VVe
 HRCyXkY5UzdafmZ3JW+qcnGeNAEzv0CH3UVM7C2aEM/iDnqysQXmX5DO6gXasrPexmUycqJefZ3
 4mJOAxmOG4CiATnGLazXZuBga3VcX5HlPGd+v8hNDS6gZGerGj8FmxeDw3+Uzms+8h7GoUXcs3B
 T4iK5Jeh2CHogY+E9Ro8CseQNvXRTF003Q+kTxKD8ox2/B2/gcbysJmPBByO28fluRcev2J50Fw
 jV05edQypr4fRkGzJWAEo8Jk7
X-Google-Smtp-Source: AGHT+IFpxYO2IFaR+qPHNH7Z4lLWj2vAu5tw9/cjl1s4saae+CveOumJ4nWjuDInHApMDECs44tcgg==
X-Received: by 2002:a05:6a00:2285:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-739e71403c1mr22645709b3a.23.1744108809982; 
 Tue, 08 Apr 2025 03:40:09 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:40:09 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 07/10] target/riscv: rvv: Apply vext_check_input_eew to
 vector integer extension instructions(OPMVV)
Date: Tue,  8 Apr 2025 18:39:35 +0800
Message-ID: <20250408103938.3623486-8-max.chou@sifive.com>
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
 target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d72792e46a7..585ee98b27d 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3659,7 +3659,9 @@ static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
         require_align(a->rd, s->lmul) &&
         require_align(a->rs2, s->lmul - div) &&
         require_vm(a->vm, a->rd) &&
-        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div);
+        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div) &&
+        vext_check_input_eew(s, -1, 0, a->rs2, s->sew, a->vm);
+
     return ret;
 }
 
-- 
2.43.0


