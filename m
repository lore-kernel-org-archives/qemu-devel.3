Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=owKMl6oq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJU05-0001SX-NB; Wed, 21 Oct 2026 06:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJU04-0001SK-Fv
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:56:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJU01-0004vK-JW
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 06:56:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so558901f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792580207; x=1793185007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LTrLIzG+NNl/ftlmbA1Ww5yw1Xs2o9YwNwsFoyvFU90=;
 b=owKMl6oq3fBSkojKOsoK9/ex5QhGs/QkdNbqOOUC9SJ0Bd+wUWnb8YEsytuDopv4M0
 Kfheh+sHMLZJ+s39och9MDGDtFlBDu8cGexrySdJb8IpbKtBRGO43WlCtS4zHUC6Godc
 aMtdWoaSR62HVeZXeXqKnGT6a3oynaN/e91CjBOWoLqBe/MdbOem4av09MrkSALKoGwd
 dqem64RvRCEGaY82NDMy1EEGhC2g+z8lUESBL1q5fvhq82xhpYcYgVWeW3wcrienfPfw
 cG3MoVa0vwyJ50clPudMVz0HDVA7io0F0xkPJErn277iKuT50DIuDI8Hm0zpYEWUsIsw
 JJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580207; x=1793185007;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LTrLIzG+NNl/ftlmbA1Ww5yw1Xs2o9YwNwsFoyvFU90=;
 b=UGJFy5cNa7wTjDL/K9uqrCKfZoIqwSy3D8T1Hi/dfKXtd0vP67UzEpnuRc9OakZW/F
 L+RYV0oZSga0c5tdItNTbs5X7Fz+zvqFeLQcd5ABaje65kMd/Ulxlhavq0fLeoxMPFaJ
 7dKvRdX6wgqRA2Lf8HJsTHs3S+JQOcb+T9FrnNnnd9IVfi/HnIx9QSnn9XG2+Eb8iIGo
 iJFn+ucCEYMnFBhMWU+sDYQmfSbucnqXVxngXTkIbWqr1bfjzwAGHnLNAS354nSQ8+z7
 Y4tWq8SaAn9x0Cjsa6A09rGPqUGzOoLCCW8BxAm9dFkUzKeKEjpvnkOJW6m22ckx3sGa
 Qk5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByL6BhMmjTa7i6lH4iy6ttkzNTBoDt905cHgDvyglrRYOsxJAtMEu4JfscL2Zn3ijqsRSrnsqpygEp2@nongnu.org
X-Gm-Message-State: AFq9FYLFQFyfVXhQrhzdP/MXPPhy/uLbYEgNP+j+NQxcxl4xk2mgIgDe
 9BKDWFaWXiMo4UJfhPDmr3EJp71YBzzDNG0g+b8fwwzh2N9Vvi2c27WSy0jL5hPM3IM=
X-Gm-Gg: AYBFou2JLYjXpIPpcqveyHU/KXIvvVMV+ABk3AjiOd8N6rXn0g6aUG1VUIciA8nfqoH
 jojGrzIZjXunCpQXGaFm0aY3r+IxOENSTuLkGMo82t8p0HV3njfayOmK2uq1xft9crDFgnnEuDF
 MDrZG5OUg9HPOfxHHwWGoSQUVqdfku9c/4jfsRLcjegGtGZm3WoeBycGSwgxJuqxMDnVTj4rXZv
 royk5WOB8lgPYHF5ttOXSNORrSSwGWWQI5A8Z1y2Q2/oonqV0wucgEUzutBMpPJz+7eLWAqr/Yd
 EM5RSJbH4iLiho9x070X41Cpls8xqHYU5inrqunKXSWgO6ahzQ7fJXwtZKP8r+hoTp6FpV5UGl8
 z7W/kbTIbgEXZ7odaY4lNknlIdlImmubaDkO6FHpH/GEWMk+Odz5Gy+BBS/AxBF7VOL1GIH7jVQ
 NODF/f8B4SuBKIJJAeUFb4OdtSZ/oGeURXTMBR+ZPBfsHhLHpaZi6Xf8pDe4WEEZ9F+WCXyb7x8
 dYWdsrwdbvBhtH0Qbam14EEokmfA8NA9ILXyt40mFNgSRg7HU6ej8yeo57BpbhisslI3ZKvlLRJ
X-Received: by 2002:adf:e00f:0:20b0:488:8232:d16e with SMTP id
 ffacd0b85a97d-48e264a9823mr2220894f8f.45.1792580206721; 
 Wed, 21 Oct 2026 03:56:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828ca3sm4719514f8f.25.2026.10.21.03.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 03:56:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E6AE5F828;
 Wed, 21 Oct 2026 11:56:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  qemu-devel@nongnu.org,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] ci: add automatic retry
