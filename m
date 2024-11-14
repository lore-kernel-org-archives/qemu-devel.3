Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671ABD6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgka-0002bY-Oo; Thu, 14 Nov 2024 15:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgkY-0002bF-Ro
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBgkW-0004vl-LR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731617251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiShHbsWUOTfTTx+lrf+1ZaXSGzj8MIRBW8h8wqZ8q4=;
 b=MSHgxFmSS8LIeGMrO3+TFs6yhhcEIIRJd4mj7nyDpPlUF5YZIKrgGtT5ZHdX0sIY7jTNH6
 ga+raBCzPh/Q9nWEB+Vz17kiGNjbqf6dfzJXx2CFRznSBdHjdo+hLUv7qplIJECiUiTqM7
 q1lvgKZnlkwVICXt30wbQR/B/V30Hus=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-B90cXNgLNHa0HfjNylZsaA-1; Thu, 14 Nov 2024 15:47:24 -0500
X-MC-Unique: B90cXNgLNHa0HfjNylZsaA-1
X-Mimecast-MFC-AGG-ID: B90cXNgLNHa0HfjNylZsaA
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83ac1f28d2bso108358539f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731617243; x=1732222043;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kiShHbsWUOTfTTx+lrf+1ZaXSGzj8MIRBW8h8wqZ8q4=;
 b=w+a+vZL9tUY2ayDFxWvhhmNiRo+F2DOwLhiXN6C29m0IqDjz2cIEKc3Kv9/ZItz4MS
 fYhY5QAQP508n7eSGvxyP+8lyJW9gtkym1f5W4l2+uCNIWCfYci34+Zqkmv6cQywqeRz
 c+Y6CRIcKWC2YRBlrLYzLxGtJIyNiWYuYVergH8UgTVEIJV/i1VjmAsSgAnK3FwzJR/N
 j6BoFmyvZ0kQxEZMKgusidSSA3BHiWyJv5lkDQBHqSo1xwBcqPNCr+d4WEuyRBY4/g1t
 5t+ByPxF8oeGAuZxYPVMsX612mhW92bU2y4QjslMwq7Y3ZmnRM37uOO49LlvN0YYc6cy
 Jwkw==
X-Gm-Message-State: AOJu0Yzomc0xDhkyIg7YyiE3v+7zHbnIX9cvt18PTLdIkZSmdV13e72K
 xCEcEs1O0qd7hlsJ8E2MZWD1RpFVlvzX0g7+Pikcj4lGXCOWh0jxV1bhjVc0Kgy4JRCXgoq3kps
 sa1XPLNcpchrWppO2Sg4m6QrqpNbjbd18le+5ud6bmYy46bHbJ+qt2KXifOdG
X-Received: by 2002:a05:6602:601b:b0:83a:acba:887b with SMTP id
 ca18e2360f4ac-83e6c2ccdf6mr42663139f.10.1731617243540; 
 Thu, 14 Nov 2024 12:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGedKmgjuC4JxAk9sgwbxPrN++gi+2JaQngV1SsykglIgnePzNkNrtaojnKdefXaU4m+HbA5A==
X-Received: by 2002:a05:6602:601b:b0:83a:acba:887b with SMTP id
 ca18e2360f4ac-83e6c2ccdf6mr42661939f.10.1731617243197; 
 Thu, 14 Nov 2024 12:47:23 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756f2519sm12606173.148.2024.11.14.12.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:47:22 -0800 (PST)
Date: Thu, 14 Nov 2024 15:47:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 6/8] qom: introduce qdev_new_dynamic()
Message-ID: <ZzZh2GHJm1L-mq5D@x1n>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-7-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111155555.90091-7-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 11, 2024 at 03:55:53PM +0000, Daniel P. Berrangé wrote:
> qdev_new() has a failure scenario where it will assert() if given
> an abstract type. Callers which are creating qdevs based on user
> input, or unknown/untrusted type names, must manually check the
> result of qdev_class_is_abstract() before calling qdev_new()
> to propagate an Error, instead of asserting.
> 
> Introduce a qdev_new_dynamic() method which is a counterpart to
> qdev_new() that directly returns an Error, instead of asserting.
> This new method is to be used where the typename is specified
> dynamically by code separate from the immediate caller.
> 
> Do likewise with qdev_try_new_dynamic() as a counterpart to
> qdev_try_new().

Since at it, would it make sense to simply replace qdev_try_new() with
qdev_new_dynamic(), assuming it plays similar role of "it can fail" version
of qdev_new()?

Then instead of four helpers, we stick with two helpers, one that asserts
the qdev new will succeed (qdev_new()), the other one that allows any kind
of errors (qdev_new_dynamic()).  Then we can drop qdev_try_new()
altogether, and avoid adding one more for it too.

The qdev_try_new() four call sites can still pass in errp==NULL, which
should be the old behavior, so we don't need to touch isa/usb callers.

PS: looks like usb_try_new() only has one caller.. so maybe prone to be
dropped altogether..

-- 
Peter Xu


