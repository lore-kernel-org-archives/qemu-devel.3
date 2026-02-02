Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B3DE7DEEF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmufS-0003sw-NC; Mon, 02 Feb 2026 09:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmufR-0003sH-At
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmufP-0001zV-L7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770041558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VA4MvcPpdrJwFUg/1eLfUJAw0KXXSsu8dcNJDUH7l6k=;
 b=UYe+edo70hdsE4bqiIHty/7W564Ln5dwK0WeT2MGqeinYx4EP2b/aYfa6eJW6tWomFcs8w
 xU0jO73iUvzcJ2Y/tyxSOUwL7A9e3FzHFR44kg9Sauj7FV/ERDxKa4CoX8kLXw/AVn9XKl
 2SrVh5j/M/bXpRn3XwaDwlTCqo9LQ3U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-7BSm4QJKOdKBiX-LK-w8Dg-1; Mon, 02 Feb 2026 09:12:36 -0500
X-MC-Unique: 7BSm4QJKOdKBiX-LK-w8Dg-1
X-Mimecast-MFC-AGG-ID: 7BSm4QJKOdKBiX-LK-w8Dg_1770041556
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5059656723eso218367511cf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770041556; x=1770646356; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VA4MvcPpdrJwFUg/1eLfUJAw0KXXSsu8dcNJDUH7l6k=;
 b=BCJiUCDwz0tF/zWLGTZ4NOhUBqpG5tza3lWdZJ0GfYpjPlfO8yLhui3tqjZbeUG46r
 WpxncxcfiXP2NyOOtjQ4AIYNA1MP6FXJX0xdW6nczXan1EJgKo3D7XSt5uODnRpSKfst
 YKiSsVFC/PtWK2HCgPyPjWZlxg2iMYhzrJ9rptely/3YntbL4oJMWHXZKzXnIcA6lulE
 XOkOzs0+Zib4QQ/4n88m+n8/mij/O8r1L3l8OCYmlqm03w7ECPI7Z3uiThKbYTSlo66e
 +nTZCKTKh95WpT69PpHU7BT2Exbop+oJVLSTsGMmbovSfHVcJv8fgMpadM+8vnrSgcXi
 gAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770041556; x=1770646356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VA4MvcPpdrJwFUg/1eLfUJAw0KXXSsu8dcNJDUH7l6k=;
 b=gVrmVzoPy2QAUq9dEzLCqxG1bVpSM8WuOt5qfdBecsfLWiVdN7FSEgXw0PGAA14gmW
 wmBoXjL2VfaQz0qzXfnqgDn+hJHMnRxgzm3CJCQrh0rlkLzduVcWgaocIeFTI0KnWQLe
 t0JuhQLPgWZdAXTeX7U+F3AJSxX/crOkNdkCP9a8c3NpFkFewozsUVywxryaGmu3i6IE
 A5J3zQ7wq2KX0RQAnJzSa/OWdo4MpeK+MZ/bUdiTOjUs/2MSzuquqOJmU+8UvJ1LDzHm
 eBratQWMKa95M9Oeg/p8g7/YFUNjH2Wt5CFOafB/7HhtJerIY6wUs4AKYWmiMKKnkCt/
 qwdA==
X-Gm-Message-State: AOJu0YzLTzaVG6H6USjnISM98qZZ1NQfxTy252qn8tXq9nHJ43tmsWo2
 JG8vPgk6cWNiKFBzbAvWaF/5LRElw2RAx6PXMgYKPlzuZZDMwIMsd4oGpYBVB9smNQU22kJ4Vn/
 /zUhPYmnJ4IdQc8jFEDtL/xx9zc+lwBN8kDnLkNFXjvX6b6h1HuU9Tf71
X-Gm-Gg: AZuq6aL7JDz4/zA9eNnkUvtS26IxfSw3uIDP/wUfX02ERbN5KQUiJMLhFSEzMFo2DaC
 iIRgenuGEmDtYIs3WQW8DLhYNSUY4pxbJDJcK/rkWuk9VQ+rTCEttnc9GhN5IXwNLsRcMFKBYbC
 7d4hE/u8AvD9YAAJzUZ06u7BbLdBKJA/jAaSgBEfErC2Z8L0SGmPwSCU0HckABX3aEWJOwtlwFI
 t4PQv8Ifg44Vzy8qeq86kCgXm7a8IL7RXlrcR8dnlFhNqNDH5KmSjjyV3Ne+3J9ICwFljF5qfX5
 dIQ5msaeek4QLXhEnraTbz66tyv30Lw0WueFPSqa1nZiUrriZcan5DSbOU/R9bXnv7mbalz3Wrl
 AM1I=
X-Received: by 2002:ac8:5d48:0:b0:502:a06a:fe5a with SMTP id
 d75a77b69052e-505d2289c3emr138259751cf.51.1770041555806; 
 Mon, 02 Feb 2026 06:12:35 -0800 (PST)
X-Received: by 2002:ac8:5d48:0:b0:502:a06a:fe5a with SMTP id
 d75a77b69052e-505d2289c3emr138259191cf.51.1770041555172; 
 Mon, 02 Feb 2026 06:12:35 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337ba39d8sm110259211cf.22.2026.02.02.06.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:12:34 -0800 (PST)
Date: Mon, 2 Feb 2026 09:12:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 05/10] colo: Fix crash during device vmstate load
Message-ID: <aYCw0Qz_OQwlUrjM@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-5-ae926ccd8eae@web.de>
 <aXkiX-jvFOieE9FG@x1.local> <20260130134942.721a2758@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130134942.721a2758@penguin>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 30, 2026 at 01:49:42PM +0100, Lukas Straub wrote:
> On Tue, 27 Jan 2026 15:38:55 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Sun, Jan 25, 2026 at 09:40:10PM +0100, Lukas Straub wrote:
> > > With colo we load device vmstate during each checkpoint, on top of
> > > a vm that was already running. Some devices expect a reset before
> > > loading vmstate on such a previously running vm.
> > > 
> > > This fixes a crash when using COLO with Q35 machine.
> > > 
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>  
> > 
> > Yes makes sense, maybe you can add some comments into the code too since
> > this was overlooked before,
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > Have you tried to measure how many overheads will this introduce to loading
> > each snapshot?
> 
> It's a large overhead actually, between 10-20 milliseconds.

This can be mentioned in the commit message.

IIUC reset() may or may not be required while loading a snapshot.
Normally, a device reset() should reset all dev registers and internal
states, OTOH loadvm() will reload most of them once more.. so less
efficient.

Maybe there's chance to "fix" q35 instead reducing this overhead, but I'll
leave that to be your call; to me this fix is clean from maint POV.

Thanks,

-- 
Peter Xu


