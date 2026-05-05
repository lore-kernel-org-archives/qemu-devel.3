Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108EDCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMmR-0002wm-GK; Tue, 05 May 2026 16:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wKMmM-0002vs-OE
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:54:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wKMmL-0001Q3-36
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:54:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so82093705e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778014443; x=1778619243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OlMkUnK67P6OiqTbgbKmspu7e+U7zl/NOy2A2SBzKk=;
 b=KiLCzHTkuP8bcvK83ASSS/8SCb7V+j6GCnWs1wwImxheiHN+iIeTF8SpA2/zvsHQx+
 okkjR73RYkg6PuMPnFWeuzmwzQpnDVajRGhR9nnMSkF2gKuGo8luZkvOo5YeKOdAmtVu
 ZOBoaN1ojKxayJ6b5aUKwi2HBrU1rAeBL6AxkVCqxcOBNSK/VD9nX3XrMkvIE649ODl0
 Ue2ImL+3deGWVlBwvpv/A3krOXhx3Ru5PC8evXxjApfdaWAETUZu+TqixhcmyhlNufeq
 ew03cEWph0+CWsCWPVDmj0ZVx3NnCAhZv7cxisYFsfgD0Tro0m6dSvABc3cA9/j23ycn
 3G/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778014443; x=1778619243;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3OlMkUnK67P6OiqTbgbKmspu7e+U7zl/NOy2A2SBzKk=;
 b=dThwkyN70lx5/nX+h2+EIUM6/1VE+XBCNgj5R8E4m8civetNFl656oXEOE5LvCyz65
 IMNNw1XJXoxwdBSaXhXQNAJ2MjVsdzb2O51kNv9vogbsBQSANPTCNa8WlG0N8GopH31j
 zcV/527BQo/EKpq4z9vfoJuGV7rYotgvA8YSh2s6cbBLV06GysI+OniHIJ8DRVq4GcWK
 SrINPiLzTX4FQOqL1nglIK+em04ZcFIA2VYgBLKYvHVLNVdCjtA2z1YaI2toGROX7Qyw
 iayPYp09BhEYBd6UtT/iZ+d/71lMDB71wAS/VBVM5w7OMVDEnboquERgYqF+SjCf55nX
 Gm8Q==
X-Gm-Message-State: AOJu0YyhEo0YJXPPuoRT3h2iD9HAOyxxNHxHBY0BcdktURpSi/AVumNL
 YV2mS7jOH/tFSO5XKBHv1fNfV17DP0+txiyHjbwtrP/kEl1dG8O/tQb9
X-Gm-Gg: AeBDiesJC6WEmPveKn3VQowHL0wBwv+J+O5q6puXgjFB5Me6UCJFOhtBzyCHgh4l0ct
 aErsMsk4s4o/Xi4N5NJDLLLyHVzYiujcTt5W00yU/yxaNWpivqTst/WhMVvLKkzmYrclNs0Jfdi
 nrLvO7GPPgCtkjeDvxOxoctJUF4D1WVhc5/VDJM5GumfTR346+igauIJyGbRh8qAd/WA9p/f4z0
 jw0A1Mf84w5ru0dXsxFrEtM04GUsz5RRrslxe9wt4jPgN/4RqS4hdO7drucumqFDKmpezvaMrZQ
 vGjAaU2HMoANzZiyuVpdl4gy7+kvoCI7wmQHcv0+AwgeGU60peogFKdU9puTkK0NAH2urWRZHCA
 20Lpdfo07ajdms3aT/cV2KvxcmjGr2EjYBoFUi8SWULeGW3L7AoYmFTFYHukP25aBuNuuNneVZb
 v0ORFy2UMsmDY3GW5EFQJ2gJra2mfkQgIqZSxJ4yb+As0ZlD8XkCNS8DeUlqN63Yo7YT7K27VvS
 SQCk128NUqx3pdlVWIFuNaxQfsoo9XSPLtQJpIUEccqIGdoZv5inipB
