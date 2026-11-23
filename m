Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t2Gwq6oE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSIx-000524-Qe; Mon, 23 Nov 2026 06:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSIq-0004yb-Hb
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:33:47 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSIn-0007vl-PP
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:33:44 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b4d07494b0so41758867b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 03:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795433620; cv=none;
 d=google.com; s=arc-20260327;
 b=a9d2Mn77lPKachKRwVgraf7yk0PmjFyYR2c1e+3itdlupP9dSzz208D5jN/ifREe3T
 70K6yqRlHB3eWIlZQTIKvUYz0WjUHiDb3o2T3mhP9TbaWdifV7aXZrf97ErnWuwcmDYo
 nPzeXxQHxRSimrqYPOjk80Fh3wOx02TlpTXNCTO3gFtv1AipugOYmUWBIBpOnnIvQBpk
 ytjj6vsaVzPgq8vaXEUvf9QB5tOBBBDChdPps4+Tz/v/4BXfedgCKPsU0RaZYnRxd9PM
 chvWd8c66iHPN9H1gafvqRTIylRj7BkdRM6kbavR7l/KiceRrMxZg72Pkaf79u7V9g88
 uc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EKkmkSylR03Y9B23WtbRqfh0zauSJ8Gp8q0rHWrMgss=;
 fh=ZbLVWfwPzSmwQQJY3iAUgT8xZLFlnNQOT1qozk/C1Ms=;
 b=jpuGF7WXNHbnIiJGlO9i8uDkbFfbtuI38mpGAee2deuJ3gEASImkRtkjVM7+av4j0z
 Xg3mF+OQre4ftJ38i9PQHXdhtkTVqSsDSuiXKnmR0Zc+YGULCjGbdy7Jun9j7zrJ5S7q
 j5bjUE3A4q39Zf36A2Mmc8Tm+bDJDXubEyg7SJhmUvP+D9KNjqojJmVDsDkRi4922BjD
 KDaqJRSNn71nEscrgUN+kKWriKkI14qn6dHBrnP3tg1gCMZSOWMIsWvVBhAuwS58QNm0
 B+dg3K4e/vYP83A8YmEqI2m+GDfPMLu+svXWNE2vtHTeuCOyZfpDtxTrOkTw3l/iKGVP
 Stng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795433620; x=1796038420; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EKkmkSylR03Y9B23WtbRqfh0zauSJ8Gp8q0rHWrMgss=;
 b=t2Gwq6oE9TT75BVFcmzzja1E3/0TMuOurMQZNY1Y/dB7sb6CW5PxI5ffcec6l2bpwW
 5rgdBhpmhWIkoxDETL704UZFXmUC1mmUgPueXs+wSOZ8DxmwWqB0HUrdNhvH2OdseXQs
 aXIONGIx0QBE2ojLK1zi+E6X+HOtaKjNIZfkYsKww4e8QXwr79zJm21M6hFhTXCagnef
 4zVAXC7IEXiSdwiJUA27UNAT94LA5vmLezNkI4g0IoVE7CA19C0bpKBbuQ71WCfIPw1n
 8zKpxunEz2iRMHm3EWks1O+JZ2fhieWwmC52T2dI7db5gc+3OiFKkKXkU1Qcu+1qGG/6
 q8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433620; x=1796038420;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EKkmkSylR03Y9B23WtbRqfh0zauSJ8Gp8q0rHWrMgss=;
 b=FzNoE4OSBGSpVrDo10c/mCwpOMp67pC6SeHJcgFW9GiAU2o6NUhvUtW/YyPfu0d/ps
 qMhvlvS4JijtQQtUkeTsm9+CiajwxvpbBn5ShuKfwsT4R9QqBLXThZOKh8MXbu6h9H6h
 k1r4AdyhXtSvQ0d4iUC7BYZU0f3+NDcYs8cGbXvZq5rlpuZpBbr7NHzFA6NOt7rCzPLs
 0HU3zdE1/uBh7WRjP0lwKseiv7n8BurtQ0Sxplms0XjNx/XWryB7tY0t6H3PV74uJSca
 b6eR6qFpsSGNVV/8C3fNSOR3NMtpd075LjAiGVJw0RRvvUcVqdUUQWsFzkSPiTX1gD+p
 UJJA==
X-Forwarded-Encrypted: i=1;
 AL+hErGXiE7U5mPDxmbaEciqJTzNhz5yz+Q49/1/Lc7ticFP/W9o73yLoys22WsFc1Bi7jcu+yLV+ioPlkHf@nongnu.org
