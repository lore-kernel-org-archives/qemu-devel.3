Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB522C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabmc-0003hp-5I; Thu, 15 Feb 2024 08:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raY3f-0004L5-J9; Thu, 15 Feb 2024 04:29:31 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raY3d-0004GX-OU; Thu, 15 Feb 2024 04:29:31 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so484949b6e.3; 
 Thu, 15 Feb 2024 01:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707989367; x=1708594167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dxETrzZs6v6x2GkrIM8h7gsGJ6oZgwCCQ3ysSkDrvgA=;
 b=bQJSJXh0gJeIwd44ShKTNpwe13mjWOudcWYtufTdZXMIJpwhyKVAXdufS5/AhRXZgE
 YdGfs+dRz9mJdnLN9novQPOrF/dzCxF394O2vhnQtgrrG7DCaUBbwHp2FGWBK5CdvQ+O
 YZ1Psa8aSOKkuUru+YMAOu2O1ACLNBgMMeLYmjwE7Bi9htSX0PHOpzLeVeBItLGX6Ez7
 +R0v5oupxQRlbCOCUyxVKCWzUgC+oII/SLTxtx7PPIVIdJQeg6xBNMNkSZlM4jOEy9PG
 HxyqqUFNHrG3PK+p7g/Pq475AsKrny6HI+ahL1uL2IFGnTlVhk6+I8c1qTUXyva6gEeR
 8mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707989367; x=1708594167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dxETrzZs6v6x2GkrIM8h7gsGJ6oZgwCCQ3ysSkDrvgA=;
 b=DU2uRJ91LdlBsPmrElNbee3sECgR93OgATdRBILBQamsdrfRu3FMlKnnrJ1km5sbpo
 NrMF/X3lQAA5HU3LZBbd87aIYsoIZ0ZLOjcActYXIZVcxEE7KecUOob8pdASEC7kqnPt
 1M4QYVOsSpITK8/DE6Qxh1PyOufh6hj2lRvu0IO+Zzy5Tq26vjswc3qIWx/z9PwPgVjD
 b0gO0RdK9ea2lUYv+6gagiJRYQ6SQZNBjtkbKPJ58LI0l/XOiO45w4tPa8cXjlrPKRCl
 bjcRguK0W7TmG5irKTw90fifhyHVp//1+avpwiVigy2lZaLU8YGrCPJ66KTsvjZFdT/w
 dBnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGYI1rSuOj+dFjD5EjTiNg0/f4tRv6PT+ELqm/Xh1Xf7La9R48z7M2c1ok47QwWzmqw+vLbI/FlUPlW5lgCVLW1ufj2hnyag==
X-Gm-Message-State: AOJu0YxMU3EZyElA7AZbZF4Y9zkKwIrFXIIbBicSwf3wHWOeZiOddgNA
 qGr28QiFUffYTTFY8lExaMKRWHmwXD41N49dSAt4dCv5K+W4pmq5wVdfb9qxOGU=
X-Google-Smtp-Source: AGHT+IE40YY8qrqqlV0YwaSSw5C8EYB0c0bXjWuiHRjbMYIvgHd1alENPr5yMMZM2IjgpDI4R4EfbQ==
X-Received: by 2002:a05:6808:1156:b0:3c0:3f3f:16e9 with SMTP id
 u22-20020a056808115600b003c03f3f16e9mr1714490oiu.12.1707989367198; 
 Thu, 15 Feb 2024 01:29:27 -0800 (PST)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 j8-20020aa78d08000000b006e04b47e17asm856838pfe.214.2024.02.15.01.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:29:26 -0800 (PST)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/1] Fix tcg assert when decoding "lock cmp"
Date: Thu, 15 Feb 2024 17:29:08 +0800
Message-Id: <20240215092908.569947-1-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=ziqiaokong@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Feb 2024 08:28:07 -0500
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

(Resending this series since it looks like being ignored by the list)

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


