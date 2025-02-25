Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA1FC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwEg-0006KN-AD; Tue, 25 Feb 2025 09:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmwEY-0006Js-Cn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmwEU-0001aF-Rz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740494905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEtQP47RAlZqnEt0Vy/CSjZv53uus8MFp0Y0L+rmou8=;
 b=O0DSmKiYSd/wf7zNMmvHKzji6wRGFeV6AUtOKZtBaKvv6XZ3wFHgTGTPEwmOK4PQ4xHWIV
 Qan8KeGWbcphXHZgGr8Yu2abTWoSdyG2s/gDU4vSivvrgW7MR48z1yJ1rRt5NXgEjTH/kQ
 i7V4RKRoYOylFxy+/YrQwwH4K5Ev0BU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-2b66kzECNeKgqfMeG68IGg-1; Tue, 25 Feb 2025 09:48:20 -0500
X-MC-Unique: 2b66kzECNeKgqfMeG68IGg-1
X-Mimecast-MFC-AGG-ID: 2b66kzECNeKgqfMeG68IGg_1740494900
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2add2f6f16dso8707554fac.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740494900; x=1741099700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEtQP47RAlZqnEt0Vy/CSjZv53uus8MFp0Y0L+rmou8=;
 b=rm2mtnbzyj39lqMb3xzcvgBjWRfo5fCeKDtsghE0QBim7mbaY+o3AM0XcsR+cy8XsR
 RFJEKMLjR4385wIyAuMy6YReTwLtXW3LDMSVwCvZNu4fzCqhZyeaug3rKJ+0BKZHIgO8
 D3isbowbSdpLHnO99Y4+c+97pKksb9Ku/+g3OtKJOEARJQH338g+Nji3O3iEI1+Ev5v9
 BWiLGKtjhvVF1cMCW4MtECCNPTU7kmjkNz8+8hF1R6/o+S9cgKlAZzC5NaZpjvaJTN6H
 3dEsQdnP2EhONPHt6tronJqHWM8UCDmr+lqZsvRP94P5/Bob3az1ajr+UJmH+WDvX0lI
 V7Fg==
X-Gm-Message-State: AOJu0YwEkYf+SrQ/m9O0IyvZsSvykR+Tx+dF9RgHZPyUx2IH3lAMF9z1
 4cfqa20DKMfQaJWVd5HnIlDqvAQK4U5PkJtvLF5rkBSkvfcl+nFU/jyA3vFjfSd6HCcMWDFBdb7
 j5te0zyXI1QqceqTZzqiU0HHqUKTkEWuzatVyjWovzzjca5jbITl9
X-Gm-Gg: ASbGnctyoDLnDKS19BWzDHHPi3oX9ZWtdbIfbIrj23hOeZqr+aTCxbo/6s+e4oSwnt7
 Imo/HyklLJTRsQC5fILcfKIG8ZOM/9hVuzspVmO0qdzIIH8j2vbva1lgvRYPE6x7VDQxMdy57x8
 ePhb+Qa08oU4tgHiEpUOompjZNE13M2S+zVn81kCDYZQIYlXWeu6tKGOp0ZXTXYrlWWFjtvfY2n
 gsgMDdZuxYgU2L0pr4+9Q2bXqdyJvE4ZI1YxKkdDTGczSboPf1rnMG3VFlBRoiohz+ABg==
X-Received: by 2002:a05:6870:169d:b0:29e:4cab:5954 with SMTP id
 586e51a60fabf-2c10f2e75b7mr2241522fac.17.1740494900143; 
 Tue, 25 Feb 2025 06:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjo/+6w4VXWDnBYwpHzGyJj5uz2gq+dXgUAXtbavU3Gf6RPbE3SlFx9pxfbkK+jG5wJdb53w==
X-Received: by 2002:a05:6870:169d:b0:29e:4cab:5954 with SMTP id
 586e51a60fabf-2c10f2e75b7mr2241507fac.17.1740494899800; 
 Tue, 25 Feb 2025 06:48:19 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c11128723csm399662fac.18.2025.02.25.06.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 06:48:19 -0800 (PST)
