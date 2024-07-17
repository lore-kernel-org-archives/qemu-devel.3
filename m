Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505D1C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 19:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUAGO-0005iC-Ax; Wed, 17 Jul 2024 15:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUAGL-0005hL-Tc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 15:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUAGI-0001fQ-SR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 15:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721244265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfDqO5QDUfjaxADAITl7zzYhGnjVqqYIrR+bZVUltNo=;
 b=JTtK678t38m9LaWEzaP5SAoVR6NkZXTKw28xNdvdNR+6+oQEOz+DF7ywLhJgCykTpHYOg4
 JU8CleKaPLtEtcRuXIR3AjfLrkLczANNtTfPRRubp39E4rYWDAs0YyYHMznIXUtG6ecM9z
 b6zbPAJrOKe7CMzZA8fxgUe6IvGFVmM=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-p07J1NqGO5-GJ29l1GP22Q-1; Wed, 17 Jul 2024 15:24:24 -0400
X-MC-Unique: p07J1NqGO5-GJ29l1GP22Q-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2502a80477bso16641fac.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 12:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721244263; x=1721849063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfDqO5QDUfjaxADAITl7zzYhGnjVqqYIrR+bZVUltNo=;
 b=VBnZiFOi/DmA1548i35n9H07thoLVgKY0+Ti43q4/qLdqZu/iqgdHsPmP3PTqsJrnL
 fu1FC9s63vhZzao5yIXVRAUykTC4AO2PKA/xC/C+rEqwOSodJfijz0FcCFcs8YphCZ7/
 ZNUgSi6s7eJd3DMtSQSsiQ7894JEBYUgeaaBDFOg5OJB4XEXOqAKpUhzJqdJydHUCUn3
 V/q3acaXnSUtU1MU0ChgjookBX0Vp9frb23w5qnSoWFC3CZhTxttTMqlKQfrbxpXGExY
 Ou5PtbLye4CDxcgM7PjOXXwx4DoGqneo9cnFGRpkHk3OfGjzaqzXh5zM7sRRoTRJgtBd
 Jc0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Lpl8CWoP5v652u+MQSZsQ7AYvi8fXAz9Azn8I3hIxhe4Xkx92LvIdx8PdxwP9RHP0DkBDRrHlqHzUdYtFEZRILErpjM=
X-Gm-Message-State: AOJu0YyDmrLzYLW0DAD0Lm/UcKcpJUd9bm/onN4yZ3xFGLHXbMJNC5KZ
 cOjU+5z7Eb4o1CrowYvAyTGrdACKWmtf7mDP3yzTYLyrijd5v/eszMTSZNEDATS85NaHJDBCoRj
 QUFiXZLfKTphWrq/9A/DuS19BVIm0eTCy9KGxAS7MUT9w3E0SuTyZ
X-Received: by 2002:a05:6870:d888:b0:260:23eb:5669 with SMTP id
 586e51a60fabf-260ee6278efmr308281fac.2.1721244263474; 
 Wed, 17 Jul 2024 12:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH19Dq20+NleW9Az/Rnqg1yvRtVC50M3OPEr7oHMXP0ziHMbVNH1Fp/WoI7W/3QHg6Mkz97YA==
X-Received: by 2002:a05:6870:d888:b0:260:23eb:5669 with SMTP id
 586e51a60fabf-260ee6278efmr308267fac.2.1721244263101; 
 Wed, 17 Jul 2024 12:24:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160bbe360sm439456785a.30.2024.07.17.12.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 12:24:22 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:24:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <ZpgaZPxKzwcVAYZn@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 16, 2024 at 11:19:55AM +0200, Igor Mammedov wrote:
> On Sun, 30 Jun 2024 12:40:24 -0700
> Steve Sistare <steven.sistare@oracle.com> wrote:
> 
> > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > on the value of the anon-alloc machine property.  This affects
> > memory-backend-ram objects, guest RAM created with the global -m option
> > but without an associated memory-backend object and without the -mem-path
> > option
> nowadays, all machines were converted to use memory backend for VM RAM.
> so -m option implicitly creates memory-backend object,
> which will be either MEMORY_BACKEND_FILE if -mem-path present
> or MEMORY_BACKEND_RAM otherwise.
> 
> 
> > To access the same memory in the old and new QEMU processes, the memory
> > must be mapped shared.  Therefore, the implementation always sets
> 
> > RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
> > user must explicitly specify the share option.  In lieu of defining a new
> so statement at the top that memory-backend-ram is affected is not
> really valid? 
> 
> > RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
> > as the condition for calling memfd_create.
> 
> In general I do dislike adding yet another option that will affect
> guest RAM allocation (memory-backends  should be sufficient).

I shared the same concern when reviewing the previous version, and I keep
having so.

> 
> However I do see that you need memfd for device memory (vram, roms, ...).
> Can we just use memfd/shared unconditionally for those and
> avoid introducing a new confusing option?

ROMs should be fine IIUC, as they shouldn't be large, and they can be
migrated normally (because they're not DMA target from VFIO assigned
devices).  IOW, per my understanding what must be shared via memfd is
writable memories that can be DMAed from a VFIO device.

I raised such question on whether / why vram can be a DMA target, but I
didn't get a response.  So I would like to redo this comment: I think we
should figure out what is missing when we switch all backends to use
-object, rather than adding this flag easily.  When added, we should be
crystal clear on which RAM region will be applicable by this flag.

PS to Steve: and I think I left tons of other comments in previous version
outside this patch too, but I don't think they're fully discussed when this
series was sent.  I can re-read the series again, but I don't think it'll
work out if we keep skipping discussions..

Thanks,

-- 
Peter Xu


