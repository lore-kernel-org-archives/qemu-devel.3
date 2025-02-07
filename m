Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF6C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSgy-0006OT-M2; Fri, 07 Feb 2025 13:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSgw-0006Nz-7S
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSgu-0006sm-Lo
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738951379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBk0L7or9/QFMfON30R9cD+TsfOcgyuynUBAaCzFm40=;
 b=DPuKiLKeY8snzeBC5bdIWZBxKxIhRmcgnC5iIErSWLlBQPzx+c/8Zb6viMnDUljR/AG9rH
 wYzyfkWgl1H4R1Dc3XpTils/nkVVcdXU41bFPdioILvTpi5tjsexeUfvQes9YLp9ognjv1
 y2vPDHGMuTKCYAIKVnSldktRksc4uA8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-uB5bxVS-NIm_QtansxpVOA-1; Fri, 07 Feb 2025 13:02:58 -0500
X-MC-Unique: uB5bxVS-NIm_QtansxpVOA-1
X-Mimecast-MFC-AGG-ID: uB5bxVS-NIm_QtansxpVOA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7be8f0c72b8so401326085a.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951378; x=1739556178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBk0L7or9/QFMfON30R9cD+TsfOcgyuynUBAaCzFm40=;
 b=dkz7eGHrO7+Ngpc8AFS9UoHEIccNYbOv9rqE11V/17O3f3IEvkoF9mpHAWqGiyc2tf
 IJn2i1C0lTiPqsYZe/ihg/XKOg9kge95FY/cA/5AkLCsA0ir68P04WBXitDxstYcBfb9
 oiByecfNF+Sm9O7zzC/EpYXJXwNnRgD/mv6LbJdy55yjNUrk+vO7+g02muCdOapqWYzg
 6I7/FTTs1zu+WBMqrXG1Vbr0mNJ3ARAp0TVbOZ2mV5biYvOewrrWwtSjmJZU5059MEWl
 43h4y0WamjMeYMEnW+J9C3UUjZ5Z7q4kBoXowYOC+HdwOXnn3DF0J6NmSWORzeE7aDJC
 0PhQ==
X-Gm-Message-State: AOJu0YzvSds57XjMuChWAZ63KfWM2zCbYj/4kaJDkpXZUhS8DsGjDD8D
 N1B8EDjVXD7/Fe0Ve9xbjaNsyRy8NFaDgPOwxkb1MJpEKhQChnPEBYlSg+8Sr972ztxjl/9cnNv
 Etm3nkRRM5JU9rw+1vQIs0zPCPVci7lqN0M5D3LSwAiTp3MsUF0hqNvWNR2Jk
X-Gm-Gg: ASbGncsg4n+xhWYI9g8yJfCF9CvwnhL5/B8G1M8PNtTHfnCubX2d5xSbGOX5zzhgQOO
 ZuGZwcZGldjudTC9qz7vAUEgodDTh8mS59AC01AuiNjHVPXufERNxkKuF4hMJs1vLSkFVUiMg1N
 1eQEzr9v/gwC395usTnV3nFHtSYWm0tFgIy4MABykPzfmGLYA+B9GsufHS7FvZBklsoG2H3+1e6
 xd1T1v3mK5umm5oOtn+UobVLMbHq+FC9IobD3/MkKECxA40By6aE4kRAb96bXvbVOAMX5EQPtkC
 CIoCjWzP3WT8flWJ30FlNAZRAAimshZSmx7Ra2GOf7Ehyz2s
X-Received: by 2002:a05:620a:440d:b0:7c0:a2:e68a with SMTP id
 af79cd13be357-7c047c575bbmr645567385a.30.1738951378072; 
 Fri, 07 Feb 2025 10:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQtfVrtMR82IQChSGLRGTd+y7KCY1Kco91lsFe1asSrfqLXi2ZSQkMh+BVUv+3JANRKqr2lQ==
X-Received: by 2002:a05:620a:440d:b0:7c0:a2:e68a with SMTP id
 af79cd13be357-7c047c575bbmr645563285a.30.1738951377773; 
 Fri, 07 Feb 2025 10:02:57 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041e9f9bfsm218491485a.74.2025.02.07.10.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:02:57 -0800 (PST)
Date: Fri, 7 Feb 2025 13:02:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 4/8] migration: Check migration error after loadvm
Message-ID: <Z6ZK0E_IT6dobvE5@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207142758.6936-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 07, 2025 at 11:27:54AM -0300, Fabiano Rosas wrote:
> We're currently only checking the QEMUFile error after
> qemu_loadvm_state(). Check the migration error as well to avoid
> missing errors that might be set by the multifd recv thread.
> 
> This doesn't break compat between 9.2 and 10.0 because 9.2 still has
> the multifd recv threads stuck at sync when the source channel shuts
> down. I.e. it doesn't have commit 1d457daf86 ("migration/multifd:
> Further remove the SYNC on complete"). QEMU versions with that commit
> will have compat broken with versions containing this commit. This is
> not an issue because both will be present in 10.0, but development
> trees might see a migration error.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/savevm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bc375db282..4046faf009 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2940,7 +2940,11 @@ int qemu_loadvm_state(QEMUFile *f)
>  
>      /* When reaching here, it must be precopy */
>      if (ret == 0) {
> -        ret = qemu_file_get_error(f);
> +        if (migrate_has_error(migrate_get_current())) {
> +            ret = -EINVAL;
> +        } else {
> +            ret = qemu_file_get_error(f);
> +        }
>      }

IIUC this one needs to be after the patch that allows pre-mature
terminations from old qemus?

-- 
Peter Xu


