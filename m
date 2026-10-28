Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48668606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MU9dRvcs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtx9-0006So-GC; Tue, 27 Oct 2026 23:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLtx8-0006Sf-KX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:03:50 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLtx7-0002Jv-1h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:03:50 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c46d41f6af3so65746166b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793156627; cv=none;
 d=google.com; s=arc-20260327;
 b=h2NttsQLhH+UZ2ANcsxDVeJeUsddzf186d1hi1331Nj4YDXN/y0bOqNFUbf+s4CUHj
 iUvYWpCTgc3T/Q52XM+xLTgg3sdNOTrehe1FPI5aXmqS2R8rSnuv04HfP8dTnIKBm1xN
 F16rsC/AmGUAu7BNJhKgjPPZ69nRQsW8caVQHS5hCw0+q0668r1sf4/Ke5xjHx1X/OPj
 Fg9Gi+Z7FmFX1nlhoEaxpZ+CsPWqLMoMiEVOWDGgI0kDnmfGyqhxm/B1OBb3RLnsCQwP
 MPJRe5nCr64WGKSrZkLp9ZJv5RH88LDXzWHTxXKFaiVfwNrxCSMwdqENqTtfm7CZaxmu
 MZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=0M+1SaSgj8ZCbUjfdvltNFPgBUCEzl0eZfRO8DXam6c=;
 fh=Ms7FYm1YqzcXx+L0l7o2nAt4wMKVfd9g/Bijw92L0zo=;
 b=OkqegncyRW7zDbR0RFAFVVDfjDR6rF9RnocuP5gtRFEohik1PNQb5zPSHmNn4fbAVp
 I+VQDnvj4RZKGLKvHw5OD0SgAsKU0kmrXP34dLSOjyc7ngth5ebt5ho6cB3qax1LribB
 UDy7wYgtoBG+krqGooq7EmT4HNCJz/7YiEMIeKuV+RxZLTr0Fxx2yYCRUXgUPc0FFAcy
 8ZMhgUZIrsntiJRIEV66AJCVSy8M32CUnEx8jtTz2RhSLAcheuKVhRXyo+yM+aTJzpo2
 9h9RrrN8Xmhv5rnJ/5ViX4BirBabEv3VhjI81TjueeEHsIWS3rhDfvdl73vKuBYCk5lt
 TCnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156627; x=1793761427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0M+1SaSgj8ZCbUjfdvltNFPgBUCEzl0eZfRO8DXam6c=;
 b=MU9dRvcspa5Mli3u7PgLZ1AO+FhWIuKeX4sP+vyjDfqjHMMjWS2cZEIy4xZMJGIz6s
 DSAwgg6WDr4viXpUixctiCjWKkiYWvF+RP282OVsJ8pd04NLz8WO69aVhl7LMd7fYw5W
 acm4u86eFJcevqRNVVDLzCLP2wt+m/R+dnB9RanC9chbjOeq0v1THIlOOY3q1n4A5hk2
 blaMkRfFwbln6D48D5QGqtooFbjAjW9BD3sQL2VfmQKNQpUv2u53Ri8yJyC8C9Jsgyp1
 RVuOZPMe54s34uSC3ReOh8g2U/4DAswnhebAUWyW5XsgPZ2JGR4cLlLVEu3T70VNcZqh
 JY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156627; x=1793761427;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0M+1SaSgj8ZCbUjfdvltNFPgBUCEzl0eZfRO8DXam6c=;
 b=UibU+IuD33gJSdIv03DGgDV2AJfYD/6BDGT+V/F+97Ffaan7UD0pFows7/6PUVrI/K
 wCoRV1Q1yN70/ysUSqj5EoYTT88avHzzUVW2wpx2xkr+jOfeW0qQAqZ0NVr/vhPR3tB6
 VOJ67pDjWG6o+9r9EA2hSAuXkbCJUu+OU/DzFhlsM0aAVhGZN0ACjMGS9xRCvP+Fsva3
 Z3nLRPMPkAMGuouZ6DEsbkRl3R70R0UVpcJom04WfgHOeiCeBv4WIRrhIHxVnax2iWSm
 SoKMOkvI/lRxYvvW5v+rN0QkuG8z3mLedkThORzpOn5Hk6wmg8re1cNAul044wY4NFXG
 WZIw==
