Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B68C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcW0-0001Zg-J2; Mon, 29 Jul 2024 22:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sYcVw-0001ND-I1; Mon, 29 Jul 2024 22:23:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sYcVv-00072N-0b; Mon, 29 Jul 2024 22:23:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3687f8fcab5so1759928f8f.3; 
 Mon, 29 Jul 2024 19:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722306174; x=1722910974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JdBHp9lpgX9d7tp+bmQGMt8Ej9jnlJjkVMDxsR7jhs=;
 b=LTMzMOh1XVdUJLJ5KFjcLMdkEMpNIgF0GRMWraOq0PByzsejja55W04SOdHzKBw0Z9
 W73yh8h++mWxxhGnV3Y8e4KeI53vEVe+vJooPiKwa0hIRcjVMGjOa2V1eVe671JHOEyz
 E/IKGVo49ADWnFtDr9G+OVFBnrmpZqaIHlzQyeK5twH9iW280DzEOwu1/6fEipSTEBHF
 vaGG0BCUgeGcPCmgKIaS2RNUx5O3As1rWtyAzmZx/ilw5YVxkj3yN07A0ijH2NEWEeDF
 ogMoACmWlJxHB5GJ9D6xgBvCvd5DrNm/aeijJLVzaLpldzyoxY5PzDzeETzFLnUQwR9S
 xTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306174; x=1722910974;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JdBHp9lpgX9d7tp+bmQGMt8Ej9jnlJjkVMDxsR7jhs=;
 b=eXGM5CAzsACcolf0bfrwh2qFWK2nxsGvGAxIWEGa/0y2v/ipRUTX4jgsLhr9ro1Ui3
 QVOmKPj+XtB3yhzMFXVDMCjuqD9nMe/TbzSzapOqeiGX/ObpEYpUsE0rU0KBv99hkAyN
 nrRUTT0M+oZMc/NqDj1lkkVR4c/h8Q4bSAhPIZkh6yqI9JywrBAY0Me5fqTjo/1CFraO
 vhR9AcEVh/ttiCbNaF8Tp7GuNLKUycAzWTvpoQMO7xsZiy8oaF0wyekULu043Eu/6Oiw
 sO7WUV/WtRnz7jpGboCOfx9NK3iupjctKiJttpDrod+0TnNE5uCOTQJcf9SSpIZU6HPb
 GI2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYOCsGagN7m9e8Fu6kcT2H5x4UX8ej90G2u9dGIQdqQUStGJ5FHXAGm2/ajZ2yOTXlGM3HOqwwQwE7s9EmBeRY4ZSMWMXGrmdc9baKeNK4vS1fjblZ08Cl4wUs1cAwirSwC94Xeqx/e3BvRHzLFCcZdA==
X-Gm-Message-State: AOJu0Yz4oynFg5M9AJDIO9swbT+uAt7daL1Gek0lXCpp+IJ3rXmCG0Xi
 xb7dnX2x2Vv+uZ2gEZsGDUBAE+8vIFj64OWL5ivaEWLmui9OtNeOr9VKRA==
X-Google-Smtp-Source: AGHT+IHPmwK10GW8rSmAb6oBJyj4R4EN4ji+4rccKeBoSU/xMINAxC24bddO8C0ZhAc+4HQVXOgocQ==
X-Received: by 2002:a05:600c:1e26:b0:426:5b84:86d2 with SMTP id
 5b1f17b1804b1-42811da946fmr65216725e9.20.1722287283185; 
 Mon, 29 Jul 2024 14:08:03 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf001b00951a078cd3412cc4.dip0.t-ipconnect.de.
 [2003:fa:af00:1b00:951a:78c:d341:2cc4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280f8da2f7sm122892195e9.10.2024.07.29.14.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 14:08:02 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:07:54 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 05/11] exec/ioport: Add portio_list_set_address()
In-Reply-To: <f5f5dfca-d60b-4b0d-add9-e41b42bd4ce2@linaro.org>
References: <20240114123911.4877-1-shentey@gmail.com>
 <20240114123911.4877-6-shentey@gmail.com>
 <f5f5dfca-d60b-4b0d-add9-e41b42bd4ce2@linaro.org>
Message-ID: <C0822DF6-EA81-48BB-9102-887E66441EF2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
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



Am 29=2E Juli 2024 09:26:19 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>On 14/1/24 13:39, Bernhard Beschow wrote:
>> Some SuperI/O devices such as the VIA south bridges or the PC87312 cont=
roller
>> are able to relocate their SuperI/O functions=2E Add a convenience func=
tion for
>> implementing this in the VIA south bridges=2E
>>=20
>> This convenience function relies on previous simplifications in exec/io=
port
>> which avoids some duplicate synchronization of I/O port base addresses=
=2E The
>> naming of the function is inspired by its memory_region_set_address() p=
endant=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   docs/devel/migration=2Erst |  5 +++--
>>   include/exec/ioport=2Eh    |  2 ++
>>   system/ioport=2Ec          | 19 +++++++++++++++++++
>>   3 files changed, 24 insertions(+), 2 deletions(-)
>
>
>> +void portio_list_set_address(PortioList *piolist, uint32_t addr)
>> +{
>> +    MemoryRegionPortioList *mrpio;
>> +    unsigned i, j;
>> +
>
>       memory_region_transaction_begin();
>
>> +    for (i =3D 0; i < piolist->nr; ++i) {
>> +        mrpio =3D container_of(piolist->regions[i], MemoryRegionPortio=
List, mr);
>
>Should we check mrpio->mr is disabled before changing its base address?

Isn't that the responsibility of the guest? What should we do if the check=
 fails?

>
>> +        memory_region_set_address(&mrpio->mr,
>> +                                  mrpio->mr=2Eaddr - piolist->addr + a=
ddr);
>> +        for (j =3D 0; mrpio->ports[j]=2Esize; ++j) {
>> +            mrpio->ports[j]=2Eoffset +=3D addr - piolist->addr;
>> +        }
>
>          memory_region_transaction_commit();
>
>> +    }
>> +
>> +    piolist->addr =3D addr;
>> +}
>> +
>>   static void memory_region_portio_list_finalize(Object *obj)
>>   {
>>       MemoryRegionPortioList *mrpio =3D MEMORY_REGION_PORTIO_LIST(obj);
>

