Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37386C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYvg-00062H-Mx; Tue, 15 Jul 2025 02:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYuo-0005Md-CC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYul-0004In-6h
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752559996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5x8+wM7O2OpUKd4Qng94w7OvTiM42FK/AkT0bBDJwyo=;
 b=Iwi4LT42Bt51r6ehSvgfD78AhgSV8JtjcIo7PJcNn2E23EEmHdMX2W6Qj23R76INkUJ4Dy
 6pdDNWBQKcy85DdF1KEfqxW7bntNMwIcS6C/t8+H1ns52YjvSwxDlSlz005QBVe2v2iNca
 1zBMi3mdOoOi+XycLVvchpAiYIyQwXo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-0uRI90uYOS6zh_xiZSqK8w-1; Tue, 15 Jul 2025 02:13:14 -0400
X-MC-Unique: 0uRI90uYOS6zh_xiZSqK8w-1
X-Mimecast-MFC-AGG-ID: 0uRI90uYOS6zh_xiZSqK8w_1752559993
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso3306894f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752559993; x=1753164793;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5x8+wM7O2OpUKd4Qng94w7OvTiM42FK/AkT0bBDJwyo=;
 b=Mx32dQ7qOmMAVva1ow2JVQDrutEAuXc01VefwpjVbYOOxhjq0CcGoiofNrqblRl81T
 uatW6CgozCREVov3Np56NXHQFPTS7/3wychs05ac9fGUfnsL0N4AMaTPzT6J9Hq3+33Q
 ZCqYgFPrWSkhkDxGALHKVP3ylK0ggUdWAQITRz1FVxWLdZbIPgL8ERin08WtR8olZmnx
 gFK/5G9P22wH38dlbmkh3wV0Ar/6IV+sXtATekY6Pmlmpbc0KZFhUqg0WJPzvxJaq1tS
 4PbntmcA1z2gHOe5xWp+XIdtYqrBlvSLCNZ/qDV1Nkni5T3VgElq7PnLkH6mdK8HCru1
 kaBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Te8eEb5qzoM00zyeBEOZVQ5UTlUgfjMLh9gG7uWmrwfqPhteBsODUNLfD6K1M+n/JRXXWH24UOCV@nongnu.org
X-Gm-Message-State: AOJu0YyeugHyIl1QPoep1yzEx/IBx3AdcLio3OP5ZjorRFa7H+CtfjUX
 lV5ZtS3RSxwWHGioYiJNk8P5roRspnOmUdlqFHWgfAP1EY84mbuAtlreS3rbz+nBr/y/FKTZo6j
 JEE7C6wRuzmpQdJLMUDadDiB/6KmVOnlmtna/LL4D8Kxy1OLw6FDmS0yh
X-Gm-Gg: ASbGnctrzPJhHY7vRoP3UT/TmvKpcLmPJFjdVZzdlkLw3zrIcObhY8eSUDlNgwCADVl
 81c47L4heyNSQAt4hkf88B+e1sfod1iX2iY3w4Ck3I8WOL9RAUUSmeixVg3iOxpsw2J36OUUIRQ
 Azk2daHJa6ikEsckcNgwMI6l1pWDrx0mU5Wvp7uPkFInJdRF0Q2nwViyVvi4Rj1gVWwZ2ZeqWtz
 SJNHSU3odT5aqAow4FKY7G8qF/0s5ODnZkipXA61+AuLXd94wH45X/JxvIpvT50F+paont0c1c2
 3Bxrh9ztIxWafDffu1dEYn11xe0U8uHWCntnkUODVgUGUeKSp61ul9fyq3um4TGEnVRgUMVTglI
 =
X-Received: by 2002:a5d:64e4:0:b0:3ab:27f9:e4f with SMTP id
 ffacd0b85a97d-3b5f2e1b872mr12138081f8f.35.1752559992736; 
 Mon, 14 Jul 2025 23:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnJq2sw5ZPSoWTxT6RagPbrxhwXVqPvUOc4VTC95qGVGqr3iNifDbXnsdvE30zVJ++kdK8Yg==
X-Received: by 2002:a5d:64e4:0:b0:3ab:27f9:e4f with SMTP id
 ffacd0b85a97d-3b5f2e1b872mr12138057f8f.35.1752559992333; 
 Mon, 14 Jul 2025 23:13:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1ecbsm14058060f8f.25.2025.07.14.23.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:13:11 -0700 (PDT)
Message-ID: <7f8f262f-3490-4588-82b5-20b6af340f45@redhat.com>
Date: Tue, 15 Jul 2025 08:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/11] docs: add support for gb200-bmc
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ed Tanous <etanous@nvidia.com>
References: <20250704083723.1410455-1-clg@redhat.com>
 <20250704083723.1410455-10-clg@redhat.com>
 <CAFEAcA9-wpDS2_4paQgswqB=NfgxadvGB8WULWGqQXV7d47-Mg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA9-wpDS2_4paQgswqB=NfgxadvGB8WULWGqQXV7d47-Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/11/25 14:01, Peter Maydell wrote:
> On Fri, 4 Jul 2025 at 09:39, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> From: Ed Tanous <etanous@nvidia.com>
>>
>> This patch updates the docs for support of gb200-bmc.
>>
>> Signed-off-by: Ed Tanous <etanous@nvidia.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-3-etanous@nvidia.com
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   docs/system/arm/aspeed.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
>> index 43d27d83cb54..bec0a1dfa8b8 100644
>> --- a/docs/system/arm/aspeed.rst
>> +++ b/docs/system/arm/aspeed.rst
>> @@ -1,5 +1,4 @@
>> -Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
>> -=================================================================================================================================================================================================================================================================================================================================================================================================================================
>> +Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
> 
> Hi. This change removed the "======" underlining from the title, which
> has broken the rendering not just of this page but also of the list of
> arm boards in the parent doc:

Oh. I missed that. Sorry.

May be we should reduce the line by removing the machine names ?

   Aspeed family boards
   ====================

or is there a specific reason to keep them ?

Thanks,

C.


>   https://www.qemu.org/docs/master/system/target-arm.html
> as it now has all of aspeed.rst's second-level headers in it.
> 
> Could you send a patch to reinstate the underlines, please?
> 
> thanks
> -- PMM
> 


