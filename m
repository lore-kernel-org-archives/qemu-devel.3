Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FCDC021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 15:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrl5-0004uj-EL; Tue, 11 Feb 2025 10:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrkj-0004nm-4q
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrkf-0001kv-Ly
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739286039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/zvo5IxgV9aRsLTjGUWuZMYIGppcrHlcN8Mp0kpEDEo=;
 b=GQHIvID/xbzwvdTRZjmvzwFwfeho4YHgEHlcCWCuDa1nl7HuY6n21CbVZonk8L4FiobukX
 AQBGEtCPIv7SF/Em2lARBEiJRKWuhEDSckkYvAryMeNdj3nqfXqVOiVIAxI5FaJinjwsRo
 1+ET5+xeiAy/orRb4TYe5V8/S+wfegM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-bpypn42POrqt4s1-lnfmwA-1; Tue, 11 Feb 2025 10:00:37 -0500
X-MC-Unique: bpypn42POrqt4s1-lnfmwA-1
X-Mimecast-MFC-AGG-ID: bpypn42POrqt4s1-lnfmwA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so14772405e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 07:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739286036; x=1739890836;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zvo5IxgV9aRsLTjGUWuZMYIGppcrHlcN8Mp0kpEDEo=;
 b=q3wFnxByIDcuq1mgym7alL0rgyxgemdIzOFJ7k62n1Nj9s6et6wVr9O1FGZKqWtBGm
 Bd30OH/ocEextEg7NiFFpl8LQ/f/9RG2V6nkeEG0lgA4nv01F3yKcr2GzUBXQLXxQ4Yy
 +ZnppeTzKuTfvSTaGYk00m3w7cS+empi7w8cvwsqbQKHh1GA4DYkMRoGWM0rOgy45ObR
 djsBLytGNZHScKxsD8trhKqjxetzSWRLwAgRb5iCiiTmeQeadlcwrd3quSvZoXcnsFUL
 BrK1+Ry1JiSuA/qpXQNYNMBPH3qJD/5qD4hCjCfrVMAZTqE1e6y8kRQd16uzQZ48/wgS
 J4kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5DGojasZwDPFCHZpm8wZxYVHjYrWDJLGPSDMJJmQrCy0+8TcP0I/sUN8zI8EsMgkUhJ/8IxzUV8Tf@nongnu.org
X-Gm-Message-State: AOJu0YziYMBljhZOCIx32IwYfDY9cYezjUGqrnZSey7m6/wT70WfCunV
 9ZrckFomrISdtfTzsIntlWIrOvddSZkYYgPBMcNFjGNg5FjKJnQe4JW3Ko/O09W9bhDx0k6Ju2Q
 yGIUX27qfoLXI2qdH84IxPJS7rJw4zT9DRggbXQ5l2MSfHdWM98XA
X-Gm-Gg: ASbGncuAWLZugOB7r5lK53ZvgvSU5+ddLkDTMbPLyhIBBPrDTgtBYdZku2Q2Wj7iqGJ
 E/7OctUntXtGuGyawBk+zRVf6f5u2txGfXXoQxltlRPgUS3o6lhCwwzCtmJsV5Bm+gIGgxWBtJc
 X+l94pD/6gJ2vOl6AeSib9+Bk8mn3cSvskA/Cn72JUTUmZltu0KDvqumwnElhIkVjlCZwqRp29z
 ZP444WYMlM9shwI58epyMbhdd8HruVEjJ6H1/+P8J1qNN4qE60E2GcPDc3v6i93kvVEEtAnnc2p
 Vg9PeFIrFrSjNQI2RCD4a4OgFnuRuK0DmRVWm240Is4=
X-Received: by 2002:a05:600c:34c9:b0:439:441a:3d7e with SMTP id
 5b1f17b1804b1-4394c8461c7mr37500555e9.20.1739286035990; 
 Tue, 11 Feb 2025 07:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8dnNLRQUGDpIKvF2zi6X4j2468+20sKLd6VMIZHwg2tZ68W96jzbkSCleFI4LejboNIUDbg==
