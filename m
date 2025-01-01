Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2862E7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 19:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tT4Mw-0006qm-K4; Wed, 01 Jan 2025 14:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1tT4Mv-0006qd-9o
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 14:27:01 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1tT4Mu-0000aD-2N
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 14:27:01 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e399e904940so12032142276.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735759618; x=1736364418; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DlspCG2p3pjngpFOh5rqaS+flx7a33Sr4gVoPh//Jno=;
 b=TM18lubVCduZbeNTuNnL1kfGvU5bleRexp0/eJoqjBg4gpU7tDp16CZNGEE0STvaGy
 0GQT5l38wKqJgD801yljqd2/4R/2RNt0vUnpmITeCUbNNfZc7qtHjR2v9wRFXnv5BZBb
 7uZH683Xz0jNuvep29lWLhYdae5IwZxAiISbiOf1EOH8LKekr2rQh1nttkuopU5EYTnC
 Y17PJT2Uf0Wt+9OozCBBki83pMoxfAcDs0qPn9yvZ9jP2J4kkjA/RATigs5oIhLIjrPP
 Y/ezBtzt8sw0nn7XivPwlspRVrW7vqeish2qFGrALJ5IfT4P59XHicEwr8ucuVjBv4dJ
 LN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735759618; x=1736364418;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DlspCG2p3pjngpFOh5rqaS+flx7a33Sr4gVoPh//Jno=;
 b=CaYo34LZtTqqyekshlgEbODxBgAH7FKXPBf9OdMMBgo6e1op3e2bFrYweAnyDdIY9k
 i5VGcfuM5fwThLIYqKKPxOUdTeADdlgXNL80TlpPODmyrOp7M4Xt5hsJ2bmvFGTMn4BC
 15fn3aUoR8eLY+O8pBdQfuBDOZ6zxKaCbigkhTcIwNJvjqtq8Wn7IYVVoPufdLAN3YgF
 jSNfBfyO/nw7nhsN/pcJDuJOFu+/bG8+yn111dJ3S6RyaD/h7c1vWywJ3H+q+dynEmO1
 FNWXGKwV+vb131DOklJVIcU5MRw+9ufxtFNviG6Hxpj+wUd85cpzS53HkbVJ1K7REVus
 qtpQ==
X-Gm-Message-State: AOJu0YwVK2abC2PKSUsEgYOGQaGzvAgwuUTPuJfIHXYCIUf9Xg2Iz8cp
 OPtsKTsDlqW/i/kHFbfbh5sNAr90a+Wrlyh6dNE+HzgYmvnChz0BWjRf8EY8XyvQn+dpXa/dPf3
 wRtOJgbT3uQ9N9NUKZtI/s+NH+Xwfyw7A
X-Gm-Gg: ASbGncvi0Zjp/93VGigfJjO5EcM52iteaRl0bfvwKq9UfjDKkEPJtGjD7eaHz9ylw1N
 VYziMwD15pWO6uZdJkuebd7acxbS94bPd5VC1IX553yctwEO1Ujuh2+ukhxbkLqn+7qpBvOQ=
X-Google-Smtp-Source: AGHT+IGncNYPhixFVDG1w2ssk9D4I/1g2j3XExtmCEZVCpc+wA9XioJxMkT1M6WDCTtuuJAibuCecM1fO8pYPFBYbK0=
X-Received: by 2002:a05:6902:1886:b0:e4b:3d71:3464 with SMTP id
 3f1490d57ef6-e538c3a3643mr28179778276.36.1735759618308; Wed, 01 Jan 2025
 11:26:58 -0800 (PST)
MIME-Version: 1.0
From: Gautam Bhat <mindentropy@gmail.com>
Date: Thu, 2 Jan 2025 00:56:47 +0530
Message-ID: <CAM2a4uxJFhw71emxdZrB4SF-JSzJy_-bL=g9ke7OmjUoOXUDYQ@mail.gmail.com>
Subject: How does "rsi" get set in x86 prologue?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=mindentropy@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I am trying to understanding the generated code for the x86 target. On
EPILOGUE code below:

0x7fff98000000:  55                       pushq    %rbp
0x7fff98000001:  53                       pushq    %rbx
0x7fff98000002:  41 54                    pushq    %r12
0x7fff98000004:  41 55                    pushq    %r13
0x7fff98000006:  41 56                    pushq    %r14
0x7fff98000008:  41 57                    pushq    %r15
0x7fff9800000a:  48 8b ef                 movq     %rdi, %rbp
0x7fff9800000d:  48 81 c4 78 fb ff ff     addq     $-0x488, %rsp
0x7fff98000014:  ff e6                    jmpq     *%rsi
0x7fff98000016:  33 c0                    xorl     %eax, %eax
0x7fff98000018:  48 81 c4 88 04 00 00     addq     $0x488, %rsp
0x7fff9800001f:  c5 f8 77                 vzeroupper
0x7fff98000022:  41 5f                    popq     %r15
0x7fff98000024:  41 5e                    popq     %r14
0x7fff98000026:  41 5d                    popq     %r13
0x7fff98000028:  41 5c                    popq     %r12
0x7fff9800002a:  5b                       popq     %rbx
0x7fff9800002b:  5d                       popq     %rbp
0x7fff9800002c:  c3                       retq

Can someone help me understand in which file or where in the source
does the "rsi" get set to jump? (0x7fff98000014:  ff e6   jmpq
*%rsi)

Thanks,
Gautam.

