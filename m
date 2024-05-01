Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752D0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 15:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2CGt-000285-2E; Wed, 01 May 2024 11:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2CGs-000261-7B
 for qemu-devel@nongnu.org; Wed, 01 May 2024 11:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2CGq-0001wh-HF
 for qemu-devel@nongnu.org; Wed, 01 May 2024 11:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714578803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rfcFBh9MZBqRRCUwLc8ydDFX2OK2w2oQrKCzD1yGI8=;
 b=fyNR0ifKABInHkYUwRWxymnXEdBe7cPCxsyeQ8VXWXJGwD5zLVyv4FGDa/G2Cg9fAdz9JE
 KL7MpHNhFx8SvFg6IVximAtmMh+Y84LAEpVWRKI09MfLQR0WSSioLi/RHKVpTZDwccIUxz
 5xYEpEQPsi3s58ELg/NUYP/yhi5lfGE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-3nCpDvB7MfutT2Hbe90EKA-1; Wed, 01 May 2024 11:53:22 -0400
X-MC-Unique: 3nCpDvB7MfutT2Hbe90EKA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6f0556064ecso587418b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 08:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714578801; x=1715183601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rfcFBh9MZBqRRCUwLc8ydDFX2OK2w2oQrKCzD1yGI8=;
 b=KX2ZS/ImsPZelR7qsRi3Efp9l+SbV5HUmvocAZGl3BeBHCrRiYgON7U29zIZsCVk6Q
 ywWrnaQgtW86ploM2NnDWWxkhHMkdNo5XMwHQXuAg3Lz8+JfgyLKuWTGRZ2U4WHgWIM/
 Q00KcNleAs1ZmimQa1MCZkBusd0Ubi37LYFyctl3cPrYEWdtDvvg7L5ghwP0DAZRnlmn
 cCbyEKmcv44SLPhLs85AFm9Gdv0z5tEKoVTnyLmn4CAtSPU+ZSw75XeiiPGGHqZDihMW
 INWutgz1rQVJuFpuIZVIVTmPBPItmGLVjj9UZ3ZavK1++3hzXJzcG9VGXudi9fXEKXBG
 haRQ==
X-Gm-Message-State: AOJu0YxJzLZ8gftfG1TZO1HeYE1s02GCnjKLopHfJXe3XRbVTWJLJsa+
 w3CGgksXMoRMKG12Tix+z06SNNZScwM40Wrtq29culUAeS7JUNxRrH6F3QP4KNtlrXAauehsUoj
 bsy7kbrZ2JQ3+jmRLVdRLzJzspJ8habuFdhOP9CafLOcnXuuzAyyBIv5seiML
X-Received: by 2002:a05:6a20:dd9f:b0:1ad:8a2b:8744 with SMTP id
 kw31-20020a056a20dd9f00b001ad8a2b8744mr3349255pzb.4.1714578800754; 
 Wed, 01 May 2024 08:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAjUsFYIZeXWcLVrxjXVDQc5dGBk3S6DT6McqzWu4LJ9Z2Gh2wEICLGenLhua5CIaYTY7UHQ==
X-Received: by 2002:a05:6a20:dd9f:b0:1ad:8a2b:8744 with SMTP id
 kw31-20020a056a20dd9f00b001ad8a2b8744mr3349212pzb.4.1714578800039; 
 Wed, 01 May 2024 08:53:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n7-20020a635907000000b0061236221eeesm6713228pgb.21.2024.05.01.08.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 08:53:19 -0700 (PDT)
Date: Wed, 1 May 2024 11:53:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v3 0/6] migration removals & deprecations
Message-ID: <ZjJlbG-E0B4rdbJv@x1n>
References: <20240430142737.29066-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430142737.29066-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Tue, Apr 30, 2024 at 11:27:31AM -0300, Fabiano Rosas wrote:
> since v2:
> 
> - removed some more stuff which I missed:
>    blk/inc options from hmp-commands.hx
>    the entire ram-compress.h
>    unused declarations from options.h
>    unused compression functions from qemu-file.c
> 
> - removed must_remove_block_options earlier in the 'blk' patch
> 
> - added a deprecation warning to outgoing/incoming fd
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1272385260
> 
> v2:
> https://lore.kernel.org/r/20240426131408.25410-1-farosas@suse.de
> v1:
> https://lore.kernel.org/r/20240425150939.19268-1-farosas@suse.de
> 
> Hi everyone,
> 
> Here's some cleaning up of deprecated code. It removes the old block
> migration and compression code. Both have suitable replacements in the
> form of the blockdev-mirror driver and multifd compression,
> respectively.
> 
> There's also a deprecation for fd: + file to cope with the fact that
> the new MigrationAddress API defines transports instead of protocols
> (loose terms) like the old string API did. So we cannot map 1:1 from
> fd: to any transport because fd: allows *both* file migration and
> socket migration.
> 
> Fabiano Rosas (6):
>   migration: Remove 'skipped' field from MigrationStats
>   migration: Remove 'inc' option from migrate command
>   migration: Remove 'blk/-b' option from migrate commands
>   migration: Remove block migration
>   migration: Remove non-multifd compression
>   migration: Deprecate fd: for file migration

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


