Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A8DC88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFE-00030g-5o; Sun, 13 Sep 2026 20:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFB-00030C-86
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:21 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uF9-0006rz-8Q
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:20 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so1037278a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344497; x=1789949297; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4Lqh9WoE/JjlZrRKqXsl2uIUcMDy0M+ANyMPX7v0EFo=;
 b=OrgY2UPmFYYGIlnItQGN7qOHUhLcUwvW4Jco6/nMsXoVq5DlPwJwo06ABDHSsVagA+
 lAoOwyoYNb2GdRDkvTVCth08avYefIy7+yDfyZR9LLLk3Ulii1mowr7s/PlKtg1NeqoJ
 NxSR65kYJt/AIqMN0kjFBCGaFixDoaKlRXywzzIY8QLE+gGWNPBOkxzwxSeki5CLdNdV
 h+eu5xDvW4gBMVBeUDwJOru5HxK15+uCh9d+N/XV7cV69fOIRdKmdBx5OMhITRWndvnM
 Vl6DTbxY6aEAkHX3hEXvp6Eoh9xUiGnSQ//JZ7DVfDDEBzSomjEyrmpwqQ/t7d8iEt5N
 GtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344497; x=1789949297;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Lqh9WoE/JjlZrRKqXsl2uIUcMDy0M+ANyMPX7v0EFo=;
 b=M54qFhsV33ZOmZ72TsOeNYHcF0wfXo0Q3RBvRcWmhsDfIUzW7h1fjVqu1WSE4ZGmB3
 cGJLFjdIsftiTGS8zDkMnGZoUUtSZic5IWF04PfwTbTmhRDSW6IRRptFTKSaHNgmOZTP
 zC3XxqMI7yAstKNQmVpaDnnryI4GMqyhHQpaelC6n1gib0PTzS6pj5BM99OSLN9B4pGf
 2YtgAq5THGzojyxp+E5vJFnnaZf8AHCcQpl2bQEDouKjI04DyZXPL/PGBFJdpTrd/+Ka
 ELWV8Yy0LzqFth7/h93j5rB1CaWZgRsWMET+/ulc5wwOe4FzTiVU43UyHQy6077CBRu9
 +DUg==
X-Gm-Message-State: AFuF++mPqMctB0L24XvCNYhazCpDtFfn5lnJYPSA/ikfb2HH41pMASEr
 CAmlN7hXkSr4k49AQtfhBJ3rhnSt7vKTHkFl+u6fCi9maO3pWr69u7UIoFVYTs31OLWAaPKoIn1
 Sv8Ua
X-Gm-Gg: AYBFou32paDM2GD+/eoB1T5wyFlOmKWnhUMVUIonJGKPr/1h7NcmXva4SamXUR+TY+V
 7NuzuwI01zWLmk/DX42nwJsmy1wTbcEczcP2Aw45RDzxiIqj0gytXd6S8MaOjuhf84rINy69Lql
 XeJ6RN4ZZJU1kQjhNoIqXy01IoZ4cMKKySOQbxzlfnO1B88LFefTeqc/hc1pUO6zTuJ0rPGKsa+
 3+jc3NPfP+jtGdlEmQ5U2B9g1Ry5Iz5dOULw/z3uyGNvYCMvqNtRTE3Z90ZwTuqpQ5gku7xW0I5
 Bs7vCba/qcwCetfJ4xM9It4eHmYGcC4Skn+5UtJfk756Ih7prBNZCI1sebbVwfSvJQyjAWXJZ0d
 3bnIQmWBTJGbuQQU2os6svgp94VjA1sGsArXe4EaSOfyHDz3uPo4j9AtOj3nhTvj0+cEnzqZcpL
 6BXXs9tV0PweWih9p5DfDAQvtUmz/bjOFzKYnhUsw46/XOGp9H9zc3Neiw29vC6nvZAqN0DorZa
 7tN7DU=
X-Received: by 2002:a17:90b:2e48:b0:39d:9b53:112a with SMTP id
 98e67ed59e1d1-39dec0fc3f6mr541987a91.23.1789344497112; 
 Sun, 13 Sep 2026 17:08:17 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 00/11] tcg/riscv64: Fix AUIPC pair range validation
Date: Sun, 13 Sep 2026 14:08:03 -1000
Message-ID: <20260914000814.785155-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Hi Max,

In v2, the change from int32_t to uint32_t is pretty much
the opposite of what should have been done, since all of
these are logically signed values.  I've adjusted all of
the encoders to take signed inputs and assert in range.

In the process, I noticed tha the branch range tests were
off by one.  Now all performed in exactly one place.

Finally, tcg_out_ldst needed updates for AUIPC as well.

I've tested this lightly so far; full testing on a rather
slow riscv machine is still on-going.


r~


Max Chou (2):
  tcg/riscv64: Validate AUIPC relocation range
  tcg/riscv64: Fall back when AUIPC pairs are out of range

Richard Henderson (9):
  tcg/riscv64: Return tcg_insn_unit from insn encoders
  tcg/riscv64: Rename sb-type to b-type format
  tcg/riscv64: Rename uj-type to j-type format
  tcg/riscv64: Use signed type for encoding immediates
  tcg/riscv64: Adjust sign of lui immediate in tcg_out_movi
  tcg/riscv64: Assert immediate in range for [isu]-type insns
  tcg/riscv64: Return success from encode_jimm
  tcg/riscv64: Return success from encode_bimm
  tcg/riscv64: Fix off-by-one in branch range tests

 tcg/riscv64/tcg-target.c.inc | 230 ++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 109 deletions(-)

-- 
2.53.0


