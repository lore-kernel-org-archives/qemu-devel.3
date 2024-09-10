Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25604ECE58B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snv10-0001fF-Tj; Tue, 10 Sep 2024 03:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snv0z-0001el-Os
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snv0y-0000Sz-4T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725952213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oOX6cOVT1Kdz8jmnBkIPWo5ukqdAQGLFFwQKyS0eYUM=;
 b=LQv93Eo+WDZa/Gf9WVEab51JKJYaw+A5N4i8GHLRj6aWWHq1b6cqkcJuu0ffKeNy7CXRzV
 nqzqsX/JnpYCG36Y7YuzPnZsTZv09bLm+zaKm5Ie2WwGr5B4/6M/lX0LylmowvP8G4yzmN
 INkL/nCebl7NCENunvoZpkBSs8rSYWY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-vJXLwOZiO1e43Z9RKoeKlA-1; Tue, 10 Sep 2024 03:10:10 -0400
X-MC-Unique: vJXLwOZiO1e43Z9RKoeKlA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb857fc7dso13394645e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725952209; x=1726557009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOX6cOVT1Kdz8jmnBkIPWo5ukqdAQGLFFwQKyS0eYUM=;
 b=loF2B3frWyU6MfFxSMYlnHzlZPDfPpgIqCUq8E/bnf8cIUaBUnmSxdQGUexLgX9yFj
 8NaOfOo0OaT26oj9ln4WBqMqNEGrtgwP0+jc4iD5B/PHTZg1KClaNnmmggnv723daytg
 w2TOzek4qwRGUCrwJlgtdDUK8/4bc90I7S39GcQVjCqYuGA71SV7M/nUNxNeWrrP+Ia7
 Jd4dSnh6jCPqyAMj0zfmymXwRkVuW4CdpmD7s2A9+yuBPuph1vMDEWmGUTIGIsuWQJNX
 4q/AgLOfqesRSOCmI8+l/7OfE3TyT0F9R8AME4BvkusQ69GyMTBIwF5htVwrTPHRdfUT
 pP5w==
X-Gm-Message-State: AOJu0Yw5lKOKtYVwjhu2r9Op1MlFQ1GiuxbL26ryXx39z7DzSiZWgAG5
 r8STU0HWk14R4DcoJh/Wd0VBfVOi1kp0Ab+3tExb9HgP/r/U1pGSC0Je7MHSRnDjTxFol0pC6WG
 j3NZubnGEV63nG1nPDKTvo+nbqEke9YgWdn5PdvL+IU6o9Dnt+jIL
X-Received: by 2002:a05:600c:1c21:b0:42c:bad0:6c1c with SMTP id
 5b1f17b1804b1-42cbad06f22mr29801605e9.18.1725952208960; 
 Tue, 10 Sep 2024 00:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcGnK2F9ITxbFHcYHdm+n6wvXO4tCB24zQYo85x2MsY5bAfqQ4eQKPNwmwVIcwpdNvC07pNA==
X-Received: by 2002:a05:600c:1c21:b0:42c:bad0:6c1c with SMTP id
 5b1f17b1804b1-42cbad06f22mr29801215e9.18.1725952208099; 
 Tue, 10 Sep 2024 00:10:08 -0700 (PDT)
Received: from redhat.com ([31.187.78.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca0600651sm134047875e9.32.2024.09.10.00.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 00:10:07 -0700 (PDT)
Date: Tue, 10 Sep 2024 03:10:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 0/2] Solve vt82c686 qemu_irq leak.
Message-ID: <20240910030754-mutt-send-email-mst@kernel.org>
References: <cover.1719690591.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719690591.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jun 29, 2024 at 10:01:52PM +0200, BALATON Zoltan wrote:
> This is an alternative appriach to solve the qemu_irq leak in
> vt82c686. Allowing embedding an irq and init it in place like done
> with other objects may allow cleaner fix for similar issues and I also
> plan to use this for adding qemu_itq to pegasos2 machine state for
> which gpio would not work.
> 
> BALATON Zoltan (2):
>   hw: Move declaration of IRQState to header and add init function
>   hw/isa/vt82c686.c: Embed i8259 irq in device state instead of
>     allocating

This looked like a simpler approach to shut up analyzer warnings, so I
picked this one.



>  hw/core/irq.c     | 25 +++++++++++--------------
>  hw/isa/vt82c686.c |  7 ++++---
>  include/hw/irq.h  | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+), 17 deletions(-)
> 
> -- 
> 2.30.9
> 
> 


