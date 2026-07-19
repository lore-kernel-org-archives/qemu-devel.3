Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9640C44520
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBF-0007l7-M4; Sun, 19 Jul 2026 12:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUBB-0007jg-St
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:49 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUBA-0002QC-Dl
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:49 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id AA11B1D0003C;
 Sun, 19 Jul 2026 12:15:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 19 Jul 2026 12:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477747; x=
 1784564147; bh=FxYe49VlUpL49RJnm5W6cmxC8BRM74U3nkrbigB7SYI=; b=b
 pYaFSgC0v6ky8nX0cnMJlqfnDziu7bh09GRPsqdNSJ6E6Az2lvKvd/Q2DnP5tK9U
 uRGm8QZI0GmiEzpoZBKAEHhcp6Z9J8lngjEI1tC+0z67YWRusPlN4ARD6xjYDu4/
 vPaPUm3sxx9J45UxUXKF6ZOqIUKWLTzmWr4m6KUu00BmPIBlrdmHD26wOVJLWACv
 bqnRtA6+aGKr27w6AGnM8SuNl8vwtJdVe4qFPnnirDuMzu6V359aKuqmF0TrOS8J
 hEMEezwMIa7jLluzefNEX0ijkjn+Y0oQo5bBacJdiefVUXmsMoNbmv2r7R8QrNCI
 EbK7R64tqRVbfSUt5SmzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477747; x=1784564147; bh=F
 xYe49VlUpL49RJnm5W6cmxC8BRM74U3nkrbigB7SYI=; b=eeHrq2sHK9fGA8fGp
 6A0N7rXP2Lws2lTakoliKMMXxYS+LGMSJI4muPwWOk7YhYafQjDdgFVY0cUjIGso
 WPP5+cwrjFnqKFUNd34PBiLeUPIXwwDieiaRrkyFofDi4U8hC7mwDw8zn5Izc+Ad
 2ES9Z9f+zoMOzi5nnksq/ak9QND07lBkVxL43i9iTq6FQANEfl+jI0TIpuOUYEd6
 ZoDaoKe7RwnkFgpZsfEBuMV/hktcRjqIY1h9vszZP6aXIXHSg/ElltWJ7vwmHKPB
 xt0RwcuQmrqi4oPGHnN9FsOYOLQngWOUANqk+W49cFJfUbsKOVrYd7mnwmwj20V2
 PLfdA==
X-ME-Sender: <xms:M_hcambeW8krNumMY03qAC8N6bQhrlHMBjS8b7Hgvs0NjelMbaJk2g>
 <xme:M_hcag1Nx3ERzYgYJiw4auptcynoNmFpVE8KHf3ozgV-oSPQmk6sS8ZthUxbaU1Y0
 J-xybyD7FxqH-U8pN2p-l2xddrgQJNUROzNA9S1rCJUJkcOnu8q4Ow>
X-ME-Received: <xmr:M_hcauWEjwMw0N1tCoG83yIrGn_UaDPTJFx-kxieccUeHyU1EbJFtboDFbw>
X-ME-Proxy-Cause: dmFkZTGbgkTlNDQ1Bvo8f+LUT+Zm1EtdS57c514xXo1/s9L2sic9WUzeQs4iwnWAqOr1vm
 G18BnC0XuOJCLxxKPJpmle9nfBudcOBbX4QWBH4zFAN5PSM5KjovtnhBnCqm8fGZLnzPYS
 e/Jmi9RpHIUyCg00RgRmuxPm78q3BjA13/PltbYmRrdxKrX2ID5zAI7IshEx6unZxmJRy+
 VKb+JekVlp1MyncK30ci5XSKZ+099TmxMVErmbpUkc2snVorb9wF8J4jbpfcooGEWEf6uG
 HrTzbOyLckcmFTHfvwdCMMcA5p0fezk58hbQbVWs0+N1rjoy1epuw9LZkhZuVtPd9k8ude
 KBx8pqPS524fciCjtuiw3bTSZVcZmUIVWrY+9XDSNtELyTtzr0XsvPHYwxlvehHBXdjr75
 LNizXvKkdGLy7IPCegXGH/3f15mAGZC5oQyWlx3i76Myg43SrGhQ++gLFL4Ta8O5t38PPJ
 WleQBS0r6hUERKoN/oxp6VpK9aIlm+nAGRGcpLgaemXaY0lq9ouIIHDYEbbK3QVqcm6/o7
 Pxr4PZxYRp+sfY1TMv/yNGu5umvcv2dEltMISQRbSuBww2g5Icb6Y12f1E3qlimGAEn/mF
 dOhUw2EMdrkKZj2S3O8APCUOGoojNFshiaJZXGESdGuqY0NC1UnFyjlpFFRw
