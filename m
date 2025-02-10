Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17871C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWTg-000225-6v; Mon, 10 Feb 2025 11:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thWTG-0001dZ-P0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thWTC-000221-Ox
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739204230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n0903wXg6I3F+RFekQxzBjXt2SiQSa/xeb2KDFmynYc=;
 b=VQr0eIoDdck5mNTbcc+lawr4seq3fLLhIpJZXps85ncsMJlAR1TISS5dNyXKGJ2s821d6a
 m7FyKc6rWeOyMG4wjwUzdTAMnBaAvcrEPQ6j0/KOlcfOUc4rAoilXac6qeVzGEzPZmnpt+
 mp2gh4gIE40ACX+fytjPSNEB8VNE+94=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-GHJQ61JxMBm-viAqUw8AQQ-1; Mon, 10 Feb 2025 11:17:09 -0500
X-MC-Unique: GHJQ61JxMBm-viAqUw8AQQ-1
X-Mimecast-MFC-AGG-ID: GHJQ61JxMBm-viAqUw8AQQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dcc9653a7so1260767f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204228; x=1739809028;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0903wXg6I3F+RFekQxzBjXt2SiQSa/xeb2KDFmynYc=;
 b=UzMAsaoPK6tCkCjHtkiD1n8OuGWssH9CM5ym/PegPTaUbB+Igjl5adGx7c6D9cOyuk
 YYZOdp2tLDDdlrEm4ZXmv3V0CBwXPHAynqSs6QTfM7nV+/DAgK+t8X5SwSUeV8E7jd8R
 qi2v6vLFguErHJ9ipQ5JfXU/9apINMDlRQAYvqj5qQTKWprCkg5SSfUS+GF+NLBZHs1T
 NPxFIDWrhIGkVPJ+PCJvg6po3wRRyN9s0kouwQFGptJb/PbeAFSWopS2a0dmhJnFyO8M
 d98i0qoAfRNDm3NmQ1mjgO1vsc/KB5hbwbfRNopfrpKBAuNlaGGX0y3BLrnSUYCG2MdA
 Sdyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdjTRVBcQym6sQyz2FVcJ4AONvq2UZW9igio9igs8xiIsDMHNv866FnBhbHCFEiW+TuP8yFfgnNI8x@nongnu.org
X-Gm-Message-State: AOJu0Ywb42AXo0qLrinYisPjGDkzg9mlLI4VRyI8HYsEI7UFJhlCc1pR
 /kTb/TanY0bTje5QCq1JtxwCh/R6gGcwoW6m4tMBEH6XMYSmLMB/tCCQ1xZdSlgWFi9dc+Suj7u
 hAlAaO2v/yID0dfRvZfxObq3QO3A5+OnNFDIWSB4fDHHuSInE2bM/MlUf209e
X-Gm-Gg: ASbGnct5n3Tfd3Tx1CtZBzeNQOCsXqmIHXcXscz0xeuTKFI4eMHWN5OHXH4MK6oYTM1
 MLLrjBc4gxj5amMhlxDQfP3WZkFXfBC5oRhlwX5fCndLOUu55obI5pu8bwPbb7b+1260Jsvegzz
 9CRGLiAYPgbTZagyEbc1d1YxtBl09XM1AEe2l4bcSdeSM2Ro8aJQwVjaCvn7V4aZesDuZruwB6L
 1Uwnw/bDHXHLoeODdI97GzNVjAqL2pugZEWaDoKcnxlRSt7/Oxe1ZLP6wzMqWADy25oRgFbHdHk
 WNcrxUDr7V/9COKDZ2ttjS5Hu4RSozwAHxLqIaJG6eI=
X-Received: by 2002:a05:6000:1fa2:b0:38d:d43c:31b5 with SMTP id
 ffacd0b85a97d-38dd43c356amr7325640f8f.38.1739204227767; 
 Mon, 10 Feb 2025 08:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1wrShq4UeUgmum0KfDKYglhKXgDS2Y5QaUBIfbz1KsvxKkae1EUFObiO/Ty9WyjVSYx0Z4Q==
X-Received: by 2002:a05:6000:1fa2:b0:38d:d43c:31b5 with SMTP id
 ffacd0b85a97d-38dd43c356amr7325614f8f.38.1739204227338; 
 Mon, 10 Feb 2025 08:17:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393963c84esm71638435e9.27.2025.02.10.08.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:17:06 -0800 (PST)
Message-ID: <ace08a13-c3d6-4cba-a5fc-c76b0fef3a3f@redhat.com>
Date: Mon, 10 Feb 2025 17:17:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] vfio: Improve error reporting when MMIO region
 mapping fails
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-6-clg@redhat.com>
 <84bfb439-e3eb-469c-afb4-4c942c70ec68@linaro.org>
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
In-Reply-To: <84bfb439-e3eb-469c-afb4-4c942c70ec68@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/10/25 15:36, Philippe Mathieu-Daudé wrote:
> On 30/1/25 14:43, Cédric Le Goater wrote:
>> When the IOMMU address space width is smaller than the physical
>> address width, a MMIO region of a device can fail to map because the
>> region is outside the supported IOVA ranges of the VM. In this case,
>> PCI peer-to-peer transactions on BARs are not supported.
>>
>> This can occur with the 39-bit IOMMU address space width, as can be
>> the case on some consumer processors or when using a vIOMMU device
>> with default settings. The current error message is unclear, also
>> change the error report to a warning because it is a non fatal
>> condition for the VM.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/common.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 62af1216fc5a9089fc718c2afe3a405d9381db32..5c9d8657d746ce30af5ae8f9122101e086a61ef5 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -555,6 +555,18 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
>>       return true;
>>   }
>> +static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    /*
>> +     * MMIO region mapping failures are not fatal but in this case PCI
>> +     * peer-to-peer transactions are broken.
>> +     */
>> +    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
>> +        error_append_hint(errp, "%s: PCI peer-to-peer transactions "
>> +                          "on BARs are not supported.\n", vbasedev->name);
>> +    }
>> +}
>> +
>>   static void vfio_listener_region_add(MemoryListener *listener,
>>                                        MemoryRegionSection *section)
>>   {
>> @@ -670,7 +682,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>                      strerror(-ret));
>>           if (memory_region_is_ram_device(section->mr)) {
>>               /* Allow unexpected mappings not to be fatal for RAM devices */
>> -            error_report_err(err);
>> +            VFIODevice *vbasedev =
>> +                vfio_get_vfio_device(memory_region_owner(section->mr));
>> +            vfio_device_error_append(vbasedev, &err);
> 
> Having vfio_get_vfio_device() returning NULL and
> vfio_device_error_append() also checking for NULL is odd.

Shouldn't vfio_device_error_append() check that its arguments are
safe to use ?

> Maybe just inline everything here?

I plan to use it elsewhere. See last patch.


Thanks,

C.


> 
>> +            warn_report_once_err(err);
>>               return;
>>           }
>>           goto fail;
> 


