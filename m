Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A953CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxem-0004gW-7n; Mon, 05 May 2025 11:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uBxej-0004fs-Lp; Mon, 05 May 2025 11:22:57 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uBxeh-0000L8-RL; Mon, 05 May 2025 11:22:57 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso8622987a12.2; 
 Mon, 05 May 2025 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746458573; x=1747063373; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fwRVe8mylFb/HETm6WdFXtSzSfOlSCu9lZYaXy271I=;
 b=JJ0bNP8L2gasxlL1kvNES9M67acCGEUbgY1BICPupbmcau/lFmtB28dnBmcd3EppRl
 YQ2Tktii4qJMnR2wQ8EmOkPDSD6KcpOnVrnzbWV5iSddhgChPbrF/rDIT9iNrbb4QacM
 UO/ETgauyX05f5J0pJyL8peeWtOwXSgVjjsfD1b0wrqvmQaCB2cHPhC2gGJEmgetns97
 enkqjdXFnxCzZow+Fz9l5gwFs2RBV2PU3KUB+NhEtT3fskBXh9ZL5teBW4gyCVMl6EeY
 hBmCq8FBpDZjvggrkQ84tKiXcfCPpBSetLOF6OS23kN7V3CePfPm5ve3GwiGFyPFHThZ
 ABgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746458573; x=1747063373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fwRVe8mylFb/HETm6WdFXtSzSfOlSCu9lZYaXy271I=;
 b=kXKQqRycbe2qPIgGhv8zap6pqM9dcIxegdxlw4fR29mGZEYPcLw2YfOdpJKoRD1HyY
 U074NK3Qu+/cPHfIGGcVLR9yrXDkmxfDy6WlMEh+IdAcjAFr6d2+9L5w3YGqX+3s3TQ+
 4v2n7KYTgOg5aOW+Gw9jn1OWc6u7DCwFdhQlqEw479KYs3Yq4IGzw4ay91XhcSVeT3hl
 D6W+zbc2PfjEIEfzgWlyJQyCI/Lb6U4X+KvyfBIkbc8tBKrFze2TL2JN4tfAKGHsyo2K
 dB8UipC+RBjfE3NpvZ8IDp2Gscs9BFlNRlyfEzYyhB25BzgG1+7uBt2rUtqTYsJmXg4t
 V2dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtj92slE3w3wTxzB4lgVzLPcdyW/+sxLUvlQxYyTkW1sWPsPq1ZZDKzTh5powooMjX8iZlwODRcTOT@nongnu.org
X-Gm-Message-State: AOJu0YwoPbA3Tu8gR9du+cM2f0sNCQxDI7Moktvj4aEuUWJz5z8Kwt54
 2fpvfqh8CtXE01t+5P7TlSwnSp274biTKgYEa26M4ppccJrP8owl0whd1lH/yQUzHRiFrY6CzEr
 G0Xz3zv1kbwFb6BMLFoK8XXTSAf0=
X-Gm-Gg: ASbGncvF53ocAqCULWkvqglrpQw8goesTT4BKNFrXpRNiPXifqThWevbTjJLWioujFC
 i39RUlN4ZSRy7q4alnrYhL/4PVt3ecJ4ZG9n5CpzztQuTCv/Ur/hwkThuoTYAEzWDSeZDxA6ExK
 j+xb+ilHfrowP6fy7h+sn4ZCxOpCIuBwo=
X-Google-Smtp-Source: AGHT+IFfXvn4z6bSRiAiXkik081f8SFfHTk6WCdK5GarlruUt2tCAEJD5/FugFMJW7UO6wDdt5lsepliNCOh4BZ0qhc=
X-Received: by 2002:a05:6402:268c:b0:5fb:3ca1:fb3c with SMTP id
 4fb4d7f45d1cf-5fb3ca1fcdamr1095633a12.27.1746458573222; Mon, 05 May 2025
 08:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250501092511.24068-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250501092511.24068-1-vsementsov@yandex-team.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 5 May 2025 11:22:39 -0400
X-Gm-Features: ATxdqUHWrZuSF81Ny29_hXRP9CzsqaxN5mmc7f_LjQgwwIOzreJSGluVOcucHlo
Message-ID: <CAJSP0QVwqWFuLcin+bWcjUwxZKMynqTgrGgMO6rrGu97km163g@mail.gmail.com>
Subject: Re: [PULL v2 0/8] block-job patches 2025-04-29
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Thu, May 1, 2025 at 5:25=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> The following changes since commit 73d29ea2417b58ca55fba1aa468ba38e3607b5=
83:
>
>   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging =
(2025-04-27 12:47:23 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2025-04-29-=
v2
>
> for you to fetch changes up to 35655b2d1b1015e3a6fa99ef9c2afc1826a765ba:
>
>   blockdev-backup: Add error handling option for copy-before-write jobs (=
2025-05-01 12:12:19 +0300)
>
> ----------------------------------------------------------------
> block-job patches
>
> - deprecate some old block-job- APIs
> - on-cbw-error option for backup
> - more efficient zero handling in block commit
>
> v2:
> [03]: move variable declaration to function top, to silence clang and to
>       follow QEMU coding style
>
> ----------------------------------------------------------------
> Raman Dzehtsiar (1):
>       blockdev-backup: Add error handling option for copy-before-write jo=
bs

iotests-pylint is failing:

Log file "stdout" content for test "03-tests/iotests-pylint.sh" (FAIL):
************* Module tests.copy-before-write
tests/copy-before-write:151:0: C0301: Line too long (94/79) (line-too-long)

https://gitlab.com/qemu-project/qemu/-/jobs/9931080975#L656

>
> Vincent Vanlaer (5):
>       block: get type of block allocation in commit_run
>       block: move commit_run loop to separate function
>       block: refactor error handling of commit_iteration
>       block: allow commit to unmap zero blocks
>       block: add test non-active commit with zeroed data
>
> Vladimir Sementsov-Ogievskiy (2):
>       qapi: synchronize jobs and block-jobs documentation
>       qapi/block-core: deprecate some block-job- APIs
>
>  block/backup.c                                  |   3 +-
>  block/commit.c                                  | 118 +++++++++++++++++-=
------
>  block/copy-before-write.c                       |   2 +
>  block/copy-before-write.h                       |   1 +
>  block/replication.c                             |   4 +-
>  blockdev.c                                      |   6 ++
>  docs/about/deprecated.rst                       |  31 +++++++
>  include/block/block_int-global-state.h          |   2 +
>  qapi/block-core.json                            |  95 ++++++++++++++----=
-
>  qapi/job.json                                   |  30 +++++-
>  tests/qemu-iotests/tests/commit-zero-blocks     |  96 ++++++++++++++++++=
+
>  tests/qemu-iotests/tests/commit-zero-blocks.out |  54 +++++++++++
>  tests/qemu-iotests/tests/copy-before-write      |  90 ++++++++++++++++++
>  tests/qemu-iotests/tests/copy-before-write.out  |   4 +-
>  14 files changed, 471 insertions(+), 65 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/commit-zero-blocks
>  create mode 100644 tests/qemu-iotests/tests/commit-zero-blocks.out
>
> --
> 2.48.1
>

