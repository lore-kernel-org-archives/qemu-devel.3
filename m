Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9F8C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIb-000294-Mi; Tue, 03 Jun 2025 22:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIZ-000281-5c; Tue, 03 Jun 2025 22:56:15 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIX-0000PR-IH; Tue, 03 Jun 2025 22:56:14 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-311da0bef4aso6849183a91.3; 
 Tue, 03 Jun 2025 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005772; x=1749610572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRXSFCctYU6eIeoEwNRJJ2XIPCgo6TSpCf+Bf38w7iU=;
 b=eQHtXUux0hhGc1smPi8gFtGoQ3cj3P5AKTOTXgQMgw5b10hiJ6gapsboDDqAwt96vf
 r5ogprOw9D2UvRr8TCtQd3VMeveod/EVZ+DxmS9Dt5QIfnvGbKvUCHBw6ndpevWv7mnJ
 yJEMXGoTFKsK995L4VXnJZjsHem7hMNSyTIcFDixZaKfSrm+iTpHalWU1/BkDapB429G
 As+fnC4lKeiigfJQJtNYMLcZiyfRjcl1IU6WyBVT61jNzEeqlR0sBzZBZdcS2fAUlozu
 KFaLKRZIZgl72+qw31MPBi8Au0froNGMGMtIiW4Uk5z6kNM2oJN7X9/gGwGfQFbMn50T
 36Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005772; x=1749610572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRXSFCctYU6eIeoEwNRJJ2XIPCgo6TSpCf+Bf38w7iU=;
 b=DO15sRcpK4+tES9IRdMh8pk5+AYlyD8laokeugXegthyCcqM4Cfe+K5vq1xetDUB/0
 5HXTSP5ptaAdndT8OzRSxLrmhgyWUOf+O2V/aX3NGyJ5kvPahYQ9yW+r53jOQna3syht
 mACLTGaqKtuB/PQBqv+WbyQmQ0hqQAiiThCFYoDLv6fj6EC6+JGkrNXWTJm9sPAUqJ6+
 X4+H5HvsyZ8Hm3wdFUc+m5fNGch+2yLKIm7cZnCVVDk8ktLauR5QZohCSEOVLtnk4pYW
 b8A3nKCf2nYn0byiNG4Urre15o0siXhLjvtyUNaeyPe7fUFQM3ofp7gAW70AbxjeeijI
 39rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvPet9nPs1U9W7mguy2b1IDxMo8l2uaQoiHmyV7KuUqKhlFpzgCzAlFHIftJip6IeTWZs1Cldwc8y1@nongnu.org
X-Gm-Message-State: AOJu0YxcITBeWxIN7Od5ziFYLW0LJyrDuZzLzVVEeOxP99F1g4fO6srt
 KM4x27QSxqCZtvlSzQUi+XRJL9eBsnYMfjle9zJbnElXj1rleiyI8Rcm
X-Gm-Gg: ASbGnct7LzI3HTNtzAmH1eiZno6kdJP4T4QMxATsqzqz/4a1xj/+P7PNgVSFWQLeh0h
 +g++0tQlZ2RcgrIT2NpkmFC3+CI6cH3fBw8DyD9Y+9ea64ITEgDASBLcgd8ZJYyip3UntAPwDgA
 S6vuepMi+i5TRY/Elsm2SIrdkY0pi6vKgwyrimhZuTFIwktCCLhHhu1FhD0khrjkYrOCxos13/6
 izL/CML6lLQS0dAQvgztKP8r49pj9dnJ08p967TrzH4yvhvHqDkEix2MJFlR/nk4lroNkfZ8SG3
 mxWSzKXAZgIaQXRYbO55zgtDABCP6pCwkj5bDI3Mvyz+b2ayMwrBndsa6kmcNQ==
X-Google-Smtp-Source: AGHT+IFYvUz6DetSkmWankGNz0UvGs6Y9YpwXsDBOwiGBh9r/IWtfRsh9a0sGLISAUe6ynoSWTbSaw==
X-Received: by 2002:a17:90b:4a:b0:311:cc4e:516b with SMTP id
 98e67ed59e1d1-3130cdfa97dmr1786860a91.32.1749005771793; 
 Tue, 03 Jun 2025 19:56:11 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:11 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] hw/riscv/virt: Use setprop_sized_cells for plic
Date: Wed,  4 Jun 2025 12:24:42 +0930
Message-ID: <20250604025450.85327-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fd966a34277..67e60eec1f00 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -493,8 +493,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
                          s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     }
 
-    qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
-        0x0, plic_addr, 0x0, s->memmap[VIRT_PLIC].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, plic_name, "reg",
+                                 2, plic_addr, 2, s->memmap[VIRT_PLIC].size);
     qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
                           VIRT_IRQCHIP_NUM_SOURCES - 1);
     riscv_socket_fdt_write_id(ms, plic_name, socket);
-- 
2.47.2


