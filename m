Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B006606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7R4pWBB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JRw8inrQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBCN-0004qh-Vd; Thu, 19 Nov 2026 18:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUBCM-0004qW-8O
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUBCJ-0005C6-Qv
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795129542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQ/6T3Im9ThdvoO2EpFueN8A+z+EPRmTVYbBbY8uxS8=;
 b=e7R4pWBBUiJQsqvfASH1GarKO6iSvypvFuEIBJKCiZw6zsJm/dCMrAvYAutwpRPcMUZ+8O
 iqN9gzBGVkLOCA76gRF09Z1bR/hJFCfoV2oD8ozKQnycWiXeGZmeIfdcZksHM609UrsfFG
 lt2YTK6OAA5IrKl4iqnBuLs6H50OSfM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-o4gn6r3KMW-v3mLmGAoaNA-1; Thu, 19 Nov 2026 23:05:40 +0000
X-MC-Unique: o4gn6r3KMW-v3mLmGAoaNA-1
X-Mimecast-MFC-AGG-ID: o4gn6r3KMW-v3mLmGAoaNA_1795129540
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2c0e6653so62902185a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795129540; x=1795734340; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rQ/6T3Im9ThdvoO2EpFueN8A+z+EPRmTVYbBbY8uxS8=;
 b=JRw8inrQ+HDsjz6RV91Mw4/qYYKHeLFMncC9vnncBTvBZsSkcfPmIxbAdX8evwdtCO
 KmnwLV5OgiYZVOJ7BPnUMSAxDoPVV9+y/pEAYfSrBnmzrLUG2WjYolc279kFQFXlX8Qy
 bBe2IBwL8yQxm5DgVkDMtTQfthT1dzSNS2M2QfbjJIXgOf/HxTgPWEgdn6zkwHAV5Rl/
 yLD9P4aqmJhgJjlSNSDr+j1L6LogCBC+/htaUUiXUUy59nKy5qRf1Dv6iH/CsE7+n8yr
 oPQStVzUZe8bKqzIycn5YCdiDm7l+Me+qLltd6xB+EJQwdIIH3SvppH1TiJAgbD5hZlY
 tGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795129540; x=1795734340;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQ/6T3Im9ThdvoO2EpFueN8A+z+EPRmTVYbBbY8uxS8=;
 b=pF0Q7rJsDtNOe+nNGjKmzJnXFYJXRGvAmi7+0W8an3+ZxOBx0jABMh6UAWUsXsQrv+
 XnmA95cBuk5QXpg8WEXoxXcFR8vhZa9Mdi2Lirm0CJkcrkQWp36C72BusvOyfTSA82jl
 BCacHYDJcHpFtC8/1yeET21qQWoaxHW//qfvJ0EVj+UB36tKByaGImARvRCByiF0YBA9
 Q2gQnQeXLcd39x/OiYNCYt4eWrPpHA2wr84MP+Ci+d+GH3QZGG/tSdeFs3vfo4By+pxI
 TaI2tAjGZLquY7YIPaLqKupwy3CVIErqUGzwd9iVmwIHO7h3P0MwumIy0L8+Rp+AURrz
 dDrA==
X-Gm-Message-State: APuU4Z8miM70G2PZ9e/ggLHLQD6zNwQK5oY82sKVhHe6dx3xqZzIAW0Z
 QwZQIyAiNHsQKiHocRC50i2vbWDtMPdlqPbvE0eePW95D7Akb1vqdHFPXFjSsglX6tmv5sKeE42
 WfjBNBG0eevLzueU88wRkk18CkgUDR+iDhqdebduQClDYoItQmbughBhT
X-Gm-Gg: AYBFou2nk8Hdn/TpK3j7MnuE0U8WzXNF198u97idQQVqFe7ap1t42FwfW5jS+SgtmkZ
 bDi44zHy1of56aswVDu4oWsplxBGyUSvc5JblD5dBkllQr1E1bBacGGp10lrTS8/npyzhRPVUVy
 ILCuvaZICl8fkOoVQwqlyYWT8KzEMU0UtuV8I2ZBj/5Ma5zK6eXzhYHj9AUie2P7Ps6ped4PeBR
 ZHGhPUep1e7BMb88okaZ23fW5SSBFN2MxoHLm1eEtUSXe79hV3M3jM0x3yCT3YaBuWRSSIa4S3t
 Ety148q4BXYnuVf2J1l0Xwb8AFSqJWILYLqfzbrpmHHVUOOkz19Q6fnEo1VSWzdtG51lzDSKupY
 CNRuWIO3ynSR/LSHbSSneF8+DS6TQfb1FXW8a7wx8AtkR
