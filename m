Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BE2C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCDYp-0001n2-2p; Wed, 29 May 2024 03:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCDYo-0001mb-0N
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCDYm-0004xt-EA
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716967039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1wQmQP5g9F3Xaahpf4Td8w+kw4ibpHhRsBjiGJ39Z+g=;
 b=OGH2JMERTUMflqpWRSJNq4uWOax/tIOCtdMnEyHCR6xRJvx1r5Hk0duPpkvSbQ+q3v4Bev
 yH0ZisTmsDE3yZmE853YnELHgsyu9H5jCAgTesyG28IyOyWNSwOi/enqPNMl+sRHPrkkzx
 1MvGzxQYKrfMhCAQW1YVGA2NIF0QwjY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-Mv8mt-_YN-uJ06WhixEykw-1; Wed, 29 May 2024 03:17:17 -0400
X-MC-Unique: Mv8mt-_YN-uJ06WhixEykw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-354f7a278efso1176176f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 00:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716967036; x=1717571836;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1wQmQP5g9F3Xaahpf4Td8w+kw4ibpHhRsBjiGJ39Z+g=;
 b=ix2YoldRCfsVkiXDrvqPsRXohhb+Jb0MWQgo9YNhB8mhIP+rE+PinLSbwz0B+RaGbi
 jcF9uayKYl3IIjn3Rg2j9+7xcDc+kZf9Osp2TVF0yR+P2sK0MR9UfS0mjC0b5yHqSg6Y
 CeizvquNL3VLUCFaJ5vJ6Gjah5jVliZJvt2ul8pubmePcaXI8fVw6YOK1MGhSmzwxkfP
 HBKjurkZyKyOyHcomVibjyoXZ8LNtSKZStw6W3NsOMNQjM7p0BDCWmY/3ItBq+Mk+Qvb
 8az35ZqS28/YPtN0SghHaNT+nzhTIKx14RNENG5wWo9Gupijp2GdkXKxIAXWlY6hn/ij
 uhUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3P0Yov3EQX4kRWg4HZWwF6sXKhEwcATLNr+lkk4ZeORfdg5vSHbF+nPLL+81lBW5Ls8v+jHL2EP3/2k39UQSTmc39Zus=
X-Gm-Message-State: AOJu0YxpaA3XrfHhxRC1qelivsfcdL0IQp8/DvSMwJ7jXngwqBURcJNw
 hREsyFa63tLhgYSr01i4WxckR6M9OQiamE/lH7XfU+IEfCFYL/abAiZjslwLJpDDP3g8ZmCiCPO
 nHQyq/xBvseCoDrX/joj4j6Pm1tmewifOl+x78u9bF/zJ9ITffLqS
X-Received: by 2002:adf:f506:0:b0:355:433:8f80 with SMTP id
 ffacd0b85a97d-35526c569f7mr9283237f8f.33.1716967035837; 
 Wed, 29 May 2024 00:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgxDXerQ+dlGhmy2z9U3GGQV+UsMUp46H4Abg2tV2/3qDWgveVF7rLHVOGvNAfcXC/pqrKHw==
X-Received: by 2002:adf:f506:0:b0:355:433:8f80 with SMTP id
 ffacd0b85a97d-35526c569f7mr9283226f8f.33.1716967035435; 
 Wed, 29 May 2024 00:17:15 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7de62sm13957950f8f.6.2024.05.29.00.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 00:17:15 -0700 (PDT)
Message-ID: <0f8cf7fc-aea9-4b6f-9197-35c16cc2eb17@redhat.com>
Date: Wed, 29 May 2024 09:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Add numa test for loongarch system
To: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <lvivier@redhat.com>,
 Song Gao <gaosong@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240528082155.938586-1-maobibo@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240528082155.938586-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/05/2024 10.21, Bibo Mao wrote:
> Add numa test case for loongarch system, it passes to run
> with command "make check-qtest".
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   tests/qtest/meson.build |  2 +-
>   tests/qtest/numa-test.c | 53 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+), 1 deletion(-)


Acked-by: Thomas Huth <thuth@redhat.com>

I assume this will also go through the loongarch tree? Let me know if you 
want to have this merged via the qtest tree instead.


