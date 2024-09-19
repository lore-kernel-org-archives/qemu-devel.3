Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D3CF3963
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLEC-0007lS-7R; Thu, 19 Sep 2024 13:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLE3-0007Mg-P7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLDz-0001Fq-7J
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726767950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZbyOA9scaVSchpZftyGzzOJHSL66lELLtrNvl9bpMU=;
 b=BHXrg4bsnoGWghjgWA4zTKy2oZu7rEzxpckSOpJMd98iHhHqCrdJ1TAVHGQkj+q02u+LVc
 1w+aWZI88sphmcIRxB34WENVsi2CxCo1ob0T0ReeWhepze6rfndqku7pjXDxsFH8UuaTe9
 40HSyOsw7ngM3ajbGylbfixu9fVCBIE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-apRK_DhEOWqU2xvpNzM20A-1; Thu, 19 Sep 2024 13:45:49 -0400
X-MC-Unique: apRK_DhEOWqU2xvpNzM20A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c360967e53so19781646d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767948; x=1727372748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZbyOA9scaVSchpZftyGzzOJHSL66lELLtrNvl9bpMU=;
 b=mogVurSG/2SY6En3Vg8XshXq/aGfFfUIDYrthBlJJDEz0MJDzFVl9fcPLwHuk6a0LR
 M5Bf8aS5Ajp+4dAF32VPfSHYhoep2UeWKN9viL8LblV/RyAwPWJVXrDxWqszYSSgrr13
 C3U+gjiyHYf10hm7tuySI1juD0P1XMf2R2hpXf2Og2Yx9dS1/XS270GNoyTiKFlBd7qt
 F0F8TDsTFcrZAR/k2KKczsOVLfbCgnIw0XufQjwln//wtuA1RTZHsx8wgUbz2XiRFY07
 KIAXZjpepSvzdfLKBpp6GphEQMaefmwmRDrnOxkQENk+M9aYHkTXvQUJZt6zRiEFd7Zg
 ooyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIQeKRNMTuXth1WiwGESzZtZhBoASwx8zjbe5VANNdnJI3dFxqrTD8ImUAP0Ktv7oaWmiuBY76ZwdA@nongnu.org
X-Gm-Message-State: AOJu0YwrRIC730RlWCPzplVZy+Mw/3jxa+5QQmZuUOdnDGJKewp0p0sE
 TbM0n9bfQCMn2Ylzn0CrIUmjxu3FYvUgCP4BwkhpmlTy8tZ6deZbBAO+4Y7KGwSRZZ3HcOsQaXY
 S6BP0ndTrc9/9u559Ytuy4zjF1T5O5yOiukBTvz12ZHeANsHspqwKxt26GlKJ
X-Received: by 2002:a05:6214:4a93:b0:6c1:6a71:970e with SMTP id
 6a1803df08f44-6c7bc679b14mr1983426d6.5.1726767947632; 
 Thu, 19 Sep 2024 10:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF8XWc6nrANZExPoNtWgrXWGg+SvBVUsCZqova2ZQvkMfT2NxDhiADrDUquH0GqHftVRfhUw==
X-Received: by 2002:a05:6214:4a93:b0:6c1:6a71:970e with SMTP id
 6a1803df08f44-6c7bc679b14mr1983136d6.5.1726767947191; 
 Thu, 19 Sep 2024 10:45:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e57a646sm9639776d6.126.2024.09.19.10.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:45:46 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:45:44 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/7] migration: Deprecate zero-blocks capability
Message-ID: <ZuxjSHvVCwE220N8@x1n>
References: <20240919134626.166183-1-dave@treblig.org>
 <20240919134626.166183-4-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919134626.166183-4-dave@treblig.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 19, 2024 at 02:46:22PM +0100, dave@treblig.org wrote:
> From: Fabiano Rosas <farosas@suse.de>
> 
> The zero-blocks capability was meant to be used along with the block
> migration, which has been removed already in commit eef0bae3a7
> ("migration: Remove block migration").
> 
> Setting zero-blocks is currently a noop, but the outright removal of
> the capability would cause and error in case some users are still
> setting it. Put the capability through the deprecation process.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


