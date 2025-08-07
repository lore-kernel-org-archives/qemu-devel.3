Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58773C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 06:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujuGo-0004Kh-Bm; Thu, 07 Aug 2025 02:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ujuGa-00048a-3n
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:38:24 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ujuGX-0004iB-La
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:38:19 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C77EF3F674
 for <qemu-devel@nongnu.org>; Thu,  7 Aug 2025 06:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754548694;
 bh=M4pYwtZ55GK+4yd3r1Pe6fHiYh1YmdIqVBrIK6Z31JI=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=tSsDzxi9/OVb73KWTBh7kvG6dlwLS666wajBPBChjTO9avL0UNy9AqdMKR0wZlp/K
 rH5JIEjZ8g3F1me/6o1Se2VcylA7387vgs6nxchLS7viDBmUFhx9t4WQ9dTomYIm1E
 ijaoPSf54vtaVOz8gXgSDpKIiA/ghrEWqr2KAmBOAld4LykIJED++isoxOhlFqE+oI
 UXIzgAd1IBCWvcwnYiV+aAYDJFUEWVptlLd9FmwF28w+ef/jiCQxNVcROVVfOqXaTg
 U+c1s3keoxdi+JR79jjgciklp0sbnjB4VYKB8/X1m0o4kyeZH3Hpdr5Xw9ubani1fy
 rU50sFnXBP5xw==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6154cf8c32cso559652a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 23:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754548694; x=1755153494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4pYwtZ55GK+4yd3r1Pe6fHiYh1YmdIqVBrIK6Z31JI=;
 b=mteT+uZhAOoZxCEWs8tDz2SmUvtEsqrDH3y4lNHU1rMuLlI6x92gixb4JpePngikOV
 vgzD7j3/22v95VhgiIYr0qseyM4r0HmAs87H391swQCya2JVU8BHcoIEBnSI4MmixWvq
 r+2JkeBDXjK5sFUUa3PR267JTdcn3iF1hLsKvKqMkvptKkGtcfrdHxXVzaZ2NeKQoxm9
 vrwrcr48xXOiG//PK/mSNM3yOZPdliqNPF1Rk1ZOOKHqmXNxz065SWngOgjhJByzS0QL
 sK+tAMMoGx18DXpzf3ib8xlHreQarIvnOV4jsy2XnulaErr4WvXVHvp5dzBOBJ2ZeswT
 qHMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPtStE1w6Gol6EDaMwBtv32xc5yYk0VWswyGJdHXLaXbnEYxkrLOixYTh3eZxDQ63awetKzxqOR70y@nongnu.org
X-Gm-Message-State: AOJu0YxSq7ZYN+NOdm67m/eyx6tntoeiN1Afz0gvVJQHo+O74CRbTOLK
 4Kl6Dxdp4S0/DZ6eNOK5SbmMDp6IIpPgNN2EeC4XizOb7uyMj+ft11EECw2cW02F/dE+9bJuUOZ
 ScfEJ8jhlzJKQk8jDw8Hx5eutO4wuPQeq7ipnUspDpAB1jdWzHA7pCi4qH426u5ECpXXvpm2nNx
 YxI2Q+SSlNQnpsKpryBht4VAdL7jJJIRXIlMGFAyf8lOQ2qN4=
X-Gm-Gg: ASbGncvaGGVZyg9dvO4LVN3ZyXSDxJxiEu1iXxLC9s67W7V/bdvnFu/oeO3YKjRrp4A
 QPEqsWLWTFV1H68C+FeE8Y+bEni8pYFVVddy/HaqbZkZf+9k/L2ot65LH9r8uQDEDH8Y3EAs24n
 3TZrdiHFOAjp8ZQych/tO6
X-Received: by 2002:a05:6402:42d0:b0:615:4ce4:3228 with SMTP id
 4fb4d7f45d1cf-61796096273mr5150775a12.4.1754548694253; 
 Wed, 06 Aug 2025 23:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0cMG45LqTO0NDN8EpkEjwQYd+1h8ilc3LAUn/Q1XVsPAFxa4xQSd2klXZ7VG3X+AlH5nabU1XyNzczkG8HyM=
X-Received: by 2002:a05:6402:42d0:b0:615:4ce4:3228 with SMTP id
 4fb4d7f45d1cf-61796096273mr5150749a12.4.1754548693704; Wed, 06 Aug 2025
 23:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com> <2dbe2da9-895a-45ca-9f41-7ec273e0bb80@intel.com>
