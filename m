Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2031ACF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 21:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssr0v-0006RQ-VW; Mon, 23 Sep 2024 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssr0s-0006Q0-QE; Mon, 23 Sep 2024 17:54:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssr0q-00086t-85; Mon, 23 Sep 2024 17:54:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c5b954c359so2781275a12.1; 
 Mon, 23 Sep 2024 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727128469; x=1727733269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqJWx3P28Olbx33uV+DA/ET7MAsFUrsz7ZKAIOM5hLc=;
 b=jkrcyaWDTR6nCnt7Ms2IZVDghhGn2So/szZEF6R+1EjUGTnzl8GkCqdOXwRxqp5hvB
 bzyNIhB+RvxLLiiXnDdoL8ov3pbppV7WVGBK/5qV20hgysIR7gb5+JkOJHLG+Ydq94fy
 s/n5g55pfRAUewxM9VOohRU3KZ7aqJq/XnzfYmxWEczD5qvqJ1nXPmzQoeTQJNp/0fgU
 5jH1/C8VZzCeYi/GAy0f8d7LeAuzNbswPWjj9peujSyPO7o3M0CWRLw8ZsLLWx8HIKVJ
 SgH99TUFuDuide7ngJo8yej1jap62jHAtY4yhiCOJVpTu1ai7qAbyC0lUW8QwiEuh9sN
 0tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727128469; x=1727733269;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqJWx3P28Olbx33uV+DA/ET7MAsFUrsz7ZKAIOM5hLc=;
 b=Iu9YZ8pI9pz09U2M8UHQkbJogAS2HWK8D00bYyF4r3lUzTYQ1KWAcd0JT03vkO93GQ
 EH5bzVk1KnnISuVe2FksKxhbsOJ4ouD4tZc8sw2UpHPpndaSek5TK+IZm6YuFHxw1qvZ
 I/Rtn1bHOlSACKMoUlMyYZDPkqS7xUe7EovLgPvweW5k2bDSLvx4kVAvorQf8YmWN8G7
 rbpvQC8JSUgPkBUT4c86H5ArJb+JyFg2ZZ2bDFLN025iK4XDvpzK1OuKdWK+N02JKKtq
 uTzaLQ+81syfghYnAe9CAjOazidCa3SoEt902cN+VPSg4Iy4LijIGNBzmgi5OoZ4lee3
 CLhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfzAmUCVCwHjBdOUJ8nb4wWLLFGUjuDfwCnjNdHFQXj5Te8uGcF5juU9rGlF4SSOL7vObuOckIspk=@nongnu.org,
 AJvYcCVcuS2KfA99xUfiWfycTZ41M5qrfRskT/rZAeBhx5KnX8MiHXxiIFZiIhLhoj91t9NR0TEvZ5XQ7hEU@nongnu.org
X-Gm-Message-State: AOJu0Yy1qlgX7S99GwRBjqNQ6DwOJbjlb0zuIyUG4uxjTt6FDlJQh5rh
 ZdwvjXeEdRuZ6LyjhdkKHX+UFHFs3o59j4uTmccBb3tEoISOAbhX
X-Google-Smtp-Source: AGHT+IGo2Qlet3aZlmZsh3DOCZmwhFg+1XWOb3k7pmyCAywpt2L6FizCzG5AEpFzA4fEVBwdrHE2hA==
X-Received: by 2002:a17:907:7e8b:b0:a86:789f:c756 with SMTP id
 a640c23a62f3a-a90d50fd4aamr1440991666b.53.1727128468453; 
 Mon, 23 Sep 2024 14:54:28 -0700 (PDT)
Received: from [127.0.0.1] ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f50756sm5757466b.63.2024.09.23.14.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 14:54:28 -0700 (PDT)
Date: Mon, 23 Sep 2024 21:54:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_09/23=5D_hw/ppc/mpc8544=5Fguts=3A?=
 =?US-ASCII?Q?_Populate_POR_PLL_ratio_status_register?=
In-Reply-To: <3037d1f0-6e44-98ee-48fc-1bb206ebc624@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-10-shentey@gmail.com>
 <3037d1f0-6e44-98ee-48fc-1bb206ebc624@eik.bme.hu>
Message-ID: <56E67259-70A9-44E5-A3C2-6E40363A73C2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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



Am 23=2E September 2024 10:43:19 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> Populate this read-only register with some arbitrary values which avoid=
s
>> U-Boot's get_clocks() to hang()=2E
>
>Maybe this should be a property settable by the machine as each board may=
 have different values and it may need to use the correct value for the mac=
hine=2E

I actually considered this but went with the pragmatic solution to avoid o=
ver-engineering=2E In particular, I wanted to avoid further machine-speciti=
c attributes in the machine class struct=2E Or do you expect a new e500 mac=
hine to be added? In that case I'd set above arbitrary values as default an=
d expect a new machine to override these properties=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/mpc8544_guts=2Ec | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>=20
>> diff --git a/hw/ppc/mpc8544_guts=2Ec b/hw/ppc/mpc8544_guts=2Ec
>> index e3540b0281=2E=2E6688fd44c3 100644
>> --- a/hw/ppc/mpc8544_guts=2Ec
>> +++ b/hw/ppc/mpc8544_guts=2Ec
>> @@ -29,6 +29,12 @@
>> #define MPC8544_GUTS_RSTCR_RESET      0x02
>>=20
>> #define MPC8544_GUTS_ADDR_PORPLLSR    0x00
>> +REG32(GUTS_PORPLLSR, 0x00)
>> +    FIELD(GUTS_PORPLLSR, E500_1_RATIO, 16, 6)
>> +    FIELD(GUTS_PORPLLSR, E500_0_RATIO, 16, 6)
>> +    FIELD(GUTS_PORPLLSR, DDR_RATIO, 9, 5)
>> +    FIELD(GUTS_PORPLLSR, PLAT_RATIO, 1, 5)
>> +
>> #define MPC8544_GUTS_ADDR_PORBMSR     0x04
>> #define MPC8544_GUTS_ADDR_PORIMPSCR   0x08
>> #define MPC8544_GUTS_ADDR_PORDEVSR    0x0C
>> @@ -75,6 +81,12 @@ static uint64_t mpc8544_guts_read(void *opaque, hwad=
dr addr,
>>=20
>>     addr &=3D MPC8544_GUTS_MMIO_SIZE - 1;
>>     switch (addr) {
>> +    case MPC8544_GUTS_ADDR_PORPLLSR:
>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, E500_1_RATIO, 3); /=
* 3:2 */
>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, E500_0_RATIO, 3); /=
* 3:2 */
>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, DDR_RATIO, 6); /* 6=
:1 */
>> +        value =3D FIELD_DP32(value, GUTS_PORPLLSR, PLAT_RATIO, 4); /* =
4:1 */
>> +        break;
>>     case MPC8544_GUTS_ADDR_PVR:
>>         value =3D env->spr[SPR_PVR];
>>         break;
>>=20

