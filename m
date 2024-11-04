Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312E3D1BDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80Rc-0000A5-Et; Mon, 04 Nov 2024 12:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t80RV-00008S-Jv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t80RS-0005RG-5A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730739636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+fflv7r+WYWbNO9O6ldiwH1vJJe+3N3hJ37PGfcIwMM=;
 b=Ka/GcuQzEaO3O4cC0rBNUc1MKuU6vTGNjQmFEgP9nxUdsBYYYgEowD+oS6ZV9RiH+/Ncm2
 zAD1AgylGgD86txFxn+bxq/x+JwCEfi7iEfzJ4gaco70f7rL/Vgeeih2oQbW9tj6LWg8u3
 dxlkyi8y6EONoIMNzcSyKqutcLbmkAk=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-kilB1BnJPwm4CKHkAFp-bQ-1; Mon, 04 Nov 2024 12:00:35 -0500
X-MC-Unique: kilB1BnJPwm4CKHkAFp-bQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-28c70e350a2so4399740fac.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739634; x=1731344434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fflv7r+WYWbNO9O6ldiwH1vJJe+3N3hJ37PGfcIwMM=;
 b=JK98bA/zTzSsna7pCrU8NKRbK3o0djkbOmNM5gEr5jzIA6o7uB7TnzESHSK5jjC4+B
 7MqwI9HjjbspBKetPLNMZxPLsCLxvPt3G6W1K3+n8Zr1T0FHqgVFs6/h/LbgbcrFQlYp
 SL/v/iUbmI/Pd+TMpXgO78Ff0JoKvvT1uGVuSwal2Cv5VEKzJeH9GXVdRm0AWqWhHQ4c
 kXEdJ/QiTMJk0FrxKcd7OmlE0eiuDEc2Psn82L6sI0f0kGV0VMTBxteEIAkw5y8M2EMY
 HnKYMyhICzr2SHsBbxrnKMDj/jutCKiVzrpC27SlL5R4t5OfdXeojgaCPBVopx8Hd69u
 IY6w==
X-Gm-Message-State: AOJu0YyTIJ72gnMk6SsZL/fwKZFEvsppIP2Gd3Qr/jgoeU3HSKY7clfY
 gWeBtH5ICaKjuGsklusfZzvqnfBlbPTGutDJix0ryHKkCPRQrmEYFfO9nn1h+I8t9zHFtatwE9M
 YbH6dyWuPEXwROkDI38+mNzLOpiNsy9OysPJvcYn1dVqMo/wdnQ0C
X-Received: by 2002:a05:6871:b25:b0:277:c0a9:f00d with SMTP id
 586e51a60fabf-29051af0edfmr26245661fac.4.1730739634555; 
 Mon, 04 Nov 2024 09:00:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz6I8VmJwL5FsWlFhMCqZjO0lqsjgbswKFxMubmYinFlkowUNALPhPWaP2rfhBZUqsnlWd3g==
X-Received: by 2002:a05:6871:b25:b0:277:c0a9:f00d with SMTP id
 586e51a60fabf-29051af0edfmr26245623fac.4.1730739634149; 
 Mon, 04 Nov 2024 09:00:34 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-294874cf488sm3011847fac.26.2024.11.04.09.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:00:33 -0800 (PST)
Date: Mon, 4 Nov 2024 12:00:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 4/5] migration: refactor ram_save_target_page functions
Message-ID: <Zyj9rz6eD-gAm4fa@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-5-ppandit@redhat.com>
 <ZyToBbvfWkIZ_40W@x1n>
 <CAE8KmOyi+_U2H1r=MyQmppNj6v3mMqpjMyMo=q9zm0=-49+B3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyi+_U2H1r=MyQmppNj6v3mMqpjMyMo=q9zm0=-49+B3g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04, 2024 at 05:26:45PM +0530, Prasad Pandit wrote:
> On Fri, 1 Nov 2024 at 20:09, Peter Xu <peterx@redhat.com> wrote:
> > > +    if (migrate_multifd()) {
> > > +        RAMBlock *block = pss->block;
> > > +        /*
> > > +         * While using multifd live migration, we still need to handle zero
> > > +         * page checking on the migration main thread.
> > > +         */
> > > +        if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> > > +            if (save_zero_page(rs, pss, offset)) {
> > > +                return 1;
> > > +            }
> >          }
> > There's one more save_zero_page() below.  Please consider properly merging them.
> 
>             if (save_zero_page(rs, pss, offset)) {
>                 return 1;
>             }
> 
> * First is called in migrate_multifd() mode, the second (above) is
> called in non-multifd mode. Will check how/if we can conflate them.

Yes, IMHO it's better when merged.

One more note here, that even with ZERO_PAGE_DETECTION_MULTIFD, qemu will
fallback to use LEGACY in reality when !multifd before.  We need to keep
that behavior.

> 
> > >      migration_ops = g_malloc0(sizeof(MigrationOps));
> > > +    migration_ops->ram_save_target_page = ram_save_target_page_common;
> >
> > If we want to merge the hooks, we should drop the hook in one shot, then
> > call the new function directly.
> >
> 
> * Ie. drop the 'migration_ops' object altogether? And call
> ram_save_target_page() as it used to be before multifd mode?

Yes.

Thanks,

-- 
Peter Xu


