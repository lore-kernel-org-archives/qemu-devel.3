Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44EAC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC6p6-0008UY-64; Tue, 28 May 2024 20:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC6p5-0008UH-30; Tue, 28 May 2024 20:05:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC6p3-0007Nh-7B; Tue, 28 May 2024 20:05:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f32b1b5429so10564665ad.2; 
 Tue, 28 May 2024 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716941138; x=1717545938; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfyQUKByS9pJkQ3di9eRjiDadh18UVkVWkObAg4lTxQ=;
 b=Y4zzXr03eyTpWgOFpNBCZsW70iLsx0wDS9j9XZFjz5SHQFye5J+CZHS6X4YwlVB/Et
 29W4WN5uvg0R0qWDPFVi22h01YJsbLikd1apFvZXqGcKhr0cLKLMRm1a6RlEI1ahxtUx
 2iikbRPkh2yPC8TfYKY4UTnOOiQGrjv8s3C+A2JiJ1geSAXVhFD40uialKdKFEhMMrsG
 A7LYHX0zTwwf+t1uwqrYKPdXh0i7SvpDA5WRLrxMqT1cRTWsEHVJI8d84yPk3LVAuOiB
 OsVFOFfqFq5/CT5HxHOdNqUjJBGS6mYXTG0aiqyQzqbUcHO4A/BZMsLf6ca5NNdrV9VO
 dWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716941138; x=1717545938;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vfyQUKByS9pJkQ3di9eRjiDadh18UVkVWkObAg4lTxQ=;
 b=BQVFBlREVgEhrF1JXbIo4C+f3rN+g5YztcQfOjM5C3NtU70D3uSKsqSftv40dte8nk
 ORs+hp4fyAIUrRlYSPvyyM+joqQX56gSVRDCVfakiaRRYH6YkSaNvKnZx6ZpuLACeypB
 M72xL6jT3Db5VK+yYGLKUyL64snUqiyNQRjpJxpWFQKlWjXNReMI3MkVylGzZUjDyAUt
 9+LMde7FOGszSe/TRIokHUKKGf21iILEhf2t12aUZDq1aPXYE9lpYg8WbSS8mUX67a3c
 vbINzIWbU3DYmAf+q01HnCfV81byh0/MjyaoPcvwOHlaQaL8Jdv/p/N2SnVSaJUcppci
 bt3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT2cjP6zYaGEJpJS8Szi15Gi/aSdAmNTId7cTZ/QTLzcxt6v9NmsgCjMqH0pG6wq2cSMCN4SQWCjGdWgkV5N+w9+ox
X-Gm-Message-State: AOJu0YxF9P4HQVVZ1pduxWxEoDdjWl5ts7ReMx0K1C4azUsY8UsvJl2w
 uPSLLcz2E747SlmqgZzY3DDZ4Z1FHt4A9oPMaz7j6UFZ2CFc6FT+
X-Google-Smtp-Source: AGHT+IF4fb9doq5P9S5pbmlThP1fbKhbVUX/b/ys32BjD72OobqmZ7tT48Xcep61spPpHNpgtdQ7cA==
X-Received: by 2002:a17:902:db07:b0:1f4:8ad1:3672 with SMTP id
 d9443c01a7336-1f48ad13b52mr92527965ad.22.1716941138179; 
 Tue, 28 May 2024 17:05:38 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9a683asm86746605ad.225.2024.05.28.17.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:05:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:05:32 +1000
Message-Id: <D1LOU3F9ZD3Q.3KYRK41PZT98O@gmail.com>
To: "Peter Xu" <peterx@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Fabiano Rosas" <farosas@suse.de>, "Thomas
 Huth" <thuth@redhat.com>, "Laurent Vivier" <lvivier@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH] tests/qtest/migrate-test: Use regular file file for
 shared-memory tests
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240528042758.621589-1-npiggin@gmail.com>
 <ZlXdmi7PqKJdv3fP@x1n> <ZlYAvIFodnTrQIkX@x1n>
In-Reply-To: <ZlYAvIFodnTrQIkX@x1n>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Wed May 29, 2024 at 2:05 AM AEST, Peter Xu wrote:
> On Tue, May 28, 2024 at 09:35:22AM -0400, Peter Xu wrote:
> > On Tue, May 28, 2024 at 02:27:57PM +1000, Nicholas Piggin wrote:
> > > There is no need to use /dev/shm for file-backed memory devices, and
> > > it is too small to be usable in gitlab CI. Switch to using a regular
> > > file in /tmp/ which will usually have more space available.
> > >=20
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > > Am I missing something? AFAIKS there is not even any point using
> > > /dev/shm aka tmpfs anyway, there is not much special about it as a
> > > filesystem. This applies on top of the series just sent, and passes
> > > gitlab CI qtests including aarch64.
> >=20
> > I think it's just that /dev/shm guarantees shmem usage, while the var
> > "tmpfs" implies g_dir_make_tmp() which may be another non-ram based fil=
e
> > system, while that'll be slightly different comparing to what a real us=
er
> > would use - we don't suggest user to put guest RAM on things like btrfs=
.

Right, these days I think /tmp usually is not tmpfs but just a regular
filesystem. For these tests that's okay though. And it gets us working
with gitlab CI. The ignore-shared test works and is verified to skip the
copy (according to counters and some tracing I did) so I think it's a
good step.

> >=20
> > One real implication is if we add a postcopy test it'll fail with
> > g_dir_make_tmp() when it is not pointing to a shmem mount, as
> > UFFDIO_REGISTER will fail there.  But that test doesn't yet exist as th=
e
> > QEMU paths should be the same even if Linux will trigger different path=
s
> > when different types of mem is used (anonymous v.s. shmem).

Ah okay userfault. I guess that would require real tmpfs. We could just
add a new option to the harness for require_uffd when it comes up?

> > If the goal here is to properly handle the case where tmpfs doesn't hav=
e
> > enough space, how about what I suggested in the other email?
> >=20
> > https://lore.kernel.org/r/ZlSppKDE6wzjCF--@x1n
> >=20
> > IOW, try populate the shmem region before starting the guest, skip if
> > population failed.  Would that work?

I think that's good if you _need_ shm (e.g., for a uffd test), but
we should permit tests that only require a memory file.

Thanks,
Nick

