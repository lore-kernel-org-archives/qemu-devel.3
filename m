Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ECCFED2F0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bZu-00056Z-Q0; Thu, 12 Mar 2026 04:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0bZs-00055r-MV
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0bZp-0004AJ-Sd
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773304769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6keMSC1wIvTvN70FmLg3L5xmdRwuwEXhub7hUyjTJZM=;
 b=Gcl3AbYBVG8u6mc6fvt7UeNyx2dzvzaFNMnqIqV74Tw4ZCcmTpoBSsOYEADXHrBi7S6VZp
 CjBD3AKlNi/KEBKJQ9+h4uIV2vZO1PD4xcp42oTsB4TjanXMOs9zzZPVjF0nBuJIio2d+3
 3vWbpudA5U3SW+lbHcSFvAMOTF3R8jk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-J9y8pIIhPjWgO_vs0m7QEw-1; Thu, 12 Mar 2026 04:39:27 -0400
X-MC-Unique: J9y8pIIhPjWgO_vs0m7QEw-1
X-Mimecast-MFC-AGG-ID: J9y8pIIhPjWgO_vs0m7QEw_1773304766
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso888845f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773304766; x=1773909566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6keMSC1wIvTvN70FmLg3L5xmdRwuwEXhub7hUyjTJZM=;
 b=C97hSF/QLj1cXhkybyQJvjA4RvuYIlxNRkRpN4+g777mrl93bpU0hIxYOQaCQLJtFU
 LajtvdXkyhNmZ2AOoBtwwcX2dPvqOY3G9O3SlKNjKbZdFr1Ax99vYPvxPzCE+zzbWe6n
 Xw6Q90E+KzhTpOzeclERlcGPbK3iE/kua6WvEKoflaAVIToEdv3PsntJP4s961rQy4XP
 RNz8l9u/HZHnROl7XoBK1C3MekOH2UYOXmKkebxsl2Q7f+wZobjym+nkw0cm8ZbFK7jx
 qcWMomw5ZiMwXYn4BD2fxlF940hx4/puJYdhCtbXECF+gGXerWgo7HbdyEK7Vhv2Y4lc
 1Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773304766; x=1773909566;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6keMSC1wIvTvN70FmLg3L5xmdRwuwEXhub7hUyjTJZM=;
 b=J04PkOX/CgeA6CUDE1dvrQG4cQHM6npTHgiUoRt1AbFhldol86V/2ZExASUtxU5dvm
 dhuN3E4CDT9T4ndpaIbeKH3v2FtqJOmMWEaOYx3VElM3TabLyTca9s/XFkTe5devPkoI
 CIUdkjccnKYb5Lc7eoiJekY9tkHOTnMppLL9ri3UEe7QPUt2dZl5U36wuf6weQcecTLL
 hve+Yp+llJvAuaIWJwi0jMF+FdkP3Ca76WxlqMIlIJc3BoYoqdw0PXHxeDxf1ke+JcFZ
 BPrwPeuAr+xDi22YM0/3prC7JwUczQQ8zqwhGg2gyiIlkHu60T9jhrJGOHR1M+2yhDnm
 4dkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLpXzi+wKH4POgSsWv7h+NGzm+80JykVnYHowcmbB/ILvC1zb0HMar/mBHX+RLPCi0ZgXXw/zrQCvk@nongnu.org
X-Gm-Message-State: AOJu0YwxNyLJVoEujtliQydOdDH1OtyjD4i5NxTfzwk4V/hZbTpNOgLx
 n4EAAw9hUFuJgg7a6iJFAgBcsfYI6bZ5ICALjvRjPHOEcreBQTxXI3vavzQ9oUi6SPLrWpPVe4b
 +8kalqYgojIX3sYltiu6N6UNyAJ9cp+oA5UfX5z3TN6YT6ndTnRS9QXxN
