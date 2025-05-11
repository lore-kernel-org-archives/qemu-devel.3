Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BDCC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 18:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEBaa-0006TA-FI; Sun, 11 May 2025 14:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBaX-0006Sp-Kf
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBaW-0004hb-6M
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746988786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbklhovVI1XGSEFcmVYp/8ekjt/+h0BOdky+VPcNyIA=;
 b=J+kHcxfjNNQUJARjtBYKrPdOwSwBw7te1M8PX7CqY9GW5qssEp2FOv6qTlWn0w/XXvQ1l3
 Gp4xhE+gaifbppocEVU7+UcQyyet/chrTOwgAEOYbs71hJ1YrQu1XYkMJRtRpGtbaRSc4m
 VAcC1U/aOgXsTgd6Z7ALNVu5SntQG14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Ot022MhzM360vFnDkwBqJw-1; Sun, 11 May 2025 14:39:45 -0400
X-MC-Unique: Ot022MhzM360vFnDkwBqJw-1
X-Mimecast-MFC-AGG-ID: Ot022MhzM360vFnDkwBqJw_1746988784
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so18701095e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 11:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746988784; x=1747593584;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbklhovVI1XGSEFcmVYp/8ekjt/+h0BOdky+VPcNyIA=;
 b=cf1L0Meo7gIuLwvC6m5ZuyTGSBr1kVAJ4MpwOiv/aFf1yxwmCco/1Tb6UKqXL9WaVr
 E5kOxJaWLVUhO/D7UOvGmNKoiZGx3TOPIamRc62NFmJIJxhb+dRikJU8DP1m0NrqdCpn
 gdaCx1ZWo/fDSRSWLY3+WSqbTuX0S0ssximhghs4ZmzhiS3UchicCUhkFMaTZm7imfcW
 23N4k1x4ESszv55WMQ1RkIzeiPU1qtRr+uLf9c1PLaueeopoTOsNPJ1cpOpFyW5Wa8VN
 Jj8F1jhqivvMH3ZkvMJXxel6mQts05ZWDSy411iXQoSXAOPsDzSPx8HsmmSImj4z1n/E
 K0Lg==
X-Gm-Message-State: AOJu0YwjYQ1SHIXX2uhIy609Jhk+hA8q1Ju2AGUTd2277x1YuHJkI0hA
 HPEj2WV84HTaqhdXmFCRPG1B8EKR2KHWu5WOmhmG416ARV5b3k06iIUmmK6suuuJ557d/Uwjjyt
 5VIODUa9a1rEBbK5AM8ekHWt7n+ock+CGVYz5zoSf2b1NvB8hNBJl
X-Gm-Gg: ASbGncvz+hhgoQ3hJfBWe2x6cunvF5xXd1hI6+xmZfyXcjyvHC1Qd7DKW/jOIkXrsxV
 LPvinBWFlZ5FnburtpdsEVFdicUavHqW5w6vTx/NKJAZjbMOEcTzZ5RxWw1Wuy3qA7ktX8GQ6Wg
 zlvRNWTKuTbzAW2zFmM7uThE5Iy7YYFSk9JAN2flz7RMxxVr1WBMmNTaOICVY0Qvh1YvAyZxEgH
 RBkwBg9D8bTp0iTItSY0EbiJ36NBOVY2u1Fv477ihAX1Jgn12uNvJGn2f0fiO9tKzMmQdhtaOB8
 1Q/6SQ==
X-Received: by 2002:a05:600c:3586:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-442d9cacc19mr79965495e9.17.1746988784422; 
 Sun, 11 May 2025 11:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHduNZ+Wkxau/5qQBa4zLYLxHgpJQE0XCXgujfBqZ6phPDyVbUwpFPfe3FleSUCjO0d3eAq6A==
X-Received: by 2002:a05:600c:3586:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-442d9cacc19mr79965315e9.17.1746988784054; 
 Sun, 11 May 2025 11:39:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d77e4ec3sm66006245e9.1.2025.05.11.11.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 11:39:43 -0700 (PDT)
Date: Sun, 11 May 2025 14:39:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v3 0/5] hw/virtio: Build virtio-mem.c once
Message-ID: <20250511143917-mutt-send-email-mst@kernel.org>
References: <20250502214551.80401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502214551.80401-1-philmd@linaro.org>
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

On Fri, May 02, 2025 at 11:45:46PM +0200, Philippe Mathieu-Daudé wrote:
> Since v2:
> - Use TargetInfo API (Pierrick)
> 
> Since v1:
> - Use max extent size of all archs (David)
> 
> Based-on: <20250501212113.2961531-1-richard.henderson@linaro.org>


virtio bits:
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge.

> Philippe Mathieu-Daudé (5):
>   qemu/target-info: Factor target_system_arch() out
>   qemu/target-info: Add %target_arch field to TargetInfo
>   hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT to runtime
>   hw/virtio/virtio-mem: Convert VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
>   hw/virtio: Compile virtio-mem.c once
> 
>  include/qemu/target-info-impl.h |   4 +-
>  include/qemu/target-info.h      |   9 +++
>  hw/core/machine-qmp-cmds.c      |   6 +-
>  hw/virtio/virtio-mem.c          | 101 +++++++++++++++++++-------------
>  target-info-stub.c              |   1 +
>  target-info.c                   |  15 +++++
>  hw/virtio/meson.build           |   2 +-
>  7 files changed, 90 insertions(+), 48 deletions(-)
> 
> -- 
> 2.47.1


