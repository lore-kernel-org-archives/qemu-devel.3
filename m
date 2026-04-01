Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A31BD3517F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w81jp-000186-BL; Wed, 01 Apr 2026 16:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w81je-000174-GX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:00:18 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w81jc-0007yQ-Ow
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:00:18 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so55943a91.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775073615; x=1775678415; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GyTHQFti4ePurXzdbSKxukkbDfIx3wTcIViU8SobReE=;
 b=BvGiA1+kAwAp4cVY9ZVfQAMulIliGgHm5tleXH7Hq0eqslxn0Gi3BfvlNayc70xY18
 WBLM3Mxh1wZmkO5O+7KHO2QbNmltZuteBwOHoPrDVUItlHPVl8APmMDi57n+tnYg/B/e
 6/aPhkaPnwWEZIuPlH6w1C8EV2/6By7Y//xvlioLpgPEyW3U6fdIpVJBbbWx+ofvlj6/
 4Jnrn7IqoELVRFGVWvUrI6TAyncQBfFgbhggT502pWLQAP1yW/uNnAhkfF+1fyGaYzt3
 tXT+OyLRjOYMxk+zjIDkP+bxFKFHpcCu+YKFDy9sF48+CeYnbXKuZE0UFJU2jfDA6EPy
 l3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775073615; x=1775678415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyTHQFti4ePurXzdbSKxukkbDfIx3wTcIViU8SobReE=;
 b=cDe7upMwNl1Ukb9V7FW342EkASUc6NURxs5UW+PvuVJZmoV2rJzZB+6M7Cmy0/e7y6
 Ofu5anI0rzKf7x8m0BE6LrcLWhTHYThYbnAPZTL1n37zOYU/+7Qy94z/56cADpICs7Rd
 4r/Q43kPRByYQmw0M9fjc9wpIido75esEMblg62t2YhYlcnTnR0BhF97lwhK7GC40N72
 KmkgEvyKwfHm3c7o9dQsTCs5SESkcpBN7IdoFRWMgt4Gdn8W/jHhXGmFlfa2p4jrq7RI
 jLQn5X2r+tXVdRJYP0GEHlRxRufpq0UbLDpq1qvcWMFEPhInFAiwkJIT3AZdpkP+T7hJ
 tIiQ==
X-Gm-Message-State: AOJu0Yz+8NnDyGe8i+vFNZZqhKAkhETV4w3tbCSflMk6AtnNf16BjyCC
 Q3cWW0xfvqu+2nJ8byRnIv8sF2WtUYB5W79RjCIjtIqdCI+ukM4EOra+
X-Gm-Gg: ATEYQzyYIiS8VcAj9LEd60+uZoBGnASG7iup9mOH+0uim/X7lc3Ym6zVbEl/oOu/UtW
 YFdvcLTgsXe5gBA/XM2+GnrBkAxn7eEs2Nw6XBaap6pZWCSTbLfFgXO/gUr1ce15GgVQyt6SJHb
 mLX/KmBhW3kCEVSizuDJoXvkByhVPW2nzZp3WgpeYGQ3qdEGy4mw8NMu6HbWC0fA/gv8BhLrZxJ
 o+hERvn4jzo7QMPzgqiloZnt0szd6HR6iGMpVjW7gVg9hUgHlPTL23rDZXUJaeS0urOqeOAdw6u
 3FYZuY9m/uFnIDqgFqBNQQ+3G8qv1tswaRzLvCaWRMOSQhUQzzirIL+ZHXJ+DeZMrQ+tILrbC6j
 sC1wBtyyAlcuLBy87mDHSp4VGyV0vlx54OflxZJN/1F164qVvSGdHMZ97py0gRrqmxptye0xOet
 vuuJwWk+DMbSN+MqlwN5Z71SH6MdJ5m34=
X-Received: by 2002:a05:6a20:3c8e:b0:398:7866:e8e8 with SMTP id
 adf61e73a8af0-39ef76b414fmr5104227637.31.1775073614432; 
 Wed, 01 Apr 2026 13:00:14 -0700 (PDT)
Received: from localhost ([42.118.191.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c647792bsm728105a12.6.2026.04.01.13.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:00:14 -0700 (PDT)
Date: Thu, 2 Apr 2026 03:00:10 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: validate page_size in mapped-ram header
 before use
Message-ID: <dptqcdl44iimicz77wt4mhnlgrr2duzz6ipuwanij5xiaugxeq@ipzhxzz6kr3e>
References: <20260328072424.10611-1-vikingtc4@gmail.com>
 <acqzOqkSC3oXSznV@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqzOqkSC3oXSznV@x1.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 30, 2026 at 01:30:34PM -0400, Peter Xu wrote:
> On Sat, Mar 28, 2026 at 04:24:24PM +0900, Trieu Huynh wrote:
> > mapped_ram_read_header() reads page_size from the migration stream and
> > stores it in MappedRamHeader, but does not validate that the value is
> > non-zero before it is later used in parse_ramblock_mapped_ram():
> > 
> > num_pages = length / header.page_size;
> > 
> > If a corrupted or malformed migration stream provides page_size = 0,
> > QEMU unexpectedly crashes.
> > 
> > Add validation in mapped_ram_read_header() to reject zero page_size
> > values early and return an error instead of continuing with an invalid
> > header.
> > 
> > Steps to reproduce:
> > 
> > Create a migration snapshot with mapped-ram enabled:
> > (qemu) migrate_set_capability mapped-ram on
> > (qemu) migrate file:/tmp/qemu-snapshots/snapshot.bin
> > Modify the snapshot so that MappedRamHeader.page_size becomes 0.
> > Restore the snapshot:
> > (qemu) migrate_set_capability mapped-ram on
> > (qemu) migrate_incoming file:/tmp/qemu-bug-test/snapshot.bin
> > 
> > As-is: qemu crashes immediately
> > (qemu) Floating point exception (core dumped)
> > To-be: qemu continue running
> > (qemu) qemu-system-x86_64: Migration mapped-ram header has invalid
> > page_size of 0
> > 
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  migration/ram.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 979751f61b..2a7e958e87 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3088,6 +3088,11 @@ static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
> >      }
> >  
> >      header->page_size = be64_to_cpu(header->page_size);
> > +    if (header->page_size == 0) {
> > +        error_setg(errp, "Migration mapped-ram header has invalid "
> > +                   "page_size of 0");
> > +        return false;
> > +    }
> 
> Thanks for the patch.
> 
> When at this, one more thing we could do is verify the value is exactly
> target psize; afaict that's the assumption across the whole mapped-ram
> feature.
> 
ack, will add it in v2. Thank you.
> >      header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
> >      header->pages_offset = be64_to_cpu(header->pages_offset);
> >  
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Peter Xu
> 

