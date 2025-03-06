Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60D2C28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCBy-00053u-O5; Thu, 06 Mar 2025 09:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqCBo-0004ya-3i
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:27:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqCBk-00038P-Uz
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741271222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=epHqCapw2ITcyVCRZZ5gs/CE915iB8zkoYckaNQ87Go=;
 b=CrJ3oUHDgGavzra4+KmIG5wGc1VAeP6KGc6ChTuwaciO6vhGpdE9NYY6iSSbEcyfJMMV0i
 N0wwat8gZgPSNdlIDFAugF+RYFUT5zhIM8jyEmQr2EZKIir64LgvSc8jFqXQ1htZYpsxCm
 a9tdYi8grxHNLC4iPbxy1ByVwgEsfyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-TxhlW9QlMwyrOwOqb9zb5Q-1; Thu, 06 Mar 2025 09:27:01 -0500
X-MC-Unique: TxhlW9QlMwyrOwOqb9zb5Q-1
X-Mimecast-MFC-AGG-ID: TxhlW9QlMwyrOwOqb9zb5Q_1741271220
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39123912ff0so326191f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 06:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271220; x=1741876020;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epHqCapw2ITcyVCRZZ5gs/CE915iB8zkoYckaNQ87Go=;
 b=qsFR6LWezC1+TAi8lHyoxh6wv0Hf0X6op6AcSCTDOna6zFKOK/K1akNv4Fq2fkniG8
 UDxzoowoDNKxKX5FAbYVXOdtkAUmv81lYcJY4SdxAyq5I99bSURI9NGWcj9qWX2fFQxE
 RDV+rtlAZDshGXiqiSgpHRCAw6HSVhFS88AKz+d+/LLy2T4/NImY9YH5JIOwdn3LpmqC
 Zos/RVKS12nKTZ8RiyhspEYcY+kAU2V57FkR4OOAOmtZJ5XzTeHeDkKp279EnX3IYktw
 7vsfpXTM66YpV9IjIPcVjq3d3PZDMt5NfQ8xM1fj3/Rb4wIehrt4DA3VFeb187LPkHmS
 zvAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9GWCwXzjsmK4Ju4lcYaeBJZh+xcdETEUta0HQTKt0m1rB3DO6kob2yLohiinejImoxFI1LPKDDr1o@nongnu.org
X-Gm-Message-State: AOJu0YypGq8vlxwT9cq2Zs4XRzitmT67gWCK2YOrYCvUAXao9NU6TPa2
 SkjeFjwr1Ban2zQIsI1ZFSStKZPpkFv7nX18IkLi6BjoHTmTrOPMgfBa2hWZCA7EDXve+ozzP4f
 OUCgTqyAlO5PxG5aeEa3WMpiSENj5FWykj359Lpw2fL33U388JiN2
X-Gm-Gg: ASbGncvA49xh/LNlPD+YJcGb1t5vxRgqxAfKgzlnngX14SrC4f4PMvuRBPFQKa6yYur
 vbzisSzpZkHF/so+QcApq8u7VNr5rzr0iI3EzlXb/DbjThNCzU4RsgQXus0FjRhGzzf1+CFcFmo
 reen5a+rrdX822wYBTLJ3tGZuvdeAnCZ1T8Jie7QPXEOTkuYWkZmDuMSnhy391IH34cJg7FwG/G
 kyQRGjnh+M0BBZyuPX9B5BMBDifz6wMSATuWD4QudDUSHkQz7xkurxGiic3s7cinYQZoX1sEMQe
 ubGbBJDwBVN5+EfifNPpspzeMtyKJPO1Wn+50AfEMn0KTOEj8TanGg==
X-Received: by 2002:a5d:6c65:0:b0:391:34:4fa9 with SMTP id
 ffacd0b85a97d-3911f58eb5fmr7267255f8f.0.1741271219683; 
 Thu, 06 Mar 2025 06:26:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+mdpEiDM6MXK5fFR6glAV+0wkyhCyns2zG5MJ334E0bzpHg11+nTgXmoKTklK1JCvasMGyw==
X-Received: by 2002:a5d:6c65:0:b0:391:34:4fa9 with SMTP id
 ffacd0b85a97d-3911f58eb5fmr7267172f8f.0.1741271217833; 
 Thu, 06 Mar 2025 06:26:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c3aa8sm21251195e9.14.2025.03.06.06.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 06:26:57 -0800 (PST)
Message-ID: <7eb4dd80-0ae3-4522-bd1d-b004c19c4bf2@redhat.com>
Date: Thu, 6 Mar 2025 15:26:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: Avihai Horon <avihaih@nvidia.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
 <629dff3c-865d-47d9-a01a-d212dfed1efb@nvidia.com>
 <97b87f22-b867-4282-ba13-efba16458859@maciej.szmigiero.name>
 <973268d4-85d6-4a17-ae76-2d20d8cfd7cb@redhat.com>
 <d85c8d21-5e1b-4162-9f5b-fe270beb5eca@nvidia.com>
 <498a07aa-d539-46e6-90e9-8c41a59a6b2f@maciej.szmigiero.name>
 <bdf53809-b0da-489b-b25a-28be1286c06a@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <bdf53809-b0da-489b-b25a-28be1286c06a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/6/25 15:23, Avihai Horon wrote:
