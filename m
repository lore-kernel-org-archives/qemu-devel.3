Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C696CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utj18-000782-6b; Wed, 03 Sep 2025 04:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1utj16-00077c-5w
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:38:56 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1utj13-0007NR-L0
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:38:55 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 460773F46B
 for <qemu-devel@nongnu.org>; Wed,  3 Sep 2025 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756888730;
 bh=RMgNKE2Ti7LH5wDEOvr/q2CopCD0HzNlWDo5eRVFx/8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=VJv+UUCzREGM7awYKxFYG5a2WdKboRPAWQaRRIpqT/Mw8Elb8avC6Z8Dao6gy7OkQ
 2rPuM4cv28hGLxBkjdrtOcq/ApBWimbUpXkcW7HWkuSg16W9DIwNCJAjQDTB4JIE1z
 mb37bixrkESTaNBotfmx0FHUikEjPV6aexH8LzvCRco9e2b9xuePcv7L2phjc6RgWp
 HOxBSyZ7hu9JbelIQZvLq06rWWcyeRPPN8KlrtjsPiKuVAEFKAULuI1NM4YGAZuThw
 /jQoZdB3lzgyRx5LlPlrHcTO7OnQVqOIZj32+k7Fx6tLbGczwlINxOjnd6IG4ZzPbd
 +3plNePybDhdg==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b044033b983so68125866b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 01:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756888730; x=1757493530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMgNKE2Ti7LH5wDEOvr/q2CopCD0HzNlWDo5eRVFx/8=;
 b=Jbjgozu8nBQEtZQU+B1tCsjvrd9PoA03vUeedqRmsxzZitKbKSeawaof9RjUX4yrf7
 OLwCEBLPjy95BUCLUZdXb/D6v/6yttg5rS17dkZMJ0BXAc0RFM6O6DTMTGFIFZhKSP1z
 saz7F2BuzJsGLuRhrquych7fIUia65s3LCt0c2wl5fLGdJx9VPEkxozEFUyVd/hFkiig
 D1QV3dylShobRSGbatV3kz6CJuTDx4KjZhr2Yujydi7NpCMuIj2JleTxMd8s+CTBfGoi
 wjqr/AgdwQ/bMXpvVly8lKDSOBZqMvH/4VDBGbns7APnFucNPYNpJzobrfEphbcxBxwE
 A+fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbytOEZHChDYCDtZWH+6SSlX4HN+1JtzaQUaZZNotMSl0IPxQjEx13u1Ik+7LwGMA3iUOqfbbTxabd@nongnu.org
X-Gm-Message-State: AOJu0YzMiKRWSyk1ft9MNQ6qbYxH2sO1yBahH/a7tlsjUJCqSa8E72uC
 +e+S0l0dKv67oRopqY3DJMiPiv+9WYWb5TyaTaFbRBRbMl7kD5TUJdh2B/9pobokclK5B+cBzyn
 F9AXxra/NNTAWrMlqABbItEAKeT1TISAht0YWtFH5WCAEVezoqsfBFqfckmv3UaZIf1yS8UfKI+
 6ytF4zdK6CyzwJst6o2WIBGphDd9l6VmNLKpO1SEnA49ETLiA=
X-Gm-Gg: ASbGncsUqU+7FWqPX3rfud7nLWaEE4jq2K+K41lIDPAP2KWIInupcFI1kqQPeWcBr1B
 f+z9xd2EZMzRlzeaB4kh1VYI950euVbUxS4oy8TF646eOAjWb5BypqZ3Uwhy/XVmex2H3t4HBf1
 qvxBlB6yYIsFj24Wx0ngA=
X-Received: by 2002:a17:907:3f92:b0:b04:6c7a:dd0a with SMTP id
 a640c23a62f3a-b046c7adfd4mr103335166b.8.1756888729500; 
 Wed, 03 Sep 2025 01:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6o75AmbgZ9KhktV2XVBhZBSQEaJL8ReggFS6J1j0UeTR/gTRrCZ0V9Ira4r+J+60gZE/Wz18tWIS1JnINh/k=
