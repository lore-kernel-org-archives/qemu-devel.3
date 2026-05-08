Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B207CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMty-0003aI-Gy; Fri, 08 May 2026 11:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtC-0002gE-VF
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:20 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtA-0001iw-OD
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:17 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69498319ee7so1860122eaf.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253195; x=1778857995; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GSsp2+10fvcF9k9V+3BplwMm+dewbmOEpbIv8989h5k=;
 b=aCYhfIRoysjcwMefb/aHcNCuNtn4d060hakVV6SyM325bVfKKoViIPADHpfNFPqBwX
 gFk+9q5F0/l6gej36YnzwWjvBoev0gtgzZD7Br6Ro8dkrHqiTe6ZUYvJVA0etgJyohfm
 HPh9R4/OI3rdc94OWOlJU7QOqCJgxuauL+q6Wlw7VXj81SHXdK8n93+Q9LEByNFkFtaa
 ATRuzAQ54vHiyjr0KdKL+jlapjjbYm1QxZtyCrQg4LPpRoADEJDhYWq/OQr6Dk1siTRz
 RkKf2O5pPkgHI1sGjH8cCQ17h8S5hvI/utkjkoqDlZmq5Iik7vSHogazlgQ5ivo8felC
 I4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253195; x=1778857995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GSsp2+10fvcF9k9V+3BplwMm+dewbmOEpbIv8989h5k=;
 b=TQAXoL5uuHWnbRq2MYvjycOJ/iD/u2qQ3Zd4tkWAlVYjqGYFGpZ2mpEl9E7qP7uG0T
 vRR/O6JS8y7ZJBuCdYlQYYwTC4fqdpYy9iVdCY7BNsX2UfOJzVtgjYhX2BtUf+sNcTMP
 vhZsDuxDLruMw+33sryI1X4fl6pQgSZWthXna3euHL+TIx81WyjYekjvMljzZIojDT/0
 Vdh6ypBGjkqtOch7i5X56T+EXeidZm19j5pJiZ3TKWkJqG1eqwQlKggJQwY4i00GQUGa
 gyr13zcxHD0ZUfnDv9QLilZP6s4mpDaJKH/4RHt/kQizrZ8NESyyZ6ZW1dN9VIpmK/cM
 bJSQ==
X-Gm-Message-State: AOJu0YzThebIhpt69gk+Ry6/C7BiE5WPx+8V5qhzLXzv1ZdX2HKho2dh
 38dCzaoyNp3WpGSR9nCFfViTZtC6YAQlNGl7H77MD9RsuTObZ/tZx0C/ylegrQ==
X-Gm-Gg: AeBDievOPc3fPIDdg5+QRLHvlWwduNlPsTc2+sUpvnHD308kqATkXaLWcUB4+45HhgA
 w4YBgUxxwX/Dc/CG7Qoux/tCBlv5YjbxvrE82fQE5lBuKaCbWAMlVaQCm/z+eg894RQMAXx/k3I
 BcDWNuInFhDwFIMOuFj/Xxz+LpGJf/hvHnJAjXkXi4Gt7DtGih4MUDpYhSyz9PyrvhmcPMsgh5y
 /Ys7GEJJu1BgDvrM346YrvgCugKKvSF6g+7yp33JEdVXLbjJ8P5mA2aihukrq7QYI/Yfnk3kJXw
 hYAFFMluz/eFAuHTB3QR2gpNvlVtQ7pgqVTJHIJnNAegAB9L+SrrUcMxT5R6AgLLFWGJ1uPMvW8
 HQ9RD1LPJN0ICGep7DQUCJ9xC53JHgh0yy2XILo+XcJLn6tVO9oXU1Te6f29x6RPQhAmvOXDAEH
 cbRGOoT4iXrmNppYI7A3j4FSQFffus2qQ9YFXa7vG4YEmj7Z/j++8bpuScAsEA4sJsBdagVvxcU
 H8CfheJXbvGhOzl1eUo+/yMDW3Hjxp1NKVTT/x0UsvjOKp+LKFPvdoAD5JrCp0FefX2u3/JW9yS
 jfaORqSjZZig2lKzX0oVfB7TjmOStEoQx1B35evV/jXkNd58NKjqqfvoqTYPN1Ayx7LND8k=
X-Received: by 2002:a05:6820:4deb:b0:696:7f3d:a75d with SMTP id
 006d021491bc7-699ab68f93dmr3496512eaf.27.1778253195301; 
 Fri, 08 May 2026 08:13:15 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:17 -0600
Subject: [PATCH v3 17/32] target/mips: add Octeon MTP1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-17-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc34.google.com
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

MTP1 loads the middle partial-product pair from rs/rt into P[1] and P[4].

This completes the second guest-visible partial-product slot used by the
Octeon multiplier helpers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 94dbc356ec..d339e6d1b8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -46,6 +46,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
+MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5a0ff4dad3..ff02978898 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -292,3 +292,4 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);

-- 
2.54.0


