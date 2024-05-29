Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD53DC27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 19:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCOvu-0004bH-8B; Wed, 29 May 2024 15:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCOvt-0004aM-1i
 for qemu-devel@nongnu.org; Wed, 29 May 2024 15:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCOvr-0002zk-8W
 for qemu-devel@nongnu.org; Wed, 29 May 2024 15:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717010754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7w8j7/43fSCwFnrdWlFQLGNdHvaYDZ9881ed9By6Q+Y=;
 b=Qtdp6C9BLmgO0tUoqVK9KiH4/XQZGdqbz07fyphmzZpbx0BWf3Z88NlUcok5ScBxBRwBYx
 Or5ePlLRPiAwO5ik6UHMei80LejQtGm+15CkxAJsvVhhhitlihTl4TLbrzq0KnDV2So1LL
 3EK7XjQjoGf/ImwJZ9AFYGUVuWQSEEw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-NG_0J9EgNcKvUZdnDGq2Zw-1; Wed, 29 May 2024 15:25:53 -0400
X-MC-Unique: NG_0J9EgNcKvUZdnDGq2Zw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab9836827eso201896d6.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717010751; x=1717615551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7w8j7/43fSCwFnrdWlFQLGNdHvaYDZ9881ed9By6Q+Y=;
 b=HcBayg0qQi31+1ywMhTytU+yzJdUaPdTU1vBJVt4zKPg27kXS2iQK1SYMoKp4un7wl
 kBhrN4razPoG3rZMPXvqkB5zO7G4sRZiElN/z0+VH3voN3uj4jZN7O8N9/1j2xRIYF5F
 WBiR1KhvjxUyDd6+rxSObghyU688+ElTxqf9topZxZ4tqqqgehfrjpncGG+NtA7yzF3p
 F8x3MRCelh2gMubb1RR1NYsAqHZc+TOkDWrVSKNRmvY65gHzQGrNOimrCNfyx9uQdYkk
 s6vujk694IMDbPGP3gOLP2S7n2vAQFoymxcBU3GldudM47e/bXdJDXjwJGk35qU+B8IU
 2MKQ==
X-Gm-Message-State: AOJu0YzWrkQA5chhmfrp9aBiq/RgGH+liI6VYwY7b+yA3EW6KFba9h6R
 cursCiS5fSNPmAZb1FDARToBcOp3b+VYJimjYRqNnNeofehkiVgyyIojEZK+uhL/s9ezIcZtB98
 uw4IJQbci+0IqJfL4vI353oVDAqQxZInC4ZNF2HgqfEv8Mc0ivMCW
X-Received: by 2002:a05:6214:d0d:b0:6ad:7a01:19c7 with SMTP id
 6a1803df08f44-6ae0c9ab4bamr1578036d6.0.1717010750929; 
 Wed, 29 May 2024 12:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJW57pb8nBEBtubp0kDCmSDcCC2qPAo+8avsZOxsFCUyva074fVVGELwX+A1VGcDWoA6K4zg==
X-Received: by 2002:a05:6214:d0d:b0:6ad:7a01:19c7 with SMTP id
 6a1803df08f44-6ae0c9ab4bamr1577686d6.0.1717010750220; 
 Wed, 29 May 2024 12:25:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac070c2f9csm56487726d6.27.2024.05.29.12.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 12:25:49 -0700 (PDT)
Date: Wed, 29 May 2024 15:25:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 19/26] physmem: preserve ram blocks for cpr
Message-ID: <ZleBOx6pN6KCn0a2@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
 <ZlZQVijf2weEmzYK@x1n>
 <c3f23e83-81d7-469a-aa04-29785fa6f8d7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3f23e83-81d7-469a-aa04-29785fa6f8d7@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 29, 2024 at 01:31:53PM -0400, Steven Sistare wrote:
> On 5/28/2024 5:44 PM, Peter Xu wrote:
> > On Mon, Apr 29, 2024 at 08:55:28AM -0700, Steve Sistare wrote:
> > > Preserve fields of RAMBlocks that allocate their host memory during CPR so
> > > the RAM allocation can be recovered.
> > 
> > This sentence itself did not explain much, IMHO.  QEMU can share memory
> > using fd based memory already of all kinds, as long as the memory backend
> > is path-based it can be shared by sharing the same paths to dst.
> > 
> > This reads very confusing as a generic concept.  I mean, QEMU migration
> > relies on so many things to work right.  We mostly asks the users to "use
> > exactly the same cmdline for src/dst QEMU unless you know what you're
> > doing", otherwise many things can break.  That should also include ramblock
> > being matched between src/dst due to the same cmdlines provided on both
> > sides.  It'll be confusing to mention this when we thought the ramblocks
> > also rely on that fact.
> > 
> > So IIUC this sentence should be dropped in the real patch, and I'll try to
> > guess the real reason with below..
> 
> The properties of the implicitly created ramblocks must be preserved.
> The defaults can and do change between qemu releases, even when the command-line
> parameters do not change for the explicit objects that cause these implicit
> ramblocks to be created.

AFAIU, QEMU relies on ramblocks to be the same before this series.  Do you
have an example?  Would that already cause issue when migrate?

> 
> > > Mirror the mr->align field in the RAMBlock to simplify the vmstate.
> > > Preserve the old host address, even though it is immediately discarded,
> > > as it will be needed in the future for CPR with iommufd.  Preserve
> > > guest_memfd, even though CPR does not yet support it, to maintain vmstate
> > > compatibility when it becomes supported.
> > 
> > .. It could be about the vfio vaddr update feature that you mentioned and
> > only for iommufd (as IIUC vfio still relies on iova ranges, then it won't
> > help here)?
> > 
> > If so, IMHO we should have this patch (or any variance form) to be there
> > for your upcoming vfio support.  Keeping this around like this will make
> > the series harder to review.  Or is it needed even before VFIO?
> 
> This patch is needed independently of vfio or iommufd.
> 
> guest_memfd is independent of vfio or iommufd.  It is a recent addition
> which I have not tried to support, but I added this placeholder field
> to it can be supported in the future without adding a new field later
> and maintaining backwards compatibility.

Is guest_memfd the only user so far, then?  If so, would it be possible we
split it as a separate effort on top of the base cpr-exec support?

-- 
Peter Xu


