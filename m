Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5CFC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thu9i-0007xS-E1; Tue, 11 Feb 2025 12:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu9N-0007m3-VB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu9M-0008Lk-DG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739295258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+PJC9yqWd7YpmME2hoz09Q627RYwEH10n5vwbvuykI=;
 b=dPONQiK7pk0XL6W0OsYB5iJBfTNLWLkqHknVNRp7fEaF10mtLldoS5DTdgcE2jdaTs2da+
 Nayf7X06+R27fDpGgOnc1tMAn7Mgu9f5y9WZKH/6+ssOj0nCN6nJwMfd6W8kHew6yj75bF
 yqxuNo0MSEA4AY0WSeZhM11Q13fyTkY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-JEa_0lzgMl-8fmTBM6mkCw-1; Tue, 11 Feb 2025 12:34:16 -0500
X-MC-Unique: JEa_0lzgMl-8fmTBM6mkCw-1
X-Mimecast-MFC-AGG-ID: JEa_0lzgMl-8fmTBM6mkCw
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-726cb11e531so2690917a34.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 09:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295256; x=1739900056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+PJC9yqWd7YpmME2hoz09Q627RYwEH10n5vwbvuykI=;
 b=exOJ+QP6u9iWfTPTnWptpNuDWwnb1qsynZLXiLcdheCygjBfcNPFXpc4UXPCd436Ci
 e0wjJ/0fJzMxe52xMtLjTa4PhplMQZJ9x/ZorqyHXF976eLB/MkK9Ip+mDpRlT5Z0t9V
 rh+mhhYrfOv1I2/TBOzHpZfnS3nYKh/vhTSyoFxkfJid3//TKSOqqxFQzOdprj3SpsXp
 qNDmhblykKAMmOU3d3DAT0uCoTWccsafDkHMq1WJuJ4sFuLa1TY+zEz1bHQnJ0FVP4FP
 W/Vv0HDh7CgLNu8l3wRF7izRZg9xvNDBrs+F9bMhro2/h/vj+1n/88A0SUOcY41W5uXQ
 xr1w==
X-Gm-Message-State: AOJu0Yy9JWHPoPvEBs74djcunlB6eJJkhFwqwyNtocXp+Z1thcw/vDVn
 QDmZDaV+kjeToo+DB4ZkAeShNYcB6Ltcofu7wqtGVQOBy8osrRUtTuy3gr4cp8u3p9viOSs/+cP
 TPIEhDtBDjci3PoGM5vCpxO807E8feZeJ66lNO8+aIFDGN9VscFPu
X-Gm-Gg: ASbGncvwhxMdAojbWghe4i+RyEEdX60z3JK30H7aYTIJPEB5K/MfoMoQzPNU3zkDuVu
 IidFlxOEgPE9u3fNA/eHaOzVcx/Jb9OUNQRrt6TTc7iSc/E4VawWFb0OraXfrt1q30KxVGF6/Hx
 h8EW4JqGMYyGsKSMX8UVIjhx4iSMWZcJ3sxm8cM/r28JYwASdbzuOWdYOCax9v+0rWP7n1pCXab
 1pcmSkihBfJfev2vYW5UnQ/dSe8LC4o6OBvTI/5GertpxUiHoU75dqO32Y=
X-Received: by 2002:a05:6830:368a:b0:726:ed72:41c8 with SMTP id
 46e09a7af769-726f1c51872mr85199a34.16.1739295255770; 
 Tue, 11 Feb 2025 09:34:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbudSzNGfKzdHN6jFBqGZIxYwxIWYVUfm6ahbgJ7F8BC5G7d3qsoS5sJDZ6vEGKCWJN0R3Nw==
X-Received: by 2002:a05:6830:368a:b0:726:ed72:41c8 with SMTP id
 46e09a7af769-726f1c51872mr85189a34.16.1739295255508; 
 Tue, 11 Feb 2025 09:34:15 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726ee1b8ba3sm468539a34.42.2025.02.11.09.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:34:15 -0800 (PST)
Date: Tue, 11 Feb 2025 12:34:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 5/9] migration: Reject qmp_migrate_cancel after postcopy
Message-ID: <Z6uKFDWyZLpUL4cK@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

On Tue, Feb 11, 2025 at 12:01:32PM -0300, Fabiano Rosas wrote:
> After postcopy has started, it's not possible to recover the source
> machine in case a migration error occurs because the destination has
> already been changing the state of the machine. For that same reason,
> it doesn't make sense to try to cancel the migration after postcopy
> has started. Reject the cancel command during postcopy.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