X-Gm-Message-State: APuU4Z/xy+szwz8phdn57QewFgxbOMHmPQrkhp4CP7Dz0q8NFydS1k8t
 noWApdJqe1luYPhggzmvDk74DWYmkd/xi290mr0wFWHXQ801vZXk+nnRfVHmfGv4j3poxhrknlg
 ziKCMRDgppCMJgILT4cHYf/2SkSI6Mtm/b23mhXIJ4g==
X-Gm-Gg: AZFdTZcKepbMamMB+FL7ResPL/Na0yHj5Hg2+L5RVTT979vHrS/xCa+ezsz4rOVo32D
 4hoBNwl12fx4zheLzJxLojQk676dbIICnZQZcpNWyPLShzXXvITHfzuT4N6tV+8sXXVjWdi6PPW
 H/yCSFColkYH2YBscF6Fo6GdmiyWXdjcvIPoFx9WUujq/LD4QIMJ+CtoqCW2YtcN3CMwni86Atu
 IApCN01lt1cNVZPFp9VUNdRM+0WdUq6yiAkl5SRbJzNETjE/AkTCK3UdzyLOFxCQ+QoKMXKzvxB
 MNnl0fYsFgXPvJ8xwPOlN9BauTg4woRhtNVkSJGFMebiaoO56/Xu6BUogvIW41pF0fJ9s8i30fk
 D2jVBqVo9WRH4avhdlw7yF4TOGGjjbD1UQdAp/pgrg/eWhnYY1w1QWTYZImgfe4NpJqMgkrPoVN
 0T4jtUGYX36rqw52lAO1bN
X-Received: by 2002:a05:690e:e87:b0:677:c90f:46bf with SMTP id
 956f58d0204a3-67dec4202b0mr4628300d50.17.1795433620401; Mon, 23 Nov 2026
 03:33:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119171425.3186790-1-peter.maydell@linaro.org>
 <00f62c2a-f094-4922-92c9-2d3c26a012d4@kaod.org>
In-Reply-To: <00f62c2a-f094-4922-92c9-2d3c26a012d4@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 11:33:29 +0000
X-Gm-Features: Aa3M54oDzgtNUMLgOZ7sO0mQ_a5gKfBubKT8eGfW0-_wnlfq_yBZ22Zyx0o-Zzs
Message-ID: <CAFEAcA_mntTSsiZZRH1vOd9g4W2D=2AaNEEXvoucVDyf3ur1SA@mail.gmail.com>
Subject: Re: [PATCH for-11.2] hw/ssi/aspeed_smc: Correct minimum_version_id in
 vmstate
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 07:08, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 11/19/26 18:14, Peter Maydell wrote:
> > In commit 29139270d8ad70f2 we made an incompatible change to the
> > migration state for the aspeed_smc device, and bumped the version_id
> > and minimum_version_id: this is because we increased ASPEED_SMC_R_MAX
> > and so the regs array is bigger.
> >
> > However, the old vmstate was handling migration from a range of
> > vmstate versions, with version_id =3D 3 and minimum_version_id =3D 1.
> > The change to ASPEED_SMC_R_MAX is (intentionally) not compatible with
> > any of those older versions, and so it should have moved
> > minimum_version_id up to 4 (matching the new version_id), not merely
> > increment it.
> >
> > The effect of this is that trying a migration save on v11.1.3 and
> > then a load on the current head of git fails in a confusing way
> > ("Missing section footer for aspeed.smc") rather than clearly ("error
> > while loading state for instance 0x0 of device 'aspeed.smc':
> > aspeed.smc: incoming version_id 3 is too old for local minimum
> > version_id 5").
> >
> > Since we now don't need to try to handle migration from versions 2
> > and 3 at all, we can drop the complications in the vmstate struct (an
> > unused field, and field only present in version 3 and up). Clean
> > these up and set the version_id and minimum_version_id to 5
> > accordingly.
> >
> > Fixes: 29139270d8ad70f2 ("hw/ssi/aspeed_smc: Add Data FIFO-based flash =
access support for AST2700")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4880
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/ssi/aspeed_smc.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> > index ec9ad0f747e..f82947e752e 100644
> > --- a/hw/ssi/aspeed_smc.c
> > +++ b/hw/ssi/aspeed_smc.c
> > @@ -1218,12 +1218,11 @@ static void aspeed_smc_realize(DeviceState *dev=
, Error **errp)
> >
> >   static const VMStateDescription vmstate_aspeed_smc =3D {
> >       .name =3D "aspeed.smc",
> > -    .version_id =3D 4,
> > -    .minimum_version_id =3D 2,
> > +    .version_id =3D 5,
> > +    .minimum_version_id =3D 5,
> >       .fields =3D (const VMStateField[]) {
> >           VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
> > -        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
> > -        VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
> > +        VMSTATE_BOOL(unselect, AspeedSMCState),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks. I've applied this to target-arm.next as I plan to send
a pullreq before the next rc.

-- PMM

