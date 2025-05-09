Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDD0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDR0v-0006pD-SC; Fri, 09 May 2025 12:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uDR0u-0006j3-4g
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uDR0s-0002Dh-BI
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746809752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clPU3c6+Xzd9g35CRO1GiEKesw0SsTU9Vuir29zAB5M=;
 b=Kf4ZLLvNcrCEvYyGIEFdnFwdBQ8oaxeRFslpefMslozLdwH0EvpjF1a+EgW7GqeWvRLX67
 rK/Ta9tYSEw4ZXtLCzOG32O4Hp3plz7xQkIBPIvWZJJ4fno9Px3lr209uvN5abuML5s0an
 SFGeZSaxymuZzm9M6mGABv24bZKY4MM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-QBGzwAofMDqXFP-hFNNScA-1; Fri, 09 May 2025 12:55:50 -0400
X-MC-Unique: QBGzwAofMDqXFP-hFNNScA-1
X-Mimecast-MFC-AGG-ID: QBGzwAofMDqXFP-hFNNScA_1746809750
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so11292475e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 09:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746809749; x=1747414549;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=clPU3c6+Xzd9g35CRO1GiEKesw0SsTU9Vuir29zAB5M=;
 b=FGpu1suG7lLwbNzvySxQgGlvfWXmG5FtwFdbM1LkxeSk+5bgqjXRCvyfXA2BsY/moY
 M4xQQFm1EgjJ6gbKXsIKjHQmIyN+2yad7itprFgrNQc/XDoSRQjP9XKNQ6qz8Jnog+qa
 eVkMDokJ23JQZgcvQ4rw/H4oZhZlnFmjS6hTAtSp4Y99UHLeH9TTdbIseZ943krLeMYs
 gVxFn5skOkL+yo8bzrnGHqWtEWBtKX03z6j1cLoyK5r4hypD47Gmg9NOhkkeZKXh6THj
 Y5tur0BGQWfx9T8QU6A26ChUO6Km9G/YMTq881buxdEfxwUsf5ZttdV5laygBSyepAEB
 3SFA==
X-Gm-Message-State: AOJu0YxsDPfZI3JWH9c2ooQkD5xjspNw2lfgf1/CLy0IBaxFez8xfcnv
 lyalOeQsIWSZ+zNsraUymQNJUmS6aKT/tDZMxAcVc0UBp+6cjQuOXvQVnDthoSFMEDzSJNH4oQq
 7JGlUBJGcJWgkPAV2UlmD6qqkTMGgTaMrclUc9jim6BTAO/brs9Gd
X-Gm-Gg: ASbGncurTvcKTULQjBwSIfaBa65z2WDO5ToR2z/8bJrOgt1xRgDl+M49hOtMz2rVedg
 tfLaMZungNFZgsQ3lCNwClH/g9UaugfHGBUCB6ljOSR+aZxIn5XfenwJhpMZy5DN6owumozlue6
 JlsTFZ8SyDGB3oIgLqE875pVhr3t6UIez9cjZC17D4YC3bYEiWKilG5tm+U/ClplaNfPLgB2J6n
 kNsVT7J3BI/qUy2HSxtgbn7ijd8cyu4lJROcfvAp7u/GtKhchSzkNNIommikzP5OQOwkF5bOGeJ
 JEsAxQ==
X-Received: by 2002:a05:6000:144b:b0:3a0:b65b:78ef with SMTP id
 ffacd0b85a97d-3a1f64b6931mr3944112f8f.52.1746809749584; 
 Fri, 09 May 2025 09:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFOJQdPjQAaQ0U+gBainJuO+12O2XFCMDmdK3SXiUgXKkn3aWdhuDJIfdPWAx8Gtp+GBv/Ew==
X-Received: by 2002:a05:6000:144b:b0:3a0:b65b:78ef with SMTP id
 ffacd0b85a97d-3a1f64b6931mr3944092f8f.52.1746809749210; 
 Fri, 09 May 2025 09:55:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebec4sm3851240f8f.36.2025.05.09.09.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 09:55:48 -0700 (PDT)
Date: Fri, 9 May 2025 12:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 devel@lists.libvirt.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/5] docs: automated info about machine
 deprecation/removal info
Message-ID: <20250509125532-mutt-send-email-mst@kernel.org>
References: <20250506160024.2380244-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506160024.2380244-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 06, 2025 at 05:00:19PM +0100, Daniel P. Berrangé wrote:
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

series:
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Changed in v3:
> 
>  - Remove mistaken mention of 'ppc', only 'ppc64' has versioned
>    machine types
> 
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


