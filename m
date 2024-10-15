Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F917D216A9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0i46-0005Io-5E; Tue, 15 Oct 2024 09:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0i44-0005GD-63
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0i42-0007kd-FC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729000696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XXzHCkHrQ4f8orn9Ezo2iRrVTuDrUDWIKp/6Q5i8R60=;
 b=YX9gsmYt5ZYzBNInSJGNfw4q8XLopNA8+93AtqDvDf++C9iK6VsevCvBCc0XrPT2vHsebX
 RUzpAgromuPawCMBVo3ztpIF+NBB3u0fvOBTUWyVP0BnzpXcTL+GccA4dQXvkKuWTMwCVr
 oLGH0cwhHxhopmZ6eBgAUIwlAaCEoWo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-qfAHGxELPd6GtSWNF6MBkg-1; Tue, 15 Oct 2024 09:58:13 -0400
X-MC-Unique: qfAHGxELPd6GtSWNF6MBkg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbceb26182so95473436d6.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729000692; x=1729605492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXzHCkHrQ4f8orn9Ezo2iRrVTuDrUDWIKp/6Q5i8R60=;
 b=W1Qy7CnStroUlkfiRyepNP6AzprbTC0z7JFc1bHtzTYpbgOkqRT3xH4vQQ1iWgxUJI
 BtGGDgjLP4DQrICim15EJWihxrANJA5nWcd6L7pwKul/RONSmUToV1K4g5qYV5PBmg34
 XonfXq5BsK8vMMPOwg9ll4eB45ohUy9UgdPa/n37jcw5vB2TuitoOTFmARtbjXAPBu+D
 rn+iMXq9Cx+1sCqGrbq1cZRvKQs+r6unqcN8CrIk7f/GtRm9/edTZpJPWAgiNaLZ6thm
 4C9E9+gDwjU/Hcr5RUfttH2VVr3iuA5jJxRv5OJIQSWEaFj2ri7Dqpd7+5nIVYe4UC7e
 2bag==
X-Gm-Message-State: AOJu0YzNpeN7xHpYjP3bq1aJo9lPgnp3E6eyPYqnBZGvaPc6O9cK2tRN
 k2KJXhjQ/zrhaLZVJrIS2/aVoJAejabbUzDcQ9Mk0SiYLZTUDlGwp5QTB9SgZ8jpmwuzBR93Bqx
 alzHmKugSkrKIDZ+GMiZs+OJJu4lZmgoufrRYvztzUwBB5C3LX6WgaKRcfXd8LJHCNXfBt2Mxtz
 YimTqejk4BE5Y/Hz17sCfKPSXs0WPiQmOAjw==
X-Received: by 2002:a05:6214:398c:b0:6cc:53a:70b8 with SMTP id
 6a1803df08f44-6cc053a7112mr98055536d6.1.1729000692319; 
 Tue, 15 Oct 2024 06:58:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPpI9B7Wxr8OfIXsLVOuXaOqvWH6G3viViH6Q4T5dpJGd488FrXrKIGCxZPSLcvcz1jlmJaQ==
X-Received: by 2002:a05:6214:398c:b0:6cc:53a:70b8 with SMTP id
 6a1803df08f44-6cc053a7112mr98055226d6.1.1729000691738; 
 Tue, 15 Oct 2024 06:58:11 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22922df3sm6948616d6.54.2024.10.15.06.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:58:11 -0700 (PDT)
Date: Tue, 15 Oct 2024 09:58:10 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Yong Huang <yong.huang@smartx.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: Re: [PATCH] migration: Put thread names together with macros
Message-ID: <Zw508tdi8dg1PGzZ@x1n>
References: <20241011153652.517440-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011153652.517440-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 11, 2024 at 11:36:52AM -0400, Peter Xu wrote:
> Keep migration thread names together, so it's easier to see a list of all
> possible migration threads.
> 
> Still two functional changes below besides the macro defintions:
> 
>   - There's one dirty rate thread that we overlooked before, now we add
>   that too and name it as "mig/dirtyrate" following the old rules.
> 
>   - The old name "mig/src/rp-thr" has "-thr" but it may not be useful if
>   it's a thread name anyway, while "rp" can be slightly hard to read.
>   Taking this chance to rename it to "mig/src/return", hopefully a better
>   name.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

queued.

-- 
Peter Xu


