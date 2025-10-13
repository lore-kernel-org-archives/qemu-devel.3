Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38779CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 15:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8KmA-00009T-Ec; Mon, 13 Oct 2025 11:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Km7-00008a-Uq
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Km4-0007ac-Od
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760370465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z00nlRJNOjUMIfr/89eNI3fZhFQ6zEeDC8feluW5zFw=;
 b=ZtDJpIC+Fwf4yY4Xoz/fluFW1iSgKPaR31oxjJgOJa65VPGlTM2bsU9puICpghfYdEFgUe
 WPc5dnDm+wDKEG0cjj+6CVwYJtBcUapQAFa0cwR816AtpuYSlMv7KMAJ9oZ5QH0wgjlbKp
 4eKFC/+YrdYHN9CJitdNDSalnPVX0Rw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-PcVtQIFpOKWp8456Vwy4mg-1; Mon, 13 Oct 2025 11:47:44 -0400
X-MC-Unique: PcVtQIFpOKWp8456Vwy4mg-1
X-Mimecast-MFC-AGG-ID: PcVtQIFpOKWp8456Vwy4mg_1760370463
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42558f501adso3417835f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 08:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760370463; x=1760975263;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z00nlRJNOjUMIfr/89eNI3fZhFQ6zEeDC8feluW5zFw=;
 b=cMf/wq8ZLCq+ibOnVF11qSDbsSa/+hszNX7OnI8ASC5c7AsdrU0bZrLraOfr+8kPLP
 G0g3x3Bf58MRhrWqDzkRw1aSmVLHb/xSjevYGgNAtuc1/JRRL7tQeHwPFya5SwiRJuyv
 KdyO9oHdQUtkqKDbijT4OZEFh2Ol1cGtgOw6cvLTS6ihBZoyFCdbA3iMnn9ZbtXP8EH7
 yeVPUNDnYbiElGW79IQE0sGszyysYcMjhmhaV4S9LCc2Ezwiwq/b7QxdbhmQyAg2ERm6
 PXckPeacCTP90loTJ2szYn4Dh+UrIu8sxGaYxd3FuyRbj/C9OQAIBke68DGso+lu4hSr
 ogCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg7UY2AogD4zhxGzpUK88e3YXVBS5vsFRLIK4Q1gSeWKnA/z7qGoa1Jf/zgjRRYZO91cIrTLhAlMf+@nongnu.org
X-Gm-Message-State: AOJu0YzXrZigpcvxariHNcYfJSmAO8FXeZG8qY7ZkqAOuobRT9YLWrhz
 MClUQ70sj6bB3iTmtYGpXbuZrBCTzP5+w42UNCqEUtKF1kXRvU4qTUXRW9t4szIOMV0OwcIth/R
 RFvrlMkWr2X0I0Y1dlyWYNmDqCDVJPdIiN8Kl3hck4XYefKyH8vp4Q3gU
X-Gm-Gg: ASbGncu0Q9iHsFHzKyaMb4htcCwyFzMgUcNntrorL0Gn1MVelY9M+w6w7bp3TKakCqx
 QY3j7RuWT4xwhD6uEsLMcsCZnDgQx1HRngVdShJFK6dWku2LuIKTrmVQge/mKDUlL+XOOzvAFQL
 1zY+EIb5mGwas/7aXfIexSxOsYgdTwTzjtNYw74ZwD0ji7Vetnqi8OFbvU4cP/TlS+2QYLzbUh7
 CdcSjw071kzsPutRXkoLVXN5zCEMlSr2rIaNFh24TfVu2QMigvyrTfnwIfWuCxA6az5mgGyWOFP
 UgOKGs4qobNgClg5VYY831qbta4fPPpmiehzgjbWu2zmslYr/KduuvhDCXTUR86tkyVmT3Z6bdp
 ZJfQ=
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id
 ffacd0b85a97d-426d5bf0c0bmr6868284f8f.63.1760370462684; 
 Mon, 13 Oct 2025 08:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7iDyV+r82Fm2sFtKXQY5YkHzjqjILtyaNPYC0lySEWp4SxAFFyUPIHTL+VDEQZ9b1JxOvIQ==
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id
 ffacd0b85a97d-426d5bf0c0bmr6868264f8f.63.1760370462326; 
 Mon, 13 Oct 2025 08:47:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583424sm18658045f8f.21.2025.10.13.08.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 08:47:41 -0700 (PDT)
Message-ID: <750aea78-f51a-4723-bdec-449817134f87@redhat.com>
Date: Mon, 13 Oct 2025 17:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Alex Williamson's email address
To: Alex Williamson <alex.williamson@redhat.com>
Cc: alex@shazbot.org, qemu-devel@nongnu.org, tomitamoeko@gmail.com
References: <20251013153543.3091169-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251013153543.3091169-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/13/25 17:35, Alex Williamson wrote:
> Switch to a personal email account as I'll be leaving Red Hat soon.
> 
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   .mailmap    | 1 +
>   MAINTAINERS | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


