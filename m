Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFECC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmylY-0005ld-W0; Wed, 20 Mar 2024 12:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmylX-0005kz-3H
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmylV-0005XQ-3s
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710951968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q9mtthpbOAXg4sQmVeVli7IjhrEU+ZtiX0vSYDAWRFU=;
 b=ZQ0fdtIH6P9U1cD5ulLxvEYGDuIJTBnAr+eYoZVCj3dkx2gdhNbjPONG3fdXDMKFH5iSMT
 DKWyRaTewrwB6/PlRIvn/pf5WuVr6T6lLzb+toJGMa70T5hC7XTHiqbH4bdhh/36sInXBt
 nrNZvU4XplPWa+9YQ4utenZ7nD3Z7P0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-LI2ERFadMBWbEQmm9MahQg-1; Wed, 20 Mar 2024 12:26:06 -0400
X-MC-Unique: LI2ERFadMBWbEQmm9MahQg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a46f6c1104eso6319266b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951963; x=1711556763;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9mtthpbOAXg4sQmVeVli7IjhrEU+ZtiX0vSYDAWRFU=;
 b=EXOnzBcFdP/ldZ5Fzpfx1KmrjgeE0OAxBRIgAyRCt413qHXIeMzJUubLtONiy+zM23
 C/OHbIEx5+dNaN4rCNK4tXQuhbscGFMfw3xywAjySCLe2/n3uMXCIDWhjlt/2cMjS7fs
 XF/vnllIxq2feD/RfUt1HXbCImxeOGSob/xlrfycjZWhs6LPIw31owMNoD6bKKjitKeS
 nZqE2SIRy7ayoF/L2BuqyyWWffXmwAE6CbEFyZ8otz7ao8T5xYHACwVa+K8cJ810UPj6
 zSf+dQmHPHkP8fD+CTtp92sC4EeVupA7uXxqrizTQ/A95GCZ4a5RCowdW0pOIzolu/K/
 TMbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlQpHBfKM+h7tL+qrayTVsp+WpHjNcQa+JF2AqQUbCn8toYB2ILCEtk2N8a3TzxE2ReSObvxPuvdVoGrgun++nm+EEATo=
X-Gm-Message-State: AOJu0YyxbAHara8uI1IZwQvI4D7kFaY2/FH3IhY4fg/1LYMOEsLP2FIA
 mbvDQzx4XKVNOQvqoID1lbQhBQEox32j6ON1TvQAF+NZwNjVcCn2XwXaITh/585M0nJIpZJ0aAA
 ESXiGvd1DiwWcSOud8nNansGuz8RBiLEN42NtD8SRxD5jhdHYuTunM6QcMqyh
X-Received: by 2002:a17:906:5387:b0:a46:9f12:ca2a with SMTP id
 g7-20020a170906538700b00a469f12ca2amr131910ejo.22.1710951963000; 
 Wed, 20 Mar 2024 09:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECLA18nqUOxI+h+v1n/cHVmjwkTvIzsjJjO+lGm4cMUYzEvTsYkEVQt6PI24bSP3DzE+CZ8Q==
X-Received: by 2002:a17:906:5387:b0:a46:9f12:ca2a with SMTP id
 g7-20020a170906538700b00a469f12ca2amr131895ejo.22.1710951962682; 
 Wed, 20 Mar 2024 09:26:02 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 bx21-20020a170906a1d500b00a4655976025sm7391435ejb.82.2024.03.20.09.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 09:26:01 -0700 (PDT)
Message-ID: <d6acfbef-96a1-42bc-8866-c12a4de8c57c@redhat.com>
Date: Wed, 20 Mar 2024 17:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/49] kvm: Make kvm_convert_memory() obey
 ram_block_discard_is_enabled()
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-20-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-20-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/20/24 09:39, Michael Roth wrote:
> Some subsystems like VFIO might disable ram block discard for
> uncoordinated cases. Since kvm_convert_memory()/guest_memfd don't
> implement a RamDiscardManager handler to convey discard operations to
> various listeners like VFIO. > Because of this, sequences like the
> following can result due to stale IOMMU mappings:

Alternatively, should guest-memfd memory regions call 
ram_block_discard_require(true)?  This will prevent VFIO from operating, 
but it will avoid consuming twice the memory.

If desirable, guest-memfd support can be changed to implement an 
extension of RamDiscardManager that notifies about private/shared memory 
changes, and then guest-memfd would be able to support coordinated 
discard.  But I wonder if that's doable at all - how common are 
shared<->private flips, and is it feasible to change the IOMMU page 
tables every time?

If the real solution is SEV-TIO (which means essentially guest_memfd 
support for VFIO), calling ram_block_discard_require(true) may be the 
simplest stopgap solution.

Paolo

>    - convert page shared->private
>    - discard shared page
>    - convert page private->shared
>    - new page is allocated
>    - issue DMA operations against that shared page
> 
> Address this by taking ram_block_discard_is_enabled() into account when
> deciding whether or not to discard pages.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   accel/kvm/kvm-all.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 53ce4f091e..6ae03c880f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2962,10 +2962,14 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>                   */
>                   return 0;
>               } else {
> -                ret = ram_block_discard_range(rb, offset, size);
> +                ret = ram_block_discard_is_disabled()
> +                      ? ram_block_discard_range(rb, offset, size)
> +                      : 0;
>               }
>           } else {
> -            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
> +            ret = ram_block_discard_is_disabled()
> +                  ? ram_block_discard_guest_memfd_range(rb, offset, size)
> +                  : 0;
>           }
>       } else {
>           error_report("Convert non guest_memfd backed memory region "


