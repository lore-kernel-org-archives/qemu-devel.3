Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1C8D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8f0q-0004G9-RM; Wed, 06 Nov 2024 07:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8f0o-0004Fm-2T
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:19:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8f0k-0002jQ-TZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730895584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WnDAuoVKdl5A0sKOcF5BPeamPx1yBcPuUCKFshk8m0=;
 b=cketFJWuo6aKrEBhA6eSM03M4vp9gVgfQUdJB1v6mS06o+GDLDWJjB71WnAWJIc+9nIEgQ
 naI8Jl8kfaafoIMoLUvoGLDI3/4jDlLgZZgPFneHpk2atmjGqxBRgkWIDkbUwneVNHLgnU
 l3GFA+NLj54LABpnsmWAOtFFGc3xlgI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-auvWp_dgMeWt8GEL0rSPag-1; Wed, 06 Nov 2024 07:19:42 -0500
X-MC-Unique: auvWp_dgMeWt8GEL0rSPag-1
X-Mimecast-MFC-AGG-ID: auvWp_dgMeWt8GEL0rSPag
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315544642eso48534455e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 04:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730895580; x=1731500380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0WnDAuoVKdl5A0sKOcF5BPeamPx1yBcPuUCKFshk8m0=;
 b=XjZT1ls+h9bLDY2AvEMQ4RhZv2Q1g4GyjmnkMp16tj6jqN8ObPGibZxC5hOZM6Zplb
 N9qrJomS5eA+2wF4jU7XaL7/wVUUIaeTvSAE3tqReGkK1Yo9cwZp/BbomuwGdHod9eCt
 zPbvafY82HHUzSM+msb893PoiXIwiiT2Xbnvq5jr+lGSfyRz+znx2pOXOVQa8vph1cZd
 BZvjnfX9lA4oB0ViVvZq2HJeelDJD/nbxNx/sQMIZ0Eglsi2TDZIJLWVq7msEvzvS8Da
 VwFvGhIVHcTGNeYOyWgC+61ukeUKJDKlZRuqkegiB5spL9Ps11JoZTsvCZT6/sUj9wJ8
 6HmA==
X-Gm-Message-State: AOJu0YwH+fLsJD5ec/VeRVHM40RXkn/rOvRGJNtOEyDWjMgh7RTLGdVA
 Ge4Sp842O6G6YG57kb/e9BB78WSXw0D/HDd4l/hDW3eyaFnbePSQxRHE3n4zGYebrI63rqwlsDF
 /WzWRi8StbydZDT2qoDKtB1i49MXb0astYyVF+s2EO0/qT2H83/8dssLKLULmp4dtzK0HWpw9vX
 tDNOBjN/50APItGmmnKS44/UM2RZ5vEDauwRylng==
X-Received: by 2002:a05:600c:1c26:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-4329fdb1571mr69212395e9.7.1730895580555; 
 Wed, 06 Nov 2024 04:19:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoTynCq0eN5ZQ0TXfDVllycHlTP/KRdar0eeuMRVltVSwTcE1ZfRVJ+2cIakDY5/EsP5BOgDAec/xR3ubzxdc=
X-Received: by 2002:a05:600c:1c26:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-4329fdb1571mr69212195e9.7.1730895580187; Wed, 06 Nov 2024
 04:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
In-Reply-To: <ZyoW3ue3WTQ3Di1d@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 6 Nov 2024 17:49:23 +0530
Message-ID: <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 5 Nov 2024 at 18:30, Peter Xu <peterx@redhat.com> wrote:
> https://www.qemu.org/docs/master/devel/qapi-code-gen.html
>
>         Sometimes, the behaviour of QEMU changes compatibly, but without a
>         change in the QMP syntax (usually by allowing values or operations
>         that previously resulted in an error). QMP clients may still need
>         to know whether the extension is available.
>
>         For this purpose, a list of features can be specified for
>         definitions, enumeration values, and struct members. Each feature
>         list member can either be { 'name': STRING, '*if': COND }, or
>         STRING, which is shorthand for { 'name': STRING }.

* I see, okay.

> It's a legacy issue as not all features are developed together, and that
> was planned to be fixed together with handshake.  I think the handshake
> could introduce one header on top to pair channels.
>
> IMHO it is an overkill to add a feature now if it works even if tricky,
> because it's not the 1st day it was tricky. And we're going to have another
> header very soon..

* See, current (this series)  'if'  conditional in the
migration_ioc_process_incoming() function is simple as:

    if (qio_channel_has_feature(ioc,
QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) { peek_magic_bytes() ... }

If we don't send magic value for the postcopy channel, then we avoid
peeking into magic bytes when postcopy is enabled, because otherwise
thread will block peeking into the magic bytes, so the 'if'
conditional becomes:

    if (migrate_multifd() && !migrate_postcopy() &&
qio_channel_has_feature (...) ) {
        peek_magic_bytes()
        ...
    } else {
       When migrate_postcopy() is true
       It'll reach here not only for the 'Postcopy' channel, but even
for the 'default' and 'multifd' channels which send the magic bytes.
Then here again we'll need to identify different channels, right?
    }

* Let's not make it so complex. Let's send the magic value for the
postcopy channel and simplify it. If 'handshake' feature is going to
redo it, so be it, what's the difference? OR maybe we can align it
with the 'handshake' feature or as part of it or something like that.

@Fabiano Rosas : may I know more about the 'handshake' feature? What
it'll do and not do?

Thank you.
---
  - Prasad


