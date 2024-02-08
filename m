Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407A3C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 02:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXuHi-0006P9-0G; Wed, 07 Feb 2024 21:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuHa-0006Ot-PQ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 21:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuHX-0007z7-41
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 21:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707359812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J2pkOfJJdYIa1ciIJNp9EuQDaeG6YjUdQ85GdScE/Dw=;
 b=WNSz5cCIhJhis1Ev+XSWX2PLF8HZXXWiyw0DENAdN7dko4TuvXrj8/cj7Kg1N6KyopQv1F
 ltXr16y7yMEvVf62nwhPlWOfv1SnixruO3UJT4ixv1BjiDTP2e3QlPOcrRB4n6rlymLLPG
 msJOr7875xhPByqx0H00HYLPns1Hv70=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-HcpXKlnqNXiUAJWAfEqlhA-1; Wed, 07 Feb 2024 21:36:50 -0500
X-MC-Unique: HcpXKlnqNXiUAJWAfEqlhA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bfbf4dcca9so400056b6e.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 18:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707359809; x=1707964609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2pkOfJJdYIa1ciIJNp9EuQDaeG6YjUdQ85GdScE/Dw=;
 b=aBULErCwobVh3O49afktOrjWBGQbENjtaCCU6FAt4SgbnvgIz1Op9KrcBQbkztvdxd
 HdlTLJd9TgAj7gL6FqoBrZdqdkUibaCx+cY5QXQF0fDX4gilLQTLpI6E5lTvLVRVYrQq
 1hvIOwk/55olhLNnKj/xrQ7qxjaOc9Uf1RNZLl20B/lnH4Y2F4X2l9orKS7mt7YQdzEd
 WGFFbB5huv+ENzvDBHpSiaySPwdYOCJah1iNVb2hLCTtz/HKp4x0Ae7Qey/zilkBUUTk
 hk350aEkkbAUEo0FPRJZWgws7YsKftHPYtJ5knDcXWwlzRefJd9KwEcfhW0RtHRU4Y1m
 hTdg==
X-Gm-Message-State: AOJu0YwE75QpuzBPICKRNviK3BM6i/s9HqKymo6VQSMz922TIJgzigd/
 StIBqBzaUnDUj0YHxmkTLnPJvvtRHCZ855SBne6RweliCwMwv+D1MMoKeSJaGF52w6xfqKM843Z
 Mn66F9AIh0E2UwFeZ4LUa6Fz4bXL7eu5yJZjFIcpyE9je9MkzGrCn
X-Received: by 2002:a05:6358:8a1:b0:178:f482:6e59 with SMTP id
 m33-20020a05635808a100b00178f4826e59mr9781745rwj.3.1707359809415; 
 Wed, 07 Feb 2024 18:36:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAqeE63Ap6B6w/ip4f4nsymnfiM4I8hls6O+gOxwJi7dw6G/HH/mP9/p58UBI302DSjQRZDw==
X-Received: by 2002:a05:6358:8a1:b0:178:f482:6e59 with SMTP id
 m33-20020a05635808a100b00178f4826e59mr9781726rwj.3.1707359808994; 
 Wed, 07 Feb 2024 18:36:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVMn7Rrc51st15T7TyaAP5CHvhtOcDrmNM0ftkJRPvgufvU1ae9R/PupIbSPTxhnfnXkzyVaqxc169i6r15zrE=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c4-20020aa78c04000000b006dde0f53fc2sm2407415pfd.49.2024.02.07.18.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 18:36:48 -0800 (PST)
Date: Thu, 8 Feb 2024 10:36:43 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [External] Re: [PATCH 0/6] Introduce multifd zero page checking.
Message-ID: <ZcQ-O8tp_Bo0API_@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <ZcL7aIwo_Z8gn6h3@x1n>
 <CAAYibXjQYkpL+L8pLX5DQ4hTWqFAc2pcpkJFmE5bs=O5vzhDPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAYibXjQYkpL+L8pLX5DQ4hTWqFAc2pcpkJFmE5bs=O5vzhDPg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 07, 2024 at 04:47:27PM -0800, Hao Xiang wrote:
> Sure I will drop "throughput" to avoid confusion. In my testing, 1
> multifd channel already makes the main thread spin at 100%. So the
> total-time is the same across 1/2/4 multifd channels as long as zero
> page is run on the main migration thread. Of course, this is based on
> the fact that the network is not the bottleneck. One interesting
> finding is that multifd 1 channel with multifd zero page has better
> performance than multifd 1 channel with main migration thread.

It's probably because the main thread has even more works to do than
"detecting zero page" alone.

When zero detection is done in main thread and when the guest is fully
idle, it'll consume a major portion of main thread cpu resource scanning
those pages already.  Consider all pages zero, multifd threads should be
fully idle, so n_channels may not matter here.

When 1 multifd thread created with zero-page offloading, zero page is fully
offloaded from main -> multifd thread even if only one.  It's kind of a
similar effect of forking the main thread into two threads, so the main
thread can be more efficient on other tasks (fetching/scanning dirty bits,
etc.).

Thanks,

-- 
Peter Xu


