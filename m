Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78472C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 10:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHgit-0001x9-IE; Wed, 21 May 2025 06:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHgir-0001wR-BF
 for qemu-devel@nongnu.org; Wed, 21 May 2025 06:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHgip-00071W-Ng
 for qemu-devel@nongnu.org; Wed, 21 May 2025 06:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747823450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cN1YLYnvTi+B7Iyz5E6cIEozGw69QZ/dhP/brWpKmw8=;
 b=bMBMqtn6jlt89lcpkhdTqLXxv0ExiCubafQkF+IZb3lsgsMvufgQ89Az1i9PRvsvw1bRAp
 zoHoF6ML63OSm497MTr3xeiU3QXIjJeFmVIYHww9owpC7tykhv+dV4owFKQFWcA9XM2OxV
 yCtXxuES2AK16YKURtnVILMwlO2FrGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-WNsGbnPbOKKcYuFTMoU61g-1; Wed, 21 May 2025 06:30:49 -0400
X-MC-Unique: WNsGbnPbOKKcYuFTMoU61g-1
X-Mimecast-MFC-AGG-ID: WNsGbnPbOKKcYuFTMoU61g_1747823448
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so38060235e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 03:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747823448; x=1748428248;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cN1YLYnvTi+B7Iyz5E6cIEozGw69QZ/dhP/brWpKmw8=;
 b=ABvvQyt+148eIsrzZVMi80AeCIv1BzGt9pNN7Yv/M9XXnWz4Uj5Daelae44UqSbnHl
 C9vGd4mY8flIKDTYlYVa8Eei8jKRWmF++PUX2fQ/vZWp5VC8WTAxo6V1TkFjbRQY1ASK
 1f6Ew9qGjpRHHOpKwOXhUFYRZ/OyRxmtbox3EMmgoPSUZ+oWhspPi1eRX+p8fW3I91XT
 BunimB0D/lws2thCxNizbEdW1yQ1kLz6fU2FL8vz1yYB1OR+famfTlg8T7B0SRqe9m7d
 f3Z7KXXcRREl9hoOe0eyHwhJOlFvRXR/u2zdfUt5A226lUFSl73SkVYFo4lcMkMk7pAp
 MzWA==
X-Gm-Message-State: AOJu0Yz2XFiLYLhw3CAeByPbqi+j/P2io9hE/iMyebqSFMw4iSWgfmy/
 ox7XGwe16hM+PhTZEX9/Vf3gQZ9R+c1FesPxq1sQuG4MObE1tHLUR1eeEgmN/3g27ALDkwenRz5
 kY24fexWYPNlJbkCj+1jrlBO9YxyTb6d2In1/0edwVtZyKlNzwytXQez+W5Bh+p2VzCc=
X-Gm-Gg: ASbGnctShOO6lKW1oVHIY3mB/02q+u/1wm0hJHeFdhdLIdPFxnP9bHYTJV9EcY+jFCf
 KjgZ/76DqbIEE890mbnaNsNLuNIE8KPwaZ2DRJok/szCf0NU78WEAvQlbYhcJscEMCkLDzYVL+o
 yoENMOJyUzLHalKX3aaWuWC+u8cqZ6S0w0iMFDNEPVWKWyOwF2VOYUWfQvRkZN/G9MPuyWdJifg
 wMGSIPSqaTlkNjpVknpITAv+I5XNnQjBuwhrdfmU9eMSb0DITSLI9ea/oTO3C7Whl9SLup+blzj
 gtYOKWIUd7JywrKhcOD3ohDnMRVtHPymRH94gmeP5wDScbBwPQ==
X-Received: by 2002:a05:600c:1c16:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-442ff029e12mr154807815e9.23.1747823447690; 
 Wed, 21 May 2025 03:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8sT2Oi2RHQiPqu+qPpUwHuUqXrWADnU7B0VCaMKQxgsEhpoZ56rgcHmh1dP60KUzD0nftqw==
X-Received: by 2002:a05:600c:1c16:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-442ff029e12mr154807505e9.23.1747823447334; 
 Wed, 21 May 2025 03:30:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7ca2dd9sm62590245e9.37.2025.05.21.03.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 03:30:46 -0700 (PDT)
Message-ID: <f69c26fc-3cdb-469d-8f46-127c0c20cecb@redhat.com>
Date: Wed, 21 May 2025 12:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: OpRegion not found fix error typo
To: "edmund.raile" <edmund.raile@protonmail.com>,
 "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
References: <MFFbQoTpea_CK5ELq8oJ-a3Q57wo7ywQlrIqDvdIDKhUuCm59VUz2QzvdojO5r_wb_7SHifU0Kym3loj4eASPhdzYpjtiMCTePzyg1zrroo=@protonmail.com>
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
In-Reply-To: <MFFbQoTpea_CK5ELq8oJ-a3Q57wo7ywQlrIqDvdIDKhUuCm59VUz2QzvdojO5r_wb_7SHifU0Kym3loj4eASPhdzYpjtiMCTePzyg1zrroo=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On 5/19/25 13:24, edmund.raile wrote:
> Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
> ---
>   hw/vfio/igd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e54a2a2f00..36ceb85212 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -203,7 +203,7 @@ static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
>                       VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
>       if (ret) {
>           error_setg_errno(errp, -ret,
> -                         "Device does not supports IGD OpRegion feature");
> +                         "Device does not support IGD OpRegion feature");
>           return false;
>       }
>   


Applied to vfio-next.

Thanks,

C.



