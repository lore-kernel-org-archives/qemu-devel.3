Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A409606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pe+XGee4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuw8-0003hO-KC; Wed, 28 Oct 2026 00:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLuw6-0003gy-Ix
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:06:50 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLuw4-0007u2-Ip
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:06:50 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso395111a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793160407; cv=none;
 d=google.com; s=arc-20260327;
 b=YT5GAsd2bZoipw8lHhtCE0yy4wQsgm79F1kF8n8dji3heYKcMJYl7noSOwYnxqBJpI
 NshC42v1AOQ4KAjvKYetuezGiM7OJx7woMrhPKPZVZx+vwrynf7QI0IFnTqRmhhRYzTC
 wwjito6uvV2gMcv+1MxMLNzycEAw6+H3RS3ySIoNuk5TwDHf8WjM4yfv3nG3hp9BzIQ0
 BhBgr30M7CHCmRamLqQqDaCwtX6KgtFRay6mxbDhc+V2Pz5HLcV/Wpu0GYkme8aG4Uk3
 h+Z2/12jQ+tqC54xr9wDWA0dXgZKIOP2StbI7C9uvAf+lEATAHTCqyeESOb+PImBFr3P
 3cdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=SKD5ZC9EMi8rBFWT1lIUyANjnUuzTahEqj+XwLtF7I0=;
 fh=46U1FE5Qw0fo7evi6utX9h5HLfzSsvyXi+QDnZDegHo=;
 b=EZ1zxaYdtoUMagjfcm02pzjUIjqztCopNMhoePLE/ZqPXMX75QSjXTEpLyJiiZAJzI
 L9uehs0QWUCMWqOOqzQfNWz3QRFrvlNeWpwy2EspoWVxwLXwyyfbLa4H03AdNv/vnsfT
 8zbvf8fAXubJQEq3+9pZ1NshpsYRfNTef5JR8RC3FTxWXec68XLogCSvYZ75I/EShp2n
 EdCVGn22orzoOIo7qYO04RjSvgDDWOlK9Qd3M+Rl/R4WpUjBhlE5zyhlQdQ+Ezr08MUx
 5cBu1SdVsLlmV2QpI8Eh25JG3IW/N/wbl2UdGm660Sq52daHrvh1cyFZ9xlpf3Zkl22b
 4D7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793160407; x=1793765207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SKD5ZC9EMi8rBFWT1lIUyANjnUuzTahEqj+XwLtF7I0=;
 b=pe+XGee4l3lxKHYA1un0k2+GQfpCmDkzwEie/jU19yix/cjDy1O9C23/oSlCXXDod3
 114zqnQZYWGqa6JSej7ubqqkYjMVHmso1pp8lDOy/Wkf4d1CeNECrU51NwceJu8eHG3B
 +LiLo5k6DGa9mG1IbgMIzZcki7k4TXVNyDIUCSqPTG6E3EE8GIPIFGUC7Q9GKy7aT2RI
 lQqckJK88/zALg7FpH8+lJLoPxbYzPcKZAixxRDGzlx+p5DQG6ZtsNNHdjOqHxTwz52t
 RLNxgd6wqNj9C994kiLmaL37YNE/d4rYAW+/34bBpKsm4VohPIy8AhfXkI5PDdi9tu/k
 Cp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793160407; x=1793765207;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SKD5ZC9EMi8rBFWT1lIUyANjnUuzTahEqj+XwLtF7I0=;
 b=HulTbMpDr0dv1iQDF6V9YGK7ihI9BGD6YBcH7kzhT1nNmJyhpP225IQXNVekU4VVsL
 OXmEVDlAQnY9nAqvNZwIHXEdBteqmMjILMopWG08b7I8UG9n9O5FI6xCt/ZFBDRsDicK
 JoDi5eKYoz3mRDBp1q3qUxrthwP8biLK96duczlf4hKPJauee6XH76R9H3NGrkQedMWW
 1b5X2LOmU2O47wV3PYKvrPTDPdLMxuc233slNcimHX9GAfpLS/7YPzlmyY0H+zqYjoTW
 x7Ee6syKUJiLEQGVRYX7EceUC7c2HZdzC2PGeJrGVHybu4+ZKP1yUHs4rRQDYfhixEzJ
 Digw==
X-Gm-Message-State: AFq9FYKe7PGXCPpbKiuarn8jGm2AScwx/CIyhcfpqyHGfg6zJsEhMpqs
 Kmt+kZNdRElvJ2qCT8bAHyOmyD1toQtQ80+B/+QOd085ixrgBSqfv2flHnqrTeiqPrz32hXz1sX
 d/Xmbypo4zspfWdvXAoZgaZHOkAXJa6B8mDIfNuo=
