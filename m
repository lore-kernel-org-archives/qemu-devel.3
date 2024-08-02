Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C94C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa1jC-0007Sh-5Y; Fri, 02 Aug 2024 19:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sa1j2-0007R6-8i
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:30:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sa1j0-0002d0-F3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:30:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fec34f94abso70690355ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722641415; x=1723246215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zCvHOTr4DWIO6ihfVg/jezefUAXAzB8dGrgBA9uw420=;
 b=M+PjC8t8O6JuF+avHfT8YmT7iIKxRPRcEl7IMAQuNwRY8szsFWm5KqbW93uh4sMn6Q
 nysO7DosrZ7DirhzZrrqgSOOFTc4wsuL11xUt4+5ycFBGEUPNWCv7dSvrdzj/lPyDpKC
 JDxHAyLPJCtz2LesvlsB9f/LYFhihM7FqTlRN+0YnUfMWh0JVKQM+4rIZil6cY4+b737
 UQievuUVw0EXLDrLAezPYlaQZdw5xtkbsWnFWLSSNvsX4urFRY8kbSFlk214GsRShBZY
 ytbQscDucjwXUEfrPLL2sVxkwC+w2bpvoV9V7TUARVW3zQl6bJDn6CyU2Iu1Gy2P7agG
 BF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722641415; x=1723246215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zCvHOTr4DWIO6ihfVg/jezefUAXAzB8dGrgBA9uw420=;
 b=AOhykAmfJic6MTgHg8vcf2ZBW8gomEm1zS1yy+XMLoR2iQlsEGtWjIIUVhhNsl9Hs2
 7FnrkNETmrRJSTZWXd6nn3irvKRb5ZDO+mB5fJQcq8eR/zh+GdhBuf+EJbPIiqw+BuGV
 J9/VDLOckTWIpnOSZWHMH0Fk7vzmoePUzQTw+97gRh9noWWdVPGwe9V28SOGbt0ZrrZ/
 y33942sadJeGhnledkJNTpf6hBI7HAKk9/yrKABBpfOYBwDFX9PwFXp5K7OrZa77nmzQ
 WGjCnnfL8Vdu2g+8ZgnBjEgWw8fF1Y0WaICDoe+qsdiWTO634UXF6SNZxbo4ZGqCtnDJ
 hMFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeH1hcOfw+ufFmfdnEu/7sgCUXqdffrxiex6E7ybhrPz17t/SP0UDYI/O3jxg2KtBF/q4H8Lugym3/GyKg5VougUdbM+I=
X-Gm-Message-State: AOJu0YzN8IghYKWTJg1rUbmTyAXku7b9IAoGogAB1Z85QvC90lnHptTX
 YXzxoXW1oKf5WwKCIMlU9BtdnMFGBlA7s3/cS7xS0B7ogb+0Cn6QYlqU2elsMgo=
X-Google-Smtp-Source: AGHT+IEu4ReqPewLy3+YeLujGnWzfduubpOgTavre6xLCJQAH4JlaT7uMa65oG418XjJOzZXiq8n2g==
X-Received: by 2002:a17:902:da84:b0:1fb:75b6:a40b with SMTP id
 d9443c01a7336-1ff5722e66emr67917195ad.2.1722641414816; 
 Fri, 02 Aug 2024 16:30:14 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59058c44sm22669805ad.139.2024.08.02.16.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 16:30:14 -0700 (PDT)
Message-ID: <27d2b217-9568-43a9-aaaa-bc463441727c@linaro.org>
Date: Sat, 3 Aug 2024 09:30:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Migration patches for 2024-08-02
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240802142633.19249-1-farosas@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802142633.19249-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/3/24 00:26, Fabiano Rosas wrote:
> The following changes since commit c4d242501a61093a8b80ee8f6dd071c5110a100c:
> 
>    Merge tag 'net-pull-request' ofhttps://github.com/jasowang/qemu into staging (2024-08-02 15:53:54 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/migration-20240802-pull-request
> 
> for you to fetch changes up to 0bd5b9284fa94a6242a0d27a46380d93e753488b:
> 
>    migration/multifd: Fix multifd_send_setup cleanup when channel creation fails (2024-08-02 09:47:40 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - Akihiko Odaki's fix for a memory leak on ppc migration
> - Fabiano's fix for asserts during multifd error handling

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