Date: Tue, 25 Feb 2025 09:48:15 -0500
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/8] migration: Add
 migration_capabilities_and_transport_compatible() helper
Message-ID: <Z73YL3VnrmxHxZ5M@x1.local>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-6-lizhijian@fujitsu.com>
 <Z7zPYfWp2fLRB63W@x1.local>
 <8e363920-aafa-4991-b633-fa9473406b17@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e363920-aafa-4991-b633-fa9473406b17@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Tue, Feb 25, 2025 at 06:37:21AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 25/02/2025 03:58, Peter Xu wrote:
> > On Fri, Feb 21, 2025 at 02:36:09PM +0800, Li Zhijian wrote:
> >> Similar to migration_channels_and_transport_compatible(), introduce a
> >> new helper migration_capabilities_and_transport_compatible() to check if
> >> the capabilites is compatible with the transport.
> >>
> >> Currently, only move the capabilities vs RDMA transport to this
> >> function.
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > 
> > Yeah this is even better, thanks.
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Hi Peter,
> 
> Thinking one step further, this patch looks promising and can check
> most situations. However, on the destination side, if the user first
> specifies '-incoming' (with the startup parameter -incoming xxx or
> migrate_incoming xxx) and then 'migrate_set_capability xxx on',
> the function migration_capabilities_and_transport_compatible() will
> not be called to check compatibility, which might lead to migration failure.
> 
> To address this, without introducing a new member 'transport' into the MigrationState
> structure, the code might need to be adjusted to this:
> 
> The question is whether we need to consider it now(in this patch set)?

We can do that in one patch.

> 
>   static bool migration_transport_compatible(MigrationAddress *addr, Error **errp)
>   {
>       return migration_channels_and_transport_compatible(addr, errp) &&
> -           migration_capabilities_and_transport_compatible(addr, errp);
> +           migration_capabilities_and_transport_compatible(addr->transport,
> +               migrate_get_current()->capabilities, errp);

Here IMHO we could make migration_capabilities_and_transport_compatible()
taking addr+errp like before, then..

>   }
> 
>   static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
> diff --git a/migration/options.c b/migration/options.c
> index bb259d192a9..59f0ed5b528 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -439,6 +439,29 @@ static bool migrate_incoming_started(void)
>       return !!migration_incoming_get_current()->transport_data;
>   }
>   
> +bool
> +migration_capabilities_and_transport_compatible(MigrationAddressType transport,
> +                                                bool *new_caps,
> +                                                Error **errp)
> +{

..  here fetch global capability list and feed it.

> +    if (transport == MIGRATION_ADDRESS_TYPE_RDMA) {

[1]

> +        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
> +            error_setg(errp, "RDMA and XBZRLE can't be used together");
> +            return false;
> +        }
> +        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> +            error_setg(errp, "RDMA and multifd can't be used together");
> +            return false;
> +        }
> +        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> +            error_setg(errp, "RDMA and postcopy-ram can't be used together");
> +            return false;
> +        }

We could introduce migration_rdma_caps_check(&caps, errp) for this chunk
(since [1]), then...

> +    }
> +
> +    return true;
> +}
> +
>   /**
>    * @migration_caps_check - check capability compatibility
>    *
> @@ -602,6 +625,15 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>           }
>       }
>   
> +    /*
> +     * In destination side, check the cases that capability is being set
> +     * after incoming thread has started.
> +    */
> +    if (migrate_rdma() &&
> +        !migration_capabilities_and_transport_compatible(
> +            MIGRATION_ADDRESS_TYPE_RDMA, new_caps, errp)) {
> +        return false;
> +    }

... use migration_rdma_caps_check() here, might be slightly more readable:

  if (migrate_rdma() && !migration_rdma_caps_check(new_caps, errp)) {
      return false;
  }

>       return true;
>   }
>   
> diff --git a/migration/options.h b/migration/options.h
> index 762be4e641a..ca6a40e7545 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -58,6 +58,9 @@ bool migrate_tls(void);
>   /* capabilities helpers */
>   
>   bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
> +bool
> +migration_capabilities_and_transport_compatible(MigrationAddressType transport,
> +                                                bool *new_caps, Error **errp);
> 
> > 

-- 
Peter Xu


