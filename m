Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C940DC63685
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjL5Y-0001eV-NZ; Wed, 28 Aug 2024 12:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL5W-0001Wm-GL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL5U-0000q3-Ob
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724860800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39KYAcedtNUz1sStiXN95S6otemAnCTfL4a+zXrWXcg=;
 b=AT6+spj23K07ac0rNa4L9ekjjw3p1xTkk4UQ9XAv9jdvYu0Uq4IoVCZYRzwQ0hG8rGHmhj
 ZSL8FcQfEz3jKvQutJ4GW82+tc3fOL2O6cm8ccqAQtOa+c0lMxd8DAy4ZA3vm0xu0Uv/Ms
 vfHFOh0MGSm+Y6ii0T0UsPv5PlEYwEE=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-upX7tt1FN1yFh5FrfI6D4A-1; Wed, 28 Aug 2024 11:59:56 -0400
X-MC-Unique: upX7tt1FN1yFh5FrfI6D4A-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2703e353c5dso9958338fac.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860796; x=1725465596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39KYAcedtNUz1sStiXN95S6otemAnCTfL4a+zXrWXcg=;
 b=RvGQ5dWnWEGRUGGxMFK1nDGCcSgoBz6ei23T3gy6dPxMNzyaPhckT6tpAKELan/tpS
 U71d+tNGSGqiZnJuRhbFPcWzfj37AL4mw4keqAdQMc+1sKbS/+xFPpmyS5NAcV+a+klb
 yT7w7qA6aUW1V8wwo7rFkuiQ56rLrp+w46rZEb6tFnzyzk7FsjREx6SSQHVUF0h6eh7T
 weHR//Knytd6jOaYqEZzVpn9KN7Inomn4gJCEs1m7wZwn/DghEAZHbWmvEQ+BoP4kxk5
 yteydDLCS70vlAxGQ+ZfauhY9kNdN+n5tGovN5Nv5zCpCyrXj/ksG3FGKUBwO7iXKegg
 g7+w==
X-Gm-Message-State: AOJu0Yxxl7FC0qOEPja4aPTPoqyGYHxcHbI4eWeZnOoz6z8tZtT3+Pad
 TO7MSnEKlNzKby3xN/tuq3aM6dAYAtsQYWDtdUxnepjiXf4PsunbLw9kq3W4x5I7IJLqATbTg16
 FtWE3hQKkRMiPW0HSteWvQM8TalwkfNCkOwj15/Mm7tBGqJFzvDSM
X-Received: by 2002:a05:6870:1691:b0:261:39d:afa1 with SMTP id
 586e51a60fabf-2779012bf7bmr9514fac.22.1724860795951; 
 Wed, 28 Aug 2024 08:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY1tUPmFXhJwjAidDrLHmE7KqlqrCWxvFin2VQbmtrvn8bWb3wAmSoQKW1zGsGv3bnawiYqw==
X-Received: by 2002:a05:6870:1691:b0:261:39d:afa1 with SMTP id
 586e51a60fabf-2779012bf7bmr9501fac.22.1724860795645; 
 Wed, 28 Aug 2024 08:59:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-273ce9e3c8bsm3819264fac.16.2024.08.28.08.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 08:59:55 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:59:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 3/4] migration/multifd: Add a couple of asserts for
 p->iov
Message-ID: <Zs9JebFK7rJvJKkX@x1n>
References: <20240828145650.15879-1-farosas@suse.de>
 <20240828145650.15879-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828145650.15879-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Aug 28, 2024 at 11:56:49AM -0300, Fabiano Rosas wrote:
> Check that p->iov is indeed always allocated and freed by the
> MultiFDMethods hooks.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


