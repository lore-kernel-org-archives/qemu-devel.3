Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47168C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 02:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXuRL-0000SR-UA; Wed, 07 Feb 2024 21:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuRL-0000SI-0g
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 21:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuRJ-0001D2-FU
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 21:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707360420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lOxG/Nh7JgeSx+Aw2f2z0KgRebico9OoCiViW6PfgQ=;
 b=M99G/e4Q4JvHEe+Scx/jFqEzy5AFhoRtRkdUY6LY9MoAvAumozmuZzZZhHkfX4rSzhdfOZ
 96oPcVx2fwhRojjabMuYPGMEBT/NgNyvWONMPBsDP35hP6pvfoQMVieQPWhZ0WwTfsX1sM
 ZpVNEGl6V5I6ocZtIl308Z9Ultsyg40=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-i2qGiv9pOMWfSwsKD8vmRA-1; Wed, 07 Feb 2024 21:46:58 -0500
X-MC-Unique: i2qGiv9pOMWfSwsKD8vmRA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7bbde31d9b7so51992639f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 18:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707360417; x=1707965217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lOxG/Nh7JgeSx+Aw2f2z0KgRebico9OoCiViW6PfgQ=;
 b=MmPJoHO5LTh14Y750IXSB6sbl25hYy2CLiNsPNYTDttPWpWB1sN8kOODOW0FXrXO3t
 12SdYiFemddC494z0FBsckMEdnBz/HQ7fSVWaejazPtn8udoEfX1iHfLRX1pVyzxvDKW
 LBAP7t2syrsLxKiLo/h9yB+3KgdtrnTr+POhwKFhNZSIGpjnLW+OgquZgmDHKrltPfaI
 cF2nnUcMG2ZTE4cErsrBq7vjE1T+0DL7H3v+dIsbii/U9EGw7B/jieO1lI1qFv9MUIi2
 nLSuyKGHrYBg/tbGQeGKNK/wHSn70D0fUKDOIIyAvAo9ugugarzq5b65J9ouCVWjqZAV
 6Tog==
X-Gm-Message-State: AOJu0Yy/aTo38DTAc1dzbYza1XEB3/kAuDVBBIaBcxa1MR3XqihSmpNl
 9qPrcgkpUjbYJ8k8Mn9EbnWHbG6OHl3iMYjTai5tNcMfWxpqciG5oXklm0DTHR3EVn4Pe4bvt3L
 U4zQVaKp623Y4AIht7Lvrai5K9elWUU4Djq/UrT1tR+TcFQhCOmXGSK09RInYZVJpnrnYcJ3h7g
 b1laYceVoA3qsJOmwAgaRmdaFc7V9CcC8bQK3X
X-Received: by 2002:a92:c266:0:b0:35f:bc09:c56b with SMTP id
 h6-20020a92c266000000b0035fbc09c56bmr9310425ild.2.1707360417542; 
 Wed, 07 Feb 2024 18:46:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxydobGRTIUqt/izOB7HpE+PReZ2b+ztR9w5KV51DArnuwcyEWUhhrrfx9K/dbZTGL4lyIzg==
X-Received: by 2002:a92:c266:0:b0:35f:bc09:c56b with SMTP id
 h6-20020a92c266000000b0035fbc09c56bmr9310404ild.2.1707360417144; 
 Wed, 07 Feb 2024 18:46:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUL4Rz2oqsLc6J5Lbx/Jx2blAch/tuEajMgFjCI1Cj04+PXVrB2ZJcbloMhG9X3MuyRFLsGLji3JlNgqr1Lh8Mt02b0WJEJLOfKC4CiVqMOGtH1VgfuB6fr2pFeWJVXbBbt8Ayt1on3s8TDD8h9Mab+MIHQRNNczPJQ3OQsu/DqrEwadg==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 126-20020a630084000000b005d8e30897e4sm2394601pga.69.2024.02.07.18.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 18:46:56 -0800 (PST)
Date: Thu, 8 Feb 2024 10:46:50 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 0/3] ci: Fixes on the recent cross-binary test case
Message-ID: <ZcRAmg4B0XD_g-IS@x1n>
References: <20240207005403.242235-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207005403.242235-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 07, 2024 at 08:54:00AM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> v2:
> - Fix a typo in patch 2 on QEMU_PREV_VERSION
> - Added R-bs for Dan
> 
> Hi,
> 
> This small patchset updates the recent cross-binary test for migration on
> a few things.
> 
> Patch 1 modifies the aarch64 test GIC version to 3 rather than "max",
> paving way for enabling it, even if the CPU model is not yet ready.
> 
> Patch 2 removes the tag dependency of the new build-previous-qemu job, so
> that in personal CI pipelines the job won't fail if the tag is missing, as
> reported by Peter Maydell, and solution suggested by Dan.
> 
> Patch 3 updates the comment for aarch64 on the test to state the fact, and
> what is missing.  Then we don't target it support for v9.0, but only until
> we have a stable CPU model for aarch64 (if ever possible to support both
> tcg and kvm).
> 
> Comments welcomed, thanks.

queued.

-- 
Peter Xu


