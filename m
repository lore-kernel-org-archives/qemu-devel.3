Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52DFEE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8tx-0004sP-Rq; Tue, 10 Sep 2024 17:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so8tw-0004rh-A5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so8tu-000512-SQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726005592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZxvA8g0igeYpL4bNDI5NJ0mQoP4uOKMHQMLpwlP1y0=;
 b=YSZNOXP85BK6UHtOydUvIuSHSceYXXqlGIXfIijs5HBUhH3ZAjhbHtqVJAZrb1+Zcnnvvc
 FceJWAM7labipqBGXyfrrZCeoYoYc/dMxTuN3vgBQ+bvabiUQuSQ6AqW/rLhX1FCoHDnaz
 Z7bn4AokBqT/nmkPskcCnDZOord6qJE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-fuo--gldOWCVdc_sy4pV2Q-1; Tue, 10 Sep 2024 17:59:48 -0400
X-MC-Unique: fuo--gldOWCVdc_sy4pV2Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c3540067b1so21570446d6.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726005588; x=1726610388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZxvA8g0igeYpL4bNDI5NJ0mQoP4uOKMHQMLpwlP1y0=;
 b=p62jxUvQzahBmDxUBNCmtMk1m+uB1BZrubNftqniF4mycb0pWF2xnfWxeUtGGrB7sp
 PmBXl90W9UuVUJQgZQjMSk0wUmN5qq33BV9dGpIDwcgzu4r53+GIqKAMgJ7F3yA4Cuid
 gh7x1fZoU2jiR8f702FQRE1b6dS2jJqr9awDK7oIf1yylVlFiTuZWDppvTWhGH3vjlJa
 bYep7FO6VRkyHxZhBIBy6qnnos2JmPoArgUbAAQSPrw6ufgXH1R/4EIxX4lMUJd4MV7+
 xCI8AqbBo0gS4M/Ge2YmFTQmnTiWR2HSVBuxarnrolDBuepo5QY0KtWfb/eE2L3FgGsE
 ByTQ==
X-Gm-Message-State: AOJu0YydjzbEWwOlq/aGZpFG4zPi+XvgwACHZb1Ek4L6IrxYgHyl482o
 sAPbXctip/YUjHtITITGefTXOFzm3HMUg2OO6VEbF+XIbVuzvQ0TNY1750U5FTEDR776zTUyr/3
 DqjzJif5s7sLKtAQ2ldUHV9L6NVtpWhJ7kxs2YwD/YB1xXn7pRi/W
X-Received: by 2002:a05:6214:440b:b0:6c5:dc7:577c with SMTP id
 6a1803df08f44-6c55f9eaef0mr12262126d6.2.1726005588244; 
 Tue, 10 Sep 2024 14:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuJn0n/WnuAwzAGorxIXc4EpmVxAZPqK+QEodWmyRPwekR5JkKdwwo9/Kfua+8t8Z9QoNXeQ==
X-Received: by 2002:a05:6214:440b:b0:6c5:dc7:577c with SMTP id
 6a1803df08f44-6c55f9eaef0mr12261926d6.2.1726005587889; 
 Tue, 10 Sep 2024 14:59:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53432945esm33761796d6.20.2024.09.10.14.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 14:59:47 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:59:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Hao Xiang <hao.xiang@linux.dev>, Yuan Liu <yuan1.liu@intel.com>
Subject: Re: [PATCH] migration/multifd: Fix build for qatzip
Message-ID: <ZuDBUSC2hVaWv6dE@x1n>
References: <20240910210450.3835123-1-peterx@redhat.com>
 <87v7z3qjih.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7z3qjih.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 06:35:50PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > The qatzip series was based on an older commit, it applied cleanly even
> > though it has conflicts.  Neither CI nor myself found the build will break
> > as it's skipped by default when qatzip library was missing.
> 
> It took longer than I expected.

What took longer?

> 
> Do you think it would work if we wrapped all calls to external functions
> in a header and stubbed them out when there's no accelerator support?

I didn't catch the major benefit v.s. multifd_register_ops().  Any further
elaborations?

-- 
Peter Xu


