Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E68C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpSbZ-0004Tv-J9; Thu, 30 Jul 2026 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpSbX-0004Tf-Of
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpSbW-00087w-B5
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785425005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqqeXJQ7rBaxeoBRGSLx9FjMl19nrvT6UYJ+8PAi4Fo=;
 b=UJA2rGMBKZ8V7GfUHMtI4HmdmzaCj83xH5YnRBSFzlf0dtSHjKzTNwGn3uPeq57502uH9W
 lOTz8ppimahNxCK62W3trgjxVsDwud/LFCnZYYKizxSVYIBL07K1de8a627k8YJhsAWD68
 5i4UxkhkotNrJv8e91Ihky0AUu6JilI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-7UVInmVNOZqHioQNZZ44fg-1; Thu, 30 Jul 2026 11:23:24 -0400
X-MC-Unique: 7UVInmVNOZqHioQNZZ44fg-1
X-Mimecast-MFC-AGG-ID: 7UVInmVNOZqHioQNZZ44fg_1785425003
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15e57a7f8cso211749266b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785425003; x=1786029803; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wqqeXJQ7rBaxeoBRGSLx9FjMl19nrvT6UYJ+8PAi4Fo=;
 b=jfEsl7uzdZn7O/HIWhHFVekgJqoht3nmEIOOP73aq/uCjetxLcD862rzSI8N2uUI2Q
 n4mK01cGuCPTRVlI9Vkb+vOUcLvdCbwYvNzx7vhPuvgk8VAekzGyEkUIkENx2a+AvC97
 xMTW2iTJ6LoO8vBLaIDUKuwEJ9Y+xK/E1HfKFcq+trym/haF71Ry5/4KUGzR/vWiC0F8
 KrZupKmVLJDVMsHw3QfKWx0wF3T0HgLiG+WJdca0Nnzl+PDAWi5GOM6k3dfTl+7GBfi9
 AlWHc3XZqUuhyyrI62vFYnGro3EmndpWdoXcUQVqSLlP3tZd+1gLZDillzzb6qkjK8mp
 gWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785425003; x=1786029803;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wqqeXJQ7rBaxeoBRGSLx9FjMl19nrvT6UYJ+8PAi4Fo=;
 b=gGxB3TGqEXJwMPBUwToI0GgcCtRbc5lbu5klIyBAW3Jy8dLr7yEHtC2zY/VIlBxXYC
 galzmgJcMN9+aODorR65ALtjVqpWQwUBD0guE5rXl51xcZHpjlUE+iL30h7rql1+6EkI
 iL57a8TsRbShsIGoG+Q4K5Q72amXgPaQj8ZE8VwbvUOTSh+SMAjXRMSESeH4jhD2OZ5u
 8Fc0wQRpiSX4iJ8L4kz01SRf8wmzDFUE13VvzejXtkDc8lZNbU3rZXmA/R9Hl2DB1v64
 A6TdVqtTsrFm1JymUiIKJmK7/r/SGizd0ukPlaM4LV+6zf0OZB7hVDW19jc91S9E3rrB
 aA3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rro++b7hUn5cWbsQzrAjdVqOotUrNrZ7fRe3wzzKEwYGk6VeDpbTQ1sHCChDu8VlSr3W+B65XR82tj8@nongnu.org
X-Gm-Message-State: AOJu0YyqIeLRJkKpy2r1Aj/kuAVP6sGHua6TuPeglwAHxgLT1c1J7r7o
 /oez4rhycEgx8kyOFZ29f91xMRbBuSrmITJPSkh5MrkTkK/xXY1089Qzq5uc4Ta0hlkhOwUyken
 K9CEG6P6VwNwgoRNUp96goYR/zqONtLQBhp9tM04c7MQv0BGowa/bMI39+Oy1cm+w
X-Gm-Gg: AR+sD11clzlug1zv4MbVMzPrD6SYsntUsyhuC+AglrADbMpF9igy2t8SlvwvKXc2/LC
 sXyNDPsUhMzN/2Gsp8bSf8Jyi+tc9HySIp1ava/9ef9F//nXtfLx7BtyC+RiNhGdTB7/tGaG9V9
 tYDBrCVjo+8gWnxESX5r6l+NYQyeyux9/MO4FkYt6DZNdIQ1SSAFMeQFJqyoikgmdLo7FY4RmWF
 mp2oXjpqraXBC3+RH1EvTM5RxbhKxKiO5lDYxORe8Kne5mnRkkGKZowEBBnyBuqiDr13RdVa1Wz
 U5c9XxGxJK8qRUSUDe8ZKZvJ+fVd+ohgeiyR/TjOl+9r4CTAt6+Ugn9qggDOXMCNy0kj
X-Received: by 2002:a17:907:e1ce:20b0:c16:e54:9cbb with SMTP id
 a640c23a62f3a-c1fa55da90cmr119849666b.25.1785425002798; 
 Thu, 30 Jul 2026 08:23:22 -0700 (PDT)
X-Received: by 2002:a17:907:e1ce:20b0:c16:e54:9cbb with SMTP id
 a640c23a62f3a-c1fa55da90cmr119848366b.25.1785425002319; 
 Thu, 30 Jul 2026 08:23:22 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa85dac0csm82991366b.28.2026.07.30.08.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:23:21 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:23:16 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH 2/4] migration: Introduce VMStateOffset
Message-ID: <amtsZDQHTLg3nvdB@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-3-farosas@suse.de>
 <20260730101353-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730101353-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 30, 2026 at 10:35:41AM -0400, Michael S. Tsirkin wrote:
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 34dd06f9f73..a272bcfd0b4 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -873,14 +873,14 @@ static void vmstate_check(const VMStateDescription *vmsd)
> >                       * Size must be provided because dest QEMU needs that
> >                       * info to know what to allocate
> >                       */
> > -                    assert(field->size || field->size_offset);
> > +                    assert(field->size || field->size_offset.size != 0);
> 
> Why is field->size checked by coersing it to bool, but
> field->size_offset.size - by comparison to 0?
> field->size != 0 for consistency?

Indeed it might be better to add a comment, but for another reason: IIUC
old code was wrong.. size_offset can be 0 if the size field is the 1st
element.. so this may have fixed a bug.

-- 
Peter Xu


