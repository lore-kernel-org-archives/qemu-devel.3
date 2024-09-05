Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D126CD6E74
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 17:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smGft-00025M-6Y; Thu, 05 Sep 2024 13:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smGfH-000210-8k
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 13:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smGfF-0006eQ-2a
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 13:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725558779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KavS3iRY1L6obsM1DTfsjPqroWrCzQfffXWBF6BH8VY=;
 b=U4puY2Bn6m5LaLfHlOHl3OygympalPU8cvc/nOVX/lRFtj+FZ7YBvKQ3ZJ1h/wlmQ5Ob8x
 bBYPuAhFeNYOIdkI5l3gSnY45P+MH0TKjjAWYbACFHxiOWXVmAQvwThaSrvllidboSWoUs
 iRT1gWenQR/Za5QBqm2zs+dubcm9l9s=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-vvS5iRUtP5ay88q7YwlI2A-1; Thu, 05 Sep 2024 13:52:58 -0400
X-MC-Unique: vvS5iRUtP5ay88q7YwlI2A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-457cd21f270so20794271cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 10:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725558776; x=1726163576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KavS3iRY1L6obsM1DTfsjPqroWrCzQfffXWBF6BH8VY=;
 b=Op5ameVYFTmznLwvwBaOo0HT6oiWP6wvOWhtq1tYn1bCrUPrTCPgrHrvlOPY4mjAd7
 8zgfHjtmbyGmaVTdV9gDmhneowgafz1P5YrgB76w9c+OoaKeqiGh/RhpWYjcat/pTY+J
 2WOE7sU5RIQ+SIJBtlUutEB9Rexd6Y++bgScKcMOPpJSTfhsfML1DakMkl0YwVOkVLBH
 5pT6ySSvlO2UPsrBw+xXwk7mKiUt5yi0cvJlDaCnPm1rvZ6ZPlzbUr5Eq7mSSHvtKwlS
 NwiG7/v0rVvgDtcndamYRDPclRf6zNwNS/1r5MpRz0UIuOUGwXhl4WjddGdhu6DgMWKt
 17vA==
X-Gm-Message-State: AOJu0YyP1CXF9eDrpBDX8cElAv3iuyWZjVUujm96TVPJIwUSfnUrQ5Ye
 J63/wtYlHD0zIqdzW2ZuX9FZ9fbAaO2TLB0/pvTrIkaPfIhoSWd2vzRbBqJeZcUtbTSMrdnVXgu
 3an8C0sYfQ+yuwdLoz55bcnTR/lRCS1dntvQEQ5TC/EdGoKcuSRVQ
X-Received: by 2002:ac8:5d4c:0:b0:451:d541:8b77 with SMTP id
 d75a77b69052e-4580c75a107mr103671cf.46.1725558776676; 
 Thu, 05 Sep 2024 10:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOy60HRYSkuMy+2nVIuMiXA7wuv1N99LnSv65URYqTt3TI41d9BUKpqEJz7Dcc5iYL0Z/RXg==
X-Received: by 2002:ac8:5d4c:0:b0:451:d541:8b77 with SMTP id
 d75a77b69052e-4580c75a107mr103541cf.46.1725558776300; 
 Thu, 05 Sep 2024 10:52:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801cbc46dsm9004481cf.77.2024.09.05.10.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 10:52:55 -0700 (PDT)
Date: Thu, 5 Sep 2024 13:52:54 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/1] migration: improve migration_throttle tracepoint
Message-ID: <Ztnv9mouMVIbHnIx@x1n>
References: <20240905165146.293586-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905165146.293586-1-den@openvz.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 05, 2024 at 06:51:46PM +0200, Denis V. Lunev via wrote:
> Right now this tracepoint is just saying that the guest has been
> throttled, but this is not that good for debugging purposes. We should
> also know how much the guest is throttled in order to understand
> consequences for the guest behaviour.
> 
> The patch moves the tracepoint from migration_trigger_throttle() to
> mig_throttle_guest_down() where this information is really available.
> This is not a problem as mig_throttle_guest_down() is called in the
> only one place.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Peter Xu <peterx@redhat.com>
> CC: Fabiano Rosas <farosas@suse.de>

Makes sense to me, but maybe we can further move it to cpu_throttle_set()?

-- 
Peter Xu


