Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBF9CF6C1F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQC8-000468-GW; Wed, 07 Jan 2026 04:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdQBz-00044C-R5
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:51:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdQBy-0006C7-0o
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767779460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HltyUR9MIWSH8HNAucuWS/U9bIdg7qBJHH7dQwu1ci8=;
 b=TOhzJopMOvoe3drxTrMIUF8kuVGOnSmMb+lg6uJg1OHG0Hgz+o+li/Sa4bHSl2azIKAM+o
 eVRviziCPjAWsE/Yu3EBZYSIoWK+2ocmMXuNePPeNmCVyVseKywamyY16EbvuWhxMix7mO
 Mckv+VQ7SZXcjtPwhHG+q3o/4RNAS9k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-2vMG-3dhOO2KYoeEa1Z0fw-1; Wed, 07 Jan 2026 04:50:58 -0500
X-MC-Unique: 2vMG-3dhOO2KYoeEa1Z0fw-1
X-Mimecast-MFC-AGG-ID: 2vMG-3dhOO2KYoeEa1Z0fw_1767779458
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso12626115e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767779458; x=1768384258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HltyUR9MIWSH8HNAucuWS/U9bIdg7qBJHH7dQwu1ci8=;
 b=bXEKeOV9gEzBwgH8NnbHzFR/WjmvIED7XkHvyQscLsG5D3XZpuyLf7tL27liOh/4Nf
 bfTLXK7SPj4ltTpNEYUvsmVLgmc3qhJoKNILaJOGHALLOENHnmMq2CbLan0bSrxENjww
 Ce9Ip78fCD16ZEAeWfDx24AIq2Jt37WE2Q72xTDXeHpaxodqo/CwUMhr35IzpSaYsQcT
 kbmvtGWQl3QbN2Fzmk7dCfSO+dDO8xeBZgw+M/AzKHb0MLPWRz3T82mgcURyeWtnIlGb
 TiefWiljkgVv4AAT++LwiJnq93z2YCNYatZKnt/8N9JEeZBJbXWSBtXCWRV7nduniLCW
 X2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767779458; x=1768384258;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HltyUR9MIWSH8HNAucuWS/U9bIdg7qBJHH7dQwu1ci8=;
 b=B4XPnvXPmpw/gaZcBF/w32Ckf0HvjDhJYLixWZVBgJ3KCf8h89Bvb9wY87hGuuBn7K
 kPqHF8D979gv15zdSr5Y2asgYRejQf7waOLmO3rz6mWeupeY68T/ugP2yaOeBFS5m0NP
 1nrIjmExioczLGK4/ENeR0w43c9BF0xJJ1w4A2jCy5Z8ONTe6caHObulGLO4TKoaerW6
 6g/RKAcODuZwme5C0on4xxwegcCpYyEb4Nw88rm6vFUI/Od/JdkDjP4AdpSMLQ5n4hEg
 oM3eYraDMswBX/ul1XtxdkZrUa443OKtToKI2+Zv9fOKeA8lOsvM/+bz5i2Xh2C0NC8b
 Cvqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZatpO3QBlt+gv4iH4Mq/zAt+Z8KYGkwT5ji1tXMnZSe51xrikwkJhhUjORBoY5Wbwft4vAbqMvYwh@nongnu.org
X-Gm-Message-State: AOJu0YzrX6F3ei1sbmfdq2GZV5K4DyBLwyvvpelhcphdsw3e24klEDvL
 EhwR0hFp64eY17suvg5hueuPb08tN5uWyFIxKfm/PF7sy2TOT9mQ3pD7uE81BzvBwBBT3q+hGgX
 AruPE8DkFVpq1RPNuIZVmyOhtpBWbgwXmxg5JHVsPrB9+9j8eQODgB7Ez
X-Gm-Gg: AY/fxX5cXZrOd7VNpFpQwDwVe90rnFdd3ONbvjnO0Z0jBo7Z0NMFUSSYksnTJx+vt6J
 HxmCie9ypSFsXY86MNS5trgofEiC3q7Gu8LmTsXeu5jKea7oLaOjkbAu4O834FG7Tpfm3yVX+b7
 6pGcAleWb0HL97g9Vg9vgSvKoSewdpJ5bv6CXiSOTNGUz8AweHspA/G0ivdixT+Js84kwpyo1tT
 rdVvTSDsd5lVY7RGk5CXuSzmpYrL3/yz+wav43ar6zMLdbJINMVuP8jif/r83MKW9G9jmTb1d1d
 8xFYFblBno0vOULb9PJx1B9u1XXNg+mj5eh30ujIezA/HD+GTok5ZhOJIyykOWQbdWgBc5KoZ85
 Mcelkfojr6/oE2VL+v2HlOjhMDxYQA45dLXo=
X-Received: by 2002:a05:600c:1e24:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d84b32efemr18642475e9.19.1767779457679; 
 Wed, 07 Jan 2026 01:50:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfrxPbl/9w2kK2OIMcIIfa7Rwc0xPr4VvEz+QB6Lafvjy28fP51UAG2mvlRsMmSZg7+nvhnQ==
X-Received: by 2002:a05:600c:1e24:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d84b32efemr18642235e9.19.1767779457256; 
 Wed, 07 Jan 2026 01:50:57 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e199bsm9401991f8f.16.2026.01.07.01.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 01:50:56 -0800 (PST)
Message-ID: <306ae12e-a855-4fa5-bf4c-eed1561be85d@redhat.com>
Date: Wed, 7 Jan 2026 10:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] include/hw/s390x: Move CLP definitions for easier
 BIOS access
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-5-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251210205449.2783111-5-jrossi@linux.ibm.com>
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Move the s390-pci-clp definitions into the "ipl" sub-directory, which is visible
> to the s390-bios.  This allows the bios to reuse the architected definitions and
> prevents code duplication.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   include/hw/s390x/{ => ipl}/s390-pci-clp.h | 0
>   include/hw/s390x/s390-pci-bus.h           | 2 +-
>   hw/s390x/s390-pci-vfio.c                  | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)

Reviewed-by: Thomas Huth <thuth@redhat.com>


