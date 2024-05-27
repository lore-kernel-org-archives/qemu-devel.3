Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11E3C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcTn-0004Gn-CA; Mon, 27 May 2024 11:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBcTe-0004Ei-Ds
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBcTc-0004kH-Od
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716824490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2jjXAGnMJIup5py9qFNx8dqcZIpm8XYuyMzu+9N0U0=;
 b=MRNRhjtghLJNMLRCfQ2siUTb6pTkMUA3amC3R1N+trKOKvGbKN9LZ1uClXIPngjT7kmITL
 Lj4honBvqnCt/hnLaD7FXJtZL3cM+yUa2spwndZrNn4xvGJv/GobPPPL+sOwItoLhZ6QBx
 moL5x4mFvwUs3n03WR31PLtY9fG5H/E=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-EsuVNf3MMNmlinxpfl-D8w-1; Mon, 27 May 2024 11:41:28 -0400
X-MC-Unique: EsuVNf3MMNmlinxpfl-D8w-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-48a3a10e7e5so180390137.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716824488; x=1717429288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2jjXAGnMJIup5py9qFNx8dqcZIpm8XYuyMzu+9N0U0=;
 b=MwCBYHtEUcRkSu791ihhTx3taGTfnWOqeIAkjhVDUPdijS7mVRJB2Q4y5yxcuvqXyq
 frSHltOMQmQrJoESETjdhVEgGvNlRf+FQFWxhb5+uOV64b/ehhE+IlI/d6yYvmXUUrca
 XsuzmLRFefCDxNvDaT9wcK5PMp+CmphBBtt9wYY7R+XMQJ0KAFsuMQ437KRs66ofl9YK
 fY/L7g42ncp7Ud9DfkmIJnadrWEbKnEpLmn03AZu5zedbeFLGTkQJG/vplOhaxPXWie4
 vnhAqbyspqQbji2n3HKClawIqqdCEjDSotB5WkFfNRP0Hthfaomf8P2mo8KIWbM7Cde6
 WJ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRV8lLOXeLun4wWfMLYY1YJh7snkReR8mMxXWjOF0LsEA/wq1Xd8RdwNSuloFatYpNQWQazAjlVTLcb8Crdr2oMpMubE0=
X-Gm-Message-State: AOJu0YzuIQImUwRURZB5G65s3mgx1mrwQf5LxH2GR5rerAy7O5vc1cjy
 TK2CYge+FmYjxJ+6QSEdJ1cHHgbQzSZTwAvxt0jsnG7DzK+G8Ya8rTqCDJ+1KpzIYp54C25k5cQ
 WDO2Q8suC5Ms8rZq/2eYiSzIIrNe06JTZ7iPIfTVML02hB5souVK/
X-Received: by 2002:a05:6122:36a5:b0:4df:7ba8:5c79 with SMTP id
 71dfb90a1353d-4e4f01238cemr9448919e0c.0.1716824487788; 
 Mon, 27 May 2024 08:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE34VQSCdPigH4Z/67XKZrqVvIIvh5kzZeSgKv34vtOpjCWxzLMBaz60esA6v6wtSQ05xpI5A==
X-Received: by 2002:a05:6122:36a5:b0:4df:7ba8:5c79 with SMTP id
 71dfb90a1353d-4e4f01238cemr9448880e0c.0.1716824486993; 
 Mon, 27 May 2024 08:41:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd06397sm305174485a.96.2024.05.27.08.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:41:26 -0700 (PDT)
Date: Mon, 27 May 2024 11:41:24 -0400
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
Message-ID: <ZlSppKDE6wzjCF--@x1n>
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-4-npiggin@gmail.com>
 <87a5kbh1e3.fsf@suse.de> <ZlSfNe6DhBgft79p@x1n>
 <8734q3guha.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734q3guha.fsf@suse.de>
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

On Mon, May 27, 2024 at 12:11:45PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, May 27, 2024 at 09:42:28AM -0300, Fabiano Rosas wrote:
> >> However, there is an issue here still on all archs - which might very
> >> well have been the original issue - which is the fact that the
> >> containers on the Gitlab CI have limits on shared memory usage.
> >> Unfortunately we cannot enable this test for the CI, so it needs a check
> >> on the GITLAB_CI environment variable.
> >
> > Another option is we teach migration-test to detect whether memory_size of
> > shmem is available, skip if not.  It can be a sequence of:
> >
> >   memfd_create()
> >   fallocate()
> >   ret = madvise(MADV_POPULATE_WRITE)
> >
> > To be run at the entry of migration-test, and skip all use_shmem=true tests
> > if ret != 0, or any step failed above.
> 
> There are actually two issues:
> 
> 1) Trying to run a test that needs more shmem than available in the
> container. This is covered well by your suggestion.
> 
> 2) Trying to use some shmem while another test has already consumed all
> shmem. I'm not sure if this can be done reliably as the tests run in
> parallel.

Maybe we can also make that check to be per-test, then when use_shmem=true
the test populates the shmem file before using, skip if population fails.
And if it succeeded, using that file in that test should be reliable.

-- 
Peter Xu


