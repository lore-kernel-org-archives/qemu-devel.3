Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4257AC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUe8-0003nG-PE; Mon, 10 Feb 2025 09:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thUe5-0003mE-99
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thUe3-0006Tz-Ed
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739197218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=unVBynzcTR69zAnyjlxu43GMU8HeDifodQGhYGd6rqw=;
 b=Rh5E2fomGEGegBIjimx9xC/Zti5yQbzpXSeF4RTA4k0SMPVzXJ4GKMJkoxfV3EQ0SLysj9
 Uu3rdVn25rnnwiXviljAql5+TGNb5l/TCz3CNt/lBEImLXsl9+zZfTQQP3JzdJzTqR1T/I
 gEY5vJ1VvxtsGIb6PMhGeAEfS+uBOfg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-sJBabcpNN-ONYNbtZMWzAw-1; Mon, 10 Feb 2025 09:20:16 -0500
X-MC-Unique: sJBabcpNN-ONYNbtZMWzAw-1
X-Mimecast-MFC-AGG-ID: sJBabcpNN-ONYNbtZMWzAw
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c051b1860eso162366585a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197216; x=1739802016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unVBynzcTR69zAnyjlxu43GMU8HeDifodQGhYGd6rqw=;
 b=LL0NJ2rkKcpQvfI/kSEtXrsTKmHzLhiXQggZVZv7olSgUBbC2JKloAsn6SLj9B3B02
 W84nNb6ActR3wpoFBh3ns1YFvfFwYbjL1YZ/M5ndcQ/F52APlouVym+biLQ+rSBd4AMS
 3tr9hX4W6jVKPTbozwMiFYT3emRQdOunIKIvvbASWFrxPvF+RtLbNL0mXtnlQ7460zxN
 wi+TxmUBoHhroPAtkVFxVKkuZ4LuXAZIvxY+wbC3Ny2xyfm682p2V0XFsk5Qk/KAyri0
 vf3Xl7Dl0uuQpDfcieG6iiFSDAK3D5ggITUBC8ksJmP+605OW6cinlwbC7rvZ6PB4Yg/
 PnIQ==
X-Gm-Message-State: AOJu0Yzy7AiwiwHsh04B76fsAb/SPLCz8V/uogaZu9ux1aoZ7EDilpYg
 mCKGp481i5pW8ry8TC84rOviEQfZpi+D3oIH+q2fAcFkolPYAGbnVN1K51PVPuQ+MNpRfPDrR//
 Z9d7ufovBM7NNDdTPkmqSfjzKpowakjPwNQCiW2TxP7Lb5L8K+ikt
X-Gm-Gg: ASbGncvVgo4u+JkpJbdOln1J0ZRl+QK6FIkpDzFywba8AqLGa0oMbSgJS3jY/JkVU9X
 itzI0SIKBL3638U00Cn6PIC23k2DsydzfeICr/0kHTaWhBPHE75q2LlNnHMyecddl1vBIzEaivo
 hlM5aSf+4Zmuv/AJZbH3RGRwDTQie9o3NCsit2Sc5e+N6TROiy3c9UQoIL3fiJuE1TKPJ5VhQot
 weJ0Gh13fbJxiUE1Mm10SW3A6K+9J5RUYM26xox+cBAa2Cg3uRRMR/sWOc=
X-Received: by 2002:a05:620a:414e:b0:7b6:d8da:9095 with SMTP id
 af79cd13be357-7c047bbb346mr1580651585a.13.1739197215750; 
 Mon, 10 Feb 2025 06:20:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9ZlV083E0iuTlu+eCCsfWFq1ncy12QXCj+9sCkaTXUa0XoxL0iUHWlayOk7gIUXbhcoZt5g==
X-Received: by 2002:a05:620a:414e:b0:7b6:d8da:9095 with SMTP id
 af79cd13be357-7c047bbb346mr1580648885a.13.1739197215323; 
 Mon, 10 Feb 2025 06:20:15 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041dec312sm528969585a.11.2025.02.10.06.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:20:14 -0800 (PST)
Date: Mon, 10 Feb 2025 09:20:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 3/8] migration/multifd: Terminate the TLS connection
Message-ID: <Z6oLHLSGxrQpEzQ-@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-4-farosas@suse.de> <Z6ZKUTNVcCVgIbjh@x1.local>
 <871pw9mxij.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pw9mxij.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Feb 07, 2025 at 03:15:48PM -0300, Fabiano Rosas wrote:
> >> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> >> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> >> +
> >> +        /* thread_created implies the TLS handshake has succeeded */
> >> +        if (p->tls_thread_created && p->thread_created) {
> >> +            Error *local_err = NULL;
> >> +            /*
> >> +             * The destination expects the TLS session to always be
> >> +             * properly terminated. This helps to detect a premature
> >> +             * termination in the middle of the stream.  Note that
> >> +             * older QEMUs always break the connection on the source
> >> +             * and the destination always sees
> >> +             * GNUTLS_E_PREMATURE_TERMINATION.
> >> +             */
> >> +            migration_tls_channel_end(p->c, &local_err);
> >> +
> >> +            if (local_err) {
> >> +                /*
> >> +                 * The above can fail with broken pipe due to a
> >> +                 * previous migration error, ignore the error.
> >> +                 */
> >> +                assert(migration_has_failed(migrate_get_current()));
> >
> > Considering this is still src, do we want to be softer on this by
> > error_report?
> >
> > Logically !migration_has_failed() means it succeeded, so we can throw src
> > qemu way now, that shouldn't be a huge deal. More of thinking out loud kind
> > of comment..  Your call.
> >
> 
> Maybe even a warning? If at this point migration succeeded, it's probably
> best to let cleanup carry on.

Yep, warning sounds good too.

-- 
Peter Xu


