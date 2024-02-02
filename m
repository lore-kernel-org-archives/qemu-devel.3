Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D55C48286
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 00:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVhZg-000168-0S; Thu, 01 Feb 2024 19:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVhZd-00012S-Ax
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVhZb-0002xc-9D
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706834306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0wMM8C0tBNtvMw3veEu1vPwyvlHBw3bpN0EPmwg1B4M=;
 b=BcexyKPJ3VSgh8Fn9w1vK6KRk76Y+ZL6iePqXL3oRt9mXjp0SHLXmxwjHJZr6+9v9aTLer
 mqrNNZ6x/s1erI/BhwVIN880TyHxFdi23EuPQDBr0VZlzUaaT2xSXg83ZOMuDwH3vqI0Qt
 jXiyXPHzhMzqZ3LYlKtHsTAWarlotus=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-V_Ba29dEOxq6fbmYITWRWw-1; Thu, 01 Feb 2024 19:38:25 -0500
X-MC-Unique: V_Ba29dEOxq6fbmYITWRWw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2961fca4282so204533a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 16:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706834304; x=1707439104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wMM8C0tBNtvMw3veEu1vPwyvlHBw3bpN0EPmwg1B4M=;
 b=uS8gAfEYykUsArYybF9sMxs+Ot6kXRmAkkydN8HId31/NnfiXYvRx8mme63rKz/6gE
 8UbKRJTiiaAiqOQdMLqwv03UTkZcBw2vvnSYKjvDmYA0R8cpV/EtEa4xBHFc9YuA0J0K
 5oLU9nIwskAiLfAIYPuIuLbljBRJYJOvTQpx0gO+qtnd7v3sBfjKYN0X+kjw31KUQW75
 iIM4+Dii03uWVu7MRV2gMYw+sxvUb/ZBV6JjWDzQE2/OQXAkh2ZUEdrprmiZSaHrFJx3
 +sFyIiYjxd5fc3oPtDcqKsquNEtyQ2928YdjqjYuhhzNNmpzlzw33Yv2tJb+MOouYVJV
 QXTA==
X-Gm-Message-State: AOJu0Yzy92xBtv4YhIWgOIKyorwU12E6wU6sH2m6Ay0LwxzqJGkYlKLg
 1v1YJEdlN6MoeOtEsmqiiXp6YWilz9NXv1yiPi0JInrssuF5uSVi/802aQLK1EHD8kofoGnMKat
 sniTHMvq7C7NZxDZHVRsemPdJuAbvyfKoERf7jlMnjRTlQvPdUd33
X-Received: by 2002:a17:90a:5987:b0:295:d792:1ef1 with SMTP id
 l7-20020a17090a598700b00295d7921ef1mr6587777pji.0.1706834304200; 
 Thu, 01 Feb 2024 16:38:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExMVP7ztBnMPE9n59irdHbVIkz6I/KZkarCbtY0e5b/gRHELTDj9Ls1z01g5kVkK8nn0iivA==
X-Received: by 2002:a17:90a:5987:b0:295:d792:1ef1 with SMTP id
 l7-20020a17090a598700b00295d7921ef1mr6587771pji.0.1706834303891; 
 Thu, 01 Feb 2024 16:38:23 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVmqc+uNvMXQ34jfst0IwDE7l+J2tqqyVAVWFMXoXRIz+dhL93zcQ8GeIoKfqPeBK8ploQWQ2dc7Z6YQkopLO9NuSG9QWo6+rXzBq/Dy/7oz94BVNw2k3hlwzeEW6hyTWXCigYZtdp2rNHSEq0Vmhq375x+LQaYUBODn+mGTnNFjCSsxcUQkU5CayP42QnixgMvP2pNM9RakfrQHJ4dZN8=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 gb23-20020a17090b061700b00295f9a4a338sm3296215pjb.36.2024.02.01.16.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 16:38:23 -0800 (PST)
