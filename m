Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D907C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 16:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2COJ-0006ei-Nj; Wed, 01 May 2024 12:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2COI-0006eA-UU
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2CO6-0003cV-Nk
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714579252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3/Ygv1QxTxbAMDqSumkK5hlcguBkYUeh/pfd2A5920=;
 b=JrXcX3Ee6WTcVExr/8wop1aE8WwGvIH93S4XBQvUtimCrKhQBsW7i6DxZtyqZf9npbKdg4
 Vn5zjA4rtWHvKgC58/cqOTbt4Of5Z2oUUqiKhn1uluFmSnBqBAhsD/aEJflnp6Gooqayqa
 kK9p4251b+YADUK6Y23P/iECr8ZKvvA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-qgw9TSX-OrCUL6RvTyCk-g-1; Wed, 01 May 2024 12:00:51 -0400
X-MC-Unique: qgw9TSX-OrCUL6RvTyCk-g-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ec919e71eeso1702535ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 09:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714579251; x=1715184051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3/Ygv1QxTxbAMDqSumkK5hlcguBkYUeh/pfd2A5920=;
 b=G5VPKfw01MZJCFzbsA+SBKmkgMM8pBa86X2jwzZV16Y0kMEGuLQsXVH3M5RFLxaRrh
 JxmhP4AAqTtsM3g0uAtxGxhvsjRucnZGToUT+pTENAaBmCVWAa9J+6xJA9HcxX3eTLDT
 6lZyTq4elBgB+7h2T4fK/8ItzwR4Ly8hJWlY6wEYFD9MDwkKjGOfOVY5bvw++f1vI2UE
 KE2l3HUJ/xjfNyWjckipqh2X6fUiGU3xEE+GbdYUC/BBJAaqKS43oFVPFAawWHH2Y28K
 X4WAcK+Ybe3idMFVKMt1sKNJrO7FKUXo5t5zo6k5h3rJJV+41G+NSkfJfrVJzm13qFvl
 8t+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdELYr5WunrJO/9JsCjoTSXgStwvh21CmW/kfOp6KVInhT0HrbrNGHwVuo5EEVjHmA3AyCNgExsfOzLi9mPjlDAO49KUw=
X-Gm-Message-State: AOJu0YzPQ4qF2ZRy5wsRW4P9D/7npti3odCGwwruGo1RlQsG5aSwsVi/
 ZNXOrfQLYlwaWKciklIxK5ZjsVBxrXnvLqW77Fp8JFk9TI4hOvbQ5ilRF3tcTatovMUNRyhpEk3
 ZD9bO8ETVHvJgIIN+e2dVpQU5LHgpxneC8rjS1zMlPq5xEorxnXAE
X-Received: by 2002:a17:902:c407:b0:1e4:397b:492c with SMTP id
 k7-20020a170902c40700b001e4397b492cmr3127088plk.4.1714579249955; 
 Wed, 01 May 2024 09:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjUYW65ypZxmLAtWWMTIvcvTdAiyF4+vuZTISaecB1ag3dOb0WDrpxXeRCYX+gG2VyD4Q4PQ==
X-Received: by 2002:a17:902:c407:b0:1e4:397b:492c with SMTP id
 k7-20020a170902c40700b001e4397b492cmr3127026plk.4.1714579249178; 
 Wed, 01 May 2024 09:00:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d12-20020a170902654c00b001ec379d8167sm3597930pln.115.2024.05.01.09.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 09:00:48 -0700 (PDT)
Date: Wed, 1 May 2024 12:00:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v6 0/5] migration: do not exit on incoming failure
Message-ID: <ZjJnLQiyZJTkOTr7@x1n>
References: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 30, 2024 at 11:56:41AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The series brings an option to not immediately exit on incoming
> migration failure, giving a possibility to orchestrator to get the error
> through QAPI and shutdown QEMU by "quit".

There seem to have one comment overlooked in the last patch I left before
(on a probably useless error_desc pre-check), but doesn't look a huge
deal..

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