X-Received: by 2002:a05:620a:130f:b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-949bab20007mr197862685a.44.1795129539533; 
 Thu, 19 Nov 2026 15:05:39 -0800 (PST)
X-Received: by 2002:a05:620a:130f:b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-949bab20007mr197856185a.44.1795129538915; 
 Thu, 19 Nov 2026 15:05:38 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3bec3dsm65860785a.23.2026.11.19.15.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 15:05:38 -0800 (PST)
Date: Thu, 19 Nov 2026 18:05:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <av-AweS887ZVL9HO@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261119145311.1144878-1-peterx@redhat.com>
 <20261119222936.GB780462@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119222936.GB780462@shajnocz.csb>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 05:29:36PM -0500, Stefan Hajnoczi wrote:
> On Thu, Nov 19, 2026 at 09:53:11AM -0500, Peter Xu wrote:
> > Hongyan reported a possible use-after-free of RDMA migration code:
> > 
> > https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> > 
> > The issue seems real, while this patch is a proposal to fix it in a simpler
> > way, meanwhile it should be a problem to the yield_until_fd_readable()
> > helper in general, so it should make more sense to be fixed there too.
> > 
> > The problem is about the use of the stack allocated FDYieldUntilData where
> > we must make sure after yield_until_fd_readable() returns it's not used
> > anywhere.  If the coroutine yielded can be entered from outside of this
> > helper (fd_coroutine_enter()), then the aio handler might be installed even
> > after yield_until_fd_readable() returns, and that makes the stack variable
> > accessible by aio codd, even if stack gone.
> > 
> > Fix it by moving the aio handler removal outside the handler.
> > 
> > Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > Cc: Hongyan Xu <getshell@seu.edu.cn>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > NOTE: I targeted this for 12.0 because the bug was not introduced in 11.2,
> > however this seems to be a real bug fix to coroutine in general, I'll leave
> > that to maintainers to decide if to pick it for 11.2.
> > ---
> >  util/qemu-coroutine-io.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
> > index 364f4d5abf..3c0a7feafa 100644
> > --- a/util/qemu-coroutine-io.c
> > +++ b/util/qemu-coroutine-io.c
> > @@ -74,7 +74,6 @@ typedef struct {
> >  static void fd_coroutine_enter(void *opaque)
> >  {
> >      FDYieldUntilData *data = opaque;
> > -    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
> >      qemu_coroutine_enter(data->co);
> >  }
> >  
> > @@ -89,4 +88,9 @@ void coroutine_fn yield_until_fd_readable(int fd)
> >      aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> >                         &data);
> >      qemu_coroutine_yield();
> > +    /*
> > +     * Always remove the fd handler, no matter the re-entering of this
> > +     * coroutine was caused by fd_coroutine_enter() or something else.
> > +     */
> > +    aio_set_fd_handler(data.ctx, fd, NULL, NULL, NULL, NULL, NULL);
> >  }
> 
> Why would the coroutine be entered?

In case of RDMA, rdma_cm_poll_handler() could receive a disconnect event on
another management fd, then it knows the link is down, hence it needs to
kickoff this coroutine to quit.  See 923709896b1.

> Should there be a loop around
> qemu_coroutine_yield() - otherwise we fix the invalid stack memory
> access but return to the caller without fulfilling the purpose of the
> function (waiting for the fd to become readable), which could cause
> further bugs?

I feel like these are two separate things.

IMO fixing reset of aio handler should be a pure positive fix, because not
fixing it doesn't stop user from re-entering of the coroutine and bypass
fd_coroutine_enter().

My understanding is the caller should have full control of this: when the
caller requires "fd must be readable", it should always wait until
fd_coroutine_enter() returns.  This patch should have no functional
difference.

But it seems still legal if the caller is benign and can properly handle
the case even if fd is still not readable.  In this case, this patch fixes
a real issue.

In case of RDMA migration, only the quit path can cause it to re-enter, so
either there is IO or we need to quit.  RDMA code works well with either
event, it can even loop back and wait on the fd again, but since quit is
the only path kicking this off, it's also not possible even if the caller
handles this.

Thanks,

-- 
Peter Xu