X-Gm-Message-State: AFq9FYJ5I3VUOWNWNQB58Rf2R040XLlz1wk8r9ms9b1cwUYjHLjxESzd
 gb3+dmeRe/TXs3ksGxQ4/uOq6OXx1lMStyoAvjIWJ34V7jbCUG12FKmwJL5ts0ks94rrLkSO/7a
 mEfw/6CVRdTWOffjbrRIdPFLZOfRDqY4=
X-Gm-Gg: AYBFou1d6Fbt2q6v8P/eHxEXifPSEt1HdEf0wyTWUQEn3RjaS3Calcp5rwoe7SHPCk5
 nXsKCI/T+ow8F+OJJgkr9H1szmqZhuXn7TyEfaeO8W3YeKwa/NLezwvcs3BnP41Uddl6Hzmt56j
 2KAA7DVwQ2m+QDcVyBDQoXcXWimWMxeI77PHOvzjdTOgcYuC6KUW0RHOr/lT1yEi31IhaEK+v6d
 KTaEozPYsuXpe3w9cN/eadbtcgTdmuQPvyJug37kwRkkGGhXJNbqS82FBhR7SBiK3XxPiLJYdBy
 I3J7SCLg/WR7xeQpIYhJe3KVfVudJVfghkUwqzYZ+mlRNbCwhv1MHiVNsAOTaYrYvLJNIstRQjx
 OtOsqbDrIW0Q7fCEz3viKgDd4EGSWiHrOTt7y
X-Received: by 2002:a17:906:ef03:b0:c41:4d5:e97c with SMTP id
 a640c23a62f3a-c49be04243bmr75212166b.37.1793156626813; Tue, 27 Oct 2026
 20:03:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027054026.2184-1-luoyonggang@gmail.com>
 <20261027054026.2184-3-luoyonggang@gmail.com>
 <d001a2c6-79ab-4f75-8c00-ae0c43a67d2f@oss.qualcomm.com>
In-Reply-To: <d001a2c6-79ab-4f75-8c00-ae0c43a67d2f@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 28 Oct 2026 11:03:34 +0800
X-Gm-Features: AclHuK9Xcg7OYzXTRfO_JnGns7TUO5vxxVcBoUXqh3GbG-b789ZLsD4jeGwNowc
Message-ID: <CAE2XoE8BD6kaC+055N3EJvUM_5SQo93SNjQsjHHciVkNaST7kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] accel: register CPU parent for each target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Darren Kenny <darren.kenny@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x631.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 2:31=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/26/2026 9:40 PM, Yonggang Luo wrote:
> > Now we need use the prepared target-list to register different accel-$c=
pu_type
> > parent QOM type. So that multi-target won't error missing parent for di=
fferent
> > accel for different arch.
> >
> > Also add a test for it in test-multi-target.c
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  accel/accel-common.c           |  6 ++----
> >  accel/accel-internal.h         |  1 +
> >  accel/accel-system.c           | 24 ++++++++++++++++++++++++
> >  accel/accel-user.c             |  7 +++++++
> >  tests/unit/test-multi-target.c | 15 +++++++++++++++
> >  5 files changed, 49 insertions(+), 4 deletions(-)
> >
>
> An alternative would be to keep a target specific accel file
> (accel-target.c), which only contains code registration for accel type,
> and no global symbols.
>
> This way, the type is correctly present for all targets, without needing
> to iterate list of targets explicitly, as build system includes what is
> needed directly.
>
> IMHO, it would be simpler and better.
>
> What do you think?

I am fine with this, I also consider this, I have avoided this because
I am thinking
there won't any target-specific files except target-info-def.c in the
remote future.
Now I think a small set of this type(target-specific) of files is also
acceptable,
I'll go this way, much simpler.

>
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

