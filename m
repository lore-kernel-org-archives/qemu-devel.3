Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A773C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmSZ-0006rb-0Z; Mon, 11 Mar 2024 16:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmSR-0006rL-Qn
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmSQ-0007Sc-72
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710189673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+RV8dYpqTTiVgnTg7dhL7/X+F1rhrBz2l6Y2pht9LU=;
 b=Cmqrw2Zhnr8x84ACleb0xOTkWzNncOw/QKh46+mYeqvQxicFqY8/hcNH1g/3Lqc4NeK0yG
 7UmSsCtZwXcgSlFQ9EIKu6AITk7eLQWiwP7q5ghlW0wNKyRz9H3ubIIX+Cu1rtbUOpi0vD
 iWGA9aNPkMAwId1UI+ha/RK9hqVape8=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-Tr_sF7iIOsmUwaUaAxsL9A-1; Mon, 11 Mar 2024 16:41:10 -0400
X-MC-Unique: Tr_sF7iIOsmUwaUaAxsL9A-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-221d6a92312so1025681fac.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710189670; x=1710794470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+RV8dYpqTTiVgnTg7dhL7/X+F1rhrBz2l6Y2pht9LU=;
 b=Oe1bEoxpnT0Ai6TdXYLVOjbIRYyz2Ap2UIaRPieK/5NPOibQsHm3JqZ9v/t6YuY38Q
 iunob11xhm7ZjDqjGhgPjHdKXj981CUUn3W4RJBbtk+/slU/Z+5D/D85K5VHghV+GYYP
 s6ZSjr9DBtvb6OSWWYgNun7iVjIy0eE3S2JhwJMHor3SyPlKh6+pjYjhZ2QrZVzS66pa
 WxBv31wbDSbpmVswKjYDFBnBUNuuJLJsIAdWn6zTp9VwAVqJP7UOhl2heBxqyY+6IFcQ
 8kT55GwoJttKVp2tN1FMJ1L8dKGyp7cw33/iueQHFiURSwQm0rr6t7UKwwMOBKt0vu69
 s+VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXpw32zIZGkAA4ZrYXl9Ti3wvVS6MT9zC1AWBWbERmYtlF7xU9G6wkI+bSP9NCqQn3Q597hL9jHwdeHICaMDXWBYG7GJM=
X-Gm-Message-State: AOJu0YyTVBkwHTMVGVMlF6JKQhCJm8pZtZmAnXUL/COajHfh4TTS/CHx
 QF+Ra0e578BuwUp7QuaXHEaTZGSZqk84aZkr+T9nzgkDISO/CJtOr+h35qdIiMFR4q0Kh3BTn5N
 W1sjmy2uwWUE8l0rjsjrHgy1us7MuXxbCP9V2WxBClLeo2ohZGnO8
X-Received: by 2002:a05:6870:b14a:b0:221:731a:1f67 with SMTP id
 a10-20020a056870b14a00b00221731a1f67mr7359400oal.4.1710189669842; 
 Mon, 11 Mar 2024 13:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRWTjLNEpr1zd10iLY2rN3VqdUjm+hTepCw1JoUn3a7Iz+LA/ErN/Z3pcg5FPE4Y6/GIsXQ==
X-Received: by 2002:a05:6870:b14a:b0:221:731a:1f67 with SMTP id
 a10-20020a056870b14a00b00221731a1f67mr7359374oal.4.1710189669506; 
 Mon, 11 Mar 2024 13:41:09 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c18-20020a05620a0cf200b007871bac855fsm3014544qkj.47.2024.03.11.13.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 13:41:08 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:41:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v6 6/7] migration/multifd: Enable multifd zero page
 checking by default.
Message-ID: <Ze9sYV3pjfsP2_Lw@x1n>
References: <20240311180015.3359271-1-hao.xiang@linux.dev>
 <20240311180015.3359271-7-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311180015.3359271-7-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On Mon, Mar 11, 2024 at 06:00:14PM +0000, Hao Xiang wrote:
> From: Hao Xiang <hao.xiang@bytedance.com>
> 
> 1. Set default "zero-page-detection" option to "multifd". Now
> zero page checking can be done in the multifd threads and this
> becomes the default configuration.
> 2. Handle migration QEMU9.0 -> QEMU8.2 compatibility. We provide
> backward compatibility where zero page checking is done from the
> migration main thread.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