In-Reply-To: <CAFEAcA8-evgTa4GgvHV7HjUAeqnee1CN3onAK-EBH42saRqNag@mail.gmail.com>
 (Peter Maydell's message of "Wed, 21 Oct 2026 10:20:57 +0100")
References: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
 <ceab474d-ea17-41f8-817c-86f90c0feef0@oss.qualcomm.com>
 <CAFEAcA8-evgTa4GgvHV7HjUAeqnee1CN3onAK-EBH42saRqNag@mail.gmail.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Wed, 21 Oct 2026 11:56:44 +0100
Message-ID: <87fqxz1fv7.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 21 Oct 2026 at 03:41, Brian Cain <brian.cain@oss.qualcomm.com> wr=
ote:
>>
>>
>> On 10/20/2026 6:16 PM, Pierrick Bouvier wrote:
>> > When merging PR on the project, it's possible to observe failures on CI
>> > that can be related to sporadic test failures or infrastructure issues
>> > (pod eviction with Kubernetes). As a result, it adds latency on the
>> > process and workload for our top maintainers.
>> >
>> > This patch sets an automatic retry (supported by gitlab out of the box=
),
>> > so failing jobs are automatically retriggered.
>> >
>> > It's important to note that in case there is a real test or build
>> > failure, concerned jobs will run a second time, and fail again. That
>> > said, it happens seldomly since sub maintainers are supposed to test f=
or
>> > this before sending it. Also, the retry is limited to the job that
>> > failed, so it should be cheap in terms of CI minutes.
>>
>> Will this effectively mask those flaky failures so that no one hears
>> about them?  Is there a way to find out about them with something like a
>> weekly/monthly digest of failures?
>
> Broadly speaking, it's already the case that flaky failures are masked.
> Random infra-type failures / random timeouts /etc are common enough
> that when I'm doing a merge CI run I will just hit the retry button
> without much deep investigation.
>
> In an ideal world we'd pull down the gitlab job history and look
> through it for cases of "job X failed running against commit hash Y,
> but we also saw job X succeed on commit hash Y" (i.e. the retry
> worked second time) and then check the failure logs for what
> kinds of things are intermittent like that. But that requires
> somebody to put in the work to do that analysis. Gitlab's own
> CI job history web UI is very bad and doesn't let you do even
> basic things like "show me just the history for job X".

The gitlab-failure-analysis script was an attempt to start doing this,
so the last 10 failing staging pipelines where:

  $ ./scripts/ci/gitlab-failure-analysis --count 10
  failed pipeline 2949515618, total jobs 120, skipped 5, failed 8,  45059 t=
ests, 1112 skipped tests, 8 failed tests
    Failed job 17194356901, block: [luks], https://gitlab.com/qemu-project/=
qemu/-/jobs/17194356901
    Failed job 17192659533, block: [vmdk], https://gitlab.com/qemu-project/=
qemu/-/jobs/17192659533
    Failed job 17192659440, block: [vhdx], https://gitlab.com/qemu-project/=
qemu/-/jobs/17192659440
    Failed job 17192659398, block: [vdi], https://gitlab.com/qemu-project/q=
emu/-/jobs/17192659398
    Failed job 17192659309, block: [qed], https://gitlab.com/qemu-project/q=
emu/-/jobs/17192659309
    Failed job 17192659287, block: [qcow2], https://gitlab.com/qemu-project=
/qemu/-/jobs/17192659287
    Failed job 17192659245, block: [parallels], https://gitlab.com/qemu-pro=
ject/qemu/-/jobs/17192659245
    Failed job 17192659237, block: [nbd], https://gitlab.com/qemu-project/q=
emu/-/jobs/17192659237
    Failed test qemu.block-nbd-optional+block-thorough - qemu:io-nbd-nbd-st=
ale-connection, block: [nbd], 1 raw nbd-stale-connection
    Failed test qemu.block-parallels-optional+block-thorough - qemu:io-para=
llels-nbd-stale-connection, block: [parallels], 1 parallels nbd-stale-conne=
ction
    Failed test qemu.block-qcow2-optional+block-slow - qemu:io-qcow2-nbd-st=
ale-connection, block: [qcow2], 1 qcow2 nbd-stale-connection
    Failed test qemu.block-qed-optional+block-thorough - qemu:io-qed-nbd-st=
ale-connection, block: [qed], 1 qed nbd-stale-connection
    Failed test qemu.block-vdi-optional+block-thorough - qemu:io-vdi-nbd-st=
ale-connection, block: [vdi], 1 vdi nbd-stale-connection
    Failed test qemu.block-vhdx-optional+block-thorough - qemu:io-vhdx-nbd-=
