Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B513C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzRx-0007jP-Vj; Thu, 25 Jul 2024 10:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sWzRu-0007iZ-33
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:28:07 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sWzRq-00030a-Va
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:28:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso720327b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721917681; x=1722522481; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRNH78SPPa5G0rhyn2Ej3PTDaLde8EB/MLkgyd8OQHQ=;
 b=eXcveN0Uixtb/lNVN+G68kFNgkYJECxQbrnvB/x67s/hiGLmdQlxRRPb5xV00n6TWC
 OBzPZlBb0pKpaEcxftYNVVpKNZMdRq+ACKWxBb8zAEms/70adNnGzKbS82Eypz3Xll6V
 nBc9rqnG2iSFBFGLy0/u5Om1y1cEyJ1+ApGDVBGto6HU35SseVY2dcAWVGTzRSq2kizz
 UEi2XjdzZEU8QXQUmoHO2xZLheL/2SAdclTAHBnc6cRdkz8v8QdshNDUDd/ANXRvUKO8
 XziSOz6Pma7HF1D8TgoeXb8epyOuU9tnlwPt3LBXuL8GISE40fyR33zoIJBuEjjh2S6Q
 NTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721917681; x=1722522481;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRNH78SPPa5G0rhyn2Ej3PTDaLde8EB/MLkgyd8OQHQ=;
 b=OrGKLOgblva52vBWszp7q9JDC7ELw38ykjKFQ1SpFhf6YqcUMyURrgM35DcUwTd8ps
 1E8pCSIs518M5Ns2p2PPNlh8tZT4Sjdx/OdAKNH72KXykv7riWoAxm70XxxtoQxoa1us
 3/9pW7jKNY8l5l2UKyAK7nqSr7KX67UUSHvcVE1FwVBA2eiyQtvN14+Avw7bskX4AO7B
 bPnZdIl0Ho0QPuPD4IzZtaSPOzlMVGQ5u6EoO/Xt9cF8UUkRe/c+6NteTFmo62yYHDT7
 q/frpJEwEbpQgzeH6aN5BoM7ucUwnyMz09u4tqxRD8duEUVMTu0s+LvCcNeUR2el377I
 zBpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCtRSjg9XcOTg57EQCMYboGar4Om3J17NWTLOajoMa/NI9d8L479+sOqrkaQM9r6dzoOCoUnR1e9y7YMUQviRQW712AxU=
X-Gm-Message-State: AOJu0Yz5mbvndlV1hQDFhMtGD6FzcTRiS7mv2f/fcs+cZmNQUp0OGkql
 0OF4xdUarErCuh4PwhyUwdxEw1KuFGjEXQjCTPZ4akS2kwdMA8CmCD8ccDK+/9Q=
X-Google-Smtp-Source: AGHT+IE/gKJylySwMG77UlV+1JVTqizBS2jSeSU8zCC4Vn4WKKqV4YWRgpru+REtsLTANwUJLIRTrg==
X-Received: by 2002:a05:6a20:9192:b0:1c0:e564:d718 with SMTP id
 adf61e73a8af0-1c47b4ae364mr2353738637.37.1721917681030; 
 Thu, 25 Jul 2024 07:28:01 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.37.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead71228dsm1179165b3a.47.2024.07.25.07.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 07:28:00 -0700 (PDT)
Subject: Re: [PATCH 1/4] gdbstub: Use specific MMU index when probing MTE
 addresses
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-2-gustavo.romero@linaro.org>
 <707d1076-4f29-4089-b7ae-0bdd3e1305ee@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <7b1833f8-cfad-c989-df77-d057129fbd4b@linaro.org>
Date: Thu, 25 Jul 2024 11:27:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <707d1076-4f29-4089-b7ae-0bdd3e1305ee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.699,
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

Hi Richard,

On 7/24/24 7:14 AM, Richard Henderson wrote:
> On 7/23/24 02:07, Gustavo Romero wrote:
>> +    /* Find out the current translation regime for probe. */
>> +    mmu_index = arm_mmu_idx(env) & ARM_MMU_IDX_COREIDX_MASK;
> 
> The official interface is cpu_mmu_index().
> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks for the review! I'll change it in v2.

I'm just wondering if you plan to review patches 3/4 and 4/4 in
this series too so I could wait for the reviews before sending v2.


Cheers,
Gustavo

