Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4463BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 05:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v365f-00086y-JJ; Mon, 29 Sep 2025 01:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v365d-00086o-KL
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 01:06:21 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v365U-0008G2-Dy
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 01:06:21 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6364eb32535so290905a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759122363; x=1759727163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzQr7YPzngYZhsNKhMZez6vZSpF77G13d6Pqfp1bYxE=;
 b=mh/+nq05mx5MvbJbR9FsqfZg0I8DTYkyBd5ijZ201guNzgrS1fY4HtpOE3Zlf+OJzB
 OWShK7D4pUgFnrBAFjMIA9Naq+OtiGnOnPb/bU424I3KD/NZccXxqz8DkxjzFUp5VaAy
 G3gsV5jvmCzARzFBqRowh1YJCT7Ng/M64zP+Vslr7VycrBtteD76SL76HNjDorJxHbE9
 jSGeRrkqba5DWgZ8bVp5gClntG64EdtE+sVZJu0TzRaIJKzawvIUA4D7DBMCSvHwR9cU
 wdflHPL2yOLEdeM1AVbaiOK2B3i9MleQj46XE0aiLRJ9jKQ63omDk3YlSvHv4pbCfYFo
 +/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759122363; x=1759727163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzQr7YPzngYZhsNKhMZez6vZSpF77G13d6Pqfp1bYxE=;
 b=MeclbmNP4z8QpRIy9fsdZ+jR4GRtBnK4HPpGcQJ590F3UeBlxYeP7LGRCS92U5Ate/
 7iLqngABbCLVV2Wz9zteyrfJ52E0/qOuBqP1EAMAqYQCH/At5hCtZdhdU28CP6T4KBi+
 81OzKp5gR4gbsC33SyT9GKVDdamz01f+H2yXAG/4TlR5qzkFvBjsUVE3ZMxQamaMjIAa
 pvc94IbKMcwpm1lvPQuF0UmH+403pJcoNzUz1mTwl4MC0/8ESk92lJsqCnONKSXvD9dE
 dl7BRMI/2tm4JDx7B+v++kZCaOqfdnQLHvLz//Q3KzWw5gciQW2xLYgnkc6S8Wl8lb80
 DnIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJqLYTddfpVaqPVYBLreoNr9XtpJDIaJyQZBWF9LStJuFSjDobee5XB+sWQzciWZJrlnqOayaMFACv@nongnu.org
X-Gm-Message-State: AOJu0YzoByaNEaL1RXtEbaXE0tWW/OWlb29OzvserA7fs9YxOxZ7D3xo
 qXSdN0cwfT75gckhijmIPzhW6dQn9wCjpf+/D/SAaDErJqfFX061xsUXpOCWgQ/sIQcsgvsoPa/
 wL+8xBVks/rrJJbG61Ow5xc63tiYJQ8k=
X-Gm-Gg: ASbGncujgGgKFNQrL40HpmMAJIrlSHKXqw8ZcBMivHDBtiRqvybiG8h5+Y6H+V/xeKb
 ecQXLrw8tJVdbgGfCAYBtDOR+n8OXbIYv4kU2sRUGbJIKYMa57j1x9uNWfAVu9C6BTW3Ce4aBZ3
 TjTPLqieiNzVeWnyVrA9nZhGrkWt5dHa4vSatTMj+D1lO/TysBwI4Q72QN8hCy6lfLzcsMdePgi
 SbMa4agElbLTNg2RKVKqNTzV4A1Go5xpxCUu3WaxBRmKY58
X-Google-Smtp-Source: AGHT+IGO7yDGbJzkg87cm6mgILrGb71onEEeNpPK6NLPLD08xAGbuUTyx63/8Uo8ivlFWmPIqBv84mJeFpSUCOjvlgw=
X-Received: by 2002:a17:907:3c8e:b0:b3f:5513:5cd0 with SMTP id
 a640c23a62f3a-b3f5513775amr181313566b.19.1759122363244; Sun, 28 Sep 2025
 22:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
 <20250723094213.2975268-2-dbarboza@ventanamicro.com>
 <CAKmqyKPirO4wLus3kWeHk_ir6kOTru6U745AVUW1jNzYXbzr2Q@mail.gmail.com>
 <5319bc5d-ee82-43e0-adb2-2657b150a0ea@ventanamicro.com>
 <CAJSP0QU0XeuQML+kLGBZgk2V2ABsqdyUA__M4YL_VSp+oYJYaA@mail.gmail.com>
In-Reply-To: <CAJSP0QU0XeuQML+kLGBZgk2V2ABsqdyUA__M4YL_VSp+oYJYaA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 15:05:36 +1000
X-Gm-Features: AS18NWA7zyb3_Xs4kkItcvxNdyT26IAIBGl-y33EYvKxxO3pde9AjmmyD3IGdic
Message-ID: <CAKmqyKMCHYhCT+apjRw+ktcRpOWmTMoz=n66bB73pk=pQ7OW7g@mail.gmail.com>
Subject: Re: [PATCH for-10.1 1/1] roms/opensbi: Update to v1.7
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Sep 16, 2025 at 1:07=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> Hi Alistair,
> I saw you requested access to the opensbi mirror repo on QEMU's GitLab pr=
oject.
>
> I went ahead and pushed the latest OpenSBI master branch to QEMU's mirror=
:
> https://gitlab.com/qemu-project/opensbi/-/commits/master?ref_type=3DHEADS

Awesome! Thanks for that

>
> The mirror got stuck because commit a2807646a858 ("include: Adjust
> Sscofpmf mhpmevent mask for upper 6 bits") is not present in the
> upstream repo. There was probably a force push upstream that replaced
> it with commit df997c6e55fe ("include: Adjust Sscofpmf mhpmevent mask
> for upper 8 bits"). The diff of the QEMU mirror commit and the
> upstream commit is:
>
> diff --git a/include/sbi/riscv_encoding.h b/include/sbi/riscv_encoding.h
> index 050674a..2ed05f2 100644
> --- a/include/sbi/riscv_encoding.h
> +++ b/include/sbi/riscv_encoding.h
> @@ -207,7 +207,7 @@
>
>  #endif
>
> -#define MHPMEVENT_SSCOF_MASK           _ULL(0xFC00000000000000)
> +#define MHPMEVENT_SSCOF_MASK           _ULL(0xFF00000000000000)
>
>  #define ENVCFG_STCE                    (_ULL(1) << 63)
>  #define ENVCFG_PBMTE                   (_ULL(1) << 62)
>
> I looked at the upstream discussion about the reserved bits and I
> guess that the author changed their mind and force pushed with an
> updated mask constant. I mention this because I came to the conclusion
> that there was nothing nefarious about the force push and that it's
> safe to update QEMU's mirror to follow upstream again.

Thanks for digging into that, I agree that it seems like someone just
wanted to correct a bit mask.

Alistair

>
> Please let me know if you have any issues updating OpenSBI in QEMU and
> I can tweak the QEMU mirror repository as needed.
>
> Thanks,
> Stefan

