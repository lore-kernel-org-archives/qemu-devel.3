Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E5FC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 02:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXuVp-0001uY-D0; Wed, 07 Feb 2024 21:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuVn-0001u5-Qn
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 21:51:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuVk-0001xg-If
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 21:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707360695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoWqfZIV4x9mMS2BBLyxp5HCz4NSc3Kur1VBSieijAo=;
 b=MF/SHY6p0MdouJ/rug3TeD1sGSXcUG6FxeWed9TUMIc63mkwXNeGfT2y6yPKlAKTskx4gK
 fDe+ivocGB8d3ICa+aNS6YUsm8xf+4Qx+eqbs9xKQQUjXkRVx6nWiKpPd+qk7xw5nbvkPA
 qaKWz7qdjnIhMOvAQ2IYj5LlyBY5gKs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Aj65iThJNsC-tdz-QOkw_Q-1; Wed, 07 Feb 2024 21:51:33 -0500
X-MC-Unique: Aj65iThJNsC-tdz-QOkw_Q-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d9f83b7857so880695ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 18:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707360692; x=1707965492;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xoWqfZIV4x9mMS2BBLyxp5HCz4NSc3Kur1VBSieijAo=;
 b=rohBq8xztewLcaepQz15QCzUEa6w62g5/kM2p1RW7WRoTSkWOQpurpOQ92ckb4euyg
 VmbuLAD4LyTjAlD75DUU55YS87dvvtSAELBkzYY4IS9Ooau+VITO7ygdB5+zxjPIJcIR
 Pc3YA+ZqZWIDZS9G1+QspPuMEHiI63vzxul5iTDYl3JbyGvGNwm0UAwYCW/m8w9nHHhd
 AI8YfrLq3HlgRrP1KRbF282FxrLR4xJfRxaNGY3R/Gr/noonTV8cPlpcvLGOHBENP6Hf
 Rjv92OgQ7btM3Uabli9XpstphfdYH4qsEbmi5bdSlNIqKpf6qxuGNf7pHP8cHi4LnWXr
 o6ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCpiNedSS9NJ2WaNvI0+HU9gGLr8Z/Ne4V+67J0RZMrXj1UYRp1vcJjd+ktpfz4W820mwwjzhIsMDuwThd53EXIP0bPLM=
X-Gm-Message-State: AOJu0YwKwsPFuI85cBNDMtjmYx2QPC0EBtRqO5c2cZlqE7xZ5PVQAHfO
 VaTTLlqfmvM28CU1AQRbprqECGO5tHcr3PaFxdX4xyVrlhXz8pvO1GWtTI6MqKTRLbciLKztCRD
 R/WlbCNZAmZiuimDFj7wfUmxWfzM0gbTVMtTC3sqNNtdNhmP81IAFmpZLtcP40Q8=
X-Received: by 2002:a17:902:d505:b0:1d7:1480:6538 with SMTP id
 b5-20020a170902d50500b001d714806538mr8222592plg.1.1707360691842; 
 Wed, 07 Feb 2024 18:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiBPH2Nc7t/VuKzajR+hhjXN2iO9aI25XTYX7RrZXIurgShFFn4d8fz7rAgWgcdjlW7G1P3w==
X-Received: by 2002:a17:902:d505:b0:1d7:1480:6538 with SMTP id
 b5-20020a170902d50500b001d714806538mr8222579plg.1.1707360691458; 
 Wed, 07 Feb 2024 18:51:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUEyJtanm2UkYdbdhymsyY7ge+U9hP3ia0Qk0CZrNqyOfZ+JF0UMYxR3hwIda8/7epCZkqWvFqW/nb7kZg35zpghJqzBM1pg+pePkBcZizaJbO+KGmlQg==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 b18-20020a170902d51200b001d70af5be17sm2178782plg.229.2024.02.07.18.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 18:51:31 -0800 (PST)
Date: Thu, 8 Feb 2024 10:51:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [External] Re: Re: [PATCH 2/6] migration/multifd: Add zero pages
 and zero bytes counter to migration status interface.
