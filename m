Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3B9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRLm-0000mY-3e; Thu, 01 Aug 2024 04:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZRLk-0000lF-AP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:39:52 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZRLi-0002rp-Gm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:39:52 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70949118d26so4047324a34.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722501589; x=1723106389;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Wr2B2dOEpTz/1CmtRRsNDgEz7b/9NfuJSuefX3zklI=;
 b=Qjak9Hh4147IsqShKX1gI2gpTpX3wmAXfK1TjYagiOzZ0wWS5dlV4QlDLvpdXtwj/o
 +GWFBmnONed7Wq/bGqg8hkVTeq16Dsgci6LizkFmIPkP9iVVeklSSMSr7RXwqX9R9Vg+
 sbEkQDSUvxS08DkL7vkajIgLaBmbWHr1Kyw7lNA+6LZaKGZANHUa+HGuv1VvarDi7Tld
 KtlEwSLzEAyXN9xcdsFMU7EQMp7CzAfIxMIFvkCOxWv1YwQB9atImQr3EgGoXAVkjHkY
 5sB8qTBAQEHXqRv4KpaPaq9zKe+3ibvjxF5js7rQeqG1Rx3KeQqKrfAybo+ypPLf6MCL
 LH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722501589; x=1723106389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Wr2B2dOEpTz/1CmtRRsNDgEz7b/9NfuJSuefX3zklI=;
 b=mfrlgZshfiGv6PYbvZXQ0BiYGhrTDRhlN6Pf23KxJqAL+LY1m1B3aXMHc7r23gWCLu
 V5NAw5U93jOIjgXHMTtmM6XFzbRSkkXUrq8ZdljYk6OYARf+e+GSex9J5fDkdYGRs2QS
 56D34gJrx5Ix8EynwX4xYw3fHyoOs/okp5egTHnmrXYDXQ7Fu6engeWqFqE3f43vcwBV
 EiFehrOr0VzMKWz0rxR6RJSA9UClEJuTvS+AL5pu9kmFMMiUi6qxHHzIsPNny2gTG/7d
 x/8eN5rfiFj5MWKgFWL/tlyPbGE7zjYl/bP8MLizB8TkUq7iFmKSjlhb40h8Dz4hkdyH
 7QdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQNxAjJmFIHsr6UP4OgE+DraS934BcP2TxEdQWChLeDI2OvRdIHjRYA/NfzbziWqlu3BsZz/+e0m6t63Zpv9pvLoJiu5g=
X-Gm-Message-State: AOJu0YwGYFpGnfsrgwpPjiED6u26ipxcQDht9qAb/llcJ8rv1dWSPwEx
 eNJ7JQBV/fn3yXI9VODSwfYC/Eg54dZ0qS8lYfYp9QolwSAlW2PSuB9HFl0RXSc=
X-Google-Smtp-Source: AGHT+IGAYKoQk16KnWUrOwqi3zNyzTtHuYMB9ixbiciCw5LY5AENDJ8p9NDGiYVuZcgUJJSebWh8ZA==
X-Received: by 2002:a05:6830:2a9f:b0:703:b0e9:d951 with SMTP id
 46e09a7af769-7096b7d528fmr2170049a34.6.1722501589050; 
 Thu, 01 Aug 2024 01:39:49 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead87d58asm11410808b3a.177.2024.08.01.01.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 01:39:48 -0700 (PDT)
Message-ID: <6746a403-ce09-4dfb-bc03-d8b57aa4798b@daynix.com>
Date: Thu, 1 Aug 2024 17:39:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
 <87a5hyj71o.fsf@pond.sub.org>
 <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com>
 <20240801035118-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240801035118-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/01 16:52, Michael S. Tsirkin wrote:
> On Thu, Aug 01, 2024 at 04:01:44PM +0900, Akihiko Odaki wrote:
>> rom_bar_set() and and underlying visit_type_str_preserving() are ugly, but
>> we can remove them once the deprecation period ends. On the other hand, if
>> we don't make this change, dev->opts will keep floating around, and we will
>> even have another use of it for "[PATCH v5 1/8] hw/pci: Do not add ROM BAR
>> for SR-IOV VF"[1]. Eventually, having this refactoring early will result in
>> less mess in the future.
>>
>> [1]: lore.kernel.org/r/20240715-sriov-v5-1-3f5539093ffc@daynix.com
> 
> I don't know that this should worry us much. Is there some project that
> requires getting rid of dev->opts for some reason?

No, but I just thought it is too ugly to add a new reference to it for 
the aforementioned patch, circumventing the visitor code and the QOM 
property.

Regards,
Akihiko Odaki

