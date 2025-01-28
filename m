Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09932C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tct1M-0005SG-0g; Tue, 28 Jan 2025 16:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tct1K-0005RI-6r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:21:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tct1I-00059O-L6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738099275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lFy29Xq+1HOxTqMFytnWbSTJPhKDue4PhhbAG73HmVY=;
 b=HR7yLWz/K9bt00oRdyCEyCnWLYDmBXFUd9MoUO1OVbNVFuZwrae6ied6K8NBTmfoQ7WBT/
 6hzRf1aOPFKAxe5WMpic+JCeM9rVFntB2soQstgq1Cqm3abw5hkQNgtYY3Xon6y34OCqql
 CHfx2zCWwddSBKJCPu74oG+wOZqBKyA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-HcfUQ4vqPueX-UkDGmoO1w-1; Tue, 28 Jan 2025 16:21:11 -0500
X-MC-Unique: HcfUQ4vqPueX-UkDGmoO1w-1
X-Mimecast-MFC-AGG-ID: HcfUQ4vqPueX-UkDGmoO1w
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467948b2902so1726631cf.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 13:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738099271; x=1738704071;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFy29Xq+1HOxTqMFytnWbSTJPhKDue4PhhbAG73HmVY=;
 b=m1BpwKhQHOBM53uRZ9TviDsinu5sXUQj/plGFMnqvLAUq1uZqRevplbKw6bhZFu/6x
 xX8vkr/1DTaPD9crAsINW8QaCVsCSDuh7QmFeamHjMRx5KHO0DcSsTV0oOMx/ohxViOW
 kcClKgBETwk9ldRTyAVPJX8TLoY0yOpCd4+oVqFFGB/iLJBE7chRaZ5AQQsBKM+ovcq7
 N5ONgP3g0nVFslxB4eUDlW2Nys/M3BuSbWydbfFaFJWZgO2Qa8Qb8sEEL2HkXGrijPN9
 JgwKwwl09j5yJi9jMRIeYFnkyij3lOBbPyZytqNqrE0J+rp8s2bmFgsgwKL8+NnqEouc
 oUQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUubLU7hdnpoa+2at/dPEjcqP5VCU3Bl7iu9Mw8cVkH/klM8NQobJ6TpxF2lwRf4V+nVZNkKsTgyKHa@nongnu.org
X-Gm-Message-State: AOJu0YztkZhoBRynGAJ4oWwOjAmvdpyrJgZ9CVXTYM+Ikal+fU/jRdOJ
 N+OsQd55TFpJnDa3Jjg34tqvBzwr4xGDTztz30QBOjdv0A/g7J/MaC22YEbXu4qwv0zswzwUekz
 rR3Vma6/T91cFHOgRR4XAgJ2rXZ8pNlBzX9M25w6M5oXhtbfS4WFB
X-Gm-Gg: ASbGncvYaMn5CYZT8PtlwssMWfGGmZD30z2RR83p0Y3zBsWUUL4pV2RtJ5CXK8kEO8p
 6Wed+4Q4f+1OuSL2kfIxvECc7lL6UJcnprQ9SO5K5qzNTsZaDvggoHejrmzrP/C2wdO+CT06bN3
 UaPayk+f7k24bFNG5gWkDjQQie/iVOehdacAP99ud3U2n6Kdr55Z/gwam+pTDEQW2qzP1rmeY+8
 OeELVTG1prCZOv3/06okd7KKhFzEiO8cABLphVc4agcozwc0QF9M79EitXjziHEH6Ygh8yMAiw8
 utDBDUVPMRnah2aduiYIiPjruEwYEalD+ztOGi0gUY0=
X-Received: by 2002:a05:622a:2289:b0:467:5cfb:bd40 with SMTP id
 d75a77b69052e-46fd0821ff4mr13109681cf.19.1738099270765; 
 Tue, 28 Jan 2025 13:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwd2M7M2saXyqnIpTqVfahX1tAjdwXCe2KU/qZokWK/4n/gbXEECJVf0XTJdBiJmfKl9+orQ==
