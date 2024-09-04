Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598E1CD4F32
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 20:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slx2B-0004Ip-IQ; Wed, 04 Sep 2024 16:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slx29-0004I1-TN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slx28-0000gG-Dy
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 16:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725483319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RYYUvPmmndVr1Ak2OkN7RO7dIBWFKaxBQ/WL9u2PSjM=;
 b=H0IYT1gCoUQgyk+dC9RBB0+TIb/2FO7So0bkcswhIU04DWVa+LSGLMD2CnJzNc3T1ipU3R
 CvKFQyAJ0rG2ldex4EhMmM9yJumTaSuDlvk1a9gDVvmDg4qjsC0AYNtKbYhHjoCFTtNTz6
 R05OjYbezlOfRU26qG4wbRVKmyKMr1s=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-s1YCEfekNIuER_tFfISJWQ-1; Wed, 04 Sep 2024 16:55:17 -0400
X-MC-Unique: s1YCEfekNIuER_tFfISJWQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3df2f5535e8so3287b6e.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 13:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725483317; x=1726088117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYYUvPmmndVr1Ak2OkN7RO7dIBWFKaxBQ/WL9u2PSjM=;
 b=SDZKPhVbKGVuLM23zdR5gP/PfR0PlLBVxJqlxT4sz1vbSwPzqWEcrvAqNSYBful3yI
 ZsM4N5QGAlJIglFKtHy1uPQCN08LdkkRR9b+QG8fwnz2YvxSISepMRCasCASFUdlalX1
 /6g2qk+hAzzG9z1LauHK+0+uheyFILQrGhfCLkUG3jJEtwGcg6RrOOyLzqDDJuHvGR2s
 WOEmJ4nSZMS2+9gHofaCdDrm4NLs0HI+nCFI6qlcBTJvs/W/le9X56FhxdDMCb6T/Jvz
 pRPs5VAnE8UbChJu2BS69pvuZPOmEuZfykFs7idQaK9ah5Di0Yb9xUjDcsUEAXkq9Szr
 SL2w==
X-Gm-Message-State: AOJu0Yw5qCljOH+bhdLqpQsjZeznSBxt6oVZJ2j2FRYh6z7ZDBQYL5r1
 Cz1QOkW0q2o/bo6RmAqZLb0bzF3tLWfhquTqdRc9vY7QHjzNq8fFu3asPaeghB4tHSjWLuEzH/5
 PM9GsTE+prp/zpysiRMPxdk6KCoO30GrHx0CBhu0l3Y/fDMsulrhZ
X-Received: by 2002:a05:6808:201b:b0:3d5:2afc:94f5 with SMTP id
 5614622812f47-3df1c942eedmr19421437b6e.10.1725483316660; 
 Wed, 04 Sep 2024 13:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECpk0TCP46RZfhPTCG1Eq4Huzd+/VXJmgIy2PqvxcCcQAFbTiFmEurM79xwQ1a30w75KXBmw==
X-Received: by 2002:a05:6808:201b:b0:3d5:2afc:94f5 with SMTP id
 5614622812f47-3df1c942eedmr19421421b6e.10.1725483316328; 
 Wed, 04 Sep 2024 13:55:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801dc19b8sm1652611cf.82.2024.09.04.13.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 13:55:15 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:55:13 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZtjJMXoHvi0VHEhn@x1n>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <4ed8cec2-413a-4254-8804-55befbcd0d00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ed8cec2-413a-4254-8804-55befbcd0d00@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Wed, Sep 04, 2024 at 10:43:23PM +0200, David Hildenbrand wrote:
> On 04.09.24 21:16, Peter Xu wrote:
> > Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
> > was a separate discussion, however during that I found a regression of
> > dirty sync slowness when profiling.
> > 
> > Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
> > statically allocated to be the max supported by the kernel.  However after
> > Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
> > the max supported memslots reported now grows to some number large enough
> > so that it may not be wise to always statically allocate with the max
> > reported.
> > 
> > What's worse, QEMU kvm code still walks all the allocated memslots entries
> > to do any form of lookups.  It can drastically slow down all memslot
> > operations because each of such loop can run over 32K times on the new
> > kernels.
> > 
> > Fix this issue by making the memslots to be allocated dynamically.
> 
> Wouldn't it be sufficient to limit the walk to the actually used slots?
> 
> I know, the large allocation might sound scary at first, but memory
> overcommit+populate-on-demand should handle that, assuming nobody touches
> the yet-unused slots.

I thought we can have holes within the array?

I meant e.g. when 10 slots populated, but then one of them got removed,
then nr_slots_used would be 9 even if slots[9] is still in use?

Thanks,

-- 
Peter Xu


