Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD8606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4mQHGjO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8yZ-0007zx-2w; Wed, 28 Oct 2026 15:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM8yS-0007zM-2x
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:06:14 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM8yQ-0004HY-Ak
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:06:11 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-676804a3a22so1427567d50.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793214369; cv=none;
 d=google.com; s=arc-20260327;
 b=Ylf91S+4l3T+fnoPnGrPLTbFFU5OsxrWV1gBzy4dOdN9xxyih3jD/xHWXRqL9WG5yP
 txkOsJdIB2QQrleiBz0AzEPXb/V55v2FFyOdkBhCtA7E+cs0YRRiZJm5s2uk2A7yf5TG
 ITprRVKuOWURGgzAbP22bA/zraZW5MZSo7BMyNW0byqMwmaqTYxg34XDfipAs9ACawGQ
 k2gJBbmV4j1sXikfgUUGwtuIWInE0SotNFeQ9WSnW04XbdG6l5NPT/xcF1vmw58BgfG/
 j4Zz0O7jCX+qjhd9mM+2xmK7iJ8jqmHvkoZyUiCLE5BvDb1yd4tNi8OgVFdTMrfLsNyC
 rCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=sGbSByCOv8vzewZJnjCOsQPqvStPFP/5eiT5dlY6cQ4=;
 fh=46U1FE5Qw0fo7evi6utX9h5HLfzSsvyXi+QDnZDegHo=;
 b=ri2uixNKndHqRWHmviHWUOB7ZF//Xm2buixkrH8b56awL2jAbVecqfblAfmRVmeYLN
 JNRWrcBD5cC4T5UoPxAj/3T6m1fUKR4gO7NO19U2WtZZpis8k0jd8Jzik0wvEoeQhw6s
 8LkmrsVW734CSZwF+4d9q8OHzdt0dVPr7EjcRDVPbrkW1NaLfdOIinC1heZoiHQ1vp/i
 wY8lo4HZxVkxZSAmNLk/oTf8uVgPu2pPpH2bmbusbfaBnOYEkln/+gCwy030bvRr04LT
 RyBs10ah3a/LAMDm33ulmLkWcmaG/G/4+9Z8A0+mFroo2S7nE6lJSCgwx3swTueVBsnG
 CFZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793214369; x=1793819169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sGbSByCOv8vzewZJnjCOsQPqvStPFP/5eiT5dlY6cQ4=;
 b=r4mQHGjOlnuKyztXXFFoyf1KZ1HyUOHge6+ec/0hUdXpW1inM3PCRA6oW/Od41zotM
 QYGdBVrEtcO/E0Hc2Z3TpHNaPO3OUxOp/MRsnUk2PRLk9DBsvZ4N2bO13BHvVx+h207/
 +adoW1kT5+n5anXWCYEhrYh+1ZSYEXLMlkigCCNa6IOUrSaElwtVSKGSOfdEWcxEXA0q
 G4Jo/ytWZMsbMcBfbUvXR/AU+frzRn2eeoi98TokloeSvWkuZRVRVnV5NXIynYyEgM/Z
 7b1f9tMx0jE0UjUN0hdS3e3nDU2BtVvn/WKcIWDaejB2QC8Jz1xWWyrQPMI73wd4MJwJ
 /W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793214369; x=1793819169;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sGbSByCOv8vzewZJnjCOsQPqvStPFP/5eiT5dlY6cQ4=;
 b=b/PZacaLhEoFzjH+DuvasOxlW1nBlbuZzYobEFWXlCWXztTbbIeuun5ky1E1jMY3gm
 2fu9t8kIuqyT96ZBWajFJa0G0j56R9bdlmd/ZR/AwYOXNvo60QzVS0bWuRewk9RSvmlv
 JSMJNjUr51IRQc9tJQdHOQIqaxT8Nz17GK5PHs1EIv92AtnfpvvQGfRpwsFcFAQibK+Y
 C8gfEHhC0hdmlMjan/8W6R6FyIZb1FUzlfOABtUFkVbZ6bkEIq0fDaiNPTSmk5nwwHpo
 nziF1T6y0ntDIIgcMip2Qb2/f8iNmrXus556FBvw5D39fee8I0jox6BrZkf4tL+DPR9i
 Pdlw==
X-Gm-Message-State: AFq9FYJUROsg6MmvWkcTsOr+zTcx2zaoyzdt2a4zIn8tj0PYtdVaXSmk
 f/7x4IkERSIrY2f4Vx1EDl+NIHezUl7LUwQNUBWt3zNVRqlxfqxp94Y5mvMY5Yud7MIDSNI+bPm
 /CXBCvnnpwMNVgj94qxtkzL2kWQJeLRIsrKCqiwU=
