Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF8AC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 16:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPPK9-00084O-IP; Thu, 04 Jul 2024 12:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPPK8-000848-Am
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:28:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPPK6-0003MD-D1
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:28:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b07f27788so213685b3a.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720110521; x=1720715321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ChGgGSRBtyFa34AqS0WSBlI4SMeTkOOzIBOk6Z7fwCE=;
 b=VtLG2skkJbi0IRKPP39PQQBBqSXOoamOKeOWr1b7J3S5PirzjvTRF8yMvNtkX7hWmc
 MQqk1hckGymNA4LbOT8hs6jTmpmV7zsQGUZPqKCvr04VSRYpdcaovIb7AHBvpc1zC+Hl
 ijvhoPAqWQopVUTYZA3jAG6xBIxSiZZ2HgmLKd9+pYC8uthrL4mF9mqMUzYzYZR/AWnY
 zhInBn51FCSoEoqxOy1K3wwyC0WT5t7jw03/hq5q7GeLt9foO+fjMHo1nNbBOoBvOPGI
 FxwBMdAeJ2pKERC1cKGkkIrX8sQ4Qf8RKLgfJDgZ7hm0IAgKk2OEx1GYb8FZETMQJ0P0
 L9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720110521; x=1720715321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ChGgGSRBtyFa34AqS0WSBlI4SMeTkOOzIBOk6Z7fwCE=;
 b=KtWSwA3EkmhTMsC8Xtf+59TSMEZBAe+rbHBJuv22KDtKE7UJVNrYezceCXKGk4bH49
 0OY3BbTNZSQuqWLd2N+95nacaz11xpl5b6ez+oh7vDxfT3WMm/YOnhb9k8Ec0+N77zxn
 wVAKd0xqKG6snCVOYFTq0q59WHUg3WMquoTdQIpWmY6WJ36OIFjnqMXCVQlqqf5NCMgh
 eYUatC6nwkfJeRgTBR4SNqga9jXnRD4MTHSiNJtkv3cIgPCpbf+O4S0kDh4N93ReY9fD
 uBkQP1YXGa8AW2HgDBWBOYky8R4VLuFGO4qvl9Ht6oFYXlE4l9gQd/GpIUcARYJ1B5kf
 fU7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURMqT8MDielx8M6M4QVLx+Lt6XcOp5Hs9dS5CbT6NvKJZUx7iU5S2AIKspmjpIMMY+t1KWDyRbwrEB98wMaGHHb4Ru7/E=
X-Gm-Message-State: AOJu0Yx6+UompM7C8/m7tt4bR5bFFPH/eGugs8vmJM/sXzF/jkc9PGfv
 RJMp9OuWexrmfhCExnB5632BVvUQHd5gnx2uyMRtPPdCGkscqvFCix0N3eABMLc=
X-Google-Smtp-Source: AGHT+IHTVMmepbgcYWr3KXE7dliyPARKIAFjTWbkp9IDhWm9edJniXQ6kKukfhIWgNiTWHzQLUifjA==
X-Received: by 2002:a05:6a00:2192:b0:706:5b58:464c with SMTP id
 d2e1a72fcca58-70b00945ca7mr2021868b3a.9.1720110520852; 
 Thu, 04 Jul 2024 09:28:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7086207ed02sm12457412b3a.95.2024.07.04.09.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 09:28:40 -0700 (PDT)
Message-ID: <19a4fd57-ce0d-4c95-a4df-43a43ad7481e@linaro.org>
Date: Thu, 4 Jul 2024 09:28:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] tests/tcg: allow to check output of plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702184448.551705-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/2/24 11:44, Pierrick Bouvier wrote:
> A specific plugin test can now read and check a plugin output, to ensure
> it contains expected values.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   tests/tcg/Makefile.target | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

