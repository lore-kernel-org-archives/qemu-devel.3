Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B557D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxLb-0001g5-Bv; Thu, 08 Jan 2026 16:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxLZ-0001do-SD
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:15:09 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxLY-0005CY-7s
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:15:09 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81c5ff546f6so703959b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906907; x=1768511707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L6EW18kzztUHXC1Qz3Jtg9R6p2G4J491Y9oCkF/TlEQ=;
 b=I2XECQLFemn9BRUgTlywXgt5jp0JpVxdDeNjZ5wATvRh6eh97bHvexZsrRBtmms0bB
 0jb6RmN1hNlnQUY++ldTTDbDsdxjmVU6POtLnL0kRfTHkss1D+jAp2Xm4P6NhpZayYKf
 8jo9xPhkbNXwmfbo/o+phfYu2KGWxwZKJig7GiP+YblVJAXI/m8FK/MnjmBZLadveQUF
 SiAkuzDS9F5h5dQdIC7FioaTM4/FYyHxZ8/hF0T9WxnV++dJ1yxodMBu7f8rHOaUuzmj
 a3tWEEO3VSpDsbepncY0/l0Kb6tyMDFZC7ekM+axXfTitQGM2ybtYy0K/im8ioubVuBY
 nQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906907; x=1768511707;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L6EW18kzztUHXC1Qz3Jtg9R6p2G4J491Y9oCkF/TlEQ=;
 b=urhh/XBve0fn119nWK33lREUt8rry7E7eNYdHKIfEX9JIYgP4jLmEF+lOKOmLHU1G+
 gA/2HLI0+qUUL/aYUHjLzOm4raPheLqjOcpv3XsnH+JGgxZrRSKszKEbx7cHKHreTa3b
 w8gMJ4fNY4o0xLfDFqk3zRF+gbVz2QxEONMfHPQ3nSNb7B9LWtZs+xmmAsyxWQxsVqMC
 leMAb0mx+sLM6exYMIURcUUpm7UDkSNQWbbnNVuHCgfMg8R3DMlOAbmpWZRbSEFBQvTa
 noRHKljMNdfA++6CBBmFNWS8wa8gaSXoT3aXAFwmTCIgwknn3DaroPTAphAh6dvwBkQi
 0iLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJfh8xNLKjOFahDwqxwRV1OAH9aAMq8XmLsVD9JOFIZfsU2aVz0bBh4gptua2CtNy4PH9i+nrOTnPb@nongnu.org
X-Gm-Message-State: AOJu0Yx/Ka59Dx2gMVuKa008+aWwORgWevBHVlSSf4UrDQMhzi+P082r
 8/GDU/BtzRVN6w6KhzccYvskgvCp2ayXxqlemwTKXMS470bJsAhykGHV6QF1Y10W+iU=
X-Gm-Gg: AY/fxX4xd+bpfRVT5SzNwy6DKVrwLnFeFMlBqaoWJsvsLQhVad4RDXU47jN/FJG7gEJ
 7gwREKQJHg3Ni4JBlw4jW28ZlhJBKO2+OdHXLusS5Buk03I/CD0j8r4gdTiYgHYl42MPIuS9GBk
 EGwZ4l1SUzRUNkN4grAYGh/q+CpHQRyJzvUOIOPT++UueIEA+zFjcMBKpoc2uqU2zJ17boghqUJ
 rXzrKL8heP6m5b7j1RzvXu1Um5FbbirCsfSoqthUeTmcVTXGhDsiiR8FngVMS1IB4rbM21OS3H+
 iL5d7u8DPVSCPC0w+UsPrKyVAdVuTS0gnvkzQjUGHiM0bxLFw/5QJ0EVUwgAz2Fhm8AmdE3bg4S
 N+YJtRxfKmyiDY1TuphCAspwS49o9R4yRLv82qxEzVPHtydVT0lrDS5/I5twRZ21smf+FAm62yk
 5hnBc0F8GvB5CngrUMjfX4PYoC5VQceXxI1fAvkUe5iTFWtYXnXZLeGm1t
X-Google-Smtp-Source: AGHT+IFqGeuoTrWRhfGGIePxztE44uBS0XnYAmL7ULua5uahN7FK3INsgjTY4j28ppomQ0JSCZcM2A==
X-Received: by 2002:a05:6a00:2987:b0:7e8:3fcb:bc4e with SMTP id
 d2e1a72fcca58-81b78e9b50fmr7329612b3a.35.1767906906726; 
 Thu, 08 Jan 2026 13:15:06 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c530133csm8473249b3a.31.2026.01.08.13.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:15:06 -0800 (PST)
Message-ID: <c8175d51-9b2a-4a0e-9582-515d3f157f88@linaro.org>
Date: Thu, 8 Jan 2026 13:15:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/50] block: Drop use of Stat64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-47-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> The Stat64 structure is an aid for 32-bit hosts, and
> is no longer required.  Use plain 64-bit types.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/block/block_int-common.h |  3 +--
>   block/io.c                       | 10 +++++++++-
>   block/qapi.c                     |  2 +-
>   3 files changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