X-Gm-Gg: AYBFou2PhiqV5tHgr2mP0nzBupJzhuB3RfZgfWzuvpB+XukMNEQrvNrkRrLO8G2xYpJ
 rh7IqynBkf8BwiumQavMBohzuwLVVbC5AYLQRVtb6RysS5VwUZmDLS9jDGEySjtTZgPOCBOQw2h
 5dTFhOrR2k4mz06oqFjzcxXPc79wosArsiS6V/cOtxekc6SNWbzt8joMEGOknm/iJXSGYA552g4
 Go2uV9Ph6ZFaEC9DM9hk101ErE6QTJgctWeng+t9BwkSFNXvysUktqa/cejRu2rnwRr97KezzWW
 iE9fBxeoDCN5bB3OAr+c1WUrnCYfCJcA0TeiUASp6F5m0HJtdynx2v1u6PLUifL+L37GVTQu6E/
 GHT3PPt2G8+KdndP2BpktKqnoIftw8OsjUqXd
X-Received: by 2002:a53:b709:0:b0:679:cc49:55fa with SMTP id
 956f58d0204a3-67a7bd54fbcmr2058091d50.98.1793214368857; Wed, 28 Oct 2026
 12:06:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
 <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
 <CAE2XoE-iOCdGxPtg7MqydmahpnOTFM_15dR0eJKGMrQKxrgeQQ@mail.gmail.com>
 <b45d0be7-519b-4c7e-9934-02929e98b1c1@oss.qualcomm.com>
 <CAE2XoE87zFaWZOY4EUjxrOo81+LNbEH_bsm1Hhe-kAdoa9teJA@mail.gmail.com>
 <14850e9b-a9fd-4a97-8040-ba67900e3aa6@oss.qualcomm.com>
In-Reply-To: <14850e9b-a9fd-4a97-8040-ba67900e3aa6@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 29 Oct 2026 03:05:54 +0800
X-Gm-Features: AclHuK8KahISGpSWf6bbUtqhULNl24aKTn6f6bL4OzZLIoQYgHl9dAaE-HWmDjs
Message-ID: <CAE2XoE-Rm-FTPx0GnbMRfVVmE6-rjrafRrXavm_2VtMZXz++QA@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=luoyonggang@gmail.com; helo=mail-yx1-xb135.google.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 2:27=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/27/2026 8:06 PM, Yonggang Luo wrote:
> > On Wed, Oct 28, 2026 at 11:56=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/27/2026 7:15 PM, Yonggang Luo wrote:
> >>> On Wed, Oct 28, 2026 at 1:40=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/26/2026 9:57 PM, Yonggang Luo wrote:
> >>>>>> I hope that through the recent series sent on multi target topic, =
you
> >>>>>> can see better how to try to slice work in smaller pieces. I try t=
o
> >>>>>> focus on having a clear goal for each series, and each patch has a
> >>>>>> unique purpose. Then wait for reviews, and iterate from here.
> >>>>>
> >>>>> I have learned much, I need more information or discussion about th=
ow to
> >>>>> avoid calling target_info() in class_init. You suggest me to use is=
_available
> >>>>> but I still did not get it, because for multi-target binary, the is=
_available
> >>>>> will not be called. so adding more things into is_available is
> >>>>> useless(for my target).
> >>>>> So I want a more clean explanation of how to do that. (I have alrea=
dy
> >>>>> tried rename/duplicate
> >>>>> the QOM name with is_available, too much changes and cumbersome)
> >>>>>
> >>>>
> >>>> First step is to create distinct duplicated types for every QOM type
> >>>> concerned (like two cpu max, one for arm, one for aarch64), and sele=
ct
> >>>> the right one with is_available.
> >>>
> >>> I think this is easily implemented. So this is fine.
> >>>
> >>>>
> >>>> Once we have all types correctly duplicated, and using is_available
> >>>> everywhere, we can replace the callback approach with a declarative
> >>>> approach (.targets), and register types in distinct buckets.
> >>>
> >>> Indeed, we can compute .targets from is_available, as we can create a
> >>> constant mapping
> >>> for those target_* is_available callbacks. So the prototype can lever=
age that.
> >>>
> >>>
> >>>
> >>>> Then we can have an automatic naming convention "arch-type" which hi=
ts
> >>>> this bucket, or "type" which must exist uniquely among all buckets.
> >>>
> >>>
> >>> So you mean use "<target-name>-<TypeInfo::name>" as the QOM name when
> >>> registering?
> >>
> >> No, it would still be registered without the target prefix. Then, we
> >> would automatically make an alias as target-type for each separate buc=
ket.
> >
> >
> > any pseudocode about the bucket? For example, The "virt-machine" qom na=
me will
> > correspond to multiple totally different TypeInfo, how is this achieved=
?
> >
> > Currently the type is directly insert with
> > static void type_table_add(TypeImpl *ti)
> > {
> >     assert(!enumerating_types);
> >     g_hash_table_insert(type_table, (void *)ti->name, ti);
> > }
> >
> > where should be the bucket, I need to prototype it out so we have a
> > clear picture and
> > avoid risks. Or we turn TypeImpl to be a List instead? so we can
> > iterate on it? when
> > it supports targets?
> >
>
> I would suggest you first introduce duplicated types + is_available
> where is needed before trying to do this change.

Hi Pierrick:
Done locally. I'll post this first.

>
> For this, as suggested previously, remove the global target_info, and
> make sure all types can be initialized without crashing, proving
> class_init don't depend on target_info.

And stuck here. I am trying to do class_init with target_info=3D=3DNULL.
with your idea about provide a buckets for each QOM typename, and changed
many objects.c still have not got a workable solution yet.

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

