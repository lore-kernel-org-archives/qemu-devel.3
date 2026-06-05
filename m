Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E3ACD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWeq-0003Wo-4P; Fri, 05 Jun 2026 11:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVWen-0003WV-9P
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVWel-0004KH-JD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9My/uKp2UcMyusPMEgQCTlJ8sjYfVAJFixR1iLGg664=;
 b=QMoHVCBnnLd+9qhqG3j8MCXMNybcvrzXLpgV5f5+1g333t8H3W4x0eB9575Ail28EWqPNK
 6TEFES6bdEKwm/sH8tVy51r7WqJ58mRd/+7VPb8BEd5MZJPsPR/t4FKplimY1qq7XtRoi4
 VcNwI8qyt4GuF5Fun/mzXXTUf8ScTg8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-AFbhLhYSOfeQ6tfDLW7cFg-1; Fri, 05 Jun 2026 11:40:20 -0400
X-MC-Unique: AFbhLhYSOfeQ6tfDLW7cFg-1
X-Mimecast-MFC-AGG-ID: AFbhLhYSOfeQ6tfDLW7cFg_1780674020
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ce9e6cf3aeso41089666d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780674020; x=1781278820; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9My/uKp2UcMyusPMEgQCTlJ8sjYfVAJFixR1iLGg664=;
 b=CqKPJ7BNl/9gI28UrJ66yrYrhTjnZexLYa2EiPu7g0CeKHGtyepVogmCdn2fdmE46Q
 ZRlFK1fd4zRLJDWXAqzabnGW8w6/5Zf7bJakLnbwyiUhroOCFw/l9+EtXO9V343/QIIe
 fLhD12lY3oPuJR4oMQ6H03fo5nUCAppa7gX5xiOBh2j4Z7gWggdHEB3lly4Stdpxi60w
 KHeZCZmgkYGk1gfYtFuW26aGFBh2wc0QVebQb1LqnEviw4vqPshZQyQjZ91rMedvmpxt
 fVdylL0w4rv6rI90R1F6/+yPEctkEiCcY90jzcUOT5BVzy+NYl/mVZm4wJdixBtOYtdV
 OyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674020; x=1781278820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9My/uKp2UcMyusPMEgQCTlJ8sjYfVAJFixR1iLGg664=;
 b=ktm1AFZV8sBLDjx5JyabVX7T+R2gtOOiW4z58lvw7Ri12cnc8PkVn66KcVQYcA2Owt
 pDuNaA2GMCmZ3uKhaJyYHmtTz0E6sababl3L7FyQ16qcJcOVW0B0UmGX5m4VVVIH7ncn
 VICpOOy8ueixx5NSfvgb7dX6uXIrxKVH38cHRTX1LnrNgr45555vl1Dgnp1kL6jCCnYQ
 ZoT8qr+UZP1mV9cwqZKxNpIqL3Hyob3j+R6wuzU569n26unm+sY/hpbUUtF2M8mlaNLR
 UwH15eaun4UaQhSAkeTZrbHkgs0n30T0MN0JlTIsaAigvN68/Hsyy0Ypqykd57zqUGyZ
 Jvbg==
X-Gm-Message-State: AOJu0Yw/hSkkFwdlUjCQMo8qFDS0DJWR3mYrZw70O7QAneOUCjyq0cz4
 vpnE+Kc7FttA1LxU+F4AO1OexpmSYxDSeRGGWF4sDWXwfSBL7wMOa+kDJf0wOJa6c4GuAegH8Im
 DaFuKymJb8HMI4Lp9A5b4ZTMfHsBaAv/2dje0YNg4qhWnLYk2MvgLwX34
X-Gm-Gg: Acq92OF/9eXNMOXNiPjVwe3tVqcrx0vnJ+G9PIkJe6qU8ppiKJcIMxVF0HzUm41Tf4f
 VodeMZQn1gfXFN0c0tnsygmWY06URemuB5MhpVJ5flYcU/6ogFQ1Wwe7jfNGk4/pcMzuYgjJigA
 dy8JP++hZLKewL2QtewoHnbJehUurDAyUtkq593G+yGYOkkTakvsV7Y6BthbGPE1ivIbGNiLD0I
 ZWukqpSN8p6Fez53EnmfIdER9xBpTHVoXNrxt3/4wNkkRzyuin2fKfKJ1xPn6BYpk3F5Cs1iRoV
 DzOjg3yyIezklTPObwOgndY0I2J7I1rEIRuQRjwvmZK2yYNm0hv2yNZRcQkOkzHL1/J6EvSNfwM
 NV/jGxcQtmQL+hFbrER6I6L/u9A==
X-Received: by 2002:a05:620a:40c2:b0:915:673a:617b with SMTP id
 af79cd13be357-915a9ca2579mr756269085a.24.1780674019968; 
 Fri, 05 Jun 2026 08:40:19 -0700 (PDT)
X-Received: by 2002:a05:620a:40c2:b0:915:673a:617b with SMTP id
 af79cd13be357-915a9ca2579mr756262385a.24.1780674019476; 
 Fri, 05 Jun 2026 08:40:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00a4f4sm990088585a.3.2026.06.05.08.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:40:18 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:40:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/4] qdev: Pave way for exporting Property to be used in
 non-qdev
Message-ID: <aiLt4TZ3s8GiTwJP@x1.local>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-2-peterx@redhat.com>
 <87fr316ogx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fr316ogx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jun 05, 2026 at 11:39:26AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Property itself is a well defined interface to either support smooth
> > conversions to Object's properties, or supports global properties.  However
> > currently it's tied to DeviceClass, aka, qdev. So non-qdev cannot use
> > Property list.
> >
> > My current observation shows Property is almost ready to be used as a
> > separated exported interface, except two small things that may need touch
> > up internally:
> >
> >         qdev_prop_allow_set
> 
> Just a thought, we could use something like this to block update of
> migration parameters during migration runtime.

Currently it may not achieve it (with qdev property or object property that
I'm trying), it's because qmp set parameters currently bypasses qom
properties.

We need to switch QMP set parameters to use qom set to achieve it, but yes,
that sounds like something good to consider in the future to merge the two
paths somehow.

If we use helpers like object_property_add_uint64_ptr() we save lines but
lose control over setter() blocking updates during live migration.  If we
use raw object_property_add() we get control but adds boilerplate lines.

Anyway, sounds like something for the future..

-- 
Peter Xu


