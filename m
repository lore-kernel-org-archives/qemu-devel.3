Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D7606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AyzqICuF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jOYFi8D/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMxl-0001G0-8z; Thu, 29 Oct 2026 06:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMxj-0001F1-F6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMxh-00016C-RD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793268140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LusTqivVmv3DC+2Iikcd03JVuR97wAClJJsfvNbxUuY=;
 b=AyzqICuFjkL/HwYvB5o1mxhPZZVEMCxtW2pk0tk6O2EhpP9FkpljOLE5JVAOr5vSrs/e81
 rJX8hrutxwM51eUuP/cZTgQLjX1yq1oAeJ0P9mWT2BPewLrMg6VaG4uDI76mrNE1ujgiuw
 1QCVAkP+Z6ULTKIOEN8UJ4JmX0rltPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Jd39renjN8OSiKW_E0hJKQ-1; Thu, 29 Oct 2026 06:02:19 -0400
X-MC-Unique: Jd39renjN8OSiKW_E0hJKQ-1
X-Mimecast-MFC-AGG-ID: Jd39renjN8OSiKW_E0hJKQ_1793268138
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a210f93860so13872805e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793268138; x=1793872938; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LusTqivVmv3DC+2Iikcd03JVuR97wAClJJsfvNbxUuY=;
 b=jOYFi8D/LN78sIjROwP66mvpa2ZWytMCy5R8QCiEgK86t1Efrea778lKy4Uk6eITJa
 X1W1/i0PjQR4QM2aqWBJzTBPIa0hPLwDTHNBwFD7MFVV+xSDHjee3hLSZ1Gaf0yVgHQs
 Txo9826TRz5r4+a4DntX6SN/o68gg1jbO0WDb6eKDtejPPYz2ieaoTkMVhKuthhMX2hg
 uTpX+YP99cMAS6ePIs+UNi2JpIM1pCgtMfcCBQA31UL/tOPaLppA7mAIZ3gZIAGWO3ps
 ayPcGL7PLybmlBLIZk4/FH6DfsWHUy6o2lgMtxNcil0Xdxt3z6WmTjm5z52CUn1qjRGr
 fM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793268138; x=1793872938;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LusTqivVmv3DC+2Iikcd03JVuR97wAClJJsfvNbxUuY=;
 b=GogbjL1aQRuiYdoD7MRC6OwpdPfaWa3esbyyxicziqHOsk0S1SHTMlTLmrt40mtB/9
 TNyqzh2Lnu71X9Vx2VidZPyo8tRCK2fm9++TJ3qJfAA5vlC7W1HgWNb3Q1z2CxOP/hQW
 seInj9G/IvC8P13qWI6mmnRQ/wF9zfgYE7yu6q625/0tX33+q+Jn+uo1aw4OPWFlUDXt
 3BVaS7ePc0uz4ijwpK/0SPveQ1syf5Or4F7QrElABna6CwrWOeX6l6zsWyw+6Zko5sAt
 im/4qXznZjKCQBcHDzwGC49wznG/6iXrsDzpvHNZBOxb0Op2L0KiljI3/p4fSzw79P2O
 H+zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZU5HP/2AK1zvbzmF/ptiiXdVSQ+JMBfzZ2HsgDiHFvguOPWarIa3TuXFftE3/0uDrJbjEE+ocRG3o@nongnu.org
X-Gm-Message-State: AFq9FYK6bOO4uqRiTiGWoqPSVsGNcnlCz0VyCdk0AYNVfeKyR51C5Z4x
 GzVKdXhHfcWKInSQ663r+L6zrWeGXxL6YVCmyV2b6tnWQsxHm7kALrkqt9j5vL6ilTuddj8thKP
 4W3Bb9eaJWaLiIqvysLgKscwL8hLp7nUAg5KLSlKtfSYywqie8wmuxcE3
