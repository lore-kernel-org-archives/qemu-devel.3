Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B28DC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQAP-0008Oh-9N; Wed, 26 Mar 2025 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txQAA-0008IK-VV
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txQA4-0001jE-TI
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742993225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/TMFxF2KrGzc39LoUIUVav93WBHkkOMZ7yf52Ayhsus=;
 b=M6wYpmRVas+U+FdXYY2X9mKTosa0UyRODZf0jqZ+qzRESQALa7stmTWpGGvTLaSC72InSq
 uIW+KEaKn8CdlZn6rATGKvyfFs+TuRLgxwuq7doC6AH9ckSX7TTLtUZgRiauJAeZ794rpM
 x6ji4oTdo743J7BoCMEzYUcGdVXrhs0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-6OSrai_2Nf2lIVoE6YK3xQ-1; Wed, 26 Mar 2025 08:47:00 -0400
X-MC-Unique: 6OSrai_2Nf2lIVoE6YK3xQ-1
X-Mimecast-MFC-AGG-ID: 6OSrai_2Nf2lIVoE6YK3xQ_1742993220
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391425471d6so347184f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742993220; x=1743598020;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TMFxF2KrGzc39LoUIUVav93WBHkkOMZ7yf52Ayhsus=;
 b=NVVnbNMA+8KJQZdpvN+Au/Ga/5sJwia07rerjy5/WSQZIPOlBmE73emUGV/+NnPxUu
 jbmDE/JPBCHZv362Vnq0z6Gv+mIE9ekjgltBuvOpirq3tZl1hFn4/PwmafVjxCHAjkSM
 jNXQ9+BmfMmKMmiqdwVzuTbgQyZ7+17velhYx+DA1tOMPlh4MOuQHDreYmg9KdRaQ4xa
 5gVGnw7Fz1kErIYstJ6ro4LsgvY+1hkTsG7YKxOj796AfQphLcZLqihjNjUXyZZ1v/sp
 ylPNZJV7ws5/iVilFvsSriIiIrIhSz66wUu3pkvrfhwFAKQFw1cGBBC7Rx0BCJgSQS/W
 ZVBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQcnQQ0O0TBzvuvhoCRL9sUid+mwaWCjFSj9OLe8GPyc5ivHBn/12tJaqsz47KkyH/saf37r9lDbUS@nongnu.org
X-Gm-Message-State: AOJu0YwJZb9e1475KsVpu+FxZAjkkBAtp1FwSNVE4RDFfM/R2GoJhDVp
 SdX+FdVlWRkoPXxIXvo0hmNMfWSYm/ueaiDdV0CbH3W/nQBNduZavvoztMF8dCSI/ujRENMfQp2
 aDrrzBWyprNWxhVSVoTquL8mf7H2a0/6aFyn900tgHv7uE3NoFL9kco+K+DvW
X-Gm-Gg: ASbGncvrrbAJa/u5G5uaUVcla70Pcsxa4XP2FYASuWXE6b/z52XywxB9y0V5WldkqDx
 gfyJQqenxbcPywrd1wXhDS2x3PZrlddS3aCYrsH0jR1Vm3Q519xxwOtaR9Hbd2Q7iV1CNIT6cR3
 emJceYauxnglG8hDLN+8ba5EQy4s++DBIe2U3iKyMuHs4RccnbvuCfzG9VcmP6EODzDfhMnvxm+
 XorpqZvOmNRbwoqeLmsLrKv8sbYYbfdrZutqgncpNU1IPBM79JZmNoOdghvypXUMvGi5DaS50MC
 Yk6QfFJoMtWCmlDH3Ydqp6y5RFafoTPyJam8JjZxYHjOZLA=
X-Received: by 2002:a5d:47a5:0:b0:390:fc83:a070 with SMTP id
 ffacd0b85a97d-3997f8a4e9cmr17526328f8f.0.1742993219624; 
 Wed, 26 Mar 2025 05:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDatqG6oJDMVvOdvnISoit9hzYR0Z7dy4gZRRS+tbR3AWmqNHkdNW4IdCephlnyaqMUCekGw==
X-Received: by 2002:a5d:47a5:0:b0:390:fc83:a070 with SMTP id
 ffacd0b85a97d-3997f8a4e9cmr17526290f8f.0.1742993219140; 
 Wed, 26 Mar 2025 05:46:59 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-49-206.web.vodafone.de.
 [109.43.49.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b4cd3sm17157088f8f.57.2025.03.26.05.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 05:46:58 -0700 (PDT)
Message-ID: <a453429b-2c7e-4ea9-9b36-278fd0fb611e@redhat.com>
Date: Wed, 26 Mar 2025 13:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 01/12] hw/audio/wm8750: Categorize and add
 description
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250325224310.8785-1-philmd@linaro.org>
 <20250325224310.8785-2-philmd@linaro.org>
 <892797b6-8d2f-4234-840f-e36ef94b0701@redhat.com>
 <befafa24-f2a5-4c7c-963d-4ea89e44fb69@redhat.com>
 <205e31d4-9dc5-dfec-f012-94b3ee9dfa2a@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <205e31d4-9dc5-dfec-f012-94b3ee9dfa2a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/03/2025 13.39, BALATON Zoltan wrote:
> On Wed, 26 Mar 2025, Thomas Huth wrote:
>> On 26/03/2025 07.47, Thomas Huth wrote:
>>> On 25/03/2025 23.42, Philippe Mathieu-Daudé wrote:
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   hw/audio/wm8750.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
>>>> index 8d381dbc658..6c1bb20fb75 100644
>>>> --- a/hw/audio/wm8750.c
>>>> +++ b/hw/audio/wm8750.c
>>>> @@ -721,6 +721,8 @@ static void wm8750_class_init(ObjectClass *klass, 
>>>> void *data)
>>>>       sc->send = wm8750_tx;
>>>>       dc->vmsd = &vmstate_wm8750;
>>>>       device_class_set_props(dc, wm8750_properties);
>>>> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>>>> +    dc->desc = "WM8750 Stereo CODEC";
>>>>   }
>>>>   static const TypeInfo wm8750_info = {
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> Looking at this twice, I think the patch is not OK in its current shape: 
>> The wm8750 device now shows up twice in the output of "-device help", once 
>> in the "Sound" category and once in the "Misc" category (inherited from 
>> I2C device). That's somewhat ugly. I guess you'd need to remove the MISC 
>> bit here to clean that up?
> 
> Maybe we could add an i2c category for those devices? But in this case it 
> fits in multiple categories.

I think we should aim for the most specific category only. For example, we 
also have things like "usb-mouse" or "usb-tablet", but these only show up in 
the "input" category, and not in the "USB device" category.

By the way, it's somewhat weird that we have a USB category, but not a PCI 
or I2C category ... maybe we should rather get rid of that USB category and 
classify the HCDs as "controller/bridges" like we do it for the PCI host 
controllers?

  Thomas


