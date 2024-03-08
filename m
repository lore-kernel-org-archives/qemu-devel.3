Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874C4C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rie4f-0004DR-QI; Fri, 08 Mar 2024 12:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rie4e-0004DE-C7
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:32:00 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rie4c-0007Ei-D1
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:32:00 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5683576ea18so536760a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709919115; x=1710523915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NviDvTymXW52i5jxAqbmXlgQ6cPtIoOGEuP56BfSjYY=;
 b=Epk+1jB3A3Wj7DR8F9nID60lIlUTaMWRjzA3qhh9SavNy/b1o/b1MDyzxr7BkiUskD
 3514yiOC+lSbqcs2V1vE7MgPmwxjnh+k2QsYSVNcfI15v6b1wVlbZGoSDSjjMwCvpmk7
 dma4bDoSPoe5EYvyl0ljnhm0R9Sxj5W32pB6aGuzeVR0vLX5rM44S81BpNSNIoUEtm+k
 aJion+JINxewXReDWW7yOLhx7JuFUp2+WMU0VQzp/CEUkrjXAky82KfDLHZG0IMCSdg/
 0369Xuc1bKGB1+YrdHneWSfpUSFq+c3XApj5382TKAVSs//S/N2+ADn23ZBjTrUVunwx
 5ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709919115; x=1710523915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NviDvTymXW52i5jxAqbmXlgQ6cPtIoOGEuP56BfSjYY=;
 b=E2nw2IEPWG5wdQSp2dpL/aKwxlQmDWthAFhbPDGZ6Mh0vSu3j/IT/w7XPHh7rCTfYM
 uCqO8aXc8pcvsb8gwVdEXJwoP7BXSFkQFSJrXFreWHFKsxg0LOTmwloOHS+imjPfbE2l
 eklVAiYc5DN2fMkQdQyJ/NCN8AvBjGs4dd4TGwfI3UT7jvY6al8OkGFYpiDlnwN52wjb
 IiVzYFMGgju7UNZAQlz23wxDKhAeQbINTjuRbPKqeZycup2HWsAjSa9QNF6lUoTkGrS0
 xzJruVm7pKz0nMfAHHW/v2sCM6u2FSATnliSi6f0iz7SEROsdG88WL8p+o6tmVbQ9s4g
 R21w==
X-Gm-Message-State: AOJu0Yzw69Vioo2pXf2FzOqTijsMSF0t8Zcd3nL8L4Z99O9TXbJ51Dxo
 wiFf4NkePLvtN4A+l7EKBXV/ylTB2GcRP33SJVHH9PyWGQpEcQlsW8YtcmV+kgYECb6xE1Aalsf
 eK/Z2rBAsyaiTWwbuvV1SrxFllS3xw6nQ9ouf6636+DXoE7pl
X-Google-Smtp-Source: AGHT+IEn0D7Yc3RBdO+JrJULgEltTX5I6gayHLufZGrKDUXRYy3A3O6YWiTIpx5Wua3jgWGwG2qQP2edqryqQLXCGro=
X-Received: by 2002:a50:cb8a:0:b0:567:3c07:8bbc with SMTP id
 k10-20020a50cb8a000000b005673c078bbcmr2341028edi.21.1709919115568; Fri, 08
 Mar 2024 09:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20240308145554.599614-1-pbonzini@redhat.com>
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 17:31:44 +0000
Message-ID: <CAFEAcA-7N+tOGPcTiR2wUGcE6c_KPnbGPV+YpY-qcQGd2Q8qYA@mail.gmail.com>
Subject: Re: [PULL 00/12] Misc fixes, i386 TSTEQ/TSTNE,
 coverity CI for 2024-03-08
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 8 Mar 2024 at 14:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a=
87:
>
>   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsq=
uad/qemu into staging (2024-03-06 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 47791be8cc6efa0fb9c145a2b92da0417f4137b8:
>
>   gitlab-ci: add manual job to run Coverity (2024-03-08 15:52:26 +0100)
>
> ----------------------------------------------------------------
> * target/i386: use TSTEQ/TSTNE
> * move Coverity builds to Gitlab CI
> * fix two memory leaks
> * bug fixes
>
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>       meson: Remove --warn-common ldflag
>
> Dmitrii Gavrilov (1):
>       system/qdev-monitor: move drain_call_rcu call under if (!dev) in qm=
p_device_add()
>
> Paolo Bonzini (8):
>       hw/intc/apic: fix memory leak
>       oslib-posix: fix memory leak in touch_all_pages
>       mips: do not list individual devices from configs/
>       target/i386: use TSTEQ/TSTNE to test low bits
>       target/i386: use TSTEQ/TSTNE to check flags
>       target/i386: remove mask from CCPrepare
>       run-coverity-scan: add --check-upload-only option
>       gitlab-ci: add manual job to run Coverity
>
> Sven Schnelle (2):
>       hw/scsi/lsi53c895a: add timer to scripts processing
>       hw/scsi/lsi53c895a: stop script on phase mismatch

Looks like this hits a TCG assertion on aarch64 host:
https://gitlab.com/qemu-project/qemu/-/jobs/6353434430

Several of the qtest tests fail with:

66/853 qemu:qtest+qtest-x86_64 / qtest-x86_64/vmgenid-test ERROR 0.44s
killed by signal 6 SIGABRT
>>> G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/E8PpwMky/0/qemu-project=
/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./sto=
rage-daemon/qemu-storage-daemon PYTHON=3D/home/gitlab-runner/builds/E8PpwMk=
y/0/qemu-project/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=3D139 QTEST_=
QEMU_IMG=3D./qemu-img QTEST_QEMU_BINARY=3D./qemu-system-x86_64 /home/gitlab=
-runner/builds/E8PpwMky/0/qemu-project/qemu/build/tests/qtest/vmgenid-test =
--tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
**
ERROR:/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tcg/aarch64/t=
cg-target.c.inc:1511:tcg_out_brcond:
code should not be reached
Broken pipe
../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from
signal 6 (Aborted) (core dumped)
(test program exited with status code -6)

thanks
-- PMM

