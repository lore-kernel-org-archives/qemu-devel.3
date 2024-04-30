Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CCBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 18:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1s0Y-0002Fc-LB; Tue, 30 Apr 2024 14:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1s0X-0002FH-9B
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:15:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1s0U-00083X-K0
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:15:12 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ecf05fd12fso5376383b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714500909; x=1715105709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=96CiHfEkeO/WnbLn30/Z48GGiaKHZepzsC+nvJZ2Yl4=;
 b=EJdUcKCDxnXOc6iHnpKEj7piZeq8t5aee64ZOz115CqVttidS4UleZqddv6HH7jaj3
 vfzN1JDwWBZgueq9W6e/fwJ0hOHIZZpZeioqSWCOsD0Ly95U9HU/WZYnsxKw7QqJQfTR
 KJLbnQOS681GDipykaBlKDxs7MnYQxg6lPDITZCMcAgBHmwe71/xYTTMvLR6rIp/w4cI
 nZCm4mNI3SHMehCSkuIjIt5eIy5mWbukzEQpfnIQnayja0jO/Po7JQPrXSgBZSFFtmD+
 I2a/Gw2/25bR0vcuEwelvs5UGdc6IYYSrP9dlyswmmtS3rQ19la52+EfGRdiCiWRbdwW
 sZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714500909; x=1715105709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=96CiHfEkeO/WnbLn30/Z48GGiaKHZepzsC+nvJZ2Yl4=;
 b=TWrjDubmP6+OF/daUu5KqxxFIPfjD1S7ANO+vF7k4vjemFuSZ3iwPUZTEXeo6Viw9r
 MND3L3GLSk7sCK4LBv+yedFllvZGx2LAnLTSkD9VX/16L3HOQbUNSAANYiTxDjLnne7R
 pcsFvLvPPhdfv+dlzjsBjdHiFiyF6N5jUft2I9EFxmlwiS523mB9yU2zOXMx3UKR1J2P
 0RmmxGxrO5C+nBUcexdaNDNYO17al9BS5rRR46MkujffX5iOvbqk9Eg4oc6qMWUtWyWU
 6PBWdPKhlgih3+kYXT9+xixSbnBARPM31gfiwIUWYSrSV2o0iapLILc8fgHmHIvVaCUb
 0Ywg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiRB7WeEUXOchXycGMdWjQsRgMDrwyEgh6ayi3dsLrUSMV8eLPM8GQ90fd9T8N+8wKZ13VP97hJECWk639Q1CRw+VXx5M=
X-Gm-Message-State: AOJu0YzQnY3LrLwHE0133yiWCAkWAlPPOgdnMRrcNX2RIbKLaTEtfClJ
 vZnjemXhtr792Zc7SyLC5nm2p9N8m+MrsNlaNc3STP+Qzl7D6J8+Y60Fl/UMiuw=
X-Google-Smtp-Source: AGHT+IFFJo/ltVzMuLt3E77mHTP3eDnbzP6eW1MRXKx4aOfrUK+iEPSTwWz2M4l5j+D0l1qnwfo+fQ==
X-Received: by 2002:a05:6a21:8185:b0:1a7:7358:f111 with SMTP id
 pd5-20020a056a21818500b001a77358f111mr628091pzb.31.1714500908946; 
 Tue, 30 Apr 2024 11:15:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 y8-20020aa78048000000b006f2e10b00d6sm15286349pfm.41.2024.04.30.11.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 11:15:08 -0700 (PDT)
Message-ID: <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
Date: Tue, 30 Apr 2024 11:15:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/30/24 09:47, Dario Binacchi wrote:
> The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is not
> always provided by the libc (uClibc). The patch disables its compilation
> in case the header is not available.

Since uclibc has had fenv.h since 2008, are you sure this isn't simply a case of a corrupt 
installation?


r~

