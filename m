Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC948C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmx9J-0002Ob-0j; Wed, 20 Mar 2024 10:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmx9I-0002OS-7L
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmx9D-0002ix-Nv
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710945750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lmYNCVj1qYxPr/KiXOpLo9If0W3ioxfEJHjY6ipJGAg=;
 b=KMkEieClrqdb1HKf3Rs+hXMmu5JxJ4BTs0AtWNHsIxLdz1R+PLslw7XQgcxvLzcgesAmF3
 OmVtqyI8dqs+DBnzDHy5fgt7rK8pk+sENHHJpYqY4hjQYmu8tij/REP/ivuynHSQ58Ruq+
 +k/ggYRwGX88KeJXTQGjnNOIyQcUyy0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-YjNhyDHyNSG3iSs7zuirmw-1; Wed, 20 Mar 2024 10:42:28 -0400
X-MC-Unique: YjNhyDHyNSG3iSs7zuirmw-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c386baa6feso804591b6e.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 07:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945748; x=1711550548;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmYNCVj1qYxPr/KiXOpLo9If0W3ioxfEJHjY6ipJGAg=;
 b=iTafgEjkMeP40NUjClyMG09usgpBPBsa42RiOYgjjysW9ZuQhtpPGaBe8rkozJMQMd
 Z0EI6+dSYr9dNMH+VWTz+jLlYTuFd0vxFdrZysrnJ0FwxP0a85+wo/0oqZnkEGwfNtBz
 zOjzwVgo90bNhyG5BrVPwlasyVcR4QNEdVYPGrPZroay+BxAFKfv4n/gGB+exHSMI6My
 jhuQe3pOLpDBk/7YzZ338PGFQTc8goshUkws3KKBz6eZIDmp6QvnieWXej2e+/iBC5eZ
 s0HCVBVdA/HYlpSluNRGr5tXJOdBPiXF7ihvDGi+SReh5Vc+Qjns5fph8UTDlfVyccEV
 R7wQ==
X-Gm-Message-State: AOJu0YwtOiQmcBh06XNYNn6RIhQxaySM917U25zEF2+xTYlFJuy80wHL
 PohPzqYLH0oPrD2qCgh1m7dBkbXV4R9hw4kmEuuZiWpn14Obb0SfAkW+b+kYqER80TvnRN9yHXq
 6O2jhC2Xd77Fh/ofxwCUVubHu/DMtQZdtp0Y7QhEb4h0FDLfgIxB3
X-Received: by 2002:a05:6808:1508:b0:3c3:62e8:b257 with SMTP id
 u8-20020a056808150800b003c362e8b257mr17461011oiw.2.1710945747855; 
 Wed, 20 Mar 2024 07:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG1VX1WcbuhKZfwJ8zAztngTa7EDORJFVVDVVSW2Mx3OJakfgoqiSm2eUrIxhK5KuwSOm0dQ==
X-Received: by 2002:a05:6808:1508:b0:3c3:62e8:b257 with SMTP id
 u8-20020a056808150800b003c362e8b257mr17460978oiw.2.1710945747404; 
 Wed, 20 Mar 2024 07:42:27 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ge16-20020a05622a5c9000b00430b79aaa1esm5775620qtb.94.2024.03.20.07.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:42:27 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:42:24 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH for-9.1 v5 09/14] memory: Add Error** argument to
 .log_global_start() handler
Message-ID: <Zfr10JG2dTChsLVj@x1n>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-10-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320064911.545001-10-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

On Wed, Mar 20, 2024 at 07:49:05AM +0100, Cédric Le Goater wrote:
> Modify all .log_global_start() handlers to take an Error** parameter
> and return a bool. Adapt memory_global_dirty_log_start() to interrupt
> on the first error the loop on handlers. In such case, a rollback is
> performed to stop dirty logging on all listeners where it was
> previously enabled.
> 
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Still one comment below:

> @@ -3014,8 +3044,11 @@ static void listener_add_address_space(MemoryListener *listener,
>          listener->begin(listener);
>      }
>      if (global_dirty_tracking) {
> +        /*
> +         * Migration has already started. Assert on any error.

If you won't mind, I can change this to:

  /*
   * Currently only VFIO can fail log_global_start(), and it's not allowed
   * to hotplug a VFIO device during migration, so this should never fail
   * when invoked.  If it can start to fail in the future, we need to be
   * able to fail the whole listener_add_address_space() and its callers.
   */

Thanks,

> +         */
>          if (listener->log_global_start) {
> -            listener->log_global_start(listener);
> +            listener->log_global_start(listener, &error_abort);
>          }
>      }
>  
> -- 
> 2.44.0
> 

-- 
Peter Xu


