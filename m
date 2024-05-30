Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC77C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZln-0004kt-Nt; Thu, 30 May 2024 03:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCZll-0004jv-63
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:00:13 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCZlj-0002uc-8f
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:00:12 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5b3241a69f4so217652eaf.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717052410; x=1717657210; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAPxzM3vONxFn7FrP1cmBxYkHqNr+pZuBhha2kexCok=;
 b=bDj2LoZGzbHxLp7ofECz6i6K7tvftN2SVgffgbycjsoXSsA43mXUlGkfz5Ah8yP25b
 JHkODUn3wUstTQErcM0HgMcUJNDe9rDztOhAjXWWKC8M7bUMl+e0IKMVL+ou7HMwJEVn
 /KxOjlxINHnmtEMi93OaS8Zf4XxDW5zedE90zhwIrEpUOIzIuUHKAkxIDxY5xgAeI91P
 OQ+AxD5ER6PSkja3NNuVAUgK2ruwW5LhMEJnMjVcJ238hJN8saSY0noTsxY6I/turKRC
 kfR/h3DIYC8UgY72u6fCsW7nmXdU7cQ0jcAO7TXAXM2sIq4XSpKu9Zv+7m/V+mYcr8gv
 /eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717052410; x=1717657210;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KAPxzM3vONxFn7FrP1cmBxYkHqNr+pZuBhha2kexCok=;
 b=Cms1EdevwZKut3mi1Lja4sxqzph1Upt6fJzq3xA/pu4KX0VJy8ZWAyWEpfm0MsamkO
 wMzMTNmo3pU4N/FYWS9H323/qPty1f1ctM2MxQhSIMjM/hXK1gQSaPAr2IJVW8W6FEMr
 0VDd9RpU9bPyY9XL5P3SlEaQfEqYIrw5NFAWzNzBG0VRhvnfQtdjBM+1xa+YlE5/Q6nn
 IHoWOs1/OJfmeNyVolbz3JmnlQ1n/iWtt/tzjK0GdFUeHg0X5M2Kj9CmgS76BLxf2q6j
 l/bBChlswBpLUWkYRM3ouZeWH+Pge6nfXf7bi8n7qjMkvdQp3jMEaxi8S2anvj0D19On
 Z8Sg==
X-Gm-Message-State: AOJu0YyKIeGnx6bCpDjJ58WODhCYq2ESgzVgp8e4s9WRqrsp7BLC8qwO
 khzoQjzwLP/f2I2J+g3mM1umONMtYseDX5bdqZwpBkQqYXuv7NMU
X-Google-Smtp-Source: AGHT+IEHj4BzKPpIyslQIXPdSH3ZpyV0hZuwMki7aIzcPOMqOUkoyzvllBBwrrpOrNNu2TcTZa5tsg==
X-Received: by 2002:a05:6358:9889:b0:191:96d4:b14d with SMTP id
 e5c5f4694b2df-199b985fe28mr151635655d.30.1717052408820; 
 Thu, 30 May 2024 00:00:08 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1931sm10158107a12.45.2024.05.30.00.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 00:00:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 17:00:02 +1000
Message-Id: <D1MSA0CSRX8H.13REUA0XDAW35@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Thomas Huth" <thuth@redhat.com>, "Laurent
 Vivier" <lvivier@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migrate-test: Add a postcopy memfile test
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, "Peter Xu" <peterx@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240529041322.701525-1-npiggin@gmail.com>
 <875xuwg4mx.fsf@suse.de> <ZldOal1YdAWLB5pj@x1n> <87zfs8ed2s.fsf@suse.de>
In-Reply-To: <87zfs8ed2s.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc34.google.com
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

On Thu May 30, 2024 at 3:35 AM AEST, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
>
> > On Wed, May 29, 2024 at 09:54:30AM -0300, Fabiano Rosas wrote:
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>=20
> >> > Postcopy requires userfaultfd support, which requires tmpfs if a mem=
ory
> >> > file is used.
> >> >
> >> > This adds back support for /dev/shm memory files, but adds prealloca=
tion
> >> > to skip environments where that mount is limited in size.
> >> >
> >> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> > ---
> >> >
> >> > How about this? This goes on top of the reset of the patches
> >> > (I'll re-send them all as a series if we can get to some agreement).
> >> >
> >> > This adds back the /dev/shm option with preallocation and adds a tes=
t
> >> > case that requires tmpfs.
> >>=20
> >> Peter has stronger opinions on this than I do. I'll leave it to him to
> >> decide.
> >
> > Sorry if I gave that feeling; it's more of a stronger willingness to at
> > some point enable shmem for QEMU migration, rather than wanting to push
> > back what Nicholas was trying to do.
>
> Of course, I didn't mean to imply that. I just saying that using /tmp
> would have been fine with me and I don't want to get in the way.
>
> > Enabling more arch for migration
> > tests is definitely worthwhile on its own.
> >
> > Shmem is just some blank spot that IMHO we should start to think about
> > better coverarge. E.g. it is the only sane way to boot the VM that is a=
ble
> > to do fast qemu upgrades using ignore-shared, that was true even before
> > Steve's cpr-exec work, which would be much easier than anonymous. And i=
t's
> > also possible shmem can be (in the next 3-5 years) the 1G page provider=
 to
> > replace hugetlb for postcopy's sake - this one is far beyond our curren=
t
> > discussion so I won't extend..
>
> Interesting, good to know.
>
> >
> > IMHO shmem should just be a major backend just like anonymous, and the =
only
> > possible file backend we can test in CI - as hugetlb is harder to manag=
e
> > there.
> >
> >>=20
> >> Just note that now we're making the CI less deterministic in relation =
to
> >> the migration tests. When a test that uses shmem fails, we'll not be
> >> able to consistently reproduce because the test might not even run
> >> depending on what has consumed the shmem first.
> >>=20
> >> Let's also take care that the other consumers of shmem (I think just
> >> ivshmem-test) are able to cope with the migration-test taking all the
> >> space, otherwise the CI will still break.
> >
> > Looks like ivshmem-test only uses 1MB shmem constantly so probably that
> > will succeed if the migration test will, but true they face the same
> > challenge and they interfere with each other..  that test sidently pass
> > (instead of skip) if mktempshm() fails.  I guess we don't have a way to
> > solidly test shmem as shmem simply may not be around.
>
> Here we have each of the 5 migration archs taking up some amount of
> memory + each of the 3 supported arches for ivshmem. They all could be
> running in parallel through make check. In practice there's maybe less
> overlap due to timing and not all CI jobs building all archs, but still.

I could just add back the GITLAB_CI gate for shm tests for now then.
>
> >
> > For this patch alone personally I'd avoid using "use_uffd_memfile" as t=
he
> > name, as that's definitely confusing, since shmem can be tested in othe=
r
> > setups too without uffd.  Nicolas, please feel free to move ahead with =
your

I was just thinking uffd could be used with another memfile (hugetlbfs)
but on second thoughts that's a bit silly. So use_shm_memfile would be
better.

> > arch enablement series with /tmp if you want to separate the shmem issu=
e.
>
> Or just leave ignore_shared untouched for the ppc series.

Good idea, I think everybody is happy enough with ppc series so I
will send that first.

Thanks,
Nick

