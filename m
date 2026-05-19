Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0472CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRIB-0003Zt-4f; Tue, 19 May 2026 16:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRI9-0003Zf-DI
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRI6-00045a-G7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779223429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlczZg63DjJFARr/lz1niGHunkJb1SpM3BOqE0B50Ps=;
 b=KPGJdv5uSXvmgsDUHvg9mPYG6PVj8YoAT6FOtGtOzZOVsfwJAns7bbpVcRD9QWT1Dpjggd
 w4QVRa7iKw5H+Ij2qfDtOmIIYHa9Omy7kdwvLXelWDgb2/W0tu/pqDwk/I2S8J/2tB/Hir
 37zdC9pAaJs5tnCectX1t6C8VnfcRik=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-E5RGuMsMNuaGMH3Fz41Ulg-1; Tue, 19 May 2026 16:43:47 -0400
X-MC-Unique: E5RGuMsMNuaGMH3Fz41Ulg-1
X-Mimecast-MFC-AGG-ID: E5RGuMsMNuaGMH3Fz41Ulg_1779223427
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ca1295e3a9so38590276d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779223427; x=1779828227; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AlczZg63DjJFARr/lz1niGHunkJb1SpM3BOqE0B50Ps=;
 b=odyxLSGwRFECvjX/wxhvjRheSA1VOqdA1Bjw/95UIlDA/GhCBxf0dkh36PX47KRfe5
 STK9rVdXngDDl95AlQporTc8BLdD6kuzE+B2GysSedcd5z5TdryOdEnSt8vu08U43AAc
 M/wsL3m+hHxR+01+8fej3STfIr+/G6KbyqHhvydkuecAt24nP09YpkmlK2TclCU99zSO
 DLmYJjkRBpOHLNnPyHgE/r9DnwEI1bWbTLPA/16f0FYdXbDDDZ6INk60M6wD1LD0ZUJX
 Q8iYR/MB4r2RgtsJng3QIPTqh3jCBxo/C3UnSvDOLseJWba+FSXVIiOo2AnxQtJyBeMs
 1hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223427; x=1779828227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlczZg63DjJFARr/lz1niGHunkJb1SpM3BOqE0B50Ps=;
 b=f0SbXB0NvA/DccM6svTJrvyGqqGYR2HVVYqJHbUwFABpk8XsnizdIC3un4dqyboJ5V
 j2mCJ8axeKt4RlvVyH8ZWSNvFcXgGHJNB2kAFeADN8aVMpVjofAFQN0aHfpaMsD1Oqul
 yMLvjDxq3rFx+MZGpNOAaW0YVhE0BDMhacBxzofuXpQ3tunBUrhd+4YpKbZCnhnWv+dj
 bUuSjuVu33g2vTSQNlJHNXTwGrcxf2AkIfRNpcfVCxXy1vW6EONMIxyfvi2P4m8sRe4m
 810AzyjL/5JYlHIgRcK16mNX0yxizmgjbXF67KxNB0Ukju4Ka4FaFPf638erc3V7yqEZ
 UXzQ==
X-Gm-Message-State: AOJu0Yz680DfNoo3dcTi5exYX9adHmt6F57hFEqDvVNMrQ6l/RwF9KVw
 Oj7qxVD2PlG7eq+nIRVIZQdacPk4BIekcGNNhRmE2ewV8QbaB5yCZNvcLPTKHKWcVC0ImUqe6wH
 jfojg2xTuj9ibuA3u105hJtuyo63dzf9ISBEYiD/QYvN02DOD2Hvz6W77
X-Gm-Gg: Acq92OGWgQOmDqyMBwFN/w9U/H9PeUaKxpxJpp3PrNrSdrvYYomf7lxNqsrFfcM7uhm
 iV6CPQ7Pf4FFiIGy6WrivDudizps9IKUHH4gGT6DeqU50SmD1JInaHA4re16T4eo0Ms217OG2A3
 1KKQRhVkTh4e+aaGWeNOq/E6jIUBezq/TMGkYF3BpQjfwb4r7P77yjXztBz4G7+4rXu72ipc4ct
 NK8rMOsQ/i1SJZJHxWxztxpik2+GR0KTIo9jvMs/DKj+WZy7NiXA3P8LjAq25KSJARpgkY501ek
 HFffLaAUUUS2q/DbSJQ0RxWzI0ILEyE8sq8dsA29GUxaGtJFKnNmQqbw8Us3h/p8ZxKB/6FCAPS
 EqSxwLVXiLm5EaJlHJWj7ZmvH9ff8lWg9JY4rrhtMRqZtg4E96UcnQXVxyg==
X-Received: by 2002:a05:620a:4102:b0:902:e991:f3f3 with SMTP id
 af79cd13be357-911d0d54ebamr3239375385a.62.1779223426929; 
 Tue, 19 May 2026 13:43:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4102:b0:902:e991:f3f3 with SMTP id
 af79cd13be357-911d0d54ebamr3239370385a.62.1779223426404; 
 Tue, 19 May 2026 13:43:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba182535sm1945928485a.8.2026.05.19.13.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:43:45 -0700 (PDT)
Date: Tue, 19 May 2026 16:43:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 01/15] tests/qtest/migration: Move cpr transfer logic
 into cpr-tests.c
Message-ID: <agzLfwxeGEv9diLo@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 05, 2026 at 01:09:00PM -0300, Fabiano Rosas wrote:
> There's some amount of cpr-transfer logic at precopy_common, which in
> retrospect was a bad idea. For just two tests, that's too much code to
> be in the common function. Move it to the cpr file. We'll need this
> cleanup for subsequent improvements.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


