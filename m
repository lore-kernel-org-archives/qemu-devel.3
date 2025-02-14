Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1A5C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiy5k-0005pB-Jp; Fri, 14 Feb 2025 10:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiy5i-0005oe-Ev
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiy5g-0005y0-6j
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739548734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpXoA8OzyvtAynR3LPNSYQrou2ydHgNzmo7m6R1BfLc=;
 b=Si76vu1nrDF2VMN+GIDUEOZmGqCyVYZkag/6uH7t/9/0Y7wr1OX5Fb3urGFQg7bAH6LIqn
 tMHFw54fXCiNcUyRjCazyvmjpX47epIaBR4jMf8g6ZV0BcNOY0xXJrwau72jK2DfDgJ0RS
 A5APO/ZGqGm6xrVp86cTt+0QAWzyZnE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-BpkYBUjZMlCS3ZFEBEZTNQ-1; Fri, 14 Feb 2025 10:58:53 -0500
X-MC-Unique: BpkYBUjZMlCS3ZFEBEZTNQ-1
X-Mimecast-MFC-AGG-ID: BpkYBUjZMlCS3ZFEBEZTNQ_1739548732
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2bc63274bd5so2393825fac.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739548732; x=1740153532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpXoA8OzyvtAynR3LPNSYQrou2ydHgNzmo7m6R1BfLc=;
 b=lFnNCtBG7BoZACGe9Nswg75MQCh2s3fpcA9f4td8h6zCSPzSMe+mJVI1yPklpJjeD5
 yyhegzBgGBQ6rTsdIv/Cz02MYxB0Rc/1ia98URTcFSoo47FJdDYtmTAB5XzHMScnrKfq
 WttNGDzourhYRwYqNl7/EUeykoHkEUglPlQb8Go65IaNb0iItn00bpf1M22XVLxNZWeX
 1dXbCyeer0HoCYOa1X0FCjEaj0zY0i8yGW4mLqwxtDc5pYNPx1W3T73A1fgXwJOwpC+T
 fdfg9qxQGC7kqtWapgygGRy3AJAqA9cOjAOXoszR7/GphS9lRPpCtNf8GSHNrkHHCXti
 AbOg==
X-Gm-Message-State: AOJu0YweiAbZZiY84ofKV+fopWRyXw/v2JDBX4VFOLCkZRE5plTCcU9S
 HRfq1saGnXc/u/mawseFrfCtCqsKtp3bRLGD6jNRk7wNzK6KTEMWYBH1FGxFjsCojmJTmcOm1He
 KLPXv8VdKYR3ajMsKJm6dwc8b5nl3stk7f+qJ0orORsOJ9N8OLmD5
X-Gm-Gg: ASbGncsd2IEi8i9QxBHQj8dg5NHaMzIdBoQcE6EBCTbjyiOS1EdV7t0ZvnXkrYuHc6Q
 9fcG5kbTf3m/0NysElKhHfIUoqna4leKXn+uOm5sHYOhbjXfbmIJrACjJ0RetKlH87HZ2M7gKiv
 MafMP4tb1gyWGyL6PaXuWFtLRgBCTeBGW0mfw45fSBacIDuR0en2y3rz+9hLfV9+Wxb5O9njUSs
 NR8rCfa3aN1FA5kwpl4cld+gxktcjBMmmfTI6tjwtXr0T8ssnc1uTBBEu0=
X-Received: by 2002:a05:6870:d3cb:b0:2bc:7acb:b073 with SMTP id
 586e51a60fabf-2bc7acbb978mr1857124fac.9.1739548732380; 
 Fri, 14 Feb 2025 07:58:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwoQudPGE7KFEX9ar+TNN7ZL/g+d4/EnORDFnK1e2Og3b5ih6LYwzeIWPN627h6eE1fSp0Yw==
X-Received: by 2002:a05:6870:d3cb:b0:2bc:7acb:b073 with SMTP id
 586e51a60fabf-2bc7acbb978mr1857065fac.9.1739548731169; 
 Fri, 14 Feb 2025 07:58:51 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2bc69a3af4fsm1251601fac.19.2025.02.14.07.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 07:58:50 -0800 (PST)
Date: Fri, 14 Feb 2025 10:58:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 03/45] migration: lower handler priority
Message-ID: <Z69oNsdWlf3VpeFi@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1739542467-226739-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 14, 2025 at 06:13:45AM -0800, Steve Sistare wrote:
> Define a vmstate priority that is lower than the default, so its handlers
> run after all default priority handlers.  Since 0 is no longer the default
> priority, translate an uninitialized priority of 0 to MIG_PRI_DEFAULT.
> 
> CPR for vfio will use this to install handlers for containers that run
> after handlers for the devices that they contain.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


