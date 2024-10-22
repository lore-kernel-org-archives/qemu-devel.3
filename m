Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26BFD2CE12
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 17:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3J2K-00084Z-9G; Tue, 22 Oct 2024 13:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3J2I-00084O-VM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 13:51:15 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3J2H-0005hR-DH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 13:51:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c8c50fdd9so609425ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729619471; x=1730224271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h7zYxo3OgfiD9slKp6kdWyE2of37hiKKbMy9qbgwesQ=;
 b=NHYc4QtnZ8ZHwkwH1HYX2/QCFj5rh1aG8t+myy4EUTsVOkzMAUiG0OMHtsY5jNXf6/
 4dMTRGTfF+cGsR9JTW6NkhkQdVpAOsy6Ra7X/vqqa+qs5gNG/8uOu3LQLca6dMw5os1u
 SBxCkZ+sf0sQdXSGIb8X+xovVEsX3FVFnM5pf7tvOYoiy5krVzVLk9KX1jWz4CaqMHP1
 Q5BF/AHWdxIBpaeD8A8vmCBGhhUUaelMurA4WJt6Yjp7DD7qOs2RHcHvv/b63kKK1ZKn
 ejRmgSC85Dr214JeqdAvPhTTipoBt6hXp54dFjcfiY182cUFNvfeXSdq3Qtd22U/4lT8
 p/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729619471; x=1730224271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7zYxo3OgfiD9slKp6kdWyE2of37hiKKbMy9qbgwesQ=;
 b=VFT1l13qU39BoRL5CARcZaLVwyCd/mi0H9aoQKgz8mBAe3WeOxL8w3fFe1dlEuT5Y6
 DjIyFFCfg/ktBVl/GuD1Gxg5dleBiZIAkNVvm+TyYoR7qxy8RKILH2/Z7xOvny/GMr1p
 LXSD33WCQMSvjpNKUyv1wEDwnULU+0T+mVZ33JeVBbUJa1tGnjsNL62qE4/U+C3GUAXg
 /lsAvTURbw/+kptOvPByPbLQi/3Xqz17WnoRXOu9CKas1K0q1IVPI6AC6sTetOYIYmA1
 y+Q6os5UV63cCd3Xo/zCx1Y2wVObtbTGZPTjqjdZsgKJ9BPRnJzfnuicILfF7PaSJUHX
 56ug==
X-Gm-Message-State: AOJu0YxkiAKTlZ44ROMaahqi9SircfvPrNVfP40cZ0nxWbqYAdEjdE4t
 kMOiz/fY/frGpehu8pRWLxoKHNRxsd8EGpWWtsDRhars2HnlZJiHruDqZKuepfk=
X-Google-Smtp-Source: AGHT+IF+j5PHYoDZUDG5s0y7d7sstJWlsbMrUQqyrheSQl+mGxBF/kzp9WHTLNi7rFUGfmo4oLixTg==
X-Received: by 2002:a17:903:40c8:b0:20c:62af:a0f0 with SMTP id
 d9443c01a7336-20e96ebc90emr62696095ad.7.1729619471396; 
 Tue, 22 Oct 2024 10:51:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd4fdsm45500945ad.166.2024.10.22.10.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 10:51:11 -0700 (PDT)
Message-ID: <e197e607-c64a-4076-b2a4-1f33b73910b2@linaro.org>
Date: Tue, 22 Oct 2024 10:51:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg: Test that sigreturn() does not corrupt the
 signal mask
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241017125811.447961-1-iii@linux.ibm.com>
 <20241017125811.447961-3-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241017125811.447961-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 10/17/24 05:54, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/multiarch/sigreturn-sigmask.c | 51 +++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c

This needs -lpthread.  I'll fix while applying.


r~

