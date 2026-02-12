Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB99EEA86E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgYz-0008Pz-JS; Thu, 12 Feb 2026 18:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.5hx5xj9npiouv80=3r8mqfjlp8ao=r2bbkg3zm1l7ou@em483429.getutm.app>)
 id 1vqgYx-0008Pa-Bw
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:57:35 -0500
Received: from a4i986.smtp2go.com ([158.120.83.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.5hx5xj9npiouv80=3r8mqfjlp8ao=r2bbkg3zm1l7ou@em483429.getutm.app>)
 id 1vqgYv-0005Vk-JG
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1770940638; h=from : subject :
 to : message-id : date;
 bh=1ZqH6L8yb/rW/YvFww8z2sJQVKZ+g7gw8cwuvcC4v30=;
 b=abjni8NeDF3VP9IbB1sXKSXckzPhDeNuDs+NX5+o2PR0JG6bIQUrWrgr7xzxEFtgBS+vy
 nh45/Dtt3T8cOGzCACpwChiAQQYEpDUYfvbwAKBcLeKddIHTP4ZAvqRm7qQ//Xv5XRsXzDP
 Kf6ltnY+gws1WxTwoQvxRO+tvnQrhAnQE6S9NaPeQH3th1E2f1+wjbiBbG5vH6bs9NDu+Hb
 ZA/N+kJ9b1xfjso2Shl+eTs9Qbtq8c1UEJEYbeSPQBqbaPTogIarELOdKYJQl8WJYIWsqKD
 pFqr/zuC7/KdCY4Ou9FuFjSCI+WfFUORi0TAjZXzyJFeaRechB1wQSMNUsEw==
Received: from [10.159.238.187] (helo=mail-ed1-f45.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.99.1-S2G) (envelope-from <j@getutm.app>)
 id 1vqgYe-FnQW0hPlS5s-iZqw for qemu-devel@nongnu.org;
 Thu, 12 Feb 2026 23:57:16 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-65a11e565a9so339697a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:57:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWLN0xniWq41P4HAZIUL7hFri/oLYYL/Lzc6MNjnb9tAWjxtbKgJg+p6qjrLhNjazj3XcgSKSY3DRSb@nongnu.org
X-Gm-Message-State: AOJu0YwO6WzxJKAvf3lipLsQ0nmGEvKXdfcriOUrCqnC+xgw9w3WWb7P
 Phg0JxqcwobosKfu9HwcwfvL3KnMtsgdUaEnAsRQ1pBTWGoFolLG2peWUFmo1eBV/MQoC9We4og
 P4WlUgRAtgONBBpwP1GQ/PWVg8mCW9Q4=
X-Received: by 2002:a17:907:6d1b:b0:b87:4c74:b316 with SMTP id
 a640c23a62f3a-b8face2cffdmr34585366b.50.1770940635489; Thu, 12 Feb 2026
 15:57:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
 <68223045-effa-4319-817b-1a31f227c081@collabora.com>
 <20260212020117-mutt-send-email-mst@kernel.org>
 <f6d75a31-a72c-48da-a195-0a74b75b8596@collabora.com>
In-Reply-To: <f6d75a31-a72c-48da-a195-0a74b75b8596@collabora.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 12 Feb 2026 15:57:04 -0800
X-Gmail-Original-Message-ID: <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
X-Gm-Features: AZwV_Qi0SV2U1QgnVPjxLZuQ8JqxWNsPw44FnDqNPjW5Is1e7CFBj9iXT_ymFuA
Message-ID: <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Joelle van Dyne <j@getutm.app>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429scVmEp7XNq
X-smtpcorp-track: 1jneKb8ukVEd.xyBF-11i6BL9.GQxpqwApvXP
Received-SPF: pass client-ip=158.120.83.218;
 envelope-from=bounce.5hx5xj9npiouv80=3r8mqfjlp8ao=r2bbkg3zm1l7ou@em483429.getutm.app;
 helo=a4i986.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 12, 2026 at 3:00=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 2/12/26 10:01, Michael S. Tsirkin wrote:
> > On Thu, Feb 12, 2026 at 01:53:09AM +0300, Dmitry Osipenko wrote:
> >> On 2/12/26 00:32, Joelle van Dyne wrote:
> >>> Yes, it does seem like v1 was picked up and not v2. v1 was broken for=
 this
> >>> reason.
> >>
> >> Thanks for the confirmation. Most likely you will need to send a new
> >> version of the patch fixing the applied one.
> >>
> >> --
> >> Best regards,
> >> Dmitry
> >
> > applied one was v3 according to my records
> > but if it crashes pls do send a fixup.
Sorry for the confusion, I was traveling and when I originally
reviewed this thread, the stack trace + the link to v2 caused me to
claim that it looked like v1 (since it didn't have the NULL name
change) but after looking at the changes properly I see that v3 was
the patch that was picked up. There was no mistake in applying the
wrong patch.

>
> Alright, I previosly missed v3 and see that it's identical to v1, which
> has the crash problem.
v3 is not identical to v1. v1 changed the owner of the region from
itself to the parent object. This fixed the original crash but
introduced a new issue. v2 tried to fix the original crash a different
way that was brittle because it involved manually writing to a field
in the memory region struct. v3 was the proper fix which used a NULL
name which allows the parent to be unset and then we have to use unref
instead of unparent in cleanup.

>
> Joelle, are you aware of this problem with the version that got applied
> to the qemu/staging tree? If yes, could you please send patch fixing it?
Unfortunately, this means that the patch should not have been back
ported. It is possible that the crash which this patch was addressing
was introduced as a result of changes elsewhere. For example
https://lore.kernel.org/all/20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-tokyo=
.ac.jp/
changed some internal mechanics of finalize. I didn't raise any
objection to the back port because it seemed like the original code
where the object was its own parent was wrong but I guess it was
working fine somehow. I think in the meantime the best course of
action is to revert the patch in the stable branches.

>
>
> --
> Best regards,
> Dmitry