X-Gm-Gg: ATEYQzwUjlbbLEUe0aJ6TnWZDlGikCR7N5/vc1ll53L4fnXulFtbnuQQGSW7S6J/Or0
 FXGFT934QXvfMk2Btbz68XOT7b2vWl7jOLLALKN1S0eLDAfAOz25OdrC2i0EvskExN/jC6d3U6X
 IqNVD3tv/DgzQL0GR99HfglzQ7ob6OYZBkdlvMAqk5c8qekvWvHfFh2Gfh1cIliuHDzmOE9EJbb
 L2z0Nsp6WPw1HD2WmAjpZKUDXQCSdQWWxXh7jqvYbzeUzKq0PCZ0iUP+0S7rbP6c5gDvfJh9+Ks
 mZOSsOmm1wGvnyWhk+Km4L/IpPjwIhcj0KPz6SZp3WKNDbS5NxeSTWxZ3zp++kfsGoLG46OVq6O
 kcgroj7O2g1gRlFej1oasLFADfKmIdWpbn25aUzv7X4tRoZH3kRmyuq9U8xOT
X-Received: by 2002:a05:6000:40c8:b0:439:f605:aff0 with SMTP id
 ffacd0b85a97d-439f8200ae7mr10364351f8f.18.1773304765851; 
 Thu, 12 Mar 2026 01:39:25 -0700 (PDT)
X-Received: by 2002:a05:6000:40c8:b0:439:f605:aff0 with SMTP id
 ffacd0b85a97d-439f8200ae7mr10364291f8f.18.1773304765319; 
 Thu, 12 Mar 2026 01:39:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22529csm5643808f8f.31.2026.03.12.01.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 01:39:24 -0700 (PDT)
