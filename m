Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B371C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxk7-00051e-0c; Wed, 02 Jul 2025 09:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWxk1-0004zT-68
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWxjz-0006yf-1q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751463788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rS836x+pkATlci8tKSzPvi9q/tIxzaeTa7/ISOQRvLA=;
 b=ZyH3SIx7AOrnzLrzTOmT7l6Ydgk78bl4oM9XxyDsYPxrQLQ7IfBuY+zR9u6FZiWmmUEZMg
 s2A1T8LNUElt/E+iA/kOH+j42ecR2XBjE7kYhKmb1dNE+YS9EDkG4CNJ3P8S7KPmNiRiIf
 6klX6Z65GBsAptRO1OX7elzjAXFQk1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-alTpkiq5PJOuSxl7Cgin-Q-1; Wed, 02 Jul 2025 09:43:07 -0400
X-MC-Unique: alTpkiq5PJOuSxl7Cgin-Q-1
X-Mimecast-MFC-AGG-ID: alTpkiq5PJOuSxl7Cgin-Q_1751463786
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso3168260f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 06:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463786; x=1752068586;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rS836x+pkATlci8tKSzPvi9q/tIxzaeTa7/ISOQRvLA=;
 b=Ms4tcfHp1ERTsKuiHPsbGoVD9Sw1lfM8McurMQ6y5AqWvSJOgpBGOvMXv5zikAcIu+
 cu/PyRPWnAH8mVTqSMRfEseTSwZ950F95T4cYvwQ0p2mLxmtlJs7RAhLW9tA/7Bqdk5D
 4iOonxvD/fqstPfN9DOsg+wZX0suMyhcvKWZSstdCq1W8+Ya+e5XSEtj1ooD5Y38swfL
 USLWGhxW3FmBlEMLMsgX6Tg9D8Rx2eKplKvCOtPuqXX1LulT5zXhYi9dDCp+ij8wLTZz
 9OhhN1d0ZBmebGQre5sJ+Gi9vGEyX1b7oxAInw+n04ysjxdOvF6o6mEzvjS/mPz3AzqY
 LvxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWojWUQ95KtzvdYHfl7C5+W2udfOlmmYx2LjaMWKcfjhtN7SBCfrwoQPpOboUpWXuaWtVpKYMUtM2iD@nongnu.org
X-Gm-Message-State: AOJu0YyyDB9z3tYsOOKxlVYVcf/DrrTWP5keRMkysSZ6vHiGRAY87D3Z
 46SIV3/JWZF18hkjowTHGKz/H8fiwiTtoQlQw0BXabaXIDMUb1fEOl53pOrfAyy94KXBLkGFTp0
 NxU5XPB6yO6SnfwiPpLulC8U+QWU0ZMlBSNP4+6i+zMhVewZ4ymn1YnmC
X-Gm-Gg: ASbGncsGeS9pkFLxdcoeeUkRHSeBIncxKcTznsb9T5lWJkb4a/TTUGF/7moR+6sJ5X7
 r9MeoN10RcX1J3qCzUfWGmdy47dw+Ans8SJsbnARvnIfit22UP2FV7wkcrhl59bZPiBlowQ21U+
 f1d+BZfxeIJyvgMmjB/0AO8qOtVPksCoon+tAF4V1bbHG1CkKaZ8W6obBnuke2I1BHSFqGFIm+y
 iOKxP13608HkkAioyTc7ffheRWKZqat/APiuC2kvtP4Gcq3MCcFR0XrNwfqg68g+wDtJmmKlpPf
 NGPqgBf7Cz4PQNvHzdK4ybdybCshMgcaPOvJtK/XcOhyujFEsL5fT1ANS587
X-Received: by 2002:a05:6000:4104:b0:3a9:de4:851e with SMTP id
 ffacd0b85a97d-3b201203be4mr2233226f8f.45.1751463785757; 
 Wed, 02 Jul 2025 06:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYFvn9YMKtU9TgMwLogVGnsm9vYyS8qJ2UnmoYJcPGJx6MjgI2y8ydV0yt51ME0f9t9ppZcA==
X-Received: by 2002:a05:6000:4104:b0:3a9:de4:851e with SMTP id
 ffacd0b85a97d-3b201203be4mr2233204f8f.45.1751463785286; 
 Wed, 02 Jul 2025 06:43:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a26sm16281802f8f.51.2025.07.02.06.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 06:43:04 -0700 (PDT)
Message-ID: <d0a2f944-8a6c-43e6-b666-75927249a24c@redhat.com>
Date: Wed, 2 Jul 2025 15:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: do not register vfio-user container with cpr
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, john.levon@nutanix.com,
 steven.sistare@oracle.com, qemu-devel@nongnu.org
References: <20250702120043.267634-1-mark.caveayland@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250702120043.267634-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/25 13:59, Mark Cave-Ayland wrote:
> As the full cpr implementation is yet to be merged upstream, do not register
> the vfio-user container with cpr. Full vfio-user support for cpr can be
> merged later as a follow-up series.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio-user/container.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index 3133fef177..4ee99fc2cc 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -225,14 +225,10 @@ vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
>   
>       bcontainer = &container->bcontainer;
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> -        goto free_container_exit;
> -    }
> -
>       ret = ram_block_uncoordinated_discard_disable(true);
>       if (ret) {
>           error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
> -        goto unregister_container_exit;
> +        goto free_container_exit;
>       }
>   
>       vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> @@ -261,9 +257,6 @@ listener_release_exit:
>   enable_discards_exit:
>       ram_block_uncoordinated_discard_disable(false);
>   
> -unregister_container_exit:
> -    vfio_cpr_unregister_container(bcontainer);
> -
>   free_container_exit:
>       object_unref(container);
>   
> @@ -286,7 +279,6 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
>           vioc->release(bcontainer);
>       }
>   
> -    vfio_cpr_unregister_container(bcontainer);
>       object_unref(container);
>   
>       vfio_address_space_put(space);


Applied to vfio-next.

Thanks,

C.



