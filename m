Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2015AC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 18:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEBM5-0007n4-59; Sun, 11 May 2025 14:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBM2-0007mo-N5
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBM0-00038C-Up
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746987888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gT2mErdvlqF2y+ihb05ALdICj2zUCRhsfgi8UyXLA7w=;
 b=UyzhBBEaeeG7YrZoCrlwrODjEVVbShuVfvfxneBNm78JACKU/slJXwbc9KQRKoHjR2fCSb
 5t4A6yGG9YQWRNM4dyW2jSEurnessPOaC6+jFOP7utfZABOxhFe3Gfmif0OFGcISYV4Ae9
 rfAZJT65c4a+sTuiY269D8fSGRdroE4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-59BsI5wgMDOIGogk7602DA-1; Sun, 11 May 2025 14:24:46 -0400
X-MC-Unique: 59BsI5wgMDOIGogk7602DA-1
X-Mimecast-MFC-AGG-ID: 59BsI5wgMDOIGogk7602DA_1746987885
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so17520285e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 11:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746987885; x=1747592685;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gT2mErdvlqF2y+ihb05ALdICj2zUCRhsfgi8UyXLA7w=;
 b=JZtbVRifScZ0er8Do34G8e7SUUgCDRMIFMI72jfg+XtO6bZMF3aNFrYMqZQmktKtET
 BnhD4DKEbL7RmlOQkdzd7a+vglyZHKAR7/WRuPLRgK3MLd1mxT7sPvK5vQ6v3w5EZ5eE
 XcBUo2qD6dAINnvmsfc2ShpOvhOIDTQXIY/j4kigde3A3DuxgBhjdT2+VVU+eNUvouMV
 mi4dzdvUIJaNAW24fS15pdtY1mb3bt6gn40JnoyeBsNzn+gLC/6Z6C3p05AlQ5HsQH6b
 s7UuundQ5Ao72pidJZyamXbCrwu2HMn+kGd1mnesMvfVm+SSFHM1quNh7fnJL7IwUt4s
 zE3g==
X-Gm-Message-State: AOJu0YyUp+ixzZV3DE8HV8mH1y7IX9ZjN3eR273BWW8TyqKbADOkMt1+
 vS4OXgoawykRUw+eJvee+hLclF4lbt1RWcYkD9p/5RzL+SgmDLvWkT4G2gcf6xPIZNy2dZYuMyY
 oEPH0m0oEQPIwhCTo65Z/bNDtZ0IJHdkxMbndVBtPXkQqT0nDwyeI
X-Gm-Gg: ASbGncvuohLaY3wD4LB4rGegJwMYBTb9ys2pJT7VK7bdzDTvyGZ3E0sn4jx+7Io/Ua5
 IphMTjjA/499QiJ3QM/W0kF1qySxhB4bgg4zPcsi4QXFzCP6QLqVx57ZEiTznbbRNfB8ZolMmIf
 dyTFg/wkPH01WAt8LBHHwYJC6tRfBSDmrs1Yz88MPg5tO09TTDTx036vq8xYQx76djTCbyiE2/y
 ROrOHwuWGPOqbBTKgjASRuHaxoN0AiGO44h9MEaHknBOpq9ERLm1qkCNMot3mo0OPjFFPDpHre2
 Xkw96w==
X-Received: by 2002:a05:600c:4e45:b0:43b:cd0d:9466 with SMTP id
 5b1f17b1804b1-442d6d44b3cmr88298015e9.9.1746987885318; 
 Sun, 11 May 2025 11:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExQQ/510DO9GIdJjGFVA/eoJF4tbWIxmeEjMDwfx/KuidLp3rfMXYt6YiAzvcgFwyQKYK2Zw==
X-Received: by 2002:a05:600c:4e45:b0:43b:cd0d:9466 with SMTP id
 5b1f17b1804b1-442d6d44b3cmr88297945e9.9.1746987884961; 
 Sun, 11 May 2025 11:24:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bde2sm140213395e9.19.2025.05.11.11.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 11:24:44 -0700 (PDT)
Date: Sun, 11 May 2025 14:24:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 0/5] docs: automated info about machine
 deprecation/removal info
Message-ID: <20250511142433-mutt-send-email-mst@kernel.org>
References: <20250429131526.1842130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429131526.1842130-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Apr 29, 2025 at 02:15:21PM +0100, Daniel P. Berrangé wrote:
> Since we deprecate and remove versioned machine types on a fixed
> schedule, we can automatically ensure that the docs reflect the
> latest version info, rather than requiring manual updates on each
> dev cycle.
> 
> The first patch in this series removes the hack which postponed
> automatic removal of versioned machine types to the 10.1.0 release,
> since we're now in the 10.1.0 dev cycle.
> 
> The second patch in this series fixes the logic to ensure dev snapshots
> and release candidates don't have an off-by-1 error in setting
> deprecation and removal thresholds - they must predict the next formal
> release version number.
> 
> The following three patches deal with the docs stuff.
> 
> With this series applied all versioned machine types prior to 4.1
> are now removed (hidden). We can delete the code at our leisure.


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Changed in v2:
> 
>  - Remove hack that temporarily postponed automatic deletion
>    of machine types
>  - Fix docs version info for stable bugfix releases
> 
> Daniel P. Berrangé (5):
>   Revert "include/hw: temporarily disable deletion of versioned machine
>     types"
>   include/hw/boards: cope with dev/rc versions in deprecation checks
>   docs/about/deprecated: auto-generate a note for versioned machine
>     types
>   docs/about/removed-features: auto-generate a note for versioned
>     machine types
>   include/hw/boards: add warning about changing deprecation logic
> 
>  docs/about/deprecated.rst       |  7 ++++
>  docs/about/removed-features.rst | 10 +++---
>  docs/conf.py                    | 39 +++++++++++++++++++++-
>  include/hw/boards.h             | 58 +++++++++++++++++++++------------
>  4 files changed, 89 insertions(+), 25 deletions(-)
> 
> -- 
> 2.49.0


