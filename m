Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C7CC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 01:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUd2W-0003kC-Ei; Mon, 29 Jan 2024 20:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUd2L-0003iG-Hl
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 20:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUd2J-0002dz-Bv
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 20:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706578537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzDZyQZCXjHAwwyZ5AxE4eFUxwp7rAobVN8Wb5qnxeQ=;
 b=d+4Q5JsjE8pYUVbt8TIoG38ZY4EffPmE2pQJExDa9aEbnjEUH3J2BUUjmFPaCRCrqXPDJs
 sqMjn6OaA/V/kAESQoIY/YZjC0qRBZOcTTICVhjU1LAr0rWqUqnRl8AZY07CswQ3njc3Z0
 FyqnxGQ4TM89CeoHNfMvlpEmrFTS6rI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-YGSJtiTxM2i-Jb73GnxAZA-1; Mon, 29 Jan 2024 20:35:35 -0500
X-MC-Unique: YGSJtiTxM2i-Jb73GnxAZA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so758481a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 17:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706578534; x=1707183334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzDZyQZCXjHAwwyZ5AxE4eFUxwp7rAobVN8Wb5qnxeQ=;
 b=X1X4BdZhO6EndUI+qYOx98L1puRjKWeRXG8hgdmhMoXQvJWbDhSY2r9d+CEJ5lV/nd
 dO4/wSpuXu2hxoB2CjCY/s5wbEAI0sHALe3/CMAwTG05wT3EazpMt0yUMWNUpKH3Smaj
 IFA3oTAhWDJHVhh7/LjpGihw8SXZiV0Rz6tDwKMBDwt6JuDpYIwlERQPvmcQ+JVmg3YS
 2P1AJTQmhkhsrzn95f2LxIBujWI2hxok6t2hJMffMwYr2BDrgJl1uxzaIVXriDqOQHlk
 jaa44YeMv9VesLcmX4SceL20vvyocDrH7wBw7jwHzhZPL9/Dgb8tYxGa4yl1pHyuiIBu
 eb5w==
X-Gm-Message-State: AOJu0YzUra7YHYLk6Nc5BuLcUk+PvX8RNVdEeAt21SC3A17VWnlQ5Gcl
 i+QmTSUVk/WBprZFSE1kC1ZcteAvFRLj3BtA0UGWdItMka3oep6+EXebcWE79USTuyrEmBZL+i/
 gO5vcmkRsFJMhSruN6uDWRhemPveTH2o1usdaOR/uyk8hJINiI6We
X-Received: by 2002:a05:6a21:a59a:b0:19c:aba7:ab26 with SMTP id
 gd26-20020a056a21a59a00b0019caba7ab26mr4995257pzc.6.1706578534032; 
 Mon, 29 Jan 2024 17:35:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyOAp306EWIhLKjRpnHope6lEqfbEWxrOzIRIYG59412tCHXbJSoEA9ApktWMasJoScd3xYg==
X-Received: by 2002:a05:6a21:a59a:b0:19c:aba7:ab26 with SMTP id
 gd26-20020a056a21a59a00b0019caba7ab26mr4995242pzc.6.1706578533635; 
 Mon, 29 Jan 2024 17:35:33 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t66-20020a628145000000b006de30d424d2sm2102664pfd.175.2024.01.29.17.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:35:33 -0800 (PST)
Date: Tue, 30 Jan 2024 09:35:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, farosas@suse.de, armbru@redhat.com,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
Message-ID: <ZbhSYE2o35oZH0wi@x1n>
References: <20240123064219.40514-1-het.gala@nutanix.com>
 <1023dde3-4de0-4ec1-85a6-238ed8e16454@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1023dde3-4de0-4ec1-85a6-238ed8e16454@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 29, 2024 at 11:30:53PM +0300, Michael Tokarev wrote:
> 23.01.2024 09:42, Het Gala:
> > 'uri' argument should be optional, as 'uri' and 'channels'
> > arguments are mutally exclusive in nature.
> > 
> > Fixes: 074dbce5fcce (migration: New migrate and
> > migrate-incoming argument 'channels')
> > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > ---
> >   qapi/migration.json | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index eb2f883513..197d3faa43 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1757,7 +1757,7 @@
> >   #
> >   ##
> >   { 'command': 'migrate',
> > -  'data': {'uri': 'str',
> > +  'data': {'*uri': 'str',
> >              '*channels': [ 'MigrationChannel' ],
> >              '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
> >              '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
> 
> This seems like a stable material too, - please let me know if it is not.

Yes it is. I used to be more careful on copying stable at least in the
commit message when I post patches, but forgot to do so when start picking
up..

Note that it's already merged in master 57fd4b4e10, while there should be a
test case to land later when ready (which won't need to copy stable).

Since at it, just to double check how stable works for us: as long as the
commit has "Cc: qemu-stable@nongnu.org" when merge should work, even
without the need to reply the patch copying stable list, am I right?

Thanks,

-- 
Peter Xu


