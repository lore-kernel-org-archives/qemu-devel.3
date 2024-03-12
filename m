Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C74C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7wo-0005iE-9U; Tue, 12 Mar 2024 15:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk7wl-0005ht-Tq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk7wk-00036Y-H0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710272277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/LI896eMrRg3iqQyNkSdpOfgLqaYttmrLm+nX+WuSE=;
 b=WNKygV0bT/8SydZg5ATkGo5miYKgha4yv0zih8ow2ffIGLCfYDPZJb+ps4FBXEdbRNTagT
 4jXw3E8HgPfB9MZKZYzD4bwQkLu8LaM7uu3LQkTLRQH9F/nA2rzSwDkixhfAQPbXRLg4E6
 B8upHg0/CXYQg2pf3bdv3JuiYPx4iKk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-7kcYw5mIOPmXksLFBDt8cw-1; Tue, 12 Mar 2024 15:37:55 -0400
X-MC-Unique: 7kcYw5mIOPmXksLFBDt8cw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e53200380so34517995e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710272274; x=1710877074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/LI896eMrRg3iqQyNkSdpOfgLqaYttmrLm+nX+WuSE=;
 b=DoyPrNIPMUqKcL0oAov/B48SMYLGcLQVRT+gXWftH//V0zI5JUcFW26yLdTMxWFw/d
 /DCljPhlhqg37wSuh7QkoiUHODWLaPY1XabuB4ZyX2JuxnGB6YK+ElgJtogqb0MgcDhy
 CFMEP6/h8kRBN9aZ4HfvPhB5gsAIjob8UXkcac3gTIwW+YeA5Mpsy4RKv4zwrpIY7SJi
 Ab4DTzAZOl5VBujaV5w797SB4nlL+LfxC4cFgMdn3z2EPoiDbETxvO16x2lKnJ3RNwG+
 dqt8fZqPNjqUa3kXtyzSKExrqIoFl/kfhF8YgpO4BG9k7N2BPheWBjlaP8rljEQ11pyt
 jntw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdVdJCvx2BrScHOdfatiLFLT8wbCedY0mwKpndN+QKFvc4Bfisv1sSfvG9TB2Opq0V70sZujcgu6hrjlrid4ocGUxKNzw=
X-Gm-Message-State: AOJu0YxlrvrImZO+K+zTEmR3MUzBdfL046rAtTlPPevNW3LrUiuPqlB/
 ubqlugZa3THlPjgMUVlYS/uDV18ZoAaxaScWHZAO7mjFOSX9pEMEvKVSFeXso7Y+d3CTcxeF3Pt
 nkVCOisOv9TdO/XZXZUsUScIiKZg8P+VF27dzbWhsjOel2I3yuB5c
X-Received: by 2002:a05:600c:4fc2:b0:413:2f9c:99de with SMTP id
 o2-20020a05600c4fc200b004132f9c99demr3079346wmq.8.1710272273842; 
 Tue, 12 Mar 2024 12:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1DLpMuTzI5rRNrInJ3fgPQkjQ5ycV4CD41UGMDjfaUeXVZPTyp3wfLA/L0VykFZdaK8NtLg==
X-Received: by 2002:a05:600c:4fc2:b0:413:2f9c:99de with SMTP id
 o2-20020a05600c4fc200b004132f9c99demr3079326wmq.8.1710272273337; 
 Tue, 12 Mar 2024 12:37:53 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b0041312c4865asm18105896wmq.2.2024.03.12.12.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 12:37:52 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:37:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v6 07/15] pcie_sriov: Do not manually unrealize
Message-ID: <20240312153651-mutt-send-email-mst@kernel.org>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-7-2e42a28b0cf2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-reuse-v6-7-2e42a28b0cf2@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 20, 2024 at 09:24:42PM +0900, Akihiko Odaki wrote:
> A device gets automatically unrealized when being unparented.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/pci/pcie_sriov.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index e9b23221d713..8b1fd2a89ad7 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -17,7 +17,6 @@
>  #include "hw/qdev-properties.h"
>  #include "qemu/error-report.h"
>  #include "qemu/range.h"
> -#include "qapi/error.h"
>  #include "trace.h"
>  
>  static PCIDevice *register_vf(PCIDevice *pf, int devfn,

error.h is used elsewhere in this file too, removing the
include is not a good idea, doing so breaks bisect.

> @@ -204,11 +203,7 @@ static void unregister_vfs(PCIDevice *dev)
>      trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                 PCI_FUNC(dev->devfn), num_vfs);
>      for (i = 0; i < num_vfs; i++) {
> -        Error *err = NULL;
>          PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> -        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
> -            error_reportf_err(err, "Failed to unplug: ");
> -        }
>          object_unparent(OBJECT(vf));
>          object_unref(OBJECT(vf));
>      }
> 
> -- 
> 2.43.1


