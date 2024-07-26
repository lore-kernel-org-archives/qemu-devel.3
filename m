Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EDCC3DA64
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 02:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXAcN-0007gC-2a; Thu, 25 Jul 2024 22:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sXAcJ-0007fC-Pe
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sXAcH-0003IN-3s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 22:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721960611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uMHF2+m9Y1bqB89q949ETCM6D8KnKNF0yiL5OsN/bE=;
 b=MyQEC5sELv36+RoZdZzMfTtKymDEqghfI+2vlCVrVPtczAjV5JZPckvYrbEF+arwYcf8ox
 uBFe5HGmdRNywEY6/OfUXp0xrKWLLGMfXIZYep8fW+MVXTB1TycDVej4vK5vv1PUByhNG5
 /l0d6xcdoQsCN+efuZ71UqRVi87c9+4=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-_lVWfyZlP_y_YSNRCZJUXg-1; Thu, 25 Jul 2024 22:23:30 -0400
X-MC-Unique: _lVWfyZlP_y_YSNRCZJUXg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-821436dac4dso140967241.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 19:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721960609; x=1722565409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uMHF2+m9Y1bqB89q949ETCM6D8KnKNF0yiL5OsN/bE=;
 b=qUqacL0fKRh+4tOAfdlBuEFuvAtU4YE+/mec6ODp3hH3OpmxGAbNFnih7UUUClb25j
 WJJs6QmUbCaiyjfcY3u/bKZ07coKdmz5hacho6uEysTk1pSIukICpLF/5VwF+4iZdfeU
 bO172VTz/sfz7U6yl3672Y5TwusOokyjDaVKQhuCyOZhgvgxYkJr+kEyFzV/cbIzX3aD
 uQe8hxLDrREEQYKDaESdFpQTFGbAAtvTygyeJ2E65G45bRT+Wplyy3i+8At3iXTNH5hn
 9y/WqNbKItYdXUoeZEUbg5ZhvZbVWErD80DovV/ntbmFQpFDfu97AoXR6/6DoFpPeUI1
 624w==
X-Gm-Message-State: AOJu0YwukESqQ7GfCCSaSB7tCP1YR2gSC2VkF1be2y2DXxF5PYFOgqGT
 stpzbitDomHe50CDf3LMo9eQAeAXpO8ajUUxUP0JeMGvruC+R7E0YkZ9s7Gml/XektPJpFaR9ET
 Sz+meLQKtxWTjV353dxilvDZPfKao+Gp9iDZQ6Xd5pKW30RyqTwotUNLnJOEhJCwVLanOmoFO+d
 7Tf2sugbSVWsLWhw5v7Jh/6RSWPB4=
X-Received: by 2002:a05:6102:2927:b0:48f:3b56:a184 with SMTP id
 ada2fe7eead31-493c5a0d8c9mr5678728137.5.1721960609145; 
 Thu, 25 Jul 2024 19:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmL91ooCjnYz6qfBIHuvtrMfAbCRvx1HBQtSYIY8SsntMUWjtVM+NkzKYd/vX489euDKWoZ5Kag6vWMImF7j8=
X-Received: by 2002:a05:6102:2927:b0:48f:3b56:a184 with SMTP id
 ada2fe7eead31-493c5a0d8c9mr5678726137.5.1721960608749; Thu, 25 Jul 2024
 19:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240704124834.81958-1-lvivier@redhat.com>
 <58363488-4058-4470-8bda-5068381712bb@redhat.com>
In-Reply-To: <58363488-4058-4470-8bda-5068381712bb@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Jul 2024 10:23:13 +0800
Message-ID: <CACGkMEvdt3SaOb6=SDYiRoR1xhcbJhr0Q_01m_UqZiyTZJNfPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: update netdev stream/dgram man page
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 25, 2024 at 2:49=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> On 04/07/2024 14:48, Laurent Vivier wrote:
> > Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
> > manpage.
> >
> > Add some examples on how to use them, including a way to use
> > "-netdev stream" and "passt" in place of "-netdev user".
> > ("passt" is a non privileged translation proxy between layer-2,
> > like "-netdev stream", and layer-4 on host, like TCP, UDP,
> > ICMP/ICMPv6 echo)
> >
> > v2:
> >    - split patch
> >    - update unix socket description with stream and datagram words.
> >
> > Laurent Vivier (4):
> >    net: update netdev stream/dgram man page
> >    net: update netdev stream man page with unix socket
> >    net: update netdev dgram man page with unix socket
> >    net: update netdev stream man page with the reconnect parameter
> >
> >   qemu-options.hx | 189 +++++++++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 189 insertions(+)
> >
> ping
>

Queued.

> cc: qemu-trivial
>

If trivial maintainer want to take,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


