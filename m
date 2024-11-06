Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A091D44D75
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gzs-0007PF-TD; Wed, 06 Nov 2024 09:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8gzq-0007Ox-Uf
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:26:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8gzp-0000P7-4l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730903215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TO+sQUOb4E6qYZjLgK8v9LziU6QipUHhJhEXG3s4EKc=;
 b=RFTN0KincfZ4ieYDnhkqazWFymokqIWUEFmfiY3Lu3RQS7BMc+C4PWrIuPTdrm0ntvyj9M
 s2r98fURNo6cB4CFBdCXv8gVgRABm7ef1RCvlb5zOy/TC/c8NK+PG7aXKGSvj9PHQXnPwL
 7Udf4nqIEhQhc3ZUycAE9HowQFDHCTQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-7wOcdRtHPA6fg_4Wfw01XQ-1; Wed, 06 Nov 2024 09:26:53 -0500
X-MC-Unique: 7wOcdRtHPA6fg_4Wfw01XQ-1
X-Mimecast-MFC-AGG-ID: 7wOcdRtHPA6fg_4Wfw01XQ
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3e601553a1fso6446992b6e.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 06:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730903213; x=1731508013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO+sQUOb4E6qYZjLgK8v9LziU6QipUHhJhEXG3s4EKc=;
 b=vbU8WIU0RBKnUNhqUrhITvop4ji2587yWIwj5I8F+W5h+1i1MdqlFjAu11IuJcyF6Y
 oeFxN7ZhV6SX2AbGkdV4qnlYwxaGVJ9mI0NHPYlxiVTeeP0F7khomR0XivZgI9linP0U
 pfI3YOhu4xKzMP5qUHGzBihj1CRRcbWRhkO8XshsmFz2JbMpbf1BX+fJI2Ee8t65a9YI
 nBK/17cA9XvfeQZnSNy7ETBEHgFBe1ypbOz4FiMQc+kWIOLray89xyj17paqk9A4bboQ
 kCtUlsWsd7dYSiYw9l6+2sl0XmHXIBc/zhM0BQJqN+O1JFmLU42h2/R/R2E5/CQ9BLB4
 7ZHg==
X-Gm-Message-State: AOJu0YxKwv3p91YMi2LeeYyuALOVcy8+IYW2v14qh/RVye7OrMaXEyfw
 RbIJN2wXgisw6i1Zr5LRBQ/ZKsnFSETwIccgNn0AL1k7zlpjgVJ38hwVdTJArYyKFn0ekVWOczu
 Rjz/troh31r7pCNMvSq1/K5PnIwIE7kbdRzecUccPSoHh8rZgXSgC
X-Received: by 2002:a05:6808:1207:b0:3e6:2f0f:43dc with SMTP id
 5614622812f47-3e758bfd092mr18754730b6e.6.1730903213250; 
 Wed, 06 Nov 2024 06:26:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEQI0KXGr/14VelB1zXiBaVRnZWESZYNSwo911GUC6luISbw0kYiNk+vKpEHf5dxKS/4XnTQ==
X-Received: by 2002:a05:6808:1207:b0:3e6:2f0f:43dc with SMTP id
 5614622812f47-3e758bfd092mr18754714b6e.6.1730903212968; 
 Wed, 06 Nov 2024 06:26:52 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e661190d14sm2996610b6e.6.2024.11.06.06.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 06:26:52 -0800 (PST)
Date: Wed, 6 Nov 2024 09:26:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Steve Sistare <steven.sistare@oracle.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Why the wait for reviews / advice from armbru?
Message-ID: <Zyt8qjKuE0Rfho_Z@x1n>
References: <87v7x0o75w.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7x0o75w.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 06, 2024 at 01:53:15PM +0100, Markus Armbruster wrote:
> I've been dealing with a health emergency in the family.  I've had
> serious difficulties focusing, patch review in particular.  I apologize
> for letting you all down.
> 
> I tried to cc: the people who I believe are affected, but the list is
> almost certainly incomplete.
> 
> While this situation persists, maintainers should feel free to merge
> without an ACK from me when I'm too slow to provide it.

Thanks for the email, Markus.  Just want to say that you've never let me
down, which holds true now as well.

Please make family (and yourself) as first priority, which I'll do the same
if it's the case.  Wish the best that things will go better soon.

-- 
Peter Xu