stale-connection, block: [vhdx], 1 vhdx nbd-stale-connection
    Failed test qemu.block-vmdk-optional+block-thorough - qemu:io-vmdk-nbd-=
stale-connection, block: [vmdk], 1 vmdk nbd-stale-connection
    Failed test qemu.block-luks-optional+block-thorough - qemu:io-luks-nbd-=
stale-connection, block: [luks], 1 luks nbd-stale-connection
  failed pipeline 2945631627, total jobs 120, skipped 5, failed 13,  0 test=
s, 0 skipped tests, 0 failed tests
    Failed job 17162982778, check-python-minreqs, https://gitlab.com/qemu-p=
roject/qemu/-/jobs/17162982778
    Failed job 17162982652, block: [vpc], https://gitlab.com/qemu-project/q=
emu/-/jobs/17162982652
    Failed job 17162982622, block: [vmdk], https://gitlab.com/qemu-project/=
qemu/-/jobs/17162982622
    Failed job 17162982605, block: [vhdx], https://gitlab.com/qemu-project/=
qemu/-/jobs/17162982605
    Failed job 17162982484, block: [vdi], https://gitlab.com/qemu-project/q=
emu/-/jobs/17162982484
    Failed job 17162982417, block: [raw], https://gitlab.com/qemu-project/q=
emu/-/jobs/17162982417
    Failed job 17162982413, block: [qed], https://gitlab.com/qemu-project/q=
emu/-/jobs/17162982413
    Failed job 17162982411, block: [qcow2], https://gitlab.com/qemu-project=
/qemu/-/jobs/17162982411
    Failed job 17162982380, block: [parallels], https://gitlab.com/qemu-pro=
ject/qemu/-/jobs/17162982380
    Failed job 17162982361, block: [nbd], https://gitlab.com/qemu-project/q=
emu/-/jobs/17162982361
    Failed job 17162982339, block: [luks], https://gitlab.com/qemu-project/=
qemu/-/jobs/17162982339
    Failed job 17162261239, check-cfi-x86_64, https://gitlab.com/qemu-proje=
ct/qemu/-/jobs/17162261239
    Failed job 17162261192, ubuntu-24.04-s390x-all-system, https://gitlab.c=
om/qemu-project/qemu/-/jobs/17162261192
  failed pipeline 2929887766, total jobs 120, skipped 7, failed 18,  0 test=
s, 0 skipped tests, 0 failed tests
    Failed job 17055360127, check-python-minreqs, https://gitlab.com/qemu-p=
roject/qemu/-/jobs/17055360127
    Failed job 17055360119, functional-system-opensuse, https://gitlab.com/=
qemu-project/qemu/-/jobs/17055360119
    Failed job 17055360117, functional-system-centos, https://gitlab.com/qe=
mu-project/qemu/-/jobs/17055360117
    Failed job 17055360116, check-system-centos, https://gitlab.com/qemu-pr=
oject/qemu/-/jobs/17055360116
    Failed job 17055360113, block: [vpc], https://gitlab.com/qemu-project/q=
emu/-/jobs/17055360113
    Failed job 17055360112, block: [vmdk], https://gitlab.com/qemu-project/=
qemu/-/jobs/17055360112
    Failed job 17055360111, block: [vhdx], https://gitlab.com/qemu-project/=
qemu/-/jobs/17055360111
    Failed job 17055360110, block: [vdi], https://gitlab.com/qemu-project/q=
emu/-/jobs/17055360110
    Failed job 17055360109, block: [raw], https://gitlab.com/qemu-project/q=
emu/-/jobs/17055360109
    Failed job 17055360108, block: [qed], https://gitlab.com/qemu-project/q=
emu/-/jobs/17055360108
    Failed job 17055360107, block: [qcow2], https://gitlab.com/qemu-project=
/qemu/-/jobs/17055360107
    Failed job 17055360106, block: [parallels], https://gitlab.com/qemu-pro=
ject/qemu/-/jobs/17055360106
    Failed job 17055360105, block: [nbd], https://gitlab.com/qemu-project/q=
emu/-/jobs/17055360105
    Failed job 17055360104, block: [luks], https://gitlab.com/qemu-project/=
qemu/-/jobs/17055360104
    Failed job 17055360078, ubuntu-24.04-s390x-all-system, https://gitlab.c=
om/qemu-project/qemu/-/jobs/17055360078
    Failed job 17055360066, tsan-build, https://gitlab.com/qemu-project/qem=
u/-/jobs/17055360066
    Failed job 17055360065, build-cfi-x86_64, https://gitlab.com/qemu-proje=
ct/qemu/-/jobs/17055360065
    Failed job 17055360061, clang-system, https://gitlab.com/qemu-project/q=
