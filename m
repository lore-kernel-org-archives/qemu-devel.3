Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A85CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 11:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roi5g-0002O3-Na; Mon, 25 Mar 2024 07:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1roi5d-0002NS-PO
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1roi5b-0003qR-RE
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711364522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ynrT0BBXpwbr0/S8uNq/sJzEyJypze0RxNnMEbho7Ho=;
 b=evTldis+wu+CSWy7yq4gvZojtLbu9pi9TMJepqd+c3XYNmLDSILjf0zvCB3LealCJEuUIP
 R+bvvf6Bv3+n17X6/MR10Kip+gmuUSsn2rLXrPRI5egYBwYc1tA5LBawS3GOQwTvdH+4Fv
 PLXqO/k67OI9UlMo19W2XLWBc3KG5tw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ofKVEZB2MMiVBX-51w9r8Q-1; Mon, 25 Mar 2024 07:02:01 -0400
X-MC-Unique: ofKVEZB2MMiVBX-51w9r8Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ec604d3b3so2643757f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 04:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711364519; x=1711969319;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynrT0BBXpwbr0/S8uNq/sJzEyJypze0RxNnMEbho7Ho=;
 b=pAuMuJ3VPHMNbzBTZSyJhRVXoEjbChxCAMmp0BreI5SxRtS4UFe8JvgWQBpd5qLbd1
 XgfTThSTyjzoMkNrFF8PUONtda7MsqVG9rzaVtyAKLeVQCgqXYqqPEniL18DJzEP574d
 IS7YoIwFfZ7gC/00iN6tHrkaIm30s+/LUKrO4e2ubzOwfaBAUENipXBYjEEXXyDHJj7C
 oCV/LISRfHy1nTFnpXDQbBAsgkAE8OgkhmwcaJYE69XdAsnea1zjNsVaeAhBD4gxrjUk
 QyGOsVrRC+AIZ7FEucjMRY71Mg8dMO25+XREY61qdvd52YolbtpAMj1fjEzF3150y09v
 cFTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFTAhq08/rF/ggJgg8HRhaYOKfqWocPRpTRmNPFFLMxL+nwe4F5ekYfOXNvW0jgaLaR8WVWV99p4hGhoVisL6b58B+dc0=
X-Gm-Message-State: AOJu0YwqzYmVcKN+NiyUAEkHF86g0GO4TK59DVt7dbiMUCRYxL3ziYbO
 mmaP2Fml34fDBSXz8BXfSwFj5KuNcM8rqYx2QBqFfVL7O8moSv0BZZfEcAH611oMcaENmLbbJqq
 xSu8ET3Jed7UDmvsyv8oNjfHIAWUGsdvr2beYYGadPnYN4mZj2DmE
X-Received: by 2002:a5d:624d:0:b0:341:bdd4:aedf with SMTP id
 m13-20020a5d624d000000b00341bdd4aedfmr4433328wrv.25.1711364519808; 
 Mon, 25 Mar 2024 04:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwepsqnzNNqMLNKhhcCKXe1elSRswQ3T7wBTUXmCv63it/ZvW3ds8uDG0pKnXWa58eR8ky2A==
X-Received: by 2002:a5d:624d:0:b0:341:bdd4:aedf with SMTP id
 m13-20020a5d624d000000b00341bdd4aedfmr4433311wrv.25.1711364519462; 
 Mon, 25 Mar 2024 04:01:59 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-158.web.vodafone.de.
 [109.43.176.158]) by smtp.gmail.com with ESMTPSA id
 h8-20020adffd48000000b0033e9d9f891csm9211210wrs.58.2024.03.25.04.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 04:01:59 -0700 (PDT)
Message-ID: <697de906-1998-4803-8e4c-b88dcecc32d0@redhat.com>
Date: Mon, 25 Mar 2024 12:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Include missing 'cpu.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20240322162822.7391-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240322162822.7391-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 22/03/2024 17.28, Philippe Mathieu-Daudé wrote:
> "cpu.h" is implicitly included. Include it explicitly to
> avoid the following error when refactoring headers:
> 
>    hw/s390x/s390-stattrib.c:86:40: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>        len = sac->peek_stattr(sas, addr / TARGET_PAGE_SIZE, buflen, vals);
>                                           ^
>    hw/s390x/s390-stattrib.c:94:58: error: use of undeclared identifier 'TARGET_PAGE_MASK'
>                       addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
>                                                           ^
>    hw/s390x/s390-stattrib.c:224:40: error: use of undeclared identifier 'TARGET_PAGE_BITS'
>            qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG_MORE);
>                                           ^
>    In file included from hw/s390x/s390-virtio-ccw.c:17:
>    hw/s390x/s390-virtio-hcall.h:22:27: error: unknown type name 'CPUS390XState'
>    int s390_virtio_hypercall(CPUS390XState *env);
>                              ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/s390-virtio-hcall.h | 2 ++
>   hw/s390x/s390-stattrib.c     | 1 +
>   2 files changed, 3 insertions(+)


Reviewed-by: Thomas Huth <thuth@redhat.com>


