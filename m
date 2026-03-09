Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD47F41810
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdZm-00078P-EP; Mon, 09 Mar 2026 12:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzdZl-00078A-Om
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzdZj-0007Ju-Cv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773074122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U07d+lohWT730+kIOsQzG6405cB1f9HTmdKo/WXEVFI=;
 b=KULjqsds7kAKgalWQIJzr8ckatmBNDqtfvTSUapuxESPfPtwIB90OJdpcIroH81gRE+Dld
 0npl5fpOVT9jus6nO8l43LEra5/0/TjPp2ah52DDSct9VV5rvE4bdQDZqWyf2XmWRJMtfq
 Dzb4odle8ONjOvtXVFTFXoibixVCZi0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Gg4f-yRXNGeTcoNYwzJSrg-1; Mon, 09 Mar 2026 12:35:20 -0400
X-MC-Unique: Gg4f-yRXNGeTcoNYwzJSrg-1
X-Mimecast-MFC-AGG-ID: Gg4f-yRXNGeTcoNYwzJSrg_1773074120
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899f671ceb2so586682766d6.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773074120; x=1773678920; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U07d+lohWT730+kIOsQzG6405cB1f9HTmdKo/WXEVFI=;
 b=BVQhhPKsWjMG0Bder4wR9rRuud0wJhaLYJZCI9e+pCTBiHI8YJPqRxcgrAULgjFEU9
 WuqekBtD8rL9P4z6uNMaIASlQ6Kpga3OlmVKagHO/FBdBW3MHo6MVvoYfuKm1wpRXScO
 jXBPZjPevRlIpbc2tmGobHZTOOHpvnjZD2rj+bGtDkaZXQq1Y6eUpOsyNXQMRcROSd2c
 jhGro2XATWhbZddXkjpXAEvNX3TOotBCGSj5svJLdsrb99A75IBNU4tC/UvcrV/JTmCU
 0XmGKliSaJapZwmkVts6LJ+LKbyc4h6ZSzt+F1y2gtCE143C2jBARvEu2EFbnwizX8Ae
 2QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773074120; x=1773678920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U07d+lohWT730+kIOsQzG6405cB1f9HTmdKo/WXEVFI=;
 b=b+uMiGFSlewBLYC7q95iS+Tr62+fCeBuiRwKRz2kyPX2U8vdiB8s9JX+2ntlN8GmJB
 Gh4ejePTU7Ylu4Qib42S6t3S1gOXpsQjPcjNAUkaSxk+JhiHDefF5F7WEu0P6PC/qgr+
 po1Eu7zN5Jsjx9sHJ5CQ1Ym0JYY/D8hhoEYYNq6CyfGfuEibgzHkmCe3erumoM+DhtnC
 Zm1lSgmr/5j/m/TnfqPJy7TI4UyU37iBbvhOyleKtyp+ESTlnZ/Vlya0rUYR8cGcYRwD
 3Gf4U+iERQw73oDNxvhwVaaHroB1KJ7S9T0sjMsXzwt1oKU5kiiXKhGnFmi1lr6O8W4T
 9hiw==
X-Gm-Message-State: AOJu0Yy9g08f9fAeD1P+9Bp8FD3JZdhdaqyaBMIoAdWT/6xKMrhNGPnZ
 G+6uMs7ffEiaUd3mMSZTdSP94RyF0eX2BytEQ8+Tf5biwSReadKgsf5bNO1de9AxsxLug7v7Ks+
 kqLSGALl2tz234OxkXT/bpb28nvvjQdaM2S9WlsV577sIijyQojdSgnKX
X-Gm-Gg: ATEYQzwc1iL0X3H2Kj4CuNze8nGaVLRdDEMEbyY1ak4LBuBxaAKCFeJGryhanMvf6kB
 i3htVZH5TF5203YlEr0QbwXOqIMKBajBrM2ZNw/do3JZA2kCKiQvWV1AjvzgD0zDCkN9wluZOLo
 152UH3RSw/AiBudBc2hGxKvapI1jVQHhMaDD9y0VS70E/lk/hEhscw4veJgYbkna2HTGvE3TVGZ
 WMuMFa9M5M4x/nvhIT7r6MEZqpuarVGUV3Wy8WqOqsUK3jtfoIJEIIHGjtDoTCW+rLx1i0gFyZJ
 i1Ra+POzbCPfZ2PT+2PU4Wdox90esj6pmUW3PX1I1LwsEprFRVNt6f+Kxya0g6mWePo/+zQskkN
 HJ9TIUV1yyAl+evnY0XNLoekd02Gnu/V/iscxCbFE0xa4M+LmrgVf3Y4kJPmySfWw5AO2sLL9RF
 NRtaV9NQ==
X-Received: by 2002:a05:6214:194d:b0:899:f092:9da with SMTP id
 6a1803df08f44-89a30a77e50mr190561636d6.28.1773074119985; 
 Mon, 09 Mar 2026 09:35:19 -0700 (PDT)
X-Received: by 2002:a05:6214:194d:b0:899:f092:9da with SMTP id
 6a1803df08f44-89a30a77e50mr190560926d6.28.1773074119345; 
 Mon, 09 Mar 2026 09:35:19 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57c13b71sm1201416d6.36.2026.03.09.09.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:35:18 -0700 (PDT)
Date: Mon, 9 Mar 2026 12:35:16 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v10 0/9] memory: Remove most _nomigrate variants
Message-ID: <aa72xAyfXk4rrM6d@x1.local>
References: <cover.1772924151.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1772924151.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 08, 2026 at 12:05:58AM +0100, BALATON Zoltan wrote:
> BALATON Zoltan (9):
>   hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
>   memory: Remove memory_region_init_rom_nomigrate()
>   sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>   hw/xtensa/xtfpga:  Do not use memory_region_init_ram_nomigrate()
>   memory: Remove memory_region_init_ram_nomigrate()
>   memory: Shorten memory_region_init_ram_device_ptr and
>     memory_region_init_rom_device
>   memory: Add internal memory_region_register_ram function
>   memory: Factor out common ram region initialization
>   memory: Factor out common ram ptr initialization

I queued the rest too for 11.0, thanks.

-- 
Peter Xu


