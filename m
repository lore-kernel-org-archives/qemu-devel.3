Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B38CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 20:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0mzo-0005Tn-M6; Mon, 22 Sep 2025 16:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v0mzl-0005TQ-TW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 16:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v0mzg-0002Wn-PX
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 16:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758572316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ohDhQtnyNRuZlluu19cSZqT5eOFjUDOSrQXdvbxdhPE=;
 b=PEMFgrRhTPOMMdVmr9qUcQBxham23qNOq6X01PD5r6OUnR50qAr7gUut/OYj92d0x7qk/E
 j8vDLhebDMgsTSq2CqJkZLt/K8jqsGkIXqAryMpfJPpfV3ZRN/pjPEyvg2X0LajJk/DsBd
 lr0aFvxNsqtPsrSIwTiQvllfhZbG4Jg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-8_kw16TFOpi3gB4do3orCw-1; Mon, 22 Sep 2025 16:18:35 -0400
X-MC-Unique: 8_kw16TFOpi3gB4do3orCw-1
X-Mimecast-MFC-AGG-ID: 8_kw16TFOpi3gB4do3orCw_1758572314
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4bf85835856so100641051cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 13:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758572314; x=1759177114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohDhQtnyNRuZlluu19cSZqT5eOFjUDOSrQXdvbxdhPE=;
 b=Ukefj0MJqoDdZKwD9Bf032z8PKZtOm8PDKIWsW2ESyWnghlGujjgvIStrk8jtzrdRD
 o0OtsAev4reK0QgD45U1D031z+eQ1WnDLHu37JdrQMpfTVzvDcKcA80M52Oe/Jrxj5Kc
 uE7Q0xEbnEuteE5W7b8Hw1mFcPBK22OA9SgVZE9bZ7QOe5cGfAYWO+XFwcR2WFoCx4Hq
 ZJyda4Y2CcwZB4GoBzIUQdhwWzsLXRtAB3V+yIvr7ctCjpCEdEhFO8uVbPdCDteDbb7g
 YAVA2DUVhy3Sl1T2nSV4QRsixykHXdfPr4sz1CBKjJv+zqtTG0eJz+OGdFu6DwI5YK78
 437g==
X-Gm-Message-State: AOJu0Yw0yUIVbI3hFx3h9xseJtok7ZoZhKmYHkYc+LktoMGuFKKf4Woi
 FdyWmAON24N1kdeWRb87wfnZEH4ounuEWumMnOph8wDUg7Cfw0aH0dQAnBowiRGEGv32q8jN4Fq
 7fz8XXxO64vrfHj5Ys+Y+VXOMSlJI3qD/wfJwmrfT8W2CxRD85S3I+ts6
X-Gm-Gg: ASbGncuCOcSRC06vg2ZNEAkM4AVPv9PwA/giA85xbPcObqkHKXsgjSDFlVPinZ971n2
 iKOO8EnOZ9dGbRqRYJLfqrh0NTk4Lgl/wv7dxE41NoZe+oj9BP29x4h+B8nkyLTPIYks5pDlQtg
 OlXCETyZlYoSB8zYXwBMlQ/4UPvhuEgsFKzc/OWT0tAqmH/Bbyn2edJ60trEoNv8nybLfXSHyFJ
 vkS2LOo+DR0dGLfixf4jobBXhRSg0AQoZUHHCH0Fu12CKT9sKr0i5qvvZJLLk8/gbn4hgAlMBZp
 aoVJOOItS+oAa4cpgHONYTo+yvuUFWXL
X-Received: by 2002:a05:622a:164f:b0:4b7:aa52:a713 with SMTP id
 d75a77b69052e-4d3911c7387mr59751cf.14.1758572314413; 
 Mon, 22 Sep 2025 13:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHVzIyr7x9qb9HEKNecUP0bI/NaIFE3KKMU8+4PfWLAnewseel5ECEdk4m77tPAp3XZrmkYg==
