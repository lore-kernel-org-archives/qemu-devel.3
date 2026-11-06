Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87AE606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kdt/9lfp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP9Qs-0002AS-Pc; Thu, 05 Nov 2026 21:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP9Qd-00029l-Bi
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:11:44 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP9QZ-0003pf-Rv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:11:42 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b5669a5100so147014a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 18:11:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793931098; cv=none;
 d=google.com; s=arc-20260327;
 b=fALSfYOONwlhz5tAjlzelRlzUScqVMkr5r06aWBFopxJ06x3/xqki6OOcRva1+1Bkr
 E8lBhHt9JIWItCtjr8Qe6xjjiz0jpZXJRXzQVv3vK6RHGKXMjxeJPHydWdUlhSbJ1w6T
 REU94Og2s9odMdKBudqZwbS+JeoIYxnUuFh9xNpQQruUHgzlO0u3P2l3NeXK/UNSvhF0
 DM3z2U3bTipnhck7y5bhjBVaSW5kvuSi4zoc/5oKQF7TCK770ts+yLcdj1pBoW3oeKsD
 IA+9VGtKF9b1udNQ1BJ5nmORvA37bey0JWYUhEAe2kHEfox1Pjhl4YmE11bWCCfRke+M
 r7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=cf50maBua9+IyQK3Q7mR5sgG4hXOZf0u7EIQD9rVXQY=;
 fh=whduUG8/6CYISlEVdqw4rnakkUWmjK+7561i5R62nME=;
 b=M3WmDgQP5L6nhK4LHn9jRRrZk7KscubCJYedMoi6MQVy5PS7BK/kLUXAr1/WeXKpcq
 lRUEz+ma6GhLZJG66rMS7a6Wf4I1FfQr2WSYug7v+PZkHnX2KSTHI19TNyLd5+viREZb
 oGpLr97K9VrTIuF21e4FJPf1pd8UZ0cTrZJd4pmwVUHo937f33Fm2hQL86n9pjGmr2e3
 0KxEW1RgM+F6vqyJGp3V2Lfm8Az/+t8xqR+RFFuW9erthkqvVANM2yOdWrn8vUmPSaBH
 PKHujtVsHHtOapPAksZ9QIHyv1ofHxaYGBhovlhukV68NsTVJWWBrS57LHM+6l/GLqSy
 U60Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793931098; x=1794535898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cf50maBua9+IyQK3Q7mR5sgG4hXOZf0u7EIQD9rVXQY=;
 b=Kdt/9lfpuqtTRpEb8madZYGY23b050xLMGqq+bdN6ZcItK7CaUmH9YgjGzRm9MGzSI
 vOdVIxYWemlIiLffHrTo+NhFphHAydWYaHQ6GulbSPWxwl4ti188o/iQutIAopwAxQeS
 abycXZOeDLdgz0XH14yVxTZXzR1+f+PmFK8R4FTyxEm6nEHglY8VMZN2uS8WUiTRPj8r
 NIjSOJGf34b6M1dEOLc7GDthnMz/bTkWZkwNupPJlUXg/EUhM3WGm2GvMsg/ayxn503d
 Ym4xkjti/ZX7CXhMtkrds8CRiWEUH9yX7pxtSD1JYjoObTqTjsJiaTNDOmhZKoBwuj7/
 OEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793931098; x=1794535898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cf50maBua9+IyQK3Q7mR5sgG4hXOZf0u7EIQD9rVXQY=;
 b=J6SE0K6Jvr1wCuw1fybHvLBNmShNvpp5AuBL8of42atm+LsvjdzN6aL4LXDZp/mDhN
 /3/KiwDyy+6vYw9k0vNmMLi4QSIT0fAz64/Q5cR9ZOUl3CC3T49fhEw0bmdnyilZpj/G
 7LsA2MS3YHx2bsvYsDKywN51vCWAGNdsKYB4uxbwa/ZdcL6LD203hOM43Gcfp9hJ+EE/
 Uxf1q2Qnznmau4CSUGPyZtok4L36jljIBFh1U+XsV4Z6or3xMG3C7Tv1D5UYunYPc0jv
 cvFKRwuN5PTw9ga1qEoCcWKfg/LMdmshPM3+yfwjaDLKZmwReyqJ8dRfPL+GWE/POu5B
 f2Wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiy/X4kHGhOYYPo5+xQY3X99rbUuPe2c4V44TFw73GrdIIB8HZfPo5CnIgUPsOJLMcaOkPWr0cbpIJ@nongnu.org
X-Gm-Message-State: APuU4Z8iRWX8t++NM5/o3ZUURqsd+jvrTxXx0AwC5PzuSNVbg2HlfxbF
 Zw/p9t3/iK+j5J4IhnKFm3R2/nuDYeQeeomxRJOOrCFlDl6fdsoD85CmksFQ5+cDUc0XCUwbwsI
 gBWbz5ND6gmKi15Llm7seteZy6bTnyvY=
