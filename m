Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B335D58D73
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdFu-00018y-0t; Mon, 25 Nov 2024 12:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdFs-00018Y-0s
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdFq-0001r5-N3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732557129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmNEPRh4wLTifSod9v0DBNqw9UCaVKsM9QvtMj0kPXQ=;
 b=UujsEJqqwL2YoJiWZF/eMsmBBq4HRHy38Ho4zrwfFC6Tcq6RRMaSoiW3ZUpv04FYXkMyma
 UxJSXxAKRxC2uur6zCl0KP3JOG87+ZgqzP+q+nbhUS6ZKI0rG+PJ6DlgGzx/ejaDGDigt2
 2HsJts16sZJXM42lUuE2tikpehEQ0Ms=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-omiuDpylObS5gEKq4PqJ8Q-1; Mon, 25 Nov 2024 12:51:01 -0500
X-MC-Unique: omiuDpylObS5gEKq4PqJ8Q-1
X-Mimecast-MFC-AGG-ID: omiuDpylObS5gEKq4PqJ8Q
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83e5dd390bfso485901639f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557061; x=1733161861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmNEPRh4wLTifSod9v0DBNqw9UCaVKsM9QvtMj0kPXQ=;
 b=l2ie4Rz4V9qj9fwhcMk6YyfH+7Zd5+MUOpvJi+V/h25iw9CZAeIXbfs/Ji31FeNCR8
 7lcW0ASXlYOCxo00APK+pJg3zMgUaHrX3+p3s5aIkExf5NbHEgKquwexfByhn2SYaEQ/
 UiNe9a6QioVLV0AmhsE7NWBRtGC07H+7LC3wTtbAAiq/8s6dnBAhYhaC8VZ9wWoSMv5Q
 2HImSfq84Jxe1QuVntZ5ZyoA0dHY+KF8Sc3+rdTcJAwIOz6Zf+UfsDKkrQKBpRHVo0as
 DINw5Q7wRyM2eJ9/kaNMVUd7FfDmSz0e5yEIin/mo77VwanQRN30T4BDuqGObZs/fpGu
 U2kg==
X-Gm-Message-State: AOJu0Yz5D2xl4amg4mooekSKt6nkkMk/I0aBPsVXNxXpV7ACjDeJBzQQ
 3+OIIVqOMu8/jAKK3ohVJWlwQVZK1cNGoduWqZ6QsJAZCyPxcALcM7cOLRCD5QhJ8aeEF2EGGQN
 hKF3heJdWrZ/LUKc2NeNG82r+gB24xGNfyDlQlAbr3MK8XpJFlprT
X-Gm-Gg: ASbGncsAUIrl4Gf6g2GV3tSeX3OkVRjbHpUc/5K8XcsjHCNN/yNdFeTaJbDsK38YnIe
 FM6CSO2CTv7g8cDDA1qPKvZ6IfLCvRxVkNM0eLy1AEgiclAzdLGWW76HO04PpQ0+hZ8Z43oh/oM
 2BmDpSMhjdEm9njzqq9/pOJ5/4IWKss0+kfAgDNU3PhD3UUgYE8A7HfUygizqD2M9ucBi0eBDoZ
 FzZ6RA3T9wDBVDCKHaUbw14sqNDwVHN6vylqlHl0CxC+YMYfBw8sTaSJaTI4Quad3QgrvQFlLmL
 /FVN5KXS+A4=
X-Received: by 2002:a6b:c410:0:b0:835:394a:d784 with SMTP id
 ca18e2360f4ac-843d7f159b2mr34288239f.7.1732557060933; 
 Mon, 25 Nov 2024 09:51:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHshK6gK8VAvwnA8GfB2hLTmMm2Xn8BlImZ+JiQtx4CappiHSdYUMobfDxTX7QVGD1cqHNpOw==
X-Received: by 2002:a6b:c410:0:b0:835:394a:d784 with SMTP id
 ca18e2360f4ac-843d7f159b2mr34286239f.7.1732557060688; 
 Mon, 25 Nov 2024 09:51:00 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1fb5931d0sm890301173.124.2024.11.25.09.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:51:00 -0800 (PST)
Date: Mon, 25 Nov 2024 12:50:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 13/22] tests/qtest/migration: Split compression tests
 from migration-test.c
Message-ID: <Z0S5ArJgdsVjU0Zc@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Nov 13, 2024 at 04:46:21PM -0300, Fabiano Rosas wrote:
> Continuing the split of groups of tests from migration-test.c, split
> the compression tests into their own file.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


