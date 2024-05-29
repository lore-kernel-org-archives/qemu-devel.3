Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E96AC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC7T5-0004b7-9W; Tue, 28 May 2024 20:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC7T3-0004af-33
 for qemu-devel@nongnu.org; Tue, 28 May 2024 20:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC7T1-0004Pr-Kn
 for qemu-devel@nongnu.org; Tue, 28 May 2024 20:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716943618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yY8xpkG4AR/dbkFJ19RA9OR84yURWFnjrIYDMJxJm6Y=;
 b=Zw4Hljeq/V2N7BkoEGWVxkbbztTAeZ5wZg2pUoRdMywUZiwW/bzP53bh8JPAQtgtGpRfxw
 5LJ9JKfAFwFhlvFdIuOcq1+s5KkyWUpFKu3vGmvC+PKPXvjiWrAs50u0pbsHRpC37wN+C7
 Pmynf3LD5oxyipoQ1xg68QN4V69k1H8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-UnBnsdSJOvG_FHJIorzf_Q-1; Tue, 28 May 2024 20:46:56 -0400
X-MC-Unique: UnBnsdSJOvG_FHJIorzf_Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ad674e609fso3725866d6.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 17:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716943616; x=1717548416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yY8xpkG4AR/dbkFJ19RA9OR84yURWFnjrIYDMJxJm6Y=;
 b=olMGOPmlT5lEPY82LV1TOluSaie7yDvwzodQtR6IailLgj6DhAJQJDpBW+vt4SCYy+
 hEhJhRzypryA3+OT1jOD+G+amwctE7XbOq3wBsKupMCcitJmx/nElA7j9xAMYy4mpyjS
 lgqQR0Q6rLDn6mrJddDpuNJ7DWJP4eKNrGVyKOpifqCCmnNnHF73btJ26nDLKwOxz23t
 PbKd1TtqWCjt3O5+aoVFtvapi3AumDxbEyf0UZI2xyr1zUyFXglE2gH8BgEnU8L/52wg
 SI/c38281IXlazZMDP6AHKHMSWhn+bK/eJSa6SF7gfSt5tOeOLNH7wH5pPNQU0uisHeY
 hoeg==
X-Gm-Message-State: AOJu0YxmNLjdrqE0hFi/oCLEFDmwriPimLzXUOv5HXZWgpgblZTtivFc
 Z/YZPsNDx2EmM2Fz0mBATaSQyIROGZPo1wO7PmnULqJuj+GswCzrVEo7fooypF5EUFNddQ7UJj6
 /hoI1q4Pu3ZcQ8C5ZwlFRgmC7xCWU8JkpMsCDb0TJ4qwFMO5eiiDq
X-Received: by 2002:ac8:590c:0:b0:43d:89f6:9104 with SMTP id
 d75a77b69052e-43fb0e6e8c7mr163643151cf.1.1716943615785; 
 Tue, 28 May 2024 17:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx7XvZ+cFqwSasVmTfuzVc22/BmHmPTcmED+e0LSgMq/Et91ZmB603+AjUm9XEvIFAx8JXyw==
X-Received: by 2002:ac8:590c:0:b0:43d:89f6:9104 with SMTP id
 d75a77b69052e-43fb0e6e8c7mr163642781cf.1.1716943614963; 
 Tue, 28 May 2024 17:46:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb17f6ac8sm47372121cf.42.2024.05.28.17.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 17:46:54 -0700 (PDT)
Date: Tue, 28 May 2024 20:46:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migrate-test: Use regular file file for
 shared-memory tests
Message-ID: <ZlZ6_cJmxMkMmVKo@x1n>
References: <20240528042758.621589-1-npiggin@gmail.com> <ZlXdmi7PqKJdv3fP@x1n>
 <ZlYAvIFodnTrQIkX@x1n> <D1LOU3F9ZD3Q.3KYRK41PZT98O@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D1LOU3F9ZD3Q.3KYRK41PZT98O@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 29, 2024 at 10:05:32AM +1000, Nicholas Piggin wrote:
> I think that's good if you _need_ shm (e.g., for a uffd test), but
> we should permit tests that only require a memory file.

Yes there's no reason to forbid that, it's just that we're not adding new
tests but we can potentially change any future use_shmem to not test shmem
anymore.. instead we test something we don't suggest users to use..

The only concern is a small /dev/shm mount, am I right?  Would it work if
switch to memory-backend-memfd,shared=on?

Thanks,

-- 
Peter Xu


