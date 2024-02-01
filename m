Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6E9C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVULB-0002il-2i; Thu, 01 Feb 2024 05:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVUL8-0002hM-8A
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVUKr-0003ys-FG
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706783420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5MPNvRHq27VkvBvnEcCVnjWWbmBAXdW0hsbssfeswuw=;
 b=Xh/j5Z/lWtur/wTbEtUfnOtfIh6vD2daBBXqYD1Mu+OqjTlEc0LBTtt1OytNy4yMbq8hy3
 JagKNzyACc+N9LPgD9relXE2SpUhqADFVPItt+ichx4JHaswpJ32aeHeI12UolbXO9oUBt
 HqRKXUNuw4G4gX8gWhokcz/6XQ7s374=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-ab575PYNPbOrj8MzqJ3-XQ-1; Thu, 01 Feb 2024 05:30:18 -0500
X-MC-Unique: ab575PYNPbOrj8MzqJ3-XQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33aebf85ce9so292671f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783417; x=1707388217;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5MPNvRHq27VkvBvnEcCVnjWWbmBAXdW0hsbssfeswuw=;
 b=EOKmZ0p6fc+azjA40scuZaz/WAwEjlUv7EjEXDHvjDxqzTk1dsHzhCeYspnHMn0LAU
 kU4P7XgsTptyFiznAwK4diwE3sRLkAw69rjMw0jsVtk1SDDPZCjWcguYyIYc2PvsBOdf
 guYQ3h3cWlRfLb+oiPGU8ObYeGj/3ML6ajmcPdOqOaTqqKcytNkjltS97zR1FmAnjIXw
 KrZn16LSneEQSu7vFh+ghdhjHnYygswK2kWZaI2OGuogHLB8y40kG1j7loXuCOxJFFm9
 I3Ex3SosK+f3flHGDqiatjGlWv3eJw+hJ0d6TtRTFscl+gPDaSMtTVz6cHbnmJg5pOxT
 L1Qw==
X-Gm-Message-State: AOJu0YzhU+/EEJ9GVR9FOedzyYGvfl+5IUJoUuP5yU/CXoShr39eUEvH
 OwxmpjhCPNdOG+JOWleHI20W8PYA29sLeN5kywzp8W/Nn7rsr/iWBUWoyiEQvw9TEhYDQFaubM6
 086wr9j4fcsoekNa76HR/p62AX0gtI/fQq1RVxvSs4I+sKcT9rRUu
X-Received: by 2002:a5d:6442:0:b0:33b:eef:86bf with SMTP id
 d2-20020a5d6442000000b0033b0eef86bfmr1690202wrw.25.1706783417552; 
 Thu, 01 Feb 2024 02:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo5S+2cwkCikaslb/1z3M+gJFkKX7H8mytW510M6D1faAPKJ20hhoTUFMS0uyEfPPXaGuByA==