emu/-/jobs/17055360061
  failed pipeline 2908947622, total jobs 119, skipped 5, failed 5,  0 tests=
, 0 skipped tests, 0 failed tests
    Failed job 16911683051, functional-system-debian, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16911683051
    Failed job 16911681150, functional-cfi-x86_64, https://gitlab.com/qemu-=
project/qemu/-/jobs/16911681150
    Failed job 16911679766, functional-system-opensuse, https://gitlab.com/=
qemu-project/qemu/-/jobs/16911679766
    Failed job 16911678710, functional-system-centos, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16911678710
    Failed job 16911433872, ubuntu-24.04-s390x-all-system, https://gitlab.c=
om/qemu-project/qemu/-/jobs/16911433872
  failed pipeline 2906503036, total jobs 119, skipped 5, failed 4,  0 tests=
, 0 skipped tests, 0 failed tests
    Failed job 16896095104, functional-system-centos, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16896095104
    Failed job 16896090260, functional-system-opensuse, https://gitlab.com/=
qemu-project/qemu/-/jobs/16896090260
    Failed job 16896083592, functional-cfi-x86_64, https://gitlab.com/qemu-=
project/qemu/-/jobs/16896083592
    Failed job 16895432496, functional-system-debian, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16895432496
  failed pipeline 2876539219, total jobs 119, skipped 5, failed 6,  0 tests=
, 0 skipped tests, 0 failed tests
    Failed job 16692899473, functional-system-fedora, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16692899473
    Failed job 16692899464, aarch64-macos-26-build, https://gitlab.com/qemu=
-project/qemu/-/jobs/16692899464
    Failed job 16692899463, aarch64-macos-15-build, https://gitlab.com/qemu=
-project/qemu/-/jobs/16692899463
    Failed job 16692899432, clang-system, https://gitlab.com/qemu-project/q=
emu/-/jobs/16692899432
    Failed job 16692899429, build-some-softmmu, https://gitlab.com/qemu-pro=
ject/qemu/-/jobs/16692899429
    Failed job 16692899413, cross-win64-system, https://gitlab.com/qemu-pro=
ject/qemu/-/jobs/16692899413
  failed pipeline 2840522620, total jobs 119, skipped 5, failed 7,  0 tests=
, 0 skipped tests, 0 failed tests
    Failed job 16454091776, functional-system-opensuse, https://gitlab.com/=
qemu-project/qemu/-/jobs/16454091776
    Failed job 16454091774, functional-cfi-x86_64, https://gitlab.com/qemu-=
project/qemu/-/jobs/16454091774
    Failed job 16454091761, check-cfi-x86_64, https://gitlab.com/qemu-proje=
ct/qemu/-/jobs/16454091761
    Failed job 16454091760, check-system-opensuse, https://gitlab.com/qemu-=
project/qemu/-/jobs/16454091760
    Failed job 16454091758, functional-system-centos, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16454091758
    Failed job 16454091740, check-system-centos, https://gitlab.com/qemu-pr=
oject/qemu/-/jobs/16454091740
    Failed job 16454091730, ubuntu-24.04-s390x-all-system, https://gitlab.c=
om/qemu-project/qemu/-/jobs/16454091730
  failed pipeline 2839257817, total jobs 119, skipped 5, failed 2,  0 tests=
, 0 skipped tests, 0 failed tests
    Failed job 16436167533, ubuntu-24.04-s390x-all-system, https://gitlab.c=
om/qemu-project/qemu/-/jobs/16436167533
    Failed job 16436167532, ubuntu-24.04-s390x-all-linux, https://gitlab.co=
m/qemu-project/qemu/-/jobs/16436167532
  failed pipeline 2830538304, total jobs 119, skipped 5, failed 3,  0 tests=
, 0 skipped tests, 0 failed tests
    Failed job 16377263801, check-rust-tools-nightly, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16377263801
    Failed job 16377263686, ubuntu-24.04-s390x-all-system, https://gitlab.c=
om/qemu-project/qemu/-/jobs/16377263686
    Failed job 16377263684, ubuntu-24.04-s390x-all-linux, https://gitlab.co=
m/qemu-project/qemu/-/jobs/16377263684
  failed pipeline 2820341086, total jobs 119, skipped 5, failed 2,  0 tests=
, 0 skipped tests, 0 failed tests
    Failed job 16307778927, check-rust-tools-nightly, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16307778927
    Failed job 16307778897, functional-system-debian, https://gitlab.com/qe=
mu-project/qemu/-/jobs/16307778897

It has rudimentary access to the tests but I think the deep dive would
require better retention of the job artefacts. The second pipeline in
the above list lists the "job artefacts" as removed 3hrs ago which is I
guess why we don't get the test breakdown for the earlier jobs.

Anyway perhaps we can expand this to be more useful?

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