X-Received: by 2002:a05:600c:34c9:b0:439:441a:3d7e with SMTP id
 5b1f17b1804b1-4394c8461c7mr37499995e9.20.1739286035409; 
 Tue, 11 Feb 2025 07:00:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d7d4sm216981425e9.10.2025.02.11.07.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 07:00:34 -0800 (PST)
Message-ID: <ab34a907-7e88-463e-9924-d8fdd771bfd8@redhat.com>
Date: Tue, 11 Feb 2025 16:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/33] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <11f12c43e098ac5e2466e456e8cf8936c54210dc.1738171076.git.maciej.szmigiero@oracle.com>
 <36beb97e-ab1e-41f4-b9d0-75238d5faaa9@redhat.com>
 <afcec18d-094f-49ea-a4f9-3b868b58e60a@maciej.szmigiero.name>
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
In-Reply-To: <afcec18d-094f-49ea-a4f9-3b868b58e60a@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/11/25 15:37, Maciej S. Szmigiero wrote:
> On 10.02.2025 18:24, Cédric Le Goater wrote:
>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This property allows configuring whether to start the config load only
>>> after all iterables were loaded.
>>> Such interlocking is required for ARM64 due to this platform VFIO
>>> dependency on interrupt controller being loaded first.
>>>
>>> The property defaults to AUTO, which means ON for ARM, OFF for other
>>> platforms.>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 25 +++++++++++++++++++++++++
>>>   hw/vfio/pci.c                 |  3 +++
>>>   include/hw/vfio/vfio-common.h |  1 +
>>>   3 files changed, 29 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index adfa752db527..d801c861d202 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -254,6 +254,31 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>>       return ret;
>>>   }
>>> +static bool vfio_load_config_after_iter(VFIODevice *vbasedev)
>>> +{
>>> +    if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_ON) {
>>> +        return true;
>>> +    } else if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_OFF) {
>>> +        return false;
>>> +    }
>>> +
>>> +    assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
>>> +
>>> +    /*
>>> +     * Starting the config load only after all iterables were loaded is required
>>> +     * for ARM64 due to this platform VFIO dependency on interrupt controller
>>> +     * being loaded first.
>>> +     *
>>> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
>>> +     * the right place in VFIO migration").
>>> +     */
>>> +#if defined(TARGET_ARM)
>>> +    return true;
>>> +#else
>>> +    return false;
>>> +#endif
>>
>> I would rather deactivate support on ARM and avoid workarounds.
>>
>> This can be done in routine vfio_multifd_transfer_supported() I believe,
>> at the end of this series. A warning can be added to inform the user.
> 
> The reason why this interlocking support (x-migration-load-config-after-iter)
> was added because you said during the review of the previous version of
> this patch set that "regarding ARM64, it would be unfortunate to deactivate
> the feature since migration works correctly today [..] and this series should
> improve also downtime":
> https://lore.kernel.org/qemu-devel/59897119-25d7-4a8b-9616-f8ab54e03f65@redhat.com/

So much happened since ... my bad. I think this patch is not well
placed in the series, it should be at the end.

The series should present first the feature in a perfect world
and introduce at the end the toggles to handle the corner cases.
It helps the reader to focus on the good side of the proposal
and better understand the more unpleasant/ugly part.

> My point is that after spending time developing and testing that feature> (or "workaround") it would be a shame to throw it away (with all the benefits
> it brings) and completely disable multifd VFIO device state transfer on ARM.

Well, if you take the approach described above, this patch would
be proposed after merge as a fix/workaround for ARM or we would
fix the ARM platform.

> Or am I misunderstanding you right now and you only mean here to make
> x-migration-load-config-after-iter forcefully enabled on ARM?

If we only need this toggle for ARM, and this seems to be the case,
let's take a more direct path and avoid a property.

I haven't read all your series and the comments yet.

Thanks,

C.


  
>> Thanks,
>>
>> C.
> 
> Thanks,
> Maciej
> 