In-Reply-To: <2dbe2da9-895a-45ca-9f41-7ec273e0bb80@intel.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 7 Aug 2025 08:37:47 +0200
X-Gm-Features: Ac12FXyNQ614dd7RPyxWtxLvc1lQKL3BorOZoiLiu3UNirzgzhAbbxLuPc2c01g
Message-ID: <CAATJJ0Jpn8VMRDOFuk7VaV5jC3tj0V1817OiRa6tH3x1OtYFSQ@mail.gmail.com>
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 7, 2025 at 5:38=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> wr=
ote:
>
> On 8/7/2025 3:18 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
> >> On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> >>>
> >>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
> >>>> Hi,
> >>>> I was unsure if this would be better sent to libvirt or qemu - the
> >>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
> >>>> behaving differently. I did not want to double post and gladly most =
of
> >>>> the people are on both lists - since the switch in/out of the proble=
m
> >>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not y=
et
> >>>> having all the answers, I'm sure I could find more with debugging, b=
ut
> >>>> I also wanted to report early for your awareness while we are still =
in
> >>>> the RC phase.
> >>>>
> >>>>
> >>>> # Problem
> >>>>
> >>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc1 wa=
s:
> >>>>    error: operation failed: guest CPU doesn't match specification:
> >>>> missing features: pdcm
> >>>>
> >>>> This is behaving the same with libvirt 11.4 or the more recent 11.6.
> >>>> But switching back to qemu 10.0 confirmed that this behavior is new
> >>>> with qemu 10.1-rc.
> >>>
> >>>
> >>>> Without yet having any hard evidence against them I found a few pdcm
> >>>> related commits between 10.0 and 10.1-rc1:
> >>>>    7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> >>>>    00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not availabl=
e
> >>>>    e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> >>>> feature_dependencies[] check
> >>>>    0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> >>>>
> >>>>
> >>>> # Caveat
> >>>>
> >>>> My test environment is in LXD system containers, that gives me issue=
s
> >>>> in the power management detection
> >>>>    libvirtd[406]: error from service: GDBus.Error:System.Error.EROFS=
:
> >>>> Read-only file system
> >>>>    libvirtd[406]: Failed to get host power management capabilities
> >>>
> >>> That's harmless.
> >>
> >> Yeah, it always was for me - thanks for confirming.
> >>
> >>>> And the resulting host-model on a  rather old test server will there=
fore have:
> >>>>    <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
> >>>>      <model fallback=3D'forbid'>Haswell-noTSX-IBRS</model>
> >>>>      <vendor>Intel</vendor>
> >>>>      <feature policy=3D'require' name=3D'vmx'/>
> >>>>      <feature policy=3D'disable' name=3D'pdcm'/>
> >>>>       ...
> >>>>
> >>>> But that was fine in the past, and the behavior started to break
> >>>> save/restore or migrations just now with the new qemu 10.1-rc.
> >>>>
> >>>> # Next steps
> >>>>
> >>>> I'm soon overwhelmed by meetings for the rest of the day, but would =
be
> >>>> curious if one has a suggestion about what to look at next for
> >>>> debugging or a theory about what might go wrong. If nothing else com=
es
> >>>> up I'll try to set up a bisect run tomorrow.
> >>>
> >>> Yeah, git bisect is what I'd start with.
> >>
> >> Bisect complete, identified this commit
> >>
> >> commit 00268e00027459abede448662f8794d78eb4b0a4
> >> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Date:   Tue Mar 4 00:24:50 2025 -0500
> >>
> >>      i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> >>
> >>      When user requests PDCM explicitly via "+pdcm" without PMU enable=
d, emit
> >>      a warning to inform the user.
> >>
> >>      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>      Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >>      Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.l=
i@intel.com
> >>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>
> >>   target/i386/cpu.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >>
> >>
> >> Which is odd as it should only add a warning right?
> >
> > No, that commit message is misleading.
> >
> > IIUC mark_unavailable_features() actively blocks usage of the feature,
> > so it is a functional change, not merely a emitting warning.
> >
> > It makes me wonder if that commit was actually intended to block the
> > feature or not, vs merely warning ?  CC'ing those involved in the
> > commit.
>
> The intention was to print a warning to tell users PDCM cannot be
> enabled if pmu is not enabled. While mark_unavailable_features() does
> has the effect of setting the bit in cpu->filtered_features[].
>
> But the feature is masked off anyway

Right - it was disabled right from the beginning.
As I reported libvirt detected it as not available and constructed the
CPU as with it disabled.
Which translated it into -cpu ...,pdcm=3Doff,...

The new and bad aspect we need to overcome is that in these conditions
this now somehow breaks save/restore and migration operations.

As a cross-check I reverted just and only 00268e0002 on top of
10.1-rc2 and these use cases work again.

> even without the
> mark_unavailable_features():
>
>      env->features[FEAT_1_ECX] &=3D ~CPUID_EXT_PDCM;
>
> So is it that PDCM is set in cpu->filtered_features[] causing the problem=
?
>
> > With regards,
> > Daniel
>


--=20
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

