Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3832EE8B39D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVO0-0000VP-Kt; Wed, 04 Feb 2026 00:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVNy-0000V6-2k
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:06 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVNw-00039w-GG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:05 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a7b23dd036so31239225ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770182703; x=1770787503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjzLzhiZx67XRXi7FWdIhLXG29bt3F9fdnv1+/smnsI=;
 b=CLQgk4t4IdNUr0F2LSnKkg4eHODDIJL68e+hUe0o3XwvfgEVJiFauxZUVtHdKiNaf8
 FxgPMIuNKk76VxGPGsFaDB5pEumNhXEvJ8m+1dpOAI+n5eNNm1ZvXZpnGszJYTCtfC2S
 sdYavXa9hxnSkEnBfEL6R2d+zVNkBjaG4Zmtb1VmBWiTxwejFt+KQdEfHOdNUAMuRper
 lSiX2Ey72CSs3bbM/v9uNbzh4APTfXWZNBxI+MucQLqALRIkXYFejyeuWX5gMI/NYrPM
 SZN7REreXCyYJ95TtQZPm2bJC5Xani8WOSmA9JEMiVFnVm326+yNumyFYaRD70hRfwmA
 cYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182703; x=1770787503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjzLzhiZx67XRXi7FWdIhLXG29bt3F9fdnv1+/smnsI=;
 b=b8zoeF/7MXCGkKhJ5uBpGKa7PPoKbWTxvPiEZdB8LI+uvM5rlRuA+fNlGuAioNdz45
 fmrf9yEJPkzrU6AR9Fc3dJAIVsPY7e1JC3rljVM7dRIGLaC7GU+qm2YiUJ4b5vQFPx0I
 eevmKxd92qgMHSOPTj4yliHDQfe4z4waFAKtdMKMthKjKc4sTjZL0hNHPydZ0jPjF+TP
 2KoR8WeIg5YSQJmbsLRTHUougXN3sHcj9mKQ32pAHHf53gucNUDpO5qTHT+OzMtE1OZV
 PmCryeN0IFc47RTz86rm6DapZsDHiA+I8VfbqCA1dsv5dBkUSWSut+kWo+dkmw+eUs65
 L3yA==
X-Gm-Message-State: AOJu0YxIx9Gc8aTbPSPQETXQDLcLtMdUyLsrzktbHc5WRFwCwO+TvSYf
 fODTFN7nCKIC6ph2mIKxuf7aWf/YZK2IxEKLWz/wFHdukGeCE7z4z/l0jQ2sh3+BRQyutvyfHv6
 5NhPXEdU=
X-Gm-Gg: AZuq6aKAODAiPAVaAcZukirAMeRTCFnf9zV3JrdWVbNF3C/dw4twZBXBItNCxQNWW9R
 i6uUV9cRX8AqaVRIlUOi+F3aBGOisQZY3x466mNv6kWaXXy6nKQuLJRfVMfQnXDe5oOHIyIA5+e
 v7jArRlinr9hG1l4h72tWswJdoClOwU/Ua9yJ5Ewk6L4heV/MCUGKF95lyAp0m/VOlPp1fkGqoc
 4hFlzL7OHF0wmyls/fhtqIOcZFSlYEy+BfVCXTVEhltxBTANflCEo2dRCN6ENIZSN4iPARdYwg2
 ZbhtZXhBkgV7h0I1Nilxbq6qji0+OxJKHzf/XScDZkyP61K/5UC4IBNbsXTVsX+f1GP/WTHd7Vo
 D4iy98+Fj6/s79+BM+mGoQ8dtDg5wF+Hk3N0QnFvhGidm0URLE9x/LS9cfefIgIcO/tsdDLiO/b
 fbCokdBhQ+JaGBVmJUzgDo3XJ9faFmdvOv04I45D2TvmdGLEMfW6NO/ne1xTQ=
X-Received: by 2002:a17:903:2ec6:b0:2a3:e70d:5817 with SMTP id
 d9443c01a7336-2a933ad0624mr20074815ad.0.1770182702529; 
 Tue, 03 Feb 2026 21:25:02 -0800 (PST)
Received: from stoup.. (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c3esm10062015ad.67.2026.02.03.21.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:25:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 0/6] tcg: Improve extract and deposit code gen
Date: Wed,  4 Feb 2026 15:24:50 +1000
Message-ID: <20260204052456.970605-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Supercedes: 20260119000740.50516-1-richard.henderson@linaro.org
[PATCH 0/3] tcg: Lower deposit/extract2 during optimize

Supercedes: 20260115135453.140870-1-pbonzini@redhat.com
[PATCH 0/2] tcg: improve instruction selection for extract and deposit_z

This is a merge of these two patch sets.  I'm not sure what
inputs you were looking at, Paolo?

From random aarch64 guest binaries, and an x86_64 host, I still
see most benefit from the lowering during optimize.  It's not
lots, but every little bit helps, I guess.


r~


Paolo Bonzini (2):
  tcg: Add tcg_op_imm_match
  tcg: target-dependent lowering of extract to shr/and

Richard Henderson (4):
  tcg/optimize: Lower unsupported deposit during optimize
  tcg/optimize: Lower unsupported extract2 during optimize
  tcg: Expand missing rotri with extract2
  tcg/optimize: possibly expand deposit into zero with shifts

 tcg/tcg-internal.h |   5 +
 tcg/optimize.c     | 279 ++++++++++++++++++++++++++++++++++++++++-----
 tcg/tcg-op.c       | 210 ++++++++--------------------------
 tcg/tcg.c          |  21 +++-
 4 files changed, 322 insertions(+), 193 deletions(-)

-- 
2.43.0


