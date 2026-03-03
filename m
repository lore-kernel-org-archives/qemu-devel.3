Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21960EC1452
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQ8s-0006xp-8i; Tue, 03 Mar 2026 08:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxQ8k-0006pd-Ji
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxQ8i-00034b-1z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772545818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdqA/kmjpsE3VC0ENsT1VKsbar2/DNF3vL+6YVM6Xzg=;
 b=ay6yG2qzFdo0QGxe2++fBBY4+HOOsyY7U2Pb45unlhgJ9yYOcbnXcd9R0G9aImZOI9kITy
 WTAr6u2jBuhzU6+rfg4kDjkql6kRCUCWCZ1r201REQl1UcfnxmEzPACeHAOIKH0hCW2VbO
 bYuatLeSeRAJRQ17S4TcHcQyiWi2vcY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-A5vQeh_bNc6UwD03HyEHVg-1; Tue, 03 Mar 2026 08:50:15 -0500
X-MC-Unique: A5vQeh_bNc6UwD03HyEHVg-1
X-Mimecast-MFC-AGG-ID: A5vQeh_bNc6UwD03HyEHVg_1772545815
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5033c483b76so500213631cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 05:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772545815; x=1773150615; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AdqA/kmjpsE3VC0ENsT1VKsbar2/DNF3vL+6YVM6Xzg=;
 b=fOEH46pTf0IfEFsXAMzKkGktBi7lSNta+qWLh6WGTeIfYC5a1s+T7AQf60nPvYBq94
 yt8RxY5iGC9REjuBEHer2ILHQ1KSpUoE0S8wZJQ/HM4Re7f6Gi3Q0hqPRTrMBkorDuJg
 flA24Yr+csU9m6/7QmjMMmKavPgcvdaRTdzUtSnfmnkX6Y0rO0UlS9T8rSeE1tqsyDD2
 a8IzKs0quioV+d8R5QLMjVkfBNurIAq5w7zpt2wbrpA593vcSJwMS2n8laFuer6tOYrI
 IfQR5W391LyZwoxonYrxZXX6IrWLLL+Z8dWrPXvrwhryQxkF7GHhlZGv6AaR7FvBT8oE
 E3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772545815; x=1773150615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdqA/kmjpsE3VC0ENsT1VKsbar2/DNF3vL+6YVM6Xzg=;
 b=hk4hFaW7foIraGnkckQddmcLnOB/v+Bonw6NKF+xi5rlx5r+8LCSLX67lJYK2cAMAT
 gUR2kf3+/iI5qb1yx6gBSYwDfpY2xp0KEc/2xDxy4eRddDpiqBMcVVdyW3OW4DqM8jRd
 oqUm3iZ2pUtq+6WZKAM7ZQtAQvdBnCtrH/lF9qWN+V8VVcC4f5ZSEFHi5FWhGJQZfsI+
 7w8yG4dleSxhhxXOyAbCc3ffXJseQSc5hXgHIrM6yzphVGegFQfYsW561ZcvfbFXkb/6
 gZsxoLm++d3Cqi9KcFo+Gd6vaW0wfHY5EvBLZnTHHUL8R6vv2dly1X99lLIWKJ+ifB7O
 o2pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUODHoGwV0MYPzOh8BSZ/pg9nId4A45XDu48Bx6I0k4PfFlNAQFRggGa+ilrE2zJ3rdRAQrnPhEyRrM@nongnu.org
X-Gm-Message-State: AOJu0YyljBUjX7HNE+SRZtcamXpYOFfqVIaBmPX729Krnq0eCOKMCVUW
 EaImIISKMmi15Ip+TRiXvgrFbyWXafDK6u7rPU9dE+oufC5NbAthQRO8z0bPRFB73t1hi3Fbmc5
 hse39DlBUUzMqzBDZKKLH5fEf3IOyDcAG5tjyldnjEN8aJOB+flXxZCK9
X-Gm-Gg: ATEYQzy5an+SQSuUWwR9lsQpJ5QwLm/wPO4u3OR6546dvoIwu1RnIAvV5230KwlsQ7f
 Y+KcfmaSWvd+vD+K1lLbpnkne2vYc81eD0O+wGhasDGKXBek1vdFR10ZgVxWb3bugQXs1782pzL
 vswegTfo9e0StXSkphxiM7LKYeFyXzzpEH0DmBXtgzI2CMdqTn5LFHh1Ra9OsedfPC6fndUfYTv
 n9C+4xTEu9g2vnPfVONsWooggjOfOqQCjDZYkJjdfwHiiPgkmISB764G7p5LdPSjYYMNw/2dxNU
 YiXSxwOGPEGoE0qb5NOEx1jAuPzv/UWWGCJ7Vef6LuAVCAuvGb+oVRv5zkEN0o4l+nvQDkn7suk
 tIS0j5Xms0x+KCA==
X-Received: by 2002:a05:622a:138d:b0:506:6e65:2334 with SMTP id
 d75a77b69052e-50752884908mr176471051cf.7.1772545814635; 
 Tue, 03 Mar 2026 05:50:14 -0800 (PST)
X-Received: by 2002:a05:622a:138d:b0:506:6e65:2334 with SMTP id
 d75a77b69052e-50752884908mr176470761cf.7.1772545814122; 
 Tue, 03 Mar 2026 05:50:14 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449add38sm132020941cf.13.2026.03.03.05.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:50:13 -0800 (PST)
Date: Tue, 3 Mar 2026 08:50:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH 1/5] vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
Message-ID: <aabnCoT3Wp6L_ZuJ@x1.local>
References: <20260226100232.500781-1-eric.auger@redhat.com>
 <20260226100232.500781-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226100232.500781-2-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 11:01:29AM +0100, Eric Auger wrote:
> Already existing VMSTATE_VARRAY_INT32 requires an array to be
> pre-allocated, however there are cases when the size is not known in
> advance and there is no real need to enforce it.
> 
> Introduce VMSTATE_VARRAY_INT32_ALLOC as we currently have for UINT32
> and UINT16.
> 
> The first user of this variant will be the target/arm/machine.c cpreg
> indexes/values arrays.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


