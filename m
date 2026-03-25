Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7061109E522
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5WEq-0003U9-8F; Wed, 25 Mar 2026 17:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5WEo-0003T0-KD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5WEn-0007KS-0Z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774475882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IOSsXQwXgCyohSWF4ickTCb+bYsKHCvLaHWhl5yfdy4=;
 b=OuS3Y8t6/kgGMMcR7fOk1a6M4yb3etf+7SjDVXQZJ+u/ABzmxAxTCSHukJTgkL0srIUfVm
 QEzMk5aDtQVV1FwUeqm0IoVxS3qP6hbVbT3LVDoc0et748nF4sc3KFjGUVaJqCc9ECxkcz
 c8L4xusC62oSICL2iJHlwkS9YUcKlHs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-fSXzVdYDM-myJqqEuSAjpQ-1; Wed, 25 Mar 2026 17:58:01 -0400
X-MC-Unique: fSXzVdYDM-myJqqEuSAjpQ-1
X-Mimecast-MFC-AGG-ID: fSXzVdYDM-myJqqEuSAjpQ_1774475881
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50925fed647so11136061cf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774475880; x=1775080680; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IOSsXQwXgCyohSWF4ickTCb+bYsKHCvLaHWhl5yfdy4=;
 b=llzbk7X56m+Ojbt7U10VoWcRJE0RPrvTTJIVKHA9+mT4TxBPzeu/UNond0DRWM/h54
 HHWgPtrAK3vTUXwk1G1EKuTwmOz6vvlQOV3L3PDewZuT302e4LAfjc1Nb3W87Md4M56X
 3ib2uqE3SOvOZp7+G9nlnPpiZIcGHOroAL+7Yvaw/DsHXyRdOyZyJ7hptQbZBdYvHr0D
 2BbATRSJjdxUxffOuJWqZv6UhJYmDKzVfAW6ymPl98Lxdfow+xEf5DPkAK0ex+496BnH
 6jGXdzYciAYNxxcOXz5sg5W/VhWKREyCBf1gHqZ135S9GcyvVRtmGblcHKeLdOMYgLs4
 il2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475880; x=1775080680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOSsXQwXgCyohSWF4ickTCb+bYsKHCvLaHWhl5yfdy4=;
 b=TUypWlpRiX+JbGWVE926xGvNr25VF1aVlaZIEgBWVXD87fy/YfmkLtvaXJP2RP3Bvh
 /CMgpLKfNhGkmEO/XuHbE5YZF/8ION5rbhUip1nrMNkWVMpS6orr3K6a1gDC9FtAwb1i
 uivpXhuIZeg1X9daujhQdYGPbcQIVIt7Gb/FUwU8xm572A2DjMpFno0JVLYir+dD23in
 3KJhaft/Y2KyRkx9jhTtUz7UCnAxJn3neGi6wsStfAhbO4yVfE+GGLlGIK7zoWS5TfW5
 aFdRmil7bkmM295oDnq0MesuIFn/t6IYTcyv8fLlt0KCttq8QXCD8LtxZb7CqMHK/QSr
 5rFg==
X-Gm-Message-State: AOJu0YxV5yIX3S23UFhVBXYJntb8dR0CZ3eEAwERFgC/z+VC6kEDjKyC
 Mcny70kCC40YklkRG/zWB0cR+aN28zmzj8GRsElJw7LSiRRjcBknj7KiRrqy5mOw3Kl6kFTM1/v
 QivMXfhn7EPOjP/GQBMkSrj2R+GYOl44JDYpbh0Zvz2zriVS5jvsqfEC6
X-Gm-Gg: ATEYQzwSTL1vGb8Ld/m2nwJrBWKlWkF6u/0V7FN5fnOZQLDus0JvgmZJpxfr1sPUMJR
 BoRhOJGOHJHGXmroOv6ShlX3Xy1jwu0gx82tkjzSQXNNzEk4IvL0BFz5je/dn5LTFw3WJpCjxgN
 WKXTTPthkjbTfpYFSD/hoZP8z8M1ZTQVN6FOOryyLSJ07CZyey7L2/10XprocjrEnc1H9epQhEF
 n3KTy5LqiyO2KtMEbhccXntyj4TIyzmegoYsMtQItQwko6zl24Ankqb6q9/LO7fWUUb0hll8Ldm
 AmxQ1kq660dZI0o5AXC+96sqYcb16JOq31+MNqUaJwvpsFbMpWPOtTPlYrASs0UvvFPyca8Z5d6
 mI0TyYl++kOIEDg==
X-Received: by 2002:a05:622a:5b03:b0:50b:3f09:1942 with SMTP id
 d75a77b69052e-50b80eeb845mr70257651cf.66.1774475880535; 
 Wed, 25 Mar 2026 14:58:00 -0700 (PDT)
X-Received: by 2002:a05:622a:5b03:b0:50b:3f09:1942 with SMTP id
 d75a77b69052e-50b80eeb845mr70257441cf.66.1774475880007; 
 Wed, 25 Mar 2026 14:58:00 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd5855280sm7818406d6.1.2026.03.25.14.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:57:59 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:57:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 13/17] vmstate: Drop VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Message-ID: <acRaZpYQy4y87lkM@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324194333.30004-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 24, 2026 at 04:43:28PM -0300, Fabiano Rosas wrote:
> Note: I don't quite understand why we cannot allocate the first
> element of the array with VMS_ARRAY_OF_POINTER_AUTO_ALLOC, so I
> avoided that case when using the other flags as well.

I just notice what this question is about after reading slightly more of
the code: note that we should allocate all elements if AUTO_ALLOC is
specified, what is introduced in patch 11 (vmstate_first) is essentially
processing the array itself, so if VMS_ALLOC is set we alloc the array, if
further _AUTO_ALLOC is specified we alloc all elements in the array.

-- 
Peter Xu


