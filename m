Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE58C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI71s-0004UB-5F; Thu, 22 May 2025 10:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI71q-0004SW-Aw
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI71o-0001SO-MH
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747924570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fp7K5g4cypCHber5g+OBJ2QBCKPqwNkkdnVi2GefpzQ=;
 b=Udp1H5vmPSD5aR7CAY3cZClWF/jEQZ5G8UdY3ZY3xDmD7sega6ypeSpoz9beDbxDhKmW5i
 AgE+VLP2YhXeDwdMZmYW4ErvBKgiMHEEZqkBbROvazguz+Hj1IFRIeD5PHLaLIHcuBqEIQ
 1t+2tt2scINrYxqL8GMCy4v2o//4kI8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-P-gI5ESEP0Ks9YmfKuM30g-1; Thu, 22 May 2025 10:36:09 -0400
X-MC-Unique: P-gI5ESEP0Ks9YmfKuM30g-1
X-Mimecast-MFC-AGG-ID: P-gI5ESEP0Ks9YmfKuM30g_1747924568
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30e78145dc4so8948332a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 07:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924568; x=1748529368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fp7K5g4cypCHber5g+OBJ2QBCKPqwNkkdnVi2GefpzQ=;
 b=DLe3X5nGdP88kOEnU+TfZIlL5ttERpokG2AlXMn5Ik7dJz00h/RhUJMLoSjxPkBLaW
 RL0SyWGhbV/fAi937aF4O8j95BNS4uemQOn6LI6J0ft/BDrxsvDspxg5nKDpxVqIHJ1i
 MWkNPOdnkspnuIE3sQAFbZGcMXQLRcAdUNbMvZ+1Jdae4NkV72kbRzweixWXU9gzx4v3
 zu9qLIGAqGKx2zIqPM0wwzuPzUvEBdi9qShE5mshUwlJ2HHKavnWeEjn5SKi5Rix1HQL
 eU1YmPkXO/+MnbP0d5U8fOW72oyuiyAdDejLTDqN0kMieS/wa8s1db/0yVS4OXueUIXx
 3qQA==
X-Gm-Message-State: AOJu0YzkO/V7FbAzjcdVz00MONTlX004H7mqSmRgrA0DF8I4V8Xx+ygy
 iYqSilTSOhTnBAxzTmeJ1wyT1taF/75vX2tzwrAeI6Rq7yJdToqXfCMBtp5eKA5tBxa6DAO1ENa
 5YvBEVPCX+Zyp6lNaxtIHYHmHfbibqx0bnGSGi4ffFfKypafKUqZdQ8aO2Ss6o7IO
X-Gm-Gg: ASbGncuQGeHFJ7XbeRQ7zh3DltLN42P5KLVxVJCSCPygCKrLIlWwwIdhrWJXIjnOY/A
 GbgMsmoLenOys79a+bl7JbMk17NkrykFeHxM5rcg8RVZVUUa2KHVBADDNFLNSWBoSCXYe9rWExR
 DHEXUfolN+hhyjNBZ8g6IQ7sKT4MwTg49S81sBQhVoXc77nEsf9KhShE4q8yqJeaRxR+7x2a+oh
 +Yte4b1ICiNfOgVXbP1/dsgciehQh7gIdAi+N0YqonxCMMLth3U7KUogZqee03G7sEPAbgVeYj8
 kJM=
X-Received: by 2002:a17:90b:17d0:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-30e7d57f38bmr32371821a91.21.1747924568162; 
 Thu, 22 May 2025 07:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK3UZGNcqAOsq+TSNZaL0tyv8jvy2TufVvv8QAqoc2GKOz5ihDnI8fFXZlRmO5FIQxIR/r7w==
X-Received: by 2002:a05:620a:f07:b0:7cd:2c8a:2839 with SMTP id
 af79cd13be357-7cd4670a67bmr4409673085a.7.1747924557614; 
 Thu, 22 May 2025 07:35:57 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467ec38bsm1030638485a.51.2025.05.22.07.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:35:57 -0700 (PDT)
Date: Thu, 22 May 2025 10:35:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/4] tests/data/vmstate-static-checker: Add dump files
 from QEMU 7.2.17
Message-ID: <aC82SrxyqNLeyn_e@x1.local>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522133756.259194-3-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 22, 2025 at 03:37:54PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> For automatic tests, we need reference files from older QEMU versions.
> QEMU 7.2 is a long term stable release, so it's a good candidate for
> checking whether the migration could still work correctly. Let's add the
> files from that version that have been taken with the "-dump-vmstate"
> parameter of QEMU (compiled with single machines and the configure switch
> "--without-default-devices" to keep the json files reasonable small).
> 
> Some devices also have been removed manually from the json files, e.g.
> the "pci-bridge" (which can be disabled in later QEMU versions via Kconfig),
> and some Linux-related devices like "scsi-block" and "scsi-generic" and
> KVM-related devices. Without removing them, we might get errors otherwise
> if these devices have not been compiled into the destination QEMU build.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


