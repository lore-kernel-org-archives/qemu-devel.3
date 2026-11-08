Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65DF606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bsUBMsJn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzfC-0002gX-Mz; Sun, 08 Nov 2026 04:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xPzf9-0002gG-KE
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:58:11 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xPzf7-0006ZK-Qe
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:58:11 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b31ca7e0bcso1717167b3.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 01:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794131888; cv=none;
 d=google.com; s=arc-20260327;
 b=PINRUebMlLP2WxwKbO+DHFZ1g92HX6Ytb64QwZ8Z5umGmAwMobIWSLCk6gbUtaMyWf
 QDKVQcxahjXbs0DBbtg7dbuNrPTDyeEPGYkYMuvEAKr8mredvcQ5/svKGguNHvBV6c9I
 3AjTAHoS0OKqgMSdXhjSLh2VB4VacSwa/QZ7lRUTTMKC5f4VzRhng3gLxjTjesqx+WM1
 IXim7oUQEtUWahNVLHWHX1dRZUUI7HSudZlnUHnM8pF4Ep7M7I2MkqDZ3O1CfG8q4Rzx
 u9BM4vn28n1sCVCq6MVKsQgL3eANC1mB1gUSAbTpxX+h6nkOOOfwc84alUmsnAd6vUc1
 MXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ju31Yj3PhF9PBimAL5CGDkzWo8BjgD+ZDBluI6B15qI=;
 fh=El6yot8g0uRIbkOvmTaoES3GvjNp/wIBqRu1ppOC07Q=;
 b=RAUjghjxMIEvpWmgoMCxBnMeTStcgpayj+Cdsyvi4rr436aufazyr0E6nI+zOJCKdd
 k0eBzfTA8W2mJhFmcaI6Sw0+gaFjqOlTxfNN7W5LX+zjAI3VKZUGeY6b8pbZfI+tzWBZ
 zn2oPlRSIETsH0AuGTOG0pOpuS19KSFfR/r8mrNoFueKvqvRB4QqgJn7RI3kU8G3a5tk
 VBLBO0PN42ZoOz8Ps1Jko8Au+Q9d3bSt9NAjAvJP7QLN2E5GLFTnlwdDW0DxVo1/Zx55
 +8MgTpB9XQyYJNW+M99Npsyd1PRWBJR3jIbKCNjINC4UCPDMUcS7PooeOQ7Sv4WUAizW
 pBEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794131888; x=1794736688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ju31Yj3PhF9PBimAL5CGDkzWo8BjgD+ZDBluI6B15qI=;
 b=bsUBMsJni3yLTuK0Mj5w+3P0Q4moFiEq8wmTL7iqEcQ7/l4fOEd9GWYLNuUyu/Iuoa
 t5fpjqmA7J/fd2aYPY7ptEde8z5P63nsL8G+IWsRbr9pnWwfu3UoRPg4XF1EyVK/K9uW
 lRBUfxbTAnzXS54IlN42ZefqhWhxWVMFyRvAkVkyKyZyZpjvsMYCALMCQIP+9ZWuOjPD
 liDVA8N5EbamzMgAvEiaxIZFFIRmu8CN+VvgAN82BnWh4yn93TyJd3X38VNEsvqlASQ6
 CFvy8kRtar37ss58K3AYT1aqgrQYE22sZfdy+ywsiAWPtRnE9FVuCf/6qgvfhD0kCOZS
 PjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794131888; x=1794736688;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ju31Yj3PhF9PBimAL5CGDkzWo8BjgD+ZDBluI6B15qI=;
 b=fYCOcgyv1YVb3w35PVVb5hbxVUFqHUj8QlHnITRvI74/fwylsOF38QK68xO4NJdYSG
 AM3WZcSywdRJ6cfUDlcJFcFL6AW/WYMQZVeOvwN/NYcEaA/+w2kV4oWMrMqlE3tYwQ/6
 Pxa6soPWZxO/tOxhPfEKkqLlAqiklip65yTOJ9tPL1++vinLpmxObiqswP13UE/Et52C
 V46Ir47DtTdvphCb3waBkaqDUs6o3D+RRXrknW1pWgp2DFmZO1rHnL/kSmgvaZ6Av9H5
 JkJ+IvlWToZd6oMwoF15sS3xetS7VGjqqJ8G5IIiJ8QemybeAUqpOnZBFWqvpqPWVGDo
 ERnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGWIUftgo/+utxWFpqqeR4AVGAQMIh1bgGBmw+sNOW0gGwavg7zaiQ0tekDthLABx+71f0iGEni3guH@nongnu.org
