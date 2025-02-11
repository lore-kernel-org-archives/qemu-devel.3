Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDB9C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmC4-0007gr-6T; Tue, 11 Feb 2025 04:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1thmC2-0007gg-90
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1thmBy-0003ow-SY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739264667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vx0iGy0yrRql9BVDiGwk9uFWHC3QLwoUqnYftjZsp14=;
 b=NgWMaPgd1yFOtQTXjQl/Lr8BZ8BTEO2TC1ZWg5JO6Lp7LIdf68bu9PRnCJDmCHV03AJVxf
 izAOyhsMhi0d5nlc+lAKo1hhipdusqvFVjSGik5Y9a203DmWWzrONA9D3ny2hAIixMnqZu
 AWEMrGQlJCIvdaoAxRO0aXUQv0+6A8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-V3n19xbxN2aKf7VcW_M_ig-1; Tue, 11 Feb 2025 04:04:25 -0500
X-MC-Unique: V3n19xbxN2aKf7VcW_M_ig-1
X-Mimecast-MFC-AGG-ID: V3n19xbxN2aKf7VcW_M_ig
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394c0a58e7so7096435e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 01:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739264664; x=1739869464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vx0iGy0yrRql9BVDiGwk9uFWHC3QLwoUqnYftjZsp14=;
 b=euhoeDca1V4UL8bUM+wht/6Tsty1aBF7oJwNZLkL3FJGojtB8SBq4q83XTj26Sphkw
 KUzobGKk5lu7HMJfeNg0p7cLy/YkGClS4rHLym6jM52and3IQHUDWkvpfY0UpX2qowA7
 w/TyIdqYsqSc5dWl4R3fYSEqnSIhRlrqE/yjIFgzpWXxZFNk9s7N3W7Sbmab0Vl54JNT
 RPpNbKAl5LwCioA2su/RdYy27j6kDSt4TU+SVbRdZQjJwBio5LIidv7WU4fspm/8dqRw
 GcrOoSPrK+Pna3dyshllbahBMlR8s95Pp9yJhWS8nMv/jmO+FIx7ISC/o6inUEVJ2Vtj
 HmxQ==
X-Gm-Message-State: AOJu0YyTdgkv+QCpgF1EPbmr7tChGUu2JXS095F+8meNaCi5+/CxU2Bh
 om4n6w6+PS07e66kiQQFH3Qe9etLJrBjsULf6OJy6KQ+rnDeAL1hJQfA5pT3PwjjblYqDCosdGJ
 zxWYyqMZTfiXmOs8WU1iM/I+IKf3V0MxfVeaygQ7iky+L8pQCzhdWgekZKaIerKnvUt6nXPQWdZ
 C3jTaMGOn+IW/2BOdcJPXPnh4pD80=
X-Gm-Gg: ASbGncu9qCwSS3b26Bs8AVMBWaMysB3p1Zr3iCNERl+I7t1ZLHB6M6J9Rf3Chxyy74k
 5ltjevbTn26uFXShcjyXisIFTHb1fGfPJcL2jdeod29kl9/ccr854FCaACFdRYjM=
X-Received: by 2002:a05:600c:3d0c:b0:439:35bb:a5eb with SMTP id
 5b1f17b1804b1-43935bba811mr95674795e9.4.1739264664148; 
 Tue, 11 Feb 2025 01:04:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEysFcjnv9s3mzH3nqDK0Su/VjEbSut7cjH60apjvsc/5eVsH0G/dAm5z6uqAl7QegLzmqp3CXS9pNnzHRM4tE=
X-Received: by 2002:a05:600c:3d0c:b0:439:35bb:a5eb with SMTP id
 5b1f17b1804b1-43935bba811mr95674515e9.4.1739264663825; Tue, 11 Feb 2025
 01:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
 <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
 <Z6owYoktb5nk2yRw@x1.local>
In-Reply-To: <Z6owYoktb5nk2yRw@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 11 Feb 2025 14:34:07 +0530
X-Gm-Features: AWEUYZnW4Godl2CIu3xg6nWK8hehqv-uD2q0PfBN-Q9HulaR4yIPGZuj0n323Gc
Message-ID: <CAE8KmOy+C7QzDHJ5hfWg93zSV0ctGYYz30qsQTe-=+iq1vA+fQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, 10 Feb 2025 at 22:29, Peter Xu <peterx@redhat.com> wrote:
> Yes, and I suggest a rename or introduce a new helper, per previous reply.

* Okay, will try it.

> I didn't follow, sorry - do you mean this patch is correct on dropping the
> mapped-ram check? I don't yet understand how it can work if without.

* It goes for channel peek if '!migrate_mapped_ram', ie. when
mapped_ram is not set. When it is enabled, likely it just falls into
the multifd channel, like other tls/file channels. I'll see if we have
to add a check for mapped_ram stream, like tls/file one.

> I meant tls channels should have these magics too.  Do you mean they're not?

* Yes. AFAIU, tls/file channels don't send magic values.

> No I don't think so.
> Flushing sending side makes sure send buffer is empty.  It doesn't
> guarantee recv buffer is empty on the other side.

* A simple 'flush' operation is not supposed to guarantee reception on
the destination side. It is just a 'flush' operation. If we want to
_confirm_ whether the pages sent to the destination are received or
not, then the destination side should send an 'Acknowledgement' to the
source side. Is there such a mechanism in place currently?

> >
> > * If all multifd pages are sent/written/flushed onto the multifd
> > channels before postcopy_start() is called, then multifd pages should
> > not arrive at the destination after postcopy starts IIUC.  If that is
> > happening, we need a reproducer for such a case. Do we have such a
> > reproducer?
>
> With or without a reproducer, we need to at least justify it in theory.  If
> it doesn't even work in theory, it's a problem.

* The theory that both multifd and postcopy channels use the same
underlying network wire; And in that multifd pages get delayed, but
postcopy pages don't, is not understandable. There must be something
else happening in such a case, which a reproducer could help with.

Thank you.
---
  - Prasad