Message-ID: <ZcRBrmTfxQixTeaJ@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-3-hao.xiang@bytedance.com>
 <ZcMDVpLilA-PZ3he@x1n> <ZcMI-wPq94x6cO2Z@x1n>
 <qhvli57ctzn3cyt2fwppmcauhmlrqoz7ubljxswx7ghroshop2@kmiaukhnvfko>
 <CAAYibXi3BUxjg+b1ZXiT_AnnV5LkAN11G-UZc6bZQr4sFz5uzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYibXi3BUxjg+b1ZXiT_AnnV5LkAN11G-UZc6bZQr4sFz5uzw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 07, 2024 at 03:44:18PM -0800, Hao Xiang wrote:
> On Wed, Feb 7, 2024 at 12:41 AM Jiri Denemark <jdenemar@redhat.com> wrote:
> >
> > On Wed, Feb 07, 2024 at 12:37:15 +0800, Peter Xu wrote:
> > > On Wed, Feb 07, 2024 at 12:13:10PM +0800, Peter Xu wrote:
> > > > On Tue, Feb 06, 2024 at 11:19:04PM +0000, Hao Xiang wrote:
> > > > > This change extends the MigrationStatus interface to track zero pages
> > > > > and zero bytes counter.
> > > > >
> > > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > >
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > >
> > > I'll need to scratch this, sorry..
> > >
> > > The issue is I forgot we have "duplicate" which is exactly "zero
> > > page"s.. See:
> > >
> > >     info->ram->duplicate = stat64_get(&mig_stats.zero_pages);
> > >
> > > If you think the name too confusing and want a replacement, maybe it's fine
> > > and maybe we can do that.  Then we can keep this zero page counter
> > > introduced, reporting the same value as duplicates, then with a follow up
> > > patch to deprecate "duplicate" parameter.  See an exmaple on how to
> > > deprecate in 7b24d326348e1672.
> > >
> > > One thing I'm not sure is whether Libvirt will be fine on losing
> > > "duplicates" after 2+ QEMU major releases.  Copy Jiri for this.  My
> > > understanding is that Libvirt should be keeping an eye on deprecation list
> > > and react, but I'd like to double check..
> >
> > This should not be a big deal as we can internally map either one
> > (depending on what QEMU supports) to the same libvirt's field. AFAIK
> > there is a consensus on Cc-ing libvirt-devel on patches that deprecate

I see.

> > QEMU interfaces so that we can update our code in time before the
> > deprecated interface is dropped.

Right.

What I mostly worried is "old libvirt" + "new qemu", where the old libvirt
only knows "duplicates", while the new (after 2 releases) will only report
"zeros".

> >
> > BTW, libvirt maps "duplicate" to:
> >
> > /**
> >  * VIR_DOMAIN_JOB_MEMORY_CONSTANT:
> >  *
> >  * virDomainGetJobStats field: number of pages filled with a constant
> >  * byte (all bytes in a single page are identical) transferred since the
> >  * beginning of the migration job, as VIR_TYPED_PARAM_ULLONG.
> >  *
> >  * The most common example of such pages are zero pages, i.e., pages filled
> >  * with zero bytes.
> >  *
> >  * Since: 1.0.3
> >  */
> > # define VIR_DOMAIN_JOB_MEMORY_CONSTANT          "memory_constant"
> >
> > Jirka
> >
> 
> Interesting. I didn't notice the existence of "duplicate" for zero
> pages. I do think the name is quite confusing. I will create the
> "zero/zero_bytes" counter and a separate commit to deprecate
> "duplicate". Will add libvirt devs per instruction above.

Yeah, please go ahead, and I hope my worry is not a real concern above; we
can figure that out later.  Even without deprecating "duplicate", maybe
it'll at least still be worthwhile we start having "zeros" reported
alongside.  Then after 10/20/30/N years we always have a chance to
deprecate the other one, just a matter of compatible window.

Thanks,

-- 
Peter Xu


