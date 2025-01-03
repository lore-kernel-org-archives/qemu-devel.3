Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ABDE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 20:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tToKX-00016F-36; Fri, 03 Jan 2025 15:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tToKU-00015p-VK
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 15:31:35 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tToKR-0001Lj-Ap
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 15:31:34 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d8c1950da7so9926096a12.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 12:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735936289; x=1736541089; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8i7IPi16OcQksk0QF9NDfx+W0hwRWbuw9kIibbgo+v0=;
 b=R8O4/EiZ/EANKieDq9abZMoxw7DtlZVTrhQkwJ20ecnf9ac85+WSa3gyiEaFrjElMG
 4myj1Q3JWrN2WXaWSQVNArQf07SbK9br7MJ0pgrY1j5S0bp5GSf/EgosUBmRhU/GWJe8
 okBcFHkBH4ANAy8lFYUShnvgvuaLW7hrj4z8E/RD7r2d9NsDomxKbTiL6t3LZgI7hoUK
 6XFRHPefrqg9fYlmzkh3s9koLsv34yxdkaXhpUqhdlK0wmX7Met5rNhJbaCkh/P/+imW
 RhpCRPqRFP1ou2BIbL+aeCcw7+d7baD2YdVH58VY8wSwn9YG5TxaBZEqKEeICJxEHhi7
 b3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735936289; x=1736541089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8i7IPi16OcQksk0QF9NDfx+W0hwRWbuw9kIibbgo+v0=;
 b=JNU0kCG7QD2ewTfyFbOIctF9qJGfztw+U1qC17ntV+rXaSKdSUbtOnDIdRY9DgsjUQ
 0XL0+bVUiFTlYAN5hmVqwiTS3Trxumiz6ZtGspgQK1dj3aq/hWMUgWGdEK9FEzeIHz2B
 KO9NftqzlRdLFB8ZJlDsDbjRBsXRReHpmY4lNDbq9fqPNJhR6NpzyTd9OvoRIaxXbmj7
 BTo7HAeewVrHFem1dh+zLA67S4uV2tGe/aZkcDuTag9THnsOURMfvuQS64GzOvbr2Xho
 f9p2NxtEwYMi2c/ug8+RF2eFD26cYdAQQMcGrPXbRtQSkxV4g0dqf1mRMNZ3sOa+Tk15
 VrWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgyKDrt7t8+vGfPMNH5pk+h3VwN/+4u+io9dr4eaWEBev8e7viRFrxMt6BgJqVb/XxFzdpU9UiY3pC@nongnu.org
X-Gm-Message-State: AOJu0YxuCPrtEBd0F3vkp14pE5hT35kefLPMzUojqGoPVdtc2Jn6trqY
 Hj4PJRXZUtppOtqr3v6ahwIf9X3/4AzOTxv6zQ5T3eQPDxZB+hFbbfmkjWFDE3uo7Q3pW0Jety/
 4IUnVwGv7RhYkwcpmrNJGCdoxbl8=
X-Gm-Gg: ASbGnctOEVUA9jjh1jr7tOfPm4JphIrltJt0P8Iv59T/VU/Rp8wGSBxatl306qZ62b4
 it35e71JTQL/GlGxYNNeBxoZ478getjZcahQM
X-Google-Smtp-Source: AGHT+IGUTfw/s1es9/a6qvqmxxpC7VNRzMKm/0OkiBk1YXxtGybWaaITaxrJCJEIXKOT5jveEPTAG0bPPOKNVwCCJYA=
X-Received: by 2002:a05:6402:540b:b0:5d0:d610:caa2 with SMTP id
 4fb4d7f45d1cf-5d81de1ed59mr45400955a12.26.1735936288384; Fri, 03 Jan 2025
 12:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora>
 <87zfkrtsgt.fsf@suse.de> <Z2WbSZkEGSnA-BX9@x1n>
 <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
 <874j2f92cn.fsf@suse.de>
