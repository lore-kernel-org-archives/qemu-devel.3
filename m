Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AEACFC5F4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 18:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syyGI-0004ER-CD; Thu, 10 Oct 2024 14:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syyGG-0004EF-VF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 14:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syyGF-0003gh-Gj
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 14:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728586300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nW0XKUIWCNnLdJj0Ed36P9ApOxrvYcmAJ0gr78DP0UI=;
 b=a4xsctCs5FK3yJP9vxqf6VjcyEExEjMz/2jtnD2q8P6qWKlVYflbp5Zla2KOl0voxFWx4/
 +RpJqdDyVz7xVx0JUBbFFIsrQ6w93wIApXF5PZCRlhqJYCkHodwkQNQJnnRzBaxV6VPZe+
 xLmo1moxQceisn1XL0LeuGyrznjapWI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-oUZChwhcOeugii-HEmGwUQ-1; Thu, 10 Oct 2024 14:51:39 -0400
X-MC-Unique: oUZChwhcOeugii-HEmGwUQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-45b5cdfbc89so24184711cf.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 11:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728586298; x=1729191098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW0XKUIWCNnLdJj0Ed36P9ApOxrvYcmAJ0gr78DP0UI=;
 b=dKC2ZdpJuvS2k5xYUAENVbowa/l+1N51tXbDyEaCqc83x/6C9qNlH3rulnPWGngSWK
 vtBPpTrNXKQ9jJg5PIodkSkEtax5rn+hACy7Hh7/ST85tXWbcnnaxiDfSVXVXGJLQAh8
 SUfz9h+l6LGghrC71sAKOZmbg3DLE0ByAkJGeqLCKg8OMbssWA16TT182t0GmCRN15+B
 xnhg0MhoktniaXIIEO25xHSujEi1FAUpyt/kESr68cOUIBjOmwE/OluLyrCT4hN5EebZ
 fxthiDkAiNfChMGjR9U9c8TZeIhXIAvkRaeepGyN5HPP3NCLtiR5+rrlsQlWGAyeh9mm
 HQbQ==
X-Gm-Message-State: AOJu0YwAi9yp8cdaQczbViH3408dZwqV8xJidh7LciqCARMmkvqj/8+N
 W3t2fuV7w4sUc2E2LYNq6zjwth+hY3X62Dg195qvjbUwBN7ydnjz7UBzQZg6EmnNrmQNUc0c0aP
 ZqF8rxLeG3+eAW/ts7D2vbeXiOFRAWdkLdz2Uk1qbkngtd32/0EuNukwJgGU9Gu3TiDkc7cfZTD
 U1WmO252ProQCmQwwF/k5JuxpWdl9HtjK/og==
X-Received: by 2002:a05:622a:c1:b0:458:156f:965c with SMTP id
 d75a77b69052e-45fa5ef4de9mr112814051cf.22.1728586298155; 
 Thu, 10 Oct 2024 11:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJWIGHZ8mSidXXXPO9ElFHRsEud/BahTtEwilKHZC0AeuluFCgmpw5iBL2nZveRUyIR0UZMQ==
X-Received: by 2002:a05:622a:c1:b0:458:156f:965c with SMTP id
 d75a77b69052e-45fa5ef4de9mr112813721cf.22.1728586297702; 
 Thu, 10 Oct 2024 11:51:37 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042808619sm7828431cf.55.2024.10.10.11.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:51:36 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:51:35 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration: Cleanup migrate_fd_cleanup() on accessing
 to_dst_file
Message-ID: <ZwgiN3Jv7aOnC1oB@x1n>
References: <20240919163042.116767-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919163042.116767-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Sep 19, 2024 at 12:30:42PM -0400, Peter Xu wrote:
> The cleanup function can in many cases needs cleanup on its own.
> 
> The major thing we want to do here is not referencing to_dst_file when
> without the file mutex.  When at it, touch things elsewhere too to make it
> look slightly better in general.
> 
> One thing to mention is, migration_thread has its own "running" boolean, so
> it doesn't need to rely on to_dst_file being non-NULL.  Multifd has a
> dependency so it needs to be skipped if to_dst_file is not yet set; add a
> richer comment for such reason.
> 
> Resolves: Coverity CID 1527402
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

queued.

-- 
Peter Xu


