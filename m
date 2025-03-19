Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A615C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuurs-0000JF-Gl; Wed, 19 Mar 2025 10:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tuurg-0000FD-7w
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tuura-0006xC-NB
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742396260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6tjw1mSWSMquwZmm+qtuXAh2X25FxYPkTS8DkXIrWE=;
 b=SJRUAqfLoiCw1O1RQeQ6NQ95SsYJdQCTGSMrfwk7rVo1plQlBj2VM0YacAMTLJXCbcMQ9q
 2Vdq/h/EwwlUSqOHenr41NWR0Ojh358ODaeRghnYhvD8hqeoqVbWsMMScraW1qB2SirQFr
 Bc/z/fdfGuOvZChypXLGqYA2CkpDmnA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-pNlrkEZrNQ-dtX1QDnsqNQ-1; Wed, 19 Mar 2025 10:57:36 -0400
X-MC-Unique: pNlrkEZrNQ-dtX1QDnsqNQ-1
X-Mimecast-MFC-AGG-ID: pNlrkEZrNQ-dtX1QDnsqNQ_1742396256
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6f2737d115eso90486747b3.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 07:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396256; x=1743001056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6tjw1mSWSMquwZmm+qtuXAh2X25FxYPkTS8DkXIrWE=;
 b=M0p94V+29cJ4XUIF2Or0jmAa0SOManrGhHeN9txbL4VbEDaPBk6wu7xtWPw2Psh9Rw
 cSfMEnxv3E7wj5wfqtWZtM/NYP0gNJzKEBVXhtS2BLowJyndVRVLUkQtMpsQIXIL9qZD
 csQIx5RRiiXqnKrjn9fR603B2/fr7Z8M9VNdirPI1gvYCPxrfI7V5i0oDC6uJJA8WT/A
 egHhqdAIlyFQVEEpYe1RI1s26nayJGuMWRz06oBNyJG4aXJLa8wJCufMmL/p/bj4bl/g
 iORbH7ni4l1g46n1i56RE5XW/JnTECv1LiS6XcPeA/5Ta4yWx6GhdmXBL5kidnLpeAFM
 h6dQ==
X-Gm-Message-State: AOJu0YyUy8aF8E65oakmUCYRfHBK50o/qrIQyZg7FSCW4COw0uaqR6lC
 CviuYRLJRRbKWUhXkg+6mVahZ/7WVyjt4jcj/G3onsn+j/wy5igkQ1sPfItcGMene9FAu9jrPC6
 HFnA11N8bVlX/PsikBmgfrb1AUof8UC+zVpavh8vXQG9UwxlOPJtiEQbpKIKSnox2uFBmdoyQ1R
 /5h9XjFBwWSG6EE6GVjRokFYRac7s=
X-Gm-Gg: ASbGncuu3IGRE8lvmAE7soDy41EKHTD1T0hClqBYYbjw7uMnQFyZmB12MvyePd1hP9J
 6nDFTkr/019fEmsiFdVCQJ0JqY8+TZDkZ0uQTYNrnURT8n5levtZpUH9GnFMkYQjKIimNzeQ=
X-Received: by 2002:a05:6902:478f:b0:e63:cfbe:5d57 with SMTP id
 3f1490d57ef6-e667b435c9emr3598318276.38.1742396255888; 
 Wed, 19 Mar 2025 07:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMkPltfMYNFvh9X6D3XkZlY7VwIsEZZn7B6RGK5mY/Oxx+v0UBc716gCdDNk5s0VaRU18kAbyHWvf5zAXp+5E=
X-Received: by 2002:a05:6902:478f:b0:e63:cfbe:5d57 with SMTP id
 3f1490d57ef6-e667b435c9emr3598296276.38.1742396255540; Wed, 19 Mar 2025
 07:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250314113847.109460-1-kkostiuk@redhat.com>
In-Reply-To: <20250314113847.109460-1-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Wed, 19 Mar 2025 16:57:24 +0200
X-Gm-Features: AQ5f1Jp4b70D06oNJRULhanRx_7HYwFw1d920TghMYCJ5jicoNpkLDDzZjkV9dA
Message-ID: <CAGoVJZxAEXsiuC+B1uA0m-FJJwVbR=9pP9wDrHNkgE52gbqp2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] qga: Add 'guest-get-load' command
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


On Fri, Mar 14, 2025 at 1:40=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com> wrote:
>
> Konstantin Kostiuk (2):
>   qga-win: implement a 'guest-get-load' command
>   qga: Add tests for guest-get-load command
>
>  qga/commands-win32.c   | 140 +++++++++++++++++++++++++++++++++++++++++
>  qga/guest-agent-core.h |  10 +++
>  qga/main.c             |  39 ++++++++++++
>  qga/meson.build        |   2 +-
>  qga/qapi-schema.json   |   4 +-
>  tests/unit/test-qga.c  |  17 +++++
>  6 files changed, 209 insertions(+), 3 deletions(-)
>
> --
> 2.48.1
>
>


