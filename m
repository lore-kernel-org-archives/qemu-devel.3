Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651C8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4R4-0001Fp-17; Fri, 10 Jul 2026 02:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qj-00018A-6Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:46 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qh-0001uE-QY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:44 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso759733a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783663782; x=1784268582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qi3Cab8K1e60CRoLYMLAsESl91lzJkvRFZK117KQQXA=;
 b=WqqV0+ESnkEL25enTzLdQRTP3e2WuIb+9lKlhyGyNvzxePNy4XtgUFs9H0S5wZHxIe
 wyzki12+Lq7ZxNdiBNBUzKv6VuATc9JzRNhfVCfER84jXCfZ//zyHB/5r7wAajEETFG5
 rxmxbQsCwF8UrvhVkRYXZP3JTF1zpxfeeomZ4GrWfEVAgrsTJer2rbqaN1/PqvQ+lzXk
 SY+aQG+68/i2P7CxjK1c7IOX40ITQx5CBiOrxBeoINvD2KskcqhHNcw7b2HTomj/t5ty
 R7fiFPFkNq9Y8yh1/jW9wcGAZe2BYV1XFXwl3FcKDZXKxDRA1/3UgvG53efOzWNA1+99
 J2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783663782; x=1784268582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qi3Cab8K1e60CRoLYMLAsESl91lzJkvRFZK117KQQXA=;
 b=sOkQ8qxDUWvkheckEyymd+lQuIS0IwUa5JDthWQx8JQB75DdFIOMhtYN/FaCdHs+TW
 fUKuTz9q7bYi584FZpfwWySCSTSBdQOnWoBJuXkFe/iKg+7rE9uWThQn6+PwxXH4N81C
 opuBGoqv+pdImjAE5/yw5iqEjosqg59/7hrPn83SMY8vPS1p5U8h4YrDsZZ45eb94hUF
 OoCvIMy3HNde5Wmlt1PKYHLkOSh3nBiDjU4gjOQOzzyar9lfFoleX5f7/VikRHjxMqO1
 bsNYpcDHu1ZWyyVExmBgnPxInihpQpGQXwg5p+F/oF4GFdG5gwjcEkZBzQ+hJdaKK4CI
 AfLg==
X-Gm-Message-State: AOJu0YyA5SvfT90DMVyIz2zXsUjHHej6HeFgCTeAk5bTBAkuKh5jq0oi
 0dprmJ53/tT0Tww2q4mK8WTgLKMx3u7O0RfWviuLzzwZREBfcpLXdmo4RGnwVGVWfXRiJUWr3dx
 MOsRVfC7xvcED2UqrGSPfyNPGH9vsjDQZF7/UQoTcdeJcGHsW3vz9IVWBPoLHaqOh93wRCnDbgk
 LWtCz62yp3MSYjcvUl7Bof3geNpxRGZldlIgB6aWkMScw0MhZU
X-Gm-Gg: AfdE7clP6DscDx08tTjqnCEgVSIRNwMCblVagwuFAXIZrZL0JOso+AfWBBcJKSgUuud
 t8OyTLw15GaXM+pIAAzminqFiAhrEiTTv4tGo/5uE/R0ai/1kXg2q2e9Wh6SXYDNWo5qe3dnu65
 o6GsiYQcGQgfu9qw9BtPXEWdKVE262mKoq6bdtKc+/0zrsmrFW88F09XQpb6wPtXTZkXuyysT4L
 9KQjpHMAocxhO3mGQKX5N/NmXhf5ZpaT2ZCxkjQKW3cPff1cNScN9kMu4DPmZTce/1JT9X7dW/d
 RrPg1axgL6YbMsFErgjVPbgP2CagF6mle0K8E1cVX2S2xfPUUhm0bdovr9Vj6N8j2xgqA0fUo0z
 RtzOvvALSK0YpkyPrk8YYf64GZpD1etWvq0sA28RDgg1/CpFNFamU7hLmEEqT9NLDUNQAhX32rN
 OZcXHCjgdHbIPXX0LPiydkBT3ORKS5G7a1C/yMnU0=
X-Received: by 2002:a17:90b:3946:b0:38d:56aa:6f32 with SMTP id
 98e67ed59e1d1-38d56aa73cemr1388335a91.38.1783663782373; 
 Thu, 09 Jul 2026 23:09:42 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm53344255ad.74.2026.07.09.23.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:09:41 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v5 5/7] hw/riscv: sifive_u: Align ROM reset vector data
Date: Fri, 10 Jul 2026 14:09:12 +0800
Message-ID: <20260710060914.1227027-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710060914.1227027-1-frank.chang@sifive.com>
References: <20260710060914.1227027-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102f.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The SiFive U ROM reset vector data needs proper 8-byte alignment for
RV64 ld instructions. Without Zicclsm support, misaligned loads will
cause exceptions.

Add padding to ensure start_addr and fdt_load_addr are placed at 8-byte
aligned offsets and adjust the load instruction offsets to match the new
data layout.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/sifive_u.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 99423ef472d..57a57c96e16 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -564,19 +564,20 @@ static void sifive_u_machine_init(MachineState *machine)
         0,
         0,
         0x00028067,                    /*     jr     t0 */
+        0x00000000,                    /* padding for alignment */
         start_addr,                    /* start: .dword */
         start_addr_hi32,
         fdt_load_addr,                 /* fdt_laddr: .dword */
         fdt_load_addr_hi32,
-        0x00000000,
                                        /* fw_dyn: */
     };
+
     if (riscv_is_32bit(&s->soc.u_cpus)) {
-        reset_vec[4] = 0x0202a583;     /*     lw     a1, 32(t0) */
-        reset_vec[5] = 0x0182a283;     /*     lw     t0, 24(t0) */
+        reset_vec[4] = 0x0242a583;     /*     lw     a1, 36(t0) */
+        reset_vec[5] = 0x01c2a283;     /*     lw     t0, 28(t0) */
     } else {
-        reset_vec[4] = 0x0202b583;     /*     ld     a1, 32(t0) */
-        reset_vec[5] = 0x0182b283;     /*     ld     t0, 24(t0) */
+        reset_vec[4] = 0x0242b583;     /*     ld     a1, 36(t0) */
+        reset_vec[5] = 0x01c2b283;     /*     ld     t0, 28(t0) */
     }
 
 
-- 
2.43.0


