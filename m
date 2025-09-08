Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71AACAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvfUe-0005V5-7b; Mon, 08 Sep 2025 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvfUa-0005LC-2a
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvfUS-0005UB-I9
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757351829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVZPuZFn2/5GHqR+CDtTv2W/b/v3wxC0ly8NpxOfaQ4=;
 b=IZI9PxY/YSm30PRUzkpZxgT7F1C+6Q79GQWLAlfrXZvIop94taVVRReQ4+2JMytUxYJ79Q
 RO3CoEpKBv0kQHPbZQ7XyXJdI7VOIijc4Jt1IMmLlqoe4egFut6lPBBcT36q9ii390LS42
 oKK3UctfpuL10gDZUUFpzLjbIvkwDQY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-HiYLhMgjOkuhTcN_f07mXQ-1; Mon, 08 Sep 2025 13:17:08 -0400
X-MC-Unique: HiYLhMgjOkuhTcN_f07mXQ-1
X-Mimecast-MFC-AGG-ID: HiYLhMgjOkuhTcN_f07mXQ_1757351827
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-252afdfafe1so22846315ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 10:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757351827; x=1757956627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVZPuZFn2/5GHqR+CDtTv2W/b/v3wxC0ly8NpxOfaQ4=;
 b=rXa/W+QXc5scvsS2rUqfXKX1CyKyRT0XQlNrzNuD/6OGeDK4uCw5RkhG8RRe+T1P5+
 h9WKCf1GD1UFNKLFSKp0mPUCxzkUrQHjD4H3pDtwrIgFh/4WF7yUMDxa6VZMKrEALNgr
 sZL+UMZog395KB517qj8y/EPrxgUOOmWrLNhKslseGwBMn+lm4bXBgeQcopywq9ZchNh
 PP4MPWTaMJ+myACoD7V7bRZ7P27NE8qZsNazsaWLJHpeQNI17lJtUkNmDcyyl+4noCl9
 RkedGbS1WkCqs2xglqfaM4e/3t5vfD47+ih3kAm6mI1+XaqGIL10lsepY6xfANpAJsOc
 emBA==
X-Gm-Message-State: AOJu0Yx4XeID50h4jeqc5cOX6jHNeUqhv3+37NYz7aN5HCdPPeJe8HxU
 0HB83ic3hBuOjrGxO+OtR7zlSM/FpIUGHe+NTqEPLoZc7Fc2eRtPt+dcoj+YoGXGXk/A2jK3Thq
 q6GVm0mUFuTAdiIKLhfxlwjQlOzO7JPQ/39a0vgI4cffN9Ec7DgbtY6IIZPphw83DmY8REz0gmC
 2DUs10byfDuul5Ftm51m3khgdy3c9ZQyA=
X-Gm-Gg: ASbGnctltCMNwlzJSA53L6ogfcARGaH/8J9RpA0WEVVPKAhXmPbWb3ahGm+ZzaleLML
 uwwm6thlpK9ng3KHD4MMT+1cPOPwUmAwplm+5xR/sRlquZq0NQ9SBgGEpvhWo2UpAbnjbtqHb3a
 Hfri7gMtYJIwHGsRmdJyt9vxD6+Zc6+wsrdAhw4EmoiHSe9/+KVoXR
X-Received: by 2002:a17:902:cf01:b0:24c:cb6b:105b with SMTP id
 d9443c01a7336-2516e4ae7e2mr114698605ad.25.1757351827023; 
 Mon, 08 Sep 2025 10:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX+j+tJqFN9lJCV+6yEVbIxDcNihh1RLhpakT0VhM42h2hcH/apJDuIzTVYHtGkgYem3ENfsw7+QlsJbw64Tg=
X-Received: by 2002:a17:902:cf01:b0:24c:cb6b:105b with SMTP id
 d9443c01a7336-2516e4ae7e2mr114698285ad.25.1757351826620; Mon, 08 Sep 2025
 10:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-2-jsnow@redhat.com>
 <aL8C_paBo7KfcwEE@redhat.com>
In-Reply-To: <aL8C_paBo7KfcwEE@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 8 Sep 2025 13:16:54 -0400
X-Gm-Features: Ac12FXyLtri1LVnbThbqxcBFaumR7n4c6k1Iqbi04Ai1Xb4nOYrVl0PBwFj8B9A
Message-ID: <CAFn=p-Y3WNudDx4ZRWhz14xe1YFEoVGM7cOTTRWW-J9WMc48xg@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] python: backport 'Change error classes to have
 better repr methods'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 8, 2025 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Sep 03, 2025 at 01:11:07AM -0400, John Snow wrote:
> > By passing all of the arguments to the base class and overriding the
> > __str__ method when we want a different "human readable" message that
> > isn't just printing the list of arguments, we can ensure that all custo=
m
> > error classes have a reasonable __repr__ implementation.
> >
> > In the case of ExecuteError, the pseudo-field that isn't actually
> > correlated to an input argument can be re-imagined as a read-only
> > property; this forces consistency in the class and makes the repr outpu=
t
> > more obviously correct.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > cherry picked from commit afdb7893f3b34212da4259b7202973f9a8cb85b3
>
> Wonder if we should modify this (and later commits) to say:
>
>  cherry picked from commit python-qemu-qmp@afdb7893f3b34212da4259b7202973=
f9a8cb85b3
>
> to avoid the ambiguity of what repo we're referring to

Sure, can't hurt.

>
> > ---
> >  python/qemu/qmp/error.py      |  7 +++++--
> >  python/qemu/qmp/message.py    | 12 ++++++------
> >  python/qemu/qmp/protocol.py   |  7 +++++--
> >  python/qemu/qmp/qmp_client.py | 20 +++++++++++++-------
> >  4 files changed, 29 insertions(+), 17 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks!

(And sorry fixing for 3.14 has become somewhat of a process. Almost
there, though.)

--js


