Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C310C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 11:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbfoO-0005Tw-Dn; Sun, 18 Feb 2024 06:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbfoN-0005Ti-4E
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 06:58:23 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbfoL-0007E2-Mr
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 06:58:22 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a29c4bbb2f4so443370066b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 03:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708257498; x=1708862298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvjy9a0b/8+i18hyyzJpz5TV4ynW3qWlZS8jq+3Gv/c=;
 b=HGeOuAOKXcMqLENr63ItraItD7auChMIFvuK76KvJNBJ6geWJf7KSxZwx6maQolgAI
 cwE16TkM1UATLDt/a/CicliDtTvBhWGAVjOvMMbWzjQNedUVktzv/w6vYUrOxx1OK17c
 fLMpZ8nYcy8YdbQQSV5UjwVhUx6iUk9OXQRs2AJwjlQwkrwBYE8HNjcM0I9iqTW7dVFV
 z0k63u+Gbba+sJecMKmfTB8CbFqjBSVjWyG1mNSwuE9J0o2w9B59b+kjHHw/a1sZPjHJ
 077TCjSScsfq80eK/oxeEH6XOZgjZTuTq4xi1rajzPVEUj+40qJfjhIJzqOjRONjthm6
 WAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708257498; x=1708862298;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvjy9a0b/8+i18hyyzJpz5TV4ynW3qWlZS8jq+3Gv/c=;
 b=MQWnZs4K/IL/4QPOy85hirwcUH1tOBf8PkLRVA+96N38tt9oFMU5uV4hKvWI9NV+dL
 DbR86SDMADrBBs3pWCtFkck2xbdtiiGGLPhKKtle6u2r2+E5FGNC31Au2YiVnaoSsCVK
 vrXwh8VFHgTr4DTnxOlSdKos3LLriOD3DJyFrqfw+4NhDFBYSuOEaElwxJf4WzyRRXfh
 DTnScktYH/32+GkZIICa1qkZjfvy0hTk8gV0cCfGKY74RrOlAMGVsqfYrOEwrUh+AHlA
 7DfWuRWw2mz2BHYsaVoGIhWH6zDH3nviE3Qmev9bQDFr8YR00tYl4xyHrK4BBTgxUfKm
 2lCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMFfg42yxW8ipQP3ni1xfbrEQqbOrPwqpE3le9I1sK3yXbIemXvls1YLrKDcP2yoGR8PigMKjkVjnkJcayR5lWosR7fUQ=
X-Gm-Message-State: AOJu0Yyaq0CqMQW2HSJ5qjXKtdNH+VVMF1jDXuu6lk196YycvEjoQbqe
 arOjQBV7rCqmfJ2Ycch+qh450ACn1PbNc7af/eweV0MzqqdRC9KDU35XPBcn
X-Google-Smtp-Source: AGHT+IHTeh19FQdPVdlMM46nntToPtifwRkjIClYQdolS2EP3/UroRJSl9Uo6OAs8cVaV7gv0jaSrg==
X-Received: by 2002:a17:906:a19a:b0:a3d:2a52:380f with SMTP id
 s26-20020a170906a19a00b00a3d2a52380fmr6194835ejy.72.1708257497867; 
 Sun, 18 Feb 2024 03:58:17 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-149-080.78.54.pool.telefonica.de.
 [78.54.149.80]) by smtp.gmail.com with ESMTPSA id
 fy22-20020a170906b7d600b00a3cf4e8fdf5sm1869956ejb.150.2024.02.18.03.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Feb 2024 03:58:17 -0800 (PST)
Date: Sun, 18 Feb 2024 11:58:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/i386/pc=5Fq35=3A_Populate_interru?=
 =?US-ASCII?Q?pt_handlers_before_realizing_LPC_PCI_function?=
In-Reply-To: <a69d2291-4bd6-42de-9049-e973b11d0acf@linaro.org>
References: <20240217104644.19755-1-shentey@gmail.com>
 <a69d2291-4bd6-42de-9049-e973b11d0acf@linaro.org>
Message-ID: <5909C4A9-28E7-4D13-8D96-DD6ABFA97304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 18=2E Februar 2024 10:47:26 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 17/2/24 11:46, Bernhard Beschow wrote:
>> The interrupt handlers need to be populated before the device is realiz=
ed since
>> internal devices such as the RTC are wired during realize()=2E If the i=
nterrupt
>> handlers aren't populated, devices such as the RTC will be wired with a=
 NULL
>> interrupt handler, i=2Ee=2E MC146818RtcState::irq is NULL=2E
>
>Why no CI test caught that?

Good question=2E I think the missing IRQ connection would even be hardly n=
oticeable when running a full and modern graphical Linux distro as guest=2E=
 There is rtc-test=2Ec but I don't know if wiring is in its scope=2E

Best regards,
Bernhard

>
>> Fixes: fc11ca08bc29 "hw/i386/q35: Realize LPC PCI function before acces=
sing it"
>>=20
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/i386/pc_q35=2Ec | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>> index d346fa3b1d=2E=2E43675bf597 100644
>> --- a/hw/i386/pc_q35=2Ec
>> +++ b/hw/i386/pc_q35=2Ec
>> @@ -240,10 +240,10 @@ static void pc_q35_init(MachineState *machine)
>>       lpc_dev =3D DEVICE(lpc);
>>       qdev_prop_set_bit(lpc_dev, "smm-enabled",
>>                         x86_machine_is_smm_enabled(x86ms));
>> -    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>>       for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
>>           qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms-=
>gsi[i]);
>>       }
>> +    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>>         rtc_state =3D ISA_DEVICE(object_resolve_path_component(OBJECT(l=
pc), "rtc"));
>>  =20
>

