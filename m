Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD7E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 17:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIt8O-0007rE-RV; Wed, 04 Dec 2024 12:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIt8M-0007qd-3C
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 12:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIt8I-0006BP-AL
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 12:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733333148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S1+dnobDYZcZGLZdxeqoQpMIAbyBoTb7pnKIzfSuQu8=;
 b=gZj/jo0ZRpBWLxzoniaMEoOafzkLI/R8wZHdRrdmJskfL0G/Y2L0qZ6iumaMnalihmuYSJ
 17s4vizuUq1AFKr9H0jAXEGW7SIq/PgIVKE4m0p80sbqWl4oyeqTwkv4MaqfHkPIXMzaVs
 XfiM9FkgAZgEFrNjKJPHRsx1IlB0g5Q=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-r4GQGkNaMH6GdsYGk8RU0Q-1; Wed, 04 Dec 2024 12:25:47 -0500
X-MC-Unique: r4GQGkNaMH6GdsYGk8RU0Q-1
X-Mimecast-MFC-AGG-ID: r4GQGkNaMH6GdsYGk8RU0Q
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7e1527971so67762645ab.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 09:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733333146; x=1733937946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1+dnobDYZcZGLZdxeqoQpMIAbyBoTb7pnKIzfSuQu8=;
 b=DGU1BiCTYt4NqlCrxf0wNknZwkxp21qsVQO69RPvHTT2onI8/UTCGzYOIUuOcoSFZt
 8itPpRIRhr29WQJar6Rk6LGDkRvoeEk6loZiEVSQevoGor5A+1Vx3WgkJWlWo2NjuVGY
 xz5/1VK6YepTvua/utcVdqnGvQ99EOwN5/b1unrrwBJmoX560yu+NF1YPg1KFiBup+3t
 AOoSVnMXcVbvGLyRcn+XJJGPqogekw2b/RsMmHFQLy4k3OWNbvbRACkgPpAuWeWK2z60
 ax12TDgfVmBqJVzMPIp8rhNGKl8SZv4pT822roeEw5zaqkTrWvL5NBy3V536mAcIGkrV
 51KQ==
X-Gm-Message-State: AOJu0YyyHTTrfbaBUIKACy0SQXGXiGy+yW2Ae2bONcPIC6YkMgMQmy7m
 MirZX2J8osHQxS7dQRHCVlsDR5MvV3a2Y1wE0OSlqAv9QaeBhzwBqGEf5K02wLqc/jQrO92Fx/V
 Z+54s4lmaVkejM7VlBqboYAKF4hhW+eMpl8/b0Om3aH9QhAQxaVk6pSx5hROBi1A/nNnfOxG7ls
 MfdVlV9D4yu/L1mmsqkr289AAu2o9a1GlaGw==
X-Gm-Gg: ASbGncvEj4UKcXyIFlynq9S7jjr0Py0OP+Pimr/z80aUUzxMHEEIG+H9JuNm5oE7JN8
 5i7u+NPQXScYoNwVFOaScTI9oPxR5bENPCEjdcFEO86UcmDF+suqdjpdNC1lCge/ZyiECsyDt0e
 Y3AXGSZa/e9mESaENSzG5d9okoz9pW7ijwtAYzlnAmkouqKC5mTLOxNkKfM8ZRtzy6aDxoOtB0I
 EvXacNHksCboF/UHMDdEYWLnJIuCEeI+yPgPssCGy8F6BXqiSioGp4jHeP6bNiacrc1CvRAcC3B
 rMU06Ppq9Sg=
X-Received: by 2002:a05:6e02:184b:b0:3a7:e7bd:9f09 with SMTP id
 e9e14a558f8ab-3a7f9a2a1e5mr98170525ab.5.1733333146559; 
 Wed, 04 Dec 2024 09:25:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEncoE34/KO+aJNn0pCxtpJ9UMCC0X2J65rt/X53p6ly5LzB+hGXpUT1svmX9kc9StPf5DHVA==
X-Received: by 2002:a05:6e02:184b:b0:3a7:e7bd:9f09 with SMTP id
 e9e14a558f8ab-3a7f9a2a1e5mr98170115ab.5.1733333146226; 
 Wed, 04 Dec 2024 09:25:46 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7ccc0b987sm33187455ab.34.2024.12.04.09.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 09:25:45 -0800 (PST)
Date: Wed, 4 Dec 2024 12:25:42 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 00/11] migration/block: disk activation rewrite
Message-ID: <Z1CQlkX9e7YCNzjN@x1n>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Dec 03, 2024 at 07:51:27PM -0500, Peter Xu wrote:
>   migration/block: Merge block reactivations for fail/cancel
>   migration/block: Extend the migration_block_* API to dest side
>   migration/block: Apply the migration_block_* API to postcopy

I just noticed these three patches cannot be separate, because right after
we introduce a flag to cache disk activation status, it will need to apply
to all the code or inconsistency can happen if someone applies one of the
patches, for example.

I also overlooked that we must take qmp_cont() into the picture too, so
that will also need to use the API so the flag will be consistent.

So in the next version I'll squash the three patches into one, and also use
the new API in qmp_cont(), so the status flag should always be consistent.

Again, to block layer developers: please help if any of you know how to
make bdrv_inactivate_all() safe to be called on top of inactivated disks,
or any reasoning on why it mustn't.  It could be very helpful.

-- 
Peter Xu


