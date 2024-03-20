Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9255EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwxG-00046f-PM; Wed, 20 Mar 2024 10:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmwx6-0003yd-23
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmwx2-0008LQ-8U
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710944994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0JOYkmBhkovPIKTos+0ZM+y2Bw3eORfQ+1fwgF5t8Y=;
 b=ElRMyVlO2e5r9exZxvZvM39QzrLh1dE8LSSY620/imDapM8VVw6+y/fvI9X06aXc90nVcm
 k4R31L5DK95GCLfnXJ7NWsqHln/lPxLmXZOsRrEV1YGxQjRMY5AkX7a+AzhKYWef52oF8a
 B+B4hN3M2UTQ5N4uwbZpHKvBZuWG5MA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-GNwhbOUEOtaPWM2x88uekw-1; Wed, 20 Mar 2024 10:29:52 -0400
X-MC-Unique: GNwhbOUEOtaPWM2x88uekw-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6e6ae0d2cf5so29354a34.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 07:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710944992; x=1711549792;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H0JOYkmBhkovPIKTos+0ZM+y2Bw3eORfQ+1fwgF5t8Y=;
 b=Ic0UrOVh5q6SBIhTlYwfeSnH+kHXttHTOf95ExH/8u5hZ3OWVq0flx+tOmPmstiG+i
 OHJyCkz2pKf8odQSQAHUqhGwVCYT4zyypc8E0aND5ERQi5ke+VdseN+r7v1tetI4XuHM
 KB5FArWse55N08e0M60+vY0zrhCuQn+YXODaOKJt0qR9B3J3+grhOjKvetSbmuZL2LYH
 7t2HFAF3lAy5TCKedAKi7ueSEmQ9tWuA7qaDVtIiP5jhQ/K4JCddLxTEEvzFliry+7AB
 /1Nx1IYGbd/JdzVMwwuDsgrx7CySePs4vkKFl5JEevZUy9OCKworu7VYstHt8I6Q+pmB
 /xZg==
X-Gm-Message-State: AOJu0YzkriQ9WM5ds+2HgGysngmeTNYs+w9FWJrt4rRj3HUzIvaZevhR
 R1crVy+HCY1XzF57p1ys4miATWLLlAncl2r6SCxhAevruyheXiT+46ww6zQNuXWjGd3F3RJ04t2
 n5RiiGJu0J3Nv+9ffybxc7FBp76wMDanT8C0kbO/EYO90BsaOSi1T
X-Received: by 2002:a05:6808:211d:b0:3c3:750c:2b6d with SMTP id
 r29-20020a056808211d00b003c3750c2b6dmr5902218oiw.3.1710944992123; 
 Wed, 20 Mar 2024 07:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVZLxweMIJy3NT7oxKVyWoT0Urcp6lp6RHviOnIviVpHKIQzQdGG7MSGHif1O7XcCnaayzRQ==
X-Received: by 2002:a05:6808:211d:b0:3c3:750c:2b6d with SMTP id
 r29-20020a056808211d00b003c3750c2b6dmr5902194oiw.3.1710944991600; 
 Wed, 20 Mar 2024 07:29:51 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j3-20020ac85f83000000b0042f200b4508sm7503926qta.96.2024.03.20.07.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:29:51 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:29:49 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH for-9.1 v5 06/14] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <Zfry3UXOfMVfOofa@x1n>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-7-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320064911.545001-7-clg@redhat.com>
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

On Wed, Mar 20, 2024 at 07:49:02AM +0100, Cédric Le Goater wrote:
> This prepares ground for the changes coming next which add an Error**
> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
> now handle the error and fail earlier setting the migration state from
> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
> 
> In qemu_savevm_state(), move the cleanup to preserve the error
> reported by .save_setup() handlers.
> 
> Since the previous behavior was to ignore errors at this step of
> migration, this change should be examined closely to check that
> cleanups are still correctly done.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


