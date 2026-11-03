Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29753606A328
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gSqf5yg6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOITg-0004fl-PU; Tue, 03 Nov 2026 12:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOITX-0004ek-Gm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:39:12 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOITQ-0007IP-9d
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:39:09 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b2d149b483so20473057b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:39:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793727540; cv=none;
 d=google.com; s=arc-20260327;
 b=fwnh2AiUIe6WJNQu4D7B3kSISIbSSjQGNFFHuFcHjGHrbKE0j/FYj3f0kaoPsWxppO
 TyAegVzfxIEgdovnUs93Cd682H7fumaJbKFsvI8DET+nCkPlhcmPsQxVWg1GgUYypzKc
 YcK/1H+BoEyL0VdS6HOadT8deH82Js9vPJvVV/+x0UyuiBDQkMKo4iximhIgYcZ8a3mi
 WaKnqgak8OvStEqUq99kgjNRHNsMrijYrpucKSfRdbt6TaQUXinFmdODB71YHVNMaxWn
 wu+7gH968Aax0nbO+4DzZpvCds+etsVPQe0N2hCJCDwZwT54kK+RuycCJlglaNx2NflH
 xJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eYJsPy2af8MtLz+Lbc9s1O6GV6rp9tzvQ4qATqX/8aM=;
 fh=HhVnZIVgDvgRQluOQPzGzgOcqIdQcHm0kkiIkgMVLLQ=;
 b=Sz0JzdCeCTWgmwjX/z1z9pZIRyucRIxVl4/536uPEWSO8mnd0DzKakq3CXIybjVRg7
 sabb1NybZNga+bHptniaad0ALt3VipvYgrsTl4VVIUjZ3qgJZKpaA+75dWgJuwkSHdxx
 HyhWCetKOxHwEO8BWtVzyqxIzGujLfdrQXRLb4D6NydUXJgLi21wmALgkGZmKfo7H2E4
 wglT2FG4H6ORx0P0mh+osXcFfFxhDdIpjHP2xrhSHYVbkRDv9lhZs/+0UAfHF8UCMx/s
 v6ijuEaN6QWyhRlRyfcdNrtDZclOYHkun+lFUF8xERCfHT5WsAUb4DIpoUC3vsLG65E6
 n3Lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793727540; x=1794332340; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eYJsPy2af8MtLz+Lbc9s1O6GV6rp9tzvQ4qATqX/8aM=;
 b=gSqf5yg6APN+ePySeegDhxsGi+x/Q1Nrq5rbi1zaiJ7jjaoIa1XRqh2XOal+sJrf2r
 E7rNoUrwbjWgjOM2B1kfSJt1kEYp4INSOy7wgr563HzxOG9jAQvS49k7qV5OsHtqxd3w
 w61FsJjtfVw1P2W5VYFaRWJZAh1Mr9VqQZwjJBoefPvqtk5+PxZzeQH/VAfOmpu74Khm
 h0eV3t/RAhPVLOvGoo4rDuWqayTGESNhe604wC1q/zjLmlS3hepEzVPphgDsf96d6Dpu
 u0h55ycw7cJJnA9CuGkv4Un2KRLCP/hx7ks2DXuweLxrJTQ6IdqDwEGX70ct8H14VqRU
 H03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793727540; x=1794332340;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eYJsPy2af8MtLz+Lbc9s1O6GV6rp9tzvQ4qATqX/8aM=;
 b=ZzkRFFtbRDPZjH83wMmCwfcyu/0ko9273lwamBRaFaHv14917W40ioe0OyIoNasnhL
 eKLacy6LLD8sZyGtcJZM1LG0w3irRp9cKD1/Rv0uReIz6ktY5HWOlW/mpOy0txi4zLVh
 o5Uhjfnyk7melczySrLUTQwq9Gk1gmr9BSiCW9yUYa6rJx/oZGF+cGynsqKOziJ9f29G
 UnsYLxkwUNYG9yIduRfUOqMj3sF5i+kbD+wY8B91fJd8vxXcyND3q3MhQZoi+uPXPyip
 2YEjC1LtUK4YmedcLbmwyj/DiyB4tdpcyDPfwERBf3VO2BHjzdSbx9YXRklB9z3UlQaB
 YgIg==
X-Forwarded-Encrypted: i=1;
 AKwUvByRmcUwRH8Ryykf+bSHgp0zcACRffD34z4ojYs3wjmlLZAdXyYGEEzIagYJhldc/9CgNkjhI8JRfCXT@nongnu.org
