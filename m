Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817A4C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 00:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgwE3-0000vD-Ex; Sun, 03 Mar 2024 19:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgwE1-0000ux-9f
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 19:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgwDz-0001Cn-Bo
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 19:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709512233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZriy6c/ERZ7d3BCwVgBok9tFGBO+WJUZ0ghiU0HB7Y=;
 b=AlpgVpHMdFVdhZeeY5SAL9aSw80bm6OBFtEFfXVH1U4z6np+YhdL+6OrJlg0TA/IkAG8mW
 JkWv/6/aODwteOGs/aAgf2Uvond0Atb33E46RPCXYVMe/UxtEn7HijgXaEYlX3pR6IZ8vt
 CICB3voD1i32a6iKRd3BedXqp6lHtDY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-hMeclWPQMgeaeDd3s_X30g-1; Sun, 03 Mar 2024 19:30:31 -0500
X-MC-Unique: hMeclWPQMgeaeDd3s_X30g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so1481492a91.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 16:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709512231; x=1710117031;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IZriy6c/ERZ7d3BCwVgBok9tFGBO+WJUZ0ghiU0HB7Y=;
 b=LmC24qZu7T/eoBVRmslPOZvl+RbfZSrAehbe4EsbSERb6/Pi4f07pPea505Si6Rszx
 ttBUT9jlauhxWa09ZoaKyFgTa5/uW1fWOZXWKrOAOqjdt9bCl7VeZ1gyOEWg+DVIDk8l
 kGXz7465wMGzr+vcmskRO01bcKK/2onUigmPs9gHVk7ZWJliLnll1Ajiw34NFYp0YfpF
 E8nOTaqvtTCpotkbCLh+8iFonPM8EQzHDeo0+vgD3tzyYTpzsPdgwrKDuvfBDNeEtmI4
 JpjCVMrSRruYR8ZSN2cVI5y6CCaSQ/58Dqr4NdqbqakcyRnjC4GQd/J4tN04sfbUmQhD
 TalA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi0y1mwe3+i11G2Szkfduvii23QGvQw4RktEZwnuepale7grf3lWkDtwRd1M1L/tz0kzMgHaPhx3WDUPraLiglO6mCmvM=
X-Gm-Message-State: AOJu0YwC7eWvlbazAJd9X04Ou5RTeTu07ca8aHoGlHVhQ25MaGOIp54i
 xjViXJsNjL5GLEm/zfgz69q+ySjsC7OIIUvAJ5XZF8G6get55+g93qmElu5mIThbXOOwQEf0cKD
 DqJYybJ5wurNJWW79wL42XF20VkTpt9ahbQch+wTlLpx1Idbf39c7
X-Received: by 2002:a17:90a:8998:b0:29b:3cae:c50a with SMTP id
 v24-20020a17090a899800b0029b3caec50amr2405746pjn.0.1709512230657; 
 Sun, 03 Mar 2024 16:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWOrkcCXv00/ncgrvEUOWC/nO0b7TjgVzXGKcuRHlkME6Kg1gTj5In+bX4uI9dAR8DVnS0aA==
X-Received: by 2002:a17:90a:8998:b0:29b:3cae:c50a with SMTP id
 v24-20020a17090a899800b0029b3caec50amr2405732pjn.0.1709512230235; 
 Sun, 03 Mar 2024 16:30:30 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sw14-20020a17090b2c8e00b0029abf47ec7fsm8884397pjb.0.2024.03.03.16.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 16:30:29 -0800 (PST)
Date: Mon, 4 Mar 2024 08:30:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration/multifd: Document two places for mapped-ram
Message-ID: <ZeUWGa20ELoWse5q@x1n>
References: <20240301091524.39900-1-peterx@redhat.com>
 <CAE8KmOz_5-DtSO2BHpBXgD2kJUjwsLaqKguOcWgfXC2efB2rWA@mail.gmail.com>
 <ZeIVYDnAkPTpKHsP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeIVYDnAkPTpKHsP@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 01, 2024 at 05:50:24PM +0000, Daniel P. Berrangé wrote:
> On Fri, Mar 01, 2024 at 11:17:10PM +0530, Prasad Pandit wrote:
> > Hello Petr,

Hey Prasad!

Thanks for taking a look.

> > 
> > On Fri, 1 Mar 2024 at 14:46, <peterx@redhat.com> wrote:
> > > +         * An explicitly close() on the channel here is normally not
> > 
> > explicitly -> explicit
> > 
> > > +         * required, but can be helpful for "file:" iochannels, where it
> > > +         * will include an fdatasync() to make sure the data is flushed to
> > > +         * the disk backend.
> > 
> > * an fdatasync() -> fdatasync()

I'll fix both when apply.

> > 
> > * qio_channel_close
> >     -> ioc_klass->io_close = qio_channel_file_close;
> >      -> qemu_close(fioc->fd)
> >       -> close(fd);
> > 
> > It does not seem to call fdatasync() before close(fd);
> > 
> >     - qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC, ...)
> 
> The documented behaviour reliant on another pending patch:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg07046.html

Rightfully as Dan helped to answer.

While for the other comment section in the same patch it relies on the
other patch:

https://lore.kernel.org/all/20240229153017.2221-20-farosas@suse.de/

> 
> > 
> > Maybe the qio_channel..() calls above should include the 'O_DSYNC'
> > flag as well? But that will do fdatasync() work at each write(2) call
> > I think, not sure if that is okay.
> 
> 
> 
> > 
> > > +         *
> > > +         * The object_unref() cannot guarantee that because: (1) finalize()
> > > +         * of the iochannel is only triggered on the last reference, and
> > > +         * it's not guaranteed that we always hold the last refcount when
> > > +         * reaching here, and, (2) even if finalize() is invoked, it only
> > > +         * does a close(fd) without data flush.
> > > +         */
> > 
> > * object_unref
> >     -> object_finalize
> >       -> object_deinit
> >         -> type->instance_finalize
> >          -> qio_channel_file_finalize
> >           -> qemu_close(ioc->fd);
> > 
> > * I hope I'm looking at the right code here. (Sorry if I'm not)

Yes I think you're looking at the right path, it's just that the relevant
patches haven't yet landed upstream but is planned.  I normally use
"Based-on" tag for such patch that has a dependency outside master, like:

Based-on: <20240229153017.2221-1-farosas@suse.de>

I believe many others on the qemu list do the same.  I think the rational
is this will be both recognized by human beings and also by patchew,
e.g. patchew will report a good apply status here:

https://patchew.org/QEMU/20240301091524.39900-1-peterx@redhat.com/

And in the same patch if you fetch the tree patchew provided:

  git fetch https://github.com/patchew-project/qemu tags/patchew/20240301091524.39900-1-peterx@redhat.com

You can also directly fetch the whole tree with this patch applied
correctly on top of the dependency series.

Personally I don't use patchew, but I kept that habit to declare patch
dependencies just in case it'll help others who use it (e.g., I think
patchew has other review tools like version comparisons, which I also don't
use myself).

Thanks,

-- 
Peter Xu