X-Gm-Gg: AYBFou0xtkXcvOK6UicpHHjZSXjdDKlKwTRHOllch5yiCF1w3dbnC+3/di6CBRvfrlu
 zOBmyxrB8wk7kp/THWmDI1Vmgo5RieBGP2Vfp/nGbHk6EwoZfTv+0UkLPYUilj75YaHsc/IzPk1
 Asqi8jnAnw/eMhhV4yXfKn3psvClS1GRy7gzalhe7c28aJla+JZn/+EatQZ9rOktDvI1xo6DWHI
 tgICuP6YtKg+wU0ndbLOIAHSPCoB/hL1sMqbkA1MtRVw3wKmc0IpAmd+ZuiU8EZ3AxvOrV+q0Nf
 MEiBUCdbzK3uwN4BhNMR7oPS+7XBMGZ2lAe4R/8at61yWet0mviWRK/Ra9JOPuwuCGCdpX5O1sk
 bcAT5JsHNDLzrmD20MHGbPAKuj37F6x8SGzz1oEL5e+kfGmW9kszOYWKmPA==
X-Received: by 2002:aa7:d386:0:b0:6b1:bcb9:15a with SMTP id
 4fb4d7f45d1cf-6b49cbe4f13mr391017a12.20.1793160406548; Tue, 27 Oct 2026
 21:06:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
 <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
 <CAE2XoE-iOCdGxPtg7MqydmahpnOTFM_15dR0eJKGMrQKxrgeQQ@mail.gmail.com>
 <b45d0be7-519b-4c7e-9934-02929e98b1c1@oss.qualcomm.com>
In-Reply-To: <b45d0be7-519b-4c7e-9934-02929e98b1c1@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 28 Oct 2026 12:06:33 +0800
X-Gm-Features: AclHuK9wcDl3jT79IPXC3nA5xllQMNLlRD9MNHBO63XGxRR_hRpZ6QpTIIVAx3I
Message-ID: <CAE2XoE87zFaWZOY4EUjxrOo81+LNbEH_bsm1Hhe-kAdoa9teJA@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 11:56=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/27/2026 7:15 PM, Yonggang Luo wrote:
> > On Wed, Oct 28, 2026 at 1:40=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/26/2026 9:57 PM, Yonggang Luo wrote:
> >>>> I hope that through the recent series sent on multi target topic, yo=
u
> >>>> can see better how to try to slice work in smaller pieces. I try to
> >>>> focus on having a clear goal for each series, and each patch has a
> >>>> unique purpose. Then wait for reviews, and iterate from here.
> >>>
> >>> I have learned much, I need more information or discussion about thow=
 to
> >>> avoid calling target_info() in class_init. You suggest me to use is_a=
vailable
> >>> but I still did not get it, because for multi-target binary, the is_a=
vailable
> >>> will not be called. so adding more things into is_available is
> >>> useless(for my target).
> >>> So I want a more clean explanation of how to do that. (I have already
> >>> tried rename/duplicate
> >>> the QOM name with is_available, too much changes and cumbersome)
> >>>
> >>
> >> First step is to create distinct duplicated types for every QOM type
> >> concerned (like two cpu max, one for arm, one for aarch64), and select
> >> the right one with is_available.
> >
> > I think this is easily implemented. So this is fine.
> >
> >>
> >> Once we have all types correctly duplicated, and using is_available
> >> everywhere, we can replace the callback approach with a declarative
> >> approach (.targets), and register types in distinct buckets.
> >
> > Indeed, we can compute .targets from is_available, as we can create a
> > constant mapping
> > for those target_* is_available callbacks. So the prototype can leverag=
e that.
> >
> >
> >
> >> Then we can have an automatic naming convention "arch-type" which hits
> >> this bucket, or "type" which must exist uniquely among all buckets.
> >
> >
> > So you mean use "<target-name>-<TypeInfo::name>" as the QOM name when
> > registering?
>
> No, it would still be registered without the target prefix. Then, we
> would automatically make an alias as target-type for each separate bucket=
.


any pseudocode about the bucket? For example, The "virt-machine" qom name w=
ill
correspond to multiple totally different TypeInfo, how is this achieved?

Currently the type is directly insert with
static void type_table_add(TypeImpl *ti)
{
    assert(!enumerating_types);
    g_hash_table_insert(type_table, (void *)ti->name, ti);
}

where should be the bucket, I need to prototype it out so we have a
clear picture and
avoid risks. Or we turn TypeImpl to be a List instead? so we can
iterate on it? when
it supports targets?

>
> > For example, most types are QEMU_ARCH_ALL, then they will be
> > registered multiple times?
> > Or for all type with QEMU_ARCH_ALL, will only be registered a single ti=
me, with
> > narrow QEMU_ARCH_*, emulate <target-name>=EF=BC=8C then register all
> > "<target-name>-<TypeInfo::name>"
> > at type_register_internal?
> >
>
> For this, we can probably keep the type in the global table. I doubt
> there are many machines/cpus concerned.
> And all devices will be available for all targets, as discussed previousl=
y.
>
> >
> >>
> >> Yes it's a big change, and it can be done in parallel to current effor=
t
> >> to support multiple targets linked together, it's unrelated.
> >>
> >> Please note that the bucket idea is just an idea at this point, and I'=
m
> >> not sure if this will be accepted. In all cases, the refactoring for
> >> using is_available and have duplicated first is needed first, so lets
> >> focus on that.
> >>
> >> Regards,
> >> Pierrick
> >
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

