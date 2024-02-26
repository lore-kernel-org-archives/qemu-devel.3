Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E9DC54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 01:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rePpA-0003cp-9m; Sun, 25 Feb 2024 20:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rePp8-0003cZ-Ew
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 20:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rePp6-0005fI-FZ
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 20:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708911026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7oI6jky+EMal3JJCUROYhMsQNix/76ib3oBPptJk3Ac=;
 b=KbnbNq4vyTTX0+zb7BknckxjRJmpm+dm63tUlA5ZF5+z18RJxekZzz5DDdOLy0QVCdmjjM
 AT3O5RQo6/riQy8jOvHW8foflua8b18UQFBbyjjKVvBrhLA1Bopf+9J/2f6UjyT2AwfByt
 Toea3G+MU1nO7pGsNGVAJS0R+oYe9bA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-CVCGsdifOWGwQk_rI1DrsA-1; Sun, 25 Feb 2024 20:30:24 -0500
X-MC-Unique: CVCGsdifOWGwQk_rI1DrsA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-299180d546bso279891a91.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 17:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708911023; x=1709515823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oI6jky+EMal3JJCUROYhMsQNix/76ib3oBPptJk3Ac=;
 b=IWonIMTCchE2hoo687qfKLN+AfY1fWn6L/88Oxa1XrmtB31M69OloLlf1VumG6FSIK
 sR0pIPnZsajeC60w0AxavEycpZyNEBPEhhkuwhrhxqgltVipqyBND6lhTkKH88YUaS7R
 oCYjezJk5htZUNO8E1RmGVGVOpORgXMD0SUnzQepnbuRs3adOQZmpD81QGuAcvOpHDw8
 6U/xGxz9aHxtVPn5OuYGtvkE3RfbOCGvCpou6Suuo7urp22wnDDCk3sMZoJRE287vNat
 XWruR2C2I3cvHgNvy8+WT5AzlIS8Ic42N6DHlJv7rgn4rzSfD2wHHKPDigN7cgsvTJAr
 rfdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSVFAq7OuIdG5wRwqCqyikJrT8Ax9fjXiJRM1pUc9treF6Ul4uE2hGLPXXsZgjm5nfmMnAVvXSD1gdCHmXzeXGTSjwc0M=
X-Gm-Message-State: AOJu0YxhO0836UrU4YosrwGZIVYil6ASV8BtTjtECE5sRRvqlp47rChp
 3wk0H2Q+UhoZWO1j2oek8U8vApe1bT8COB3TTv2eqiY9m5WRwKHCK3/X00L75iVQLGnXnW8MnG+
 wcHVDjh7KdCzuAj7eKQPunHJL6sfwKQ1xO2bi4CugI34bHf8e3+wF
X-Received: by 2002:a17:903:1c5:b0:1dc:8790:67f4 with SMTP id
 e5-20020a17090301c500b001dc879067f4mr5022320plh.0.1708911023242; 
 Sun, 25 Feb 2024 17:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc5v5z3qAdTuu28rnsZCXXZ1gblePsHypSU/pmAFnbu3l430ziZhoBRew99R6W9OnIzRcDCQ==
X-Received: by 2002:a17:903:1c5:b0:1dc:8790:67f4 with SMTP id
 e5-20020a17090301c500b001dc879067f4mr5022295plh.0.1708911022806; 
 Sun, 25 Feb 2024 17:30:22 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e8-20020a170902744800b001d9a42f6183sm2741368plt.45.2024.02.25.17.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 17:30:22 -0800 (PST)
Date: Mon, 26 Feb 2024 09:30:12 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org, jdenemar@redhat.com
Subject: Re: [External] Re: [PATCH v2 3/7] migration/multifd: Zero page
 transmission on the multifd thread.
Message-ID: <ZdvppKlR1FHMwOl6@x1n>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com>
 <877cixbkc5.fsf@suse.de> <ZdgA-Wv9xlZbedD5@x1n>
 <CAAYibXiPEqFdypDwK2e=6D+A1O_Q3OLdakqjanT3PaPKgXtg2w@mail.gmail.com>
 <CAAYibXhA=U8mp5Mid30OvgGfSOD5Ly2ESKjc67sPsouO429Xeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAYibXhA=U8mp5Mid30OvgGfSOD5Ly2ESKjc67sPsouO429Xeg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Feb 24, 2024 at 02:56:15PM -0800, Hao Xiang wrote:
> > > > I don't think it's super clean to have three arrays offset, zero and
> > > > normal, all sized for the full packet size. It might be possible to just
> > > > carry a bitmap of non-zero pages along with pages->offset and operate on
> > > > that instead.
> > > >
> > > > What do you think?
> > > >
> > > > Peter, any ideas? Should we just leave this for another time?
> > >
> > > Yeah I think a bitmap should save quite a few fields indeed, it'll however
> > > make the latter iteration slightly harder by walking both (offset[],
> > > bitmap), process the page only if bitmap is set for the offset.
> > >
> > > IIUC we perhaps don't even need a bitmap?  AFAIU what we only need in
> > > Multifdpages_t is one extra field to mark "how many normal pages", aka,
> > > normal_num here (zero_num can be calculated from num-normal_num).  Then
> > > the zero page detection logic should do two things:
> > >
> > >   - Sort offset[] array so that it starts with normal pages, followed up by
> > >     zero pages
> > >
> > >   - Setup normal_num to be the number of normal pages
> > >
> > > Then we reduce 2 new arrays (normal[], zero[]) + 2 new fields (normal_num,
> > > zero_num) -> 1 new field (normal_num).  It'll also be trivial to fill the
> > > packet header later because offset[] is exactly that.
> > >
> > > Side note - I still think it's confusing to read this patch and previous
> > > patch separately.  Obviously previous patch introduced these new fields
> > > without justifying their values yet.  IMHO it'll be easier to review if you
> > > merge the two patches.
> >
> > Fabiano, thanks for catching this. I totally missed the backward
> > compatibility thing.
> > Peter, I will code the sorting and merge this patch with the previous one.
> >
> It turns out that we still need to add a "zero_pages" field in
> MultiFDPacket_t because the existing field "pages_alloc" is not the
> total number of pages in "offset". So source can set "zero_pages" from
> pages->num - pages->num_normal but "zero_pages" needs to be set in the
> packet.

Yes, one more field should be needed in MultiFDPacket_t.  Noet that what I
said above was about Multifdpages_t, not MultiFDPacket_t (which is the wire
protocol instead).  To support zero page offloading we should need one more
field for each.

IMHO MultiFDPacket_t.pages_alloc is redundant and actually not useful..
It's just that it existed in the wire protocol already so maybe we'd still
better keep it there..

-- 
Peter Xu


