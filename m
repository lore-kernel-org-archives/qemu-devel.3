Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A96E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLP84-0006xT-GP; Wed, 11 Dec 2024 11:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tLP81-0006x1-4n
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:59:57 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tLP7z-0004RF-CC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:59:56 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21675fd60feso25349695ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733932794; x=1734537594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=u2ApCL4hWQL+lKZ8HvyNR5ClS9vcIdzXpgj1lOxfSUE=;
 b=A/73A7sGkYNLALk5crRjClO5CCJLkH1HGtowAXHljktWn9cxgHph+WUtqMF3rmEHOP
 aySJKTc1AaavT8e9td1kB9lzY7inp6ifT1PlAvH/AU8kUmUqxWoOxTuJrsVKPlzz4HEK
 lJEIwp13vAUZSQ5hP+SizOAvpzG1rcgAeqpxXNDfDMgP9wrgOJsiyOru37FU1sP+Yvrn
 iBI8bWc6RKYZx5BtL9cVDQpMvb84ITg6FLkLubALs+4RMQu3XxXNT7y3iK1Do3i8HSgd
 N2D08UKLLGUQ4kIRiTskyi4UFB0qxX7PztdvDRCFqE3kvqp1w+qSFPBWFwumKsEJymOs
 ug8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932794; x=1734537594;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2ApCL4hWQL+lKZ8HvyNR5ClS9vcIdzXpgj1lOxfSUE=;
 b=eOlc+wyIswARf6Z1bWAF8LISKGxsjj5JOitZWm+ooH2Mja/l9xgiKx2QzY8pePOL1N
 KI0CK+plTLnV9H/GD/PTlbYsb9I+0A288YBe5JLxDXAAJH28UpxeCetBfj8M8nfdbEDl
 kb8R+qvUzdow13eOqZKFJgH4eum2l8uHDTsa0Gs48u7xfQYiTkgAiad3AELk7ihDGKh/
 HQdLBOrMqSqSRoQdzrYkI2Dx0c6y+zRDxazBVtaIbhsnLircvbCpd1v8jcw1rJwlseit
 XYzXakWfZ5mWSf3F8Mt1Fvo183Y3I18NlmFR7kARQ6aVCH7ENDs+h7dtMt9disCL+bGw
 voKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtzkpF+P9uVbhVizs5iWBFbgtUo2iv+mj4CGfFD4BzHce+1Awg72IWOxYRCHyD3epaKZ/bwDMKc5au@nongnu.org
X-Gm-Message-State: AOJu0YwijDIp4L/efhvvNWl8/zJ+0ANXPydF8LuDGV5xEkdXBAjkNFwE
 siaA3ddjIe1ngenXpvPW+Sjq8HasYHxfnpJ8gfJcou3FFn0R81bN
X-Gm-Gg: ASbGncs1M9+Rf0LhfOAaqLy9d03NyrjnBLxJA4lxRPQwJcIzINiDCquPhd11N5xVax6
 q84q0E1Cs12LJ8zEAn++Lz6EeRvKiVLBYjtfSGyuYFJ8yozjdGrULoEnkjGT7UvX2UrnRSr25eY
 gC4M8nm7jVro4WFKfldVDwz6GMUSIAMw2fLdv8fLxxQxbAQaNisTfhTqZtFH5w/fDqZYHFHpYRF
 u9Tz1n70dOXsz8qXglFno2+
X-Google-Smtp-Source: AGHT+IG+g9PIgL893WCCvo4McS/ll4kfINyZ1GTsPx0OZiC8dZTGMux+9sTpItpvzFFPafzuy2lXaA==
X-Received: by 2002:a17:902:f54b:b0:212:5786:7bb6 with SMTP id
 d9443c01a7336-2178ae5a009mr4240345ad.3.1733932793925; 
 Wed, 11 Dec 2024 07:59:53 -0800 (PST)
Received: from [192.168.1.18] ([223.233.86.194])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21674098305sm30811405ad.122.2024.12.11.07.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:59:53 -0800 (PST)
Message-ID: <d829d4e7-5a52-4eb4-95fa-82296c71524f@gmail.com>
Date: Wed, 11 Dec 2024 21:29:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 3/5] vhost: Data structure changes to support packed vqs
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <20241205203430.76251-4-sahilcdq@proton.me>
 <CAJaqyWfBpyJAwv2m9r0ik_pmoN2OSJvcvSjYuq_vPAXSZP138A@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWfBpyJAwv2m9r0ik_pmoN2OSJvcvSjYuq_vPAXSZP138A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

On 12/10/24 2:25 PM, Eugenio Perez Martin wrote:
> On Thu, Dec 5, 2024 at 9:35 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Introduce "struct vring_packed".
>>
>> Modify VhostShadowVirtqueue so it can support split
>> and packed virtqueue formats.
>>
> 
> This patch should be before the previous one or it does not compile, isn't it?
> 

Right. I missed this. I'll reorder the commits.

Thanks,
Sahil