X-Received: by 2002:a05:6000:61e:b0:441:2335:ac3f with SMTP id
 ffacd0b85a97d-4515d4d114fmr1157861f8f.31.1778014443322; 
 Tue, 05 May 2026 13:54:03 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2288-5100-c87f-e1c3-d3c0-0c97.310.pool.telefonica.de.
 [2a02:3100:2288:5100:c87f:e1c3:d3c0:c97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e7c0sm6410810f8f.3.2026.05.05.13.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 13:54:01 -0700 (PDT)
Date: Tue, 05 May 2026 20:53:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: Re: [PATCH 3/5] hw/arm/imx8mp-evk: Fix reference count of SoC object
In-Reply-To: <CAFEAcA_cYDwOFP_h_pKyUQ0kKmT671iZiNntzMC5O5tF=1cC=A@mail.gmail.com>
References: <20260308203516.160103-1-shentey@gmail.com>
 <20260308203516.160103-4-shentey@gmail.com>
 <CAFEAcA_cYDwOFP_h_pKyUQ0kKmT671iZiNntzMC5O5tF=1cC=A@mail.gmail.com>
Message-ID: <842AA964-4C27-47B7-85AB-A26BC607BD5D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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



Am 30=2E April 2026 15:39:48 UTC schrieb Peter Maydell <peter=2Emaydell@li=
naro=2Eorg>:
>On Sun, 8 Mar 2026 at 20:35, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> object_new() leaves a reference count of one, and object_property_add_c=
hild()
>> then leaves it at two=2E This would leak the SoC object if the machine =
object was
>> destroyed since the machine is the SoC's sole owner=2E Fix this by conv=
erting to
>> object_new_with_props() which gets the parenting and reference count ri=
ght in
>> one go=2E
>>
>> Fixes: a4eefc69b237 ("hw/arm: Add i=2EMX 8M Plus EVK board")
>> cc: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  hw/arm/imx8mp-evk=2Ec | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/imx8mp-evk=2Ec b/hw/arm/imx8mp-evk=2Ec
>> index b84ac91a17=2E=2Ecfc3038c36 100644
>> --- a/hw/arm/imx8mp-evk=2Ec
>> +++ b/hw/arm/imx8mp-evk=2Ec
>> @@ -74,8 +74,8 @@ static void imx8mp_evk_init(MachineState *machine)
>>          =2Emodify_dtb =3D imx8mp_evk_modify_dtb,
>>      };
>>
>> -    s =3D FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
>> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>> +    s =3D FSL_IMX8MP(object_new_with_props(TYPE_FSL_IMX8MP, OBJECT(mac=
hine),
>> +                                         "soc", &error_fatal, NULL));
>>      object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fata=
l);
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
>
>Looking again at this, is this really right?
>object_property_add_child(=2E=2E=2E) creates the object (refcount 1),
>adds it as a child of the specified parent (refcount 2), then
>does object_unref() (refcount 1)=2E Then in this code we call
>sysbus_realize_and_unref(), which calls qdev_realize_and_unref()=2E
>That function:
> * (indirectly) calls bus_add_child(), which takes a reference and
>   hands it to the link property on the parent (refcount 2)
> * calls object_unref(), as its name suggests (refcount 1)
>
>So now we have the object with refcount 1, so it doesn't just
>vanish, but on the other hand both the QOM tree parent and the
>qbus tree parent think they own a reference to the object,
>so our refcount is wrong=2E
>
>I think the existing code here was correct: we get a reference
>because we call object_new(), and then we drop it by calling
>the realize_and_unref function=2E
>
>I'm going to drop this patch from target-arm=2Enext=2E

Yeah, makes sense=2E Thanks foe the clarification=2E

We'll need to fix imx8mm-evk now since it uses the same broken pattern (I =
cc'd Gurav who incorporated this patch into his series)=2E I'll send a fix=
=2E

Best regards,
Bernhard

