Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0785C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicFP-0003HM-C2; Mon, 26 Aug 2024 12:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicFG-0002cQ-Ay
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sicFF-0008K5-0l
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724688423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLVbTSgvbph6ekMh45EFXWbdhxT+KXyojv6Mt8u22fU=;
 b=g81+7Ey5zI/E7ffUrNZsZTipJJkkSEVMrInX5uBqjb/mKUCt3zfxfaqGcl9VrXRQdIoQgM
 3i/0oX0yU9b1hfV0DngFLEKmzES9cLcIXEMedwph64bof45ToBmsEeVsusLmL6TGN3Epfw
 rCCRi5fyI9Cl7EWiGXXH02cy423FeJg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-SAqLFzlANxWJqDeB0rY2QA-1; Mon, 26 Aug 2024 12:07:01 -0400
X-MC-Unique: SAqLFzlANxWJqDeB0rY2QA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-454eb13cb87so50055861cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688421; x=1725293221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLVbTSgvbph6ekMh45EFXWbdhxT+KXyojv6Mt8u22fU=;
 b=Mv8z3Dp3dhEhoCundh13B6rknHeCja7w556hP3nVoP5M/ayKu3l/CTrfMq2Awh8woa
 muaJfW93dELQ8eaHhpPi9A1+tOSf7rOGPuXfICZj/ZRl151golkqAEKBpgr1LSLs4v7k
 5TachE+7uQ9YLNj81gQCO7/ORQ7wc7eifvcl+eukRy+++H1r3tGMgdLukv2U9wt+dxz4
 tVaPJ+M0FTjaTbbW8rWD0pOqlKQBz5QeisWr9wu9pAARhSTfoa167EZHNOr/SlwlgMQk
 xD5xcGhIj2NcUe8j4p6TJg0Gam0E9hkM53/QW/7D/r4RzBPvZczSbUyXCgItaGoyUq/T
 m9sw==
X-Gm-Message-State: AOJu0YzpnotSbpdQCdYkI34Nojp9a+P2p7qCrRKZGEl4gm1qE6W72TsG
 dnq3AtE8iNxd6UQOkSzMNvPMQpmIBpvKAV6tCDBRbvXQy2f+McLCS7NWlTnfR0rZcd1zfNyUe6w
 2WBs/+wEbNURxMAR96WiF8FCV0TACJ9hXFz1dFIJoYiv6GZv6uN8m
X-Received: by 2002:a05:620a:2484:b0:7a6:624b:3fe4 with SMTP id
 af79cd13be357-7a6897c42b4mr1050808285a.60.1724688421190; 
 Mon, 26 Aug 2024 09:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWg3qI2+f80fYiH68sOw1D9Rq7fSEftt2SXqe4Qe+XWDmRVvM6YKOq+QqUgoZE8ZP2hIVh3A==
X-Received: by 2002:a05:620a:2484:b0:7a6:624b:3fe4 with SMTP id
 af79cd13be357-7a6897c42b4mr1050805885a.60.1724688420844; 
 Mon, 26 Aug 2024 09:07:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f361c16sm470033785a.66.2024.08.26.09.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:07:00 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:06:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 10/16] migration/multifd: Isolate ram pages packet data
Message-ID: <ZsyoIpqGjwZ7ml-C@x1n>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823173911.6712-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 23, 2024 at 02:39:05PM -0300, Fabiano Rosas wrote:
> While we cannot yet disentangle the multifd packet from page data, we
> can make the code a bit cleaner by setting the page-related fields in
> a separate function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


