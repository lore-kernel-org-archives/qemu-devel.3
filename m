Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4CDFE5204
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDq2-00085G-Tj; Fri, 24 Apr 2026 06:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wGDq1-00084z-4h
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wGDpy-0008Fi-R3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777026761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FweiYUionAf0G+sWG6apDYixDLEKkon1MR2bzb5I5Wk=;
 b=Q68Pdg+6sneyoqkwA7Y8iAL+qOTGIgo2RqlhC3yj5AR6u3Lz25fy4jM+RTRPwQXOvItk8M
 6t/Kci/r+P+FYYbZQwjODj7sKw1sHEhbqdAdMcOHLwbLHLH3R+///M9ieS3uN+hgTINs5l
 L3TNuW/IdJO2Lg0f11W0AJjRJtdCHwQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-YDIUuBUKOEG_S-BudGQXWw-1; Fri, 24 Apr 2026 06:32:40 -0400
X-MC-Unique: YDIUuBUKOEG_S-BudGQXWw-1
X-Mimecast-MFC-AGG-ID: YDIUuBUKOEG_S-BudGQXWw_1777026759
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2adef9d486bso70765635ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777026759; x=1777631559; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FweiYUionAf0G+sWG6apDYixDLEKkon1MR2bzb5I5Wk=;
 b=GmU0qtdtE71xoeM3pBll6CCbTTrU5bd4tiznqmXCvD7mfaFNGTDWknjrRO28pFxuqD
 nSFwKZUbDrxisitw2VGq06UwRxIirtL1AoQNgoV7vQIR8RQuyu7eqPQK4X+l7ANOFGoM
 2zZwTzKoLYG9iQ1iLBHzte7L3AAM9eBAR878FahtQaUTIY1wCmvx7E9MMAbkofyiLjnQ
 qaB76DmlWhEsXy9OBkn0s6ZKVv9Sqf88CNHrCCbEboO/1gz0SCR4KS1sOMfhDoQxLlOV
 2DLT7RPmILNvbJE+iWdeihR0VmlUElbCumJOvWSeHV8KJ3ZoTdGLEaQWNvC6noDi9sjD
 ptEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026759; x=1777631559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FweiYUionAf0G+sWG6apDYixDLEKkon1MR2bzb5I5Wk=;
 b=a6tFHKFKuDRW4Xw0x5ABH+jBYi2TDjCFDLkETbMWjpOedrWrJgAtz+MalWYP+d5N0g
 VS6qi01wCsHSkOIiokqgDz0sYuDOQ+5ryzdPDA1IrWfvtmlIX8silIVuQE8sryayXlqM
 /j7KJGcqC8e8xAUO98NZXOxFMcm2rcZqPNQn3+2QF2LF8afcvnNr4IQjQLRK6Q8f9LPI
 MY6q5bwHI6e5nZqj2AMNMWCvfauuVVtLSfJJ20bLuO6k8QpRMk46cngNQAxYc2LSbX7y
 IriG77oR2Sabpxx/Obf1irF0DtWu1HxRh3esB1rPxzkxP+vxS9QygfA8eAwHsqVcZnz5
 S1IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yVWaV1UktvSBD25K0YgjQYcbsOuuc9ZY/mdtIE42hLTdM309ibakiIgFFoQ8JqG5T9W32S5AtyXCY@nongnu.org
X-Gm-Message-State: AOJu0YzL3eZ5ASTeHtaDe86ZQ0fQuT6xJyO3kt4aNAQzL/vE3469R0Lm
 eay3X5Pa/3IssM2JJNlWBspdbMn2uk/RpQEnLH58yM0E3yFv8SRaSM9unnwNxQ+CLFxXHrHPGSx
 9IjE+hsH3lh6IN0F2GE2YgPdJr5IkIYNorhxlCEQDAiTxwTOOA5IEwIDA
X-Gm-Gg: AeBDiesVg+gTFHTnObeKZo8Hhqzh/TYVfIbq0VDaKm1Dm8ZeYjYsAZB2cednUTl4TNf
 ymHHffYbwcVXtjgry1AsmN/efXVSKSIjq7mtQ8iMLMMgJC4KHwzhnRlBNXoxwrUdRIPBVw44Ihy
 Mfi771KoJyzjPYd+xZk51HKEZvBfBHaS0jc0rYtlMrmVr0ZHH9v+I42Ht5FahumXUCVCEI0d3Na
 SmqSfIlluvGHthe5YMhLnTBhPmyaiElkw8gPc/0cYZPM/4MfcgZHu0PuuMuZUbzBksZniAZxidN
 7xdQ8hU8d9bK4V88rz8F5CQQjh47RpMfKhTg0IWrs+GoxMHR4DieXZAFdusIX0mhLdfLQAqz+IC
 YLzHRQSto3S2V
X-Received: by 2002:a17:903:17c5:b0:2b7:a08d:9e42 with SMTP id
 d9443c01a7336-2b7a08d9f73mr81016865ad.32.1777026758960; 
 Fri, 24 Apr 2026 03:32:38 -0700 (PDT)
X-Received: by 2002:a17:903:17c5:b0:2b7:a08d:9e42 with SMTP id
 d9443c01a7336-2b7a08d9f73mr81016545ad.32.1777026758530; 
 Fri, 24 Apr 2026 03:32:38 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab4bf7bsm221195045ad.81.2026.04.24.03.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:32:37 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:32:29 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Pranav Tyagi <prtyagi@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2] migration: Fix blocking in POSTCOPY_DEVICE during
 package load
Message-ID: <aetGUBIswlBVwZVq@fedora>
References: <20260423094438.43556-1-prtyagi@redhat.com>
 <aepvNu6ko5KfFY3a@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepvNu6ko5KfFY3a@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Peter,

On 2026-04-23 15:12, Peter Xu wrote:
> On Thu, Apr 23, 2026 at 03:14:38PM +0530, Pranav Tyagi wrote:
> > The package_loaded event is not set in case MIG_RP_MSG_PONG does not
> > arrive on the source from the destination in the return path thread. The
> > migration thread would then be blocked waiting for package_loaded event
> > indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition the
> > source VM can safely resume as the destination has not yet started. The
> > pong message can get lost in case of a network failure or destination
> > crash before sending the pong.
> > 
> > This patch removes the package_loaded event and uses rp_sem, instead of
> > kicking multiple events. The error is detected in case of network
> > failure or destination crash and rp_sem is set in the out path of the
> > return path thread. This will kick the migration thread out from a
> > condition of indefinitely waiting for rp_sem. The migration thread then
> > fails early and breaks from the migration loop to resume the vm on the
> > source side.
> > 
> > Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
> > Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> I assume Juraj has looked at this already internally, in that case you can
> always attach his R-b directly when post / repost.

I did indeed check it, you can include by R-b!

> 
> If not, then it becomes a sincere request.. :-D
> 
> Thanks!
> 
> -- 
> Peter Xu
> 


