Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC9AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 21:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC4cz-0004ZK-6D; Tue, 28 May 2024 17:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC4cx-0004XR-3n
 for qemu-devel@nongnu.org; Tue, 28 May 2024 17:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC4cv-000508-Fz
 for qemu-devel@nongnu.org; Tue, 28 May 2024 17:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716932700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h7vAHbXgtzSsa9a2dc28G2k+DKuhP8PHSJ9Ue2I1CM8=;
 b=BclF/GKQalVhvATnlbygIOok0kTW2vl3Ac0eFr5AdjIW2ZHSP6gfraILi/j4Vh7LnZEMXO
 u3ZZhDVoHPAnU67K/27Ogy4fa0bi8DiiHV7Im5sncciL0GhR8Tt6KZDz8N+UNZ3sPLJj6d
 GVVr4Y57o4qcnRqUs89TB6rq19yImZk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-kCciOdMOOpiIiiw9pg6oFg-1; Tue, 28 May 2024 17:44:58 -0400
X-MC-Unique: kCciOdMOOpiIiiw9pg6oFg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5b96a77ea14so488717eaf.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 14:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716932698; x=1717537498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7vAHbXgtzSsa9a2dc28G2k+DKuhP8PHSJ9Ue2I1CM8=;
 b=EOH3xSKTF4VsbT/jqMzyUqRjbzNrDG05ZzxQrAoXJUPnW2x6/qOtdJUSxgDEXZ7RYp
 7anEDgrkZPIHmqEh5fOpOTV8ePQFbRCtjAn941fCuibPc9nwo2DoRV9Y7kJTHI+OhjT3
 UlfL20HogrK2mzZ/ZdG0TQ2qpGSJMX59KP2dHTYdpU3XaujPV+qqhv1toG1ZII6WDFRG
 KmswNQ2mCInfB/t4N+tOYijw/nr3OC0NBPDt8CzP6uFysue6qplbxPOAxakxz5D6PHBC
 zkgYZGEXE8QgDnBcsQr/iLFycXYqh25YsaZ1qPQtD6s1uLKvgFg96CaTDFdSot6sipfc
 WmTQ==
X-Gm-Message-State: AOJu0YxFFOf1a7h74+n7dzzSYeoGjPZXP4EA810BSChNe1zf7m3UTKzL
 DwLvsX6455oWNvZk74OMoiQ/u4bFFLNb3sz+PcEE+GXUMIGuiEGUYfaFctFs4xRj6uDdBMwumfX
 UlRvI7EzSISTVB2fTsQYY6cQPHL1p1quA7Vt0bmuQMrKKxXKtyzwT
X-Received: by 2002:a05:6808:4c85:b0:3d1:d3ba:ce0b with SMTP id
 5614622812f47-3d1d3bad073mr1083783b6e.2.1716932697625; 
 Tue, 28 May 2024 14:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfcvhHEBdzHlmad9nm9eajofaNTE9nKjy9cy8E1bXaxYGuI0CG/jl8Gqn4i5tl0K3AO2R5Aw==
X-Received: by 2002:a05:6808:4c85:b0:3d1:d3ba:ce0b with SMTP id
 5614622812f47-3d1d3bad073mr1083764b6e.2.1716932697027; 
 Tue, 28 May 2024 14:44:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac1641928esm47971866d6.134.2024.05.28.14.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 14:44:56 -0700 (PDT)
Date: Tue, 28 May 2024 17:44:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 19/26] physmem: preserve ram blocks for cpr
Message-ID: <ZlZQVijf2weEmzYK@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, Apr 29, 2024 at 08:55:28AM -0700, Steve Sistare wrote:
> Preserve fields of RAMBlocks that allocate their host memory during CPR so
> the RAM allocation can be recovered.

This sentence itself did not explain much, IMHO.  QEMU can share memory
using fd based memory already of all kinds, as long as the memory backend
is path-based it can be shared by sharing the same paths to dst.

This reads very confusing as a generic concept.  I mean, QEMU migration
relies on so many things to work right.  We mostly asks the users to "use
exactly the same cmdline for src/dst QEMU unless you know what you're
doing", otherwise many things can break.  That should also include ramblock
being matched between src/dst due to the same cmdlines provided on both
sides.  It'll be confusing to mention this when we thought the ramblocks
also rely on that fact.

So IIUC this sentence should be dropped in the real patch, and I'll try to
guess the real reason with below..

> Mirror the mr->align field in the RAMBlock to simplify the vmstate.
> Preserve the old host address, even though it is immediately discarded,
> as it will be needed in the future for CPR with iommufd.  Preserve
> guest_memfd, even though CPR does not yet support it, to maintain vmstate
> compatibility when it becomes supported.

.. It could be about the vfio vaddr update feature that you mentioned and
only for iommufd (as IIUC vfio still relies on iova ranges, then it won't
help here)?

If so, IMHO we should have this patch (or any variance form) to be there
for your upcoming vfio support.  Keeping this around like this will make
the series harder to review.  Or is it needed even before VFIO?

Another thing to ask: does this idea also need to rely on some future
iommufd kernel support?  If there's anything that's not merged in current
Linux upstream, this series needs to be marked as RFC, so it's not target
for merging.  This will also be true if this patch is "preparing" for that
work.  It means if this patch only services iommufd purpose, even if it
doesn't require any kernel header to be referenced, we should only merge it
together with the full iommufd support comes later (and that'll be after
iommufd kernel supports land).

Thanks,

-- 
Peter Xu


