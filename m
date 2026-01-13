Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8242D29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaSn-0002Gx-TW; Tue, 13 Jan 2026 04:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfaSm-0002Fn-JE
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfaSl-0007MI-5b
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768295597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q7YBuQ6r5CAtsR1AvTqI6U8ZDPomC1nXwMLhIwwvnVA=;
 b=ImobCCO0xRi/w7bEeakS6AdRTfK3kD1n70o6mBEsLPU7rKA80xyppyb1sSWy6hwbpd1l6K
 q9o/5zCMAsB4mLP5Zu8uNu34amZSKAamUw4XcSpGuY+64Qhg911S3W6pIvuEHJF5/pfOPr
 GHfh7iMGMN4JhyNlWzjbGS7z2KTnNAM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-reVYs0RkOOa7rSqpUlIQ9w-1; Tue, 13 Jan 2026 04:13:13 -0500
X-MC-Unique: reVYs0RkOOa7rSqpUlIQ9w-1
X-Mimecast-MFC-AGG-ID: reVYs0RkOOa7rSqpUlIQ9w_1768295592
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f4609e80so3926404f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 01:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768295592; x=1768900392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7YBuQ6r5CAtsR1AvTqI6U8ZDPomC1nXwMLhIwwvnVA=;
 b=rlBNZox+B5AxZqFPa13H+Wu8nxLg6Jpc+khaJOVUbjl8d19uxpSEWIICQPvApz++G4
 J9Po7ra3byr5qKBg+zUcv+dns6cHpzN+7guGdaC+tmmeh0T3AJB51ldq6bS3oOJ6ls+4
 s0c6UXoQRys8rRQptphD2gl8JWBVkTPnyNXumIvyIBtwlG8UGUruDCIttmdECTDarOkD
 QU9iZL4Tf5PFM2wp516mJF1HfGAlcdjmUHHQd88L3LA1BfRYV8ZIU/ux4aFfl0t/n76s
 MPrL+Z49+911bIe3BCIMLTkcCkLozZC9V1kAAkr74GEgh9Nx2I41PdpzFIlCNLQryBeS
 RSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768295592; x=1768900392;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7YBuQ6r5CAtsR1AvTqI6U8ZDPomC1nXwMLhIwwvnVA=;
 b=U4R0vG3hiV/hqS+IZN3yEIvg9JdYJNs61tHqD4szuFllHY4yM9C/vGBuS8vZD8MPiW
 xt+c6k36jY7UmfFOhjx5vf0d7BwO97vhRD1Vx1jmlcpfs8Q/9oWDk3bKowEaqPcqcxV+
 R5xyamAWCEIeqZ6I/7AcG31LSSE51k17krafbJXXGhp9Q1Kp8fj+M67Mt/hHM/8by4yk
 ylfnrk5XZVqztdwKU2S5dIS6kavrm9TW7uKSrALCVOrrkZhRJ9rqzqJEqsyLdcbeeqqT
 fMuGcghgOZma+eR7lU+jQoynkq2bxnKveIPoy8Fq5fuOyfcuur28QmlaaNp4kc2wUZLe
 ITLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmgWxxNR3fRGiEZ7GuI3SYGIKaSB3SiqrMyYoEZdNAZOQvXZfyZch7ISGOiIqQWbFA9O1mLuFxUjwF@nongnu.org
X-Gm-Message-State: AOJu0Yw6hIlzylvKf0jopbqVyJGTZ7u15/1FSwx9cJ5l1QI3DAj9PwcI
 5kyG3IuMlvp+F4U5SxgI1RaJ3KHKAzYR4CiF1Ukf+a14oet5dUgdhrcWPmMZk5jfPG/8RM38ANz
 AJPqRAA2z8itpe2zFcz/ZYvNKJfonC9X4zlBfb99YUYrtWsMN7i1sSM7z
X-Gm-Gg: AY/fxX6GQKtlik0LrsYus7DuwxsZ5wrLUqnhBLhUjQEUUWf+qs93dGlMkdyMCPtAi5i
 DaZSDLkjTKiHHe4SclX0k8PWpXmYsBNQiZe1YyzAdTE3AMekTHtXpMa7Tpo2lQb2iqDgfPAY/oE
 9keh1JCD0NQxc46g+B+UpjxV19m35fj9ArDkXqRjDkUt8xQyA7Vsd0e4pxM1V0RS9QYYpFPHDrv
 AXBQPK8T83au1Ac2IXTgyV+Frq3vtJebWeOX9/7hwTGS3AE3cgjqJm3LlJ/Co4l0dSuj1TWTf5p
 bngejWrDPB6azulM4WcrERIatoaXkhgzJG+2xNbvNHtk141flp/JAeP4f/VYzElObwiaeIdeKnC
 dxN/NYYM=
X-Received: by 2002:a05:6000:24c8:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-432c375b114mr21828161f8f.34.1768295592350; 
 Tue, 13 Jan 2026 01:13:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPwt9v5rtE6bH2ekixXQxrZbne0nuFDrGiZgBHh3ckBZpEMpEcBj2DGeo/PPWRiisUW9x2kA==
X-Received: by 2002:a05:6000:24c8:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-432c375b114mr21828123f8f.34.1768295591940; 
 Tue, 13 Jan 2026 01:13:11 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm44051509f8f.11.2026.01.13.01.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 01:13:11 -0800 (PST)
Message-ID: <cb532d62-b7c3-431d-9f4b-a7281a043262@redhat.com>
Date: Tue, 13 Jan 2026 10:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 26/29] hw/s390x/ipl: Handle secure boot without
 specifying a boot device
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-27-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-27-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> If secure boot in audit mode or True Secure IPL mode is enabled without
> specifying a boot device, the boot process will terminate with an error.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index bfac156afe..2809fb718d 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -771,6 +771,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>           }
>           if (!ipl->iplb_valid) {
>               ipl->iplb_valid = s390_init_all_iplbs(ipl);
> +
> +            /*
> +             * Secure IPL without specifying a boot device.
> +             * IPLB is not generated if no boot device is defined.
> +             */
> +            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
> +                !ipl->iplb_valid) {
> +                error_report("No boot device defined for Secure IPL");
> +                exit(1);
> +            }
>           } else {
>               ipl->qipl.chain_len = 0;
>           }

Reviewed-by: Thomas Huth <thuth@redhat.com>