X-Gm-Message-State: APuU4Z9Wwukkp5lI6mmMuSBD2x03T/eZX6dbeCoRPZMRSYsBuqQhf8xq
 4ab4i+OjTcwq6okd34sodxHEnpCaEIa8XH2FBPI9EV+NZwfXrQgMIRxroT56Mg1MkmUS0Su1vcx
 pcp0C1WS13cc+sV0B6u7Mevt5ZgwMIjM=
X-Gm-Gg: AYBFou2Va2VHhqZqhi+qhxWj25+FdLaabXDnDIsFkz29aYdF4mgwmARQWk7zM2dlxT+
 Hf5Dl7/Qd+AVZrMPaTLNFp4fZLAfqL0sxfmWmRO76mWJY/+GyjlHZws3SHUqiEbL++AJs03Ml4G
 i4/EHGXIp6dZo2hc2W2nxtH+7tRJ4ReQhdkfV1Sus8yi8toN1g+s83wk4HV4hor0MM3gGNuLrhL
 CsO9bUiya/YgFmsLlOD5NjtUMXf0Bk4zuEN1eRO8Dzf51fIrCa0XwaveWgnAYgmY5jZvYX41S/g
 u20Tw0lIjTRRMZee3Sm8eAB32PKUyKGrle4+9kTQYJis8yaKxUG1PUGDkXcTdMphUFfVxtzIsz4
 PlHo62SJ5DpfPZgkBUdZ9FR79FrlzyetAV/pxOsVfAnq6GhNwRSqvZHsf6SFWDO8VPR8JXWzz6n
 ur
X-Received: by 2002:a05:690c:13:b0:8b1:233d:7054 with SMTP id
 00721157ae682-8b36ca9e4acmr8896307b3.32.1794131888462; Sun, 08 Nov 2026
 01:58:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104173329.706635-1-bin.meng@processmission.com>
 <20261104173329.706635-6-bin.meng@processmission.com>
 <c8a25962-b452-5f67-9a80-fcabad783e2d@eik.bme.hu>
In-Reply-To: <c8a25962-b452-5f67-9a80-fcabad783e2d@eik.bme.hu>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 8 Nov 2026 17:57:56 +0800
X-Gm-Features: AclHuK-eWcmrOL9k28Pd3eZyTpMiZuq6PKij4RL5sbyB6hkg9FjbgRMB5R5j64E
Message-ID: <CAEUhbmUVx7yNLmMr6LpNW4uBe6z6F-TghwaXwg2NNM4R2Y3YCw@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] target/ppc: Complete e500mc and e5500 L1 cache
 configuration
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 6:26=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Thu, 5 Nov 2026, Bin Meng wrote:
> > The e500mc and e5500 manuals specify pseudo-LRU replacement, cache
> > locking and parity detection for both L1 caches. The reset values
> > describe the block size, associativity and capacity, but leave
> > CREPL/ICREPL, CLA/ICLA and CPA/ICPA clear.
> >
> > Set those fields to their documented values so both L1CFG0 and
> > L1CFG1 reset to 0x00B83820, including the shared eight-way, 32 KiB
> > cache geometry.
> >
> > Reference:
> > - E500MCRM (Rev.3), section 2.14.4 and 2.14.5
> >  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
> > - E5500RM (Rev.4), section 2.14.4 and 2.14.5
> >  https://www.nxp.com/webapp/Download?colCode=3DE5500RM
>
> I'm not sure we want URLs that can go away in commit messages (or
> comments). I't probably enough to list the manual and section or move thi=
s
> whole reference section below --- to help review but not record it in the
> commit. But if others think it's good to preserve this in commit message =
I
> don't mind.

I can drop the URLs if the URLs are of a concern.

>
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> > (no changes since v1)
> >
> > target/ppc/cpu_init.c | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index 3be3e44aad..e2182720a3 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -2886,8 +2886,9 @@ static void init_proc_e500(CPUPPCState *env, int =
version)
> >     case fsl_e5500:
> >         env->dcache_line_size =3D 64;
> >         env->icache_line_size =3D 64;
> > -        l1cfg0 |=3D 0x00800000; /* 64 byte cache block size */
> > -        l1cfg1 |=3D 0x00800000; /* 64 byte cache block size */
> > +        /* 64 byte blocks, pseudo-LRU replacement, cache locking and p=
arity */
> > +        l1cfg0 |=3D 0x00B80000;
> > +        l1cfg1 |=3D 0x00B80000;
>
> These were changed two patches ago. Do we need that separate patch or if
> you don't want to squash the two patches maybe move them next to each
> other without unrelated patch inbetween.
>

These 2 patches cannot be squashed as the previous one is a bug fix
with qemu-stable cc'ed.

Regards,
Bin

