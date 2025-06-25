Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DDAC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 08:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUL8S-0001MO-MA; Wed, 25 Jun 2025 04:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUL8N-0001LF-Rl
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUL8E-00083x-TE
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750838721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yu2LqTbA83PUG04X9JPOeH3v0JzuPJz0We/mnLD0hnk=;
 b=ijIGteUmHc6OMhsxsx1Nv0CTSwEOvLsebpr3uLG5JCBtgsw4aBSzxS664IGU+MoUjwaNQA
 KzMQqrO4oCEaOLrkm7SL72/4mRDKLRfEwq0uHxdybblvSrvBawE9vZxcGWVDjGsdQwkGSD
 kCX7cebIvd0poLDgrmq2KUcwo+GcBPI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-lIeWS6mVPcWPepLF64qQzA-1; Wed, 25 Jun 2025 04:05:19 -0400
X-MC-Unique: lIeWS6mVPcWPepLF64qQzA-1
X-Mimecast-MFC-AGG-ID: lIeWS6mVPcWPepLF64qQzA_1750838718
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so8258785e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 01:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750838718; x=1751443518;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yu2LqTbA83PUG04X9JPOeH3v0JzuPJz0We/mnLD0hnk=;
 b=sb8thz0InngryChwNW0YtGAIU+a5yju6um+5U6N/FZ4MLPnjdYOUVmg4xHSY+sv083
 ND3klRY99tvOa74OofJvfI0cckM4Un3RgDc99rTzA2KkYnlv0UA6TIDihzdfnKs6yXkZ
 BE3x3s9WdpFEaRnyVZwWWkl+GMHq+Fyq1z06weTMZAbAYopjn65GGZIEvQpLQup8kWd3
 Jv2IS5vQrLQF7pEwR8AptdUfVA18kjTuITvPiGlebleHobTede7MmyfZYD1LbPtLF+Dv
 bq0/a6IeBFqz5VTXXy1bsr8m6ESzzmyECsHVNtOOzR4XEzSke7WImal0gE8KSVp3uyk3
 g2ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAJ3kElcP+fDAb7v1DPs2fKXzt5pobYUkigCYsM62iqYghRQjyKFFSg3jhmy2hzMmiXmaYE/Q7phGw@nongnu.org
X-Gm-Message-State: AOJu0YzDRfnuApGKMV2bAE6eF11SEhXIINzF2uu6rZfjcotSq3Mphoow
 aKyFG7Amvvprqc2GxOkGB1XkMz2bOg+ufWMtjPCJK4JDG2iavofQGwB8/994QI0zsikhsuuif5c
 Wfk1km9gAQLzdnEvk1onnozrcX4mYoLkfLQdqG66DFW57plLEOd+JzL5z
X-Gm-Gg: ASbGncu4u6XRGvYndc4Me7xknlyGCvGagAbBc1Rhvv3+V22qOmyJM+r+NmI0iXWk3lO
 q4xxU4pmD/tin8iNHzENRz78Qby6n8OT7TmQNWjr9kJMklqmm9PqO5J60NEN+C2tIfZ4JA42ReS
 qHJ6UxpClPyL7a5Stlh8BM7JSY3j/Wa2Jf1/KY0N/SO2uugWQcM3uxNu6mV9yAWKKoBDZKmMegE
 BHeUsdPsgGaZj0HNVKe//kzgjTLCZZQ9nnCgg6OhdpTDosuoHpK2DlBMP/1G4lw2s6sQ3oOFKY5
 7YvUWTDl7wnkTkv4pWJGGM6Rp8eP/0bmgCCCQCKxBj9Uvfvze0UbEYIOYYun
X-Received: by 2002:a5d:5f4a:0:b0:3a5:8d9d:27fa with SMTP id
 ffacd0b85a97d-3a6ed61f739mr1499314f8f.3.1750838718170; 
 Wed, 25 Jun 2025 01:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErKIQRgJLgmrcnh01WNH1q71RaVqAoM2ktmbWtedEiRm45hVwTsY2uhVZioI/v1EW5oN1h2w==
