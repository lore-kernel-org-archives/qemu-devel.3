Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B14CC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 06:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ2em-0003x3-Eq; Wed, 31 Jul 2024 02:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ2ek-0003w7-TJ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 02:17:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ2ei-0003T7-8B
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 02:17:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so40873125ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722406666; x=1723011466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UNTERHp3GIYXxn5sGB74xauir6WmXCe2lGjra3gAtIY=;
 b=iccTkJ+SVKpvTmMV7n3q2dCSaM3DqIjcJ717GIct6Kxmx/Ctp01+Sqielg57qu+1l5
 OFuyMDGVd7S01QracYc/TwU27v//oZOpEBKRIN+9fITED6hR7qzsmtPmnk5rqqUPaazg
 ActMHLQp58cpxWO8WLEOO7QgO8OMkzU1tCPUTc2snujy+YBLQOiLzd2IeLejOMUgoLai
 BFFDVE4v1kU4Pzil7MVv5WK3x3juOlYuwmgUAhEFzt848WORw7vWQecVyOgzaXcq5RED
 VpjQKe9qfHFJ05rlEJvp8Sjdkr7x9aO3Rq+DGfsfRxBNgDaGqSP2mfcGU5kpG1U1qDc0
 t/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722406666; x=1723011466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UNTERHp3GIYXxn5sGB74xauir6WmXCe2lGjra3gAtIY=;
 b=Dv8aI3W2XQLln6nt7R1grAacPk9EZsTErblI73MhfiEN8CXKZSFKE4u9JqlrZ5gs0U
 LaVPulko0GUmwUpTL2IiWYL6WmzZDFVJjg+IMI9xQ8CczRkw1lqR4VR7VUXfTXfvGVHD
 LQYTH70ZcJtrIc0p7jzrB3/5rOO1TEY8sfU2nVDktUMqYgugInUTnRm2NPJ6wecAM2hF
 5CmU7DbXWq13MkCPYZzoQ3joSdZ9Wb8hhSxh8UyRiqUK2uhbx5POc+IrorhyoVMkmPx2
 /G8r4vCjn9fb+bGiLzNUNJ07o1sABfYesq3fq8VLTwo7ltNz+hFsJhnV7o/9TWlmFlGG
 ziCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+BscpGD5XZADa/HWI9KF+NMrlMUzYfoZx4Ew59EQHmosVZtLq3MgDFVqAru0PbORdUehfBKWlW3aHfQE4ykpYca7St8A=
X-Gm-Message-State: AOJu0YzEjYkimDmTcfW+K1ldKftq09FtC/M7Hv+JMTQCDdZJlAm6gP8e
 mHbSOMgsKFtnn6EOTGUn477NyB1mc2wa3bsE68qeuoe/2IXPwJdGrml2dCoOnd0=
X-Google-Smtp-Source: AGHT+IGXcUFCuNhZemucYUd3frKelJX+lvfbGqaiDWN3JPdz29Qu2JQMGwjSiDzKvqnNN0rTeqaZzQ==
X-Received: by 2002:a17:902:db03:b0:1fb:247b:aa2a with SMTP id
 d9443c01a7336-1ff04938315mr124650885ad.59.1722406666079; 
 Tue, 30 Jul 2024 23:17:46 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee4b0asm112807025ad.176.2024.07.30.23.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 23:17:45 -0700 (PDT)
Message-ID: <ebf41c51-b016-45c8-8442-0c7cb86aa4d6@linaro.org>
Date: Wed, 31 Jul 2024 16:17:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Docs testing patches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240730221957.34533-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730221957.34533-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/31/24 08:19, Philippe Mathieu-Daudé wrote:
> The following changes since commit ef009e4b4dc0421464008e6e303b892141ede579:
> 
>    Merge tag 's390x-20240730' ofhttps://github.com/davidhildenbrand/qemu into staging (2024-07-30 19:21:58 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/docs-testing-20240731
> 
> for you to fetch changes up to 7b60b971cc2f52ed2a69006a2ad709df2831cd67:
> 
>    osdep.h: Clean up no-longer-needed back-compat for macOS 10 (2024-07-31 00:15:00 +0200)
> 
> ----------------------------------------------------------------
> Docs & testing patch queue
> 
> - Test QAPI firmware.json schema (Thomas)
> - Handle new env.doc2path() return value (Peter)
> - Improve how assets are used by some Avocado tests (Cleber)
> - Remove obsolete check for macOS 10 (Peter)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


