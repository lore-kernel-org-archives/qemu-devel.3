Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97152C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinGz-00029c-4b; Mon, 26 Aug 2024 23:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinGw-0001zr-NC; Mon, 26 Aug 2024 23:53:34 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinGv-00041y-3T; Mon, 26 Aug 2024 23:53:34 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4fcefbd6bc4so1921276e0c.1; 
 Mon, 26 Aug 2024 20:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724730812; x=1725335612; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwtuD6r+LaOIV6qzEM4pjOGO/u2N1OLV4/0xzbsy4jY=;
 b=aZO6ZlgutQ2UnFRE432JpcssV5VWX+OWvxWufJy3JA84kPjrq7gdG9nkRTXISSTgrn
 Cl0v/74JeBXvOxA94+HR/wK234jfy0DILkCJueD5FOpy1/swJSrSSsRzJV1mPJvvHXBo
 rkAc9meuV4Y+suoSTBjKDmAT/weFoj5FxewX4rlByhbNblCXo+RFSv9wdurXGMwjxAOx
 bq3z1EcvMEo9485h6KylcUxBHn1Qqg11SA96t9ny/oKbbPXfAEhFU8rrs/JWRFYXwHIj
 M+YeWCETg+27UQzZ4gxTmrJX0q7DBGZccoJIfSdzkyAWk5uX4fXXeC7s5ZpxRpaloZLD
 UJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730812; x=1725335612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwtuD6r+LaOIV6qzEM4pjOGO/u2N1OLV4/0xzbsy4jY=;
 b=kiNJtdBgGhru14ZTDyluVueNt+Ui7wYN45F5uIZND91EWrzvLbPsCf1Q3k7cKmoc8J
 qorqQzRONhZrFIcFa92hF+cEP5JMOYZMKykrxYxHCk6Mbk/3dDxwR2SCC097yx8doJ2F
 dQK+VBeoSbXmMkgfCOgF0MNfB0gqHDmsqro0CdWHzylkJ31ghqkcQBfPwgOGZfdI06vp
 y+qwu1V+jGk1vZ+RynyuV5i2/PWz60lEXA8E/hH89uY3WYkVpI0JWUEC/kbqjmxnp5Rl
 s7Mxmt4NGil1NGiZMgQ9wf0Mign5KwAHj7Ywf3w3X0ZTQHiyjup7V4M2Ps+88oEBNe5s
 QVww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCOoGodKGYwaiwBqmaHOcyGaXJ/5GJfSmlc/3E7Yq24CX4FCGWHaMRH6HGe8vXSwRgA9xR3jpnz/Zb@nongnu.org,
 AJvYcCWw5jmX9Q3GX2LuQLW/8uGh4zI6XjzpUbolOrhAubpXED6HAPFw64kYJaJ+quqmQrlJU0Bvm0dAr5SUNQ==@nongnu.org
X-Gm-Message-State: AOJu0YxH5oNFekFd2d6gzNxOzEyjymq+sDxaibCr4D/7PZZEaOuw0v8X
 /1vdgzk3sezWuvVTeF3OoGFdnkZNzLBMnbspg6RaT+HoEzTI9T3NY/xLFhvH7FsJdq7S0jTwPIP
 Y3bnvKSunCbzYn4eCw8VKptpbNK8=
X-Google-Smtp-Source: AGHT+IEDrkfw9s95wq6Q2IUE9fWNQYdpo1902eA/nTbS6CNLgrK7Wo7AeVFOtb4r+BFudS/jlrM6nwy+IHxFANqKgHk=
X-Received: by 2002:a05:6122:222a:b0:4fc:e4f5:7f83 with SMTP id
 71dfb90a1353d-4fed5df30d7mr2324052e0c.9.1724730811578; Mon, 26 Aug 2024
 20:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-4-debug@rivosinc.com>
 <da021104-6836-4e5b-a8a4-991f975c553c@linaro.org>
 <Zs0jURx7jbgd64jV@debug.ba.rivosinc.com>
 <056740af-1b61-426a-940d-3ca118ebd081@linaro.org>
In-Reply-To: <056740af-1b61-426a-940d-3ca118ebd081@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 13:53:05 +1000
Message-ID: <CAKmqyKOni_x8bw_3TfdV=xGg0MX-NPnPgo84dsKojdRqO_j36g@mail.gmail.com>
Subject: Re: [PATCH v9 03/17] target/riscv: save and restore elp state on priv
 transitions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Aug 27, 2024 at 11:36=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/27/24 10:52, Deepak Gupta wrote:
> > senvcfg and menvcfg belong to S and M state and don't actually mean any=
thing
> > for qemu-user.
>
> Certainly they do, in that you obviously have arch_prctl calls that adjus=
t them.  The fact
> that you've modeled those so far as separate variables is part of what is=
 confusing.
>
> > However if that's how it is for arm as well (i.e. exposing system
> > state for qemu-user), then probably there is precedent.
>
> I think having special paths for qemu-user in target/arch/ is maintenance=
 burden, and
> should be avoided if possible.  The best way to reason with user-only is =
to treat it just
> like the full machine, and set the fields just like the real bios and ker=
nel would do.

I agree about avoiding adding these special variables.

Can't we just use the extension check to enable it for userspace?
Exposing the *envcfg CSRs to userspace seems tricky as everything is
currently built with the S/M CSRs removed from user builds.

Alistair

>
> > So while shadow stack and zicbo are similar in terms of enabling. Landi=
ng pad
> > enable differs.
> > You still want me to generalize *envcfg flow?
>
> Hmm.  I'll leave that to riscv maintainers; perhaps a third user is requi=
red to show
> generality...
>
>
> r~
>

