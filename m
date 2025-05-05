Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2693EC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBqGJ-0006Fw-MI; Mon, 05 May 2025 03:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uBqGH-0006FZ-PT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uBqGF-0004hb-S5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746430150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wv2QY6/q3n0u3MRB7qCW5RhKNEZFPcgUEZSBLIpFUtg=;
 b=N19f4Ted3ZBUVblihYZE3EE/Jthi/hX0tNDIJX7zA3INuGmQ3IUOzL6NjbA32RYzc5yJru
 +sZVw7Dpn3tgjJjEXAGiqTpLetr6JDYuwx+/kTilvZfAJ3ukH5VUVGpLHMX+Pb/P2qCLcO
 KIAyGsOH1X5AMhRczwbnQoRVpEYSGOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-2Kct4gx0MHe85j4Sv4UQVQ-1; Mon, 05 May 2025 03:29:08 -0400
X-MC-Unique: 2Kct4gx0MHe85j4Sv4UQVQ-1
X-Mimecast-MFC-AGG-ID: 2Kct4gx0MHe85j4Sv4UQVQ_1746430148
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so23741045e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 00:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746430147; x=1747034947;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wv2QY6/q3n0u3MRB7qCW5RhKNEZFPcgUEZSBLIpFUtg=;
 b=W2LxtjhR9YG02Ujriuw+ib2rlLoYPuJm6Agq/fFXZF0HzSoPmMPHrL+mK8kwb61rK4
 UETaCcpSRfY+EEcCv5CSJd71+2DRsdX9/pgEArVs+e4SrkVpbaRyAAWLwMlXy9fP5h6P
 FJUqeYZoiZyD4exrz4y6xCdHfRdsOlOO2YQG86XwDd0V1nV4VGvf+5x5UIl0tCfXnnNW
 iPcTj6LreS/VJdsoLa5u/M5x7EFlH801QlwAFt/nIk+VSYd8r8lOiI4QttipDs22bwuG
 0l43I/wsomIIRkOzVfwxzJy4h6NbuKo7tCAyW5LplbriDYbLx29Pwp3z//SWqFCPnf+D
 az1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNM1AOQ2tfZWfRVZpfPNZZciiJ2ikz0lfAM5CLkc8jtT3t8/Hlk1CscWAfVQKxQkiLwP8WKy0SMe0U@nongnu.org
X-Gm-Message-State: AOJu0YwN1uAOuP32yGNc9Kn6i/cf2cjcpzQIt1xFiZGCgGpvvIx4AvEX
 bW+7ggS6oQBW+XyppD8YeskAsAfYyd5ps1M8wPbulHPAnp2qTEdqVQ90UpGgxQ0BttgcaZ15yJ1
 R+sLFjB1vIhQtI2shFrfoI3gfpBd+jugrorEI/3s5yK/dh13o5X9y
X-Gm-Gg: ASbGnctqXBwNIWCjg9HUHo1HKtPaGRkXULAqnORnVJsyG+WJ4eO2xndR4MVrlYS5+ET
 N7Nr6xGW+Ws3BocMC+ezZvIJ2yIqMxQE7Lnlz4dzzqmnvcgKW6DAh6eyxD0b1BjxmIKAOe65MEQ
 gUXUB0OYg0d6sqt53KSPH8oOfYU9BYWvER5ZDbaSWnXH1jW4y3jldoBnaf/jJqaiQtC6TLRXn97
 fyZw1ofUi8aOITprQkiF4QrcQB/I0SPxRsuegC2sf9INyKU7TEeL3gsqwJJqQG834r9aXE3h8g4
 rnzucOV/zgJ+L9tTNb6XCWNzi2fblH8tvRnI3k4X7EHK44HnonA=
X-Received: by 2002:a05:600c:4683:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-441c492374fmr35853115e9.20.1746430147619; 
 Mon, 05 May 2025 00:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb/QmGaeLPA26AqMMzx/Of8llAyQOWx8lkAQzkvXQA/iIDLXPpqkxVP5AFxsjjbQR7J1akfg==
X-Received: by 2002:a05:600c:4683:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-441c492374fmr35852865e9.20.1746430147237; 
 Mon, 05 May 2025 00:29:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc441sm126052865e9.3.2025.05.05.00.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:29:06 -0700 (PDT)
