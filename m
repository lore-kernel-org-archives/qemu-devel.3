Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18556C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LJV-00058V-EJ; Fri, 26 Apr 2024 09:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s0LJN-000577-JU
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:08:21 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s0LJL-00083t-PZ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:08:21 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51bae805c56so2501323e87.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714136897; x=1714741697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ojfaGpZDBKrXxqEULNT37n9qz/YZrJPCLwSYtOnfSY=;
 b=Cd1bZenBkdNgVx8yVpPzlLbT63dVqMzkNS0Ip1tKmlzqO65owxlei+hFa7+gTs2alQ
 EqPAUL//lKfZtWUqDk3PgoVVD3asrdlSzZW7cOZ23L7WQY+S3BYS3YPo3ylA4FAKPqvg
 tGTiA63P8jVkJGIOV5hplPsFT5O98booWwFMoORwex+hVXtxhVufZ8cWhjegJGn6f0Od
 ZPHCq5jPVEfRZ/Cqn3A+uoI84FeJ9e6yLASLk/HNGG3PgxCucHxdceTxJYMA332L1MQv
 an7oVMovR1D/B9wpmMpuecBlsvd57zdRP9h/GgXNWtJ/YcYB9B0EYZMzZ7PdhUNPhLTf
 WRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714136897; x=1714741697;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ojfaGpZDBKrXxqEULNT37n9qz/YZrJPCLwSYtOnfSY=;
 b=d2Q6/xt7ZpfsiWPN8Gpj7sJIwZwFWhpMYKRypPj1VFEw4nF3IRy/mya9Vzs2dxSFsW
 rLJp76ubaA6AFCk4ObLDa9H++2o6qVcKGVXZLS/8B5BX/rCGStXU8yriBEC1fVGQKkBr
 0vufiD6LcfoLj+RfdPrNiB5kdpGNPrZIt0KiQ2R1239kg5++ZYjTDdOKsPT9tzgfJRQd
 8sz0THZutRpeBJH8483iwlsVY7DXAlF+SS8gaPY6LEg6PHkTt/dEPOKyKeW0Lcitm4Ph
 QtDLn5RAluMCcS9oAARbeAuaR7kfLAcLqW8RnhroQq02wGpeDOv+D3Y20WWs4SxODh1h
 echg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1KUP8O9y+KVTTu9z7ZrCYhsiQxlRslo98n+y6U5xKZaWlJliNmhlMc+A2+In+xqQltnweKLbm2mp6xvlyIBS0Dbyvdec=
X-Gm-Message-State: AOJu0YzQcnyRNLbR/l+JI/OKp47qsPpiDNAQXcS2YPyzocgiRgXrp3bG
 fJQV9CaHIOvpVSVBO+IXu7IRfa9ekKhDcOPCAjGWiaSMt9g3lsTQ
X-Google-Smtp-Source: AGHT+IESfczpKb+1DUuegGG9wtDgVDOOICzYRe1I50RMoPxsT5DOjPF9+uxtmpr82xH6GvdgL+sWOw==
X-Received: by 2002:a19:e054:0:b0:51b:223f:ac49 with SMTP id
 g20-20020a19e054000000b0051b223fac49mr1655321lfj.38.1714136897231; 
 Fri, 26 Apr 2024 06:08:17 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-131-109.89.14.pool.telefonica.de.
 [89.14.131.109]) by smtp.gmail.com with ESMTPSA id
 fi20-20020a056402551400b005723c612b1esm1898979edb.64.2024.04.26.06.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 06:08:16 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:08:14 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 4/4] hw/i386: Consolidate isa-bios creation
In-Reply-To: <dc0ccf20-fa3f-4882-a179-17798ebe5106@linaro.org>
References: <20240422200625.2768-1-shentey@gmail.com>
 <20240422200625.2768-5-shentey@gmail.com>
 <dc0ccf20-fa3f-4882-a179-17798ebe5106@linaro.org>
Message-ID: <18751F18-7C82-40C4-A191-37D44832F153@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 25=2E April 2024 07:19:27 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 22/4/24 22:06, Bernhard Beschow wrote:
>> Now that the -bios and -pflash code paths work the same it is possible =
to have a
>> common implementation=2E
>>=20
>> While at it convert the magic number 0x100000 (=3D=3D 1MiB) to increase=
 readability=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   include/hw/i386/x86=2Eh |  2 ++
