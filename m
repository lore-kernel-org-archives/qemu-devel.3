Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B76C5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL15-0006qe-Ez; Sun, 23 Aug 2026 23:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyL10-0006mK-O2
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:06:26 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyL0y-00045q-IH
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:06:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so2948123a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 20:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787540783; x=1788145583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rgL955tZ3JpF8EMdLyYe38cem/51/AaFnMyxcri4t04=;
 b=AWsVZEBBOK4NedWW3SMucQCooDWott/j58HSI3kRWOL++f6A6ipn2JUQNx86CNHtm6
 0LkycKuTbad1ToyEmr8fUzVCR6jAwNH1Y+ZY1UC77FdwVNjYlt27SlwVUvg1G33hVady
 Jx6Aa5+6bFScM9idVungl03bh5nwLcauwFnlEluDDbSLuOEGug2usIURHoRgiHVojxH6
 c/ykRTWpL8o1fk+rYYm8YLdYlGyrpzPgPOhH5bS1PA1evWhl1kHc502t2UWJrK61noIl
 kqdOpbQaD+Y+WB2pr5T7wvXIInSbms5xNpm1uI506tT9gtkbX4EyWsahe9GR4eU2jH7u
 Umug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787540783; x=1788145583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgL955tZ3JpF8EMdLyYe38cem/51/AaFnMyxcri4t04=;
 b=eFsQii++nPFu9XMTu1ojI4I1wHWE9X14RwDIm8HvoROZdYbYIqCAkODf6/bGYVFhL4
 WIcN4yXl0OSNDS2SoVp4A4Dn5kgs3zkNkoL0lYYpBAlYZJ2mK/J5wjkmjcc9VMA8R6j/
 kWEiRTBMQcifFIhy0IOGx4jIErYmbDnt91Ebh8PllukEgW6JX8F9RRW6SRs+x/4UnfUO
 ddhsXucX7PeLCiTELWatGcoRQ9HyJaJ//8FyVBLYXykJeoSK0PVFTBVGeSA1GlVBbIk2
 EfzDt3t3C12tJuqGx8vtvmO3U6J2nvp+wN7Dt/MwCopX1jpKj++bvRdpjV271XHmqZ1g
 d7kA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrP+zronnNTjbSgRykrUubelNRgSklETSwGtSUMMKZL082McCZqbGpzyms90yVrGTCmzFDShTpH3t6s@nongnu.org
X-Gm-Message-State: AFuF++kUpO3W9Zxijl42iDd2vBV56aI0+hcB534nVxKcLtpF0+NJ2HyI
 wZX/vDUFkSs8/UALSTl7fHq5Bh/gUcDhjmffkWSwb9JJ/8OFBFXSczfjt8+IqTVt
X-Gm-Gg: AR+sD12OIhMPj+pwcYuJa/9fXcMmK4IQdY4A87rtIHQ2jLkn/qY0nEkWR2mkG8aP69A
 LT4Dxqfryooqp94a0qhoPpJIKjurgo8VHOUErJZb33N9l3PQH88IFeu+gV0YKgCotlPJOW40rhk
 PYaTOynWJkuLv5dva0Oz0UWUODOteJWLujNRUYuNQJl+zw6TRryx4JR9ZLTG38pfsivai4aGMtv
 zfK7YybC+bkMKO7HF3BhgDehaB+QiDfipblMLxfnShvJqZpelMO9BCRL303P0Ycw720fAprePFD
 UM4PMmcXZir5H0aswB8asAQau+vhgGonGphjyzYslKPW0yE2nqsqv5IEcBWi5nsP8A+T77YOYv2
 Advj5d0CcOB8SxkYHBhFtwBlEdpan3sIM5wJU4+Vb+vDqsc8JirCEeEeUvl20fDA31ngg2zXB1R
 JmuG2U5U7UufbY66UYkDPUlTeiT8rzsFgdVMKJYrCVCefOEqlGj3jqwi6hPNN2q8Onk5/fJ8uRI
 8E5PRH4+mDxfeHfSlwPLVnfZcBK2DTykObmAdG2L/TAqz6DDi/6JIge+OpMg/I5zLfvNMz/BaME
 6A0wV387Orsv5MuoaHFNbg==
X-Received: by 2002:a17:90b:1b0e:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-395deec7930mr25772572a91.7.1787540782663; 
 Sun, 23 Aug 2026 20:06:22 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4a4e5ecsm8299699a91.16.2026.08.23.20.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 20:06:22 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/riscv/aia: Check for invalid IMSIC configs
Date: Mon, 24 Aug 2026 12:35:07 +0930
Message-ID: <20260824030509.18078-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824030509.18078-1-joel@jms.id.au>
References: <20260824030509.18078-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Assert that the IMSIC layout will be valid before creating the devices.

aia_guests is a command line parameter but the machines that allows it
to be set (currently only virt) should be passing the correct stride for
a given number of guests. The assert helps catch bugs in future changes
and shouldn't be triggerable by an invalid user config.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c33a3b32bd45..c1a5982856c5 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -43,6 +43,10 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
     /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
     g_assert(num_sources <= 1023);
 
+    /* Prevent IMSIC MMIO regions from silently overlapping */
+    g_assert(s_imsic_stride >= IMSIC_HART_SIZE(imsic_num_bits(1 + aia_guests)));
+    g_assert(m_imsic_stride >= IMSIC_HART_SIZE(0));
+
     if (msimode) {
         if (!kvm_enabled()) {
             /* Per-socket M-level IMSICs */
-- 
2.47.3