X-Gm-Gg: AYBFou1lvKrZRfBHAtWRJ+CNOX08mFz9Njhs6ykRuptCXD4naJZOOcsit6r0KizFEaa
 XLppkuXTGp3CvNIIu7E4QlE6PBUaAfubhJCnxMQpOelfwq5hzrujf4VCHtw3nqmdqNHjY3pWyah
 xSVBHjGsp21LPjmOYhGXp4vBwum6nCSGW5I3j1cfxLQYOssBgINfrMGdIT5z7tOiGRogkArjpO8
 XSKZQ8QBE7qd54zHy7um2lB+lh27kmiGttDvzgp/koqzAlNa9WUoSQxx3EPs6opdiEaeEjs6HCR
 aDs+MEfoD+EVhbVMLzmhBrGFY2dg0leP6MuhqhbvyMh2yeLkfERfhFrNvjl5RtoixRVY/NcEAAM
 CMfXEplrKnKWIECCxQlpY7R1v+06vskN2ww==
X-Received: by 2002:a05:600c:154a:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a9660b5e35mr114802185e9.9.1793268138233; 
 Thu, 29 Oct 2026 03:02:18 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a9660b5e35mr114801775e9.9.1793268137791; 
 Thu, 29 Oct 2026 03:02:17 -0700 (PDT)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a930a63eb3sm97312015e9.1.2026.10.29.03.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:02:17 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:02:13 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn,
 harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, 
 farman@linux.ibm.com, cohuck@redhat.com, armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 9/9] hw/arm/virt: Make sure virt_get_caches()
 keeps on reading CLIDR_EL1 as 0
Message-ID: <enby3ukdkcjjtfoohmawuxu5ytnfguz2cwhtk3c2rea7vp5fdu@xalveqexeoey>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-10-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029092307.281287-10-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

On Thu, Oct 29, 2026 at 10:20:21AM +0100, Eric Auger wrote:
> In KVM mode, virt_get_caches() currently gets a zero value for the
> CLIDR_EL1 register. This is due to the fact CLIDR is never read from
> host. This is a bug.

yeah, as the reviewer of f669de70011 I agree :)


> Soon we will initialize all writable isar.idreg[] from host and this
> includes CLIDR_EL1. However we cannot directly fix the initialization,
                             ^--- comman missing


> first because it would change the way the guest is exposed caches in
                                 "the way the guest's caches are exposed"


> DT/ACPI descriptions and because some host values would be rejected
> by the current QEMU code, expecially in the case host has a unified
                             ^--- "especially"


> L1 cache which is currently not supported and triggers the following
> errod: "Unified type is not implemented at level 1" error.
     ^--- "error" ? 

   
> 
> So this issue will be fixed separately.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
> 
> ---
> 
> v9 -> v10
> - add a comment explaining why we oveeride the clidr value
> ---
>  hw/arm/virt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0d56197dac..ed329e76e6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -338,6 +338,17 @@ unsigned int virt_get_caches(const VirtMachineState *vms, CPUCoreCaches *caches)
>      ARMISARegisters *isar = &armcpu->isar;
>      uint32_t clidr = GET_IDREG(isar, CLIDR);
>  
> +    /*
> +     * Commit f669de70011 ("hw/arm/virt: add cache hierarchy to device tree")
> +     * read the CLIDR value from the isar array but in KVM mode, this index
> +     * was never initialized from host. Now we want to initialize all ID

I think we should mention the bug here as well and also enhance a bit the text:

"... but in KVM mode, however, due to a bug CLIDR is never initialized correctly
from the host and we read 0. Now we want to fix the bug and initialize all ID
registers, including the CLIDR register, but until this gets fixed ..."

> +     * registers * from host and until this gets fixed, we need to override
                    ^---- stray *


> +     * clidr to 0 to keep the compatibility.
> +     */
> +    if (kvm_enabled()) {
> +        clidr = 0;
> +    }
> +
>      for (int cache_level = 1; cache_level <= CLIDR_CTYPE_MAX_CACHE_LEVEL;
>           cache_level++) {
>          uint8_t ctype =
> -- 
> 2.53.0
> 
> 

Otherwise,

Reviewed-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo


