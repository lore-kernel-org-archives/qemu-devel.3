Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1257C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbgG3-0003A4-Dr; Wed, 07 Aug 2024 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sbgFz-00037l-H6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sbgFx-0007V9-EH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723035547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bDWLD1uoFm7FU5a42zOehUthTej1cJGlhkJadGWn0/A=;
 b=ccnAtm2mukip9su2zRU0RNsrxklUCOuTMO5WOygseJpyah8/UVADuXZraTxkNhs94jzc4b
 KUO4Gt++lWkb+N/CVmR/FUjdYHd7LD96TgrKjic+LqteoS0cKqOKWl+rF8G6N7VyITJH8U
 N2jQXtp9HASivu/gROtiRAQVbUtRbJk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-oTXE60xINp2m61wvWFiAtg-1; Wed, 07 Aug 2024 08:59:06 -0400
X-MC-Unique: oTXE60xINp2m61wvWFiAtg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-709376e8668so348002a34.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723035545; x=1723640345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDWLD1uoFm7FU5a42zOehUthTej1cJGlhkJadGWn0/A=;
 b=W43hHrzzlgkBha32Jf3pKlQ41kqLrf67GNP+Iq+p+zTmI6ZcJex9OQ7/cVq8Yl1J2Y
 Wfl8CsCgaaDx0KrmcZWD0BbFvyjWGnJm/Jvo5j1366APy0D82atIKVSlQBPPF5IWdr3I
 PK/Kk0Arkp2+xG0XUZJlGctd/suHm1czoJEUhLRUUjvPbsYXRo8/CfrEoq32Pu8glXqM
 io2BIaXl5XQAf69reNaJbBlkEAUGJL4JKAkFmXLnuhq+wZ7SI/hztOB8OCFDmljSlmSm
 BiQL7P9mfoN7buJBeWbpgIwmHCilggE40IRHOxQDjAxtx3t4iT6q8KeOye7Kh/jUK8jD
 qx2w==
X-Gm-Message-State: AOJu0Yw4eoSR93R3R5gRBmx8ZfERXbcoWVoe6QU1AabU/PDJ3JM9qqzp
 kSLv6nxSfBsSMab1mVN+gqzIvLao+s8bnBs5/VvlCYr+zSBNKwfESKx/uUQ8ZEvNpUXgcS8EoGX
 qN2qilsl+No2fsDxeKXHC4oT8drjpZepptDmlMX86BkiS9NU0h22w
X-Received: by 2002:a05:6830:f81:b0:704:4987:2342 with SMTP id
 46e09a7af769-709b995bb2cmr12614786a34.3.1723035545456; 
 Wed, 07 Aug 2024 05:59:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkYBRrcm2vNjDLIsSVEeRueSKKdHKny09yM832oRTYEBVUqlVjh4DvrCcJnJTBbcxqUN/6g==
X-Received: by 2002:a05:6830:f81:b0:704:4987:2342 with SMTP id
 46e09a7af769-709b995bb2cmr12614773a34.3.1723035545073; 
 Wed, 07 Aug 2024 05:59:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c86b6f8sm56435056d6.123.2024.08.07.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 05:59:04 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:59:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Refine the convergence detection
Message-ID: <ZrNvltexbLK8yxTm@x1n>
References: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
 <ZqlGjaleFHdnJUZy@x1n>
 <CAK9dgmbkKPDTYv0i1jpASgTR5iN+_4+DrZUxo5VxQF3NdZewaQ@mail.gmail.com>
 <ZrJTDhyRdjEL9VTV@x1n>
 <CAK9dgmYcW7C9i+KGMH1pN_QRWy_A1ZGXixi49Unt6VhaP6DVzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK9dgmYcW7C9i+KGMH1pN_QRWy_A1ZGXixi49Unt6VhaP6DVzw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 07, 2024 at 02:46:29PM +0800, Yong Huang wrote:
> I still think dropping the dirty_rate_high_cnt is a refinement. If migration
> has a precise detection of convergence, what do you think of it?

Maybe; I don't think I thought through those yet..  If so that'll make
sense to be based on the sync change first, then we can have a parameter
(doesn't sound like a cap on its own) for keeping the old auto-converge,
and pile new logics there.

Thanks,

-- 
Peter Xu


