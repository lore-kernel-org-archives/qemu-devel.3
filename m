Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3573C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXx4w-0000M9-SP; Wed, 15 Jan 2025 01:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tXx4u-0000LW-HZ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tXx4r-0008W7-RF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736923232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aaNF5o21t9JcD2Gj1DAUT9D0I3XOHT4f6U/7VGRMvm4=;
 b=UTrK+GFa7/Fxgl2oXm9Jvb21T86m1LjHUOSHI4qIAX4Hw/B8p4jLBQU0LT8n0srAjGR37U
 H3ExOxkR9mcXzSxsqy4UdApw2Y+qV1/hEOIKCUnu7fGqVPkoGlKxa7PvpJQX4D4HmfxsHL
 Hhoo2lXws0dSVso+9S0S8eP0q8ByoK4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-19YmmE1nM8aEvlabYjsCpg-1; Wed, 15 Jan 2025 01:40:30 -0500
X-MC-Unique: 19YmmE1nM8aEvlabYjsCpg-1
X-Mimecast-MFC-AGG-ID: 19YmmE1nM8aEvlabYjsCpg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef8c7ef51dso1135244a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 22:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736923229; x=1737528029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaNF5o21t9JcD2Gj1DAUT9D0I3XOHT4f6U/7VGRMvm4=;
 b=J7CAWf7YHePyfVk8FOU5E2/uaaUSnwgR7LdO13FreSg+2tTi6RqZfgXhRB0JiFLsKa
 nT/FkYkg/NjdIqT6ElU9wULbbua4g49InLK4O8hyoU8B/JJU/p7By6icRlplCq9gLf+x
 m9WgIzItBJeBcvxod0mz360Y2MFdln6XWXCyuFuSbxETwlB6BzuadkAknchTfqDYLuIu
 6ng7D04efNh03Hm/GkysDQhRX9xD7DZ2LrYvCjMhPqz0gEytve1kFcrvVL+GKC+1/q4+
 pFAW8RplN5xXN3dWVY6W6ZggcFzhji7p3/ccBL5xldS2WEDStT7Xg9PxgHpzdWIsmbOF
 4zqA==
X-Gm-Message-State: AOJu0Yxqy9f3R7l4nHXOvO8/sdd80h0bFdgUpsPqlJ+JFGFKH6k+3c6o
 66mp1IefcxTUjRVBoC08szdA773L9ORsN6a1mDQoZSaAzUPwVGZaBMP4jBmkUJnNO4hEPlRsi/R
 s/aV3wwQ0qOk8i5/NfWpeSNb0jfXadvBHTIpmkWhDB5y72hAIgZ0FQhwfUG1HRBQ4ARJdYGURF7
 7I8ibTR8D72oUzGSyktYHKTQf9V+4=
X-Gm-Gg: ASbGnctzXGdrYWAbtEnIaU7kK/6l2kCDS2TY+Rn4Cdyb3W6peDRHBA4cmfvnwgL964w
 Ww9lnYNEZF5pxZ04+GoaIEtNbJBeaSrATVG4j
X-Received: by 2002:a17:90a:e18b:b0:2f2:a90e:74ef with SMTP id
 98e67ed59e1d1-2f728da6048mr2898731a91.1.1736923229138; 
 Tue, 14 Jan 2025 22:40:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETFX4epg+XEFC6uwG1ogGRKBLpBqQjr+Fhrx7qCnGpZmTduy1po1+jacpuqa4m39GHxLyxFiA52Pr+utNDS6A=
X-Received: by 2002:a17:90a:e18b:b0:2f2:a90e:74ef with SMTP id
 98e67ed59e1d1-2f728da6048mr2898709a91.1.1736923228822; Tue, 14 Jan 2025
 22:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20250114104820.2613099-1-marcandre.lureau@redhat.com>
 <33501d8b-0035-404a-88ee-c6ff64c237a4@linaro.org>
In-Reply-To: <33501d8b-0035-404a-88ee-c6ff64c237a4@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Jan 2025 10:40:16 +0400
X-Gm-Features: AbW1kvYrYEdIAfvwPHGeiyNvzgmJJMPCafq4dSBRlNXQunnE9OCgWbH7r6IhcBA
Message-ID: <CAMxuvaxg_oTJyrWS7HU8F3MP==eVz_9dDogZ_ihHwCX_YX9Sfw@mail.gmail.com>
Subject: Re: [PATCH] plugins: fix -Werror=maybe-uninitialized false-positive
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi

On Tue, Jan 14, 2025 at 8:00=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 1/14/25 02:48, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ../contrib/plugins/cache.c:638:9: error: =E2=80=98l2_cache=E2=80=99 may=
 be used uninitialized [-Werror=3Dmaybe-uninitialized]
> >    638 |         append_stats_line(rep, l1_dmem_accesses, l1_dmisses,
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Is a false-positive, since cores > 1, so the variable is set in the
> > above loop.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   contrib/plugins/cache.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> > index 512ef6776b..c2c274cfcd 100644
> > --- a/contrib/plugins/cache.c
> > +++ b/contrib/plugins/cache.c
> > @@ -609,7 +609,7 @@ static int l2_cmp(gconstpointer a, gconstpointer b)
> >   static void log_stats(void)
> >   {
> >       int i;
> > -    Cache *icache, *dcache, *l2_cache;
> > +    Cache *icache, *dcache, *l2_cache =3D NULL;
> >
> >       g_autoptr(GString) rep =3D g_string_new("core #, data accesses, d=
ata misses,"
> >                                             " dmiss rate, insn accesses=
,"
>
> By the way,
>
> which compiler (version?) are you using?
> Just curious to check if we don't have any other false positives in the
> code base with it if it's a newer version.


GCC v14.2.1 from fc41.
I use '--enable-debug' '--enable-asan' '-Doptimization=3Dg'
'-Ddebug=3Dtrue' in my configure flags.
All targets do not compile with those flags.
ASAN reports various errors during make test.

Help welcome!


