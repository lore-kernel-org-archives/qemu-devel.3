Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BA1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yz7-0003rl-FN; Thu, 02 May 2024 12:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Yyu-0003p1-Jb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Yys-00050O-Bn
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714666100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG4WaHKnvZvbUTAgY6ELVXY3qEaB2xuIBuG0iDdebyQ=;
 b=ehBWtgkeL/ihAvrgGsEYkLZxpKQF4vH2ooZARWhIAMm2vOGaLc5DpmB3EXGMV8skPi73ps
 FHRinpYKzIJITnN2NHv+jo5Wp/K6iDHgCqlRXsp2zT4VFHX0Z5LaHIgdok6suDRSd6507T
 JXS9fQmo4Lc/OmLctF4wzgX71KflAwI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-fzdxR7wJOiKk32CmyjjDGw-1; Thu, 02 May 2024 12:08:18 -0400
X-MC-Unique: fzdxR7wJOiKk32CmyjjDGw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a103d524fdso447466d6.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714666098; x=1715270898;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gG4WaHKnvZvbUTAgY6ELVXY3qEaB2xuIBuG0iDdebyQ=;
 b=AbV/oSYA2cI4jemAdj+wPPkrzFx6eEsVy2GdOCffwY85DjUvqiGz/NHYJATx/84IqT
 SyzrUFcfy4Jd3W/NQi5TaeZAhHemVp2AlTkCpImGKb3WT05lgGkH/1jLN3zTRYh3Xg0s
 PE95KPWKYwin3a92xO5HaTyfeZ3d36BPg8hJCMPLrGnIHPaS0SzzN/wU982p0hePJ9GK
 S+UoxhRCe2a+qAFIm/tuFMMGBnvi1L1NaqlnpsUnQIqMca/1C3Evp2j05x+4IbGWDCE3
 wePLC0GMUB0IbgURf+GggwF9OGtHLdwGEvowQQyMsatp7shEjxM+mynzfQEYtHUWQNI8
 5ffQ==
X-Gm-Message-State: AOJu0YxottZlqOXHnBtyprb2c540He9BOn9J9G2BHtQivmCUcNxyv12k
 9rQvqQWagqSR2VUVma6Nf4rhZh7Lp3kpyQ6r5jcBlJoAopnPlNrIBO5G41JHdaYbewQ8xAXuP2r
 JHNYqytjvMHJ4O14H5ip8hs0WTEUQOl0bdvUqCaxLcccc7rHTdK/7
X-Received: by 2002:a05:6214:d4f:b0:6a0:b3ec:8ff2 with SMTP id
 15-20020a0562140d4f00b006a0b3ec8ff2mr6057629qvr.5.1714666097525; 
 Thu, 02 May 2024 09:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSqXHI3njkf/BGvLCzFkxOkuakb0iAyLMPE323EHbMbn5AHpvULdpZAL1m+KIE+cYG47SCBA==
X-Received: by 2002:a05:6214:d4f:b0:6a0:b3ec:8ff2 with SMTP id
 15-20020a0562140d4f00b006a0b3ec8ff2mr6057565qvr.5.1714666096712; 
 Thu, 02 May 2024 09:08:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 k9-20020a056214024900b006a0fbcab221sm457157qvt.3.2024.05.02.09.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:08:15 -0700 (PDT)
Date: Thu, 2 May 2024 12:08:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: qemu-devel@nongnu.org, mgalaxy@akamai.com, lizhijian@fujitsu.com,
 jinpu.wang@ionos.com, elmar.gerdes@ionos.com, armbru@redhat.com,
 berrange@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: Update the reviewers for RDMA migration
Message-ID: <ZjO6bi52Egfw_01G@x1n>
References: <20240502103538.243789-1-yu.zhang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502103538.243789-1-yu.zhang@ionos.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

On Thu, May 02, 2024 at 12:35:38PM +0200, Yu Zhang wrote:
> As the links [1][2] below stated, QEMU development community is currently
> having some difficulties in maintaining the RDMA migration subsystem due
> to the lack of resources (maintainers, test cases, test environment etc.)
> and considering to deprecate it.

This is true.

> 
> According to our user experience in the recent two years, we observed that
> RDMA is capable of providing higher migration speed and lower performance
> impact to a running VM, which can significantly improve the end-user's
> experience during the VM live migration. We believe that RDMA still plays
> a key role for the QoS and can't yet be replaced by TCP/IP for VM migration
> at the moment.

We need numbers, and that's also what I was requesting.  Per my
understanding this is not yet compared, so IMHO we shouldn't state that
before we have some test results.

Note that I'm not NIC provider, I don't sell cards, I don't earn anything
out of it.  However I want to make sure commit messages are true and fair
when I review a patch.  It also matters when I want to provide more
information to future QEMU users to not misguide on how they should see
RDMA under any doc of migration section.  IMHO we can continue the
discussion in the other thread to finish it, rather than rushing on a
MAINTAINERS file update; nobody is going to remove the code without
finishing the discussion so no worry.

Besides, there's also what Dan used to ask on the possibility of wrapping
RDMA channels with QIOChannels.  I thought it won't easily work, but again
definitely be nice if you can help to double check with your RDMA expertises.

> 
> Jinpu Wang is the upstream maintainer of RNBD/RTRS. He is experienced in
> RDMA programming, and Yu Zhang maintains the downstream QEMU for IONOS
> cloud in production.
> 
> With the consent and supports from Michael Galaxy, who has developed this
> feature for QEMU, we would like to take over the maintainer's role and
> create the necessary resources to maintain it further for the community.

So I suppose this patch is not yet ready for merge, either we need to wait
for a true test results coming, or we just need some refinement on the
statements.

I hope I'm not asking too much here, but would you mind also provide a RDMA
documentation patch too?  It's under docs/migration/ currently, and now any
new feature is required to have such for migration:

https://www.qemu.org/docs/master/devel/migration/features.html

RDMA is not a new one, but if we want to keep it, let's make it serious.
IMHO it'll be nice to provide suggestions to user on when an user should
consider using RDMA migrations, or if it's only in maintenance stage we can
also mention there so we suggest people stick with TCP.  Basically we have
a place to provide a summary of all our discussions, so somehow we can
consolidate such discussion there.

Last important thing: you may want to copy Fabiano, he's going to take
whatever patch coming for 9.1.

Thanks,

> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00001.html
> [2] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00228.html
> 
> Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - fixed an email address
> - added "Tested-by: "
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1f692202519..fa9c62aae3e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3425,7 +3425,10 @@ F: util/userfaultfd.c
>  X: migration/rdma*
>  
>  RDMA Migration
> +R: Yu Zhang <yu.zhang@ionos.com>
> +R: Jack Wang <jinpu.wang@ionos.com>
>  R: Li Zhijian <lizhijian@fujitsu.com>
> +R: Michael Galaxy <mgalaxy@akamai.com>
>  R: Peter Xu <peterx@redhat.com>
>  S: Odd Fixes
>  F: migration/rdma*
> -- 
> 2.34.1
> 

-- 
Peter Xu


