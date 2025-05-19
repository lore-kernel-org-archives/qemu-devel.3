Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7394DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzYm-0007no-KU; Mon, 19 May 2025 08:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGzYe-0007nM-4Q
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGzYY-0005iw-8J
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747657519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=weO7OZ75B7qu0mumLEBxplrst1P5z4e9IkV0lFp9LUo=;
 b=RmjaYnvwcQ94GWZJeNw0fe1KlXWuqfCW8vxgc0uhe8gcmEOTBYuFTGjR+CLTjmEin4z4AL
 vnBANy9L2yqQS+vLUazkkZ8tw3P+gmoX7s3qWupn/TqXw3dFPOIzY4OdaeT24qriUoniKV
 MByddw3FW6QUR9k1uGjYosoAG1h+JxM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-4RWc0eOCMlmF11h9SVU2LA-1; Mon, 19 May 2025 08:25:18 -0400
X-MC-Unique: 4RWc0eOCMlmF11h9SVU2LA-1
X-Mimecast-MFC-AGG-ID: 4RWc0eOCMlmF11h9SVU2LA_1747657517
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so22291765e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657517; x=1748262317;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weO7OZ75B7qu0mumLEBxplrst1P5z4e9IkV0lFp9LUo=;
 b=kHxw0FJcGTOzDc7Sg6ctPj2aFCmPhd+Lx3eYPkrqOWsYVRgVvqictdST+K8QUpEfcq
 21ya/w9wfXXvKK1UfiHNdO2Ol0cm/IagRUHnSaSjKwfitu9oYPVgL6h8kg9wQjr3BB5Q
 uF4DkB50W4JY2ZJkJGcF+Hgm/QVb26jrYO1tGOvVjeInQ/B8qqbe5k92qWCw27M/nBTw
 X8rkVZpQ0pLIGNU3kbRLii4jQ165aKywQMi5TEBTPs3gJef1Mfrjj9jJaj2KRQVukVBL
 2QVjxt9vafiECQKWpTk0tjV/ImahaXJxpCXyiGOMnXJLu0HjucRCgQBFyK0jOojJMlEL
 0w4w==
X-Gm-Message-State: AOJu0YyK03glrO0y4MTkGQp35HMYYztvH/8+AAG7dYAMzAOPKfuqyWSr
 KEOWREzo6aZjoNl5R+ucLUT41ChgmN07ewX0FHhGeVR77SubLGzX3cuHloLOwzqswe//71+W/cm
 bKhmNZ6Lt5poRnTb7AQC/nJSpw4Tf4oOfONlQoNNMs9M9fnellZip9pDr
X-Gm-Gg: ASbGnct5BaQ/koTNX0ZG2r9Fhsf1Jo39a7/BY84ATfbtOq2EfgY6i6WwPKfeMpG8aPL
 FzokVWumSIRm9A2SBguXFoRQ5tPgqRr2LyonC/P/c6BIroAoKacFn440fyypWzYAMkkao8UN4b0
 SevOZLvzEKlobDLoeFGtJKwIh9szed5rQlqC4+CbYCoxh6b5zY2VQqjt8vxPm0wuyC/YQ9hGs7S
 dN8gxpzyPdTE0PmiHY8N8gztAUXGmsuMr2ee1Yrha+4uS1MDDDUZkCFgYQJaFF+xYxMmEHic+rK
 DKJgll7XQkAqxazq5eNIxg6SS10HSQikHLBsQrRtKOs/IXeh5w==
X-Received: by 2002:a05:600c:3e0e:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-442fd60a57cmr117804775e9.7.1747657516949; 
 Mon, 19 May 2025 05:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXpiDeS5tPY7GCC9tcmHUZMlwRt6c1Y/1ExLZsL5lLYi6aDsRmWM18tzxFcF3gotYN558TUA==
X-Received: by 2002:a05:600c:3e0e:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-442fd60a57cmr117804575e9.7.1747657516598; 
 Mon, 19 May 2025 05:25:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59ab3esm140804755e9.40.2025.05.19.05.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 05:25:16 -0700 (PDT)
Message-ID: <227ed6bf-8b5c-4492-b74e-46ac318782d1@redhat.com>
Date: Mon, 19 May 2025 14:25:15 +0200
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


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


