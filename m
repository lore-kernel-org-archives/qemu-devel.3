Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBBA106FD9B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0x9K-0005Qf-UE; Fri, 13 Mar 2026 03:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0x9B-0005P3-VG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0x98-0005oO-Lp
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773387678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jU0akz5EnGmscyMHD4mfi5dcDWGY4AU5wQ9gD0umUsU=;
 b=QEVS7rCEpxw/Ay4zVI21oiK0itclosJcz9qVXsASWHB5EFL3ahiCuEEDVtSK40iIia9zjQ
 hDZs96puyc+/fTYKp6KzdeBuLKLO0C3oM32A1FsVWYrSKo7JA2909OS39VjCl71RnHigFv
 Xh6c5DhcdPI5TNq5qUVXeKihGRPEu0c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-ByN0CH9fNLuRRdGBSu-hWQ-1; Fri, 13 Mar 2026 03:41:17 -0400
X-MC-Unique: ByN0CH9fNLuRRdGBSu-hWQ-1
X-Mimecast-MFC-AGG-ID: ByN0CH9fNLuRRdGBSu-hWQ_1773387676
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48541cac34dso17020985e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773387676; x=1773992476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jU0akz5EnGmscyMHD4mfi5dcDWGY4AU5wQ9gD0umUsU=;
 b=MQLuT/FoqTxcQP6XGFAcBVnOCiQmIEWYgiDdH7X8cf0RNdNAzoFNf9HELswQiIgI/S
 gi5/denl5rgbXJmHy3fM+ZABSlfdktGPkFINIv5SKtt9YrtEn8G/xcq1zoLKEGMavvfa
 QIxyt+CjNFui270qpkAZC2RWxFh41FlXrlgYmQO4pgbp63AfU5wc4A31aT/Oi+/aSDsF
 5F043YAq5woUJvCpg5+/xXI5RYMVGCbM1ggSnvHu32cV6lCj2jXTYFSES/6/slScagCd
 Y1/A1HZb6rkF07d8zGpg9EGz+cUb2BBjWu/BHy2G8xbs9WPuiZ5bYByw61ZO6s1jRV2Z
 A/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773387676; x=1773992476;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jU0akz5EnGmscyMHD4mfi5dcDWGY4AU5wQ9gD0umUsU=;
 b=MuDJMLlTPdBSmZY7j+MfQFv9KCToqidT1jhOIzKx1ufEaBEkQOu3y5REbhiaWcM+q6
 rRd15yLvbDRqNBflCKaOP37Ue/TYj5G7mJr08SJDGbUUh49UswrVwJ8KaBBldsVVe4IG
 JUA+zo4R9r5+bl0DpdQv8Fyn9u/6nbtS5FrOammNa4y+0UMWSXPywjMk1PbewwrqvXTP
 uG8kaiXdjbx02yeWrTLNu/1dMHvwQezzevZSH+DEUzNroa/8CT+yi05q7saZn4VGB2s8
 RE/eHUAK1T4SK/7uO9LE3dv08EQPbHirm5KUvBiomTX6/WYA2BFZn4ViIoAHbbj519he
 uAxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo/2ewEeTRSNNoNR7i0w+xSX3Fe7HjDDmRmabz0FTDhVDPGP5+704PU186IHaDYNjiLipt4kMcMyVj@nongnu.org
X-Gm-Message-State: AOJu0YwdZISV6WLqyNpYvaqHO8EkpAC9dIvxvgYlAspp6Es+mlAYWMyF
 2XbOenb6Ks2XJ+TwROfTpROTcn8hgQgmZzOrVKzYUW2liZiV0IHw4SV08Dn4Qto2FbRfrHvMlWE
 8U+HcDoKlN+h5wD87JeMUW/jZif4dJaElWS+WOfAavZ4uzOydiNiglIT2
X-Gm-Gg: ATEYQzxmlu9DVAQPGTXDSBv+y96ZUWYbiYRXyBEcyywvPUDidG1PLuToeIloOjApkVV
 O0zm9RmCKALojCWlDzFxTxRvqEc5BjpO7q75B6zggy1dVyvpyKjWAqYG9X7iC35BWYrn2UFfbql
 3AR87s3ebLfGNuJ/3eNr4MQe5kdTr2KKl1nJzywTbKFsR16KHGRfw2mOvcKwhvkJIWw5mu6fyiS
 U4bgGEqAbrhp1VyB2++2wSwtaP3hyYIKFFKtshH2tTL6U18dSKZ8jZXHhYUVDlS9TZgRSX99bhE
 1EODE8k55V1z56MsNKw8n+HCrLo8KXFbL0Ux4rRgSIQOpp+/pBElbZepTe3JOqyW2sAQGXshTkO
 YfXmqZ2qr6WWCtgy+hYjPAIoQYqLos9jNHfiC7nYDEVdDZ8FQ31/zKJ7zSC3Q
X-Received: by 2002:a05:600c:4583:b0:485:3983:aba8 with SMTP id
 5b1f17b1804b1-4855670530dmr29503955e9.27.1773387675848; 
 Fri, 13 Mar 2026 00:41:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4583:b0:485:3983:aba8 with SMTP id
 5b1f17b1804b1-4855670530dmr29503685e9.27.1773387675458; 
 Fri, 13 Mar 2026 00:41:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48558fd09d8sm27998315e9.7.2026.03.13.00.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 00:41:14 -0700 (PDT)
Message-ID: <ef5f20a5-a143-4ef1-b331-79c71f35218f@redhat.com>
Date: Fri, 13 Mar 2026 08:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
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

On 3/12/26 23:44, Pierrick Bouvier wrote:
> Code concerned is under a kvm_enabled() guard.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/listener.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 960da9e0a93..31c3113f8fb 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -20,9 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
> -#ifdef CONFIG_KVM
>   #include <linux/kvm.h>
> -#endif
>   #include <linux/vfio.h>
>   
>   #include "exec/target_page.h"
> @@ -303,11 +301,9 @@ static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
>       if (bcontainer->dma_max_mappings) {
>           unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
>   
> -#ifdef CONFIG_KVM
>           if (kvm_enabled()) {
>               max_memslots = kvm_get_max_memslots();
>           }
> -#endif
>   
>           QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
>               hwaddr start, end;

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


