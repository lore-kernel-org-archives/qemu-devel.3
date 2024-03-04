Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42465C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1w7-0004dY-Jh; Mon, 04 Mar 2024 01:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh1vW-0004UU-Dx
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh1vU-0000mD-KM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709534151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=isiB3iqbcFlvdmOfBVXRYZeqOy8i1c4ZbMDshxgx0AU=;
 b=BsvIfTdliVTS7dkRnue6oDpozvLnobWuxF36BqPiIBw+uqTQQr3fboX1OpQDaCM+XotLhw
 BgxRz2e7RAyezGB4MkloqnA7g4KPIfIoDwNk3PkJrZ2strN4XfXnbEyw3WXEimR2d8nPo/
 s8HghFUUvUawHOj0Q4w9SoUL8J9/NJI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-d_3XHEKAOa6qNanQdv24sA-1; Mon, 04 Mar 2024 01:35:49 -0500
X-MC-Unique: d_3XHEKAOa6qNanQdv24sA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412e4d20b28so2189405e9.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 22:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709534148; x=1710138948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isiB3iqbcFlvdmOfBVXRYZeqOy8i1c4ZbMDshxgx0AU=;
 b=Cpu1Zh5YYTuwfIOpZi8mZf/Phl/TwJZw3dDfLZJb0xOhkkIrQGMnmlunEL9I9drfH1
 H6Rczs/IIE/kKCz3IwuaOu1l9KJbGFUxOPQw24Rz1OrDcDgTGUQseLQpLThtnmWaGMmR
 MURUSN79iNTrYh1Hxn2ofMhWTkE8/MUmEDBcQpWZ1an4bNJKyinJjat+D676W6BeP4dz
 MPmC6EURheIrBog2jpIs1RBa41CBPm6AnkOJN09zGkQ1aTbGPVIQxoC2/xUyQ37dgNTJ
 LyyH4UDha9GvfcRiXMFg3CoesZvK9YmJPyqQzwGsEQ+UwVDau6wxYT3Ef4c1diymuYAV
 dYDw==
X-Gm-Message-State: AOJu0YyIzBQ62Zig6QlzgFcN4WuW+78YOA5gcNKHq6dIp85Dm40v6QbS
 Gkthowb8IbCjdiEUZA+F5psl5g81OEYCn0LIWkx2x2drfBNhagv6meNGDkyqVe+JET6eOs5aVCF
 gPItybTByglDmY/jVdaCCcHLml5OHdobMjBgBIHuBHPoOaGVbn5MCuF2rbxN8WV6PvWwS7zqaJf
 9i3qo+v0TkjGrULApMDXDNLmk0CG8=
X-Received: by 2002:a05:600c:310c:b0:412:e708:488a with SMTP id
 g12-20020a05600c310c00b00412e708488amr148760wmo.40.1709534148380; 
 Sun, 03 Mar 2024 22:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBJVCM9Ats+7TLo4KLh6JKdGWsPAASkSgozCkHCOjeBrk0SJ1aHB0DBb1jSw0JkTp9M9ekKM+WSCH0W9huWWQ=
X-Received: by 2002:a05:600c:310c:b0:412:e708:488a with SMTP id
 g12-20020a05600c310c00b00412e708488amr148750wmo.40.1709534148040; Sun, 03 Mar
 2024 22:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-7-zhenzhong.duan@intel.com>
In-Reply-To: <20240228094432.1092748-7-zhenzhong.duan@intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Mar 2024 12:05:31 +0530
Message-ID: <CAE8KmOxFnzsw2das+Go_EEyVUr517hWS8xvXfN1VoJq0RofR+w@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] intel_iommu: Block migration if cap is updated
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, 
 chao.p.peng@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, 28 Feb 2024 at 15:17, Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
> When there is VFIO device and vIOMMU cap/ecap is updated based on host

* cap/ecap -> capability/extended capability registers are updated ...

> IOMMU cap/ecap, migration should be blocked.

* It'll help to mention why migration should be blocked in this case?

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 16 ++++++++++++++--
> +static Error *vtd_mig_blocker;
> +
>  static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>                                    IOMMUFDDevice *idev,
>                                    Error **errp)
> @@ -3861,8 +3864,17 @@ static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>          tmp_cap |= VTD_CAP_MGAW(host_mgaw + 1);
>      }
>
> -    s->cap = tmp_cap;
> -    return 0;
> +    if (s->cap != tmp_cap) {
> +        if (vtd_mig_blocker == NULL) {
> +            error_setg(&vtd_mig_blocker,
> +                       "cap/ecap update from host IOMMU block migration");
> +            ret = migrate_add_blocker(&vtd_mig_blocker, errp);
> +        }
> +        if (!ret) {
> +            s->cap = tmp_cap;
> +        }
> +    }
> +    return ret;

* I couldn't find vtd_check_* function in the tree, but what happens
if vtd_mig_blocker != NULL? What will be 'ret' then?

Thank you.
---
  - Prasad