Date: Fri, 2 Feb 2024 08:37:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 04/14] migration/multifd: Postpone reset of MultiFDPages_t
Message-ID: <Zbw5TpO5xOgMSmB5@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-5-peterx@redhat.com>
 <87wmrpjzew.fsf@suse.de> <ZbtsCsBFuMj1fx-q@x1n>
 <87plxgi51k.fsf@suse.de> <Zbw3P26zfARNBsBy@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zbw3P26zfARNBsBy@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Fri, Feb 02, 2024 at 08:28:47AM +0800, Peter Xu wrote:
> > Pages allocated is nonsense. See if you agree with its removal:
> > https://gitlab.com/farosas/qemu/-/commit/7cfff1a3e31b271e901a6c08d8b5d8c01b680e4d
> > 
> > ---
> > From 7cfff1a3e31b271e901a6c08d8b5d8c01b680e4d Mon Sep 17 00:00:00 2001
> > From: Fabiano Rosas <farosas@suse.de>
> > Date: Tue, 24 Oct 2023 19:03:41 -0300
> > Subject: [PATCH] multifd: Remove MultiFDPage_t:allocated
> > 
> > When dealing with RAM, having a field called 'allocated' is
> > confusing. This field simply holds number of pages that fit in a
> > multifd packet.
> > 
> > Since it is a constant dependent on the size of the multifd packet,
> > remove it and instead use the page size and MULTIFD_PACKET_SIZE
> > directly.
> > 
> > This is another step in the direction of having no mentions of 'page'
> > in the multifd send thread.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/multifd.c | 6 ++----
> >  migration/multifd.h | 2 --
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index bdefce27706..83fb2caab04 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -241,7 +241,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
> >  {
> >      MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
> >  
> > -    pages->allocated = n;
> >      pages->offset = g_new0(ram_addr_t, n);
> >      pages->page_size = qemu_target_page_size();
> >  
> > @@ -251,7 +250,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
> >  static void multifd_pages_clear(MultiFDPages_t *pages)
> >  {
> >      pages->num = 0;
> > -    pages->allocated = 0;
> >      pages->block = NULL;
> >      g_free(pages->offset);
> >      pages->offset = NULL;
> > @@ -264,7 +262,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
> >      int i;
> >  
> >      packet->flags = cpu_to_be32(p->flags);
> > -    packet->pages_alloc = cpu_to_be32(p->pages->allocated);
> > +    packet->pages_alloc = cpu_to_be32(MULTIFD_PACKET_SIZE / p->pages->page_size);
> >      packet->normal_pages = cpu_to_be32(p->pages->num);
> >      packet->next_packet_size = cpu_to_be32(p->next_packet_size);
> >      packet->packet_num = cpu_to_be64(p->packet_num);
> > @@ -451,7 +449,7 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> >          pages->offset[pages->num] = offset;
> >          pages->num++;
> >  
> > -        if (pages->num < pages->allocated) {
> > +        if (pages->num * pages->page_size < MULTIFD_PACKET_SIZE) {
> >              return 1;
> >          }
> >      } else {
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 655f8d5eeb4..d1342296d63 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -56,8 +56,6 @@ typedef struct {
> >  typedef struct {
> >      /* number of used pages */
> >      uint32_t num;
> > -    /* number of allocated pages */
> > -    uint32_t allocated;
> >      /* guest page size */
> >      uint32_t page_size;
> >      /* offset of each page */
> > -- 
> 
> I agree.
> 
> Even if we would like to add a parameter to setup the allcated size (I
> remember one of the accelerator series has it), it'll still be a global
> variable rather than per-pages thing.
> 
> I can cherry pick this and post together; will need a rebase but I can do
> that.

I see a slight step back here when rebase, since we'll calculate n_pages
every time to enqueue the page:

static inline bool multifd_queue_full(MultiFDPages_t *pages)
{
    return pages->num == (MULTIFD_PACKET_SIZE / pages->page_size);
}

The "allocated" is still good to cache the value.  Fabiano, would it make
sense we still use a global var (perhaps in multifd_save_state?) to cache
this?

I'll leave this alone as of now I think, but again I agree we should have
something similar.

-- 
Peter Xu


