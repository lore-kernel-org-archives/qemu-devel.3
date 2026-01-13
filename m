Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B719D2F359
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfjAC-0004T7-AQ; Tue, 13 Jan 2026 13:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1vfj9z-0004Qe-GE
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:30:34 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1vfj9w-00028Q-Ow
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:30:31 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59b834e3d64so5269369e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 10:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768329027; x=1768933827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sw5auUm266OABz46f1ivfCDc4BRcn4VP99wRuJhAt6A=;
 b=P9aP71Xl7JjGBjBTMBjKDqx3VUUK/uI8X9c2fwOiQhMDhg/0WzTd6ONYl4YTLFZicF
 6rciEff8vE+luFPA7nJtEUlH9rvWZVXHgQD9vjjdBX8ABLLIhjidtfAVpIkX43gesQvr
 hJYyS/iZS+8YGEzPhCGpXPQZuQ2GVnnSPZVNNRyQIUicgjnPwG7Wyr/6+eiYxk45wj9+
 DZsA6SVatxiup2aFYD6P7vDgJ0BUtgGAlmiM4SxJRmtLLvmS/al5CUN96c6Dad9Hr4f5
 6QOog8o1CERu64avY64Pnojqdo1YiBbMyE61uGgXYG2Nhba1r6wew331uYbvRp6phU5r
 2iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768329027; x=1768933827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sw5auUm266OABz46f1ivfCDc4BRcn4VP99wRuJhAt6A=;
 b=aMaZY708lb7Q6fufx9hkl5mAWWM20Ck22gHpq5VaVUAfOy2D9Uum1HIqXDg46b0hA9
 1NSR5KFKQZfMjyFLJFyeflm9mC6Ky1ZlCSqfe/qmJBMRMAEh+tpR8ZUdKXfj01e03fu8
 WdA29nRH0JWnK4HiBgLdYsrsSpuYw/IDGb7AyXnT+ahQN3SOT2U/TNzoCRr9ghJHO06W
 Jk4r6QmsFTJfESDw45hlWAHnJJAbOY7P8D8wPRG1a0ir0lIZWTGKRciObA7pCb39PnSs
 zU9a2JKQeN+6A3EeBITPOM2qfbEf31ZVZIwUbEF4bzOUvUH1UgOWvbVg+qVqFU59Op9b
 MF6A==
X-Gm-Message-State: AOJu0Yyv9cOkuRlkZaI6mIlrKomI5uD5Bo9wvvdMX+aCy40H1a+cJHev
 Yh25ujmypNxC1YUBtKSE6Kd96WGghKhfHo5c8qJEbEaaLeN6pW6ClGD3Y0fyL2TntPAbv/gtgTL
 SgXAXGgV47Fbcvp6D0HRpwcZU73GkR4G8UqK5
X-Gm-Gg: AY/fxX6dzr0et+QUCjfGB5OmQIjFacawLpqZN3cSYl51ec6z+e+Z2F4fz0yK1sIK4Du
 w5XZYueJScKsd5ZpVmYHppLas2LvmGjRRfpUzy12bTVxZKg9g+IXMomIW2QuaX9pC86XEgUQqG8
 bsEIYitnONpEXjRXUbK/ObK1UYebmcwu7bhpFCqn01Rt0Fu7cK5s2gRe2MMhGOkUrIybsu80bEM
 ZxWSh3nKIsvXn6bAtKn77xI8gCLyWIXKXSL+3YomoD/vRKxCrwJ1mCC+bq/6TXFJYba4k/c
X-Google-Smtp-Source: AGHT+IHlpTmFSru+whDsMKJ658jywaNsILIXVC+bv8l+jE3pY17BaG1MF74+ZA7uhROAKH8y6Q8pbM3pdDgFOfsOWho=
X-Received: by 2002:a05:6512:39c6:b0:59b:78ad:fb9e with SMTP id
 2adb3069b0e04-59b78adfc61mr6314335e87.10.1768329026364; Tue, 13 Jan 2026
 10:30:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJhHMCDqZE-TwmbPhDeYR0ZZYJRcV3tvcZD8-+rz7WE-oDMgQg@mail.gmail.com>
In-Reply-To: <CAJhHMCDqZE-TwmbPhDeYR0ZZYJRcV3tvcZD8-+rz7WE-oDMgQg@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 13 Jan 2026 10:29:59 -0800
X-Gm-Features: AZwV_QiC6eUZZNeWit90AEy7lySXPDRUqL-S6MqmNhTOODCQ4Kj9hiyvj_Wn4Ko
Message-ID: <CAJhHMCCSq7BqwruoptN5YY6O5tSNivcm_yuAG5Sas2gAYbfW7Q@mail.gmail.com>
Subject: Re: qemu-x86_64 fails with 'Illegal Instruction' error
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=bobby.prani@gmail.com; helo=mail-lf1-x134.google.com
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

On Mon, Jan 12, 2026 at 11:34=E2=80=AFAM Pranith Kumar <bobby.prani@gmail.c=
om> wrote:
>
> Hello,
>
> I am trying to run spec intrate with qemu-x86_64 and it seems to fail
> with an 'Illegal Instruction' error. I tried compiling with an ancient
> architecture (-march=3Dcore2/athlon64) and this error persists.
>
> Is this a known issue? Are there any workarounds?
>
> Trace 0: 0x7fffe806fd40 [00000000/000000000050d8d6/1040c0b3/00000000]
> Perl_sv_upgrade
> ----------------
> IN: Perl_sv_upgrade
> 0x0050d8dc:  c5 f9 ef c0              vpxor    %xmm0, %xmm0, %xmm0
> 0x0050d8e0:  48 83 c2 10              addq     $0x10, %rdx
> 0x0050d8e4:  62                       .byte    0x62
> 0x0050d8e5:  f1                       int1
>


This is being caused by the instruction 'vmovdqu8'. Disassembly of the
binary shows:

11e69c:       c5 f9 ef c0             vpxor  %xmm0,%xmm0,%xmm0
11e6a0:       48 83 c2 10             add    $0x10,%rdx
11e6a4:       62 f1 7f 08 7f 42 ff    vmovdqu8 %xmm0,-0x10(%rdx)

However, tcg is unable to decode this last instruction and traps.

I wonder why the 'march=3Dcore2' flag is not forcing gcc to disable this
instruction sequence.


--
Pranith

