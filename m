Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01301C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJmO-0007ZQ-Sh; Tue, 20 Feb 2024 01:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJmN-0007Z4-IJ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:38:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJmM-0002vs-2T
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708411136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BmqrMREPpQhfu/AKmxbVmfwkfdulwmcCMb4PezywGk=;
 b=jCMPbVTsWWL/10w5nBQNsNkAy1+Airuusm/nAbJZNwX8A2fsInyBnXK9SiGgJ0aF7lEFxQ
 82tBbg9waJ3ktAvEILdM7o4srM6ZZmfnYAZUhduQmB9zGkarHrI+Gw12l3EcNFSqgez5VF
 nZNRIkrLF/hVNpMegVrlq6SPsKD9SBU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-wGnSMz4jNiGgr89Yqz8xag-1; Tue, 20 Feb 2024 01:38:54 -0500
X-MC-Unique: wGnSMz4jNiGgr89Yqz8xag-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso1398695b3a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708411134; x=1709015934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BmqrMREPpQhfu/AKmxbVmfwkfdulwmcCMb4PezywGk=;
 b=h3CCDw3HjtLfCqFSwqEGNRKWjVO4bfLAAo+P+1bOcXv7zyFxk+8p660myh6R5VXqJ/
 TvzwoI0YcUpdePnIYcDtKnWJ7CicC03mwxtfya0oO3wTiZ4+k4cztDRn/Wi81/LSnfpn
 pQju8wwpBSrat5KiFILroMiIKSJFpAAiOCV7s4GX9VYTD+7MqBrqtKPh+FRcdnHZwejD
 zqWVJBnLuHQ5OXIiLe2daanUJmPm2+8sgBTLrX9osrwMuAHqZzr+P9hpi9sTaGjagVLW
 s+i9+fg28JGNxc571FGQYXzJ4rPVyFKesEJ3qI2xA45tbjmJnxdZAH7vN4lzGOI5sisD
 Tj+A==
X-Gm-Message-State: AOJu0YwNQ3dKfQ88ZWTIoJ1PRbpCj3XxJxLDm3f3FkaFDFolOP5g0SVY
 5xqzWixDZlVd7lwqiHEsSXV6JPSIcBMABGyEYroeNnVwJ//TRL3eL1ZKvD89/mlF101X8G51mM7
 /UqMWUcVijkhlEEVREtN4h3rHvWAJU7JJhwjIkvGt0ZOuGfhSzd+v
X-Received: by 2002:a05:6a00:189c:b0:6e4:7148:508d with SMTP id
 x28-20020a056a00189c00b006e47148508dmr3065200pfh.3.1708411133750; 
 Mon, 19 Feb 2024 22:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb7/WtIp8pDfhx6czKErfL9GCDWbgFGiZ4DsH7/aUFq9STiXImm+07Fh9L+6pquGPbHzEftw==
X-Received: by 2002:a05:6a00:189c:b0:6e4:7148:508d with SMTP id
 x28-20020a056a00189c00b006e47148508dmr3065186pfh.3.1708411133366; 
 Mon, 19 Feb 2024 22:38:53 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e24-20020a656898000000b005ce998b9391sm4860982pgt.67.2024.02.19.22.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 22:38:52 -0800 (PST)
Date: Tue, 20 Feb 2024 14:38:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 04/13] migration: MigrationEvent for notifiers
Message-ID: <ZdRI8VEorWRZGe5N@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1707418446-134863-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 08, 2024 at 10:53:57AM -0800, Steve Sistare wrote:
> Passing MigrationState to notifiers is unsound because they could access
> unstable migration state internals or even modify the state.  Instead, pass
> the minimal info needed in a new MigrationEvent struct, which could be
> extended in the future if needed.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


