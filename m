Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E9C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQkv-0007dS-0R; Fri, 07 Feb 2025 10:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQkt-0007cU-96
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:58:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQkr-0006Jb-PS
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:58:59 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso15129015e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738943936; x=1739548736; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kqeh+h1QXkswiJkm4JJr0gR4w369qLmdh3P5XRMBllc=;
 b=vtyu5fp1iPJX4euWrhP8Ac2JsL4nhv8ubNY8lcYzgfHs2jGHW1/CIdV6RLxchUVdco
 pYAcSFx4ekHTzEjH2196VEkfM/bI2Qex8NPigYTeqE14s65ub/TxByQ6TGtQHhevzV+n
 bEtJn5Kb1lmsgzJndjfqvcWtdm+QHqpz3MIP38tQ136DqLXIZqS3B4bUihaZ8wQEDFFZ
 lnBNGZOdmJxr+tAev4+l2oTTKFXx+duZjtNlIzS6NGLtMMC7EglwgxwtnF84++lN9g5a
 sheoOc42CdEH7Jkb0HyAvbqW/aUqlJuvjaLXj1hN70s0y126A75bDUDRk3uoKYMDOfkT
 S+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943936; x=1739548736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqeh+h1QXkswiJkm4JJr0gR4w369qLmdh3P5XRMBllc=;
 b=PdevYS2LLRet4x6B/hA0H7ijk2dZME7GFNHNGhswsGr0RukG5rCv3FiSd7Nw9KX3Do
 DhMgbv413WRJ1mwpP91gly1wZsL+f5VdhOmsn26L9VhzDHulPV6Uq7alXXRmy9YaRjKU
 PrdFCbsJr4GGaWzGheWBPoYgh/WF2tXw/FXurrD/n7WLRAAiHiQoF2NCjGK+YFAbLxRQ
 cY4ZrjfY4fiXjFcoZsyxQLGvSItMjOh8N4BlbceX2/fZucS7IKYHYRT47W5v4noIGh65
 N5BaBSGIpssxaMaU+zdXtpJ4dWgu56gGf71DegbL63YQH23zu/W8QlfiC/Q9AsnnrSPy
 4Sow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVesAymicmAaZe9QhNegi1d1B4nbp/XbLQLIQ2YiVn9ZckowYI8mChGoYLClxNOd5MQcbs1Bk3lNaEk@nongnu.org
X-Gm-Message-State: AOJu0YwskFXuN7LJLVlej+AUj2Xjv5+qsNUDpjELHsk2NneLVeY8DR4k
 nUUSOXjDADOt5AF+SCsx1rNdh+qS5vZgD2DdcvyQHny+oyDKYEfz2W/3wc8m+2Q=
X-Gm-Gg: ASbGncs0VWRpA3ySXQfyuFu6yHFnsefTIb+MgJ9oYzi7pfNVNEhevWvdNK0tEsfBVCd
 /nV5E/VGQvQqkNAEdSzins5b+1lUq+p1EHu2t7iES1SMWgjFMXoZ5oEc6FVBUbdQ+8MV59WKLhA
 FyWhPwhT92CEN8Z2RapUcFiaWBE+67mnyV+ka6YabkeJl+IavFTN++h5U9/2WPzdoV6sz7wbFJS
 WkjxYEvsHasfJ1QuQdgQiFCAk+WMyYqRyCkVy0jZE6T5/u2t807uhi1VxNCkcLm1+1EG6Gw6kec
 CZtJabpq9r5tsQ==
X-Google-Smtp-Source: AGHT+IEuWkdH2e+ehVQ7UkgUJ/atzJB1wHcX0nVz7kTWJubhBVqxzpXeLrW5oXbuVgXGY8VyJVvrlA==
X-Received: by 2002:a05:6000:1acb:b0:385:f195:2a8 with SMTP id
 ffacd0b85a97d-38dc90ee7dbmr2293163f8f.30.1738943936312; 
 Fri, 07 Feb 2025 07:58:56 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde31d9bsm4899334f8f.94.2025.02.07.07.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:58:56 -0800 (PST)
Date: Fri, 7 Feb 2025 15:59:20 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v3 09/26] target/arm/kvm-rme: Initialize Realm memory
Message-ID: <20250207155920.GD3546768@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-11-jean-philippe@linaro.org>
 <91b825c4-462f-4663-8412-effa84c0863d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b825c4-462f-4663-8412-effa84c0863d@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 04, 2025 at 03:30:00PM +1000, Gavin Shan wrote:
> > +    hwaddr ram_base;
> > +    size_t ram_size;
> >   };
> 
> s/size_t/hwaddr. To be consistent with RmeRamRegion, we may reuse
> it like below.
> 
> struct RmeGuest {
>     :
>     GSlist *populate_ram_regions;
>     RmeRamRegion init_ram_region;
> };

Good idea, I'll make that init_ram

> 
> >   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> >                                             CONFIDENTIAL_GUEST_SUPPORT,
> >                                             { TYPE_USER_CREATABLE }, { })
> > +typedef struct {
> > +    hwaddr base;
> > +    hwaddr size;
> > +} RmeRamRegion;
> > +
> >   static RmeGuest *rme_guest;
> > +static int rme_init_ram(hwaddr base, size_t size, Error **errp)
> > +{
> > +    int ret;
> > +    uint64_t start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > +    uint64_t end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > +    struct kvm_cap_arm_rme_init_ipa_args init_args = {
> > +        .init_ipa_base = start,
> > +        .init_ipa_size = end - start,
> > +    };
> > +
> > +    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
> > +                            KVM_CAP_ARM_RME_INIT_IPA_REALM,
> > +                            (intptr_t)&init_args);
> > +    if (ret) {
> > +        error_setg_errno(errp, -ret,
> > +                         "failed to init RAM [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
>                                                      ^^^^^^^^^^        ^^^^^^^^^^^
> The type for 'start' and 'end' would be 'hwaddr'.

Right, I changed everything to hwaddr

Thanks,
Jean