>>   hw/i386/pc_sysfw=2Ec    | 28 ++++------------------------
>>   hw/i386/x86=2Ec         | 29 ++++++++++++++++++-----------
>>   3 files changed, 24 insertions(+), 35 deletions(-)
>
>
>> diff --git a/hw/i386/pc_sysfw=2Ec b/hw/i386/pc_sysfw=2Ec
>> index 6e89671c26=2E=2Ee529182b48 100644
>> --- a/hw/i386/pc_sysfw=2Ec
>> +++ b/hw/i386/pc_sysfw=2Ec
>> @@ -28,7 +28,6 @@
>>   #include "sysemu/block-backend=2Eh"
>>   #include "qemu/error-report=2Eh"
>>   #include "qemu/option=2Eh"
>> -#include "qemu/units=2Eh"
>>   #include "hw/sysbus=2Eh"
>>   #include "hw/i386/x86=2Eh"
>>   #include "hw/i386/pc=2Eh"
>> @@ -40,27 +39,6 @@
>>     #define FLASH_SECTOR_SIZE 4096
>>   -static void pc_isa_bios_init(MemoryRegion *rom_memory,
>> -                             MemoryRegion *flash_mem)
>> -{
>> -    int isa_bios_size;
>> -    MemoryRegion *isa_bios;
>> -    uint64_t flash_size;
>> -
>> -    flash_size =3D memory_region_size(flash_mem);
>> -
>> -    /* map the last 128KB of the BIOS in ISA space */
>> -    isa_bios_size =3D MIN(flash_size, 128 * KiB);
>> -    isa_bios =3D g_malloc(sizeof(*isa_bios));
>> -    memory_region_init_alias(isa_bios, NULL, "isa-bios", flash_mem,
>> -                             flash_size - isa_bios_size, isa_bios_size=
);
>> -    memory_region_add_subregion_overlap(rom_memory,
>> -                                        0x100000 - isa_bios_size,
>> -                                        isa_bios,
>> -                                        1);
>> -    memory_region_set_readonly(isa_bios, true);
>> -}
>
>
>> diff --git a/hw/i386/x86=2Ec b/hw/i386/x86=2Ec
>> index 32cd22a4a8=2E=2E7366b0cee4 100644
>> --- a/hw/i386/x86=2Ec
>> +++ b/hw/i386/x86=2Ec
>> @@ -1136,13 +1136,28 @@ void x86_load_linux(X86MachineState *x86ms,
>>       nb_option_roms++;
>>   }
>>   +void x86_isa_bios_init(MemoryRegion *rom_memory, MemoryRegion *bios,
>> +                       bool isapc_ram_fw)
>> +{
>> +    int bios_size =3D memory_region_size(bios);
>> +    int isa_bios_size =3D MIN(bios_size, 128 * KiB);
>> +    MemoryRegion *isa_bios;
>> +
>> +    isa_bios =3D g_malloc(sizeof(*isa_bios));
>
>Pre-existing, but we shouldn't leak MR like that=2E
>
>Probably better to pass pre-allocated as argument,
>smth like:
>
>  /**
>   * x86_isa_bios_init: =2E=2E=2E at fixed addr =2E=2E=2E
>   * @isa_bios: MR to initialize
>   * @isa_mr: ISA bus
>   * @bios: BIOS MR to map on ISA bus
>   * @read_only: Map the BIOS as read-only
>   */
>  void x86_isa_bios_init(MemoryRegion *isa_bios,
>                         const MemoryRegion *isa_mr,
>                         const MemoryRegion *bios,
>                         bool read_only);
>

Same would apply for the "pc=2Ebios" region=2E I'll fix both then=2E

Best regards,
Bernhard

>> +    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
>> +                             bios_size - isa_bios_size, isa_bios_size)=
;
>> +    memory_region_add_subregion_overlap(rom_memory, 1 * MiB - isa_bios=
_size,
>> +                                        isa_bios, 1);
>> +    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
>> +}
>

