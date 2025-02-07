Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B027C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQr4-0002zT-7U; Fri, 07 Feb 2025 11:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tgQqn-0002rz-AQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tgQqj-0001l8-6y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738944298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xz0hJOJEOEWUqaSdSnNyXz9h0M8g/hqw16cg12waP0g=;
 b=hdLuyQhkXSNFoejLuutzMAzGNxYtak0L6h0O7i8S+iaE8GPllN1kp4/8+wihg2/CKP6vHo
 sJQbuBihgrRlONfV7CsrL0kudOwY2Cx45jU5jb4kWQsc28Fxodey11ZYdE7wDWsWGcTxiU
 IEjW3xzCEUStrmSFqzu82Hc7ugrWDUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-juV18TyZMoSwVqVR73l_oA-1; Fri, 07 Feb 2025 11:04:57 -0500
X-MC-Unique: juV18TyZMoSwVqVR73l_oA-1
X-Mimecast-MFC-AGG-ID: juV18TyZMoSwVqVR73l_oA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43621907030so19247645e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738944296; x=1739549096;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xz0hJOJEOEWUqaSdSnNyXz9h0M8g/hqw16cg12waP0g=;
 b=Qw8PBtEFKu26wXHEqFo3YKgiYFyilXhheIYbPmGzVaWdQYoEwT5tqcRWkehDypwf2g
 PUk0+T5PufNjOrxqucp+JpYdmOmCj+9kVBOZYrpw+9JEkJ2waxcgy/EOV6Mk8qkqT+ci
 LDxrKk4xCsLepEs2aSQfPBOAME1h2KKmdZYQhav31GQWRTmfmVM1oXJD5eVYBTSGeC+P
 SZptA5H1pu3sz50oaOKDEx24MK1IVuOwkavkA0IvNZHgqI3kUN8mJoI8MiMYH+ItUT8U
 HYqSgWfHZaGVCS31K07nBQHwdRTv2cVQYNW7X0uwIA885P0VK5krKKbKzV2YAcZ/PSjl
 Kzxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF7kaHLXdSUc8bjYTIbOlAxo0hTow7GHs9yRRnuJsERWfje4GJpTSoSzhLYTJT6fhf2T9yDluNHI79@nongnu.org
X-Gm-Message-State: AOJu0YwwmLR+fL+Q1/X6MB2fSxUG5gj7oUWztQLAMDZoQBb6RWbLpVmZ
 8BCQ00TIerhPQeLldefvNVgpuhZCJS3Btsto2NMDqHVLeMOq1AG4OQ+HUeQFN2L+JJw9u4iw7Jq
 gMMugVRyp82t7fo1CUH2u5FZ5fkEJl73gAcjsglow6e1d/k4nJ76II/8xyLqJ
X-Gm-Gg: ASbGncuUHq5GZti23L+Pc2jWoIZMsu8NyDfhumndDONMYwSARx7a5mu3YprqrS5HufB
 6PwA6lzajoZsufDqcfOisSJVUiTBqWE0/jm6FJYARuKDmtXzwEzZ6L5FBDYg/Qkd4FEejbhOcjQ
 rQOhAOxeDswwpNDOGS9MRHMLexEdcoH3RgV6ZdZbQzM592SMZb3zYLe5j8CDjHI6nO6lwEf0rEV
 GcPbaQnWBpxgCJkazegfmhasVD57nICdJPTmaZBA8UAb1NfiWLTM3yzCfuDL9SOVwVb0q6E8gN+
 ztS/U1V/QbHX9s/+S+IzzbifPWDxilztIZuR
X-Received: by 2002:a05:600c:4754:b0:438:a1f5:3e41 with SMTP id
 5b1f17b1804b1-4392498b6b7mr41958185e9.12.1738944295943; 
 Fri, 07 Feb 2025 08:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEraYK+6gmFQGOGrzpx1iIDrUFHB5ABRtYi1f1eu0Eh4M+CzbNxh9pWSyrhWjDG0bCGIZ6Beg==
X-Received: by 2002:a05:600c:4754:b0:438:a1f5:3e41 with SMTP id
 5b1f17b1804b1-4392498b6b7mr41957485e9.12.1738944295545; 
 Fri, 07 Feb 2025 08:04:55 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc8a4asm59953685e9.32.2025.02.07.08.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 08:04:54 -0800 (PST)
Message-ID: <f9877082-0238-47ec-972b-c750aef356ea@redhat.com>
Date: Fri, 7 Feb 2025 17:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] tests/qtest: rename qtest_send_prefix and
 roll-up into qtest_send
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Riku Voipio <riku.voipio@iki.fi>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Alexandre Iooss <erdnaxe@crans.org>, Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Warner Losh
 <imp@bsdimp.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
 <20250207153112.3939799-6-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250207153112.3939799-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/02/2025 16.31, Alex Bennée wrote:
> qtest_send_prefix never actually sent something over the chardev, all
> it does is print the timestamp to the QTEST_LOG when enabled. So
> rename the function, make it static, remove the unused CharDev and
> simplify all the call sites by handling that directly with
> qtest_send (and qtest_log_send).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/system/qtest.h |  1 -
>   hw/ppc/spapr_rtas.c    |  1 -
>   hw/riscv/riscv_hart.c  |  1 -
>   system/qtest.c         | 26 +++-----------------------
>   4 files changed, 3 insertions(+), 26 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


