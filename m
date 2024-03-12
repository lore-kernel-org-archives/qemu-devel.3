Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B030FC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5AP-0000ri-2s; Tue, 12 Mar 2024 12:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5AL-0000rL-ML
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5AJ-00040s-Rw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710261586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f9o1aoAye7xNdYGS4m4GW0oiIbcIKcoYn2ii6iokudw=;
 b=IFTzlqVuZZIkIVpNd+5GkcBLGbfXxDKwOX/CyINglkNpVgg1dMT2nXU8RXUh9l6tUitf7y
 0dkph0/aUKPH76eFLJu3aQ19EMj2qVrjKFJvkxfsml2Sz338kKcMm8aJ0l7L7qScJ2S5g1
 FbDDFsT8xLVomeNNOYS/XPCK7+TqyHg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101--Iqc8rH2PIKVq83Din6zAw-1; Tue, 12 Mar 2024 12:39:45 -0400
X-MC-Unique: -Iqc8rH2PIKVq83Din6zAw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e8adeffe6so1620883f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710261583; x=1710866383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9o1aoAye7xNdYGS4m4GW0oiIbcIKcoYn2ii6iokudw=;
 b=WG6R1hdOahUjaC6qRKZSY5gFaNMUOP88Z6J/Vuprn8hDNGCJUDr6G7l28GYiuFRJBm
 FKwWc9U3BaGSZ7Jjy4e0eR//iBRgse/zmMWjJQihoH1ey44t12VPIxA0PhuX3vFU+9uj
 /NjgBHXmo1nfREtGQX/OPNNNVBwUe2oQucEhOzrbC+nO2AytxHKfWiLmMGkZhQ08Oqen
 pSd5JjRJ9ZhwKNt9o+KGlMF2q0xV3vuF+hUvh9Fs8X6RPB+9kCLnR4nPjlYa2GUzb31m
 GBBDcmIkw6iGZnT7aE+3Tc1b9xv4PGwj46RtSWECLIs+H1OtrU7F5FO5WQ1yOqBVXzzQ
 59qA==
X-Gm-Message-State: AOJu0Yw/Xr1hcrQYjxQQacIcMMG858e75U/GbuGLiwSw49BShhIE9xza
 b/dS/X95H2wwWonns5xD3u4qbKDKQUt+oAln0ZOksxtEANybsA+LIZn5hBfSEMECFyKid/9MJYx
 5e5aRTKVxT67XxZWeIRb+Yl4P13VPK+orV35XZW18fKG7ZSupGzma
X-Received: by 2002:adf:9793:0:b0:33e:8d9c:fd6c with SMTP id
 s19-20020adf9793000000b0033e8d9cfd6cmr1686077wrb.20.1710261583312; 
 Tue, 12 Mar 2024 09:39:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXQNMWbsB+n3on6uJIQvQTRNm3qEuirlCoCawOIkaZBqbXExhIOTTPOX06iL+pzLq+ay13fw==
X-Received: by 2002:adf:9793:0:b0:33e:8d9c:fd6c with SMTP id
 s19-20020adf9793000000b0033e8d9cfd6cmr1686061wrb.20.1710261582742; 
 Tue, 12 Mar 2024 09:39:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 bt11-20020a056000080b00b0033e9186f043sm6845320wrb.41.2024.03.12.09.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:39:42 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:39:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
Message-ID: <20240312121944-mutt-send-email-mst@kernel.org>
References: <cover.1708525606.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708525606.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 21, 2024 at 10:28:50PM +0800, Hyman Huang wrote:
> v4:
> - Rebase on master
> - Fix the syntax mistake within the commit message of [PATCH v3 1/3]
> - Adjust the linking file in hw/virtio/meson.build suggested by Markus
> 
> Please review,
> Yong

I'm still not excited about this.
For one this will not scale when we add more than 64 feature bits.

As long as we are changing this let's address this please.
I would also suggest just keeping the name in there, so
a decoded feature will be
[0, NAME]
and a non-decoded will be just
[23]

will make for a smaller change.


> v3:
> - Rebase on master
> - Use the refined commit message furnished by Markus for [PATCH v2 1/2]
> - Drop the [PATCH v2 2/2]
> - Add [PATCH v3 2/3] to declare the decoding functions to static
> - Add [PATCH v3 3/3] to Define VhostDeviceProtocols and
>   VirtioDeviceFeatures as plain C types
> 
> v2:
> - Changing the hmp_virtio_dump_xxx function signatures to implement
>   the bitmap decoding, suggested by Philippe.
> 
> This patchset is derived from the series:
> https://lore.kernel.org/qemu-devel/cover.1699793550.git.yong.huang@smartx.com/
> Please go to the link to see more background information.
> 
> The following points are what we have done in the patchset:
> 1. Take the policy of adding human-readable output just in HMP.
> 2. For the HMP output, display the human-readable information and
>    drop the unknown bits in practice.
> 3. For the QMP output, remove the descriptive strings and only
>    display bits encoded as numbers.
> 
> Hyman Huang (3):
>   qmp: Switch x-query-virtio-status back to numeric encoding
>   virtio: Declare the decoding functions to static
>   qapi: Define VhostDeviceProtocols and VirtioDeviceFeatures as plain C
>     types
> 
>  hw/virtio/meson.build       |   4 +-
>  hw/virtio/virtio-hmp-cmds.c | 702 +++++++++++++++++++++++++++++++++++-
>  hw/virtio/virtio-qmp.c      | 684 +----------------------------------
>  hw/virtio/virtio-qmp.h      |   3 -
>  qapi/virtio.json            | 231 +-----------
>  5 files changed, 724 insertions(+), 900 deletions(-)
> 
> -- 
> 2.39.3


