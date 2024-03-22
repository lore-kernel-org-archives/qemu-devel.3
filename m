Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D5FCD11DB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 13:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfAS-0002sb-CG; Fri, 22 Mar 2024 09:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnfAR-0002sR-Go
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnfAP-0005tp-UX
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711114961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/wxqkuL+z3mlvutyHssgKbDmN/0tr1ojbJqawUy5Fk=;
 b=HxyyRd15QbAvPBo+fOSTp6oA3fkumc7KDfr/N+d08Sl2HoY+Qe/CGiQZnCN6W63xjgvbNT
 ciEmdU/OtWCEo41kxX+BDRKtFOpXtFlZ6Zx8WEWC9zWjMNl/9MXGdxjQjHHoDNAUSuXTpV
 1GNbK0SI0xFwjEemZ/rD3P4Uz5fOqqo=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-kOtawfsLNVig4lf52rrVPg-1; Fri, 22 Mar 2024 09:42:37 -0400
X-MC-Unique: kOtawfsLNVig4lf52rrVPg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4760502f2a8so355221137.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 06:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711114957; x=1711719757;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/wxqkuL+z3mlvutyHssgKbDmN/0tr1ojbJqawUy5Fk=;
 b=QG2FXXCded3lLXlgVuKHahT5lLR/QWhog5u82PYBMfVCEY2vEeHIv5/SA5ZnmTo0wo
 AASNciUuzcFgFuntCd+lNK7kmHJCrvuthA+dCdrwUKf0fHkMRz+tqoN7Fypbn2ZQNx/i
 4HSCGG1yEdcWq/pWAVo7c1ndsk638bo1eArJjfZMG8dGHa6x8iOv8KqLO9xF8OtF0Yx+
 rpWVd/Z10jJTY1O1fHLcgLI3OwTBtVtqPlMPYjTPxUY8ZEnUXdCLi11OfDXYGhXoxxPx
 t6SPuwO/mRSBMrx3Bh7MH0n6wiHl5aOLHu2cruMHQgVPQ4YQGcGP0F+A8Q+irIH5zrLh
 0Kwg==
X-Gm-Message-State: AOJu0YxVuYtKUZkTEqurClT789x+YbZIjIUzSCrJw7R8Lu0AAly8EZwQ
 PwiWc0u1o+p/MF2eivU6c2rZVHln+HDI8DI2MupEdXkWHFs4WoW629DQqAvifXx6RSxBWlpOK24
 y9sV0eKzz+wfjx4pNH9h4+oLwvwEpJeqjTzI5guQUCl8nTzqNvLqy
X-Received: by 2002:ac5:cdd5:0:b0:4d8:74f7:a280 with SMTP id
 u21-20020ac5cdd5000000b004d874f7a280mr1018367vkn.0.1711114956989; 
 Fri, 22 Mar 2024 06:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGPfUmdBlJ28N8J61/7zsKnHo0zaW/FYVrij7QfaW8+GvHr85LCSdkZkavkViJNzyV1zt3EA==
X-Received: by 2002:ac5:cdd5:0:b0:4d8:74f7:a280 with SMTP id
 u21-20020ac5cdd5000000b004d874f7a280mr1018340vkn.0.1711114956497; 
 Fri, 22 Mar 2024 06:42:36 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 5-20020ad45b85000000b00690befbe5a5sm1084011qvp.74.2024.03.22.06.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 06:42:36 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:42:35 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH for-9.1 v5 00/14] migration: Improve error reporting
Message-ID: <Zf2Ky03V8d-HQJtX@x1n>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 20, 2024 at 07:48:56AM +0100, Cédric Le Goater wrote:
> Hello,
> 
> The motivation behind these changes is to improve error reporting to
> the upper management layer (libvirt) with a more detailed error, this
> to let it decide, depending on the reported error, whether to try
> migration again later. It would be useful in cases where migration
> fails due to lack of HW resources on the host. For instance, some
> adapters can only initiate a limited number of simultaneous dirty
> tracking requests and this imposes a limit on the the number of VMs
> that can be migrated simultaneously.
> 
> We are not quite ready for such a mechanism but what we can do first is
> to cleanup the error reporting in the early save_setup sequence. This
> is what the following changes propose, by adding an Error** argument to
> various handlers and propagating it to the core migration subsystem.
> 
> 
> Patchset is organized as follow :
> 
> * [1-4] are prerequisite changes in other components related to the
>   migration save_setup() handler. They make sure a failure is not
>   returned without setting an error.
>   
>   s390/stattrib: Add Error** argument to set_migrationmode() handler
>   vfio: Always report an error in vfio_save_setup()
>   migration: Always report an error in block_save_setup()
>   migration: Always report an error in ram_save_setup()
>   migration: Add Error** argument to vmstate_save()
> 
> * [5-14] are the core changes in migration and memory components to
>   propagate an error reported in a save_setup() handler.
> 
>   migration: Add Error** argument to qemu_savevm_state_setup()
>   migration: Add Error** argument to .save_setup() handler
>   migration: Add Error** argument to .load_setup() handler
>   memory: Add Error** argument to .log_global_start() handler
>   migration: Introduce ram_bitmaps_destroy()
>   memory: Add Error** argument to the global_dirty_log routines
>   migration: Add Error** argument to ram_state_init()
>   migration: Add Error** argument to xbzrle_init()
>   migration: Modify ram_init_bitmaps() to report dirty tracking errors
> 
> The VFIO changes depend on the above. They are simpler and have been
> reviewed already. I kept them for another series.

queued for 9.1, thanks.

-- 
Peter Xu


