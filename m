Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0438C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMII-0001eP-4q; Mon, 15 Jul 2024 10:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMIG-0001dB-KT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMI8-0004ro-SZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721052179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FMmdE8Bd/K5RIwz6RZQegZfACkPEXnzNSX+e3/Y4xM=;
 b=dEC5z3CCnxm1ha8EKn9ULZJWCgrrbPJkix6gIiEBAH6/cc0ox3PtZ2h4s0l9T+rzMKv/KU
 4Lhm2jn0bnklI0MyGtTECU54WZcvAvypsZ/zwyjnXzqsTFpyD6cfnrWqqaV5YKFMhaumC5
 2/nSd7DF0eh9qpMaGEyPFW85QnPYAak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-3xsao2ivPnqoM_O2Yu8eMg-1; Mon, 15 Jul 2024 10:02:57 -0400
X-MC-Unique: 3xsao2ivPnqoM_O2Yu8eMg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36785e6c1e6so1946450f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 07:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721052176; x=1721656976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FMmdE8Bd/K5RIwz6RZQegZfACkPEXnzNSX+e3/Y4xM=;
 b=TI8a/RqKUG0Qvl97Ud/HxBqEF4xptBI/phmCh039oEW5CClMVF4K5ZaM9SOEPUfTVz
 DxeBptb1De9Tupt4Zbmdq5vz56MrbTIBkOVdDu5EBKJEHjmAdouem8Ad3RaF+hLv12oj
 UzhwTCiLcL3vfGZMvLiDXio7cS1Au4lCBsloGbqvonqP1y6NazRC4vLia3qe68JVXu1U
 cfP+8OCKWzv34XCofMImGpuQxVwbgX3/R73bWMZqdBQRjhpqQXnrIdkDnbPt1Y6fS+E/
 V751eroShbQmYp7dC8ug14FcoaKvAX2Ayy8Xh0yNoqQk1bmCuCvgpck62gY2OmeTZhx0
 xRgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYnnR9/gKAzBVEMqqJipoDGvVecPBCH480It/uiiZgES173ScwAgVrC2NiCskuD8HczRE/f1h7cZYsbf/l/FGO04Qg6Cc=
X-Gm-Message-State: AOJu0YyhwT/80o4zDCgf+o3aWUNBUwXyRcmi1+YKMqs54ShNI5KFiAY3
 EIKOdT3FlhVSy7mGpge/NgDwMcZRdUbB+JoUzOX5pkN29DSJCih0aYSdmDK3BZLHSmhe02BCDcK
 3LZGxl2aqXOfkAOmqrP6Sr8iC9LGVmRPS2eHR1LFpgaipQ+ourKTI
X-Received: by 2002:a5d:680a:0:b0:367:89de:7c7c with SMTP id
 ffacd0b85a97d-367cea738f1mr12217387f8f.28.1721052176133; 
 Mon, 15 Jul 2024 07:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG22g5e9464d1DEgz652yOdwK4xP/f91QdksHZdZkKbc6h6ULr8e/GLULKiZfi4jd+bccOrzA==
X-Received: by 2002:a5d:680a:0:b0:367:89de:7c7c with SMTP id
 ffacd0b85a97d-367cea738f1mr12217376f8f.28.1721052175779; 
 Mon, 15 Jul 2024 07:02:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36816758620sm4076915f8f.19.2024.07.15.07.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:02:55 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:02:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 5/7] backends/hostmem-epc: Get rid of qemu_open_old()
Message-ID: <20240715160254.558e0415@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240715082155.28771-6-zhao1.liu@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-6-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 15 Jul 2024 16:21:53 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> For qemu_open_old(), osdep.h said:
> 
> > Don't introduce new usage of this function, prefer the following
> > qemu_open/qemu_create that take an "Error **errp".  
> 
> So replace qemu_open_old() with qemu_open().
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  backends/hostmem-epc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
> index f58fcf00a10b..6c024d6217d2 100644
> --- a/backends/hostmem-epc.c
> +++ b/backends/hostmem-epc.c
> @@ -29,10 +29,8 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>          return false;
>      }
>  
> -    fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
> +    fd = qemu_open("/dev/sgx_vepc", O_RDWR, errp);
>      if (fd < 0) {
> -        error_setg_errno(errp, errno,
> -                         "failed to open /dev/sgx_vepc to alloc SGX EPC");
>          return false;
>      }
>  