X-Received: by 2002:a17:907:3f92:b0:b04:6c7a:dd0a with SMTP id
 a640c23a62f3a-b046c7adfd4mr103333366b.8.1756888728974; Wed, 03 Sep 2025
 01:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com>
 <ccabd72c-6f48-4be2-8bbd-44f28eb2cfd1@redhat.com>
 <CAATJJ0KZDHqMHmpmfFySJjreqPMTHDiJLJM_zBdcr5CrzOL2tg@mail.gmail.com>
In-Reply-To: <CAATJJ0KZDHqMHmpmfFySJjreqPMTHDiJLJM_zBdcr5CrzOL2tg@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 3 Sep 2025 10:38:22 +0200
X-Gm-Features: Ac12FXzMXOaWHnKfTE-jwBNlrduwwfvnaZCbOuXfM1i6bgFliIMtkcfyBLFq9Ic
Message-ID: <CAATJJ0Kz7Sdv-Dq0r0pGBXYgZbTbaC0fSQiVXoQides4pF=zXg@mail.gmail.com>
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: Paolo Bonzini <pbonzini@redhat.com>, Hector Cao <hector.cao@canonical.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
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

On Wed, Aug 20, 2025 at 7:11=E2=80=AFAM Christian Ehrhardt
<christian.ehrhardt@canonical.com> wrote:
>
> On Tue, Aug 19, 2025 at 4:51=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On 8/6/25 21:18, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
> > >> On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berr=
ange@redhat.com> wrote:
> > >>>
> > >>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
> > >>>> Hi,
> > >>>> I was unsure if this would be better sent to libvirt or qemu - the
> > >>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
> > >>>> behaving differently. I did not want to double post and gladly mos=
t of
> > >>>> the people are on both lists - since the switch in/out of the prob=
lem
> > >>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not=
 yet
> > >>>> having all the answers, I'm sure I could find more with debugging,=
 but
