Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D30DC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 19:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIYKt-0006tc-VK; Fri, 23 May 2025 15:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uIYKs-0006tR-OH
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:45:42 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uIYKr-0003PX-2N
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:45:42 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-601d66f8cafso371430a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748029538; x=1748634338; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmfkiwIfOoxFkN9kWkRi6+EEKrwIbG/WYOLCan1dKeA=;
 b=Tv6yXXQIoCmsTHJn6CxQFC0XcsTB+C5et4YsCITznfxU7heY06nOVRUiTjDlKBWPOk
 2Xd4fblms8baPVlGglgJpweng/rBMbFRLp0X6v8e26/TAGxiC21hNZL0n5koe4CLplWs
 1X750nk9iBvX6n7netyMBam6nRLeYjjt/j1hNdK8dqU7+wgtIOT0+fXl1ETPb1r8xTqg
 ZhrYnK8TRSevFbFciIAGWnixwKdHZqEqRqUxHMUbpSLOl0D1hjXSYwr0FrrSgBCd4EI4
 vEf+4hwDxIWbueECw8F+AurZUEKsRSlU9oOKZwsgnC4Oo+ySCq6Z3OVBiKub/Z14uZoP
 Ht7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748029538; x=1748634338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmfkiwIfOoxFkN9kWkRi6+EEKrwIbG/WYOLCan1dKeA=;
 b=qM3fVUl92a5KKUaDxlVvQVkdIBw63FWLPUcZPBk9QKMZUissuF+M1w+1DKAt8wECI8
 Z17kUbTXWhMVJl1XQetqCvFdHFjNnYj/xMgwPy8ViSHUBNefyquhm7lPV9+mJKRHvOkK
 p7aBdqdKlFMe2Q6PGPywREXds54Ha2m3j3mWeArE8p0lg6d0Q6uj9E8SzqafVd5sa/lX
 e84tDEdzC0CGlsUHjt1RqR9AWCqMRTlgJWRJKuLU/MxLjim2ZzasGfgvl75hddCjVoav
 pd5KTq0HrV+aD0uizFIfT7hOSYrV0IjxjNpsDcyjJ9pLXblsZXl5HeLsYymbfcaXayPe
 JVaA==
X-Gm-Message-State: AOJu0YznJDV4sqRgawzvBm+BsYhGwhxPXhEBwRZV26RaNLQBSpPXUwgF
 P/qWODGcsQHtBBZiBPan20dR2a7wCLpaFheCL09fOB7xcYyOkN+m3GVOdDYIiazQi/IFA3+JTse
 f///SAVQaODapKMoYQml758gtXzoieW4=
X-Gm-Gg: ASbGncvIiCcqp7wVI8XQs+b7CEZwl0Iwa2tVlTmS+fUEKv8T28EJAUQgny5zsNkidPX
 LnLmo3yI292QbYdlEtITaoaCjGB9e0k0cp9bDENtH4OY5go5nWAwhNRYJ1t4BKLSNZVr5uu4X16
 JC5oXzKSrJ7/2yt0b9cmNTdMaB6uRozE8=
X-Google-Smtp-Source: AGHT+IGukhY2eg40gV9lcITpQI+Yym9UG5cWz/hrK5pTz/Ab5RkCT7LiZeKyYLMaPGTGpUKJi8k7EGcwU5L6NRxLhSU=
X-Received: by 2002:a05:6402:90b:b0:5fb:868b:5a59 with SMTP id
 4fb4d7f45d1cf-602da8ddecbmr331752a12.32.1748029538562; Fri, 23 May 2025
 12:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250519170055.3693275-1-jsnow@redhat.com>
In-Reply-To: <20250519170055.3693275-1-jsnow@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 23 May 2025 15:45:26 -0400
X-Gm-Features: AX0GCFs0iEOTejYTfQtK38u-t16I1GgXQZyfF9G2kp5EEOflHmQ12eWafkZL5p0
Message-ID: <CAJSP0QUT+rtmBKXa6Ve7oV_rWB4aGwTU3=xBmQTDWv0GT4zRDA@mail.gmail.com>
Subject: Re: [PULL 0/6] Python patches
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Mon, May 19, 2025 at 1:03=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 757a34115e7491744a63dfc3d291fd1de5297e=
e2:
>
>   Merge tag 'pull-nvme-20250515' of https://gitlab.com/birkelund/qemu int=
o staging (2025-05-15 13:42:27 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 818060c02a53df4b27bc86cbac3a26009996b6a4:
>
>   qapi: delete un-needed python static analysis configs (2025-05-19 12:44=
:01 -0400)
>
> ----------------------------------------------------------------
> Python PR
>
> Add scripts/qapi and docs/sphinx/*qapi* to the Python static analysis che=
cks
>
> ----------------------------------------------------------------

Please take a look at this CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/10135225231#L448

Thanks,
Stefan

>
> John Snow (5):
>   qapi: Add some pylint ignores
>   docs/qapidoc: linting fixes
>   python: update missing dependencies from minreqs
>   python: add qapi static analysis tests
>   qapi: delete un-needed python static analysis configs
>
> Markus Armbruster (1):
>   python: Drop redundant warn_unused_configs =3D True
>
>  docs/sphinx/qapi_domain.py  | 25 ++++++++++++++-----------
>  docs/sphinx/qapidoc.py      |  5 +++--
>  python/setup.cfg            |  2 +-
>  python/tests/minreqs.txt    | 25 +++++++++++++++++++++++++
>  python/tests/qapi-flake8.sh |  4 ++++
>  python/tests/qapi-isort.sh  |  6 ++++++
>  python/tests/qapi-mypy.sh   |  2 ++
>  python/tests/qapi-pylint.sh |  6 ++++++
>  scripts/qapi/.flake8        |  3 ---
>  scripts/qapi/.isort.cfg     |  7 -------
>  scripts/qapi/backend.py     |  2 ++
>  scripts/qapi/mypy.ini       |  4 ----
>  scripts/qapi/pylintrc       |  1 +
>  13 files changed, 64 insertions(+), 28 deletions(-)
>  create mode 100755 python/tests/qapi-flake8.sh
>  create mode 100755 python/tests/qapi-isort.sh
>  create mode 100755 python/tests/qapi-mypy.sh
>  create mode 100755 python/tests/qapi-pylint.sh
>  delete mode 100644 scripts/qapi/.flake8
>  delete mode 100644 scripts/qapi/.isort.cfg
>  delete mode 100644 scripts/qapi/mypy.ini
>
> --
> 2.48.1
>
>
>

