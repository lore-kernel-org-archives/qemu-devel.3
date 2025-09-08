Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50097CAC583
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYre-0001Lx-Gd; Mon, 08 Sep 2025 06:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvYrb-0001FR-4H
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvYrS-0000pN-1b
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=63XCfblRIRB/xioyliU5fyf02XQ/AYrdKg33//yMdTI=;
 b=Q+TUCod4PpV9YLoxmH8oSMrLAl3/9/D3xkajAfH4KfSPHWcFTxDcf73CcmCa2I2d3O82PF
 yAO7K99XV2aEv4TC27rglQhg5T6J0/cHgvLaSCh2dwMt9WW1dBs79LaqaoHgorD9dj1jHh
 yrZ3yzMex25yyVNQRwxsseN71aPJBW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-XbJGD13yMum1YqCuvNHgxw-1; Mon, 08 Sep 2025 06:12:22 -0400
X-MC-Unique: XbJGD13yMum1YqCuvNHgxw-1
X-Mimecast-MFC-AGG-ID: XbJGD13yMum1YqCuvNHgxw_1757326342
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df3e935ec8so2000473f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326341; x=1757931141;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63XCfblRIRB/xioyliU5fyf02XQ/AYrdKg33//yMdTI=;
 b=hDSZim1bdPZrjIPLgp0bGAAadIty/f5/0U+cSq61BBR8KlGsGRLIRDLLLjJ9BbzGCf
 lGp0qpKcy1Lsv3T5WvWpaLLmIcxUR3pCWSZI+Ycas8kqWoWAV4JlIBwIXpAu+gut5wdE
 OwYiC8j3fP0pIMvVY7DA7NwCZsNPILGB/3i8cqmmgrkUEIv9WI04npfatey3xwT43V8G
 7cMbW2MiO1R+KSPaxBitRRkouuELPUSPl73KRMeS2cGJiUKh0FqHb2opUFe95ekE4Ccd
 c8iErb5i/Du268cyPSPBuOPApdxoZ3DGT9FcUj5ick7drYpn8zxlA1XnxKZRz3Ob0Sic
 wAzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDtY3rJ8NNi3QqIMF6PFmjfeFinL69MdpTT5SnfEJj9t9/o5AYmatBx4lnfD9qprqNTGROxeWWO90/@nongnu.org
X-Gm-Message-State: AOJu0YwrXcQ3mx/QXgzU6YpQRoXISA71IyF9Jwxe/EcO6i+BfS4Ir4WM
 1lXpp47GQ80Gqw05lhcmHq66i066+NBbcDvD3raD0Ug4Ql0BozAnAG+gcv75x9fGWm2vcHMH5Q2
 r+KiF1Fh+bk5IuBJeRjJIqxQ1OAeCEh2ZRLJMYtWGGWkEupi6X5S57kKC
X-Gm-Gg: ASbGncsmc/J/9zxA0Wbn8migurKSf1KtZJft5wgE6QQHsDpfh1u2oO4cZNihQQnSHfc
 cEsrEjSuQzXLuOr33WvbZvO0soDgU2svvnFARvPLEQ5h5H86BHantt2JTdKdd6mub7erQ7T8ZJ4
 X5sK9WF7IJmrYEb6IboQ1OYDzNj+QUbrC8BLcOLMv7act1NwBnfo+SXEjAch211KGlDz4jyQ1K9
 tP5rj8wua5hZinD+ipXOPpIV9uKnNYGnL3mP/W4oriG+3+37AU1SKdB0pU2HJ1eOfcBvysx9V6y
 qLjqrgpHpp8ZbxqmSy1cgo1WbzvVjx9ihv4/QRnrlfPSfiPyWyisLV8XOVn43hINbNWEvZ2hln7
 VZkjHfg==
X-Received: by 2002:a05:6000:2005:b0:3e3:e7a0:1ff8 with SMTP id
 ffacd0b85a97d-3e636d8ffc3mr5496632f8f.6.1757326341584; 
 Mon, 08 Sep 2025 03:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU/FVxpMH5SiD3Owrt62GpFm5yHH7n2dXZ4Wr02a0nc8MsULsfRP6+qYoGMH72SZveqY8Zww==
X-Received: by 2002:a05:6000:2005:b0:3e3:e7a0:1ff8 with SMTP id
 ffacd0b85a97d-3e636d8ffc3mr5496614f8f.6.1757326341134; 
 Mon, 08 Sep 2025 03:12:21 -0700 (PDT)
Received: from [192.168.0.5] (ltea-047-064-114-112.pools.arcor-ip.net.
 [47.64.114.112]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e74b28a108sm1972111f8f.16.2025.09.08.03.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 03:12:20 -0700 (PDT)
Message-ID: <666dce10-2359-4211-b761-daf9a828523e@redhat.com>
Date: Mon, 8 Sep 2025 12:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failure of func-x86_64-memlock
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <7ceb8d59-be3f-4dad-9e2b-9db62fbf92cb@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7ceb8d59-be3f-4dad-9e2b-9db62fbf92cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 05/09/2025 12.26, Richard Henderson wrote:
> Hi guys,
> 
> This test has been failing on my laptop for a few weeks.
> Any idea why?

FWIW, the test still works for me (after enabling it with "ulimit -l 2097152").

> There's nothing logged in tests/functional/x86_64/test_memlock*/*,
> which itself seems like a bug.

Is there maybe any hint in meson-logs/testlog-thorough.txt instead?

  Thomas


