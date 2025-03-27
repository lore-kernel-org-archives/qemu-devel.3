Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B36C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txsDe-0007uq-5k; Thu, 27 Mar 2025 14:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1txsDb-0007ua-Nv
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:44:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1txsDZ-00060G-LN
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:44:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso26655465ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743101079; x=1743705879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ssfpK+FNUKOPlvCbQKHWKMok5KI7rCFZqT41M1izfpw=;
 b=L89rr4B2ELyhrjR5kd6pEQshtGZ46hUVGsjcfZW1yrrzIFUJFjs8577EMUz/ZKnB1V
 IHODGPVRpggUGKtpJmWU4t+JznZFQhQ6bLbRN5zkxeqk/GYlnpek/T8tYf4+AEx7UEF4
 Ol/oR3HGXR4iXuyebb6/lSVwR5U1i/Y1rZbFu9VxKOn3iiOtgGsIizvV5kzBYp2diyEZ
 nxey7q587mA2RvI3gCRKucDGtQ712hkhn1tM+0lqPBgyUfIiy9dJ8jem3wFtqKc03PQT
 6DE2IykwZogSEnmWcciNRcfkc2pf/SL8GMdQsncAzgApWB6HulN0wwQakmd5N+pvT1R4
 Qkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743101079; x=1743705879;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssfpK+FNUKOPlvCbQKHWKMok5KI7rCFZqT41M1izfpw=;
 b=rFEoR71JoRnbLQYDANefEieGBxzxnNiKkurx/J9J2y3IVsX9EQhTZfuY+miU1ltwpQ
 qDAiCVfiyUWK+sKhlMBjfH/TR7u5A9t2cuJCd7MFUmaRsw822LquowjQvrcLNzZSlciL
 G1FoJjin+lsMlGqs8eh3worRFe0xKh+B34AB/YkGxzEQiRXOcBITsMSZij7ScydWQJ/W
 TIpuO/My9F0GSeeFAjf0gvA1AXhymEWh0UlTJ4eIk7MxGDSm83ZcmwPpkUv3424eEzct
 iFcaan2SFPv3AfvuxswzurRNJzpLshVA41V3Y02LSmqZiaq88LMlAHWsxNUB8zIxW2ea
 P+gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmqxYU3tiuwu5QR8WPvBRw2uEJN6Y9KsBWgimGucxV8j8tSiQB3yswxtHLKR+Iw3TwsMb0GxMwz7lh@nongnu.org
X-Gm-Message-State: AOJu0YzXzPK7/WF7K8uDq2dnhs92OUtST1/Zt/XWjhfBKrVjP862UA0E
 W1HZ7cGwJQjZtGB9I8tOnB6PR+Xr3NsCjResj3ckq45M0WCVDD0H
X-Gm-Gg: ASbGncsxO2JbVOacDJpf18sFBoRZ+IOFDmkpoeqOMw56GiZnMzht5rg57rP+vMYMA7X
 f7Yltzy01QTEqQ65eybC+ob5xw7vYcSrAV2raCQmUJi3wD23vAyxiN3yIOfxh+fgRypm7SdZEXS
 jo+9ch7RHsxoJya3oecnTPGh9eIybGVJ7kYI1/qpFk5bwPbyCYJ+/oMwg0jims5Cu1Uz+zx8tMY
 5pp1DDZuoBqw7T9hPkqi/Q2ow3JwY3YP06W4oKRtruil5PRt+Xxk0Xl1LkNxAW6ibXyaEDXlZ83
 EHRBFM3rvYfE+LnruWtFr0PocAD4XpvqvqPeS2IG6Zq1nqYMEEyque7Wkt+Aeu1hoL/rSSXOjka
 q94QwqrlZKguXgMZr9o6thr8=
X-Google-Smtp-Source: AGHT+IGDrpfWeaafyTIFomLAc69JQK8uMpiI7i2JYWQjFqlQ06vIyiGXGO+1Ay4RKAHOFmk1gNuZ/A==
X-Received: by 2002:a17:902:ce08:b0:224:3d:2ffd with SMTP id
 d9443c01a7336-2291ddd8289mr19419575ad.17.1743101079070; 
 Thu, 27 Mar 2025 11:44:39 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970def163sm168860b3a.28.2025.03.27.11.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 11:44:38 -0700 (PDT)
Message-ID: <1b956efb-16bd-485f-bc6c-fcbbaaff6c9d@gmail.com>
Date: Fri, 28 Mar 2025 00:14:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 7/7] vdpa: Support setting vring_base for packed SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-8-sahilcdq@proton.me>
 <CAJaqyWfkGpRCv1a0qS3XC3Tnco-YSVH-CHd3itFG4V41tnc3wQ@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWfkGpRCv1a0qS3XC3Tnco-YSVH-CHd3itFG4V41tnc3wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x631.google.com
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

On 3/26/25 5:38 PM, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 3:00 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> [...]
>> Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
>> Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
>> Link: 1225c216d954 ("vp_vdpa: allow set vq state to initial state after reset")
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>> Acked-by: Eugenio Pérez <eperezma@redhat.com>
>> ---
>> Changes from v4 -> v5:
>> - Initially commit #5 in v4.
>> - Fix coding style of commit block as stated by checkpatch.pl.
>>
>>   hw/virtio/vhost-vdpa.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 58c8931d89..0625e349b3 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -1265,6 +1265,21 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
>>       };
>>       int r;
>>
>> +    /*
>> +     * In Linux, the upper 16 bits of s.num is encoded as
>> +     * the last used idx while the lower 16 bits is encoded
>> +     * as the last avail idx when using packed vqs. The most
>> +     * significant bit for each idx represents the counter
>> +     * and should be set in both cases while the remaining
>> +     * bits are cleared.
>> +     */
>> +    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
>> +        uint32_t last_avail_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>> +        uint32_t last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>> +
>> +        s.num = (last_used_idx << 16) | last_avail_idx;
>> +    }
>> +
> 
> This should be added before 6/7 so we don't declare we support packed
> without this.

Sure, I'll change the ordering in the next patch series.

Thanks,
Sahil

