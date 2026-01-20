Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C29CA5FB9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFUz-0003lh-F3; Tue, 20 Jan 2026 12:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFUv-0003kX-Ud
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFUs-0003e2-J3
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768929989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xgGSiMWh2caEp5MjSGS41yNnZZ9eTIUWymOD+E8n6PI=;
 b=cbBo/J3J2h5/ks1gYi/QJ4gMawReOMvZ3FgJ74EJptFj4gMwZOlZQOB5PhVwgoz9+rMlg+
 N6temi9EHk4Z7FY0oN7WRjdXovdbAFLHVsnaAGvbrRGLWsSGohR5M8VmSkFUY4EA5xuDEY
 57nCUinzhChD22Xp2KKWdsdKO9jIc10=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-QpOo69ZvNSWd90LwaWBoSQ-1; Tue, 20 Jan 2026 12:26:28 -0500
X-MC-Unique: QpOo69ZvNSWd90LwaWBoSQ-1
X-Mimecast-MFC-AGG-ID: QpOo69ZvNSWd90LwaWBoSQ_1768929987
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b6be90b6d1so2962638eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768929987; x=1769534787; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xgGSiMWh2caEp5MjSGS41yNnZZ9eTIUWymOD+E8n6PI=;
 b=CX2r2tq1D9BsJMNWbDfPuB9ZN7ZO8iGt7z65Rt2/5TAfk9eKfvwV4rlgsMzv2v9sLg
 M2FJVT43sIUUulxkaR875nZxh4D2z9U3K82kOky/lH/1t517OCsO2G7I2rowlLso0QjB
 ROk63sTRt1tFCyZovPeDrLUN1skDzxelXnBXk1V2a5sxxUqZrYS3ajM2Uw6leR/u/jbt
 z38PB81wiOWKSh40VbTbBjjONEXOaoBlfrd/cgw4PlCQGpQZX7ysAeedjqsYPSqMWxle
 VIExZyeKKtLfnoxmdcDBgoqHtdJZbNlxOrJTZ0EB3LhI89MgRXVJXiqNqIdr0Wkv0/lk
 oW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768929987; x=1769534787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgGSiMWh2caEp5MjSGS41yNnZZ9eTIUWymOD+E8n6PI=;
 b=D3bCLLYiBRwK6sdqGga8XtOddgaLdVPBloMewPkAZHpAsXeFyPCyfnEey90NOBnhm0
 MAnNKJYCJ6q1d69AW2L3m3NzsNFTFm825ipo7OUUfedPCVUHEps9PK0XPE2WX3/hUnFm
 qaF6gs0ISzF9/1OyKwcNmQ/0v9kYjH8k6AWWzDVTRX2dyEz+70Do1n7XNIYumJroHF7Z
 +k/HqWkskOJLdi9hB5RYDrZ9fX/4uUEK2DgjBvvumQdGBPsT46iO91rUme7VnTqB+8p1
 90+gevqdcoxwnRns1WfeBafkj3PNBWM1m1AffM34Y9iG0IqWkRfC+0H1HvAVakxyIv4e
 5qzQ==
X-Gm-Message-State: AOJu0YyHKxxvrvu6JZQ5XGMiJKtsTpEvEKrGVJ6/OdiJz3SCkXJovNxf
 +lMbiAfNr/NORA7wwHtOC66HDmecggXr3qOsbJIdPQFuG7frAWXu0gRPmzuRBUcvyAOafjvCh6f
 Wug8bQWO6sECerjqtJ3BRPtVAPfv2vUck5lDfBFuV89TWkwEZkxF/pZ44
X-Gm-Gg: AZuq6aLx/CjjzBCsxF3mQ/QvDFRsvpPE8bg+DmCcdywjOHPhSlseJnvRpmwRknfYdp/
 X7PKPYFdjuNdWYl5VyZZOH75g7GpzuWhK/O3eU5BRlRPMxBP7DwIftns4xOIDWkHd1xtRIvNyUB
 jiFBpihjtIwVwvFt1vNrhQhqnMtKywbKoB/Yd+g8uRGyN8XJcyt8FoBYKc+Mdkw48ZCQovQtcqL
 Da2HllQTs3YDN3AL/eD1hB569aRv4nu9MPFKIcob5r1mFhTbW6S823eF9378VOkSB3Y8e5KQpMr
 r5nO68FeA+51lbzTS9jSKJBgvG9mAn1GXJMfBk5DEj9DY6lVe5kP9B+P79mti/fCUfWDXHOqsuF
 ty3g=
X-Received: by 2002:a05:7300:dc88:b0:2b0:53e5:89df with SMTP id
 5a478bee46e88-2b6fd7ece9bmr1565765eec.5.1768929985804; 
 Tue, 20 Jan 2026 09:26:25 -0800 (PST)
X-Received: by 2002:a05:7300:dc88:b0:2b0:53e5:89df with SMTP id
 5a478bee46e88-2b6fd7ece9bmr1565742eec.5.1768929985199; 
 Tue, 20 Jan 2026 09:26:25 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6b361f5d4sm17770564eec.17.2026.01.20.09.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:26:24 -0800 (PST)
Date: Tue, 20 Jan 2026 12:26:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 6/8] Convert colo main documentation to restructuredText
Message-ID: <aW-6uSs0kO-4imOp@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-6-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117-colo_unit_test_multifd-v2-6-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jan 17, 2026 at 03:09:13PM +0100, Lukas Straub wrote:
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS               |   2 +-
>  docs/COLO-FT.txt          | 334 ------------------------------------------
>  docs/system/index.rst     |   1 +
>  docs/system/qemu-colo.rst | 361 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 363 insertions(+), 335 deletions(-)

Thank you.

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92ca20c9d4186a08519d15bfe8cbd583ab061a8b..4c30dc50d15c74b317443e43920e01b4560b03a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3841,7 +3841,7 @@ F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
>  F: tests/qtest/migration/colo-tests.c
> -F: docs/COLO-FT.txt
> +F: docs/devel/qemu-colo.rst

Should we still put it under docs/devel/migration?

COLO framework is under migration/.  COLO tests will be under
tests/qtest/migration/.  I still think we should keep doc under migration/
too, IOW when someone touches that we want to get copied too.

I also raised some other requests while discussing with you on the COLO
details.  If you want, feel free to attach one more patch to add those
contents into the doc (after this conversion patch), on either doubled mem
consumption of SVM, or RAM mgmt details.

Thanks,

-- 
Peter Xu


