Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D9C636DC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjLH9-0005Kc-EP; Wed, 28 Aug 2024 12:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjLH7-0005JS-5B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjLH4-0002h8-Rw
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724861516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMddJ2V7nEqQLgQNoF40ygmw1z9burtjuPPujwvcwTc=;
 b=ESyj3b2tXlM201eXNQUtr/Zluronb9qi4edFXJEMtXr8678CNyLGkhxeFacPWqVVE+4kn5
 l+oLhNu56Y12N1A5S0xq+aTuTKaz7eai/BpTVacXeBIQfvjPDu+RNiaTVPOy5dyi5CJGZq
 ldHdRbz/QLpD0EbL3UFXDQ/zRTMP7iQ=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-aQJ9O47MM3WHhiy1NWAf0g-1; Wed, 28 Aug 2024 12:11:54 -0400
X-MC-Unique: aQJ9O47MM3WHhiy1NWAf0g-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-270183411aaso8720891fac.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 09:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724861514; x=1725466314;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMddJ2V7nEqQLgQNoF40ygmw1z9burtjuPPujwvcwTc=;
 b=Vbhmomus8aindsywMkJSgaG1eJbunVQWNrHxcm/yc3I+K2ueEDs47MuQ9rN6aCaMU7
 fEtEEpjmcD6LQGUZxQdFcnKMfSZf827gEoJW9H2Fa/ggGN74+4q7mdXOzfaJPwiZ4TAT
 LT5rNO77JzZFUvYhyScs+bVrBMXipl5Lcplra/FwaWLhhkE3cyXBybHms+gvU1heRe/j
 Adj10UeCuiGFvQ7qxRdJOngICKNvc83gj8M8ptcoRRbrXCXw6bYq1HZOjmWIv60cgBBt
 aX2+JeYQE+AdrgpXG/uAzaffkYBbYBWXGxD0O8QH9BOfU+95KjgxjJPn7swPAKL0UGz+
 aOEg==
X-Gm-Message-State: AOJu0Yy3eCbASNatBpZVwhMgMkP7AyNZ/y3cjp/xlRIZOVhqRRw2QxeG
 k2abRTJjNrRI/nFD4frlbghGWmfKsgoFILAxmvALPPU6EbDqG5CKW6P60kNGuQ3thlYlqgDW/Ax
 RZXjYHI5Qmd2eghoqMwuU39CkTu9T67mEI3lqgxJy9EvW/IN9bVYo
X-Received: by 2002:a05:6870:d1c3:b0:269:2550:4305 with SMTP id
 586e51a60fabf-2779007efb1mr73044fac.4.1724861514077; 
 Wed, 28 Aug 2024 09:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmsYKK1U/kimAaXSODBJmrmWNewkfkaS6haBpqWVvV/e2YCxf5aloth3wCKoXbgRaGI+2Ofw==
X-Received: by 2002:a05:6870:d1c3:b0:269:2550:4305 with SMTP id
 586e51a60fabf-2779007efb1mr73003fac.4.1724861513743; 
 Wed, 28 Aug 2024 09:11:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-273ceb6bc74sm3887133fac.36.2024.08.28.09.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:11:53 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:11:50 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
Message-ID: <Zs9MRpTnGQ7opGed@x1n>
References: <20240828090743.128647-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828090743.128647-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Aug 28, 2024 at 11:07:43AM +0200, David Hildenbrand wrote:
> As reported by Peter, we might be leaking memory when removing the
> highest RAMBlock (in the weird ram_addr_t space), and adding a new one.
> 
> We will fail to realize that we already allocated bitmaps for more
> dirty memory blocks, and effectively discard the pointers to them.
> 
> Fix it by getting rid of last_ram_page() and by remembering the number
> of dirty memory blocks that have been allocated already.
> 
> While at it, let's use "unsigned int" for the number of blocks, which
> should be sufficient until we reach ~32 exabytes.
> 
> Looks like this leak was introduced as we switched from using a single
> bitmap_zero_extend() to allocating multiple bitmaps:
> bitmap_zero_extend() relies on g_renew() which should have taken care of
> this.
> 
> Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM hotplug")
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Tested-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> * Move the counter to RAMList
> * Use "unsigned int" instead of "ram_addr_t" as type for the number of
>   blocks

Thanks.  I'll pick this in the next pull if nobody disagrees (or beat me to
it).

-- 
Peter Xu


