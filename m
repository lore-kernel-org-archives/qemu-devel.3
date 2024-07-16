Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFB4C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbyq-0004wv-00; Tue, 16 Jul 2024 02:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbyo-0004qd-8s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:48:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbyl-000785-V7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:48:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb222a8eaeso34954325ad.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721112482; x=1721717282;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2rKzOEm53dFvzdf7Cei6moIsvCWVyO0dZCkwWOeMnA=;
 b=oZ2XfuVb0ATjA3HEMk6sYLNJ+R/ft/FLXjSd1C1cCBprGV3uT4avC4H7pMN6dyrwbu
 MBE/qPGrlIBc6857Rgcl3E1x7HG2XKSjLgtK+4QYkEfKA2l+OdBo9JXYRL958P0dwSyy
 OxWe904z8OyJoJavHLfy04sGNruVJWqKtPI08NtfKmUC14D4TKttJm7KRN7h6thRgqQW
 QEviOTZA1QF92Oju9M3oZPrtWwXDDCi/DMeKd1USWmQIgEzulrUk9Tdtb0TKLd6gD0o1
 wQwXHpXuv9KYCQSV6eifTLClFVD5xfgFP8nOxbJ66B07pnguvDy/XWoQq3+X+8tbBYg9
 4urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721112482; x=1721717282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2rKzOEm53dFvzdf7Cei6moIsvCWVyO0dZCkwWOeMnA=;
 b=LmEMy17dNCT6TMjnzNKdRYCYvc6xFMVIAArxUIxEkjh7HAWT5jmpRm6BiJ3vk5+XJO
 1SfAlubH0qHIsn+rg4paCz/T1HysFVDtg5O2kzLgJ/14Tsm+WzUJGUpcsvDaEdn0OtiX
 cXmaYecDKSGvo6O6+veH6QjWu/HNCg3fI2h2j3kpaPKxiMvLYC+V6PmIY2h+h501dtuO
 TvhNDk/ts5Zei+1vQWhRlECBoVaIXL7COPFuYL2wtla1InXDTEBa58JIn34EMDD+Yrdq
 bfde1DHVEw45iNgUOHpG90M463FPhnaV2F8Bm5TsvLN6g98UM/hU0tvhmTYmb13sfghA
 tDnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV8Xc7U8I5QAPG3iF/N9FlhDAKc9gHgZtwH9coj4omniFJGW9czEhHumDE92YrKqPopomfFtQuxEK1aM3kDYxqmb0iVes=
X-Gm-Message-State: AOJu0YyP4eGK2zFJg171aSRmGltWoJRXuHmr5GQo/T45hNfuO6LhnAZN
 W8jRQDahd3/bot4Hs25Gf9mMBMMOOoafzbz1GAIoN+kkqtaPBjBRM7SB0zSDYLM=
X-Google-Smtp-Source: AGHT+IEQ7wFYP5j+D6k0vGhnD9wFE1/YzZXqoYULHe62jByfoqF4W9MifdzvbhBmA+5ZOtYUdEgMAA==
X-Received: by 2002:a17:902:db01:b0:1fb:31c7:857b with SMTP id
 d9443c01a7336-1fc3d9210cfmr10618995ad.1.1721112482255; 
 Mon, 15 Jul 2024 23:48:02 -0700 (PDT)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc468b1sm51117105ad.260.2024.07.15.23.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:48:01 -0700 (PDT)
Message-ID: <6c65537d-ee67-4e0f-9f76-3da2b2ef8c71@daynix.com>
Date: Tue, 16 Jul 2024 15:47:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hw/display/apple-gfx
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, agraf@csgraf.de, graf@amazon.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, lists@philjordan.eu
References: <20240715210705.32365-1-phil@philjordan.eu>
 <eca02ec3-e2f2-4994-baf5-b86908fa0418@daynix.com>
 <a7087230-9fc6-4ab4-b35c-d3df032d16df@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <a7087230-9fc6-4ab4-b35c-d3df032d16df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

On 2024/07/16 15:38, Philippe Mathieu-Daudé wrote:
> On 16/7/24 08:07, Akihiko Odaki wrote:
>> On 2024/07/16 6:06, Phil Dennis-Jordan wrote:
>>> Date: Mon, 15 Jul 2024 21:07:12 +0200
>>> Subject: [PATCH 00/26] hw/display/apple-gfx: New macOS PV Graphics 
>>> device
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=UTF-8
>>> Content-Transfer-Encoding: 8bit
>>>
>>> This sequence of patches integrates the paravirtualised graphics device
>>> implemented by macOS's ParavirtualizedGraphics.Framework into Qemu.
>>> Combined with the guest drivers which ship with macOS versions 11 and 
>>> up,
>>> this allows the guest OS to use the host's GPU for hardware accelerated
>>> 3D graphics, GPGPU compute (both using the 'Metal' graphics API), and
>>> window compositing.
> 
> 
>> Hi,
>>
>> Thanks for continuing his effort.
> 
> Yes!
> 
>> Please submit a patch series that includes his patches. Please also 
>> merge fixes for his patches into them. This saves the effort to review 
>> the obsolete code and keeps git bisect working.
> 
> Should be as easy as squashing patches 1-6, right?

The cover letter says:

 > 04-13: These patches address issues identified during code review in
 > the original e-mail threads as well as my own review.

So these patches are certainly to be squashed. There are other patches 
titled "fixes" or "refactoring", which should also be squashed. I expect 
squashing them will reduce the number of patches (and code to review) 
drastically.

Regards,
Akihiko Odaki

