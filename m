Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47664C98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Z4o-00026n-OY; Wed, 23 Sep 2026 22:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Z4m-00025t-3s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:20:45 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Z4h-0003SM-VT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:20:43 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-85d440939f0so18712387b3.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790216431; x=1790821231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfedUkmTlAcEngOljMkzPGmSr4h0UiseyM0IViC3Rus=;
 b=YQoWrjp4y6ufgROgv7+Ts0EYh1CRsZy40qCoBMrjbdeFaV1u3snZxfk+LKb7Wdljuy
 lWfygMCLvwcNqgsu4s7wJsMTlqtIQnJYccAHhkvMVfHXcB9lD2KTUF5Uq3Gbun6g8YOm
 Rzs71Tes3TF/8bNvWikfIkMcs1xbYAVI/ez3BVzeEoMLHzbO0aKx3MHMG+6J/lyD1OvN
 0DO+v9FQmKoixNPvgE1aYylNPY2B4J9+hg3qqfZIuiIXUGVm0xN8Tc7QMf0jFpR+nVC8
 SHpGwDlwrqGXV6QSO9suVst6DGBochiHIXI2PC0dHvYNhdDAmbwqUcWxAwSWj1e3JpLw
 JqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790216431; x=1790821231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfedUkmTlAcEngOljMkzPGmSr4h0UiseyM0IViC3Rus=;
 b=s5kbVMwVI8BWyKwH/cRKMtWmDk3Em0/lBtSae3ryUhGe9mvhqQJOmbPT7FNtBHMOk+
 V0qG+8I8gsOIoTeL0FnIR9oa1Yq2RuKLDsRI8s9XO1i+acgkYvpVZLaoWvBQA3WaNN5k
 nhLnSa9/IWKwCayO9yVE5p0k/W5Y6db9yrJ8f4Dk3UUdNfD6nqAOe8Ut0khB4iq35vVA
 qeGEWrW6N2KTNlNSFFNpmH8pTaAGcXgSatt977rJj7+zqTGihFt88cTkwN6kjRWPDZsb
 BfUJOgTVayN3/b9C3XbnRi10ihNG7rhzB1ouetwkx+2HhB0x/54l95zD09U7D7G1gjPB
 hW7Q==
X-Gm-Message-State: AFuF++lXR85+CQ4Yyf/7vD0aqzghhghJyQ8xzyPDLb6x2uPE1cRlrTYj
 fzdfn88kdb6hknorSu9YmUydrpkGB7OaWVdyHXZ9neue47i4Y0k9GS/JyQEYWQ==
X-Gm-Gg: AYBFou1wKFUPXAVQxQjZt//16ulisO9P8/taq8UfNSOeFFyTn2enwA1sEG8WgT6wcXH
 q5V9vm++ztB/5AqYktt805PocCboJcOXdUWw87+kxhrHguWssqqCiK7c5MRqxf2DvzRgLXkOje6
 n6mxtQdpvCbf+x1NiuE66pDgnaBRxSd3H1B5Yo3GGxdBpnS06yRKSJgP2ZBQ276asDQESLgURsE
 GiLky0fQdOY+gr7hGE6IP3nO1oA0h73/2AUic9lBg4APnGhURJpGuOlrHUyHv3G7acbcabSTFTy
 0/I+VCKvm+bzac2EOF0q5M6arupG4n9ZVlrbr/OSGlP48l+yzaz4Ly2eQhFZgip0T5FMZSSreED
 vDi+GV71jpn+mIA4SW7wtoGwsshimMO6Y5DLivd76cEdr2le/nppML+ivilYKPCyOqmVlWHYAYL
 EiM2wxxXZHxbKFUPjcDP2TSnlaoXlcuSTW04dXwL+4DKKgpQ13qdJVukR3Dre2yOSvgl4hs2A=
X-Received: by 2002:a53:a042:0:b0:669:586a:8673 with SMTP id
 956f58d0204a3-672ed27bc88mr509447d50.21.1790216431487; 
 Wed, 23 Sep 2026 19:20:31 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d8052b4asm1495149d50.6.2026.09.23.19.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 19:20:29 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH qemu-palcode 3/3] console-low: Keep $sp 16-byte aligned in
 entInt
Date: Wed, 23 Sep 2026 22:20:22 -0400
Message-ID: <20260924022022.2414514-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924022022.2414514-1-mattst88@gmail.com>
References: <20260924022022.2414514-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x0f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

The PAL stack frame is 48 bytes, and entInt then allocates 19*8 = 152
bytes to save registers, leaving $sp 8 mod 16 at the call to
do_entInt. The Alpha calling convention requires 16-byte stack
alignment at calls.

Pad the save area to 20*8 bytes.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 console-low.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/console-low.S b/console-low.S
index 83adb2a..157a094 100644
--- a/console-low.S
+++ b/console-low.S
@@ -23,7 +23,8 @@
 	.text
 	.cfi_sections .debug_frame
 
-#define SAVE_ALL_SIZE	((18+1)*8)
+/* 19 saved registers plus one pad slot to keep $sp 16-byte aligned. */
+#define SAVE_ALL_SIZE	(20*8)
 
 	.globl	entInt
 	.type	entInt, @function
-- 
2.54.0


