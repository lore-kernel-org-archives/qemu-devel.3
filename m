Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180F7C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 14:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbmc-0007PT-JS; Mon, 27 May 2024 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBbmY-0007Ok-3p
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBbmW-00053g-1h
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716821818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+8f1pfRAwPuL9baY4gtDFImUBxyL3Ft9bre0Bzso1U=;
 b=eAt0cuodQvAQLeBwJ5am9zwX7s41TFaNw5utBOieESWd4W0u8UvcJjtO4PrRSncP0hNE1x
 WigrC1FczeC32A3O7PRbQGKQPYejfAkxinG7ZKcO9jTlphPj75LMvFL+OMhRDBzvDP92Uz
 eH1p7cWDiQ1+TnsAsjIpGv8TovaJoVE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-typgcWTJPW2sjGZGyj6eOQ-1; Mon, 27 May 2024 10:56:57 -0400
X-MC-Unique: typgcWTJPW2sjGZGyj6eOQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-794cd5c0c5bso3285a.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 07:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716821817; x=1717426617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+8f1pfRAwPuL9baY4gtDFImUBxyL3Ft9bre0Bzso1U=;
 b=HYRXrdiTruGhJ/q1n79Njh7AT+oBJHslmnc42MM9JYQzNmIPYYx30n/6SbSzdJ6RUx
 Nv+8DFlQvOlrH8kteAVQawCsUx1FALkqoU0J3WIreTHE2pVMEIByqy86CDAjlxaDveDi
 4aQJaaoM+vDzFrxF4CEM8P8/4VHbwdZQIqV6Uhif0ESvZ1c05UgG5smUlkIOckdr/nTa
 /Cz3Mfi4TGiqYppL2BAN3wa6GZ8yVtgnn53SBFGILyAcOxufQqAukpviSmKjCt7Kuwmf
 DBLsFGFGGiMUhrZhN7gd3prXqBoKSpXXfUuAdBj9hvaeU/YGCX8StUJh00G2A81ECLRp
 yf5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ94AvWkNvgoVNH6mL1R4P5PmA9apdSMxPBu+3L9AWDPUKayUJqRaeKQMQsuwDWHKC8NuoHD2xLqpIjFH64w7u3lEu4nk=
X-Gm-Message-State: AOJu0YwkhaHsQzbD1QEWoWBSnsikQ4HbwJW3NMuF/PwKLM+lC189AxvZ
 K3hYMZVYS/O+oHR+PNVXV1L6Pe6TXFtLjAx6VjKWkPyZFdqG8OEKLypL3LWDGUNFwLA3iHmSSRO
 DarvtSJ/0IG5g7hk/J8A2CI24HvmdFkUrsFbwR9FN16LgXxhIpDO+Bsa2P9f2
X-Received: by 2002:a05:620a:4493:b0:794:c215:9b99 with SMTP id
 af79cd13be357-794c2159d31mr383071385a.6.1716821816659; 
 Mon, 27 May 2024 07:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVtXm+2Wg43iZ9bN3EZl0hKDdVDmcEEOestbb42xFtp3lwJvade+d37xo47NJMcpu2u87aeA==
X-Received: by 2002:a05:620a:4493:b0:794:c215:9b99 with SMTP id
 af79cd13be357-794c2159d31mr383067185a.6.1716821815987; 
 Mon, 27 May 2024 07:56:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc3070sm299763585a.51.2024.05.27.07.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 07:56:55 -0700 (PDT)
Date: Mon, 27 May 2024 10:56:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH 3/3] tests/qtest/migration-test: Enable
 test_ignore_shared
Message-ID: <ZlSfNe6DhBgft79p@x1n>
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-4-npiggin@gmail.com>
 <87a5kbh1e3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5kbh1e3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, May 27, 2024 at 09:42:28AM -0300, Fabiano Rosas wrote:
> However, there is an issue here still on all archs - which might very
> well have been the original issue - which is the fact that the
> containers on the Gitlab CI have limits on shared memory usage.
> Unfortunately we cannot enable this test for the CI, so it needs a check
> on the GITLAB_CI environment variable.

Another option is we teach migration-test to detect whether memory_size of
shmem is available, skip if not.  It can be a sequence of:

  memfd_create()
  fallocate()
  ret = madvise(MADV_POPULATE_WRITE)

To be run at the entry of migration-test, and skip all use_shmem=true tests
if ret != 0, or any step failed above.

Thanks,

-- 
Peter Xu


