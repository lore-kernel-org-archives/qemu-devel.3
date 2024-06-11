Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78227C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0S7-00073r-DU; Tue, 11 Jun 2024 08:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH0Rr-00072P-U0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:17:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH0Rn-0006A5-NJ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:17:57 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe6392eso8154434a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718108274; x=1718713074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JbOttmsMh9Ndwkesc+TbbULpmiFD9C8jwdEacYx8YaQ=;
 b=FZtJixbLJECOKGMoMRstlU3nFZjhi6zS6HwiQgMhskwh/Y8AYZ/XHyeMnxy7qg71rg
 Q6TFK4OVybCxWy04oj5/8IC5poiZJjVhLOC4ZXr/YBxCb9LEJI+DOlWPLI8oHfI3Na6a
 g81EviEBHS5ZySWrptqTutM/7O4f22IabYaZS8vqogAnwjZMjMVN6UJe+5+/p2M0pcnG
 ERwyRjDlXg0rXHqWIrctQcpfZzkuj/+exCYxQd/TK9cS/jYGzqvS0ZG34rTMIrnuz+Qo
 LN5oUGn4RQ/O8OoGDExLjO2THnny0gzhnMJlvQq37whuU6SMVkQ210d6L/L+fThTNwvi
 d/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718108274; x=1718713074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JbOttmsMh9Ndwkesc+TbbULpmiFD9C8jwdEacYx8YaQ=;
 b=XF+DWe+oN/rLPzWpOpWNZxN4k06z8IoMxozAyZJ6Y34OxBhXGah0252G0bIz7jhqD1
 hE+e7QliMlJR+t1rw/MC1FRmJWZLj0g08FeopzFDASf4AfA491ObrhlrGJu3Tb4Dk+1s
 0bcEV2vQ1w8nipIoowdecERHsZS8+xo6nTg9nw4eMnP+57lOsfos0QaiixAf2aGXc41A
 nbpn1Q6pKITDt8jBZ1aYXovQFsLnH6oHo+IGBdlaiSbih89lCDWZ2/XrQSmN/zPoLKIq
 ayKIF3w71YaQuLW/4eVq5gso2mf6vP7PXZRsP0Liqn6oIzQcBX/gasUwM95d2bwIMyDp
 XkpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVy+12B9DIBdGdxF1HT9ZN2eG+yJ9m6rO4Jp4848ohrpVQuq3yVnHF2sGG8vD7CitqQc50IYCaTGeSZny6lCW4yuPY8Dk=
X-Gm-Message-State: AOJu0YwcNFKJ+/HYnFzjapL3Crrje/KosqZQOXslhdSVdX28zz79LHVl
 NqejrSEhjNWtF0eNWFkj8rIsa5jzzOwaaz3PlDO8Lo/OOBqLYI4X3qZnoUZBDX4=
X-Google-Smtp-Source: AGHT+IH8JEmJ9q94Lo3tFzJ5X6TeIVSjGRcEWkCltLTak4zCVGYX1CJpA5FaVVJAwCxwRjrKT4soKQ==
X-Received: by 2002:a17:906:3bcc:b0:a6e:9dab:14f9 with SMTP id
 a640c23a62f3a-a6e9dab1584mr589473466b.10.1718108273918; 
 Tue, 11 Jun 2024 05:17:53 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6effd5bfc8sm451914666b.2.2024.06.11.05.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 05:17:53 -0700 (PDT)
Message-ID: <abe29495-2890-4817-ad8e-229956589e4a@linaro.org>
Date: Tue, 11 Jun 2024 14:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/audio/virtio-snd: Always use little endian audio
 format
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
References: <20240422211830.25606-1-philmd@linaro.org>
 <63f58487-682b-4f12-b15f-7efd2fddc753@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <63f58487-682b-4f12-b15f-7efd2fddc753@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/6/24 09:15, Michael Tokarev wrote:
> 23.04.2024 00:18, Philippe Mathieu-Daudé wrote:
>> The VIRTIO Sound Device conforms with the Virtio spec v1.2,
>> thus only use little endianness.
>>
>> Remove the suspicious target_words_bigendian() noticed during
>> code review.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Ping?  Is this change still needed?

Since Michael reviewed the patch, I'll queue it via the hw-misc tree.

Thanks!


