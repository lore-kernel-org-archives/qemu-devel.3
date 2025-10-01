Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A312CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3qns-0002Gw-2s; Wed, 01 Oct 2025 02:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3qnp-0002Gi-W0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3qne-0008Ec-Eu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759301928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=epzkE0EGwfDYdmlEsfy9QA0u25Xd0eg11REQ8ARfVlk=;
 b=JgT3ndpplgTm8cy22f2wznZQSERgM0AlrREmlcxCjdqUPYl0lCNlfnetL8BfH+hn8gliGI
 jqP9Htsx/UiJKmu4R92GkYz1WZpozQCSAN2FDyLaceNLe3CXLLEdY7WbGHuCtu5Tz7hjfO
 eWgZ2vDTycLhARx3m7+IRy0cCSk/LjE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-11ySlNWfOE-18wq7uKrYFQ-1; Wed, 01 Oct 2025 02:58:46 -0400
X-MC-Unique: 11ySlNWfOE-18wq7uKrYFQ-1
X-Mimecast-MFC-AGG-ID: 11ySlNWfOE-18wq7uKrYFQ_1759301925
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e36686ca1so53567965e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 23:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759301925; x=1759906725;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=epzkE0EGwfDYdmlEsfy9QA0u25Xd0eg11REQ8ARfVlk=;
 b=dp3wYP14iEe4Vlkw4sSDniLKIahdV0pWrVymCWCY4BRxF3dJYHif6ew9ikC6SzxRoy
 EnoTG9i+z9LDPeN//f1uHmtwxIWwFUHSJ7bDdM35MXKWiZdivCgJWMk+hVwkBmVQT+gF
 AqTNEmTeopcVC5UCgfHVtQdsLrI8DDTygMFnYMGBaeOEgyiUgVqlf/lXJ6GHGgugJfCq
 FxkoQjzO7ItXKGnzWBd8XfFzwuyxTGiaZhlY/90PhJgGSg0wBuScEoOPafx66laH4NNJ
 VXCyfUYH3r+lynEdH7vvyIQ56QJ2eqmCXDvtJffWna08jLSiguNaxtdAkJLZPvzTZxyY
 2RLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9LwkPzte8hP/63/fOCJx23xeM9R/Dd0KcB/bv9h807r+gEXv3znPhslg+evSyCUY+nBsRtPJ2gSQO@nongnu.org
X-Gm-Message-State: AOJu0YzXlPE+VhOR0SSsz1qDV2Dc6RoNani2EfoAf8RMcG+3rwSDd5J7
 ZH3KV+HSnE5P7k9PXGPZHagzAv7k3dUKWw/o555jz1YvXW5PVomAxkT7FaCJdxdsglfvkrDikVr
 w1G9kVhdXyQhLXfolizMiKgqIvGW1K17IaMlKCOadVse+f/sCbPL0qEhJ
X-Gm-Gg: ASbGncvYY2gTtPB7Kb9x18h1NGOosj1kBfVAY8gAYCueaj3ArgxXj0v2iF3GPax4Wqc
 eshXgOVkuvW7MQrFjzkTDhxuBOPBxTHX7pR7XTYN4JO9vaiYIMDB3LTTp7MUO87cJ9E8frIULM1
 Pptu3qOQfPuC5pwvpHUmI6otWvNSBytQLNMqP+qqPczb1XG1SZN1MsU2C8h2B4hljbkxs3MR435
 8pn6a9q6pAuajxcPFjJGVFtvXUFKbl6tczXWAe1f5BvtZcM24EW9gVCoITCtZmDkUc43KSDGJcM
 72qLsnsuKqXpDF+Y5uy9+axloyR9U6cRRLZ4vkGRErDiHqEBtm+E15GIdoC5TNBaPHRnY8lajNK
 +fLF5CUWC
X-Received: by 2002:a05:600c:8b02:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e612dafafmr20042775e9.31.1759301924984; 
 Tue, 30 Sep 2025 23:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH36DLBDQV9r2kOY6W3z4M31oLsgSniSOHTuboyT4GTdocrHageB56VWwIi2y0CgTzTZ2/cw==
X-Received: by 2002:a05:600c:8b02:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e612dafafmr20042655e9.31.1759301924608; 
 Tue, 30 Sep 2025 23:58:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm25581517f8f.24.2025.09.30.23.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 23:58:44 -0700 (PDT)
Message-ID: <d715d9dd-a613-4406-93c1-507d1470619f@redhat.com>
Date: Wed, 1 Oct 2025 08:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
To: John Levon <levon@movementarian.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, eric.auger@redhat.com, joao.m.martins@oracle.com
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
 <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
 <aNxT1w0BbMH6pJ0J@movementarian.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
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
In-Reply-To: <aNxT1w0BbMH6pJ0J@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 00:04, John Levon wrote:
> On Tue, Sep 30, 2025 at 05:26:59PM +0200, Cédric Le Goater wrote:
> 
>>> -        }
>>> +        ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
>>
>> Could we introduce an helper to test 'unmap_all' support in the host
>> kernel ? The result would be something like :
>>
>>    if (unmap_all) {
>>          if (vfio_legacy_has_unmap_all(VFIO_IOMMU_LEGACY(bcontainer))) {
>>              flags = VFIO_DMA_UNMAP_FLAG_ALL;
>>          } else {
>>              /* The unmap ioctl doesn't accept a full 64-bit span. */
>>              Int128 llsize = int128_rshift(int128_2_64(), 1);
>>              ...
>>          }
>>    }
> 
> For reference/consideration, the previous approach taken in the vfio-user
> series:
> 
> https://lore.kernel.org/qemu-devel/20250219144858.266455-4-john.levon@nutanix.com/
> 
> @@ -533,6 +562,11 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>       vfio_get_info_iova_range(info, bcontainer);
>   
>       vfio_get_iommu_info_migration(container, info);
> +
> +    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
> +
> +    container->unmap_all_supported = (ret != 0);
> 
> (I dropped this particular change as part of getting merged.)
Yes. I’m reconsidering now.

Should we introduce a VFIOContainerBase attribute/flag 'unmap_all_supported',
set in the vioc->setup handler ?

Thanks,

C.