X-ME-Proxy: <xmx:M_hcaiXXZ3daFbcFah4ZYDGq-7ZJAil4_DH5sqghRkvBQ_vRjkFB0A>
 <xmx:M_hcaldU__ijt1td2yPKL5_Ob5x0Dnha1A4qF5pLaSEoRkxgwSFGrg>
 <xmx:M_hcajWUQqcBoIvNua4EmmY-DwZZJgP-WrCYXjcHOm1Wmr-Yf7hZnA>
 <xmx:M_hcamfCLw1dHHbGEUEO9PEucGoEqMrnebm0Hyx29SyYHGIP8l2daA>
 <xmx:M_hcauDy-hE0QnnbPJZVi9Tn-RGOs04a6OjxjmfZ5zLo07W6E67E83yk>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:47 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id bd063b2c;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 9/9] ati-vga: Scratch registers
Date: Sun, 19 Jul 2026 12:15:36 -0400
Message-ID: <20260719161536.774061-10-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Scratch registers are used by the Linux DRM driver to store sequence
numbers related to fencing. Without them, Xorg starts but quickly hangs.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 19 +++++++++++++++++++
 hw/display/ati_int.h  |  1 +
 hw/display/ati_regs.h |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0c550599cc..86e5c16946 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -629,6 +629,14 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case CP_IB_BUFSZ:
         val = s->regs.cp_ib_bufsz;
         break;
+    case SCRATCH_REG0:
+    case SCRATCH_REG1:
+    case SCRATCH_REG2:
+    case SCRATCH_REG3:
+    case SCRATCH_REG4:
+    case SCRATCH_REG5:
+        val = s->regs.scratch_reg[(addr - SCRATCH_REG0) / sizeof(uint32_t)];
+        break;
     default:
         break;
     }
@@ -1197,6 +1205,17 @@ void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     }
+    case SCRATCH_REG0:
+    case SCRATCH_REG1:
+    case SCRATCH_REG2:
+    case SCRATCH_REG3:
+    case SCRATCH_REG4:
+    case SCRATCH_REG5:
+    {
+        int reg_idx = (addr - SCRATCH_REG0) / sizeof(uint32_t);
+        s->regs.scratch_reg[reg_idx] = data;
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index df08b6ae01..daa45a2009 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -131,6 +131,7 @@ typedef struct ATIVGARegs {
     uint32_t cp_rb_wptr;
     uint32_t cp_ib_base;
     uint32_t cp_ib_bufsz;
+    uint32_t scratch_reg[6];
 } ATIVGARegs;
 
 typedef struct ATIHostDataState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index e8e1b90374..54d63cf26b 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -222,6 +222,12 @@
 #define CLR_CMP_MASK                            0x15cc
 #define DP_SRC_FRGD_CLR                         0x15d8
 #define DP_SRC_BKGD_CLR                         0x15dc
+#define SCRATCH_REG0                            0x15e0
+#define SCRATCH_REG1                            0x15e4
+#define SCRATCH_REG2                            0x15e8
+#define SCRATCH_REG3                            0x15ec
+#define SCRATCH_REG4                            0x15f0
+#define SCRATCH_REG5                            0x15f4
 #define DST_BRES_ERR                            0x1628
 #define DST_BRES_INC                            0x162c
 #define DST_BRES_DEC                            0x1630
-- 
2.54.0


