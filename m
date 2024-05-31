Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D04C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1SV-00040I-5g; Fri, 31 May 2024 08:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD1ST-000402-Oy
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD1SH-0000oQ-UR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717158836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0Up6NdBkRgjmDLWyJob6XY0DIAMH1Tn7MWcPIWCuTY=;
 b=Fde/X/1EhMKWShQytWL3ngJtUsCsZGSmita+Roovkd/LDuPstZMhZzU6RpzRqZ96/nR7D1
 zqaov11bWFc8tt5BAsM7BlSv6nCCWkiwesZ5dR2AF93eCYY/NI+m8VJpbKJBlELxCPlOPY
 uy+58mHd+zWEjnB36Tvvp1XJB6o8+oQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-tFyu_iQnPlOJhosbmNcXiA-1; Fri, 31 May 2024 08:33:55 -0400
X-MC-Unique: tFyu_iQnPlOJhosbmNcXiA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dcde1be6cso844227f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717158833; x=1717763633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0Up6NdBkRgjmDLWyJob6XY0DIAMH1Tn7MWcPIWCuTY=;
 b=Z0vssS62hVurVMW+cl9Jz4oEOykJi91WZaZ1r68ooYYKqw8OQD7LsAuRe58x5yWSg0
 pWI6FVWbS75+gX4yhinuTTOe4gfqO9CAjucSMd/fNH004oEiuetUBdZAoHEBaG8Gx9yr
 skTRj1f5/ljHME4QZXU3P0bNw8SvdcwFMmArq+1Kx/GZByaRc5nd0rPHtYevsdUyVxte
 XSb447goBP69tBuhu0kZk2tVxyc+4quxLRA+N+5qUxbURLPhV5fnL4vmIkzadNY1NvYb
 CP+rC0NDTjaf8hzJz99wN6Te7zdlNievJxVVupKBGcufqe1UbszJObIrleNOjHqlD7NR
 6kIg==
X-Gm-Message-State: AOJu0Yy/SnyWKxqaWeInm43rEV2/3jEVDGoYTSJBulsljAn5hPookJhk
 ecDeP8HXYAQKreQNplkUJyznEPq21x6kizkeIOx/QdpXgco7+gvdo7Ih10aPx9ZMZ6y5zbpXGGy
 ZfSHM7ZD3YN+eOgvv3XOFtojg7SMxD2uQx00vEQODJhZSLtBkeGnSPcexQNpJ7T6LBDI7E1HnUW
 9YJNoU5Wd3aKz7Uyg+qRNuNLCjfTeTfKfMKodK6w==
X-Received: by 2002:adf:cd8b:0:b0:355:161:b7e6 with SMTP id
 ffacd0b85a97d-35e0f2879abmr1254339f8f.41.1717158833071; 
 Fri, 31 May 2024 05:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAbWZ++3Kxz8loXJ5rJzTrFeHLsmVYmj/RgQdDDla4kiYPvCN4bCqa/jqdkI7z3R7Gfzt/kunUuX4KP22LeBw=
X-Received: by 2002:adf:cd8b:0:b0:355:161:b7e6 with SMTP id
 ffacd0b85a97d-35e0f2879abmr1254316f8f.41.1717158832634; Fri, 31 May 2024
 05:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-30-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-30-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 14:33:39 +0200
Message-ID: <CABgObfbMBdm5_vr36aX9cYYRaaLWp6+Y1AKo9YtUbVbKX897sQ@mail.gmail.com>
Subject: Re: [PATCH v4 29/31] hw/i386/sev: Allow use of pflash in conjunction
 with -bios
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index def77a4429fb24e62748
> +static void pc_system_flash_map(PCMachineState *pcms,
> +                                MemoryRegion *rom_memory)
> +{
> +    pc_system_flash_map_partial(pcms, rom_memory, 0, false);
> +}
> +
>  void pc_system_firmware_init(PCMachineState *pcms,
>                               MemoryRegion *rom_memory)
>  {
> @@ -238,9 +248,12 @@ void pc_system_firmware_init(PCMachineState *pcms,
>          }
>      }
>
> -    if (!pflash_blk[0]) {
> +    if (!pflash_blk[0] || sev_snp_enabled()) {
>          /* Machine property pflash0 not set, use ROM mode */
>          x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, fal=
se);
> +        if (sev_snp_enabled()) {
> +            pc_system_flash_map_partial(pcms, rom_memory, 3653632, true)=
;
> +        }

This number is a bit too specific. :)

The main issue here is that we want to have both a ROM and a
non-executable pflash device.

I think in this case (which should be gated by
machine_require_guest_memfd(MACHINE(pcms)), just like in earlier
patches), we need to:

1) give an error if pflash_blk[1] is specified, i.e. support only one
flash device

2) possibly, give a warning if -bios is _not_ specified.

3) map pflash_blk[0] below the BIOS ROM and expect it to be just the variab=
les

The need to use -bios for code and pflash0 (if desired) for variables
also needs to be documented of course.

Some parts of this patch can be salvaged, others are not needed
anymore... I'll let you figure it out. :)

Paolo


