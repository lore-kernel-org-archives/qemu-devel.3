Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ACBCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoJG-0000wI-67; Wed, 03 Jun 2026 12:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJE-0000vy-G1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:12 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJD-0001WS-3n
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:12 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7dd5a8dc8a2so37970187b3.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780503550; x=1781108350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9JrjbSVaI7WkfN8SQ+OIoaLMzAQFuQ2UT0Ps1OLSfc=;
 b=NOqLGorc8gkoifSw9YzPssAcXIM4gLe3rgk71qbnU3yg4HlH8THp4Nk0VeqiHCbjuh
 4871NJNjjs5qOAXA9hiBE+yTXyaCnmD4jXcqaygKlGbG53/EaLj88pKeqMiMpYSCTJ7r
 q0ObqIOI/g+WQ238vuopECcN1VXboFpr6HCLScAu91gn6ATNQ2WGnHMx69jyRKF7nUpy
 Wn7QvnId5pjFCI/loO6p0yk+Tw+3VIyvcQ35iqJa62YZRO8/fxShYgt3lX9HWp/4FRC/
 tqwfiZcD7LAf3eewi9KjFsLA30HOkxmJlK/qw4zRnWs+fjluNCS8vTdWVN23T9uic0gk
 4f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503550; x=1781108350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9JrjbSVaI7WkfN8SQ+OIoaLMzAQFuQ2UT0Ps1OLSfc=;
 b=qFyzhhpePdykgDsVJ9jDH/kXUdMGQdPbueglE1MPzHIrCo/95ssbK6jMRM0eLRwPEs
 QnlgwwtN9flmy4h89GCkxZHiKxXovyVWCdvXMINfalGUsGiOyZy+KkhYYTMzY8vEzzPk
 bWYgnKRJxOgLCItlZIk+2bcEpHB9NtVRG4O2ExRCeBy20mtw6YH33r1QKgjOIMDT2Bzm
 eYfmB8yezUidnLqHssdXmTOBIme+aLRYnkJLpymYcb1ohPzO5xbvl2rc83InIYLMy16d
 xjNBKYIzS1dNwPBgr+nuP4zj6RkDAVJT+lPvCTq21agcBUcvZeKydKM4o/i8l1KzkpuJ
 gFmw==
X-Gm-Message-State: AOJu0YxSPzg/s47/tlyJtc7trcSRbCmzDM1yDzZ5z1rGVC1E+rIs/qnV
 Vsv+6hBBGIkDYHMQWfSe6G1vuBZIOd+aZ4nVeYd4sC4Cnx2DQyFMBf5hIi3f9OskRYM=
X-Gm-Gg: Acq92OElMPPwHDWqpIgzQH+AHflsyYlUT1isdIQE9OCJ8cbIePn5/bb7NwBfXKA5ewp
 cN3Hz1kFqFAOl5IJPiewyp1pRsDVaPqsDu8XiiUV3630+Qz697kTnM5/eaMOdbTe+b2Dbno3Nvd
 9zlEx6POLudQYV5/uTidrDp0nfo0TxjcdqJd85GaXnodHSqeoflKsrA1vma+vTU+p4Kg8yuB7/S
 2n5y+VmlLUC51MXshJXMrnlA9IsZxBgOkgqkG7QyWv0/xAJaZlKxepLtmJg5CnNSdHw0yuWJpZw
 XUdOEdeeXFqi2IhjRtYCvXQ8v1WFz6kx8+mmiMUSO+AsRsV2EFdYdb+ekB0hKYzt/cSQyy+v03z
 2ZoKbzkQP9TWCLO2AVvF1TuvsGaDZZLHCtMHPZCGciVoIP/L7wy4cEAv4ZcthWdJ+G17OXZobee
 Sg8YdbY1ey57TS6jsa/wHPyAwnnZpVJE+NWA==
X-Received: by 2002:a05:690c:600f:b0:7ba:f690:70be with SMTP id
 00721157ae682-7ea49872b63mr39036507b3.7.1780503549811; 
 Wed, 03 Jun 2026 09:19:09 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea23591b26sm19017787b3.31.2026.06.03.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:19:08 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/4] linux-user/sparc: restore L/I registers from RSA in
 sparc64_set_context
Date: Wed,  3 Jun 2026 12:18:50 -0400
Message-ID: <20260603161852.1831864-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603161852.1831864-1-mattst88@gmail.com>
References: <20260603161852.1831864-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112c.google.com
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

The kernel's do_rt_sigreturn loads L and I registers from the register
save area (RSA) at the restored O6+STACK_BIAS.  QEMU lacks the kernel's
window-fill path, so restore L0-L7 and I0-I5 explicitly from the RSA.
I6 and I7 are already restored from mc_fp/mc_i7.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/sparc/signal.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git ./linux-user/sparc/signal.c ./linux-user/sparc/signal.c
index d339f89928..fda5508c48 100644
--- ./linux-user/sparc/signal.c
+++ ./linux-user/sparc/signal.c
@@ -656,6 +656,24 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->regwptr[WREG_FP], &(ucp->tuc_mcontext.mc_fp));
     __get_user(env->regwptr[WREG_I7], &(ucp->tuc_mcontext.mc_i7));
 
+    /*
+     * The kernel's do_rt_sigreturn loads L and I registers from the
+     * register save area (RSA) at the new O6+STACK_BIAS.  Unlike the
+     * kernel, QEMU has no kernel-mode path that triggers a window fill,
+     * so we must do it explicitly here.  I6 and I7 are already restored
+     * from mc_fp and mc_i7 above; restore L0-L7 and I0-I5 from the RSA.
+     */
+    {
+        abi_ulong sp_ptr = env->regwptr[WREG_O6];
+        /* LP64 O6 is biased (8-byte-aligned - 2047); low bit set. ILP32 O6 is 4-byte-aligned. */
+        if (sp_ptr & 3)
+            sp_ptr += TARGET_STACK_BIAS;
+        for (i = 0; i < 8; i++)
+            get_user_ual(env->regwptr[WREG_L0 + i], sp_ptr + i * 8);
+        for (i = 0; i < 6; i++)  /* I0-I5; I6=FP and I7 already restored */
+            get_user_ual(env->regwptr[WREG_I0 + i], sp_ptr + 64 + i * 8);
+    }
+
     fpup = &ucp->tuc_mcontext.mc_fpregs;
 
     __get_user(fenab, &(fpup->mcfpu_enab));
-- 
2.53.0


