Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEB8C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVI6-0006pw-SS; Fri, 08 Mar 2024 03:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVI3-0006lW-2z
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVI1-00052F-Ok
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1x1CbcWD8BgSBU1mwb3n5+g4oSkeRqdcwCFkah17Ko=;
 b=IBoo97u/OEJRtgJbwaiChqybAA31LghX0bPYl7WvAtJEMkeAbWmWwi4yWHNpMPp+y+22Pl
 x4N3uYndXKIJ28g7hF/+Abl7WOqAAt0yhFGEFzs0s1c5vU28WtyJeDKzy2yLT9zxlWQqE1
 hNhBCg7x4wxqP/bLGkys5abK+Tt6QfE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Rp3AgluZOlqcVcNF2ZcuDw-1; Fri, 08 Mar 2024 03:09:11 -0500
X-MC-Unique: Rp3AgluZOlqcVcNF2ZcuDw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-299180d546bso457679a91.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885350; x=1710490150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1x1CbcWD8BgSBU1mwb3n5+g4oSkeRqdcwCFkah17Ko=;
 b=BQfacP8D537vSpYkz8S5tSP9q3Bi3RQehigmabnYTrh/a8U08G70ZWRyqksUShX0jC
 uXXeAkEGhVvel4L5Rx+T/8QQHU102QNG3DD+ncPgUPlxLf3WsFQGHNo77vuEdn5+Df1B
 Ztd4DYT0mDzZrMdYDw/xYe3XYgONUJ50gh3eNW/oTSO7rBUz7/ee04W7KQ8A/8lto13R
 TQYGIMolNJfCbDwEeAqdIWvbATTvilMO1I5xnY3rlc5+ydq82rGae50qmeWLSaBMg3fN
 fz5ZNBpDLNxhuGH7y2yFyEBiUu0dt51hXQldYozt/lDp/WlGFBz1rxG7/nQt0LRGt4Dn
 /P2w==
X-Gm-Message-State: AOJu0YwlDGxLe3v17ktrXcY/gr9sb+Q7KfjfzU2Q0nQ6o2hLUEcnOzwT
 inTYqXpG0HK7W+K7NFRkTXqylTcKrvcmlCssa9Qr2lQ/xKNLDYgGOzllpRRitdlGrAJrkmuDJLf
 NJTLsB/q6gD/fqduWfnudpDV1pRzeR4/aEYVQ5vb/UgrHQ3pz9Agc
X-Received: by 2002:a17:902:ead1:b0:1dc:e469:6f5d with SMTP id
 p17-20020a170902ead100b001dce4696f5dmr1414117pld.4.1709885350616; 
 Fri, 08 Mar 2024 00:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs/jZi4bD0C8jLuLgqGbWSyg5Vu6LCAInRwprsZ+Zix37Nk3dopBct9t5JAgWyNJNdCApwUw==
X-Received: by 2002:a17:902:ead1:b0:1dc:e469:6f5d with SMTP id
 p17-20020a170902ead100b001dce4696f5dmr1414100pld.4.1709885350219; 
 Fri, 08 Mar 2024 00:09:10 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 h15-20020a170902f54f00b001d974ffa1fcsm15801113plf.173.2024.03.08.00.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 00:09:09 -0800 (PST)
Date: Fri, 8 Mar 2024 16:08:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 11/25] migration: Add Error** argument to
 .save_setup() handler
Message-ID: <ZerHmmoZJyGZH0Fd@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-12-clg@redhat.com>
 <669aaa46-0ed8-46c8-9684-fc4ccc485d4d@yandex-team.ru>
 <38414ab8-7b29-478c-9fc6-09804cc17842@redhat.com>
 <8930276b-c87b-4afd-b4e0-489dcaccc4e8@yandex-team.ru>
 <Zeq6CP5IOxqfoq-r@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zeq6CP5IOxqfoq-r@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 08, 2024 at 03:11:04PM +0800, Peter Xu wrote:
> On Thu, Mar 07, 2024 at 02:39:31PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > I would be glad to have most of this series merged in QEMU 9.0. So,
> > > unless there is something major, I will keep that for followups.
> 
> Unfortunately I found this series won't apply to master.. starting from
> "migration: Always report an error in ram_save_setup()".  Perhaps forgot to
> pull before the repost?

Scratch this.  It's myself who forgot to pull... :-( It applies all fine.

> 
> It'll also be nice if we can get an ACK for the s390 patch from a
> maintainer.

I'll ping on the patch.

-- 
Peter Xu


