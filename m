Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE8CD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0Wj-0002PJ-Iw; Fri, 15 Nov 2024 12:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0Wi-0002P8-0H
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0Wg-00059v-Ni
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731693274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dtap00CytsoEkQ8aLmr4ZhAWa/8VnMa3hVLDYBeDjT8=;
 b=ejZY4l0k7RiuID/uENgZbQhUWVnhKJL+s2u3UJOxUG2Tm+ldU5ANOOa+gpnruGZwcXLZCg
 JphTkJDO8jQSH9P25CoUgFjGAp9D310Fpesu2LJ8gnCHrJDbc5kS/zjfX7ZUr8wutRME6O
 szn4mZvQkXwFIDnbLoa4mbPw8UrDd6M=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-3qPhHeHkMf-VN0Q831N0NQ-1; Fri, 15 Nov 2024 12:54:32 -0500
X-MC-Unique: 3qPhHeHkMf-VN0Q831N0NQ-1
X-Mimecast-MFC-AGG-ID: 3qPhHeHkMf-VN0Q831N0NQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83ab110ac50so169347439f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731693272; x=1732298072;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dtap00CytsoEkQ8aLmr4ZhAWa/8VnMa3hVLDYBeDjT8=;
 b=Bw0oGGRixHYFN/svO1DJjaBPIKBDoYlsDpJ4svKq+CdTPG71ZqBCpyhCueroW0uicu
 j/VNuMUOjsx/bKes2dxWP3pOVft3ViwvtBPDAbkOBUHCET++5FGs1N4b/b6Wznb43IgV
 yBumepPzD8qFV3Il3tb1fQ55sVXlwn1wX6GhMVQe+UG2wOEPNKgK8YLVioU3iefyREMO
 tpiFIM+OK5omJV9jkM11k77LOgwUew3dulDq8RcAufPoVIKXKJA25Q242Vsfz9CJToh9
 NAiN9QDw1VPdSf5Qu35/FdxptjvXFSgZYTwoVGmIFaFREWa7XmZyAIlbfLFwd4WwJdhg
 Jb0A==
X-Gm-Message-State: AOJu0Yxm1+4LZEMOOj4jNLHyqJ2skKf1chf/1sNACD9PV7L3vuj72lJj
 IRReQS8EInHhqtzozIsWTnjCGXBdXMEkCtLieLlVZopgZog4v/kByN7KpBx6T3iZNimJ5NRW6Mo
 rfqTBPVlyZ+Ra7PwtdQhde2hFwWXlT1NMrI9mGu8GGpB0tFZ6eIW/
X-Received: by 2002:a6b:ec09:0:b0:835:394a:d784 with SMTP id
 ca18e2360f4ac-83e5cdcc91emr797371739f.7.1731693272160; 
 Fri, 15 Nov 2024 09:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMq+ovh0YieQJfP18x9QE4tlRz0mqj7CA9GOrtAyUzwL8JeEXKF9HTn8nVfxz88GvPAnq6Hw==
X-Received: by 2002:a6b:ec09:0:b0:835:394a:d784 with SMTP id
 ca18e2360f4ac-83e5cdcc91emr797369239f.7.1731693271831; 
 Fri, 15 Nov 2024 09:54:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6ea215sm462529173.20.2024.11.15.09.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 09:54:31 -0800 (PST)
Date: Fri, 15 Nov 2024 12:54:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 2/9] qom: refactor checking abstract property when
 creating instances
Message-ID: <ZzeK1bIyb0IQ6CG9@x1n>
References: <20241115172521.504102-1-berrange@redhat.com>
 <20241115172521.504102-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115172521.504102-3-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

On Fri, Nov 15, 2024 at 05:25:14PM +0000, Daniel P. Berrangé wrote:
> Push an Error object into object_initialize_with_type, so that
> reporting of attempts to create an abstract type is handled at
> the lowest level.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


