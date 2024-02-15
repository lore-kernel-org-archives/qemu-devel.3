Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC17C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYOD-00073u-OF; Thu, 15 Feb 2024 04:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raYOC-00073b-3r; Thu, 15 Feb 2024 04:50:44 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raYOA-0000gK-Iy; Thu, 15 Feb 2024 04:50:43 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so597870a12.1; 
 Thu, 15 Feb 2024 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990638; x=1708595438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oStExKZl+eVZ/0dzLrtb7ge41o3rCTsY02mrLfMdbCA=;
 b=UC67SvRFcCkvVfGbHkHiLrQRfZAhw/FRkNnaKW18Rqpb39MdhNGMBLublDUId4QvDo
 NYMLHqy0Fsyft3I2IqPmf0iVTi3CzXB3zUHnAVj4CYcc6C2RL1pSQssb3dVVvs9+6RXP
 GP4AKBDqSEQ41k6IURc8TqkwqwHHONg0XPRdRso4sl5hejRO4VmGtjQx8+pZBAujh+E0
 3/zjanQ2FQogA/3srobLGxD2jqVQBzMc3ebVG9qiywpM6fp5VQtCnwbfX19itzHrIDOW
 /UxCHCH3ZAqcbqE8oPQ3I8Kufo1UCTOAIRmpjE8mrdfWR8GJz1+p0DBRql4Zt1VlUPDY
 q93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990638; x=1708595438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oStExKZl+eVZ/0dzLrtb7ge41o3rCTsY02mrLfMdbCA=;
 b=LG2kFATI68pNcdp62vWy3TEutmeY3ecrJ5bG64nWCcVRywapHveCC0dVbpf/lQO8sb
 S9YVkP7eGq9lxuaDSv4VBh7zbL8bdeWGW1uK/ntGMvpGUEkdfRgnHi9joXZbkcmEuNGR
 osOMUMHhVsYCbIronHxYVl/0Gjq4BpXYCAp6z91r/vpDpAWBEfAUxDduDT1nAF1lPAtI
 GIdW5uSrYJFSalLfDxwKNpY335ZVcqwo84L9XLfgYLvQM+1xIJDiMARNBYhEtQ363mzH
 BxDWa++Pqi1dW0JbVR9l0rKs7iaMDrdqGD259VdpxFVZ2GzUM++unkFjNSiW2sFvfPSN
 A2vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhJn4gEMWqXlDmXmzljKpaIk+NorjHsF7+j/SMPrtTY4ChD7lWw3l2O9g8oV4MrXZxP3+NwEyaTRPTx9zn2fWewhpeXM6iwA==
X-Gm-Message-State: AOJu0YwLJLPXWJTvwcVRd0HPBck0lonubLrwkREKxE2vS8RgXywiNXki
 9+EMYERiUPbp85pJ34L9OCkLfu7jmrp9FrrQDk8JpYkQgwyIip4mlmZ4Z0nOik8=
X-Google-Smtp-Source: AGHT+IGt0Jw+ojrD+rXCFe00iTnkzWaulfmsWZsGTgCxJ/VXCNJVoHH8iBfMVz/xXQPUPJ9DBvonBw==
X-Received: by 2002:a05:6a20:9f05:b0:19c:9f1b:1d8d with SMTP id
 mk5-20020a056a209f0500b0019c9f1b1d8dmr1613642pzb.12.1707990638477; 
 Thu, 15 Feb 2024 01:50:38 -0800 (PST)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 a10-20020a170902b58a00b001db839b9e80sm863966pls.286.2024.02.15.01.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:50:38 -0800 (PST)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/1] Fix tcg assert when decoding "lock cmp"
Date: Thu, 15 Feb 2024 17:50:15 +0800
Message-Id: <20240215095015.570748-1-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

(Resending again because I found I accidentally unsubscribed the list. And
sorry for disturbance for Richard.)

Hello QEMU Developers! I'm from the downstream project Unicorn
Engine (https://github.com/unicorn-engine/unicorn). I identified a simple
bug that triggers a tcg assertion in QEMU. Although I used a usermode
usecase to illustrate the bug, it shall also affect system emulation.

Assume a binary looks like:

```
08049845 <main>:
 8049845:	55                   	push   %ebp
 8049846:	89 e5                	mov    %esp,%ebp
 8049848:	e8 0e 00 00 00       	call   804985b <__x86.get_pc_thunk.ax>
 804984d:	90                   	nop
 804984e:	90                   	nop
 804984f:	90                   	nop
 8049850:	90                   	nop
 8049851:	90                   	nop
 8049852:	f0 38 b8 00 00 00 00 	lock cmp %bh,0x0(%eax)
 8049859:	5d                   	pop    %ebp
 804985a:	c3                   	ret
```

Executing this with

```
./i386-linux-user/qemu-i386 -d op,op_opt ./tt 2>&1 | tail -100
```

gives:

```
OP:
...
...
 ---- 0000000008049852 0000000000000000
 mov_i32 loc2,eax
 extract_i32 loc1,ebx,$0x8,$0x8
 mov_i32 cc_src,loc1
 mov_i32 loc8,loc0 // loc0 undefined!
...
...
OP after optimization and liveness analysis:
...
...
 ---- 0000000008049852 0000000000000000
 extract_i32 tmp1,ebx,$0x8,$0x8           dead: 1  pref=0xffff
 mov_i32 cc_src,tmp1                      sync: 0  dead: 1  pref=0xffff
 sub_i32 cc_dst,tmp0,cc_src               sync: 0  dead: 0 1 2  pref=0xffff // so does tmp0!
...
...
ERROR:../tcg/tcg.c:4446:temp_load: code should not be reached
Bail out! ERROR:../tcg/tcg.c:4446:temp_load: code should not be reached
```

This results an assertion error because when decoding "lock cmp %bh,0x0(%eax)",
s->T0 is not properly initialized in gen_op. However, the root cause is that
this instruction is illegal refering to the Intel manual. Therefore, I add
and extra check to generate corresponding illegal opcode exception.

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>

Ziqiao Kong (1):
  Generate an illegal opcode exception on cmp instructions with lock
    prefix

 target/i386/tcg/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.40.1


