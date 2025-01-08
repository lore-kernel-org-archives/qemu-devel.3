Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C5EE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 10:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVTax-0001Oh-10; Wed, 08 Jan 2025 05:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVTaZ-0001NM-GR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVTaV-00066t-IX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736333216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eKOVuF1tVCFrg4xucSl9Z48GxMlerwz+1iYVX23nAJo=;
 b=D/FuragK0r3JXlJihYCFvO4RHqCHXgn+uD77XNsk++VwMFCuACWZ+Y/TL+AApKPrvdksQB
 n+Bid3ZUcToJ2PzVcUU6vuLHVOgMmpBPThynpGBOdkA+AhHgPUx4kJsV2TzOQcA12/ySCz
 Fr2fuIz5h4fKf5HrJ8O4QtMiz+F4Q/g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Mzi3Td3vOla-cZ6G36J8JQ-1; Wed, 08 Jan 2025 05:46:53 -0500
X-MC-Unique: Mzi3Td3vOla-cZ6G36J8JQ-1
X-Mimecast-MFC-AGG-ID: Mzi3Td3vOla-cZ6G36J8JQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467982f8816so360433691cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 02:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736333213; x=1736938013;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKOVuF1tVCFrg4xucSl9Z48GxMlerwz+1iYVX23nAJo=;
 b=Mz1+zUjqmqDqtJRA52ebg7hRnrIfJunynaH2S3zxn5WdhmwBv8+XEUUyEhwOY17wUi
 AcZDR7nqC6Hy+7CIOWrNHhtE09aXJlgnC0uyAPo1j/EI4pozK0wKqRP/rjEyWB106s66
 RmvveoLwykW237rdZRoevFVtyl/ksTyvLklVZXelUxirqIFJqA3cRds3JjJMxiitPC1U
 wtqGPXRTLOObBayVqJ2ThVXm3xed0fYYZ37feBx1J2Ibr4dlkEBhY/sDkDqcS8tNl/l4
 pGAjaGk6Fum13wFd7e9gb3zBB+wSunK8EXeq4jD5FgKY5qBwvs/n5Tlb7vm3+rbl6yzY
 jdMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXpXDtRenDpuvBuNib64ci1WcBtwTQNPzOhvAMlmzZvsV3Rd9eR6u/tLZ1P5cNqBRIRlIVu0ArgZhR@nongnu.org
X-Gm-Message-State: AOJu0Yy+n+zLYSzJnCGnyEzZ/3VegjKiEABVh+LSC1PdZlx8UjDlKI/k
 Od8TMdD1G7koswq3u7MQ6BBM6WQ67t9pUkSGqpXhO0DMv6j3hYIWADha1uEh3YcMi4PGRrHisvJ
 0mXJWAenPYTDsv4wTKfP4+KDn7uv1yXgN8/uXLgoKF+qVUtnPq1Fg
X-Gm-Gg: ASbGncvFEEV6wnw57uMxwvbEOkExTj3cwfnRe7ZywlyxwKqTPa7I2nxKxcPKHnNaGTk
 kc0flOohA+Yyn3oTPkBw5UgaXwPuPeIN10hurcvhdZKdmSdaN2iqNa+WmlB0mbkH6Ji/LVovWeK
 BBdiP1Jav1dXihcA3JaetP+zmoaGCszb1EaFn58gQBUAo6W29BRm8yKiQwvbExzuas7qyjmFoUZ
 KQUd2Jwe90Z11hwojA2c3QhzA/U32KBwOSfMilLL1PmHAy/ijG3zaawKm6wRFJsYM4Yq8icLau8
 tQJoFBBrxK5EGcAeA3A=
X-Received: by 2002:ac8:5794:0:b0:467:6dd9:c961 with SMTP id
 d75a77b69052e-46c710a4f02mr28016111cf.48.1736333213234; 
 Wed, 08 Jan 2025 02:46:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK47uiDlgJtg/4kQK8COlCIoJrIr9bKiqI/L0bHKtW9PtVCCnVcQfN6tLQ9abWcOlsu2555g==
X-Received: by 2002:ac8:5794:0:b0:467:6dd9:c961 with SMTP id
 d75a77b69052e-46c710a4f02mr28015961cf.48.1736333212888; 
 Wed, 08 Jan 2025 02:46:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6a106fsm194493711cf.38.2025.01.08.02.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 02:46:52 -0800 (PST)
Message-ID: <11cbdc49-668d-4f73-b5a8-cdaa4c85a756@redhat.com>
Date: Wed, 8 Jan 2025 11:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Remove sd_set_cb()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20250108100240.960593-1-clg@redhat.com>
 <76dfa092-7d20-46db-beb1-43848cb5ee4f@linaro.org>
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
In-Reply-To: <76dfa092-7d20-46db-beb1-43848cb5ee4f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 1/8/25 11:43, Philippe Mathieu-Daudé wrote:
> On 8/1/25 11:02, Cédric Le Goater wrote:
>> Last user of sd_set_cb() was removed in commit ce5dd27534b0 ("hw/sd:
>> Remove omap2_mmc device").
> 
> https://lore.kernel.org/qemu-devel/20240903200446.25921-2-philmd@linaro.org/
> ;)
> 

Ah ! good. I was wondering what to do of the '*_cb' IRQs and
'me_no_qdev_me_kill_mammoth_with_rocks' too. You dropped them
all.

Thanks,

C.



