Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC8AC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 07:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0EaK-0001uj-98; Thu, 03 Apr 2025 03:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0EaH-0001sj-4l
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0EaF-0004jh-B0
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743663706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoNT1AGoSV4h4xrK6YJLigb0PMdzCOxfVYOyOIRUiEg=;
 b=fVPBEIOiZIUztc8Qf7u0G+v+iZH93rDt0IvnunWr4ED7oK8NtTbPjw63aKP5LnjGAJ+S9i
 TFNhKtH5zIgbZXqF/nXPtPrKyi0pp7ERLFONlJ3ydPbg2BZvyMege9LFwXxlv9RUzKnS93
 pmxrWcIvlv1Vyy011wazNE7/05kNJ/s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Q04dmLGgOTeuT7NahjiGDg-1; Thu, 03 Apr 2025 03:01:42 -0400
X-MC-Unique: Q04dmLGgOTeuT7NahjiGDg-1
X-Mimecast-MFC-AGG-ID: Q04dmLGgOTeuT7NahjiGDg_1743663701
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so3966435e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 00:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743663701; x=1744268501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PoNT1AGoSV4h4xrK6YJLigb0PMdzCOxfVYOyOIRUiEg=;
 b=fRwLZK0yU0Zw5sPQFV1u1JQLeLErCerhlhaEDCgdkVs3AxQCXlDweWcPDWhxUXQ8dI
 vanr2I5W9J8EjcSVuX7aKEJUTzwSHetPNvzoTRpPaMfOkPxzel8mIDdEjjsNvAvFgXWV
 07HC5ZR7nZ2ACqcQ00Ln+p1BlOMQ6WyvuKfpEvsZLQ+IbsLKhuZpiziFZaZWTZEvlbOL
 +JiXoYlNqZuA6FTJm0dvA6nxL8q8Y989l7Qt5tPAI0ltnwV9vDWXjT35/14tYI9hUZ/N
 1jOMkwVcvrlstqVtwUIPF328DD1nTZ7xelyV33CseF4y/j8YPLarzENapeAWgKXrE1Gb
 Utmg==
X-Gm-Message-State: AOJu0Yx7jOBSyY47IVLuvr+QHKGeDf8XvyNhpbIM+vaQVTDv23KYUcd3
 kV4NOv7q/s/RO90lZ09LuoH9578F1WAfFVFF/MB3704nBqshJjB+iBDdbXAYsMTgV2Jz75Eu+Tl
 odUHexEWrhoKXro3KajZKnXi/84OeAAwAox1tb+DZxb5v6UeduPacx2yjjHyPrd4Ha/fzTOxhIF
 GH7KRIHtLf1au/87YoXBm42xyqpTM=
X-Gm-Gg: ASbGncuvg7FbPJbN3Ubi3LG8zQRS9LjlyQ7MBYzWoTtfMtu4MD0RmCTeDbmlnDBQxrA
 ug0sqgKFDOdeFOfZzasxTpvz7aHkiRULb3eehrbkW7qn/d+74jGqavHRZ+K7xQtfOpInqVEkAZw
 Y=
X-Received: by 2002:a05:600c:4e56:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43eb5c20fdemr59812455e9.13.1743663701095; 
 Thu, 03 Apr 2025 00:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ktUPDv7uJCFcQfCKEWckRj0Ce/DaZ0jIjZostplUZLLmSv2oUbNZs6+qhX0hEa8NGirESUteTc0wqYA/tys=
X-Received: by 2002:a05:600c:4e56:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43eb5c20fdemr59812165e9.13.1743663700707; Thu, 03 Apr 2025
 00:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-3-ppandit@redhat.com>
 <87y0wlkzvs.fsf@suse.de>
In-Reply-To: <87y0wlkzvs.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 3 Apr 2025 12:31:23 +0530
X-Gm-Features: ATxdqUFOzCuSGnQVii-eIXLUFg6GltWEaBcGgiB8oPDtLo0h5mzM4PZoCrOEiE8
Message-ID: <CAE8KmOzASSXE9FRmiFQ6Q4fxaGFh_8VWKXgnugjEs+egFuQPpA@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] migration: Refactor channel discovery mechanism
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

Hello Fabiano,

On Mon, 31 Mar 2025 at 20:31, Fabiano Rosas <farosas@suse.de> wrote:
> > +    } else if (mis->from_src_file) {
> This is redundant.

* This was to ensure (double check) that when the Postcopy connection
comes in, the main channel is established. Also a couple of versions
back migration qtest was failing without this check. Nonetheless,
qtests do work now without this check. I'll remove it if we must.

> > +        channel = CH_POSTCOPY;
> >      } else {
> > -        default_channel = !mis->from_src_file;
> > +        channel = CH_MAIN;
>
> And this is impossible.

    -> https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#m18b6bf30e877f9eafaa67bba6a209b47782f6eac

* Yes, but a couple of revisions back you suggested adding it saying
CH_MAIN assignment at the top was doing some heavy lifting and it's
more clear this way.

> We should probably expand migration_incoming_setup() to make it clear
> that mis->from_src_file is set at this point. And
> assert(!mis->from_src_file). I can send a patch on top later.

* migration_incoming_setup uses the QEMUFile object only when
mis->from_src_file is not set. I'm wondering if we really need an
assert(!mis->from_src_file) check? Because it'll reach here only when
channel == CH_MAIN and channel is set to CH_MAIN only when
mis->from_src_file is NULL.


> > -    } else {
> > +    } else if (channel == CH_MULTIFD) {
> >          /* Multiple connections */
> > -        assert(migration_needs_multiple_sockets());
> >          if (migrate_multifd()) {
>
> This should be an assert.

Same, 'channel' is set to CH_MULTIFD,  only when migrate_multifd() is
enabled. Do we need another assert(migrate_multifd()) check?

> > +    } else if (channel == CH_POSTCOPY) {
> > +        assert(migrate_postcopy_preempt());
> > +        assert(!mis->postcopy_qemufile_dst);
> > +        f = qemu_file_new_input(ioc);
> > +        postcopy_preempt_new_channel(mis, f);
> > +        return;
> >      }
> >
> > -    if (migration_should_start_incoming(default_channel)) {
> > +    if (migration_has_main_and_multifd_channels()) {
>
> I think there's a bug here. Excluding multifd from the picture, if only
> the main channel needs to be setup, then it's possible to start postcopy
> recovery twice, once when the main channel appears and another time when
> the preempt channel appears.

* When the preempt channel appears 'channel' is set to CH_POSTCOPY, so
it shall 'return' before reaching here, right?

===
        } else if (!mis->from_src_file &&
                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
                /* reconnect main channel for postcopy recovery */
                channel = CH_MAIN;
        } else {
===
* When 'main' channel connection arrives for postcopy recovery,
'channel' shall be set to CH_MAIN.

> The previous code worked differently because it did:
>
> if (migrate_postcopy_preempt()) {
>     return main_channel;
>
> which would return false when preempt arrived after main.

* Yes.

> We could use migration_has_all_channels() instead, that would look more
> logically correct, but it would also change the current behavior that
> postcopy recovery can start before the preempt channel is in place. I'm
> not even sure if that's actually part of the design of the feature.

* Not sure if we need this.

Thank you.
---
  - Prasad


