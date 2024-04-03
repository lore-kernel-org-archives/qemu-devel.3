Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1DACD1296
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 18:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs59G-00005S-Ol; Wed, 03 Apr 2024 14:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rs59A-0008VL-To
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:15:45 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rs599-0005Sp-6i
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:15:40 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-60a0a1bd04eso1655057b3.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712168137; x=1712772937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3KJOiibbjl1U+vyff9cAFt69ydGCC60MJHh75ShN0g=;
 b=KpEOueR6YRpBeMav3F84URnvcvJO6keOgjTs1AkbXHXPAmAwYJbWGKuajMA4RjqsBn
 JO6PC6Tz0vuQF5y91sGYFcZSbwt0wrsOQLVHKO7wHu4EzXkqrldvxb9geETzT2Ekhrd7
 HUL481xPECpEI799VUbVvlaAvTVmahIRBlKrk9+COMOWJtCDVdsE2UXeku45zxvZpjDm
 UbUVyna9OPEd9WJb//dfMFtWhu6wXOZq2kfQ/pvft9hlqHkD7okF8WSa4GsXIcL7LMdL
 0ucmbC/WkepQcA3A1wczn/BND5sQeFZ2toWZnC8RY24d9KMFomJIMta9dKJ31cJE6KAV
 EvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712168137; x=1712772937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s3KJOiibbjl1U+vyff9cAFt69ydGCC60MJHh75ShN0g=;
 b=FsHpJS6H2BUY3SbBIxC3Gh+mQW4kMFJxguaslZNkxU+X5lQquez8sB2Xt0s/qj28kT
 lU0bQEFnYGP1tGu4TkPh/bsBiOl2ZsKVjUI9MIG9ckhISl9dtDmeTnCtgz3E5VHGwW/t
 mESgcsy7EqKfQSoGx+KEROSgi600wG5TzfHgd5kIiz0Pbb4bFX+Ub9/ab4Iq/KuyOHxA
 6/HHvU9Lb2ZZbXgrS2+ECHZ0Ex9s2AYJLsbwGHeyhIO/VHaqbn+MEv2+QdOfet3fZa+8
 s3bi0kG3HmmiiGvoMHV+RWiK3bmKXB3NtE2WiZe7z9OEjXU/g0O3WnQB1UyXc11fiwrY
 QHug==
X-Gm-Message-State: AOJu0Yzmo3FzOlQs78vlLIQ3BqsDshgGFbKc+NeVpxJB3tbIAqzmPShX
 68KJoZj2QlpeSuZKtUBvCJ/LjbUkxjzNJwvHrl4Nl3j2NrC6CzxSOw2Z6/XRIHGRKBCaeEWwNP8
 mE0TcJL6w5LdiL10+U5NjhabQSNg=
X-Google-Smtp-Source: AGHT+IFm0b/YXKMpU9S4ZVso3C6jYIQJTk0lXqWK6XEUPzAZpcTwBfsRJQGl1BYJHdLHYYko2xh9K0pz6fjaiUYaeyM=
X-Received: by 2002:a25:4e42:0:b0:dcb:cdce:3902 with SMTP id
 c63-20020a254e42000000b00dcbcdce3902mr200588ybb.55.1712168137470; Wed, 03 Apr
 2024 11:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
In-Reply-To: <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Wed, 3 Apr 2024 23:45:26 +0530
Message-ID: <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
Subject: Re: Point where target instructions are read
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mindentropy@gmail.com; helo=mail-yw1-x112e.google.com
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

On Tue, Apr 2, 2024 at 2:01=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:

> The boot process must cooperate somehow.
>
> When using loader, you must link the image such that it loads at the pc r=
eset address
> defined by the architecture manual.
>
>
> r~

I changed my loading options to the following now to have better control:

./qemu-system-msp430 -machine msp430-launchpad -device
loader,file=3Dsimple_test.bin,addr=3D0xFFFE,cpu-num=3D0,force
-raw=3Don -d in_asm,out_asm

Here simple_test.bin is the raw binary file converted using objcopy.
addr=3D0xFFFE is the vector location where the PC will load with the
starting address.

Now how do I load the address in that reset vector location and set my
PC? Is there some example code that I can look at?

-Gautam.