> > >>>> I also wanted to report early for your awareness while we are stil=
l in
> > >>>> the RC phase.
> > >>>>
> > >>>>
> > >>>> # Problem
> > >>>>
> > >>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc1 =
was:
> > >>>>    error: operation failed: guest CPU doesn't match specification:
> > >>>> missing features: pdcm
> > >>>>
> > >>>> This is behaving the same with libvirt 11.4 or the more recent 11.=
6.
> > >>>> But switching back to qemu 10.0 confirmed that this behavior is ne=
w
> > >>>> with qemu 10.1-rc.
> > >>>
> > >>>
> > >>>> Without yet having any hard evidence against them I found a few pd=
cm
> > >>>> related commits between 10.0 and 10.1-rc1:
> > >>>>    7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> > >>>>    00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not availa=
ble
> > >>>>    e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> > >>>> feature_dependencies[] check
> > >>>>    0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> > >>>>
> > >>>>
> > >>>> # Caveat
> > >>>>
> > >>>> My test environment is in LXD system containers, that gives me iss=
ues
> > >>>> in the power management detection
> > >>>>    libvirtd[406]: error from service: GDBus.Error:System.Error.ERO=
FS:
> > >>>> Read-only file system
> > >>>>    libvirtd[406]: Failed to get host power management capabilities
> > >>>
> > >>> That's harmless.
> > >>
> > >> Yeah, it always was for me - thanks for confirming.
> > >>
> > >>>> And the resulting host-model on a  rather old test server will the=
refore have:
> > >>>>    <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
> > >>>>      <model fallback=3D'forbid'>Haswell-noTSX-IBRS</model>
> > >>>>      <vendor>Intel</vendor>
> > >>>>      <feature policy=3D'require' name=3D'vmx'/>
> > >>>>      <feature policy=3D'disable' name=3D'pdcm'/>
> > >>>>       ...
> > >>>>
> > >>>> But that was fine in the past, and the behavior started to break
> > >>>> save/restore or migrations just now with the new qemu 10.1-rc.
> > >>>>
> > >>>> # Next steps
> > >>>>
> > >>>> I'm soon overwhelmed by meetings for the rest of the day, but woul=
d be
> > >>>> curious if one has a suggestion about what to look at next for
> > >>>> debugging or a theory about what might go wrong. If nothing else c=
omes
> > >>>> up I'll try to set up a bisect run tomorrow.
> > >>>
> > >>> Yeah, git bisect is what I'd start with.
> > >>
> > >> Bisect complete, identified this commit
> > >>
> > >> commit 00268e00027459abede448662f8794d78eb4b0a4
> > >> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> > >> Date:   Tue Mar 4 00:24:50 2025 -0500
> > >>
> > >>      i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> > >>
> > >>      When user requests PDCM explicitly via "+pdcm" without PMU enab=
led, emit
> > >>      a warning to inform the user.
> > >>
> > >>      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > >>      Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > >>      Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao=
.li@intel.com
> > >>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >>
> > >>   target/i386/cpu.c | 3 +++
> > >>   1 file changed, 3 insertions(+)
> > >>
> > >>
> > >>
> > >> Which is odd as it should only add a warning right?
> > >
> > > No, that commit message is misleading.
> > >
> > > IIUC mark_unavailable_features() actively blocks usage of the feature=
,
> > > so it is a functional change, not merely a emitting warning.
> > >
> > > It makes me wonder if that commit was actually intended to block the
> > > feature or not, vs merely warning ?  CC'ing those involved in the
> > > commit.
> > We can revert the commit.  I'll send the revert to Stefan and let him
> > decide whether to include it in 10.1-rc4 or delay to 10.2 and 10.1.1.
>
> Thanks Paolo for considering that.
>
> My steps to reproduce seemed really clear and are 100% reproducible
> for me, but no one so far said "yeah they see it too", so I'm getting
> unsure if it was not tried by anyone else or if there is more to it
> than we yet know.
> Further I tested more with the commit reverted, and found that at
> least cross version migrations (9.2 -> 10.1) still have issues that
> seem related - complaining about pdcm as missing feature.
> But that was in a log of a test system that went away and ... you know
> how these things can sometimes be, that new result is not yet very
> reliable.
>
> I intended to check the following matrix more deeply again with and
> without the reverted change and then come back to this thread:
>
> #1 Compare platforms
> - Migrating between non containerized hosts to verify if they are
> affected as well
> - Power management explicitly switched off/on (vs the auto detect of
> host-model) in the guest XML
> #2 Retest the different Use-cases I've seen this pop up
> - 10.1 managed save (broken unless reverting the commit that was identifi=
ed)
> - 9.2 -> 10.1 migration (seems broken even with the revert)

I need to come back to this aspect of it - the cross release or cross
qemu version migrations.

Hector (on CC) helps me on that now - sadly we were able to confirm
that migrations from older qemu versions no longer work.
Yep 10.1 is released by now so it might end up as "The problem is what
happens when we detect after we have done a release that something has
gone wrong" from [2].
But I still can't believe only we see this and therefore for now want
to believe I messed up on our side when merging 10.1 :-)

For now this is a call if others have also seen any older release
migrating to 10.1 to throw:
  error: operation failed: guest CPU doesn't match specification:
missing features: pdcm,arch-capabilities

Hector will later today reply here with a summary of what we found so
far, to provide you a more complete picture to think about, without
having to read through all the messy interim steps in the Ubuntu bug.

[1]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2121787
[2]: https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/migratio=
n/compatibility.rst?plain=3D1#L322

> The hope was that these will help to further identify what is going
> on, but despite the urgency of the release being imminent I have not
> yet managed to find the time in the last two days :-/
>
> > Sorry for the delay in answering (and thanks Daniel for bringing this t=
o
> > my attention).
> >
> > Thanks,
> >
> > Paolo
> >
>
>
> --
> Christian Ehrhardt
> Director of Engineering, Ubuntu Server
> Canonical Ltd



--=20
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

