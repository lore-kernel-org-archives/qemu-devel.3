Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357D5C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujkXj-0001Gm-MD; Wed, 06 Aug 2025 16:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujkXh-00019n-HF
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujkXf-0007ja-RY
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754511315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rcz/079T31rdeb4+1VaCQF7JFL1/wWWBzvXooLm6PPY=;
 b=K6fWzGgf5DTjLGKxG56ym8boca8m+8LQXBdv1eI2NeZIyGY2crzcILxXeEsKX5hDPWzkhx
 Eac32r/iWH4O/SPBfWJnPczuGpe86gxKlNVCKzIAqB4VhQScX/qQiOBp96WRvGSeRINrRw
 Uea7BW+qsKPefvLTBhJfecRVTqXnQb4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-lQ_O7WKqMJa2_HHddLypXQ-1; Wed, 06 Aug 2025 16:15:12 -0400
X-MC-Unique: lQ_O7WKqMJa2_HHddLypXQ-1
X-Mimecast-MFC-AGG-ID: lQ_O7WKqMJa2_HHddLypXQ_1754511312
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7196c919719so3987747b3.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 13:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754511312; x=1755116112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rcz/079T31rdeb4+1VaCQF7JFL1/wWWBzvXooLm6PPY=;
 b=n6/1dqjEkZakTdixxh+lDYSfqGTLQb1LkOU/2bFQrAW09rpAbFnKzWxLosUlLNcK4w
 0O7a2AU10FwU7MFWezeO+VmXLNQ9aFPCJXZQ9Sy8T1dw2BBQgMGVKOCcILDeW4Dj23NQ
 9j5t2c7/QloriUV9v8TF0dsU+xU3ZOiPCYSR078kYGyoQrIZQtG7dZDLd4j1SUX26Zqn
 kBSDC6jfc8BlFt/xKVf0WBIpq3Y7/Ln5h2yDwkoteLJZHGXcfMyiJqvQBzv8yJb3tsi2
 2kpmw9M7IcUVpNiL0JizkIfHn7AbQp9d3GODSUXpDbmfI4bNsj15FO9bIlePArUHRLKt
 qd8Q==
X-Gm-Message-State: AOJu0YwpOIkIeJpdD/5xASz+YthnbpYRMpNHmMgdPuAkCP/p5E9wJ3lp
 W3rWPBn2z4jxTpjq8pQIREwZyYHZDh/sqP6wZGajuph5Czn7vw2wYgCIglFEhz0PJNMxIWjfVb/
 XWtuP4+pocycdtTo/J7nKz2BXWMDHwSIgfQdiobnJKm+aONHxDLCvCF84
X-Gm-Gg: ASbGncun808jQn92kPEANtXmx0j17DrIdL1+L4OW1QTAu8vn9S9i4ut92j5jP1vUidT
 tI3tbUoR5sT4SYdRpyQz4ykiefjppM02TSAOTJDg8736ADPgias8xi77ChKwIKOH8PtpsCNCZFi
 D4mFlaacPdrM4bxnqXIEA6D+KwO05K/CXVxTYXogdyjGSoY3E5HYIfyIA5+9cOk0BnlR8xLGS5q
 wt4cHSe/fmzeaYryHFeRhDDa0ZjleVdt6leGoLUUReewnQThMQJ7vXX18c2BVY3NrQCRO4gTcpE
 Vj0OUeAjUQBElNgkF47+K8mIdg/eUADgc/YOLbZ51wielXQJXh1O1Ra5mhLlQ7HKb7+idf3JWCt
 8MLt1SzQtK56N4E0/dqbwwg==
X-Received: by 2002:a05:690c:368f:b0:71a:1234:353b with SMTP id
 00721157ae682-71bcc8c3f1amr50713037b3.32.1754511311609; 
 Wed, 06 Aug 2025 13:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWOuOWQF4CpyS0Il7wYKLVzhqAXlpYStvbgu6gR0L22rJbzkIeLnx/oezOLcbIeVVrn0pJGQ==
X-Received: by 2002:a05:690c:368f:b0:71a:1234:353b with SMTP id
 00721157ae682-71bcc8c3f1amr50712557b3.32.1754511310999; 
 Wed, 06 Aug 2025 13:15:10 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a3f8409sm41304007b3.28.2025.08.06.13.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 13:15:10 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:15:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC v2] memory.c: improve refcounting for RAM vs MMIO regions
Message-ID: <aJO3ywz2Ej_kToU_@x1.local>
References: <20250805081123.137064-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805081123.137064-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 05, 2025 at 10:11:23AM +0200, Albert Esteve wrote:
> v1->v2:
> - Added documentation
> - Explained the reasoning in the commit message
> 
> In the last version of the SHMEM MAP/UNMAP [1] Stefan
> raised a concern [2] about dynamically creating and
> destroying memory regions and their lifecycle [3].
> 
> After some discussion, David Hildenbrand proposed
> to detect RAM regions and handle refcounting differently.
> I tried to extend the reasoning in the commit message
> below. If I wrote any innacuracies, please keep me
> honest. I hope we can gather some feedback with
> this RFC patch before sending it for inclusion.

This seems working.  Looks like so far all RAM MRs are fine with it, but
I'm not strongly confident it's true or it'll trivially keep true in the
future too.

Besides, this still adds some trivial complexity to memory_region_ref() on
treating RAM/MMIO MRs differently.

It also sounds like a pure "accident" that the shmem objects to be mapped
from the vhost-user devices are RAMs.  I wonder what happens if we want to
also support dynmaic MMIO regions.

Would this work even without changing QEMU memory core?

For example, have you thought about creating a VhostUserShmemObject for
each of the VHOST_USER_BACKEND_SHMEM_MAP request?

AFAICT, QEMU has complete refcounting support for objects, I thought that
should be totally fine being dynmaically created or destroyed.  Then MRs
will be children of those dynamic objects rather than the vhost-user
device.

Thanks,

-- 
Peter Xu


