Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3FDD43350
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t913w-0001uG-ED; Thu, 07 Nov 2024 06:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t913v-0001u4-3p
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:52:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t913s-0001fP-I3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730980346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73OZ+xdqnBbpbjiw6yqTiN6HnJpqpmLLShSN2cybqyk=;
 b=RhOF/8hO3xc11qYM3TTSFruX9nKBFt54AOvVnjxb1+X9oETR9kTBdvDE33WK9F+qDKwyEL
 UEOXzGtG8nU+L0+UCG7/pW8nAXidrUNLT2scJMxoCfFRlGlsxYITZkEpgPSbZkbUHcW5is
 YDye1AH2OHqcL07ETxbxJzi6F6xF73E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-R_n2S5a5ORmp83BvRB8t5g-1; Thu, 07 Nov 2024 06:52:25 -0500
X-MC-Unique: R_n2S5a5ORmp83BvRB8t5g-1
X-Mimecast-MFC-AGG-ID: R_n2S5a5ORmp83BvRB8t5g
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4317391101aso6205235e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 03:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730980343; x=1731585143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73OZ+xdqnBbpbjiw6yqTiN6HnJpqpmLLShSN2cybqyk=;
 b=CNkLe88cYOb2I0IHh0Pv1yfun4LzIiKI5QdDAVGns1tWhzHQIA+BzzZ+DkzeBFV4ok
 g51go2YPTRw8o1yQnu0dIob4R7AeuFVg0l7PvvriLfYtwzK1aBba40cioY5aeumZqYRR
 jukC96M1M2bhLLD2aMoKJwVvqr9wDwzsDoiflIXMpBgKQm83jK1CDKSxph9BzhfVxZVB
 jwvMmJdslERmIWLKIenUdVIuMdf0QeUF6Tec9RFzYp0FkPirXlmKMcEoTmebSf3M+a7j
 72AlwhZvgvpT+49RObWjvvJWMuCLqJ7pTeUUdflQsyw5aQtwA8Qch6CNENKp46CY8qxg
 KlTg==
X-Gm-Message-State: AOJu0Yx7GSqVmSZ7Pmd003iEzNwspc27xNkor2I+82c2Sdf3GmU/8Q1T
 WDqJudLWgEdkf2JkPncwlCusv/sYEAwwQURd8Du1gTxajqBgYUBvO4AGDlJcIak5BnYDW1OhCUS
 imSK4EnRbgRMhWadMZ5Bh+VrxoHmRxEwrvXWZp0zd/ONUH/Zn9DBw4OunoddtWWJlUHBZsJLs9v
 lHB6q5KNZoqS9O4bUzY+Ngm52xWZbscySeoIs=
X-Received: by 2002:a05:600c:1c14:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4328328492amr188176405e9.23.1730980342794; 
 Thu, 07 Nov 2024 03:52:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzntPmTT+LWAGcYfnt3Pnpx5HGmiE0YT3P0gsD00BMutsyc2uZ31NF3bAG5ge26Sv+hEUKJ4Aq0d0nCBJPb0E=
X-Received: by 2002:a05:600c:1c14:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4328328492amr188176245e9.23.1730980342472; Thu, 07 Nov 2024
 03:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <ZyuSjp2rImbm6ByN@x1n>
In-Reply-To: <ZyuSjp2rImbm6ByN@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 7 Nov 2024 17:22:05 +0530
Message-ID: <CAE8KmOz9SHFt=TdQXGXADVLp2t-95wSEWjDZ-XaMYzznPpz0zQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, 6 Nov 2024 at 21:30, Peter Xu <peterx@redhat.com> wrote:
> IIUC we can't simply change it to this.  We can do this with a compat
> property and we can start sending a magic in the preempt channel, but then
> the code still needs to keep working with old binaries of QEMU, so in all
> cases we'll need to keep the old complexity for quite a while.

* I see...sigh.

> Handshake, in my mind, will use a totally separate path, then the hope is
> we'll move to that with more machine types and finally obsolete / remove
> this path.

* I need to check how 'separate path' works.

> But note again that I still think your goal of enabling multifd + postcopy
> may not require that new flag yet, simply because after 7.2 qemu will
> connect preempt channel later than the main channel.  I think logically
> QEMU can identify which channel is which: the preempt channel must be
> established in this case after both main thread and multifd threads.

* You mean, instead of relying on magic bytes, we check if both 'main
channel' and 'multifd channels' already exist, then the incoming
connection is assumed to be for the 'postcopy preempt' channel?

Thank you.
---
  - Prasad


