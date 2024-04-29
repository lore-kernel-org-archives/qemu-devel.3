Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AF4C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1X1T-0004mt-5L; Mon, 29 Apr 2024 15:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1X1R-0004mh-PI
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1X1Q-0003Nh-7s
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714420243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FbbhF4w0+MeReLJi5WG2LSz9550T3vBn8rajiRkWsgI=;
 b=ISG/04RjCOJ4RTzV2v3KI4EkjHlw3PbuoXguAHl/WyailpnmeNRxCj0q3kZx8ZcHS1ia4J
 VQs3Zx7r4/ue1Q8iRMJ+1MJqMVhCnI4kXC1uiX5PwK+cLEpUjr9RfKOG2tY7Lt1j69LA4N
 hWHAVQXrGLtB58FrqDysD9n5WoCCCYE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-eRPr4OuKPTayCF-W4_f5NA-1; Mon, 29 Apr 2024 15:50:41 -0400
X-MC-Unique: eRPr4OuKPTayCF-W4_f5NA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ab48d143e2so1576604a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714420240; x=1715025040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbbhF4w0+MeReLJi5WG2LSz9550T3vBn8rajiRkWsgI=;
 b=Xx29Q95lssYw4b4HKN4Ymm7YDWlynOmJl9jlVAQmie2YcGZb4q2SVuWPbRAApKA92X
 41YarqsxcMTyk4qmzneN07lc9W6SvQhOdpAoQUbvSSb28oQy/0sASINcxjIWAH54JpZz
 hqtZX/Q6G733Os7Sca3ZkNgWxWdypT2/tKxsTUtD1xISc49Mrg5pj7XxVF/M4PU+PYe4
 UHYPqtuG5EmngyNy4N5bjC6IyH4gMT7lSbSD8BHzYTecTDd7MSofnWaiIx+AZX4kRGX/
 Ci8FjWWM3goEgO1ZeZ3XON/FiteNkDrjS29TV5aewuEWxrNoynjMXIMQuvkE/RqDS8ut
 m+Iw==
X-Gm-Message-State: AOJu0YwfqvgO9nlv/i8NALb49hSsTvwsfnbib/g464MlVUsv4yIfEb3m
 rD0wRN3kEVJx/yBuqVfVHd8ultI88kJ6OYIr2PUVXhtQ9ziKwi9w7tEmnAnlNYebGg9QptZmx+4
 6gPWtRMLY3wa6QYiPFVEe5NuET/9Ba/qTt3b145FEsywzI20UEDZfUjNokrTs
X-Received: by 2002:a17:902:dac8:b0:1dd:b883:3398 with SMTP id
 q8-20020a170902dac800b001ddb8833398mr13225357plx.4.1714420240017; 
 Mon, 29 Apr 2024 12:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtAfXhnZfqFOeNqrg4Vn6bbv02WPAACxwkdHXPD5odhLN/H8FULGM2qdZcF4Dwoq3Pq7vvkg==
X-Received: by 2002:a17:902:dac8:b0:1dd:b883:3398 with SMTP id
 q8-20020a170902dac800b001ddb8833398mr13225333plx.4.1714420239328; 
 Mon, 29 Apr 2024 12:50:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 kg15-20020a170903060f00b001e28d7329e6sm20742595plb.91.2024.04.29.12.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:50:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:50:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/6] migration: Remove 'skipped' field from
 MigrationStats
Message-ID: <Zi_6Cxag3bbsJI9Q@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426131408.25410-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 26, 2024 at 10:14:03AM -0300, Fabiano Rosas wrote:
> The 'skipped' field of the MigrationStats struct has been deprecated
> in 8.1. Time to remove it.
> 
> Deprecation commit 7b24d32634 ("migration: skipped field is really
> obsolete.").
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


