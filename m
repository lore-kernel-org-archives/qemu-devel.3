Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D367C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgKDZ-0002wS-T0; Fri, 07 Feb 2025 04:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tgKDX-0002uo-7K
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:00:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tgKDV-00018W-Gv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738918803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NuTAmV5clwriXRho+EYoWIJz6z86Rcetl5FEVWojCyI=;
 b=Dz/6DYPbMiObHSkGCUK1Y1OuILHt+GUadXSzfywBduXwvVWTn0lx9kU9cxnvhlfwM3Lpak
 VmeCTiBHMHr3nUVjS0tt1Vwby9YzH2hKnmG/FHuTBFvCLdR5w+aE16cE1Dh0PDQ0fTHRWd
 +8Vvjskjh7OnA9mBK2k6s1qzzULCKKI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-wYcCZjBCMp-wsqGiZePg2A-1; Fri, 07 Feb 2025 04:00:01 -0500
X-MC-Unique: wYcCZjBCMp-wsqGiZePg2A-1
X-Mimecast-MFC-AGG-ID: wYcCZjBCMp-wsqGiZePg2A
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436289a570eso15123295e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 01:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738918800; x=1739523600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NuTAmV5clwriXRho+EYoWIJz6z86Rcetl5FEVWojCyI=;
 b=iybVeyl/zsrjmM4UGuTGu2YakDWUVNurnJmSfKRyUnoj4GDSv9n82qEGaLaGpj8Jne
 88V1DdFn564JFzNhtPTvCrymC62niBTUz6mGicrPLdleGcRwy+3wqMJA4mVVhyDBSNyV
 mknYhKwyQ7dtJXELXqLsbIQHgMO6KYb42OgOOCfR9xejLHBNY1ZWXSLJYg41gO1vB2dW
 r9SW1mioU+0s9YdSFPPSFYewAa69gQOBUQ1eGypolzvetWGDv8kkNx3JNTaFuZ//YzXV
 me/uaDBEPUnZ5c5eD0QEGeHDm71F4Q7NqkTHa4drHFcwxrNNLJgUyLvVatk7xk4/vf6d
 U7jA==
X-Gm-Message-State: AOJu0YyszJ6UoVsLqchJADrolUB01B7+yj+p7FW00VPbM/Hpc1oDVRSt
 MtmPkn4Fz3BMtlqjiP0dIJDekScwsScpVNV2upPojnXRHrXEtpVRlKC1FHwvgDkdYEjpLxvGTto
 5WTQXJ4oq8UvgoA/340zljyXhM2ggUvyEG55gMrzbg8fESs937s49+sIXMW0rezGxR6dxmdHyJN
 KHTU31P49Rl68rowW1thVqANaoscc=
X-Gm-Gg: ASbGncvWxnH2o3DQhV6JO7JvEll7Hn6XNckCZmhmTKsIoeB5ePv3kDUizRh7hy4MKj6
 O02GpASw08299mAO0TYE8jxXYFa055rmV0GKk6YUVqeBN4N/wxxLgcR44J6QsSg==
X-Received: by 2002:a05:600c:1e23:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-439248c2c07mr24947435e9.0.1738918800047; 
 Fri, 07 Feb 2025 01:00:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjNUZegvlqprIBLc1ikda9wG2fIwDxhZDhMAdBxFHFjYl27AB8fVv2GIWeNx9m5pfChH3VJB5JbUe77N+aMtI=
X-Received: by 2002:a05:600c:1e23:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-439248c2c07mr24947275e9.0.1738918799783; Fri, 07 Feb 2025
 00:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-6-ppandit@redhat.com>
 <Z6U7XQO-Mjgb92eb@x1.local>
In-Reply-To: <Z6U7XQO-Mjgb92eb@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 7 Feb 2025 14:29:43 +0530
X-Gm-Features: AWEUYZkXNDi1fivnToGQgF9moKaGNvxzhJsj8at3i98YotYT2hPV-hmnO114RpQ
Message-ID: <CAE8KmOxX2TispJfu=de_u8JuAqHa=y0tjW6eEwsAAf-98r7WPw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] tests/qtest/migration: consolidate set capabilities
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, 7 Feb 2025 at 04:14, Peter Xu <peterx@redhat.com> wrote:
> Would you mind reorder the two test patches, to avoid removing the lines
> added by previous patch?

* Both ways they are the same in the end, no? Anyway, will do.

Thank you.
---
  - Prasad


