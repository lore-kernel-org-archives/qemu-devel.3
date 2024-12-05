Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D15DE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIci-0004ix-9L; Thu, 05 Dec 2024 15:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIcf-0004in-T4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:38:53 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIce-0005lO-As
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:38:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-215d92702feso11297285ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733431130; x=1734035930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LVNHTwjAp8TUuC2GjrGaXpL3eUxURvauVm5xfYBeYto=;
 b=iLjHTpZXulrlJsov5VSG9q1oRf6h3z5LmUEoxnrh2gDqZI/NzCaj2i7DC3uLZow6iq
 Uzfbktz9IQLjg4rxv9p6ityDdw+e+rPkFjYLci/dTVlNywn64o+7ML4IzN9iwWbau8Wk
 wLU78b1O4pUqL+MfKuxRjDMgG0tFu/1fMwa7ckoO9gZoetL+ssblu/9fLI4Y8/AmFrsZ
 IEPEoEBLBbLpw7iVVItInPCJj875jXCrPOaodr6+ej0OsfR8KJro77STNttbUGi8jmL9
 vhWqAEcJFxrB1mu6O7vBqe2zXmFypsIu6cMOzAHupAP7w0cuuwlyEzBKHRBSg3ocnDdg
 QgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733431130; x=1734035930;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVNHTwjAp8TUuC2GjrGaXpL3eUxURvauVm5xfYBeYto=;
 b=oYhb3t5GRlMC5iTCn67r5nXAXYW1xlhYbhmPgL+ABrtq87BMwVA3xyaX8RxnhFVsfX
 g68rcWxVG99IeNU/F2KFjleUT3aeOEBfYkMB9alAiBKpNUWTlC/KPsukLHRS5pYuL2Id
 jkw4MS8VT6Wwk4ROXD7y4SW2/5ymAp6py70TPOOz7aVKbu0cXmnnhjUyZzZgXk+qkAoM
 8DMHjI3BilNN8PNapiHp+/wkLLDplM9Qtj/w6zg63I8tTcCgRqnARJzrJyV+M4g2HLeb
 eaHSIsGQFx6qxk2BD7XC9ZxnYaAAhM4WfHdCxBLFuDj8ggytUH2KvCQ0IcRvZWeNbTUj
 yefg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4ZBrWOeMrUT4+oJHs6lsDaEEQExqzgyd8UsjILwLQpYT2Wevgbk9ZOQ3dx6Pj+cuEXby35ckh1JcW@nongnu.org
X-Gm-Message-State: AOJu0YxCb8WMjjWzJzDmdR4RlTSuO8EcubHLn8HmC1OUsCClGjP51Lqt
 HTUa/TWPZRUWlJrTx8bUbiHOxzsp48thUdS5Odxd7vcEOoGukPLX
X-Gm-Gg: ASbGncsGM6DaAqM/3MW5mwCv9UVUsD3lK3j7014O6w0DWcNzA8JfmxjurTQrFtaWqLV
 nT3bqegfBPtbYKCsXZuWNFXopHyi+fJOsFgonRfnYJTCvHV9T19M/OkZAmChTpk91rDyBRf0O/0
 pc9hT9qU9NSOJIxCVO1ZBAFMR+9dvjndWYmSOg1+oJHJLLSSctGZieICb1x/wuZSikkP2S4wJ6E
 vMsoAhlbbnTJev/F+T19s/SHfJwx9FDWehub4aZ2sdHH+tqxknHcV/2XtA1vaL9Y0M92kz+UvKk
 rzGW7jI9cexjiBrJ
X-Google-Smtp-Source: AGHT+IHkwFSGfzIegjbfCSJlHmjeLCoiRjO3yzr4OAGrOGS0lkN2/Ev++8zDUN/xlJp9VHacrdv72g==
X-Received: by 2002:a17:902:c407:b0:215:b9a7:5282 with SMTP id
 d9443c01a7336-21614d4b68amr4738295ad.26.1733431129661; 
 Thu, 05 Dec 2024 12:38:49 -0800 (PST)
Received: from ?IPV6:2409:4081:2c01:b2be:f39d:e902:7582:5526?
 ([2409:4081:2c01:b2be:f39d:e902:7582:5526])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f31838sm16547705ad.263.2024.12.05.12.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 12:38:49 -0800 (PST)
Message-ID: <6909a543-872a-4b92-ae6f-53a605317974@gmail.com>
Date: Fri, 6 Dec 2024 02:08:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil Siddiq <icegambit91@gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <3311761.aeNJFYEL58@valdaarhun>
 <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
 <1904291.tdWV9SEqCh@valdaarhun>
 <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
 <89ae0aad-eb82-4f51-9384-689a19e1626d@gmail.com>
 <CAJaqyWedOSc-jm5DnxyPNfmFNcuxnaUNt3jK6MoKB+Gyr2ZQ+Q@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWedOSc-jm5DnxyPNfmFNcuxnaUNt3jK6MoKB+Gyr2ZQ+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x632.google.com
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

On 11/13/24 5:00 PM, Eugenio Perez Martin wrote:
> On Wed, Nov 13, 2024 at 6:11 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Hi,
>>
>> On 10/28/24 11:07 AM, Sahil Siddiq wrote:
>>> [...]
>>> The payload that VHOST_SET_VRING_BASE accepts depends on whether
>>> split virtqueues or packed virtqueues are used [6].  In hw/virtio/vhost-
>>> vdpa.c:vhost_vdpa_svq_setup() [7], the following payload is used which is
>>> not suitable for packed virtqueues:
>>>
>>> struct vhost_vring_state s = {
>>>           .index = vq_index,
>>> };
>>>
>>> Based on the implementation in the linux kernel, the payload needs to
>>> be as shown below for the ioctl to succeed for packed virtqueues:
>>>
>>> struct vhost_vring_state s = {
>>>           .index = vq_index,
>>>           .num = 0x80008000,
>>> };
>>>
>>> After making these changes, it looks like QEMU is able to set up the
>>> virtqueues and shadow virtqueues are enabled as well.
>>>
>>> Unfortunately, before the L2 VM can finish booting the kernel crashes.
>>> The reason is that even though packed virtqueues are to be used, the
>>> kernel tries to run
>>> drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_split() [8]
>>> (instead of virtqueue_get_buf_ctx_packed) and throws an "invalid vring
>>> head" error. I am still investigating this issue.
>>
>> I made a mistake here. "virtqueue_get_buf_ctx_packed" [1] in the linux
>> kernel also throws the same error. I think the issue might be because
>> hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings [2] does not handle
>> mapping packed virtqueues at the moment.
>>
>> Probably because of this, vq->packed.desc_state[id].data [1] is NULL in the
>> kernel.
>>
>> Regarding one of the earlier reviews in the same thread [3]:
>>
> 
> I think it is a good first step, yes. Looking forward to your findings!

I faced a few more issues while testing my changes. Instead of explaining
the issues here, I thought I would explain them in a new thread along with
the next version of the patch series in case that helps with troubleshooting.

Thanks,
Sahil



