Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9798ACCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 21:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6EyH-0004G7-0e; Tue, 07 Oct 2025 17:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6Ey3-0004Dc-Ot
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 17:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6Exz-0005k4-Tv
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 17:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759871484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+GSS1trU36/D4/Zoq85WcGdifWUdhkengsckR8fh4kk=;
 b=Nc/yIIepAWaW6fiYZ3nvQHudfLfnT+lbSoKRdWwVvCHkViKlw1x2GCeO3URIUrjTq2SEju
 9c6rWgw5OYro0q246yEDOhJkbxU5SH1ndCU+mL9LE9TvAaQfvq3F669FWNPmiLBdXf4pRZ
 F3CPY4U4Ht32SgZg8Gu8zqKjFsjo398=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-wVowgh2FOcCX55kG9liEyw-1; Tue, 07 Oct 2025 17:11:22 -0400
X-MC-Unique: wVowgh2FOcCX55kG9liEyw-1
X-Mimecast-MFC-AGG-ID: wVowgh2FOcCX55kG9liEyw_1759871482
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-87ae13cc97cso1049793985a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 14:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759871482; x=1760476282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GSS1trU36/D4/Zoq85WcGdifWUdhkengsckR8fh4kk=;
 b=CK/b1cNlxHW+Q01bAUPkL34DrKcdDW0oGHxun+ffBOy5oVHzEczhud0gYzcf+IWubP
 ZccKnjy6zzY8b+xRphL0/yVmgofplFzj9tn1J0RQvD0Vo4WmGl3PjHL5BfiEaXDZYY/R
 elItMH9XxOQqV9ZZXiWeCjtcRK/YSPgUiuqoOeAAvlPSvIgqlF1tjHu7b+w2G8YS4TN7
 YOqqpDT1auePlrEuy9Eh6LsC1774yP6CK/b3j8HZAuCZFrkz4cdYPVG6vQIUiu8QecnT
 te+01niMpQDpvkdVmfuG13PolZOUiiQzy0mS+ANwgZT+dQLEx+BDqN8X7piC67RB5hcb
 /E2A==
X-Gm-Message-State: AOJu0YzwSYsSfuJGGqkjeso3ehBndIip2/EX0yQet91bztXtW0DGxvCH
 r+IN+WHt1l9vCjs/CkFrTbm5elWzTlWqgC8oGm0L+GBTAAFhT8YmrY0WMDajZKOctbWbT+fuSBA
 B9pAH7O5iS4oLGaYUus4wI+puA8/C8RT9Qjj1Hx50PPxUqSMI8FyC0tT3
X-Gm-Gg: ASbGncsiN1ffgt8KsFMOEJuS3GFbu8Fdmgxto5F/W+MrSYcP2+HF5a3IhtCwJ/H0Exf
 NHJo+IohYK8jQUm1rT7C4awRXPNSZPthkMLXE0Vq2A7jfuIzw3scXe+MnCLAP5gcvNUgbcrjduE
 2KA9MCkVZP9m65CAzNl2lLyk1nkpdgFa254co+OVbsuCWZbgo/ipOVST0Q6gY8rcutcH5nf0Mkn
 JWek6jxUDL4MHBCnqZe8Xd78d5TbTixyR6GQ04jiSfFvVdQ6TGx/KedCX+L9kC938lJ5r6k5GHo
 G+w1h58vSjH1H/whTCIg4L4MCib808JW69YSTg==
X-Received: by 2002:a05:620a:258b:b0:864:4cb1:506e with SMTP id
 af79cd13be357-88350a7c297mr218324785a.35.1759871481968; 
 Tue, 07 Oct 2025 14:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFntRbkO4KmFlpEj/cnikxozBPCbqx+l5oVwj5qyVwXej6CMIiFjJ6mu4knsDTH+4KK8fUVxg==
X-Received: by 2002:a05:620a:258b:b0:864:4cb1:506e with SMTP id
 af79cd13be357-88350a7c297mr218319285a.35.1759871481355; 
 Tue, 07 Oct 2025 14:11:21 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8777837124esm1759624685a.34.2025.10.07.14.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 14:11:20 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:11:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: qemu-devel@nongnu.org, farosas@suse.de, ppandit@redhat.com,
 berrange@redhat.com
Subject: Re: [PATCH 3/3] migration: mapped-ram: handle zero pages
Message-ID: <aOWB9oxknXYjeY-i@x1.local>
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
 <20251001161823.2032399-4-Marco.Cavenati@eurecom.fr>
 <26083e-68de3c80-5f3-4691f480@28926673>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26083e-68de3c80-5f3-4691f480@28926673>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 02, 2025 at 10:49:45AM +0200, Marco Cavenati wrote:
