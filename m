Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED22C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh2qc-0008H3-KK; Mon, 04 Mar 2024 02:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2qU-0008Gl-Cg
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2qS-000126-6L
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709537682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CtbuyYqZ5mjXis4yPRb0LicOqIQtfi+Ci0BmQxrMaRo=;
 b=MFaVnVJfOgad2EzsKkuje0Yb1kNCXvmM8rMQffgRH2exKV1ex7OfXayc7qAsQotghHOjX4
 923eArzjpixEV4TLBEYv4+l9FmBEPVlkwSa4nPbHfg4rHPIkx7uqYAMxHLUEZL00EL77l7
 WaQX6Fn5YBPCHaKD3XtbgQK6FQcicBc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-XkCRa7EDMImPyP2qDfSYbw-1; Mon, 04 Mar 2024 02:34:41 -0500
X-MC-Unique: XkCRa7EDMImPyP2qDfSYbw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-299565dfd2dso854113a91.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709537680; x=1710142480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtbuyYqZ5mjXis4yPRb0LicOqIQtfi+Ci0BmQxrMaRo=;
 b=cMaEjK5CYFDaxrSQNWHZ3XWEObTu12VBCe8xEnUXY76HGfpDMVOvTGpVGJfxToYgT5
 ouRLnyBgLqKW+odzhXYbJ6ITfCqEy9ZExrx79OnPIbweTsmGBE7/kk6RQl96Ov6W9chc
 QC2qyLPRjcTrRFDqg4dcT8Su3n3zggsZ7cHqcWV+DzFpMlBcBRtf9TglGpLtkyPV0q7v
 1OXwzMmi+LoRXeAI31QEwLMAepliffdyO4FgqlV+8dvA/nAK3Kia1hL96HJculKpFWLX
 FI6qBSHgNac+dGo9muWH3xIJAdMHlPBpildiMajTxAW9onF41apPQcFrVB3LfMlUq71Z
 WbDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE592vEG6WjiVuyWLiddP3ZKIvqpNb5WiodNqM62jGbrzWRCendILYFqed1hf00RgceUArLTGqHZrCV6pDA9c9GjFv9D8=
X-Gm-Message-State: AOJu0YxlWFE1SXvTw9ahnFvZhsDP8lVkzS4m7tJj/QJvdCUQpjwEdzwF
 ayQpdT5EVrZGKzg2IhQ1bq5SbpEaxaVQZN4SBcqShgdVR07pbr3DWCz2BlyqXIRvMQD3C45CYtP
 wkyNmhVD8CgLVusFVJ2cxfWNOsIy/O9z0JeD6wgMZaaG3mnTs+v/RuRJuQpT3FXs=
X-Received: by 2002:a05:6a20:409c:b0:1a1:4793:b6f7 with SMTP id
 a28-20020a056a20409c00b001a14793b6f7mr4826785pzf.6.1709537680084; 
 Sun, 03 Mar 2024 23:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ4JnSIBxCIUGF5xLqFsCbkXxX5qhCUIMmHXE2rxO/YL/lU77c8kn4uC7jDgIX9O8fQc8z6w==
X-Received: by 2002:a05:6a20:409c:b0:1a1:4793:b6f7 with SMTP id
 a28-20020a056a20409c00b001a14793b6f7mr4826766pzf.6.1709537679796; 
 Sun, 03 Mar 2024 23:34:39 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i4-20020a056a00004400b006e5ed7c0b35sm3136455pfk.67.2024.03.03.23.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:34:39 -0800 (PST)
Date: Mon, 4 Mar 2024 15:34:27 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 7/7] Update maintainer contact for migration multifd
 zero page checking acceleration.
Message-ID: <ZeV5g8nuP2NpYQ5v@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-8-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301022829.3390548-8-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 01, 2024 at 02:28:29AM +0000, Hao Xiang wrote:
> Add myself to maintain multifd zero page checking acceleration function.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65dfdc9677..b547918e4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3414,6 +3414,11 @@ F: tests/migration/
>  F: util/userfaultfd.c
>  X: migration/rdma*
>  
> +Migration multifd zero page checking acceleration
> +M: Hao Xiang <hao.xiang@bytedance.com>
> +S: Maintained
> +F: migration/multifd-zero-page.c
> +

Firstly appreciate a lot for volunteering!

My fault to not have made it clear.  This file alone so far will need to be
closely related to the multifd core, so whoever maintains migration should
look after this.  It's also slightly weird to have a separate entry for a
file that is tens of LOC if it's already covered by another upper entry.

What I worry is about vendor/library specific parts that will be harder to
maintain, and migration maintainers (no matter who does the job in the
future) may not always cover those areas.  So I was expecting we could have
volunteers covering e.g. QAT / DSA / IAA accelerators.  Since all these
accelerators will all be part of Intel's new chips, there's also one way
that we have "Intel accelerators" section to cover vendor specific codes
and then cover all those areas no matter it's zero detect accelerator or HW
compressors.

I'd suggest we discuss this with Intel people to check out a solid plan
later when we start to merge HW/LIB specific codes.  For now I suggest we
can drop this patch and stick with the feature implementation, to see
whether it can catch the train for 9.0.  IMHO this is a good feature even
without HW accelerators (and I think it's close to ready), so I hope it can
still make it.

Thanks,

-- 
Peter Xu


