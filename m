Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37665C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZRI-0001Pg-Rl; Thu, 30 May 2024 02:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZRD-0001OO-Qm; Thu, 30 May 2024 02:39:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZRC-0007kR-6l; Thu, 30 May 2024 02:38:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f48b825d8cso5042195ad.2; 
 Wed, 29 May 2024 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717051136; x=1717655936; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3ugy+40mKGbqs/lGgq0KBhYueOB5qJB53NBI2VG7kU=;
 b=lazkMecol8hv3/T3IpRXZ6dR0qaVe2HBxC5g/q5EJNmacUQCgcIapmwbuo1Mt17YSv
 eqyIU48SiE/vpYYbnHLPGn2ArdG28ZGKuUzhtzgiL4QSmMMAcj9vL2ewPPZ4B47gq0cW
 crX6n+jQZbyy0EOSluzzQBjAQHXcJWQloeqLsaZjnsX/eH0EVevml/ILjmXY/C7QUnRo
 5NFEvB2c/9lo8xIdbpZgH038qP4Td3AsMXUD5jfcSFJOXnVekBpyCQj6zd8XkFs/VJOF
 8WmLQ2qD+m2KEo5RSRnnONTRSmQoNbcLZSx0pgjifAqj92A4U7sjFFUA8wIJM2VTrgz7
 N2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717051136; x=1717655936;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X3ugy+40mKGbqs/lGgq0KBhYueOB5qJB53NBI2VG7kU=;
 b=frLpzf4S7RgpWpNcqGB8wX/kYk829oQFB8h6cyNM7HSr1sEu0mPc6u6+pX6QKJP/uI
 WNDCsXyP5lWcShh1E3Ijb2Win/6O7IWBKKr7sYIlMDYVZjePor8bBdClIIZ33neiTg99
 jgV5I4Wu5KcgXsW3XLw+3HI47NLAgKyiAVQP1nCzfvalJdwQx//NPvkam/e9RcS4zS6d
 1surRGi2PZ8UVkDVcjnDu8OYwf303rtcaqy5qdtGbZSDEIpB2vy6kUbdQAG6vYa9rCY7
 CSc3R5+25LiCYwH0Tly58GVKSCs26aGx4ESUldmIIeWj3vXyQWZdbgd0uhR17vL4dYaT
 sd/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWotoaurC21XIZV/N7Fv///HgU+9jgMOFTxwUnR+pbJcaK47pWR7qUHBvGz3np7mCknLHJ3EFQozSRzx8RDieamgg6NmeSbi/FxuqQCz0T4RnKgYJWrLYshRk8=
X-Gm-Message-State: AOJu0Yzm2apasHLrc+taUQ8e0XsZ6+74i11KYweuUzDbVxIW/6DOQOOh
 eP4CHw04vvOboCc9x16bnWiXJyQMg7pHra9bYn6M97YHE5KVAFzW2sPtxw==
X-Google-Smtp-Source: AGHT+IH34SkPH31mWVw7k16rpkGv/H0lIP/X5VIivFniInV7V1EPc7R5gh2ktqYtYwhytPgA8oKI1A==
X-Received: by 2002:a17:902:684f:b0:1e5:3d8a:75fd with SMTP id
 d9443c01a7336-1f619b32fdbmr13363875ad.69.1717051136403; 
 Wed, 29 May 2024 23:38:56 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9befd6sm110649955ad.268.2024.05.29.23.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 23:38:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 16:38:50 +1000
Message-Id: <D1MRTRSKS7GF.17AMWDOEGR6Z2@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 07/10] target/ppc: Add helpers to check for SMT
 sibling threads
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-8-npiggin@gmail.com>
 <b298b542-ee6b-4a84-b1ff-1230dfdce09b@kaod.org>
In-Reply-To: <b298b542-ee6b-4a84-b1ff-1230dfdce09b@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed May 29, 2024 at 4:34 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/26/24 14:26, Nicholas Piggin wrote:
> > Add helpers for TCG code to determine if there are SMT siblings
> > sharing per-core and per-lpar registers. This simplifies the
> > callers and makes SMT register topology simpler to modify with
> > later changes.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/ppc/cpu.h             |  7 +++++++
> >   target/ppc/cpu_init.c        |  2 +-
> >   target/ppc/excp_helper.c     | 16 +++++++---------
> >   target/ppc/misc_helper.c     | 27 ++++++---------------------
> >   target/ppc/timebase_helper.c | 20 +++++++-------------
> >   5 files changed, 28 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 9a89083932..8fd6ade471 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1406,6 +1406,13 @@ struct CPUArchState {
> >       uint64_t pmu_base_time;
> >   };
> >  =20
> > +#define PPC_CPU_HAS_CORE_SIBLINGS(cs)                           \
> > +    (cs->nr_threads > 1)
>
>         (cs)->nr_threads
>
> > +
> > +#define PPC_CPU_HAS_LPAR_SIBLINGS(cs)                           \
> > +    ((POWERPC_CPU(cs)->env.flags & POWERPC_FLAG_SMT_1LPAR) &&   \
> > +     PPC_CPU_HAS_CORE_SIBLINGS(cs))
> > +
>
> I tend to prefer static inline when things get complex.

Yeah agree it has become too much.

Thanks,
Nick