X-Received: by 2002:a05:622a:2289:b0:467:5cfb:bd40 with SMTP id
 d75a77b69052e-46fd0821ff4mr13109411cf.19.1738099270422; 
 Tue, 28 Jan 2025 13:21:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6687e9desm55982721cf.29.2025.01.28.13.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 13:21:09 -0800 (PST)
Message-ID: <6fa2c0ba-68d7-45ce-86e9-ec9e695cc893@redhat.com>
Date: Tue, 28 Jan 2025 22:21:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc64 mac99 test
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20250128180742.1137741-1-clg@redhat.com>
 <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
 <9bf6cf01-d8c4-4ed8-808d-03e6ee05bc7b@redhat.com>
 <c2dce6f7-7b76-7531-7013-366c9d7eac4e@eik.bme.hu>
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
In-Reply-To: <c2dce6f7-7b76-7531-7013-366c9d7eac4e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


>>>> +        self.vm.set_console()
>>>> +
>>>> +        self.vm.add_args('-kernel', linux_path,
>>>> +                         '-append', 'root=/dev/sda',
>>>> +                         '-drive', f'file={rootfs_path},format=raw',
>>>> +                         '-net', 'nic,model=sungem', '-net', 'user',
> 
> The machine already has a default sungem NIC so maybe you can omit that too. 

Yes. It works well without it. Will remove the nic.

> The user network used to be the default so even that may not be needed but I'm not sure if that's still the case since libslirp was moved out. Wasn't the preferred option -netdev user nowadays and -device for the card?
> 
>>>> +                         '-snapshot', '-nographic')
>>>
>>> I just also noticed that we already have "-display none" in python/qemu/machine/machine.py, so you likely don't need the -nographic here (but looks like we've got that wrong in a bunch of tests already).
>>
>> I think we need -nographic else OpenBIOS crashes.  I will check.
> 
> It should not crash 

It doesn't crash indeed, but it complains :

   2025-01-28 21:55:24,498: >> CPU type PowerPC,970FX
   2025-01-28 21:55:24,501: milliseconds isn't unique.
   2025-01-28 21:55:24,540: Output device screen not found.
   2025-01-28 21:55:24,545: Output device screen not found.
   2025-01-28 21:55:24,548: >> [ppc] Kernel already loaded (0x01000000 + 0x014a8b58) (initrd 0x00000000 + 0x00000000)
   2025-01-28 21:55:24,548: >> [ppc] Kernel command line: root=/dev/sda
   2025-01-28 21:55:24,560: >> switching to new context:
   2025-01-28 21:55:24,567: NULL ihandle
   2025-01-28 21:55:24,567: Unexpected client interface exception: -2

and there is no console ouput. With -nographic :

   2025-01-28 22:19:42,938: >> CPU type PowerPC,970FX
   2025-01-28 22:19:42,941: milliseconds isn't unique.
   2025-01-28 22:19:42,993: Welcome to OpenBIOS v1.1 built on Sep 24 2024 19:56
   2025-01-28 22:19:42,997: >> [ppc] Kernel already loaded (0x01000000 + 0x014a8b58) (initrd 0x00000000 + 0x00000000)
   2025-01-28 22:19:42,997: >> [ppc] Kernel command line: root=/dev/sda
   2025-01-28 22:19:43,010: >> switching to new context:
   2025-01-28 22:19:43,018: OF stdout device is: /pci@f0000000/mac-io@c/escc@13000/ch-a@13020


> but maybe it displays then on the graphics output so you won't get the needed feedback on serial? Although -append 'console=tty<whatever it's called on that machine>' might fix that. 

Nope.

> But using -nographic makes sense for a serial only test.

I will keep -nographic  for this test.

Thanks,
C.



