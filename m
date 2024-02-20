Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BFAC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 05:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcIS2-0005PO-Id; Tue, 20 Feb 2024 00:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcIRx-0005P7-SH
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcIRu-0006YM-Th
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708406025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XZRZmCW2Z5hbVk/OfhpU6ngnLeVK3g57Zs1cFOuiZ8s=;
 b=NJczoelWJ9ZKZ2uLrr2c3w2YGftfWOR2Ctv4A4z0MJisrQW1VbI/HR3lpHm7i2X8iJk8sG
 NSjmAIBV/vdUnAYFrhVO4BMYumZYkbhukVNOTQ8VLo07l975giEfe3YVkSCNeOFsdyG0x9
 LZEvqG8wsaAJJW5r7EFQL9oahg84ul8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-22ZN5RZPOma_GUWv5h86sg-1; Tue, 20 Feb 2024 00:13:44 -0500
X-MC-Unique: 22ZN5RZPOma_GUWv5h86sg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1da0dd1dec4so18621175ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 21:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708406023; x=1709010823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZRZmCW2Z5hbVk/OfhpU6ngnLeVK3g57Zs1cFOuiZ8s=;
 b=fqXYH8FObDMW8W5PvhFXb5/xFpPzGEPe1Z2VamBlLU+HNw8GEqdq3EEWiTuzkSSjc2
 O8L+eq+85hngTSlYqJphJpYzRTP8eZ3YfiMqpJxTm4aXb/H9b+PCCQAbVUSi71tfYBUE
 mJdESftTedhyfiMecyHW2iWAavTZchS89dQrvD7icpeByS04RTmU+V0PYH4cYBm6wIu/
 /s0DsMfb3FAmgNBeiHKCAMzmslizzwNDeMhzdXiDYYxDklcwLFx3fFRKZI/OFX/GnEFI
 NA05T9xo6dL+ah64lnf3kI8akCfgS+pR/xFlHDAnh76uBwkpNET4ftcESIU6Y7hVguPx
 WF2w==
X-Gm-Message-State: AOJu0YwK79liHnhEf3SN8vzgd41ZDyQ8ls6ZJegCznS7BuiyW4rYuDR2
 e4USG82vULGT8oQasz+1zGoBU6PPGkxaRtXRXU6DsjBogIqB+cyg0RYYiu5xECXQn2/6j/FbB6p
 BrdjU8rDzYqdNrIwhJokN/FD5eDeclIp0MeXJhub85QNWwzNqYAmh
X-Received: by 2002:a17:902:c24d:b0:1db:5b21:dcef with SMTP id
 13-20020a170902c24d00b001db5b21dcefmr12786040plg.5.1708406023036; 
 Mon, 19 Feb 2024 21:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe0FiSvmvnWryws+anxxt4Q2Z6vrTodiYQHYu2Q3fnTs5uT3Fjo69jpzBuAbdZh+BiLgWZkA==
X-Received: by 2002:a17:902:c24d:b0:1db:5b21:dcef with SMTP id
 13-20020a170902c24d00b001db5b21dcefmr12786030plg.5.1708406022720; 
 Mon, 19 Feb 2024 21:13:42 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 lo5-20020a170903434500b001db715d3bf2sm5259386plb.137.2024.02.19.21.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 21:13:42 -0800 (PST)
Date: Tue, 20 Feb 2024 13:13:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com
Subject: Re: [PATCH] ci: Fix again build-previous-qemu
Message-ID: <ZdQ0_rGwnUDeCG-t@x1n>
References: <20240213154901.109780-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213154901.109780-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

On Tue, Feb 13, 2024 at 04:49:01PM +0100, Paolo Bonzini wrote:
> The build-previous-qemu job is now trying to fetch from the upstream
> repository, but the tag is only fetched into FETCH_HEAD:
> 
> $ git remote add upstream https://gitlab.com/qemu-project/qemu 00:00
> $ git fetch upstream $QEMU_PREV_VERSION 00:02
> warning: redirecting to https://gitlab.com/qemu-project/qemu.git/
> From https://gitlab.com/qemu-project/qemu
>  * tag                     v8.2.0     -> FETCH_HEAD
> $ git checkout $QEMU_PREV_VERSION 00:02
> error: pathspec v8.2.0 did not match any file(s) known to git
> 
> Fix by fetching the tag into the checkout itself.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Oops..  queued, thanks!

-- 
Peter Xu


