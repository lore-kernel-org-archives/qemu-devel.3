Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DCFC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 13:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDlGq-00080Y-LZ; Sun, 02 Jun 2024 09:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlGo-00080P-Sy
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlGk-0004tp-0J
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717334941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8CPP7gRc24kKXr10ON3e14nu6yR9PdCzO2isiJ09VQ=;
 b=gXvkAP2n4jk1WzgO4ISFP+rwFylld5sXFH+Jcs1FSITA3gvJWlb55MyHJ/vwEmhJd4VFpJ
 LPOjWdlvtDbAPq/p44fnE93Qqwr9+vU3RdPRYPSLkyPiBb5eNbBYMO7o3Ms10H4je39l1E
 tdsQ/kMPY3cJFS9IvzDBeNgXRy0tbyg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-M_B-XUYePjyJJVK78JGNpw-1; Sun, 02 Jun 2024 09:28:56 -0400
X-MC-Unique: M_B-XUYePjyJJVK78JGNpw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dc02b991eso1850983f8f.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 06:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717334936; x=1717939736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8CPP7gRc24kKXr10ON3e14nu6yR9PdCzO2isiJ09VQ=;
 b=KrMzxXVtua13B0T1+jG20JQdG8fu2v1xF3QfzVVHQBVkUh8bjA+5H1pE5XwmGWkK5W
 ROMWo91HbrtJRKcJ7mDzFIp/H4EIKAUNryawBDzxVJFu2WavhzTVg1pQTHFhV5CYo1rF
 TXqoAjlp4LmCGwjXu1T1XAiHAlb54eHVSs4TewPVVwNcAVuDOvz+5Ac9ZkQqSIDE3MRn
 pY+yFCM3HjNtBaRGCSPOZ2zmksUTU0zdW9bMiKu8mGmdRMSgiLEfqFKRaqo8E4d+YwGE
 NSsQf3PaanD2vncC/AwVRWktYeoAMQxG6bhqn28VKz//9l2Lx0V5/Kq++AAuqGlPvRJa
 1cqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq2aJI9YwNYJU2QulAOGja5y21HQKxDlRzohdDDTm16Nld9VOTWcKPUaA6Q1dYwhNEVtx5biWmRIBZfmkHEDSRv3YAp4U=
X-Gm-Message-State: AOJu0YzosTzW3UBnDhqOSsBRQinNQFe1xAN1XBLn2XNbDa/BRCuBoMFF
 5M9usMDHgh1cAPn6XjG75ex9+Gk0A51VwCMP5lfbI6F0ZMqQEk9dgOrhrcfIy8eoByxtUTJAZCK
 1A1ggmgDYfudZ4lwE7+5LgIwtc7i7uJhucWD0/QQEMizYFNJa5RDD
X-Received: by 2002:adf:ea89:0:b0:35d:bd46:960a with SMTP id
 ffacd0b85a97d-35e0f26e863mr4803653f8f.23.1717334935655; 
 Sun, 02 Jun 2024 06:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhy4/oIOufEKoEeE4X6HGFzV3xQAtiq8NIM5lwyJeDtJB+D2CuY3r9GjU8v3DI/IfzcMtFiQ==
X-Received: by 2002:adf:ea89:0:b0:35d:bd46:960a with SMTP id
 ffacd0b85a97d-35e0f26e863mr4803645f8f.23.1717334935082; 
 Sun, 02 Jun 2024 06:28:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04da756sm6200401f8f.59.2024.06.02.06.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 06:28:54 -0700 (PDT)
Date: Sun, 2 Jun 2024 09:28:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <20240602092841-mutt-send-email-mst@kernel.org>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Apr 12, 2024 at 04:53:58PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
> the supported CPUs for PC Q35 machine.
> 
> Update maximum CPU numbers for PC Q35 in the document.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  docs/system/target-i386-desc.rst.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
> index 5ebbcda9db4c..319e540573d3 100644
> --- a/docs/system/target-i386-desc.rst.inc
> +++ b/docs/system/target-i386-desc.rst.inc
> @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
>  -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
>     hub.
>  
> -SMP is supported with up to 255 CPUs.
> +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
>  
>  QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
>  VGA BIOS.
> -- 
> 2.34.1


