Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AB5C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZws-0003HQ-6r; Wed, 22 Jan 2025 07:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taZwq-0003Eh-Fg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:35:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taZwo-0007zZ-M4
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737549302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1KES4xpsLEdFe1fXg8Bxj9Xy+gRWvqiZGMytL01K9eo=;
 b=O3l8qBtvIIYDS8cjAOvs39AdN83oqCtt4Eq4LzaHhuMn/goeE97MvWL57F4aN7N/x06m+o
 WGwy8YW4XvYm0DIa9R33EhBEcrQWAZxtzCCRafhiy/FszQpiNhxo9JeLw6v2mcCvlSm7wu
 d7vLKyV6lg8z1Q5c0+iX3S4JFND8meg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-dmmCAJ6yMfCNtmHiGDHVxg-1; Wed, 22 Jan 2025 07:35:01 -0500
X-MC-Unique: dmmCAJ6yMfCNtmHiGDHVxg-1
X-Mimecast-MFC-AGG-ID: dmmCAJ6yMfCNtmHiGDHVxg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso4704569f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 04:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737549300; x=1738154100;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1KES4xpsLEdFe1fXg8Bxj9Xy+gRWvqiZGMytL01K9eo=;
 b=JuMWshJvvnQkHw/uDvdyMr7so/MFPHXViUcKYXN/KQ7zgziGRPAmB0P7wvi7BoXJ6G
 ermuup/rTL0He73sdxTKfI4/mHFJsQI7gCuCEECNyVTGnm1P6Ln48359/KVYeqE+ARyK
 e/FiPhow6JV6huYVvWFXOSFSUKKnJ3ivOVQQmal4vpa9yYlN8hyvx5PeoilANaVCmvaf
 qb1sMViaT6aDiSH1gKTAOrgaH8xjjCU6/054Yh69i6pmUghK5vVXazQvLhkPsequKpmD
 fxK9zn06L5mkKlrb7fs8yScYFRIGIzBQM2jp1dKId8404i77dw9PNqTttpkAWRBsNcEN
 n+pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6MmtLRU5NiCrRxsQ4gHwSP6CGvxA9AsNGo7fViUo2Us+gd9IV5BU+IqLLD1YjMsFsO6pDpOpmu8JK@nongnu.org
X-Gm-Message-State: AOJu0Yz9j2MLUi1d36tWHs+xVXC/FLYr/sYW3S1C5pc8WQ1LLk5mOpxx
 KFf9pdBy4N6BgmVQb9GRLHmhA0mYgXLw0gksU8ksxKmYYHQMH+uyED5aiAttmULTWhZ4RlArv+W
 a/rl8A2D57s57O/KSCiuq2jXKn4iqVZVceuNaJ7lp+rgTu1jta1CS
X-Gm-Gg: ASbGncuJ55MmyI8J0AZm5CzpWqrij9VCQR3hyM92Gi5cYWr9KSFQROMvEDfHpgTSL7V
 rhOPWONBF2pToeWhjNVvfrTPgN7k0jcyCKF6v6dCJQq8VtElFGoRC7aClBqRZ+M2/P54ltwztNO
 GlGFOmudeHoohXd+q9QDo2K7kobepwMlq9iKzQOgVkbbQCRpuwkpxX3wQwOH9U8MS4vpj4H340H
 eNVIFWn9DepK8J/1K17r+t+GPCrhhGDKhXdK9RYuHCglcLWPQmumah7FwsiRSD9SZJQQnvBXvlJ
 NCbMiTNGkwGesGcINwlMBbAAoQ==
X-Received: by 2002:a05:6000:1f88:b0:385:fd31:ca23 with SMTP id
 ffacd0b85a97d-38bf57a7797mr21884770f8f.40.1737549300187; 
 Wed, 22 Jan 2025 04:35:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq9j2XVfhZb6BfGEG7F/g4RlK/ryrxUz4608Kg5VNiBDgJcp/HDm+51ge7CQppTT3M2BCLxg==
X-Received: by 2002:a05:6000:1f88:b0:385:fd31:ca23 with SMTP id
 ffacd0b85a97d-38bf57a7797mr21884743f8f.40.1737549299767; 
 Wed, 22 Jan 2025 04:34:59 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-103.web.vodafone.de.
 [109.42.48.103]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3278088sm16216232f8f.73.2025.01.22.04.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 04:34:59 -0800 (PST)
Message-ID: <6393ca88-0613-415e-8178-18a34778b2ab@redhat.com>
Date: Wed, 22 Jan 2025 13:34:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/boards: Convert MachineClass bitfields to boolean
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250122103223.55523-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250122103223.55523-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/01/2025 11.32, Philippe Mathieu-Daudé wrote:
> As Daniel mentioned:
> 
>   "The number of instances of MachineClass is not large enough
>    that we save a useful amount of memory through bitfields."
> 
> Also, see recent commit ecbf3567e21 ("docs/devel/style: add a
> section about bitfield, and disallow them for packed structures").
> 
> Convert the MachineClass bitfields used as boolean as real ones.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h        | 14 +++++++-------
>   hw/arm/aspeed.c            |  6 +++---
>   hw/arm/fby35.c             |  4 ++--
>   hw/arm/npcm7xx_boards.c    |  6 +++---
>   hw/arm/raspi.c             |  6 +++---
>   hw/arm/sbsa-ref.c          |  2 +-
>   hw/arm/virt.c              |  2 +-
>   hw/arm/xilinx_zynq.c       |  2 +-
>   hw/avr/arduino.c           |  6 +++---
>   hw/core/null-machine.c     | 10 +++++-----
>   hw/i386/microvm.c          |  2 +-
>   hw/i386/pc_piix.c          |  2 +-
>   hw/i386/pc_q35.c           |  4 ++--
>   hw/loongarch/virt.c        |  2 +-
>   hw/m68k/virt.c             |  6 +++---
>   hw/ppc/pnv.c               |  2 +-
>   hw/ppc/spapr.c             |  2 +-
>   hw/riscv/virt.c            |  2 +-
>   hw/s390x/s390-virtio-ccw.c |  8 ++++----
>   hw/xtensa/sim.c            |  2 +-
>   20 files changed, 45 insertions(+), 45 deletions(-)

So if you are touching all these files, why not go with an even more 
meaningful rework instead? Flip the meaning of the "no_*" flags to the 
opposite, so that we e.g. have "has_default_cdrom" instead of "no_cdrom", 
then new boards would not have to remember to set these ugly "no_" flags 
anymore. It's quite a bit of work, but it could certainly be helpful in the 
long run.

  Thomas


> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 2ad711e56db..ff5904d6fd8 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -279,13 +279,13 @@ struct MachineClass {
>       int max_cpus;
>       int min_cpus;
>       int default_cpus;
> -    unsigned int no_serial:1,
> -        no_parallel:1,
> -        no_floppy:1,
> -        no_cdrom:1,
> -        no_sdcard:1,
> -        pci_allow_0_address:1,
> -        legacy_fw_cfg_order:1;
> +    bool no_serial;
> +    bool no_parallel;
> +    bool no_floppy;
> +    bool no_cdrom;
> +    bool no_sdcard;
> +    bool pci_allow_0_address;
> +    bool legacy_fw_cfg_order;
>       bool is_default;
>       const char *default_machine_opts;
>       const char *default_boot_order;