X-Received: by 2002:a5d:5f4a:0:b0:3a5:8d9d:27fa with SMTP id
 ffacd0b85a97d-3a6ed61f739mr1499262f8f.3.1750838717523; 
 Wed, 25 Jun 2025 01:05:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6f08ae34fsm308867f8f.36.2025.06.25.01.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 01:05:17 -0700 (PDT)
Message-ID: <241d6ad8-4fd0-44f6-bf84-05e932a2a0e0@redhat.com>
Date: Wed, 25 Jun 2025 10:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] vfio-user: implement message send infrastructure
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
 <20250619133154.264786-5-john.levon@nutanix.com>
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
In-Reply-To: <20250619133154.264786-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/19/25 15:31, John Levon wrote:
> Add plumbing for sending vfio-user messages on the control socket.
> Add initial version negotation on connection.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/protocol.h   |  62 +++++
>   hw/vfio-user/proxy.h      |   9 +
>   hw/vfio-user/pci.c        |  20 +-
>   hw/vfio-user/proxy.c      | 494 ++++++++++++++++++++++++++++++++++++++
>   hw/vfio-user/trace-events |   2 +
>   5 files changed, 585 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> index 4ddfb5f222..2d52d0fb10 100644
> --- a/hw/vfio-user/protocol.h
> +++ b/hw/vfio-user/protocol.h
> @@ -50,4 +50,66 @@ enum vfio_user_command {
>   #define VFIO_USER_NO_REPLY      0x10
>   #define VFIO_USER_ERROR         0x20
>   
> +
> +/*
> + * VFIO_USER_VERSION
> + */
> +typedef struct {
> +    VFIOUserHdr hdr;
> +    uint16_t major;
> +    uint16_t minor;
> +    char capabilities[];
> +} VFIOUserVersion;
> +
> +#define VFIO_USER_MAJOR_VER     0
> +#define VFIO_USER_MINOR_VER     0
> +
> +#define VFIO_USER_CAP           "capabilities"
> +
> +/* "capabilities" members */
> +#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
> +#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
> +#define VFIO_USER_CAP_PGSIZES   "pgsizes"
> +#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
> +#define VFIO_USER_CAP_MIGR      "migration"
> +
> +/* "migration" members */
> +#define VFIO_USER_CAP_PGSIZE            "pgsize"
> +#define VFIO_USER_CAP_MAX_BITMAP        "max_bitmap_size"
> +
> +/*
> + * Max FDs mainly comes into play when a device supports multiple interrupts
> + * where each ones uses an eventfd to inject it into the guest.
> + * It is clamped by the the number of FDs the qio channel supports in a
> + * single message.
> + */
> +#define VFIO_USER_DEF_MAX_FDS   8
> +#define VFIO_USER_MAX_MAX_FDS   16
> +
> +/*
> + * Max transfer limits the amount of data in region and DMA messages.
> + * Region R/W will be very small (limited by how much a single instruction
> + * can process) so just use a reasonable limit here.
> + */
> +#define VFIO_USER_DEF_MAX_XFER  (1024 * 1024)
> +#define VFIO_USER_MAX_MAX_XFER  (64 * 1024 * 1024)
> +
> +/*
> + * Default pagesizes supported is 4k.
> + */
> +#define VFIO_USER_DEF_PGSIZE    4096
> +
> +/*
> + * Default max number of DMA mappings is stolen from the
> + * linux kernel "dma_entry_limit"
> + */
> +#define VFIO_USER_DEF_MAP_MAX   65535
> +
> +/*
> + * Default max bitmap size is also take from the linux kernel,
> + * where usage of signed ints limits the VA range to 2^31 bytes.
> + * Dividing that by the number of bits per byte yields 256MB
> + */
> +#define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
> +
>   #endif /* VFIO_USER_PROTOCOL_H */
> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> index ff553cad9d..5bc890a0f5 100644
> --- a/hw/vfio-user/proxy.h
> +++ b/hw/vfio-user/proxy.h
> @@ -37,6 +37,7 @@ typedef struct VFIOUserMsg {
>       uint32_t id;
>       QemuCond cv;
>       bool complete;
> +    bool pending;
>       enum msg_type type;
>   } VFIOUserMsg;
>   
> @@ -56,6 +57,12 @@ typedef struct VFIOUserProxy {
>       struct QIOChannel *ioc;
>       void (*request)(void *opaque, VFIOUserMsg *msg);
>       void *req_arg;
> +    uint64_t max_xfer_size;
> +    uint64_t max_send_fds;
> +    uint64_t max_dma;
> +    uint64_t dma_pgsizes;
> +    uint64_t max_bitmap;
> +    uint64_t migr_pgsize;
>       int flags;
>       QemuCond close_cv;
>       AioContext *ctx;
> @@ -78,6 +85,7 @@ typedef struct VFIOUserProxy {
>   
>   /* VFIOProxy flags */
>   #define VFIO_PROXY_CLIENT        0x1
> +#define VFIO_PROXY_FORCE_QUEUED  0x4
>   
>   typedef struct VFIODevice VFIODevice;
>   
> @@ -86,5 +94,6 @@ void vfio_user_disconnect(VFIOUserProxy *proxy);
>   void vfio_user_set_handler(VFIODevice *vbasedev,
>                              void (*handler)(void *opaque, VFIOUserMsg *msg),
>                              void *reqarg);
> +bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
>   
>   #endif /* VFIO_USER_PROXY_H */
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index bad2829f5c..61f525cf4a 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -20,6 +20,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
>   struct VFIOUserPCIDevice {
>       VFIOPCIDevice device;
>       SocketAddress *socket;
> +    bool send_queued;   /* all sends are queued */
>   };
>   
>   /*
> @@ -92,6 +93,16 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
>       vbasedev->proxy = proxy;
>       vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
>   
> +    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
> +
> +    if (udev->send_queued) {
> +        proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
> +    }
> +
> +    if (!vfio_user_validate_version(proxy, errp)) {
> +        goto error;
> +    }
> +
>       /*
>        * vfio-user devices are effectively mdevs (don't use a host iommu).
>        */
> @@ -101,9 +112,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
>       if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
>                                             vbasedev->name, vbasedev,
>                                             as, errp)) {
> -        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
> -        return;
> +        goto error;
>       }
> +
> +    return;
> +
> +error:
> +    error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>   }
>   
>   static void vfio_user_instance_init(Object *obj)
> @@ -153,6 +168,7 @@ static const Property vfio_user_pci_dev_properties[] = {
>                          sub_vendor_id, PCI_ANY_ID),
>       DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                          sub_device_id, PCI_ANY_ID),
> +    DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
>   };
>   
>   static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 31e08cbad3..0887d0aa1a 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -13,14 +13,19 @@
>   #include "hw/vfio-user/proxy.h"
>   #include "hw/vfio-user/trace.h"
>   #include "qapi/error.h"
> +#include "qobject/qdict.h"
> +#include "qobject/qjson.h"
> +#include "qobject/qnum.h"
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
>   #include "system/iothread.h"
>   
> +static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
>   static IOThread *vfio_user_iothread;
>   
>   static void vfio_user_shutdown(VFIOUserProxy *proxy);
> +static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
>   static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
>                                        VFIOUserFDs *fds);
>   static VFIOUserFDs *vfio_user_getfds(int numfds);
> @@ -28,9 +33,16 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
>   
>   static void vfio_user_recv(void *opaque);
>   static int vfio_user_recv_one(VFIOUserProxy *proxy);
> +static void vfio_user_send(void *opaque);
> +static int vfio_user_send_one(VFIOUserProxy *proxy);
>   static void vfio_user_cb(void *opaque);
>   
>   static void vfio_user_request(void *opaque);
> +static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
> +static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> +                                VFIOUserFDs *fds, int rsize);
> +static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
> +                                  uint32_t size, uint32_t flags);
>   
>   static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
>   {
> @@ -49,6 +61,35 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
>                                      proxy->ctx, NULL, NULL);
>   }
>   
> +static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg)
> +{
> +    VFIOUserFDs *fds =  msg->fds;
> +    struct iovec iov = {
> +        .iov_base = msg->hdr,
> +        .iov_len = msg->hdr->size,
> +    };
> +    size_t numfds = 0;
> +    int ret, *fdp = NULL;
> +    Error *local_err = NULL;
> +
> +    if (fds != NULL && fds->send_fds != 0) {
> +        numfds = fds->send_fds;
> +        fdp = fds->fds;
> +    }
> +
> +    ret = qio_channel_writev_full(proxy->ioc, &iov, 1, fdp, numfds, 0,
> +                                  &local_err);
> +
> +    if (ret == -1) {
> +        vfio_user_set_error(msg->hdr, EIO);
> +        vfio_user_shutdown(proxy);
> +        error_report_err(local_err);
> +    }
> +    trace_vfio_user_send_write(msg->hdr->id, ret);
> +
> +    return ret;
> +}
> +
>   static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
>                                        VFIOUserFDs *fds)
>   {
> @@ -89,6 +130,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
>       msg->hdr = NULL;
>       msg->fds = NULL;
>       msg->complete = false;
> +    msg->pending = false;
>       QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
>   }
>   
> @@ -383,6 +425,54 @@ err:
>       return -1;
>   }
>   
> +/*
> + * Send messages from outgoing queue when the socket buffer has space.
> + * If we deplete 'outgoing', remove ourselves from the poll list.
> + */
> +static void vfio_user_send(void *opaque)
> +{
> +    VFIOUserProxy *proxy = opaque;
> +
> +    QEMU_LOCK_GUARD(&proxy->lock);
> +
> +    if (proxy->state == VFIO_PROXY_CONNECTED) {
> +        while (!QTAILQ_EMPTY(&proxy->outgoing)) {
> +            if (vfio_user_send_one(proxy) < 0) {
> +                return;
> +            }
> +        }
> +        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
> +                                       vfio_user_recv, NULL, NULL, proxy);
> +    }
> +}
> +
> +/*
> + * Send a single message.
> + *
> + * Sent async messages are freed, others are moved to pending queue.
> + */
> +static int vfio_user_send_one(VFIOUserProxy *proxy)
> +{
> +    VFIOUserMsg *msg;
> +    int ret;
> +
> +    msg = QTAILQ_FIRST(&proxy->outgoing);
> +    ret = vfio_user_send_qio(proxy, msg);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    QTAILQ_REMOVE(&proxy->outgoing, msg, next);
> +    if (msg->type == VFIO_MSG_ASYNC) {
> +        vfio_user_recycle(proxy, msg);
> +    } else {
> +        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
> +        msg->pending = true;
> +    }
> +
> +    return 0;
> +}
> +
>   static void vfio_user_cb(void *opaque)
>   {
>       VFIOUserProxy *proxy = opaque;
> @@ -444,6 +534,119 @@ static void vfio_user_request(void *opaque)
>       }
>   }
>   
> +/*
> + * Messages are queued onto the proxy's outgoing list.
> + *
> + * It handles 3 types of messages:
> + *
> + * async messages - replies and posted writes
> + *
> + * There will be no reply from the server, so message
> + * buffers are freed after they're sent.
> + *
> + * nowait messages - map/unmap during address space transactions
> + *
> + * These are also sent async, but a reply is expected so that
> + * vfio_wait_reqs() can wait for the youngest nowait request.
> + * They transition from the outgoing list to the pending list
> + * when sent, and are freed when the reply is received.
> + *
> + * wait messages - all other requests
> + *
> + * The reply to these messages is waited for by their caller.
> + * They also transition from outgoing to pending when sent, but
> + * the message buffer is returned to the caller with the reply
> + * contents.  The caller is responsible for freeing these messages.
> + *
> + * As an optimization, if the outgoing list and the socket send
> + * buffer are empty, the message is sent inline instead of being
> + * added to the outgoing list.  The rest of the transitions are
> + * unchanged.
> + *
> + * returns 0 if the message was sent or queued
> + * returns -1 on send error
> + */
> +static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
> +{
> +    int ret;
> +
> +    /*
> +     * Unsent outgoing msgs - add to tail
> +     */
> +    if (!QTAILQ_EMPTY(&proxy->outgoing)) {
> +        QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
> +        return 0;
> +    }
> +
> +    /*
> +     * Try inline - if blocked, queue it and kick send poller
> +     */
> +    if (proxy->flags & VFIO_PROXY_FORCE_QUEUED) {
> +        ret = QIO_CHANNEL_ERR_BLOCK;
> +    } else {
> +        ret = vfio_user_send_qio(proxy, msg);
> +    }
> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +        QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
> +        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
> +                                       vfio_user_recv, proxy->ctx,
> +                                       vfio_user_send, proxy);
> +        return 0;
> +    }
> +    if (ret == -1) {
> +        return ret;
> +    }
> +
> +    /*
> +     * Sent - free async, add others to pending
> +     */
> +    if (msg->type == VFIO_MSG_ASYNC) {
> +        vfio_user_recycle(proxy, msg);
> +    } else {
> +        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
> +        msg->pending = true;
> +    }
> +
> +    return 0;
> +}
> +
> +static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
> +                                VFIOUserFDs *fds, int rsize)
> +{
> +    VFIOUserMsg *msg;
> +    int ret;
> +
> +    if (hdr->flags & VFIO_USER_NO_REPLY) {
> +        error_printf("vfio_user_send_wait on async message\n");

This error could be reported to the caller : vfio_user_validate_version()


Thanks,

C.



> +        vfio_user_set_error(hdr, EINVAL);
> +        return;
> +    }
> +
> +    qemu_mutex_lock(&proxy->lock);
> +
> +    msg = vfio_user_getmsg(proxy, hdr, fds);
> +    msg->id = hdr->id;
> +    msg->rsize = rsize ? rsize : hdr->size;
> +    msg->type = VFIO_MSG_WAIT;
> +
> +    ret = vfio_user_send_queued(proxy, msg);
> +
> +    if (ret == 0) {
> +        while (!msg->complete) {
> +            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
> +                VFIOUserMsgQ *list;
> +
> +                list = msg->pending ? &proxy->pending : &proxy->outgoing;
> +                QTAILQ_REMOVE(list, msg, next);
> +                vfio_user_set_error(hdr, ETIMEDOUT);
> +                break;
> +            }
> +        }
> +    }
> +    vfio_user_recycle(proxy, msg);
> +
> +    qemu_mutex_unlock(&proxy->lock);
> +}
>   
>   static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
>       QLIST_HEAD_INITIALIZER(vfio_user_sockets);
> @@ -472,6 +675,15 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>       proxy = g_malloc0(sizeof(VFIOUserProxy));
>       proxy->sockname = g_strdup_printf("unix:%s", sockname);
>       proxy->ioc = ioc;
> +
> +    /* init defaults */
> +    proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
> +    proxy->max_send_fds = VFIO_USER_DEF_MAX_FDS;
> +    proxy->max_dma = VFIO_USER_DEF_MAP_MAX;
> +    proxy->dma_pgsizes = VFIO_USER_DEF_PGSIZE;
> +    proxy->max_bitmap = VFIO_USER_DEF_MAX_BITMAP;
> +    proxy->migr_pgsize = VFIO_USER_DEF_PGSIZE;
> +
>       proxy->flags = VFIO_PROXY_CLIENT;
>       proxy->state = VFIO_PROXY_CONNECTED;
>   
> @@ -569,3 +781,285 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
>       g_free(proxy->sockname);
>       g_free(proxy);
>   }
> +
> +static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
> +                                  uint32_t size, uint32_t flags)
> +{
> +    static uint16_t next_id;
> +
> +    hdr->id = qatomic_fetch_inc(&next_id);
> +    hdr->command = cmd;
> +    hdr->size = size;
> +    hdr->flags = (flags & ~VFIO_USER_TYPE) | VFIO_USER_REQUEST;
> +    hdr->error_reply = 0;
> +}
> +
> +struct cap_entry {
> +    const char *name;
> +    bool (*check)(VFIOUserProxy *proxy, QObject *qobj, Error **errp);
> +};
> +
> +static bool caps_parse(VFIOUserProxy *proxy, QDict *qdict,
> +                       struct cap_entry caps[], Error **errp)
> +{
> +    QObject *qobj;
> +    struct cap_entry *p;
> +
> +    for (p = caps; p->name != NULL; p++) {
> +        qobj = qdict_get(qdict, p->name);
> +        if (qobj != NULL) {
> +            if (!p->check(proxy, qobj, errp)) {
> +                return false;
> +            }
> +            qdict_del(qdict, p->name);
> +        }
> +    }
> +
> +    /* warning, for now */
> +    if (qdict_size(qdict) != 0) {
> +        warn_report("spurious capabilities");
> +    }
> +    return true;
> +}
> +
> +static bool check_migr_pgsize(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +    QNum *qn = qobject_to(QNum, qobj);
> +    uint64_t pgsize;
> +
> +    if (qn == NULL || !qnum_get_try_uint(qn, &pgsize)) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZE);
> +        return false;
> +    }
> +
> +    /* must be larger than default */
> +    if (pgsize & (VFIO_USER_DEF_PGSIZE - 1)) {
> +        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsize);
> +        return false;
> +    }
> +
> +    proxy->migr_pgsize = pgsize;
> +    return true;
> +}
> +
> +static bool check_bitmap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +    QNum *qn = qobject_to(QNum, qobj);
> +    uint64_t bitmap_size;
> +
> +    if (qn == NULL || !qnum_get_try_uint(qn, &bitmap_size)) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_BITMAP);
> +        return false;
> +    }
> +
> +    /* can only lower it */
> +    if (bitmap_size > VFIO_USER_DEF_MAX_BITMAP) {
> +        error_setg(errp, "%s too large", VFIO_USER_CAP_MAX_BITMAP);
> +        return false;
> +    }
> +
> +    proxy->max_bitmap = bitmap_size;
> +    return true;
> +}
> +
> +static struct cap_entry caps_migr[] = {
> +    { VFIO_USER_CAP_PGSIZE, check_migr_pgsize },
> +    { VFIO_USER_CAP_MAX_BITMAP, check_bitmap },
> +    { NULL }
> +};
> +
> +static bool check_max_fds(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +    QNum *qn = qobject_to(QNum, qobj);
> +    uint64_t max_send_fds;
> +
> +    if (qn == NULL || !qnum_get_try_uint(qn, &max_send_fds) ||
> +        max_send_fds > VFIO_USER_MAX_MAX_FDS) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
> +        return false;
> +    }
> +    proxy->max_send_fds = max_send_fds;
> +    return true;
> +}
> +
> +static bool check_max_xfer(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +    QNum *qn = qobject_to(QNum, qobj);
> +    uint64_t max_xfer_size;
> +
> +    if (qn == NULL || !qnum_get_try_uint(qn, &max_xfer_size) ||
> +        max_xfer_size > VFIO_USER_MAX_MAX_XFER) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_XFER);
> +        return false;
> +    }
> +    proxy->max_xfer_size = max_xfer_size;
> +    return true;
> +}
> +
> +static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +    QNum *qn = qobject_to(QNum, qobj);
> +    uint64_t pgsizes;
> +
> +    if (qn == NULL || !qnum_get_try_uint(qn, &pgsizes)) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZES);
> +        return false;
> +    }
> +
> +    /* must be larger than default */
> +    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
> +        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
> +        return false;
> +    }
> +
> +    proxy->dma_pgsizes = pgsizes;
> +    return true;
> +}
> +
> +static bool check_max_dma(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +    QNum *qn = qobject_to(QNum, qobj);
> +    uint64_t max_dma;
> +
> +    if (qn == NULL || !qnum_get_try_uint(qn, &max_dma)) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAP_MAX);
> +        return false;
> +    }
> +
> +    /* can only lower it */
> +    if (max_dma > VFIO_USER_DEF_MAP_MAX) {
> +        error_setg(errp, "%s too large", VFIO_USER_CAP_MAP_MAX);
> +        return false;
> +    }
> +
> +    proxy->max_dma = max_dma;
> +    return true;
> +}
> +
> +static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +    QDict *qdict = qobject_to(QDict, qobj);
> +
> +    if (qdict == NULL) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
> +        return true;
> +    }
> +    return caps_parse(proxy, qdict, caps_migr, errp);
> +}
> +
> +static struct cap_entry caps_cap[] = {
> +    { VFIO_USER_CAP_MAX_FDS, check_max_fds },
> +    { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
> +    { VFIO_USER_CAP_PGSIZES, check_pgsizes },
> +    { VFIO_USER_CAP_MAP_MAX, check_max_dma },
> +    { VFIO_USER_CAP_MIGR, check_migr },
> +    { NULL }
> +};
> +
> +static bool check_cap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
> +{
> +   QDict *qdict = qobject_to(QDict, qobj);
> +
> +    if (qdict == NULL) {
> +        error_setg(errp, "malformed %s", VFIO_USER_CAP);
> +        return false;
> +    }
> +    return caps_parse(proxy, qdict, caps_cap, errp);
> +}
> +
> +static struct cap_entry ver_0_0[] = {
> +    { VFIO_USER_CAP, check_cap },
> +    { NULL }
> +};
> +
> +static bool caps_check(VFIOUserProxy *proxy, int minor, const char *caps,
> +                       Error **errp)
> +{
> +    QObject *qobj;
> +    QDict *qdict;
> +    bool ret;
> +
> +    qobj = qobject_from_json(caps, NULL);
> +    if (qobj == NULL) {
> +        error_setg(errp, "malformed capabilities %s", caps);
> +        return false;
> +    }
> +    qdict = qobject_to(QDict, qobj);
> +    if (qdict == NULL) {
> +        error_setg(errp, "capabilities %s not an object", caps);
> +        qobject_unref(qobj);
> +        return false;
> +    }
> +    ret = caps_parse(proxy, qdict, ver_0_0, errp);
> +
> +    qobject_unref(qobj);
> +    return ret;
> +}
> +
> +static GString *caps_json(void)
> +{
> +    QDict *dict = qdict_new();
> +    QDict *capdict = qdict_new();
> +    QDict *migdict = qdict_new();
> +    GString *str;
> +
> +    qdict_put_int(migdict, VFIO_USER_CAP_PGSIZE, VFIO_USER_DEF_PGSIZE);
> +    qdict_put_int(migdict, VFIO_USER_CAP_MAX_BITMAP, VFIO_USER_DEF_MAX_BITMAP);
> +    qdict_put_obj(capdict, VFIO_USER_CAP_MIGR, QOBJECT(migdict));
> +
> +    qdict_put_int(capdict, VFIO_USER_CAP_MAX_FDS, VFIO_USER_MAX_MAX_FDS);
> +    qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
> +    qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
> +    qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
> +
> +    qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
> +
> +    str = qobject_to_json(QOBJECT(dict));
> +    qobject_unref(dict);
> +    return str;
> +}
> +
> +bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
> +{
> +    g_autofree VFIOUserVersion *msgp = NULL;
> +    GString *caps;
> +    char *reply;
> +    int size, caplen;
> +
> +    caps = caps_json();
> +    caplen = caps->len + 1;
> +    size = sizeof(*msgp) + caplen;
> +    msgp = g_malloc0(size);
> +
> +    vfio_user_request_msg(&msgp->hdr, VFIO_USER_VERSION, size, 0);
> +    msgp->major = VFIO_USER_MAJOR_VER;
> +    msgp->minor = VFIO_USER_MINOR_VER;
> +    memcpy(&msgp->capabilities, caps->str, caplen);
> +    g_string_free(caps, true);
> +    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
> +
> +    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
> +    if (msgp->hdr.flags & VFIO_USER_ERROR) {
> +        error_setg_errno(errp, msgp->hdr.error_reply, "version reply");
> +        return false;
> +    }
> +
> +    if (msgp->major != VFIO_USER_MAJOR_VER ||
> +        msgp->minor > VFIO_USER_MINOR_VER) {
> +        error_setg(errp, "incompatible server version");
> +        return false;
> +    }
> +
> +    reply = msgp->capabilities;
> +    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
> +        error_setg(errp, "corrupt version reply");
> +        return false;
> +    }
> +
> +    if (!caps_check(proxy, msgp->minor, reply, errp)) {
> +        return false;
> +    }
> +
> +    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
> +    return true;
> +}
> diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
> index 89d6c11c4c..7a3645024f 100644
> --- a/hw/vfio-user/trace-events
> +++ b/hw/vfio-user/trace-events
> @@ -4,3 +4,5 @@
>   vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
>   vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
>   vfio_user_recv_request(uint16_t cmd) " command 0x%x"
> +vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
> +vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"


