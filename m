Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B063DC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 18:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpNd-0004n0-32; Thu, 14 Mar 2024 14:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkpNW-0004mU-Iw
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 14:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkpNU-000654-9o
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 14:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710439227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLfUxa6NixFmJdLFPhEFsnuJd79UTlr7+4enp3IoP1Q=;
 b=D/qSZOZdbwNJRetI3SGwjUj/KvcLU4S+aLPUgtdZFA5VJ+YQzgCJ//VzFRCq+21kQv3Loa
 lbDq5VH9vDnvmJaqvSNxU/rhZY+L5VlHvCf+qVtPlZcAvy8uG/wtjkI0gNHk5R7ath64P8
 RrIhUWhgTII1vqlb6pVuGVltW1SShLE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-q1CvNSn4OJq4C2F2-sWgug-1; Thu, 14 Mar 2024 14:00:25 -0400
X-MC-Unique: q1CvNSn4OJq4C2F2-sWgug-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7887a0b8b09so8361185a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 11:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710439225; x=1711044025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLfUxa6NixFmJdLFPhEFsnuJd79UTlr7+4enp3IoP1Q=;
 b=PPt/0sfee4cSdwTppECeVWog5YfroHaNe/Fe/SPLGcLzjlqPIfW7S7vnBUYLeHiRgF
 yA8ENJS68+7Fo/u1yi0hAKr41rJCNc8I6pBgo4iM4yD0SyIm9quuthiLvgoqgg5K2rfH
 iAOT3S+vWrkunOpS0XTyjxBPM17E2WYFyYZ9wvk0Rk96YCog915dn14M7xTlwbAi0CKC
 JR9cUawdndi5QsPSfbmuxgWO1u4Q5gzqSujpwyGfvdo5jUeF/o3W52adxZx4N9g55YGf
 Yge/knTENC/s0osgQrtS6htrOX6+urGrIFncZkkVjg8mnyl4nNWhGA02QMvih8VCXLF+
 U7qw==
X-Gm-Message-State: AOJu0Yyri1FdzZnrNzsb6REJ1E3GhB3qAmngnuE/6sBX0RKzWFE7TM64
 3yzzl6QwnLa/yByJPtKYoY0G56jqBHMXsb+kvq3v9MMwf22gSJsPELDiB/4niml4dwwMCIoW99o
 VQbmGGgBC9PkjmnBti79YHwngRwiLgw46cFZ5HS19waWFW3U/svLm
X-Received: by 2002:a05:620a:460f:b0:789:d14b:3015 with SMTP id
 br15-20020a05620a460f00b00789d14b3015mr2892345qkb.2.1710439224906; 
 Thu, 14 Mar 2024 11:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqktCjaDjJ+qYL3dHHd6WSF8tutLJsC5wiYWyBjXV6lQCPKZNCz2sCJ/lUCDm2g1nhpAtoCw==
X-Received: by 2002:a05:620a:460f:b0:789:d14b:3015 with SMTP id
 br15-20020a05620a460f00b00789d14b3015mr2892241qkb.2.1710439223139; 
 Thu, 14 Mar 2024 11:00:23 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d7-20020a05620a136700b0078863e0f829sm162296qkl.12.2024.03.14.11.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 11:00:22 -0700 (PDT)
Date: Thu, 14 Mar 2024 14:00:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] migration mapped-ram fixes
Message-ID: <ZfM7NDuqz0cNMXnb@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313212824.16974-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 13, 2024 at 06:28:22PM -0300, Fabiano Rosas wrote:
> Hi,
> 
> In this v2:
> 
> patch 1 - The fix for the ioc leaks, now including the main channel
> 
> patch 2 - A fix for an fd: migration case I thought I had written code
>           for, but obviously didn't.

The two issues are separate.  I assume patch 2 will need a rework, but I
queued patch 1 first.  Thanks.

-- 
Peter Xu


