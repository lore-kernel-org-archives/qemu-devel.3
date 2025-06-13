Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE80FC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrvJ-0006SR-Ho; Thu, 12 Jun 2025 20:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CmtLaAcKClc9DBAD275DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--komlodi.bounces.google.com>)
 id 1uPruI-0005rB-Ax
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:31 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CmtLaAcKClc9DBAD275DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--komlodi.bounces.google.com>)
 id 1uPruG-0000a3-L2
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:30 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2365ab89b52so5026945ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773066; x=1750377866; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bGxi0+b2ieHBb3xRNVEv/9JKjepFFVub1/UswMe9fwo=;
 b=3gjmOgRqwpEeQ4+ZUxnKZCXqdUCux0gW/uF15+pzQ2sZRZKloX/9Em65LU2yfijvTO
 +1yxpop18yOQHvq6/xQkNpNhiBjngrGGNhDPtpd8aO5mCfvP8tPcVUQmTt/R0VAlCWc4
 wGJQ9fwPYTMr/VXnlbjEV8u+cEYJD2Uar0ZDN7QMUPxSggTgOuhA60DFTE/3kOzYmM2q
 BIN/stQPRHNAn+3kmrKXlx8I+HgTd99hxafjMJvDGWI9GjczIltNA+JXA/yEfwU6Fj0R
 NvZfL7lOT8Zt1eZi6zbM72SRqCGxPrpySaAvOajY6EvbKn2+uXvuEkwYg6HQIsunOvPa
 9Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773066; x=1750377866;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bGxi0+b2ieHBb3xRNVEv/9JKjepFFVub1/UswMe9fwo=;
 b=Fe3/yzSLAfI8OLbfb27g4Vbrtc+8JqY+zc4g6mg2J6GOCuZVidHQiLzzu821gQdxhu
 Dv70i+45d2WGnePnbLn2Inm2M7pIdeY5ZbIjBCPacjkrQASthfJpQPkz3TkVzoygZjV8
 0Ld1p4XNTiq/ddnfjcUWGeriAgMgtWWzz0qhSbcdg/8RAFETc2z8rVfn9zQWA0LeO0OI
 7AKhaStSkN8rLyUfEUnv0MelrjSA7yLeRstzVDh044LYWucb9PvJTTiCKcmPk4bMToAu
 v/T3qDu0+Kc2Cwxq8pBpaoLLSz9yiQQ25guyxabbp/wea11gDxgGEyEp+IuCaqxsMPDT
 9mIA==
X-Gm-Message-State: AOJu0Yxv+4CDoWbMMioERQin5EYk9hg/4sP79YOzAMr0NAaai/2CzS6/
 wpTiUS8FGlsVzuKe4WQIOx7FIv/McWXNDqFtWjbWOCl0X2T23oG6e4JAWzZPas9+koo2c0UH1Ll
 goIbEI+I2ppw42LXWprx4o/wolOwmyE2cql8gEz+TMm7JCm0b/duI+XmOa54AppS7/kpRwlRN3G
 DaXN/gPs7HoU2hCUCuSGWPbUZDPn4O0m8stt0D9Had
X-Google-Smtp-Source: AGHT+IFirUvxD2IX451LrPoZsi4qEBbNUbqzhApW0pieIbOQgAAFEoX1n+cFSAlycEtF4voIhDobGxe5YWPU
X-Received: from pgb23.prod.google.com ([2002:a05:6a02:3417:b0:b2c:4d40:79b9])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f689:b0:235:ea0d:ae21
 with SMTP id d9443c01a7336-2365dc09ad7mr14535485ad.35.1749773066491; Thu, 12
 Jun 2025 17:04:26 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:04:02 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-11-komlodi@google.com>
Subject: [PATCH 10/19] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3CmtLaAcKClc9DBAD275DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The registers are only 32 bits wide, so we should cast the 64-bit value
passed in to only be 32 bits wide.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Titus Rwantare <titusr@google.com>
---
 hw/i3c/dw-i3c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index bf51c00935..ecd79aba8c 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -380,10 +380,11 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
 {
     DWI3C *s = DW_I3C(opaque);
     uint32_t addr = offset >> 2;
+    uint32_t val32 = (uint32_t)value;
 
     trace_dw_i3c_write(s->id, offset, value);
 
-    value &= ~dw_i3c_ro[addr];
+    val32 &= ~dw_i3c_ro[addr];
     switch (addr) {
     case R_HW_CAPABILITY:
     case R_RESPONSE_QUEUE_PORT:
@@ -409,7 +410,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
     case R_RESET_CTRL:
         break;
     default:
-        s->regs[addr] = value;
+        s->regs[addr] = val32;
         break;
     }
 }
-- 
2.50.0.rc1.591.g9c95f17f64-goog


