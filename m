Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C754FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LGc-0003fE-V0; Fri, 26 Apr 2024 09:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s0LGX-0003aN-CR
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:05:26 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s0LGS-0007I1-41
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:05:25 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57232e47a81so3619628a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714136717; x=1714741517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyNo9fa0EjoCFjhpZwr8HO0uzP0sM5nnEtjZYEros8g=;
 b=ghfrBKU4vl9CYLHCApSkuvFxqej9mYlA5+vcn/POnxYbhN4xGxjMYWJw62P8YAVHPL
 DFo0VrZvh55qeEHvtE5rq48laRomVLMYkWYGxpAD5zxKwAgPNmSnCdUm8JzbXMCl+NAU
 GVWUNu1yRj5fORehe6RaWDBc7x/SMqqhd7+bXf/HNK3xOG0A2j6fS+JvPxF0o7GdShnY
 65zod66tQcrErGgfmyC7bfoUPwOOzA8kZyQoiN3nQK0mzzMSgKUFIBmEVMM1+S8jxHRY
 UAJntGXzlTjgUBtpYcgX/TFnqcP6RGKpcOx8hgx9+4HUY9k8u/tO8ZeJ3JdmcDIOGQOd
 NyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714136717; x=1714741517;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LyNo9fa0EjoCFjhpZwr8HO0uzP0sM5nnEtjZYEros8g=;
 b=kM5+xCKQjvUqDIIhWj1nRRnTDUsqU3a3fwoUZFdZAQbdYARWXeeEcISaqNi3FIj30V
 ZH8GHNjSd+yikcOGhQBWjbQddp7fxV+gEh6YeTJHoP+FRnleGf6XiwhMeZj1u++dVT3R
 f+OxzgWCtrfKm5RbWq/GL7fLhgUfF/p3aO4ZWNeMQY4Um85ZkFLWQGsDk/rmKkHj16vE
 c+Cok0vtEn3Hxnep02QpDZ2AOxcbKvXqlMcPiP7YUrarkR4piNp7NSVSQBlE5u3WGDzJ
 G8UWx7jLqSyjBvY3EgLJnmCCEAG/XJ3m4CJWwtYiJfRb6fB95AjUvKR8cpPnBhcw1j7i
 WLmg==
X-Gm-Message-State: AOJu0Ywqr2tHLPZ4xg2G18LbAHjI4SMTyWZGoHHxC3hu0wdhzd0MDrCC
 p8n8FLS1Fu+dNpa2FxnuH/poQA7zKTIGjuqysMqb4fSp7JiUWNYZ
X-Google-Smtp-Source: AGHT+IGo46cQEU15J14FaWzRela78a4msHVsCwsj8ybQW3VxQqSILSkangec1/4zOHHbACatAplR3w==
X-Received: by 2002:a50:d519:0:b0:571:e293:a8de with SMTP id
 u25-20020a50d519000000b00571e293a8demr2213618edi.20.1714136716957; 
 Fri, 26 Apr 2024 06:05:16 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-131-109.89.14.pool.telefonica.de.
 [89.14.131.109]) by smtp.gmail.com with ESMTPSA id
 f11-20020a056402194b00b005720cefe0d2sm5679132edz.52.2024.04.26.06.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 06:05:16 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:05:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/4] X86: Alias isa-bios area and clean up
In-Reply-To: <20240425061122-mutt-send-email-mst@kernel.org>
References: <20240422200625.2768-1-shentey@gmail.com>
 <20240425061122-mutt-send-email-mst@kernel.org>
Message-ID: <4ED03817-6D49-45BF-B81C-C3F12325B1A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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



Am 25=2E April 2024 10:16:10 UTC schrieb "Michael S=2E Tsirkin" <mst@redha=
t=2Ecom>:
>On Mon, Apr 22, 2024 at 10:06:21PM +0200, Bernhard Beschow wrote:
>> This series changes the "isa-bios" MemoryRegion to be an alias rather t=
han a
>> copy in the pflash case=2E This fixes issuing pflash commands in the is=
a-bios
>> region which matches real hardware and which some real-world legacy bio=
ses I'm
>> running rely on=2E Furthermore, aliasing in the isa-bios area is alread=
y the
>> current behavior in the bios (a=2Ek=2Ea=2E ROM) case, so this series co=
nsolidates
>> behavior=2E
>>=20
>> The consolidateion results in duplicate code which is resolved in the s=
econd
>> half (patches 3 and 4) in this series=2E
>>=20
>> Question: AFAIU, patch 2 changes the behavior for SEV-enabled guests si=
nce the
>> isa-bios area is now encrypted=2E Does this need compat machinery or is=
 it a
>> bugfix?
>
>When in doubt, do a compat thing=2E

Will do=2E

Thanks,
Bernhard

>
>> Testing done:
>> * `make check` with qemu-system-x86_64 (QEMU 8=2E2=2E2) installed=2E Al=
l tests
>>   including migration tests pass=2E
>> * `make check-avocado`
>>=20
>> Best regards,
>> Bernhard
>>=20
>> Bernhard Beschow (4):
>>   hw/i386/pc_sysfw: Remove unused parameter from pc_isa_bios_init()
>>   hw/i386/pc_sysfw: Alias rather than copy isa-bios region
>>   hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>>   hw/i386: Consolidate isa-bios creation
>>=20
>>  include/hw/i386/x86=2Eh |  2 ++
>>  hw/i386/pc_sysfw=2Ec    | 38 ++++----------------------------------
>>  hw/i386/x86=2Ec         | 35 +++++++++++++++++++----------------
>>  3 files changed, 25 insertions(+), 50 deletions(-)
>>=20
>> --=20
>> 2=2E44=2E0
>>=20
>