Message-ID: <d19fb981-7acb-417a-9b33-cb697066b2bc@redhat.com>
Date: Thu, 12 Mar 2026 09:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Nathan Chen <nathanc@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com> <87tsuonp7r.fsf@pond.sub.org>
 <CH3PR12MB754899F3426FCB494EA7154FAB46A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <87v7f1xxv3.fsf@pond.sub.org>
 <CH3PR12MB75485C39AB4ECE0B594C8C92AB44A@CH3PR12MB7548.namprd12.prod.outlook.com>
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
In-Reply-To: <CH3PR12MB75485C39AB4ECE0B594C8C92AB44A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 09:33, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: 12 March 2026 08:21
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>> Cc: Nathan Chen <nathanc@nvidia.com>; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org; Yi Liu <yi.l.liu@intel.com>; Eric Auger
>> <eric.auger@redhat.com>; Zhenzhong Duan <zhenzhong.duan@intel.com>;
>> Peter Maydell <peter.maydell@linaro.org>; Shannon Zhao
>> <shannon.zhaosl@gmail.com>; Michael S . Tsirkin <mst@redhat.com>; Igor
>> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>;
>> Paolo Bonzini <pbonzini@redhat.com>; Daniel P.Berrangé
>> <berrange@redhat.com>; Alex Williamson <alex@shazbot.org>; Cédric Le
>> Goater <clg@redhat.com>; Eric Blake <eblake@redhat.com>
>> Subject: Re: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
>> auto parameters
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Shameer Kolothum Thodi <skolothumtho@nvidia.com> writes:
>>
>>>> -----Original Message-----
>>>> From: Markus Armbruster <armbru@redhat.com>
>>
>> [...]
>>
>>>> Nathan Chen <nathanc@nvidia.com> writes:
>>>>
>>>>> From: Nathan Chen <nathanc@nvidia.com>
>>>>>
>>>>> Introduce smmuv3_accel_auto_finalise() to resolve properties that
>>>>> are set to 'auto' for accelerated SMMUv3. This helper function
>>>>> allows properties such as ATS, RIL, SSIDSIZE, and OAS support to be
>>>>> resolved from host IOMMU values, while avoiding triggering
>>>>> auto-resolved values for hot-plugged devices.
>>>>>
>>>>> Auto mode requires at least one cold-plugged device to retrieve and
>>>>> finalise these properties, and we fail boot if that is not the
>>>>> case.
>>>>>
>>>>> Subsequent patches will make use of this helper to set the values
>>>>> when we convert the values to OnOffAuto. New auto_mode and
>>>>> auto_finalised bool members are added to SMMUv3AccelState.
>>>>> smmuv3_accel_init() will set auto_mode to true when 'auto' is
>>>>> detected for the accel SMMUv3 properties.
>>>>> smmuv3_accel_auto_finalise() will set auto_finalised to true after
>>>>> all 'auto' properties are resolved, and subsequent calls to this
>>>>> function will return early if auto_finalised is set to true.
>>>>>
>>>>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>>>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>>>>> ---
>>>>>   hw/arm/smmuv3-accel.c | 38
>> +++++++++++++++++++++++++++++++++--
>>>> ---
>>>>>   hw/arm/smmuv3-accel.h |  2 ++
>>>>>   2 files changed, 35 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c index
>>>>> 17306cd04b..617629bacd 100644
>>>>> --- a/hw/arm/smmuv3-accel.c
>>>>> +++ b/hw/arm/smmuv3-accel.c
>>>>> @@ -35,11 +35,34 @@ static int smmuv3_oas_bits(uint32_t oas)
>>>>>       return map[oas];
>>>>>   }
>>>>>
>>>>> +static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice
>> *pdev,
>>>>> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
>>>>> +    SMMUv3AccelState *accel = s->s_accel;
>>>>> +
>>>>> +    /* Return if no auto for any or finalised already */
>>>>> +    if (!accel->auto_mode || accel->auto_finalised) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    /* We can't update if device is hotplugged */
>>>>> +    if (DEVICE(pdev)->hotplugged) {
>>>>> +        warn_report("arm-smmuv3: 'auto' feature property detected,
>>>>> + but host
>>>> "
>>>>> +                    "value cannot be applied for hot-plugged device; using "
>>>>> +                    "existing value");
>>>>
>>>> Why is this warning useful?
>>>>
>>>> Does @auto's meaning depend on whether the device is cold- or
>>>> hot-plugged?
>>>
>>> If SMMUv3 accel=on and properties are set to "auto", we require at
>>> least one cold-plugged vfio-pci device to retrieve the associated host
>>> SMMUv3 information and finalise the QEMU SMMUv3 properties.
>>>
>>> In this series, "auto_mode" is set if any accel property is specified
>>> as "auto". The properties are then finalised using the first
>>> cold-plugged device and "auto_finalised" is set.
>>>
>>> Since we later fail the guest boot(see below) in the reset phase if
>>> auto_mode is set but auto_finalised is still false, the above hotplug
>>> case should not really happen. In that case the VM would not boot.
>>
>> Sounds complicated.
>>
>>> So likely we can get rid of the hotplug check above. Need to do a bit
>>> more testing to confirm we cover all corner cases.
>>>
>>>>
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    accel->auto_finalised = true;
>>>>> +}
>>
>> [...]
>>
>>>>> @@ -867,8 +891,12 @@ bool
>> smmuv3_accel_attach_gbpa_hwpt(SMMUv3State
>>>>> *s, Error **errp)
>>>>>
>>>>>   void smmuv3_accel_reset(SMMUv3State *s)  {
>>>>> -     /* Attach a HWPT based on GBPA reset value */
>>>>> -     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
>>>>> +    if (s->s_accel && s->s_accel->auto_mode &&
>>>>> + !s->s_accel->auto_finalised)
>>>> {
>>>>> +        error_report("AUTO mode specified but properties not finalised.");
>>>>> +        exit(1);
>>>>
>>>> How can we get here?
>>>
>>> This is reached from the SMMUv3 reset handler when auto mode is
>>> specified but no cold-plugged device has been attached to finalise the
>>> accelerated SMMUv3 properties.
>>>
>>> If no such device is present, "auto_finalised" remains false and we hit
>>> this path during reset.
>>>
>>> Cédric mentioned that we should not exit during the reset phase. If that
>>> is the case, we likely need another way to handle the scenario where
>>> auto mode is specified but no cold-plugged device is present.
>>
>> What exactly does the "auto" feature buy us?  Is it worth the
>> complexity?
> 
> The requirement came from the KubeVirt folks. It is easier for them if
> QEMU can probe the platform and set these values, instead of specifying
> them for each platform.
> 
> See:
> https://lore.kernel.org/qemu-devel/d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com/
> 
> Without "auto", the management layer needs to know the values supported
> on each platform.
> 
> eg: on a GB200, it will look like,
> 
> -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.0,accel=on,ats=on,ril=off,ssidsize=20,oas=48
> 
> With "auto" it can simply be:
> 
> -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.0,accel=on
> 
> (provided a vfio-pci device is cold-plugged).

how about,

   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.0,accel=on,iommufd=iommufd0

and smmuv3_accel_init() would check that the conditions are correct.

Thanks,

C.



