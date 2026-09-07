Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCA5C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Tlf-0001Dz-AH; Mon, 07 Sep 2026 03:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3Tlc-0001D6-Tj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 03:27:49 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3Tlb-0002Kh-7K
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 03:27:48 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66f8053e7afso1938891d50.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 00:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788766066; cv=none;
 d=google.com; s=arc-20260327;
 b=SI1YwKDUzSa/zP/lZy20d10PgEDqtJFKs4UcchDWO77lXHYOTOSItqTIAjcP5K9iOI
 yXuXUbmMH8jiioJ27gABJsfUEhMHavfSL6BqfrGs4XOhAXnDyhzRacT787KuuAwBvKdc
 MUCvgwfGiXJOEd0b9lnb6Kvznaft5W8G3ZPSHGbAkcJeomO4QnMbPT3/DhCedc4/+Oqu
 fOmCLdAIiM7Im1RcIQKdErAvankLAxm6bOY0LldM8UpOZ7z24U3m6xjPRBGOnrQHouTJ
 40ZMF4+2k9FdpANjyXz4NCbXqgEmW3Hg5jAtztT1qfUUMi7BCALnW4G+8uzR4/r41MA+
 1/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4FaTlUWDVjkPnqBZK6+CQD1ELMYVOOzDwSl4e2vjXk0=;
 fh=mA1RlqIHwvpE9xAfqQZ8HkcSTuGpdJEfixTJbCiBFos=;
 b=gEzjSR8WdpFPH3U4t0gVBDF6DBgS3s161Okvy/bD7k490p61ae4Z0AlISHVbOTzlQY
 3jlUm297LsxSqAlqyi9jrNWwvUUXu9GMiwEJIPwz4pIwjl5F3sij416zdVdWw4hhbfqc
 ME2+tQLgRs3LOKdBGxYTtxRVrx6l7T7hQml8s0wRYbL75aB4lH/J4WLpX3LiABFt07qj
 bO6VoO+rRqI3cwska2FuNtRguByFZkuyPgA7esy4Sb3dK0HRtqL4ybv9fB5l1AtGx3b0
 lGfqtddpUfifIg1ICrkUkE0NCS8JIzWhnOeS78gz9LHDaAL0r1z0F8E0ZnPZOR616giF
 /2vQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788766066; x=1789370866; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4FaTlUWDVjkPnqBZK6+CQD1ELMYVOOzDwSl4e2vjXk0=;
 b=O7khH4QJJcCU2+9piydLi/zpmamjq2rs+kVv+TyfLH4EJ130bALrmFSKvHtgsuXIq2
 727P4I4ztqIr6EmauwlS+OzcZnJ/FuvXND/cOkQJuRKiMZiDGOQdS3NfEPYa56bHB6DP
 YUVAPgQ5cwJBA3PhYp2WbMcgl98Rb6C3TxdoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766066; x=1789370866;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4FaTlUWDVjkPnqBZK6+CQD1ELMYVOOzDwSl4e2vjXk0=;
 b=BTnTCQ+WlPhMvhuYr55ZxBZErh3lVkcfMfpBKWyTrB4xLQWdKjO3enisg681efEKF2
 rIdBwrChyWjeYaRHYt09gK1I4pCvrpRKiAeNTfoYXZg3wQMlDG3F1/287reOypHUUG8a
 GvZz0TRyVxfIKNyIA4hM+68NA7ncezOS68pdaNGa2q3ktQXUKZcz/0+DcFrC5ujgQRIb
 7lD8UKcc6TjBnHYsRmro6Q+SSCGDfHJleZ3Q5ZqDtL1UX1mGoP1QhlvyXDQAh5n1uEnX
 m80MXXv4d13iEgOBdXeR0Ks0+P8uRTS92FnDSYweP9QgUFw/4BdXcG/2S3rtdjK/xPKX
 tMdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaTXK9ozgBeVKJTWG7lCwX1v/CihAqj+SjEnPYGA5Gs8S4vraWtKck9RO4ZxreL4FoUEsG1KIuexKT@nongnu.org
X-Gm-Message-State: AFuF++m8+l5dfuEi+AyAotnHKYqf1k49oywx7i7glUNFM8sg3NcHNsRR
 WoERDVvRo/9CxUK5436fryn4p9BmJyCWIlIaJpWs0q5QCy3aCB7uB0c2JFeBJeye+AHYpP45ikI
 Ppq62dWqa0OjvziZv2gENGYfN5JYxELU=
X-Gm-Gg: AYBFou06JM0RL4SwrF4z9KMGNO3hSA0FSMEgeVZCJhdi5zp82p0U8951iuOoDf998Ve
 PAi67UCNuvEPG+eEKbf9PN2nOiMpjSH9kh4a1wUxff0Rh7E2pIn3sBCUjGUXx0cuNDeKLfDmC5X
 KXvH7gQ8OFXuq9c5lIo/RSU0SMNlvWSz60lzSpICYP3hH8/NLQWHyhgs1wc7i/pp6SvxFfd7D/X
 T0FYi4tAgoHpTuUKq80Mg+Lwpk/GbzYJUoTiaeuA9561+ZILmbcd4A7zvc8iDXWElJ58Yf6wJdX
 7eXOrpnT+cpWxxoz+WIGqm9QvmzT3MX9ttLPsnHQlZOFyVjAZ88b+6tOnpZ6V5Lkj3gCQBcFZaW
 VecmiS6Fn68tcIeaG3kwV0+fJZBd4R4R8kA17xpYJEMOKjGcARKGg93iO7Se/BDLF717wJpLSU1
 WhN38pxyFeQHEhB2CIH48k1u8taXU=
X-Received: by 2002:a05:690e:4283:20b0:66f:c1be:a663 with SMTP id
 956f58d0204a3-66fc1beadf1mr2802491d50.85.1788766065936; Mon, 07 Sep 2026
 00:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260903055131.257903-1-joel@jms.id.au>
 <20260903055131.257903-15-joel@jms.id.au>
 <a4b3c4a2-e359-4952-8b1a-34db4e2b3c9a@oss.qualcomm.com>
In-Reply-To: <a4b3c4a2-e359-4952-8b1a-34db4e2b3c9a@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 7 Sep 2026 16:57:34 +0930
X-Gm-Features: AcwNN1XbKouwtUcJQbmHGY8llY8T9UYA8KYi7aof3H8oop9a8W8fi0muNztLxI0
Message-ID: <CACPK8Xd-GLWSve3_7ctEqAmLFRoNVG=WzYw6dKwGqPbHi-aE4w@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] hw/riscv: Add property to hart array to allow
 private memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 4 Sept 2026 at 20:13, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> > @@ -117,6 +119,12 @@ static bool riscv_hart_realize(RISCVHartArrayState=
 *s, int idx,
> >       object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cp=
u_type);
> >       qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->reset=
vec);
> >
> > +    /* Use private memory instead of system_memory if provided */
> > +    if (s->memory) {
> > +        object_property_set_link(OBJECT(&s->harts[idx]), "memory",
> > +                                 OBJECT(s->memory), &error_abort);
>
> IMHO this logic should be inverted: we want explicit memory bus mapping
> by default, and if not set then take the global memory. Personally I'd
> even go further and assert it is set (otherwise programming error), with
> a preliminary patch setting global system memory to current machines.

I'm on board with this idea, but I couldn't follow what you meant by
"if not set then take the global memory"? That's what happens
currently?

Are you saying always set the memory link to the provided MemoryRegion
(with a fallback to system_memory, or in the stronger case with an
assert if not set)?

Then we could drop cpu_exec_init.

