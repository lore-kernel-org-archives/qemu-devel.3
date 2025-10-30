Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE82CCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUOF-0002BQ-Nt; Thu, 30 Oct 2025 11:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEUOC-0002AR-BJ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEUNo-0005Za-Sl
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vn0M/NlZHtyvr8itcZWJIvUgseTvPvlypcxTGygvEmg=;
 b=VJB41rYHfTOgIVvfDFLjVdDG4si3xOgjfzts7CR7C2aDAklRg5Pyr/lfTq1+u8PHOukEQU
 VQbL0pKYpCTG4jkM55H0iNWNUrxjH0pvtcI1eYPUZo4kQ6FwUkuaKKr2/baNZ2SSulYrN7
 u6QDLnam0+IWI6x4OwuoUO6r4j5yW0k=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ATsihkpXMxySLgVs8CJv6A-1; Thu, 30 Oct 2025 11:16:05 -0400
X-MC-Unique: ATsihkpXMxySLgVs8CJv6A-1
X-Mimecast-MFC-AGG-ID: ATsihkpXMxySLgVs8CJv6A_1761837365
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-5d7cbbaef1bso407169137.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761837365; x=1762442165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn0M/NlZHtyvr8itcZWJIvUgseTvPvlypcxTGygvEmg=;
 b=jDG6KGpwY4t0OTUnUOMw8rmRUeuCzGW+GtJ+eikT2dvvwrStZZWG15T17I0+h4Ulrd
 MF/+E9BGaWkRD8yb4mhCC6XOVrORD2NN+foALIorsCcRtTXcQeQ8ARhy5ZSvNOWiRz3a
 JFEIfidbbgQbk5OCW05cLaiJFK3Tb0TfdFAlbTzioL5sLFSy8MzAffKtpoVVO1AGqb7j
 Dirfg7yBIgAdOqzponXfVVVjRqc3T5o6bL5CDBZH/f0CsGazZCGyiOvcPVaSYzag1qP1
 dgwiJfezWG936qcmZ5E5JQzqYd4fJM2GJ5M00UcuUNIV0JXnuto5XODKuVXWXAP/glpa
 GeNA==
X-Gm-Message-State: AOJu0YyD5sdmpdrWtVFc6v+vtMyjRuR/K41JprvSBkjBRRT43lGf3xhQ
 51BbWgLXEHYJUobWaN6j4nktTJu5nvyMFLtgkuoSlYluHVmk4etfWkHudZ17EZH+rtnBOJ+HWSD
 lmaXPc+fOlaVYeSuj/PnRHkEHbuOR4w8G//WkrL1XQVJEi70QPWyrUX8N
X-Gm-Gg: ASbGnctsHuz/SSgcYHfss8Fn/xGkwlw2DbEMTnDERJg2H7+xT0/TGprNQOIYD/F7OfS
 DWLKVyDslvl0g1sXeyhSD8LETwZ2EIO4CJKqbF1wgOwER+kV4gLPbX/AWek7mFN26u85nwbS5OS
 6Hp5S8U9vm1EajPN1emJLjpvy24OtWCzZrx45NzCvzWTvqoDqIyfdmRBbJB++Jt5buIb2+c+DBJ
 /le46oQdI+ObSGJXjdSqR7tJD/URC2WUXz0saauO1j/GZr8Lfp+VC1xNWpHuj7DeP5M5IqlBHaY
 LXXfZ0kMh9YKUnU/YfzVOy9DO2qir+Afo/wPCIsCdGdClJYxNsv4QDppwM81Mo/ftoA=
X-Received: by 2002:a05:6102:809f:b0:5db:350f:2c6b with SMTP id
 ada2fe7eead31-5db90698d8amr2487039137.38.1761837364877; 
 Thu, 30 Oct 2025 08:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOqpuECF5Q1K2zaGCUKedwKErlGKDHaXVmDuKSchaY+pYQcTWVI88ZzfZeXERBSPHXu+go0Q==
X-Received: by 2002:a05:6102:809f:b0:5db:350f:2c6b with SMTP id
 ada2fe7eead31-5db90698d8amr2487013137.38.1761837364405; 
 Thu, 30 Oct 2025 08:16:04 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-880132bb7f2sm27765126d6.17.2025.10.30.08.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 08:16:03 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:16:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/4] migration: Move postcopy_ram_listen_thread() to
 postcopy-ram.c
Message-ID: <aQOBMemFJe4f-Nqx@x1.local>
References: <20251027154115.4138677-1-jmarcin@redhat.com>
 <20251027154115.4138677-3-jmarcin@redhat.com>
 <aQJwx5IBnwk7SxkJ@x1.local>
 <dqpskxkmn6zxhd7oeuj4mqpyl7vdhjrecimtldx4k4v6wijnl3@ynjeyazm4ai4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dqpskxkmn6zxhd7oeuj4mqpyl7vdhjrecimtldx4k4v6wijnl3@ynjeyazm4ai4>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 30, 2025 at 02:08:06PM +0100, Juraj Marcin wrote:
> On 2025-10-29 15:53, Peter Xu wrote:
> > On Mon, Oct 27, 2025 at 04:41:09PM +0100, Juraj Marcin wrote:
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > > 
> > > This patch addresses a TODO about moving postcopy_ram_listen_thread() to
> > > postcopy file. Furthermore, this patch adds a pair of functions,
> > > postcopy_incoming_setup() and postcopy_incoming_cleanup(), which sets up
> > > and cleans the postcopy_ram_incoming state and the listen thread.
> > 
> > It would be great to separate code movements and changes.
> 
> I wanted to get around the need to expose the postcopy listen thread
> function in a header file, hence the postcopy_incoming_setup() function,
> adding postcopy_incoming_cleanup() together then seemed natural to me.
> 
> However, I could split it like this:
> 
> 1. Move postcopy_ram_listen_thread() to postcopy-ram.c and add a simple
>    wrapper for postcopy_thread_create() (something like
>    postcopy_ram_listen_thread_create).
> 2. Rename postcopy_ram_listen_thread_create to postcopy_incoming_setup
>    and move rest of loadvm_postcopy_handle_listen, that is moved by this
>    patch, and lastly introduce postcopy_ram_incoming_cleanup().

I'm not sure I fully get what you described, but it's okay, I'll read what
you'll post. :)

The idea here is when there's major movement of codes, do it in one patch
(or a few) only for the movement but nothing else.  Then try to do anything
on top, either changing existing code or even adding some wrappers.
Normally that'll make review / backport / ... all easier.

It'll be fine if we need to add some entries to headers then remove them
later on.

-- 
Peter Xu