X-Received: by 2002:a5d:6442:0:b0:33b:eef:86bf with SMTP id
 d2-20020a5d6442000000b0033b0eef86bfmr1690184wrw.25.1706783417230; 
 Thu, 01 Feb 2024 02:30:17 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXdHQaq7zsjEx0zSLqyP2iiquC+YjO+KlEWQ/C65QPrBLe8eq50T4wzibAGbh+br7rQ/H67TKtlUtstlc4pnukzboeruUHcBzR3f/auKalhZKFTk1PSMsFoLvzLubuKi34v7MdHCh5LhwkpNbDuYtYOZY1IzR1x1hrq8GP2oCNBlneRaWYYFIykY0N6HQFCfXf/toLT2deWPh6mAMf7mMbXcdEq1XBNKE2l8vcUA2NS8ODdldCiPyN/DsgTq0yHjGKkKc9LYy8/krMW+I2IDksUpGGewxtZpoDsjJFEZpWyLPoR5MFLYO+hSiINtDmQct23rM8f1FlJFeAmi1ux9UA5VwXQOiDN+7bZtLxmF40yDeKElkTfilMeykVmo1VAdAECkZ8pDsVUr/LjEzifE5SQe2Ci2l6X6UBSUj/PYAPfJVMLDozw0hkff1Bq2BF/euKBdsMSG5aVQ0n6V0bU8tbySnUPC/eF8AVhfwNJFrW+tTc4ZSiOeZyvO0Cgm5ciAot/+NvomqQYGfsjNIwhCWgXsGHye+VLwoXh0yX/LYTe7XZBHPAH/lhU0I3h+3pHY0f5XCpTbfJkJNfWIF7Mg0FOHd3OupMoJShaDol062zPeKVhHu6InR2oAESPhooZUxpDdCHNNhVro9VTNKajlWHt8Sc6jCyzTHeVr4QC0u3JJ7jO0RMszrKL9fScSIEuje9ThAyAQyt8L0aUQ5ZOLX85WuwxEf2pgJDPU2uPDeWkaEpambdhw2do50ATCpgrg+RbgeozlBTUL8ZMeWptai6qJqUavRkW53kaYlZhqPH3zpQz6oC/ARX8aTtT2UCuCMvTAp/NTcuzp4TXmCdqV6rmJYd3HkNk9hS2pONNDs/GbuJfe5mHsGs4na3y0cBTs6O+lEkmLqh+msYAiFM6Pb2kPM0DoMcE90AKzJESijgivvz6la4f5bkpyVNiGLf+JwA4P6
 Ef/aeqMQwX9VscshG6QUFSnvRlkjYikH/dAtkyzxgD/ts3xGVAVXXWu9SS16SJG/zWOJ0L4NbcNuUlZZi3skNXc56fsijqNEenFSWM4NC6T64Lv6Lls0GpNMXZcUh8w7zRfp5a9C4Zsu+3+odU4m+a1u0fvvCpsYGdynIrHLUFakO6EvhpwGfOr+26wZ6v7ewNlOrfzaq10zyNjaJJcDvjdBZMeYCOHTxK8zhnZXL4H2J4QtHH4/TyzDibsVDHojJnUuXMiHYBLIflcpdXyf/QM7Zjab3caKuylM59Rxfw1kiqUPC4E1zhNFTDDZLkWCF+mnQarNnVwjsqDE6KaZIMVgCIjQdTGKhJK0pGBlexMxrXOFrrqCT+Rg3HUpCZWA9pcgVdFm5wTriDURNseRI5Oz7elOCmvx80Nbg+2E2C4D+T7iJw5/4v23P0tboe6j+Er0xIKSe7MU/MP5kR5nv0XsnSitrk2XYoVeAOx3f4kP3WlMHHrAfkH+Ot8ObVDsHYGH/cA8jzf9hDHBesItNtSnpvVswKpWvf3uYWjqQA28bc/ybtWNp7igYvGp4t41T+wIbpJT1EVYF2i3Ktms+02ltAvsWe2qrY5uAHNfDI7p+VyXvnNRiDn+zmieKZs2Dh1BxjbONpbCmT68yObtkGU+lS6NjayQlYgCuB4Y6Qz5xZ0hHqwt11xaD0ebzwmZ9EnsMZXJgL7sAzfcJbpcBk/BhiEUekz4FywoXJCa/O8RymeGrfATiGwFnILwzbsXWnILfr5f0itqxGKY6cxJlxot8jkCRY+ndXn0x91lcgv9UXtzKmzW/StImMN5oOfEpuppUpufk=
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 ce2-20020a5d5e02000000b0033af4848124sm8905187wrb.109.2024.02.01.02.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 02:30:16 -0800 (PST)
Message-ID: <1f75bdb3-7a87-4699-bb4e-9608e291c887@redhat.com>
Date: Thu, 1 Feb 2024 11:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 33/47] hw/m68k/q800: use qemu_find_nic_info()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song Gao
 <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bin Meng
 <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20240126173228.394202-1-dwmw2@infradead.org>
 <20240126173228.394202-34-dwmw2@infradead.org>
 <a71dfb65-be10-409f-87bf-fa4e71253b41@redhat.com>
 <07fd91de5e438409aa6473caa18d3aab8a13c444.camel@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <07fd91de5e438409aa6473caa18d3aab8a13c444.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 31/01/2024 15.18, David Woodhouse wrote:
> On Wed, 2024-01-31 at 13:18 +0100, Thomas Huth wrote:
>>
>>> @@ -386,14 +382,21 @@ static void q800_machine_init(MachineState
>>> *machine)
>>>          * 08:00:07 Apple
>>>          * (Q800 use the last one)
>>>          */
>>> -    nd_table[0].macaddr.a[0] = 0x08;
>>> -    nd_table[0].macaddr.a[1] = 0x00;
>>> -    nd_table[0].macaddr.a[2] = 0x07;
>>> -
>>>         object_initialize_child(OBJECT(machine), "dp8393x", &m-
>>>> dp8393x,
>>>                                 TYPE_DP8393X);
>>>         dev = DEVICE(&m->dp8393x);
>>> -    qdev_set_nic_properties(dev, &nd_table[0]);
>>> +    nd = qemu_find_nic_info(TYPE_DP8393X, true, "dp83932");
>>> +    if (nd) {
>>> +        qdev_set_nic_properties(dev, nd);
>>> +        memcpy(mac.a, nd->macaddr.a, sizeof(mac.a));
>>> +    } else {
>>> +        qemu_macaddr_default_if_unset(&mac);
>>> +    }
>>> +    mac.a[0] = 0x08;
>>> +    mac.a[1] = 0x00;
>>> +    mac.a[2] = 0x07;
>>
>> Don't we have to change nd->macaddr.a[0 to 2] with this hard-coded
>> MAC-prefix, too?
> 
> I don't think so.
> 
> We either get the MAC address from 'nd' if that exists, or generate a
> new MAC address with qemu_macaddr_default_if_unset().
> 
> Then we override the OUI in the actual device. We don't care about 'nd'
> any more at that point.

I just double-checked, and yes, you're right, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