X-Gm-Gg: AYBFou03f03V81EufP33ecwf32vyDb2tkPe1NzifauUNLWOxL3HtKhVcqEo6LFPLdmf
 j6ruiBMCvnlMAGFpAlF4YKVITTR0RYMwk4RO0IQ1s4qRolM2NRK73rZYnSRcOuOWoK0pvdq6+Yt
 hWOQ2yXL9pSds5lQOJkqkhPxUfTGkOC7moezVrDas34460jH1jVgag1TTGhW04hw6Ht1vGK5fY4
 glB57fjd+098wfD6z4NlYR3/7ul8BiHHGs6VQVbuIuOdH5iuhXZgIfX7bOhDCTRng0DWbFQ3DNh
 BJpNibSNUslQbg0M7lurMqumjC1HkTVZJW7Yqm2H5W7n/9o9SPQXfb//NgbTYGH3N/2kJCosk2m
 0/7ErQ68amd8KsBo5RFxftwIiyCI8cv4FiYjt
X-Received: by 2002:a05:6402:43cf:b0:6ac:c1fc:8a98 with SMTP id
 4fb4d7f45d1cf-6b597a3edeemr642658a12.42.1793931097487; Thu, 05 Nov 2026
 18:11:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103133500.2295582-1-pbonzini@redhat.com>
 <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
 <5de7e4a0-70dc-4a0a-936d-d66b1eefcc09@oss.qualcomm.com>
 <CAE2XoE-o_K=npvHPPb+pxeS=hFwEYJh-PYEVGrcbeF4nAW+ULg@mail.gmail.com>
 <3829e1be-09a6-4582-a506-21c6625f5cbd@oss.qualcomm.com>
In-Reply-To: <3829e1be-09a6-4582-a506-21c6625f5cbd@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 6 Nov 2026 10:11:24 +0800
X-Gm-Features: AclHuK9lLVJx2D3F92S7XQfLrW9yujIHQdh4V_jog3zMkbi5ItUDS0HWyC_OAck
Message-ID: <CAE2XoE-2A1An5yeHZrvjgZZYb4uSsL+Eq4LFRCrTZRODTW7Ejg@mail.gmail.com>
Subject: Re: [PULL v2 00/10] i386, AGENTS.md,
 meson changes for QEMU 11.2 soft freeze
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52a.google.com
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 4:12=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/5/2026 11:57 AM, Yonggang Luo wrote:
> > On Fri, Nov 6, 2026 at 3:53=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 11/5/2026 2:27 AM, Peter Maydell wrote:
> >>> On Tue, 3 Nov 2026 at 13:35, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
> >>>>
> >>>> The following changes since commit 74f7bf4c59e6b6d50dbc6e124d93440be=
8be4386:
> >>>>
> >>>>   Merge tag 'pull-target-arm-20261102-1' of https://gitlab.com/pm215=
/qemu into staging (2026-11-02 20:19:27 -0800)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >>>>
> >>>> for you to fetch changes up to ab78ac76f44a1241e76fd32d248df62d83f1e=
a58:
> >>>>
> >>>>   meson: rewrite scripts/qemu-version.sh directly in meson.build (20=
26-11-03 14:31:24 +0100)
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> * target/i386/tcg: bugfixes and cleanups
> >>>> * AGENTS.md: add final instructions
> >>>> * meson: rewrite scripts/qemu-version.sh directly in meson.build
> >>>>
> >>>> ----------------------------------------------------------------
> >>>
> >>> The qemu-version.h changes here seem to have broken incremental build=
s:
> >>>
> >>> In file included from ../../monitor/qmp-cmds-control.c:28:
> >>> /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> >>> qemu-version.h: No such file or directory
> >>>    11 | #include "qemu-version.h"
> >>>       |          ^~~~~~~~~~~~~~~~
> >>> compilation terminated.
> >>>
> >>> This happens even though the incremental rebuild decided it had
> >>> to re-run configure.
> >>>
> >>> Blowing away the build tree and doing a complete rebuild avoids the
> >>> error, but it would be nice for incremental builds to work.
> >>>
> >>
> >> It works fine on my side, with both ninja and make. qemu-version.h is
> >> correctly regenerated as the first target being executed.
> >>
> >> Can you reproduce this with a clean build folder?
> >
> > Hi, it's for incremental builds, that is a build (exists) before these =
patches,
> > then reset hard to the version after this PR, then ninja will fail.
> > Clean build folder won't trigger issue. but for fast bisect, issues wil=
l happen.
> >
>
> I see, unfortunately there are multiple occurrences of such subtle
> breaking when moving between commits in our history already. Especially
> for current issue, it's now pushed and there, so we can't do anything to
> avoid bisect hitting this eventually.
>
> One nice and bulletproof solution is to rely on ccache, and allow
> ourselves to delete a build folder (a full ccache rebuild is less than
> 20 sec on my machine).

Yeah, I also leverage ccache, so maybe this is not an issue at all.
for git bisect,
git always present. that won't affect, I think.

>
> >
> >>
> >>> thanks
> >>> -- PMM
> >>>
> >>
> >>
> >
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

