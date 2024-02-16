Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089EEC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravNc-0000Lx-05; Fri, 16 Feb 2024 05:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ravNa-0000LK-Du
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:23:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ravNY-0001ae-UP
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708079016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gkUSP5E4IqoqYimjQlQLnCPzO0DCqEp8+azRuj4qUgo=;
 b=JSggqST5jYi8G0peo7UxOxK+mqxqMcvh3sgDWzkEzeDfYuqbcImqw5i3CupwAkfVt6K14s
 +AyjEm0WlIv2ryjRrhNHz7q5iZpWkNRnyWRLfIG8tFUQEu6HgEX9TnMC0poVPPpi+troDv
 s0hLESY9U+JSatc4//BkzTGh1AVwRCs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-vR3aNYIFO9K6TeMSIGYh3Q-1; Fri, 16 Feb 2024 05:23:34 -0500
X-MC-Unique: vR3aNYIFO9K6TeMSIGYh3Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78319f64126so57372685a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 02:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708079013; x=1708683813;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkUSP5E4IqoqYimjQlQLnCPzO0DCqEp8+azRuj4qUgo=;
 b=QWpSAZxt8Ab8emKhcxMRao7hirj25d+CoI91uPWvOIq2aeXH9N20FB6f6moB8/XahW
 959e8ilHNyjoyKuBv3TkBkmelxU6ls6SSGZsvM2hVpRRThbWoQG3Z6gGDdiBoeWesvwe
 uHadyuwbbP6URb4I3jk80nUhlbPzNgJpGBhNulYM05WIFK97wuHhe6Kglx/EnGCt2HW2
 mIvjKEcMstqzHoaiNI4BfXgNojuEQoOLOMpS9UB4M4hk+ryBDgPQs6h2/S3AcneQDHlN
 BdJ07gphJnBTOmmusUg8yRlx1nNRCVBAWabqMLMZUEjKzBfFvyIALU6K7Oas5l7oZDNS
 iY6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6zYJwZN7EclU9+K9F9VHNjZ78EGYkH3BLd03EPsJec2JEulgvJfLlbIUQKvY5QuX3e13O1C8XZi0RtmCB6D8KL1jO6nQ=
X-Gm-Message-State: AOJu0YzRmOtBgtAy/ONfPu86IqOU0VEnd/0/r+tlWqhnCgVxldGPNSOB
 1HRG/gGB4Gh928tkrKE4+5Gs5jhODLExPBSmTyq1fYZ0rByoUJgC7fGdpqo4bBpLk/p08hBaehb
 kdxipHOTE3+LCyBZVGxfFAwfaWfypxv1uskW1HIxb9FG3aQn/fobF
X-Received: by 2002:ae9:c301:0:b0:787:4161:9344 with SMTP id
 n1-20020ae9c301000000b0078741619344mr1090086qkg.5.1708079013679; 
 Fri, 16 Feb 2024 02:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXwAdLYM7fLjb4XujqsImORGFJfeHGD6aCKaSoBc4GxiOyT9LjvecE6kuc+c9zrwSmNZLEZg==
X-Received: by 2002:ae9:c301:0:b0:787:4161:9344 with SMTP id
 n1-20020ae9c301000000b0078741619344mr1090066qkg.5.1708079013395; 
 Fri, 16 Feb 2024 02:23:33 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 h7-20020a37de07000000b00785e016ec39sm1385936qkj.42.2024.02.16.02.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 02:23:33 -0800 (PST)
Message-ID: <489bdcf3-f3ec-4c1e-a651-7b48df24cf3b@redhat.com>
Date: Fri, 16 Feb 2024 11:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] libqos/virtio.c: init all elems in
 qvring_indirect_desc_setup()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 lvivier@redhat.com, pbonzini@redhat.com, ajones@ventanamicro.com,
 alex.bennee@linaro.org
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-2-dbarboza@ventanamicro.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240213191736.733334-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 13/02/2024 20.17, Daniel Henrique Barboza wrote:
> The loop isn't setting the values for the last element. Every other
> element is being initialized with addr = 0, flags = VRING_DESC_F_NEXT
> and next = i + 1. The last elem is never touched.
> 
> This became a problem when enabling a RISC-V 'virt' libqos machine in
> the 'indirect' test of virti-blk-test.c. The 'flags' for the last
> element will end up being an odd number (since we didn't touch it).
> Being an odd number it will be mistaken by VRING_DESC_F_NEXT, which
> happens to be 1.
> 
> Deep into hw/virt/virtio.c, in virtqueue_split_pop(), into
> virtqueue_split_read_next_desc(), a check for VRING_DESC_F_NEXT will be
> made to see if we're supposed to chain. The code will keep up chaining
> in the last element because the unintialized value happens to be odd.

s/unintialized/uninitialized/

> We'll error out right after that because desc->next (which is also
> uninitialized) will be >= max. A VIRTQUEUE_READ_DESC_ERROR will be
> returned, with an error message like this in the stderr:
> 
> qemu-system-riscv64: Desc next is 49391
> 
> Since we never returned, w'll end up timing out at qvirtio_wait_used_elem():

s/w'll/we'll/

> ERROR:../tests/qtest/libqos/virtio.c:236:qvirtio_wait_used_elem:
>      assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)
> 
> The root cause is using unintialized values from guest_alloc() in

s/unintialized/uninitialized/

With the typos fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