> Please note that there are a couple of errors (swapped parameters), which are
> detailed below.
> I will address these in the next iteration, along with any additional changes
> based on your feedback.
> 
> Thank you
> Marco
> 
> On Wednesday, October 01, 2025 18:18 CEST, Marco Cavenati <Marco.Cavenati@eurecom.fr> wrote:
> 
> > Make mapped-ram compatible with loadvm snapshot restoring by explicitly
> > zeroing memory pages in this case.
> > Skip zeroing for -incoming and -loadvm migrations to preserve performance.
> > 
> > Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> > ---
> >  migration/ram.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 55 insertions(+), 1 deletion(-)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index e238c9233f..597d5ffe9e 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3958,12 +3958,55 @@ static size_t ram_load_multifd_pages(void *host_addr, size_t size,
> >      return size;
> >  }
> >  
> > +/**
> > + * handle_zero_mapped_ram: Zero out a range of RAM pages if required during
> > + * mapped-ram load
> > + *
> > + * Zeroing is only performed when restoring from a snapshot (HMP loadvm).
> > + * During incoming migration or -loadvm cli snapshot load, the function is a
> > + * no-op and returns true as in those cases the pages are already guaranteed to
> > + * be zeroed.
> > + *
> > + * Returns: true on success, false on error (with @errp set).
> > + * @from_bit_idx: Starting index relative to the map of the page (inclusive)
> > + * @to_bit_idx:   Ending index relative to the map of the page (exclusive)
> > + */
> > +static bool handle_zero_mapped_ram(RAMBlock *block, unsigned long from_bit_idx,
> > +                                   unsigned long to_bit_idx, Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    ram_addr_t offset;
> > +    size_t size;
> > +    void *host;
> > +
> > +    if (runstate_check(RUN_STATE_INMIGRATE) ||
> > +        runstate_check(RUN_STATE_PRELAUNCH)) {

Should we check RUN_STATE_RESTORE_VM directly here?

I think it's still good to spell out the rest, we could put it in a
comment, e.g.:

  /*
   * Zeroing is not needed for either -loadvm (RUN_STATE_PRELAUNCH), or
   * -incoming (RUN_STATE_INMIGRATE).
   */

> > +        return true;
> > +    }
> > +
> > +    if (from_bit_idx == to_bit_idx) {

Might be safer to check >= rather than ==.

> > +        return true;
> > +    }
> > +
> > +    size = TARGET_PAGE_SIZE * (to_bit_idx - from_bit_idx);
> > +    offset = from_bit_idx << TARGET_PAGE_BITS;
> > +    host = host_from_ram_block_offset(block, offset);
> > +    if (!host) {
> > +        error_setg(errp, "zero page outside of ramblock %s range",
> > +                   block->idstr);
> > +        return false;
> > +    }
> > +    ram_handle_zero(host, size);
> > +
> > +    return true;
> > +}
> > +
> >  static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
> >                                       long num_pages, unsigned long *bitmap,
> >                                       Error **errp)
> >  {
> >      ERRP_GUARD();
> > -    unsigned long set_bit_idx, clear_bit_idx;
> > +    unsigned long set_bit_idx, clear_bit_idx = 0;
> >      ram_addr_t offset;
> >      void *host;
> >      size_t read, unread, size;
> > @@ -3972,6 +4015,12 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
> >           set_bit_idx < num_pages;
> >           set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
> >  
> > +        /* Zero pages */
> > +        if (!handle_zero_mapped_ram(block, set_bit_idx, clear_bit_idx, errp)) {
> 
> This should be
> +         if (!handle_zero_mapped_ram(block, clear_bit_idx, set_bit_idx, errp)) {
> 
> > +            return false;
> > +        }
> > +
> > +        /* Non-zero pages */
> >          clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
> >  
> >          unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
> > @@ -4003,6 +4052,11 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
> >          }
> >      }
> >  
> > +    /* Handle trailing 0 pages */
> > +    if (!handle_zero_mapped_ram(block, num_pages, clear_bit_idx, errp)) {
> 
> This should be
> +    if (!handle_zero_mapped_ram(block, clear_bit_idx, num_pages, errp)) {

The rest looks all good.

I can queue patch 2 now, which is trivial.  Please repost patch 1+3 after
rebasing to Fabiano's patch here:

https://lore.kernel.org/r/20251007184213.5990-1-farosas@suse.de

Then in patch 3 you can remove the MAPPED_RAM cap in the list.

Fabiano could also be posting some test patches too that he got for
snapshots.  You can either respin before that, or wait for it (then you can
also add a mapped-ram test for snapshots).

Thanks,

-- 
Peter Xu


