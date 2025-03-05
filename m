Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB06C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 10:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmJB-0007xc-LE; Wed, 05 Mar 2025 05:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpmJ9-0007wn-Uk
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 05:48:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpmJ8-0008Hc-8A
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 05:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741171737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zi8TYJXIRo742efp9c9ooVWub5kQoW1rshzUifHHiLE=;
 b=D3eB9MXPvrTbjoyepBZ5U2Fb6bZ1U1TyyJzx8bc5sxaF3TJ77zYLfDhLyV63CEN/L5B68F
 D7GumS9X4L8TXoyW0Y1Vv/oG2BnJD4jzO+pd8dzelJRZ2uY31iXMEiX85AHvKzDWSIXjgW
 iNj7uwH+vZzn6jG1cVLpvKTpjA7KpsA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-KDwlNwZlOG6FoijfrtnVLg-1; Wed, 05 Mar 2025 05:48:40 -0500
X-MC-Unique: KDwlNwZlOG6FoijfrtnVLg-1
X-Mimecast-MFC-AGG-ID: KDwlNwZlOG6FoijfrtnVLg_1741171720
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390e50c1d00so5108681f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 02:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741171719; x=1741776519;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zi8TYJXIRo742efp9c9ooVWub5kQoW1rshzUifHHiLE=;
 b=hUzODqDGZPNDI0bO8dHNqqhgs/0afhn3rKE0gyq590jquphvdFhapnoVl8V1mgKlZf
 LoK2cH2VXY4jtu6i5oG4gteAMHBg7zh+83Nc2D7GwbofBdUBe2pg2srUsR4Ya/CcoGB4
 AOnuK/D9c+G1j2KNIejlSpoogyFynbLF51ZtXqjXbtsKGLLMCAIGw5P7wo2wrca6SPEL
 wWriMcEgLsmY7TL7+d5OHJcHMmzfxlqHLZSyAQvJioE0IN9YpsDFTX1Q9b05rAja5ZR9
 euJRFvTt+B1lbfB92y9JIOPVsrWYi936Sg+3Aeal+VYAHfAJmPDEpmYHg6K4FXRURSkC
 HEvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzgV+8T7IjJ3ezYxxVzsix9r1oMgBWSS97Un/miEg60CWWj1JSKKyUAgdUA0XsuUYHBVkU3MrVlbSr@nongnu.org
X-Gm-Message-State: AOJu0YyZDK4WZYdCRhyoEnxVAed5uJ5feAQA/TjWyy7xcCSvdbYn8Jeu
 Y9xaRA2W2WUlc/LpbNJlXRp5bfA9v27FcTVlbp/Z7b9CrvBhBQc/up4epdBcp9OBSILQS50z2ru
 eIihEfi5l6MGRUgJwbN7nVCGcZ/N8uosM5Mmv1jYl5g6AXH/Fkl7z
X-Gm-Gg: ASbGncvfuvVxP38QZ1C5KnWIV8pIc+M31dpBeXx/07Ew/ciUmkVD7bZ2bLbkrhXcA4n
 GtKdAuxbgFLUwdSnJOvHy7dfDhzazXFjWFljQbC8/wv7RRZ+dPaxnSD7c8rzB4CaewmXq1TTQ0K
 f5CbYoHpq7O8NVGYK8a6qnE6iDK8sifpXlAbzDNfTmBQcaKvlAyix1ThiPpa0aXUkKTkx22UM8C
 eBZsHindTprI6UAqd6CdmbOKZahiVQSg5JQco2jDIpiLsvGSXt3c8RR78R6v0I90ZBNmpKGK1Je
 InpfVJCi+VMFZPnpja/IJfmwYHITd1fgIGb9Bij15yIy0cg=
X-Received: by 2002:a5d:6dad:0:b0:390:ffd0:4142 with SMTP id
 ffacd0b85a97d-3911f75678emr2074812f8f.26.1741171719299; 
 Wed, 05 Mar 2025 02:48:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF13bvT2KclFDloxNTKHqsSxYG2XrIVTfGNufYvBcJ2j2xre42KXInvZX0V1h5isjkOCnaB1w==
X-Received: by 2002:a5d:6dad:0:b0:390:ffd0:4142 with SMTP id
 ffacd0b85a97d-3911f75678emr2074797f8f.26.1741171718912; 
 Wed, 05 Mar 2025 02:48:38 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484452asm20816071f8f.61.2025.03.05.02.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 02:48:38 -0800 (PST)
Message-ID: <2aadca2b-f889-477d-88ed-dc030f576c24@redhat.com>
Date: Wed, 5 Mar 2025 11:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about/emulation: Fix broken link
To: Santiago Monserrat Campanello <santimonserr@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, laurent@vivier.eu, mjt@tls.msk.ru,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250305102632.91376-1-santimonserr@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250305102632.91376-1-santimonserr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/03/2025 11.26, Santiago Monserrat Campanello wrote:
> semihosting link to risc-v changed
> 
> Signed-off-by: Santiago Monserrat Campanello <santimonserr@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2717
> ---
> the original one linked it's still accesible on
> https://github.com/riscv-non-isa/riscv-semihosting/blob/0.2/riscv-semihosting-spec.adoc
> ---
>   docs/about/emulation.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 3bc3579434..a72591ee4d 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -171,7 +171,7 @@ for that architecture.
>       - Unified Hosting Interface (MD01069)
>     * - RISC-V
>       - System and User-mode
> -    - https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc
> +    - https://github.com/riscv-non-isa/riscv-semihosting/blob/main/riscv-semihosting.adoc
>     * - Xtensa
>       - System
>       - Tensilica ISS SIMCALL

Reviewed-by: Thomas Huth <thuth@redhat.com>


