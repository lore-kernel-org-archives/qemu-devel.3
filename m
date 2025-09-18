Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47248CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJ7a-000050-Lv; Thu, 18 Sep 2025 14:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzJ7L-0008Rj-7f
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 14:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzJ7F-0002rZ-E3
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 14:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758219138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCL+e46H+5pWWv9z0d+ZLpGQ78FtF8joqJTIH3xYzmg=;
 b=BTV6F9xD+VnfZunFSV32RGecpiYLt1sP60UAG5Q3x+1aZAcsobVekxMV9odNQii5jhvukU
 K2eyHeoMyxZ0Z0fwskkHPQS0AHBLUnp4mY24tXA2ETOmabMhodTE1f6/efE47QDzt249xr
 66YNEy1+4wNqQSM3F2EMofqko9WUFPY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sqS2ux5dNYa9LgpEDLE6FQ-1; Thu, 18 Sep 2025 14:12:17 -0400
X-MC-Unique: sqS2ux5dNYa9LgpEDLE6FQ-1
X-Mimecast-MFC-AGG-ID: sqS2ux5dNYa9LgpEDLE6FQ_1758219136
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-81678866c0cso218937485a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 11:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758219136; x=1758823936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCL+e46H+5pWWv9z0d+ZLpGQ78FtF8joqJTIH3xYzmg=;
 b=UTkVgMtXlv/BwAP/gklqB+TJEgola2TYAxTtgk1NRSd4RHyyJJrjlJxJgmWLzBWYTp
 k5a86xrWswPUVB1e2wEGo6SuuM2lGbADuAAKhjkq1D7iRtX9rpe1WAvFJWlV5mVHpz9C
 cm6XnEzw5vgLnveyIrZgf3nd7O25qivzjGEc8nNowqqbJqY5lzmEZOIhCwcekjzWbcoO
 X9RTseJjlDcJCoAvJJ8FJIe58QeijrcXSYc9JUBe87OILyl0CaVO9DiFAXHdCMdcz6Xl
 OT/oZQUCN/cbuYJgdAlqh8zFQgWlbHj867t+q8pQ+ep1LwkL4zU4nTaPY1DfHjg4QMqz
 vZrQ==
X-Gm-Message-State: AOJu0YxlwVkC7OztPZl/5wQ02MuLOvClBwIOCWKg9KqGEkvmIMPd4g+m
 t4qcRbB4M2p0TJ/usn4jZ8eFvg8xrffEVOIqsWu8q33ILkkf3ChlX4ubel1B+Y8Yq2ALoEJM6kq
 8ZadbDgHVSMninG1YFHRyzkuTWFiHn0q8uKb99IwwduS7XcjhgP7OoTxf
X-Gm-Gg: ASbGnct9SjdYJQN8dD5SIPqdhDH2HC0sjTTBpvMCuMk0jP8meddLD1jfSlce/daqquc
 uugTkPoHrEtEHEiYUOPDo4Xf/m8UIbXpRJtFJW8KBmq+LLyOssNp23iBja/aVaHG7GraNPc/GO3
 jcUndxEKh4I3ViR35gfRReNFfKvQTzH4NbXbHY4CD0N4BDH/xysnsR2QojAX7pdno9m1ECoCzje
 UiSh47ZQWia2JhEBkV3eQWrAGXmEcEEU2wvC3Ct70eFO2lkIZwlpmWy52Y3Srdv60IYxahVdzNi
 6TRTq34ruKV7b5roQytbYlKTCiHFIb0f50nVu8URnLFnk58o2/fKZvDYLeU7S3FATG4WGWiEVzI
 SdjbrdZ+8GGAgv3SoHXlRmA==
X-Received: by 2002:a05:620a:372a:b0:81f:9bf3:d65b with SMTP id
 af79cd13be357-83bad120f57mr55523285a.67.1758219136161; 
 Thu, 18 Sep 2025 11:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz7ajPxaNaRY4EFWWzzgfj8KCOgs0P4AdxOqY5FSCssKL7asfoPlBJ5ZbAW5ZBjUfRhau0nA==
X-Received: by 2002:a05:620a:372a:b0:81f:9bf3:d65b with SMTP id
 af79cd13be357-83bad120f57mr55520085a.67.1758219135611; 
 Thu, 18 Sep 2025 11:12:15 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83627e71fd0sm203674485a.26.2025.09.18.11.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 11:12:15 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:12:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/3] io/tls: Make qio_channel_tls_bye() always
 synchronous
Message-ID: <aMxLfX7Z-Z7l4Heb@x1.local>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-3-peterx@redhat.com>
 <87bjn7vmvv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjn7vmvv.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 18, 2025 at 11:47:00AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > No issue I hit, the change is only from code observation when I am looking
> > at a TLS premature termination issue.
> >
> > qio_channel_tls_bye() API needs to be synchronous.  When it's not, the
> > previous impl will attach an asynchronous task retrying but only until when
> > the channel gets the relevant GIO event. It may be problematic, because the
> > caller of qio_channel_tls_bye() may have invoked channel close() before
> > that, leading to premature termination of the TLS session.
> >
> 
> I'm not super versed on socket APIs, so bear with me: Wouldn't the
> subsequent shutdown() before close() ensure that the io watch gets
> triggered? Assuming we're atomically installing the watch before the
> shutdown() (at the moment, we're not).

I think it won't.

First of all, AFAIU migration_cleanup() must be run in the main thread,
because it can register async tasks like the bye() task, and it registers
against context==NULL (in qio_channel_tls_bye_task(), for example), which I
believe means it'll be registered against the QEMU main loop.

Then, if we do a sequence of this:

  qio_channel_tls_bye()
  shutdown()
  close()

And if we do not yield anywhere within the process, IIUC it means it'll run
in sequence _without_ processing any events on the main loop even if some
events triggered.

So.. I think the close() will see the async task and remove it, never get a
chance to kick it off.

> 
> > Remove the asynchronous handling, instead retry it immediately.  Currently,
> > the only two possible cases that may lead to async task is either INTERRUPT
> > or EAGAIN.  It should be suffice to spin retry as of now, until a solid
> > proof showing that a more complicated retry logic is needed.
> >
> > With that, we can remove the whole async model for the bye task.
> >
> 
> With the bye() being synchronous, do we still have the issue when
> migration fails? I guess it depends on what the answer to my question
> above is...

When migration fails, IMHO it's fine to prematurely terminate the channels,
as I replied to one email that you commented on v1.  But we can discuss, I
am not sure if I missed things alone the lines.

Note, Dan suggested me to change the channel blocking mode as a smaller and
quicker fix, instead of throwing async model away, which seems to be
preferred to keep for any iochannel APIs.  So feel free to ignore this
patch too as of now.  I'll still need to investigate a bit on what would
happen if a concurrent update of fd nonblocking would affect other threads,
though.  In all cases, all results will be reflected in v3, but likely this
patch will be either dropped or replaced.

I know I let you read some of the things that we already planned to throw
away, my apologies. But it's partly your "fault" (to take holidays!). No,
I'm joking. :) It's still good to discuss these.

-- 
Peter Xu


