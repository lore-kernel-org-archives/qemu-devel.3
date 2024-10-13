Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32A1CF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t010p-00053X-A6; Sun, 13 Oct 2024 12:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t010h-0004zv-K1
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:59:59 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t010g-00039S-2P
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:59:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so29661035ad.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728835196; x=1729439996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2XyneecOIanh99L6ACF+GbZhk2iGvAhXK2W3YvDhZTs=;
 b=F6ABA+Htqb00SJziyp/8VLIOTPdK56MJpDJXEKw3YVzBf9o7Z5Z8D+577crE8bYZ9s
 kPBJQv3LKN56ZTifdsIUjjGbuDdncdTymAb8Rxnn683qNaPUJfmUlet6Th0SzP+YjCia
 YqmI7oluTHnc7fZcqAUvdtcIPx52ziCevdy8NebA/3HIK/fnS7M4JM9Q1iTpoxY+2hxt
 UAfWRLGeF55lsLmAdUMYmoJQoC0CCzwZh7a6JdUlq7E0x+FvKjsJYxW3iZ2WoZX869Ud
 73x2u/v8E8RFv5kbrJ47FUk+sitoWIla447O5pAHb9gfP1qrTbtSyK1JPHYeLzAMLJe3
 /ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728835196; x=1729439996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XyneecOIanh99L6ACF+GbZhk2iGvAhXK2W3YvDhZTs=;
 b=DV857H+D2G/dGlo0spB0Fhx44gVGCmiuNRVfA/e+cGesVqLn4cryuilIoJ7EZCqbbw
 /QTL8M0qCCv/tTpwITypZeVsEXnCfFRs7jWN1N5mf6/Dnxq/gLkeZKz9KUUTa3wV/X3i
 EETxmMzWq2aqdq1oBnzL0hnQqR8ymPqG5KtrnrWvni//m067yWrduKzL3+dZQl6el2GT
 O8LYfnnLIo5ewMQpJXCe2dyPovNZi1ed3Mn/JmE7zmcVYpVMBzHNP2yf/n4Mkzw/0v+s
 YP1jiju8qvSZ2DS5hIqt2CTaHlnyil3rjvZIO9EI/e2Vxt21eaw3nmKYt+/iuzstuq8j
 UTfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWd96ef8zuTM68+cDCnFaMUl2gZ+0+zzlGTM6G6O9A5QzyYMJ+tUk+nV3hyJPzdEvY4BMIwaxmCQNd@nongnu.org
X-Gm-Message-State: AOJu0YzZC+qeExGQlQQzJXpAs++2o3WrwB1APKfk6TMx4f1PXYqdf/8/
 h+Ad7pz7Nfc9al7X8aR4Vmtx8GvFJXUC2Yozv3KHqXc95WCeqrFQruVpR6gAF0Y=
X-Google-Smtp-Source: AGHT+IFJ23XJ5rbyi880Xz7xbeYWFvASSscVPENasvRxWM7n0Y4VtTV0JYhu3Zfr7jk+y3bZB3uuvw==
X-Received: by 2002:a17:903:2286:b0:20c:c704:6282 with SMTP id
 d9443c01a7336-20cc7046450mr72438955ad.27.1728835196330; 
 Sun, 13 Oct 2024 08:59:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c31be11sm51421235ad.212.2024.10.13.08.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 08:59:55 -0700 (PDT)
Message-ID: <bf8e4873-1fd7-46c0-8619-3f5f0ccd0a22@linaro.org>
Date: Sun, 13 Oct 2024 08:59:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] target/mips: Factor mo_endian_rev() out of MXU
 code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Instead of swapping the reversed target endianness
> using MO_BSWAP, directly return the correct endianness.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h     | 5 +++++
>   target/mips/tcg/mxu_translate.c | 8 ++++----
>   2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