> 
> On 06/03/2025 16:13, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 6.03.2025 14:37, Avihai Horon wrote:
>>>
>>> On 06/03/2025 12:32, Cédric Le Goater wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 3/6/25 11:15, Maciej S. Szmigiero wrote:
>>>>> On 6.03.2025 07:47, Avihai Horon wrote:
>>>>>>
>>>>>> On 05/03/2025 0:03, Maciej S. Szmigiero wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>
>>>>>>> Implement the multifd device state transfer via additional per-device
>>>>>>> thread inside save_live_complete_precopy_thread handler.
>>>>>>>
>>>>>>> Switch between doing the data transfer in the new handler and doing it
>>>>>>> in the old save_state handler depending if VFIO multifd transfer is enabled
>>>>>>> or not.
>>>>>>>
>>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>>> ---
>>>>>>>   hw/vfio/migration-multifd.c   | 142 ++++++++++++++++++++++++++++++++++
>>>>>>>   hw/vfio/migration-multifd.h   |   6 ++
>>>>>>>   hw/vfio/migration.c           |  22 ++++--
>>>>>>>   hw/vfio/trace-events          |   2 +
>>>>>>>   include/hw/vfio/vfio-common.h |   6 ++
>>>>>>>   5 files changed, 172 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>>>>>> index 1d81233c755f..bfb9a72fa450 100644
>>>>>>> --- a/hw/vfio/migration-multifd.c
>>>>>>> +++ b/hw/vfio/migration-multifd.c
>>>>>>> @@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>>>>>>>       return true;
>>>>>>>   }
>>>>>>>
>>>>>>> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>>>>>>> +{
>>>>>>> +    assert(vfio_multifd_transfer_enabled(vbasedev));
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * Emit dummy NOP data on the main migration channel since the actual
>>>>>>> +     * device state transfer is done via multifd channels.
>>>>>>> +     */
>>>>>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static bool
>>>>>>> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>>>>>>> +                                               char *idstr,
>>>>>>> +                                               uint32_t instance_id,
>>>>>>> +                                               uint32_t idx,
>>>>>>> +                                               Error **errp)
>>>>>>> +{
>>>>>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>>>>>> +    g_autoptr(QEMUFile) f = NULL;
>>>>>>> +    int ret;
>>>>>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>>>>>> +    size_t packet_len;
>>>>>>> +
>>>>>>> +    bioc = qio_channel_buffer_new(0);
>>>>>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>>>>>>> +
>>>>>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>>>>>> +
>>>>>>> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
>>>>>>> +        return false;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    ret = qemu_fflush(f);
>>>>>>> +    if (ret) {
>>>>>>> +        error_setg(errp, "%s: save config state flush failed: %d",
>>>>>>> +                   vbasedev->name, ret);
>>>>>>> +        return false;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>>>>>> +    packet = g_malloc0(packet_len);
>>>>>>> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>>>>>>> +    packet->idx = idx;
>>>>>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>>>>>
>>>>>> The packet is sent on the wire.
>>>>>> Shouldn't we use cpu_to_be32() for version, idx and flags? Also below in vfio_multifd_save_complete_precopy_thread().
>>>>>> And then use be32_to_cpu() in patch #26 when receiving the packet?
>>>>>
>>>>> Is it even possible to migrate to a host with different endianess here?
>>>>>
>>>>> Also AFAIK big endian hosts barely exist today, is any of them even VFIO-capable?
>>>>
>>>> s390x is VFIO capable. VFIO PCI migration is not supported on these.
>>>>
>>> It is indeed a niche use case and not even applicable today, but if we want to add support for it after the release, we will have to add a compatibility option for older QEMUs.
>>> If we add support for it now, then we can avoid the compatibility option.
>>>
>>> It's a really small change and it can come even after the series is merged, as a fix.
>>> So IMHO it wouldn't hurt, for completeness.
>>
>> For sure, any such bit stream change will need re-testing the whole VFIO migration.
>>
>> But I will be testing the queued buffers size limit anyway so it would make
>> sense to test both at the same time.
>>
>> Wouldn't it make more sense, however, to squash this endianess change already
>> to the relevant patches rather than to have such bit stream modifying patch on the top?
>>
>> It would help prevent backporting mistakes - when someone forgets about this last patch
>> and ends with a different bit stream.
> 
> I agree.
> Whatever you and Cedric decide.
> 

PR was sent. So it will be a "Fixes" patch.

Thanks,

C.


