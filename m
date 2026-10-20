Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55218606A33B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZTkE53aQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJAkQ-0007bv-Qu; Tue, 20 Oct 2026 10:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJAkM-0007ba-Ks
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:23:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJAkH-0000ME-Qi
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:23:22 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso2235985f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792506196; x=1793110996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PhEtv1OD731M8BFH8OVnS47WdL7/GHTXLfD8WW8QLTs=;
 b=ZTkE53aQ1Od3/RiaRZo8N771+l7TzLWwaJDtpy2gV89/RhrvV3E6QmRKifKm+ghgJe
 boKpuwgZL6Wl/2bcdFckljZDxkusqt/aDcYWH8hKE5UzTFcOEz+TfpFvl2P26EJTkhTJ
 QS+EztMeQUbBrdiE2KWL2Ndm4oiVm6YUAhx43RZFPdh8S3DQ4E5stwZeg73TYCZOU3AS
 A03vQt83DQKIORu6MjpdIR8A1lwnPW3CnNPlAltsMzx3FwWIVE1BMBybq4+hFgIhY4OY
 EbUTZNngaxffChFssex9imGVxmGa37pOOw292ce4I88CESmG68JNSZnfajxHSs7rF356
 WdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792506196; x=1793110996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PhEtv1OD731M8BFH8OVnS47WdL7/GHTXLfD8WW8QLTs=;
 b=JSDpggr9GhXaKlgqCVXQcU53aZEGJUxrvIyTkGYCgAFlEHE2+D9gSt9fmYR9to12m6
 FJbEPkFIT9XSOSkqPFt8W0xHeKNwjebiaMZEJYvX3r7+5XUdzqzOmh5w6warP3RQ9k70
 +CElXnlvKJQVxvKULVlfAcgRQA7lWsxU4TsYQayvhO1obEujVap/GPs3z3O26iiao+1t
 /fxdaILEosc7xZji6SfAOFdUqsHfr8O9FZbKsKh2/Ome+AEQ/YZYlhhJt8/bewHhyB96
 6ec/tvtTfSNkgWH7O2lFYFPaUBIgAzZqrgX35UitH4f+UW6vc+rkIdOnqsHbU71Nr2TB
 X9Gg==
X-Gm-Message-State: AFq9FYK4XjfGh3e0VfvpC5LCR23cnws9lshuHTM6d6iB6Vu4vcoDlpie
 H4ZgzQe3V4wxvKYdtihXGn41sWHobdlp+IVSvqnEqNNpjkiIEdA8ShAbnn86FoFOCJha9OY2nEm
 gYJkQxoI=
X-Gm-Gg: AYBFou3ET3xpJIz5gZ/9sRkX3q9C7cjl7B4Ky79Vgg+Cd2Ga9AuPdAYz0uhWaNNYqKF
 AmzGB3CwEn7xfH0LfdR4BWdVM4IUbQGjNjamNTUraCdTRoYGOpyPSWY08Y2pgjAIZPCpxx5wFqs
 LpURi0DM46vV1/Bn+CecnatKy6nGCV+af58sJvZbN/dm/xtf5sZuyB7GofraVbdrSnLsbLvpho5
 +A5eKPWmLdkztpRqUTI6ZUM3o27GUFvnwepzx9gxqyWeXr1F5NOZA9oU83T8trjQkxQPiiTUSLc
 /CZEmGNSqj8FD9Ir0vGN4L1JXrm3DG3I/V02t0eHTrWcyhRQ5K0phM14AbgZemZuakcpiUxXitL
 xKkR4ti/n2m0iPubPqLN24JS25lXQhmplLNHjADTugnSzU7u0GwyzFT6psXkAm00X9Rq9+cUEOl
 0IxiqJCX1YGZAExkqVwuIsn1hkMwxXEoUxm72D80cFaVfbHzcVnu1TpBQixdXETEe8MmaNCB/Mr
 pZ1hZ5IARnabfsOV0Lapwpig/+6YniPnU9zrx3nhbWx5doFXfw7NIytPFePAerYGgkOti/9sKW2
 5AY=
X-Received: by 2002:a05:6000:2982:10b0:48d:fd48:86c0 with SMTP id
 ffacd0b85a97d-48e07fb83e1mr16747041f8f.47.1792506195751; 
 Tue, 20 Oct 2026 07:23:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d82dec7sm6380907f8f.46.2026.10.20.07.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:23:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH] linux-user/loongarch64: In extframe_alloc,
 align before subtracting sctx_info size
Date: Tue, 20 Oct 2026 15:23:10 +0100
Message-ID: <20261020142310.3860421-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In extframe_alloc() we allocate space on the guest stack for a
context struct, which consists of a target_sctx_info plus a more
specific struct such as target_lasx_context.  The specific struct may
have a higher alignment requirement than the basic target_sctx_info.

The Linux kernel code for this is in arch/loongarch/kernel/signal.c
in extframe_alloc():

       unsigned long new_base = base - size;

       new_base = round_down(new_base, (align < 16 ? 16 : align));
       new_base -= sizeof(struct sctx_info);

and it first adjusts the base (SP) address down by the size of the
specific struct, then rounds that down to provide the required
alignment, and finally subtracts the size of the sctx_info.

QEMU's version does this in the wrong order, subtracting both the
specific struct size and the sctx_info size before rounding down for
alignment.  This means that for the target_lasx_context which needs
32-alignment, we instead give the start of sctx_info 32-alignment,
which (since that is 16 bytes long) means that the
target_lasx_context is only 16-aligned.

This manifests as a failure in the TCG tests such as
loongarch64-linux-user-signals.test if you build with the clang
sanitizers enabled:

../../linux-user/loongarch64/signal.c:182:13: runtime error: member access within misaligned address 0x7dc793950b90 for type 'struct target_lasx_context', which requires 32 byte alignment
0x7dc793950b90: note: pointer points here
 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
              ^
    #0 0x57216113d881 in setup_sigframe /home/pm215/qemu/build/clang/../../linux-user/loongarch64/signal.c:182:13
    #1 0x57216113d881 in setup_rt_frame /home/pm215/qemu/build/clang/../../linux-user/loongarch64/signal.c:389:5
    #2 0x5721612a5041 in handle_pending_signal /home/pm215/qemu/build/clang/../../linux-user/signal.c:1349:9
    #3 0x5721612a46ef in process_pending_signals /home/pm215/qemu/build/clang/../../linux-user/signal.c:1401:17
    #4 0x57216113baa3 in cpu_loop /home/pm215/qemu/build/clang/../../linux-user/loongarch64/cpu_loop.c:121:9

Correct setup_extcontext() to match the order the kernel does it.

Cc: qemu-stable@nongnu.org
Fixes: 9d5cd6587a70d613 ("linux-user: Add LoongArch signal support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/loongarch64/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index eff75bcdc86..04015e06fda 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -111,9 +111,10 @@ static abi_ptr extframe_alloc(struct extctx_layout *extctx,
 {
     abi_ptr sp = orig_sp;
 
-    sp -= sizeof(struct target_sctx_info) + size;
+    sp -= size;
     align = MAX(align, CONTEXT_INFO_ALIGN);
     sp = ROUND_DOWN(sp, align);
+    sp -= sizeof(struct target_sctx_info);
     sctx->gaddr = sp;
 
     size = orig_sp - sp;
-- 
2.43.0


