Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D6606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGs5PwLZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NY5o6ooD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJ84-0000uV-Lj; Fri, 06 Nov 2026 07:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPJ7B-0000s7-O7
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPJ77-0000Vh-C9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793968330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YAPZH0vQIRyztFKnRkwFUzlKqJz+r6lodeZCg3ghSlY=;
 b=dGs5PwLZW556PZRpqsj00mLWN2RYq9Cv8fq4EVQ7HbPINHf2YmiAX1Y3ltmOacgQ7dU+l9
 suSjaT5KAWqZJLRlRRKd2YqnoGaSimQGu1Iz6H5pe7qZhFbDFG4ydjOcB6bZJRja3xbi/c
 zgYqIoH4TmLgzpkbByvdnjtgxLvjsSU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-WoZICVaXMQOpOsgVdWZyQA-1; Fri, 06 Nov 2026 07:32:09 -0500
X-MC-Unique: WoZICVaXMQOpOsgVdWZyQA-1
X-Mimecast-MFC-AGG-ID: WoZICVaXMQOpOsgVdWZyQA_1793968328
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-49090fde23aso622190f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793968328; x=1794573128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YAPZH0vQIRyztFKnRkwFUzlKqJz+r6lodeZCg3ghSlY=;
 b=NY5o6ooDlmwwOYCGluSWyVfK5PI2HAHKQyiN+AtD7zhKvenNpKJBxzf1c3GH6EKSH4
 tOo/3YvAQgt4rhXhkSit1WS0Vc8mUJ3/biMMTwKFd7Re6MwxpqccDM1oZchOgQWv3Xli
 aUxsAtVtMI9R/+Vdilyf2Vzl1BTaY60aXHhAZvvrVhoot9oTrDGiTb8KH/pbzSofeQ29
 w1s7fw1knEbIbVES31KDnC+jS+ltvxrnvNwdq1SDcWgmmhV2g7sJ+eAWXzBC1t888zET
 jjaSei7oFlG0YhmU0KmCjhIHkyoLOb56equGjryWsaOSSTLdXlhnW/5WU3k79Ypvnm3S
 c10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793968328; x=1794573128;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YAPZH0vQIRyztFKnRkwFUzlKqJz+r6lodeZCg3ghSlY=;
 b=La0r908oEcVpXH9sHzduLX44C3WfZzE/FYn2xzoPDe+E150DQpPrVQrcqhYAL0XpY0
 ysFkaBSuGvEdTrzFhTt1Gw10QuIfHGgKeD5FK/IPhWv+gmSdwdUPST2Us6F7lq6AdkFh
 WJnBovLW9D7sWvuxtPd8HWaZ+/J7TSHkhqXUQ6Pe4YJN4I9P0Lk0cPo3yjaMtLYSA/MB
 W6aPamTYtYIUzWizbMZiXbC1oFuIu/lYUX/ClL17l5VYAlwPevZ0BPnkvLiZy4Q2qmYi
 ovBthB+GCV5coOr7mZveRfJ3NLBt6Z1BIuky7ot1JnaXnKE7HZ5o9R8ARLp7jiU4YyxK
 w8Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMescSwZCx+/dHtE3VHElaTAlpn8xiO+IHdC37LG7BBsaXlJfVzc0/pTUR0K6957G7EYvXOKwgdtY3@nongnu.org
X-Gm-Message-State: APuU4Z+sG70umPpysypp2QQ/hbXClYB1PggQK8oiNmoMv3YD0Jjyq7qv
 w69POk7EmmTSWloKLl7b3AYBuZSUYLa6ahFPIwZ6MboMo0VdJMdWbBKFoGSsS5R5cdx/YfsU2DM
 sN9X72tQLOWLeadKloLlb6Q1heBlWSl8h5tROBBqxoo9mni/45wcq8wGW
X-Gm-Gg: AYBFou1L2/oqZvFbSOjJ35pAWSfvtLACQHsK3dsN+xsJtmtALOp7WtuEa0NG4r2Cj0x
 qFIfrJBze/GVvrLYpjds35IkiAlY9Eqj5M69BdDlLVnGEOB0CyKrUKNFmAJzb/Osqbb+tkf1x1h
 X2JizE/mqk96FiSEZ06OBhtva2hnHVhIXmzKjXoyDE+wqlezhtr3Tt46nmiomD9vpUG1+k3n90n
 PO015pDUXvjcYZbq8WIh65uWxVGkcrtBxQne/qJlviK1qbEHKkAlfyLADykCzypoV2MoIaGHMmi
 hz9MvGJjI48Sa2tJ29eGIkHqTo+p+Z9LouMxwl/Tm2agceacxVFTrcnpjby2wvvPaYYyogj9Eoa
 O5smsfgg91EByGpnTZQVpQgHR5YbdBVo5Qhdk8cVJhQKMRkfVFVyKfHa/fAmA+Q/MMtnGPqo=
X-Received: by 2002:a05:600c:4e41:b0:4a1:f68a:9736 with SMTP id
 5b1f17b1804b1-4b6dfe8f3c1mr39253625e9.26.1793968327746; 
 Fri, 06 Nov 2026 04:32:07 -0800 (PST)
X-Received: by 2002:a05:600c:4e41:b0:4a1:f68a:9736 with SMTP id
 5b1f17b1804b1-4b6dfe8f3c1mr39252205e9.26.1793968326910; 
 Fri, 06 Nov 2026 04:32:06 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46489sm132923805e9.3.2026.11.06.04.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:32:06 -0800 (PST)
Message-ID: <d21900c3-4c38-4fe5-b9fb-d1d27f84295b@redhat.com>
Date: Fri, 6 Nov 2026 13:32:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/28] hw/ide: mark ICH9 and ide-hd/ide-cd as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-13-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> These have a long history of usage in virtualization scenarios on
> x86, for OS which lack modern virtio drivers for storage, and thus
> must be considered secure.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/ide/ich.c     | 1 +
>   hw/ide/ide-dev.c | 2 ++
>   hw/ide/piix.c    | 2 ++
>   3 files changed, 5 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