Message-ID: <172974a9-4163-4f06-ba80-92bcce6c6f28@redhat.com>
Date: Mon, 5 May 2025 09:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/6] qmp: add QMP command x-query-virtio-status
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Jonah Palmer <jonah.palmer@oracle.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
Cc: mst@redhat.com, qemu_oss@crudebyte.com, kraxel@redhat.com,
 si-wei.liu@oracle.com, joao.m.martins@oracle.com, eblake@redhat.com,
 qemu-block@nongnu.org, david@redhat.com, arei.gonglei@huawei.com,
 marcandre.lureau@redhat.com, michael.roth@amd.com, groug@kaod.org,
 dgilbert@redhat.com, eric.auger@redhat.com, stefanha@redhat.com,
 boris.ostrovsky@oracle.com, kwolf@redhat.com, mathieu.poirier@linaro.org,
 raphael.norwitz@nutanix.com, pbonzini@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1660220684-24909-1-git-send-email-jonah.palmer@oracle.com>
 <1660220684-24909-3-git-send-email-jonah.palmer@oracle.com>
 <7de79c4d-57f2-4103-a22e-748cfbe08974@linaro.org>
 <41eff78d-db42-4391-a243-ec40e2356627@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
In-Reply-To: <41eff78d-db42-4391-a243-ec40e2356627@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/05/2025 08:30, Thomas Huth wrote:
> On 02/05/2025 00.09, Philippe Mathieu-Daudé wrote:
>> Hello,
>>
>> (patch merged as commit 90c066cd682).
>>
>> On 11/8/22 14:24, Jonah Palmer wrote:
>>> From: Laurent Vivier <lvivier@redhat.com>
>>>
>>> This new command shows the status of a VirtIODevice, including
>>> its corresponding vhost device's status (if active).
>>>
>>> Next patch will improve output by decoding feature bits, including
>>> vhost device's feature bits (backend, protocol, acked, and features).
>>> Also will decode status bits of a VirtIODevice.
>>>
>>> [Jonah: From patch v12; added a check to @virtio_device_find to ensure
>>>   synchronicity between @virtio_list and the devices in the QOM
>>>   composition tree.]
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>> ---
>>>   hw/virtio/virtio-stub.c |   5 +
>>>   hw/virtio/virtio.c      | 104 +++++++++++++++++++
>>>   qapi/virtio.json        | 222 ++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 331 insertions(+)
>>>
>>> diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
>>> index 05a81edc92..0b432e8de7 100644
>>> --- a/hw/virtio/virtio-stub.c
>>> +++ b/hw/virtio/virtio-stub.c
>>> @@ -12,3 +12,8 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>>   {
>>>       return qmp_virtio_unsupported(errp);
>>>   }
>>> +
>>> +VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>> +{
>>> +    return qmp_virtio_unsupported(errp);
>>> +}
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index bdfa82e9c0..3e0a484660 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -3939,6 +3939,110 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>>       return list;
>>>   }
>>> +static VirtIODevice *virtio_device_find(const char *path)
>>> +{
>>> +    VirtIODevice *vdev;
>>> +
>>> +    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>>> +        DeviceState *dev = DEVICE(vdev);
>>> +
>>> +        if (strcmp(dev->canonical_path, path) != 0) {
>>> +            continue;
>>> +        }
>>> +
>>> +        Error *err = NULL;
>>> +        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>>> +        if (err == NULL) {
>>> +            GString *is_realized = qobject_to_json_pretty(obj, true);
>>> +            /* virtio device is NOT realized, remove it from list */
>>> +            if (!strncmp(is_realized->str, "false", 4)) {
>>> +                g_string_free(is_realized, true);
>>> +                qobject_unref(obj);
>>> +                QTAILQ_REMOVE(&virtio_list, vdev, next);
>>> +                return NULL;
>>> +            }
>>> +            g_string_free(is_realized, true);
>>> +        } else {
>>> +            /* virtio device doesn't exist in QOM tree */
>>> +            QTAILQ_REMOVE(&virtio_list, vdev, next);
>>> +            qobject_unref(obj);
>>> +            return NULL;
>>> +        }
>>> +        /* device exists in QOM tree & is realized */
>>> +        qobject_unref(obj);
>>> +        return vdev;
>>> +    }
>>> +    return NULL;
>>> +}
>>> +
>>> +VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>> +{
>>> +    VirtIODevice *vdev;
>>> +    VirtioStatus *status;
>>> +
>>> +    vdev = virtio_device_find(path);
>>> +    if (vdev == NULL) {
>>> +        error_setg(errp, "Path %s is not a VirtIODevice", path);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    status = g_new0(VirtioStatus, 1);
>>> +    status->name = g_strdup(vdev->name);
>>> +    status->device_id = vdev->device_id;
>>> +    status->vhost_started = vdev->vhost_started;
>>> +    status->guest_features = vdev->guest_features;
>>> +    status->host_features = vdev->host_features;
>>> +    status->backend_features = vdev->backend_features;
>>> +
>>> +    switch (vdev->device_endian) {
>>> +    case VIRTIO_DEVICE_ENDIAN_LITTLE:
>>> +        status->device_endian = g_strdup("little");
>>> +        break;
>>> +    case VIRTIO_DEVICE_ENDIAN_BIG:
>>> +        status->device_endian = g_strdup("big");
>>> +        break;
>>> +    default:
>>> +        status->device_endian = g_strdup("unknown");
>>> +        break;
>>> +    }
>>> +
>>> +    status->num_vqs = virtio_get_num_queues(vdev);
>>> +    status->status = vdev->status;
>>> +    status->isr = vdev->isr;
>>> +    status->queue_sel = vdev->queue_sel;
>>> +    status->vm_running = vdev->vm_running;
>>> +    status->broken = vdev->broken;
>>> +    status->disabled = vdev->disabled;
>>> +    status->use_started = vdev->use_started;
>>> +    status->started = vdev->started;
>>> +    status->start_on_kick = vdev->start_on_kick;
>>> +    status->disable_legacy_check = vdev->disable_legacy_check;
>>> +    status->bus_name = g_strdup(vdev->bus_name);
>>> +    status->use_guest_notifier_mask = vdev->use_guest_notifier_mask;
>>> +    status->has_vhost_dev = vdev->vhost_started;
>>> +
>>> +    if (vdev->vhost_started) {
>>> +        VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>>> +        struct vhost_dev *hdev = vdc->get_vhost(vdev);
>>> +
>>> +        status->vhost_dev = g_new0(VhostStatus, 1);
>>> +        status->vhost_dev->n_mem_sections = hdev->n_mem_sections;
>>> +        status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
>>> +        status->vhost_dev->nvqs = hdev->nvqs;
>>> +        status->vhost_dev->vq_index = hdev->vq_index;
>>> +        status->vhost_dev->features = hdev->features;
>>> +        status->vhost_dev->acked_features = hdev->acked_features;
>>> +        status->vhost_dev->backend_features = hdev->backend_features;
>>> +        status->vhost_dev->protocol_features = hdev->protocol_features;
>>> +        status->vhost_dev->max_queues = hdev->max_queues;
>>> +        status->vhost_dev->backend_cap = hdev->backend_cap;
>>> +        status->vhost_dev->log_enabled = hdev->log_enabled;
>>> +        status->vhost_dev->log_size = hdev->log_size;
>>> +    }
>>> +
>>> +    return status;
>>> +}
>>> +
>>>   static const TypeInfo virtio_device_info = {
>>>       .name = TYPE_VIRTIO_DEVICE,
>>>       .parent = TYPE_DEVICE,
>>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>>> index 03896e423f..c86b3bc635 100644
>>> --- a/qapi/virtio.json
>>> +++ b/qapi/virtio.json
>>> @@ -66,3 +66,225 @@
>>>   { 'command': 'x-query-virtio',
>>>     'returns': [ 'VirtioInfo' ],
>>>     'features': [ 'unstable' ] }
>>
>> When a structure is only used by an unstable command, is it considered
>> unstable too? IOW is it OK to modify it?
> 
> IMHO yes. If there is no other user of the struct, why should it considered to be stable 
> if the only command that uses it is unstable?

In my mind, "x-query-virtio" is only a debugging purpose command and must not be used to 
provide production feature. So yes.

Thanks,
Laurent