In-Reply-To: <874j2f92cn.fsf@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 3 Jan 2025 15:31:16 -0500
Message-ID: <CAJSP0QVxQf4neUewBha9f=n+6-f2eTD_o5f7v+1R2Wm2y07paA@mail.gmail.com>
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
To: Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

On Fri, 3 Jan 2025 at 13:32, Fabiano Rosas <farosas@suse.de> wrote:
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > On 20/12/2024 17.28, Peter Xu wrote:
> >> On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
> >>> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >>>
> >>>> Hi Fabiano,
> >>>> Please take a look at this CI failure:
> >>>>
> >>>>>>> MALLOC_PERTURB_=3D61 QTEST_QEMU_BINARY=3D./qemu-system-s390x UBSA=
N_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_st=
acktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN_OPTI=
ONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktra=
ce=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D=
1 PYTHON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/py=
venv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-s=
torage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/4S3awx_3/0/qe=
mu-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/4S3=
awx_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >>>> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95
> >>>> stderr:
> >>>> Traceback (most recent call last):
> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bui=
ld/scripts/analyze-migration.py", line 688, in <module>
> >>>>      dump.read(dump_memory =3D args.memory)
> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bui=
ld/scripts/analyze-migration.py", line 625, in read
> >>>>      section.read()
> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bui=
ld/scripts/analyze-migration.py", line 461, in read
> >>>>      field['data'] =3D reader(field, self.file)
> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bui=
ld/scripts/analyze-migration.py", line 434, in __init__
> >>>>      for field in self.desc['struct']['fields']:
> >>>> KeyError: 'fields'
> >>>
> >>> This is the command line that runs only this specific test:
> >>>
> >>> PYTHON=3D/usr/bin/python3.11 QTEST_QEMU_BINARY=3D./qemu-system-s390x
> >>> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
> >>>
> >>> I cannot reproduce in migration-next nor in the detached HEAD that th=
e
> >>> pipeline ran in (had to download the tarball from gitlab).
> >>>
> >>> The only s390 patch in this PR is one that I can test just fine with
> >>> TCG, so there shouldn't be any difference from KVM (i.e. there should=
 be
> >>> no state being migrated with KVM that is not already migrated with TC=
G).
> >>>
> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
> >>>
> >>> This is harmless.
> >>>
> >>>> **
> >>>> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret=
 =3D=3D 0): (1 =3D=3D 0)
> >>>> (test program exited with status code -6)
> >>>
> >>> This is the assert at the end of the tests, irrelevant.
> >>>
> >>>>
> >>>> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
> >>>>
> >>>> If you find this pull request caused the failure, please send a new
> >>>> revision. Otherwise please let me know so we can continue to
> >>>> investigate.
> >>>
> >>> I don't have an s390x host at hand so the only thing I can to is to d=
rop
> >>> that patch and hope that resolves the problem. @Peter, @Thomas, any
> >>> other ideas? Can you verify this on your end?
> >>
> >> Cannot reproduce either here, x86_64 host only.  The report was from s=
390
> >> host, though.  I'm not familiar with the s390 patch, I wonder if any o=
f you
> >> could use plain brain power to figure more things out.
> >>
> >> We could wait for 1-2 more days to see whether Thomas can figure it ou=
t,
> >> hopefully easily reproduceable on s390.. or we can also leave that for
> >> later.  And if the current issue on such fix is s390-host-only, might =
be
> >> easier to be picked up by s390 tree, perhaps?
> >
> > I tested migration-20241217-pull-request on a s390x (RHEL) host, but I
> > cannot reproduce the issue there - make check-qtest works without any
> > problems. Is it maybe related to that specific Ubuntu installation?
> >
>
> Since we cannot reproduce outside of the staging CI, could we run that
> job again with a diagnostic patch? Here's the rebased PR with the patch:
>
> https://gitlab.com/farosas/qemu/-/commits/migration-next
>
> (fork CI run: https://gitlab.com/farosas/qemu/-/pipelines/1610691202)
>
> Or should I just send a v2 of this PR with the debug patch?

Here is the staging CI pipeline for your migration-next tree:
https://gitlab.com/qemu-project/qemu/-/pipelines/1610836485

Stefan

