Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBD2CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjQ-0006YX-JK; Tue, 16 Jun 2026 06:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjL-0006LD-FF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:15 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjJ-0003qZ-P3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:15 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c8589498839so1817170a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604552; x=1782209352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxKkyeejx8Q+vTtrpQmaNbDvbKzB3cd4Z5Ebm106wMM=;
 b=KtX7p4O/SuqeV9XZ5fj2QJ6X72QJb5hT+aVuBoelKWTleewatKyPoH+Ojy8ePSEgFF
 RA+p1JfL0V4E6uOOAZzWhjxaVS+Cs1BCgAXhN+ThrjaB1nhgA3PLZi/saFDbWqRtSNsS
 m8G0DCKIL1oBGwBy4dSpquazgFyslvc0Z0Rmw78SfNDEAbbPHXbT99LksNXc07B51LaB
 PiFSWDKnNhsipnAKUtKEa1wcGikkZU1mwI6trvMr4OGXpx6niNCSEZA6+dTJDJ6zOYrg
 BL4ao3MlaPrnY7bBkNR6AFVTX+XvEEUSlBoA8cFzd8n/bad/UQbZOLPIGn+EDZAvZ6jr
 Cgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604552; x=1782209352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxKkyeejx8Q+vTtrpQmaNbDvbKzB3cd4Z5Ebm106wMM=;
 b=RSqy4SFBDFfS44DGxCX63szToHHAVJXwBVBPI0ze0jXiCnMHuOyacb+Cjy177IryZI
 C+AvM6Ssfva3QFmfvJeRAZ6o3pBq27rcWDmr+RPCBJa9TL3h0QoY+f6H6WZBul0mPSv1
 WYyxF2r024S+TK9liQjTSO1ZYVueWiDz8ET0DDgIbaUbBjnxQMLpYnM25qM44EJyPpQL
 NI7NPe7+Zl6zxk1+OKYPDa0PJ+5f+j9DvauImlPIEvS0eL+kl0kj/18TjbXxvsMWxEPe
 OzU60tVhjXR2JFPzVbibBTnY20v7/cclnqtws8A/cg8Pa4M0R2mySXJONUwct5QLRFoT
 GZhg==
X-Gm-Message-State: AOJu0YykiOFTvckm/nfOeaxw8DPtyiQJfni7l7atXhAlVu/GVxnA1BQD
 2GdTWHDoyf8y+ugpWUCzq/Pewiu+05YDmkzXYTecsMd57R4KtHpdDWcquZj3A2rS
X-Gm-Gg: Acq92OHSo/9pIBJMGGFv2uPm/bOPCQ618vESIPaYY79XuoHQQ/IYTzaXaRetQFbfOSz
 6Tc+2lWRldzOOFvdwBMa2ksmmn6m//ZnYYn59KfjtEsIrqwC3ri7rwUmuuf5gnvxNDnISy6EqA/
 AsGaeyGTH9QII72B+Ednfn5d3WuClWHiI6cxZuAKXbKeDGw1+t8xj8ktT0M06GBvblrPWnVV64l
 xBC5fSDSC61ynVM47fOF1rpyA0oBOTTlMjKBekbsLwGQ/57h3wYUTpW8JO2b4aYQ3Fz9NUsNtpF
 RBvAwGFjFOrslatGRsSi+RZiwHh1vfzURjrsibRNuzzcc1pNl5wyoGV2TzwT4GmWNhKJOvwFS4P
 GTq6hbr/AIRyBUJvyx1lDGIwsroWc7cWQ1VQlueTo9vbvKnOz3n+TwybFfc11MfBAJoKnoqoR0X
 cxwaOpZKHhUt38SDN7oXdlq7iEcEEIbCi2Qsiv/4U3
X-Received: by 2002:a05:6a20:549f:b0:3b4:7eb0:479f with SMTP id
 adf61e73a8af0-3b7961f6fc2mr17029945637.5.1781604552456; 
 Tue, 16 Jun 2026 03:09:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 62/83] hw/riscv/virt.c: fix 'iommu-map' FDT entry
Date: Tue, 16 Jun 2026 20:05:05 +1000
Message-ID: <20260616100527.1939565-63-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Based on the DT documentation of 'iommu-map':

https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-iommu.txt

- iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifier
  data.

  The property is an arbitrary number of tuples of
  (rid-base,iommu,iommu-base,length).

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
----------

We're adding a no-op entry (length = 0) in iommu-map:

         qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
                                0, iommu_sys_phandle, 0, 0, 0,
                                iommu_sys_phandle, 0, 0xffff);

This is easily seen in the generated DT:

iommu-map = <0x00 0x8000 0x00 0x00 0x00 0x8000 0x00 0xffff>;

The tuple (0 0 0x8000 0) does nothing since it has length = 0.  The
information we want to advertise is in the second tuple only.  Thus
remove the empty tuple.

While we're at it, seems like we've mistaken the API and we're using
0xffff as 'last address', but in fact it is length.  This means that
we're telling the DT we're mapping 0x0 -> 0xfffe, which wasn't our
intention.  Therefore change size to '0x10000' to reflect the address
mapping we want (0x0 -> 0xffff).

Found while reviewing the RISC-V Server Platform DT generation, which
happens to copy a lot of code from the 'virt' board, and this nit is
also present there.

Fixes: 2c12de1460 ("hw/riscv/virt: Add IOMMU as platform device if the option is set")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260608210642.464131-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce64eaaef7..0c489bb412 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -900,8 +900,7 @@ static void create_fdt_pcie(RISCVVirtState *s,
 
     if (virt_is_iommu_sys_enabled(s)) {
         qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
-                               0, iommu_sys_phandle, 0, 0, 0,
-                               iommu_sys_phandle, 0, 0xffff);
+                               0, iommu_sys_phandle, 0, 0x10000);
     }
 
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
-- 
2.54.0


