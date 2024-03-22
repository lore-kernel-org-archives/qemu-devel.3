Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EDBC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 13:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnf9m-0002nO-NK; Fri, 22 Mar 2024 09:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnf9k-0002n8-CF
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnf9i-0005qS-Ih
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711114914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJo7/irORUSfHBxyzyE4PWgRdMa4wnSQmwiLtA6ROhw=;
 b=LJmS/0bsUohjx0lR2PFruSgMaqDKzZqKUBhcNnEP4W3MqlMfRQfSMiV1V3roLDniXeCg1t
 A3ofJ+7gubJsvwlzYJlalXl44gTbLTk1z0YlI10aBAMnCsCc0elVOMHiFpZmImKDkhwECC
 cuPfrIIsXoK44Sc0mjHUzUL1QbjDK2g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-cq1ACqEIN5u0NiG5ChWEVg-1; Fri, 22 Mar 2024 09:41:52 -0400
X-MC-Unique: cq1ACqEIN5u0NiG5ChWEVg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4311d908f3cso8291051cf.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 06:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711114912; x=1711719712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJo7/irORUSfHBxyzyE4PWgRdMa4wnSQmwiLtA6ROhw=;
 b=QjWLwfiw3F4h6UlsKwr6/MvEPceZNrwDLgcpErb3pCQlIJ8H7G7wpmoGUfTjUSX3xR
 TeGMIgHtHmV+zsy9elcaxr8ZXzGEDu+R3KP/rnNWYUgYEvZXLittDJgHTEFhGBvFZi9f
 vLgtGLCF5m1XhhkvJSlk9cVjEnuGqP9X2ihaBcRbnmKqwGq6k5pV2I8jBHjAK2fsNP1e
 P8Dtu4PVmQbDm/f2nOLzhQqtqsCydMVMWS3IW2KOSv+VO9Gm3FNTxB/EujtQs3eKD8eW
 mQb4wxvBKymKBwlui/e6EqciSp8+NK18jWHc1htPGzb/At5xG/QyHzndAn83fPJOo+fm
 W3zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsW/sFAK508XKHJsLbYYHZpA6tnVpYEgHESKo0EWiNrIGxD3CTbZ015GitKvzNLpnwSZEFSpgjSudOVVq1sjo9XfdjvPg=
X-Gm-Message-State: AOJu0YzSHghE7w/Sl7z0DqEI4rfdiJHVOsNyIcqLUQ7GXqPyuO3sXHFi
 BLndJBRBv2+mgdq2E5av7virhj5L+bVGyfi8jPJgcKUNykwFNewicsBVIkkfGiN1SxIOZutw9Pu
 7vTp/ddw2ZC2WPJb+8fuTb8OdB0Etk7w85LCeoLGo6yMQsmdPYVmz
X-Received: by 2002:a05:622a:1828:b0:431:30cb:4fd2 with SMTP id
 t40-20020a05622a182800b0043130cb4fd2mr2022570qtc.0.1711114912075; 
 Fri, 22 Mar 2024 06:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/0+yKyHflKpE6YElewzeWCB+HqYA1SbGgHWmnOQVycDPda2C/eX5ZaxeqW0tzatM+wiLZog==
X-Received: by 2002:a05:622a:1828:b0:431:30cb:4fd2 with SMTP id
 t40-20020a05622a182800b0043130cb4fd2mr2022539qtc.0.1711114911504; 
 Fri, 22 Mar 2024 06:41:51 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 b16-20020ac844d0000000b00430b772f3dfsm869813qto.55.2024.03.22.06.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 06:41:51 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:41:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, xen-devel@lists.xenproject.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: Re: [PATCH for-9.1 v5 11/14] memory: Add Error** argument to the
 global_dirty_log routines
Message-ID: <Zf2KndZqH5WYdAVL@x1n>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-12-clg@redhat.com> <Zfr-W0aubJC_lfaK@x1n>
 <CAK9dgmYyV-vH8YA=vkL8afXMByCTdnYUNM=XtG8xv5kpu4t6_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK9dgmYyV-vH8YA=vkL8afXMByCTdnYUNM=XtG8xv5kpu4t6_A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

On Fri, Mar 22, 2024 at 09:55:18AM +0800, Yong Huang wrote:
> Indeed, for the GLOBAL_DIRTY_DIRTY_RATE and GLOBAL_DIRTY_LIMIT
> dirty tracking, they should handle the failure path of logging start.
> The work may be done once the current patchset is merged.

Thanks for confirming this, Yong.  I think I'll go ahead and queue it then.
It should be in the 1st migration pull for 9.1.  Thanks,

-- 
Peter Xu


