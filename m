Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E25C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWZw-0006Dk-B4; Mon, 26 Feb 2024 03:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWZu-0006DE-7c
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:43:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reWZs-0007vt-Sh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708936992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mya3+oH4xz1pSWDGrx0wqrrmE1foMW+BKNf5sXwT45w=;
 b=RhENQDj1zXn+q54Gd0W35GOa2ngwXy8gwdBKmJGb6sbztx8yTcgaOhGhqOkBClNj0DMi0j
 VT1IELH0bf4yL//L4sQ9BbyuT8pnS6LaKFiD7iqig+tgf7bqSdf06RmcHP7/aHy9AdjBtU
 +8vywAEJt/qMRysqXc2+bLegXAXP14k=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-bSy9EvVYOf6s1n0anyDvZg-1; Mon, 26 Feb 2024 03:43:10 -0500
X-MC-Unique: bSy9EvVYOf6s1n0anyDvZg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5a0494c8929so450703eaf.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936989; x=1709541789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mya3+oH4xz1pSWDGrx0wqrrmE1foMW+BKNf5sXwT45w=;
 b=hwifpxk6NNjvG0mYl7xKr49Z6aliVb4r8q78A1DrZWpWHYTKUK4btq5otSptK8/zIm
 RZg37/F7LLFfqhXQuUvIo5CgIXdG3yANrn/zG0H7sZ8HykJXmyeTXBgi0XxZcwxaSfAI
 PF2qyPjXubw2JvxntWXzzTtyRAZ/9xqpgssukwWtoePnnp7rBFZ0kh2UR52PiaeUQd4p
 VXcPG6tAJDPOYb2n3R9RPKnQGxOjTdLr3XyI1Nvd6b3c3mv5k6glcOntJT0Jnm5gBp1R
 k2WcFMmN7GK4jYYxc9DoEj2zQF3Jqz3+8f4FXjHIwIL5wDKEQFYOGi8Wg2f2w0DvQ6xd
 j3oA==
X-Gm-Message-State: AOJu0YwQes9PDA5RQa4Hg1OMeK52G3w8pSpnlAWbdWotNzLT2ChdgDJt
 387TnTM8vMn7h0xwUMC9Vd5GmU0VsAdxmbAuL4/anIn6p2arb77D3GKPFbmRMY1XlNMwWBP97lN
 YIEn1SPQc6rkv9LCc/tCHT3qj+Gs6VvZM8fpnWg15FdVTYlSjlMdq
X-Received: by 2002:a05:6359:6e88:b0:17b:b540:e1ce with SMTP id
 ti8-20020a0563596e8800b0017bb540e1cemr24668rwb.0.1708936989442; 
 Mon, 26 Feb 2024 00:43:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3E7UpV6yrCU9/SHRtWW2qmT4F6UKFo4FDRPjPfH9se4yoQu6FnybbNOoplUrc6jFhDqLKFA==
X-Received: by 2002:a05:6359:6e88:b0:17b:b540:e1ce with SMTP id
 ti8-20020a0563596e8800b0017bb540e1cemr24655rwb.0.1708936989091; 
 Mon, 26 Feb 2024 00:43:09 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006e0737f2bafsm3486778pfb.45.2024.02.26.00.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:43:08 -0800 (PST)
Date: Mon, 26 Feb 2024 16:42:59 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 26/34] tests/qtest/migration: Add a multifd +
 fixed-ram migration test
Message-ID: <ZdxPE5tsyc4oek_R@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-27-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-27-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Feb 20, 2024 at 07:41:30PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One question to double check with you:

[...]

> +#ifndef _WIN32
> +    migration_test_add("/migration/multifd/fd/fixed-ram",
> +                       test_multifd_fd_fixed_ram);
> +#endif

I know we mostly ever use _WIN32 to check these, but why not CONFIG_POSIX?

commit d7613ee2165769303d0fa31069c4b6a840f0dae2
Author: Bin Meng <bin.meng@windriver.com>
Date:   Wed Aug 24 17:39:59 2022 +0800

    tests/qtest: migration-test: Skip running test_migrate_fd_proto on win32

It wanted to avoid socketpair(), which makes sense.  However e.g. qmp cmd
"getfd" is with CONFIG_POSIX.

-- 
Peter Xu


