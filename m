Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E7BC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9Kc-00086w-VE; Thu, 05 Jun 2025 08:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN9KW-0007yc-US
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN9KT-0007CS-MR
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749125056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U3TmmfE+IodnI5UiZfT/vpVHYJ+cd4mDwRSSx19gVLo=;
 b=H20zZVuVSrcEXhnm/W+BhnB6NnDoyUaDTHqU8DHySnU5y9chH4n4T7ghBHRHll+tlDYtSR
 rftlgiwq6W/UjN+Xc3UD9lyvuWjRYduFHdeinwe7zHbR/XcVGHjk7VZkBTtJurvzMKhhGO
 xkY+UemCHgaMBScUiPGniWw+WeQMYjM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-A3_CJld0NeOaZTOqF58Wbg-1; Thu, 05 Jun 2025 08:04:15 -0400
X-MC-Unique: A3_CJld0NeOaZTOqF58Wbg-1
X-Mimecast-MFC-AGG-ID: A3_CJld0NeOaZTOqF58Wbg_1749125054
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so5148995e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 05:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749125054; x=1749729854;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U3TmmfE+IodnI5UiZfT/vpVHYJ+cd4mDwRSSx19gVLo=;
 b=mmjjXSGDWeSZYzLXaD0fuMRbSDap8Qp9RVyGW+0s8XmBlqC8yiShI3892JodXb+kir
 jRxtAN37ZgqI6Waa+NNLCcjp+47ANB1qCz7rI822MAbf+Ia9ryn34EH5tJs6Cxatzp6x
 cGgVX/q7Xt6VDp1/oB7SjC+aWIM64NjwrrY7FtMLmVcRcuDypAd2jOa3j2HTnVzgMURg
 H6BZBoig6vKe2hw5fvQyX5g/ylEYyN6igE8MumE1PHSgy0YYbFgMXOUg8NA6yNDr9q8E
 Xkj/0gmpTlZtgroL/eZfM0nBgqXxDOTC/oS1Y+zj4yqlx6Ufp81tGLvXHje8tr2s3AcM
 2P0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK0P8x77WJp/wB9E5Wc45GWY7+XHWDdT085vwD8KUvnPzQ6kyF8uCBr7kH8TrM2N2k8jVrsmXaZ6gF@nongnu.org
X-Gm-Message-State: AOJu0YxopN8uAcMUuu8vnkOCyZjjqkNxjDVPFeUqqFic0DLU/vKxCUuq
 lio4VskplO3dgkN6RBNg4Iq77/jtOSHKAG5/t2wzfRv8z/geSYihWl4xwJAFEok9KpPFqKqePpT
 6dQLomciKJrcWteRFEbI0AfdQWa4ofIWrMSLtQnaaTRIfd7Q6SMrwIX0v
X-Gm-Gg: ASbGnctFB46SSNDXu33vusQIPpO8Bsny4flcyfPpYlhOuDP9n/BIGOcPnpXe0Tp7h4K
 WJGwheeFw3qTOaoT7a9TY9on5m3iEKJYvp23uWsligT0fR1nivpWuTTatqPdh2OV8ZyGI+9nx55
 We3nn3FqeiNgwzNlyng+Um1qGYHVXXGbyvJJfYpPs8qA2clu9uXZWPpqL/PGApUgVJ4vecK4lBu
 0dA3bVmn/uVcphVlm6PLxTjYJg2NALI1imPcRxkeK3R6bzUx0VhcaCnScM+vMHhHQ+b0GiwoQeY
 XHxiTz/+TheAIQSEFNWU1NODct17cQw4Bw9NHMH28VYdKHzDYe3ZVA==
X-Received: by 2002:a05:600c:3e0a:b0:43d:fa5d:9314 with SMTP id
 5b1f17b1804b1-451f0b3f30amr56214655e9.32.1749125053716; 
 Thu, 05 Jun 2025 05:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9br3c2SrIoJqxQDDhL9VLRA16hzDUpmQGc5lmdAZoDZx28ePPZaxm8eUTxCzUbgyMBE+PjQ==
X-Received: by 2002:a05:600c:3e0a:b0:43d:fa5d:9314 with SMTP id
 5b1f17b1804b1-451f0b3f30amr56213985e9.32.1749125053215; 
 Thu, 05 Jun 2025 05:04:13 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de.
 [109.42.50.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fd7csm24194854f8f.88.2025.06.05.05.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 05:04:12 -0700 (PDT)
Message-ID: <b383753d-419b-4351-987f-eb3acbe8a156@redhat.com>
Date: Thu, 5 Jun 2025 14:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] hw/s390x: support migration of CPI data
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-4-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250603135655.595602-4-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On 03/06/2025 15.56, Shalini Chellathurai Saroja wrote:
> Register Control-Program Identification data with the live
> migration infrastructure.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   hw/s390x/sclpcpi.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


