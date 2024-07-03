Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D1AC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvBu-0004Lg-Ig; Wed, 03 Jul 2024 04:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sOvBr-0004EQ-Kz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sOvBi-0001Ft-Nn
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719994677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ken4r91DRAVqqYkzN38sQgS07RXcR0e/FFw8rkoP9NI=;
 b=gLOy8eWbzK28iVbxvQoZUI9d+zsHwjES468kjrkkkG+sbFGpEjwXedgqYpNV6e4nDUgujG
 qS2FNeMImHLihBD7u4Xyggj1T+LF85HK/56o0cPvu7O+jfox0AjttAU0kUPeVmUIkvKZll
 SdmEeCAhpp+sk+QMz5vTsSyNUWWre8c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-2Xl-w041MEetkujASN0SeA-1; Wed, 03 Jul 2024 04:17:56 -0400
X-MC-Unique: 2Xl-w041MEetkujASN0SeA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4460f0951e8so74920201cf.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719994676; x=1720599476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ken4r91DRAVqqYkzN38sQgS07RXcR0e/FFw8rkoP9NI=;
 b=DuHkodODAtzbiPXVMk0FbSC6IwSDFZ/hXZ6F9x5a2n2HeT5r+jTrxySUQjLoe90Iu/
 e9XBH4uR8sWelFm2giLry3wlF5habNlgdSmV7DcD3jaRyQUL4IB4B8A86VTsXZaKoiHp
 2mOu296cmlcP9DHKoaI4M4EH37SiBLgQJwBEB1g6HrasOZVQbpi4e1Bdc7/Fh5Uki8MM
 5UA51Eb+X1D5GJCH4pCbfHKUjWaCQLUD5mg2MJ7rxMFtkDSdD5mOzO9E9fIGcZJRfO0P
 TLLoBXbcIJfqNzazkFVTdX9nCbZRwlfFofsx1rOn0N1NaBpQjm0+5/+5iC27zaaS08uj
 fCBw==
X-Gm-Message-State: AOJu0Yy2dA+MeqmsHqK8B0R4RtIXRy8fNZuKQ7VOvGJGhJEDc4uImqBy
 kCdMvrZ0uTUYclK90H1Ylyhd7Yx/OG24K2FTYayHAJX6anJR2DLtjXvic+Oy9XyRLznt50BP7tK
 0ig+rMiQHYvACV8CxvMt026cRHO6bRbiJX9dymT+Tc9HVnlup8ENfqvWQQFwLxJ0bgqOudj2YGi
 1ODrEzBdOfmJaL3vlRcuH74AJPQcE=
X-Received: by 2002:a05:622a:648:b0:444:fe06:d7f with SMTP id
 d75a77b69052e-44662e3a183mr137273061cf.10.1719994675853; 
 Wed, 03 Jul 2024 01:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPV7F7huIsPavpw+P1hkvJmDMt0un6N8GHu6BqXq+8fMaiqC9WsULzLIMmkeO2TIZQXEIfbyYWpcFblpxkvUA=
X-Received: by 2002:a05:622a:648:b0:444:fe06:d7f with SMTP id
 d75a77b69052e-44662e3a183mr137272941cf.10.1719994675570; Wed, 03 Jul 2024
 01:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <ZoRAMXeKDObGnl4h@redhat.com>
 <CAMxuvaxKRjA=p8t_RkYT-xJag4DvnukHXhD3uS83LZ-L-OZwCQ@mail.gmail.com>
 <ZoUGmVsHObVCmVPv@redhat.com>
In-Reply-To: <ZoUGmVsHObVCmVPv@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 3 Jul 2024 12:17:44 +0400
Message-ID: <CAMxuvayg2CoYu_su2qRH=OZSuaHTSUqp-5RSsuBWTvD=wcXtJw@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] qga: clean up command source locations and
 conditionals
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi

On Wed, Jul 3, 2024 at 12:06=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Jul 03, 2024 at 10:15:44AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Daniel
> >
> > On Tue, Jul 2, 2024 at 10:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > Ping: for any review comments from QGA maintainers ?
> >
> > Maybe you could resend for patchew to correctly handle the series.
>
> I don't want to spam the list again just because patchew didn't
> handle it. If anyone can't just pull the messages from mail
> though, they are also at https://gitlab.com/berrange/qemu/-/tags/qga-cond=
itions-v2

patchew also handles R-b/A-b/T-b tags, mail ref, versioning etc..


