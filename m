Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA9ECF2561
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 09:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szYc8-0005Dd-BL; Sat, 12 Oct 2024 05:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szYc4-00059a-0c
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 05:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szYc1-0000rB-G0
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 05:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728726034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XpvDuJSe2Ld8vir3PcZolc4fj1dmP79+o/0PGBjhT0A=;
 b=OsfuxGW/d9fo4JROAHMUmSQkIMQE9edy+Jbs9GtQ+WHfrDEFUC5QyIBZkbozlO3JPNw8LB
 r9f3BpaazSN0NpPv7jPKopIZOhXV9a79hWF9LBEsEQLvhfzuhYA66CGrbDK8EqdYsrxBT7
 91y6eWQ/MCJvVXRD7anHj5PqYte/SSY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-0X91nYpbMGCVaDJnfK6jPw-1; Sat, 12 Oct 2024 05:40:31 -0400
X-MC-Unique: 0X91nYpbMGCVaDJnfK6jPw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a99345b8a29so189701666b.3
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 02:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728726030; x=1729330830;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpvDuJSe2Ld8vir3PcZolc4fj1dmP79+o/0PGBjhT0A=;
 b=ebzMtB41lvKt9xsPhcyqEmHfYhNhGs36Vo+qgvI7u2gugAta/PWlotW7eaUVsF1oQM
 zgI8xzx6IkCwWx5CrEMbkHpGleBaZBam0/YiPo2rZqCzKPjsWW/5f6rU4ak0PV29Ur16
 JlAPwptU1kMPHDsONwhz0qry/XIZSRU8hlpl7xrTjB07e2Q/02RLccmcMz6XKYe1Bvkl
 7NKUAURdmOSFF5azqsBLUXhXyBQNCC/aQunHN1F20lvhh4MGuPjjnQgVIxo747XAjvKm
 OlMhRYKEEc/D+qXAUpxpI3NwrxWf8YjHv9ij7AMCBHLA86XDlM6ucRU8dfgJmps/CUgX
 XM9g==
X-Gm-Message-State: AOJu0YyFu82CyOZz9Fiim6Cn6EuY++7FLyjfmPiS4ri225qCWTWL6gDI
 dVC0/a/zFgU8TxW9VIlU1T3Psqjd9zW5zDyKrhm/ngMGK6YEL6XvgvaqrATLaVUcC9vIINP6iUs
 SQTdocMlG2Y97ViXGBcNeZX0CEQYaITTp7bD80qpzg9ubUB7LIAxl
X-Received: by 2002:a17:906:6a0a:b0:a99:f2fd:64bb with SMTP id
 a640c23a62f3a-a99f2fd669bmr69501266b.60.1728726030404; 
 Sat, 12 Oct 2024 02:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+90F087KuCAfJ4iVrinqgjBqcsn2kf3MqZx0vikeiEwQOubcRuCXeOrbvdIbwaUg6AohrSw==
X-Received: by 2002:a17:906:6a0a:b0:a99:f2fd:64bb with SMTP id
 a640c23a62f3a-a99f2fd669bmr69498466b.60.1728726029962; 
 Sat, 12 Oct 2024 02:40:29 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-26.web.vodafone.de. [109.42.51.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99ecab95bfsm54496066b.108.2024.10.12.02.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 02:40:29 -0700 (PDT)
Message-ID: <08586e5f-6a5e-445c-b74b-e2c12560020f@redhat.com>
Date: Sat, 12 Oct 2024 11:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] hw/sh4/r2d: Realize IDE controller before
 accessing it
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bernhard Beschow <shentey@gmail.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-8-philmd@linaro.org>
 <3434b32e-036a-485c-b3c2-3dd111e6152d@roeck-us.net>
 <7735d722-1047-49b2-ae2b-c95ead698a54@redhat.com>
 <61c38817-3b6e-4bc1-a65a-d2208869c53d@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <61c38817-3b6e-4bc1-a65a-d2208869c53d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/10/2024 00.48, Philippe Mathieu-Daudé wrote:
> On 11/10/24 05:23, Thomas Huth wrote:
>> On 03/05/2024 23.34, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Thu, Feb 08, 2024 at 07:12:40PM +0100, Philippe Mathieu-Daudé wrote:
>>>> We should not wire IRQs on unrealized device.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>
>>> qemu 9.0 fails to boot Linux from ide/ata drives with the sh4
>>> and sh4eb emulations. Error log is as follows.
>>>
>>> ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
>>> ata1.00: 16384 sectors, multi 16: LBA48
>>> ata1.00: configured for PIO
>>> scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
>>> sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
>>> sd 0:0:0:0: [sda] Write Protect is off
>>> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
>>> support DPO or FUA
>>> ata1: lost interrupt (Status 0x58)
>>>
>>> [ and more similar errors ]
>>>
>>> qemu command line:
>>>
>>> qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
>>>     -snapshot -drive file=rootfs.ext2,format=raw,if=ide \
>>>     -append "root=/dev/sda console=ttySC1,115200 noiotrap" \
>>>     -serial null -serial stdio -monitor null -nographic -no-reboot
>>>
>>> Bisect points to this patch (see below). Reverting it fixes the problem.
> 
> Sorry Guenter for missing your email :(
> 
>>
>>   Hi Philippe!
>>
>> Today I noticed that our sh4 test from tests/avocado/tuxrun_baselines.py 
>> is failing (which is not run by default, that's why nobody noticed), and 
>> bisection took me to the same result that Guenter already reported.
> 
> "not run by default" because flaky.
> 
> Having a quick look, the problem seems hw/ide/core.c uses non-QOM
> shortcuts. In particular ide_bus_init_output_irq() expects a preset
> IRQ. Not something trivial to fix.

I wonder whether the other spots that use ide_bus_init_output_irq() or 
similar constructs are broken now, too. Bernhard apparently already fixed 
(reverted) one in commit 143f3fd3d8b51d6526c8ea80e8a2a085f6f01cdf.

But what about fc432ba0f58343c8912b80e9056315bb9bd8df92 ?

  Thomas


