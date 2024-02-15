Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70076C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabma-0003dO-Ln; Thu, 15 Feb 2024 08:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raWbp-0007Di-E7; Thu, 15 Feb 2024 02:56:41 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raWbl-00063y-NB; Thu, 15 Feb 2024 02:56:40 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-298cc60ee66so476990a91.0; 
 Wed, 14 Feb 2024 23:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707983794; x=1708588594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XYO2qbz/pDx6A7y3WzmycZDMcOwjaWvw8NqRagW+478=;
 b=LYUvK2T2R/qyaprxkVmlYkK+qoHQPijbX5HCGRTXhNNLwZfXOQEJOVZn8qUKroXRWh
 9qNT20UUxZOd+5sOGeTWbFVxXTZdAgtrGbdFe3vyn4/URVOBsEwI5zm66OkmHMsOZmxD
 XgsAFB1lm30HnPDr1G9En1EviqIXLAdjH462VfCtxWXm2qDM978YOi7gbS7zbD1H9nbz
 950ztiM+p3FRFIFkQOSUitN+ZBLnTZ+jGGxPZ9QmHRZzIRUOyoNX61bFkYSmyGJ5pTMW
 s+4/JN4dvwBxpOUOKhpTUg2865DZ9H+QwugYTMRZEGA7Cv0oXQnRTBYw3PyY1ZtJLjwy
 Bl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707983794; x=1708588594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XYO2qbz/pDx6A7y3WzmycZDMcOwjaWvw8NqRagW+478=;
 b=mbPpjcUY7ZKwIvMPNcJnMISdwRlVWhmS4uM98P2dzkpuEktufkO+RRqSHDjRDqwwyP
 7Lh6UqYC8157mD9TZKxw9iEIPjXOGGsG5hvbpds8ItuWxs/FjmTFVP6WCFDCjryxuQHG
 Bl/uSGsxE3jiQtbDPCV5XRKpt8bxUqzJhgPYHMc7ODY8tshoE5M99qza2SeHAAl3BN4q
 8JhQ5tpbOPtbBxof7lTGXlwKMGv6aB6byB2RlfIu4insMkKjrx2J8sZYWne8vuyx1oNo
 ZYdLeoEkBKC2uguvjuzlcWXmJn+ZEjskuNYi3wXbPUNWBloMy3n6UHCYvc+ed50T0ZJA
 hjXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMCmS3/fej5SqVeJphFv7+ik5zMU7QAeqou3DbpHFHkT5EQSrmpRhXaVsuB2GD0lwH8gC4HQmytQC0JVvRunZ7P4GAsbiFQA==
X-Gm-Message-State: AOJu0YyMK6Gczl8doMQJ6aJTClrZuWdYVZeFtJOn/l+Io1wwDdVlERbU
 55AjDGQVPdmUj9E2L7J10gvrMlOJWZsBJEYBvQQiS6MTN9dK8d3SDM77NUGosbo=
X-Google-Smtp-Source: AGHT+IE4vomXlvlrU6mkSJ+lZq68mY92FDA0gfbnGXyF14QefBpyZiozKLnXb23bWI1deNYomqcp0w==
X-Received: by 2002:a17:90a:6c44:b0:298:db59:b6a7 with SMTP id
 x62-20020a17090a6c4400b00298db59b6a7mr1172031pjj.34.1707983794348; 
 Wed, 14 Feb 2024 23:56:34 -0800 (PST)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 sc7-20020a17090b510700b00296fcb4e668sm2721604pjb.25.2024.02.14.23.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 23:56:34 -0800 (PST)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/1] Fix tcg assert when decoding "lock cmp"
Date: Thu, 15 Feb 2024 15:56:13 +0800
Message-Id: <20240215075613.567351-1-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pj1-x1036.google.com
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

Hello Qemu Developers! I'm from the downstream project Unicorn
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


