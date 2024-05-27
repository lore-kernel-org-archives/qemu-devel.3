Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042AEC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 18:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBes7-0005xp-0O; Mon, 27 May 2024 14:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBes3-0005xE-7f
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBes1-0006Iw-IZ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716833692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjxopFZffCBYkviDe60I/4jzBnuV9bd90kR5hLlDPHk=;
 b=Tdt0No0zhWSFiIZHPcGC9dm9i+JkifqPFKM+4tSuQEm1Vyvf2cc9zNGMUQ3WTo1XbCS+N+
 994NvCJYCMBQc6rEk9pdHANi5R7T5AAuNmdjoz6KWru0lufjgk/h+ArekesnQ2mnwv8m5J
 LX0aVCdHqZhaQlEbelQMKRinnYXKjE4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-wB-KnVaAMo6bjfXdRUG1pQ-1; Mon, 27 May 2024 14:14:50 -0400
X-MC-Unique: wB-KnVaAMo6bjfXdRUG1pQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5b96a77ea14so1236551eaf.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716833690; x=1717438490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjxopFZffCBYkviDe60I/4jzBnuV9bd90kR5hLlDPHk=;
 b=pwWpCFxJzpdmUzdoCc8nZqB0BeG6o+Zu0xo5NDJeu7CgXIu1fsvNMM5Kp4JhOTKuAv
 2uLhEH5TY8YFRwG4tQYbqUgHUp+6OecDALwJXW7B0Ra3LYa4VOwhp9SWOwaQQQUfX3MZ
 2N9XtciMKn9tGZ48k+MYCInT0uBSkJBJQHZD6jkVxEB3FKIIEeVlodp+fC2xDTznIJJs
 D9WmuOZz3iEN98/joRgTSYUjksWaIBfpaDP2EjIQtq31W7F+itOX+tXwWj0KWye9nnn8
 hvLPtGWJT+YxdVYuL8TaFkV9DxqV5fOIcyiEeO4Jidy33zTMV8TxEB2hx5F8XEjiRffs
 TydQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaZQ2183ig+kZDx29QtbF7Q0xm+Kk1PoZYqA0ffAI6WqrFE9ZcsoL/DAo591+gY3Q8Cl5G6fxrjpqqQclEFi17Eem77Kg=
X-Gm-Message-State: AOJu0YwQO8BJsBAmCVy0BhbJ+Is4xXjRf6g7j9BKEaJFEYmRLwreF3MB
 iyBX/MvGyzjWjstOI+ygPU8JNvvijiS0BFlemgiPv4k1nmYo1r0pg4/1eDBBWAm2B5z8xaoKol7
 BI6Mf9q4VXYY8otJLWJlNswNWECfttDTid5CWl2Tzgw9d7RaewwQB
X-Received: by 2002:a05:6820:2e02:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5b961b691eemr9950259eaf.1.1716833689336; 
 Mon, 27 May 2024 11:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7iUcUTn0TFoQgrQ/K1mlk1mvF//xH/QHokrOtHo25zdbxCvZTiI2acB4mcjxd/3zoL/hoGQ==
X-Received: by 2002:a05:6820:2e02:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5b961b691eemr9950226eaf.1.1716833688576; 
 Mon, 27 May 2024 11:14:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb180456fsm36285671cf.50.2024.05.27.11.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 11:14:48 -0700 (PDT)
Date: Mon, 27 May 2024 14:14:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 03/26] migration: SAVEVM_FOREACH
Message-ID: <ZlTNlaheQwxD76IC@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-4-git-send-email-steven.sistare@oracle.com>
 <878r0mmsxx.fsf@suse.de>
 <819578ba-c92b-4589-8916-f085d0e7a92f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <819578ba-c92b-4589-8916-f085d0e7a92f@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 13, 2024 at 03:27:30PM -0400, Steven Sistare wrote:
> On 5/6/2024 7:17 PM, Fabiano Rosas wrote:
> > Steve Sistare <steven.sistare@oracle.com> writes:
> > 
> > > Define an abstraction SAVEVM_FOREACH to loop over all savevm state
> > > handlers, and replace QTAILQ_FOREACH.  Define variants for ALL so
> > > we can loop over all handlers vs a subset of handlers in a subsequent
> > > patch, but at this time there is no distinction between the two.
> > > No functional change.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   migration/savevm.c | 55 +++++++++++++++++++++++++++++++-----------------------
> > >   1 file changed, 32 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 4509482..6829ba3 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -237,6 +237,15 @@ static SaveState savevm_state = {
> > >       .global_section_id = 0,
> > >   };
> > > +#define SAVEVM_FOREACH(se, entry)                                    \
> > > +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
> > > +
> > > +#define SAVEVM_FOREACH_ALL(se, entry)                                \
> > > +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
> > 
> > This feels worse than SAVEVM_FOREACH_NOT_PRECREATED. We'll have to keep
> > coming back to the definition to figure out which FOREACH is the real
> > deal.
> 
> I take your point, but the majority of the loops do not care about precreated
> objects, so it seems backwards to make them more verbose with
> SAVEVM_FOREACH_NOT_PRECREATE.  I can go either way, but we need
> Peter's opinion also.

I don't have a strong opinion yet on the name, I think it'll be clearer
indeed when the _ALL() (or whatever other name) is used only when with the
real users.

OTOH, besides the name (which is much more trivial..) the precreated idea
in general is a bit scary to me.. if that was for a "workaround" to some
new ordering issue due to newly added dependencies on exec() support.
Maybe I'll understand better when I get to know better on the whole design.

-- 
Peter Xu


