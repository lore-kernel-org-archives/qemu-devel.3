Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3977E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ8DS-0007Sa-BE; Tue, 24 Dec 2024 11:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8DQ-0007SR-Nn
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:57:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8DP-0007Tm-A5
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735059421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+g5XBTZ6NCPc6pCoX1dA3TI46vkN9iqQQkc8PbtVpo=;
 b=PssxbqkwbPkdR8kLhIc/OyFBwocB0SuUVJVxT5uILHeXxZJ0hoqP0ObmDNf/F1kVqnn3+E
 fusuBVl9pwHUUaky595mhdbK0DEL9Q5TQFLaDzhcR0kJE8aGPJp3mpZDYMG84vjSMrGb3f
 8Z90mzDP8R5HfeGD9den8DBJC8L2ZDU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-xKsOMDqOOmCrwGLoQGYvQw-1; Tue, 24 Dec 2024 11:57:00 -0500
X-MC-Unique: xKsOMDqOOmCrwGLoQGYvQw-1
X-Mimecast-MFC-AGG-ID: xKsOMDqOOmCrwGLoQGYvQw
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6faab8334so817107485a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 08:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735059420; x=1735664220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+g5XBTZ6NCPc6pCoX1dA3TI46vkN9iqQQkc8PbtVpo=;
 b=aecM752nE1w5+se6BaIt//1rPsfxtz/8QWO16DQwVIg8zY84vXKQPD6MirpLgE2K2L
 9RqDlUZEMG2waLGw26LTVBEJobko3W5SZurD0m9KpVJ9SjZMfpA8AOqB6QU3FXqxBmLh
 lXK1nrTlc9uoegIuBoGMuRdfUk/XVEbqAFZGxCUlBlMNR3/WeHZIllZjc4oh9MI+VBw5
 XgKZTwpp8boEOf5uVlL2jboNFrMFFDmnuVHNsw/7B/cWbc73IgblQq2T/ctTy6Mlqab3
 deqwSaF/9i/+nKbpqdKPQlJmK5xy1tXCNukHUtUNzcfJeQ0GSUxVGLf0Im/IA4taZRAu
 9xpQ==
X-Gm-Message-State: AOJu0Yxf3p97GB2WdoQy42AB9/DWoEYfuGgmfv+vlsIWe0s9AcjEQcz+
 0V3JX6Uqr5yMoCoCduhVYwUor4PojldfyK9456Gz4a6ij5DXBHUIZVfATE7evK16NyQLPzy6SdK
 3XU+z+5iqL/lQoDxwvyazGy8zTEBkod9supYWC1LqYSNJtd9qQs0B
X-Gm-Gg: ASbGnct8Sm2aA8RDx9RhcDJ/6dzDm8913qUK9cg4p1hcKB1iQyx44N8aWdJlMKh7chB
 w0fDe6N4SQ3E6ofRtq9RqjWASjvmNoW0k7q+TY3vBe6fL3DfSifoeAYPy7uMO7PWeXCPBijYvYo
 LMQxqhHWSAfnimKksJDmRTm6mlfZPZigPSPnBKbmlutjFi0OK9p543Lt1JPAwvW5WhY7WQRvGY7
 WOH55M5eGb3f/BLER998CiRhweHLLtbwB5fjNE+DweITROhpm2Z3pIX/RUVwTBMFDl5X3SklJ/e
 wHkYWMTgtExOwRIOeA==
X-Received: by 2002:a05:620a:6019:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7b9ba7abf91mr3426355285a.30.1735059419825; 
 Tue, 24 Dec 2024 08:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKfM9CMEK0302stqY4uoranYfHRcB5MO7KETkUgSNQaC6d1GNH97JofLh4EEbhCKmGgYAx/w==
X-Received: by 2002:a05:620a:6019:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7b9ba7abf91mr3426352485a.30.1735059419572; 
 Tue, 24 Dec 2024 08:56:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2df5a5sm482757885a.43.2024.12.24.08.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:56:58 -0800 (PST)
Date: Tue, 24 Dec 2024 11:56:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 01/23] backends/hostmem-shm: factor out allocation of
 "anonymous shared memory with an fd"
Message-ID: <Z2rn2Imq1IEzNMXL@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Dec 24, 2024 at 08:16:46AM -0800, Steve Sistare wrote:
> Let's factor it out so we can reuse it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Better attach your sign-off here too.. especially when content changed.

[xxx: fix build for !posix]
Sign-off-by: XXX

With that:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