X-Gm-Message-State: APuU4Z96wYJhCEa8EHtPU3uWswDelSb/mV76ETFV553KJScND/Heqyi7
 SDfH+CjdBxEIi5if0KJmEMmqRZmvfzKmcwLBZK6n0p3fLxu0b8IBj2m/KBvsJEAbAH7B8ujEOaZ
 fLhhxyi3uOoUQQoZBaUkVY6LwZ5w6mCLLKnyX5b645A==
X-Gm-Gg: AYBFou2BMbkDBZJ7IFs7lyiLO0QFCVwbhuj4dcWAOb2HwR4D0hDRKPZCnXzwMG+rhMA
 W1L1+Bqvqc5hXXbl6aIrMkDLEC6Mf6ouCduIK3iy9dq6uPa86HQs6wHKjAtrJsoLIEqqmnXN4pH
 2zzOC4v2/S/ilvYw3jD3vmZ+LCUpJhx4UCUfBOph1J8tJuxqMqhj/HMUwMwU6FaGG0E4At0SlSV
 QtRd67OOROLPQxh9rScHitXTszjbLXPHBEmOYbTjx8K5qUVWYE5SbiD3EEgn7BoIhR9QyWPwQ0O
 qZyZMmRQOH5yBKTiRpVePpstYFISYMU5pXWNdrFoSl2afGZRAE+5dweBaIrPX1FzhuZVgbseH/e
 /9WrK0s0EtA5r+u2hVU1ViYaMeIajJqImftq5d7/l7h5j8c6Th/hFKqJtI5PSIn34R/HASfYKFL
 7qPW7vYYt9HS9cwsShCz19
X-Received: by 2002:a05:690c:800c:10b0:8b0:a8c1:b203 with SMTP id
 00721157ae682-8b2b6723069mr67438167b3.29.1793727539613; Tue, 03 Nov 2026
 09:38:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793207602.git.mst@redhat.com>
 <05f5ab90ea52b0151958fd2506c15858e3e80442.1793207602.git.mst@redhat.com>
 <92a5bdce-af21-4e8a-b869-57e903531a77@linux.ibm.com>
 <0af8c97e-55bf-421c-8b38-de1f88f44547@linux.ibm.com>
In-Reply-To: <0af8c97e-55bf-421c-8b38-de1f88f44547@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 17:38:48 +0000
X-Gm-Features: AclHuK9CkhCVJe0dxfLGQ9dSYLi3TTLaLivqVZblePfmMDmBXX0_RR2g61VogL0
Message-ID: <CAFEAcA8+x3Bf0LDyh9hU6J9N-A8Lii6fb8orB2Coucn-fAYtTA@mail.gmail.com>
Subject: Re: [PULL 49/78] util/event_notifier: more strict API
To: Eric Farman <farman@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, 
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 17:32, Eric Farman <farman@linux.ibm.com> wrote:
>
>
>
> On 11/2/26 10:48 AM, Eric Farman wrote:
> >
> >
> > On 10/28/26 1:16 PM, Michael S. Tsirkin wrote:
> >> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >>
> >> We have .initialized in EventNotifier to track was it actually
> >> initialized, and we have a comment that @fd passed to
> >> event_notifier_init_fd() must be an eventfd object.
> >>
> >> Still, there are two specific users, which ignore these things,
> >> and use -1 as specific value storing in notifier, to mark it
> >> "uninitialized".
> >>
> >> Let's make strict API:
> >>
> >> - store only valid FDs in initialized notifier
> >> - _set() asserts that passed fd is valid
> >> - _get() asserts that notifier is initialized (actually, except
> >>    the two specific cases we rework, all other callers are not
> >>    prepared to notifier being uninitialized when _get() is called.
> >>    In this case _get() returns 0 (which is a valid fd), and caller
> >>    will mistakenly use it, which is worse than abort())
> >
> > Well, there are other cases that would require rework not addressed
> > here, as this commit breaks (at least) vhost-vsock-ccw and virtio-net-
> > ccw (for vhost=on) on an s390x host. I'll look into that, but was not
> > prepared for such a late surprise.
>
> I sent a fix [0] for the assertion that shows up with this particular
> patch in some of the common configurations, but it still leaves VDPA
> broken on s390x (which was also working before this commit). So, not a
> good idea.
>
> I just posted a variation [1] of that which restores VDPA functionality.
> Would that be doable? Or can we get the assertions here removed until we
> can adhere to the API restriction?

If this change regressed something, and we don't have an immediately
obvious fix for that, we should probably revert this change.
Can we do that without too much trouble?

thanks
-- PMM