X-Received: by 2002:a05:622a:164f:b0:4b7:aa52:a713 with SMTP id
 d75a77b69052e-4d3911c7387mr59451cf.14.1758572313878; 
 Mon, 22 Sep 2025 13:18:33 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f59besm76661591cf.8.2025.09.22.13.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 13:18:33 -0700 (PDT)
Date: Mon, 22 Sep 2025 16:18:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v3 0/2] migration/tls: Graceful shutdowns for main and
 postcopy channels
Message-ID: <aNGvGDShRyBI80XK@x1.local>
References: <20250918203937.200833-1-peterx@redhat.com>
 <875xdfv4su.fsf@suse.de> <aMx9yi628fuXr_gH@x1.local>
 <871po2v9dr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871po2v9dr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Sep 19, 2025 at 10:50:56AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Sep 18, 2025 at 06:17:37PM -0300, Fabiano Rosas wrote:
> >> > ============= ABOUT OLD PATCH 2 ===================
> >> >
> >> > I dropped it for now to unblock almost patch 1, because patch 1 will fix a
> >> > real warning that can be triggered for not only qtest but also normal tls
> >> > postcopy migration.
> >> >
> >> > While I was looking at temporary settings for multifd send iochannels to be
> >> > blocking always, I found I cannot explain how migration_tls_channel_end()
> >> > currently works, because it writes to the multifd iochannels while the
> >> > channels should still be owned (and can be written at the same time?) by
> >> > the sender threads.  It sounds like a thread-safety issue, or is it not?
> >> >
> >> 
> >> IIUC, the multifd channels will be stuck at p->sem because this is the
> >> success path so migration will have already finished when we reach
> >> migration_cleanup(). The ram/device state migration will hold the main
> >> thread until the multifd channels finish transferring.
> >
> > For success cases, indeed.  However this is not the success path?  After
> > all, we check migration_has_failed().
> >
> 
> My point is that when we reach here, if migration has succeeded, then it
> should be ok. If not, then thread-safety doesn't matter because things
> have already went bad, we'll lose the destination anyway.

I'm not sure if it matters or not, maybe it depends on how bad it is when a
race happened.

If it's a tcp channel, it might be easier; the worst case is we write()
concurrently in two threads and the output stream, IIUC, can be interleaved
with the two buffers we write.  Not an issue if migration failed anyway.

However this is only needed for TLS, hence I have no idea what happens if
gnutls writes concurrently.  I don't think GnuTLS supports concurrent
writters.  I'm not sure if it means there's still chance src QEMU (when
having a failed live migration) can crash.

So.. I still think it might be wise we only bye() after knowing it is a
success, not only because that looks like the only way to make sure it's
thread-safe, but also because a bye() is only needed if it didn't fail.
Sending it ignoring error is another way of doing so, but it doesn't avoid
the possible result of a race (even if I totally agree it is unlikely..).

> 
> > Should I then send a patch to only send bye() when succeeded?  Then I can
> > also add some comment.  I wished we could assert.  Then the "temporarily
> > changing nonblock mode" will also rely on this one, because ideally we
> > shouldn't touch the fd nonblocking mode if some other thread is operating
> > on it.
> >
> 
> I don't know if it changes much. Currently we basically always ignore
> the error from bye().
> 
> > The other thing is I also think we shouldn't rely on checking
> > "p->tls_thread_created && p->thread_created" but only rely on channel type,
> > which might be more straightforward (I almost did it in v1, but v2 rewrote
> > things so it was lost).
> 
> Ok, but we may need to ensure bye() is not called before the session is
> initiated. So thread_created may still be needed?

In v1, I was using "object_dynamic_cast((Object *)c, TYPE_QIO_CHANNEL_TLS)":

https://lore.kernel.org/all/20250910160144.1762894-4-peterx@redhat.com/

Would that work the same, but without relying on "thread_created" vars?

-- 
Peter Xu


