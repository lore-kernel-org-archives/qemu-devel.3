Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3502CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 12:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux2ZG-0002tv-IB; Fri, 12 Sep 2025 08:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ux2Z8-0002tU-7I
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 08:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ux2Z3-0006Cz-8I
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 08:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757678857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrFyjx8xpxlDu5EVgAFVhGmnkexTADOf0qxHDfbp+DA=;
 b=L9ze1P321PCnzSqzrKpIMpWyyFimFugqtQuCgIsn7mADfASat5LolKySQcG0+bvr3n8dnt
 bizzusv74SjiRtMldFkfx+2nICnWm/miNE8VIiVLZSJXb7p+xYRgIgNPgaogjhhOo6SK1t
 qygo2PSvFDxu9mD4HcdYjhKyVog9y1Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-RbnqzNctMzKsl4lHT4KKaw-1; Fri, 12 Sep 2025 08:07:36 -0400
X-MC-Unique: RbnqzNctMzKsl4lHT4KKaw-1
X-Mimecast-MFC-AGG-ID: RbnqzNctMzKsl4lHT4KKaw_1757678855
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e7634eb959so898130f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 05:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757678855; x=1758283655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrFyjx8xpxlDu5EVgAFVhGmnkexTADOf0qxHDfbp+DA=;
 b=vmO+0pdvQRAFNpf4Gk97Icrhp76wNmOSsNnNRkUkxB3pewUe6ROn1TiU3o78ANsXWU
 htw0iHKJDArgX+HiGzop8yy9EYTAQQ4QUsu++7/UvWbHfrwl+Cra/66i+0Y+rok1J1Bk
 TPMFETTkr7im+T3My20s789sEJ5k8VHcsKFPZa/1VhkiOb7eGwvuQopyaZGqfQWUasUe
 uFkBEa2w9CpWXvAqzZq8prDiVs+LSl73iMzPtC2X+yvO58LnVWM0knuCEuL36GShDDMt
 ToY+1QEni1Q7DELy4+V80kqD3qJGr2pqp3ZJmiSi7QUIrpe3Z01A6uWlWnkN7Jjqmemy
 1ieg==
X-Gm-Message-State: AOJu0Yzh3y9afgMYLy1vDs+kbMb5Cx8Jn56qNc2of98Ww6bDxwLRa2Ae
 5Vm210ESIuAhb2jpua7dONiramcu/SO7qUOppuezMTsxTnFxuIj+A9CPs5vyYiOToixa1VIRO4B
 XOTcLiCnNtRb61InqFHMsEgsfHKW1tUF407mvFtnh32/tAe0MY0gewrrN
X-Gm-Gg: ASbGncsCo0QmuBEoVp1/336+xGp/FE7s6fnXxbnApvkPgQQzEKyGJ29NLl1yE2JwhvV
 LajEcCQb3MTudDAmDH8XU6ikkm+Lcmc6nNZx2Ww6w/gZnopy4A0xZV2Sx4i+FDKpHxcb4HYoymu
 1ZJjFDhML8vkyOgF/eNExvbuHkuXjFyeIIbsD6ZRqrK3PNt50AEu/eMi01YTFuVUGaJMXZ6Ax2K
 nronZ9NA6E4J4vfwIwrNoUTAKIl1uukCxX1820usPMpVkeQDSZTJ9MF0A5VP7gfMp+rawJ39HHo
 rlbjn+TttXWdRCt3mT4cFlcQ26G+lg==
X-Received: by 2002:a05:6000:4313:b0:3e4:64b0:a779 with SMTP id
 ffacd0b85a97d-3e765a0adbcmr2707373f8f.53.1757678854888; 
 Fri, 12 Sep 2025 05:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmjJUe7OtTw8ny0YX2NnTILxk/10/6qJblowjq0WhSaIcLclgPVwLEOS5moR2yTII9ofy+GA==
X-Received: by 2002:a05:6000:4313:b0:3e4:64b0:a779 with SMTP id
 ffacd0b85a97d-3e765a0adbcmr2707340f8f.53.1757678854401; 
 Fri, 12 Sep 2025 05:07:34 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607770c2sm6274265f8f.8.2025.09.12.05.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 05:07:34 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:07:32 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 3/3] migration: Make migration_has_failed() work even
 for CANCELLING
Message-ID: <6rvz5ywubscaoowkoqrkmtfljwpd6lv5m2qneqlvkclynp6k3t@akdkqtkhg7qy>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911212355.1943494-4-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2025-09-11 17:23, Peter Xu wrote:
> No issue I hit, the change is only from code observation when I am looking
> at a TLS premature termination issue.
> 
> We set CANCELLED very late, it means migration_has_failed() may not work
> correctly if it's invoked before updating CANCELLING to CANCELLED.
> 
> Allow that state will make migration_has_failed() working as expected even
> if it's invoked slightly earlier.
> 
> One current user is the multifd code for the TLS graceful termination,
> where it's before updating to CANCELLED.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


