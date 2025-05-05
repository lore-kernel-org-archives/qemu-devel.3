Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DC8C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBs5X-00025F-BL; Mon, 05 May 2025 05:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs5W-00024p-14
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:26:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs5U-0001EE-40
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:26:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso30598355e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437169; x=1747041969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LkJBvAij+BeLqgNXvmMKNFf1ZbTLAbXQaKB0E6RcS9A=;
 b=bEV5q+KxSM5Hl15pY7FY0Lhnbct9OwnHmrAyvMdpTBZdbl/O6fdxtWJkGqVI6z+PaH
 GlAEhO712o2PUSZhTgHqtqXuHoIlJCN4x5oVm98+d+AWXRliuInbG0LMX85KHgmMRvrD
 LKvsk6pSl58n/fdMiXfX1KoGXsFajZYUY0LnAA7TqMzFeVrYxgsZbawgl4zotySBGxBZ
 ow7TrjBigazdXCJU7a1HACE8OKDtAdoTp05cqETrwglVKZUB5bk/q6XOc1f0YbsAiIjH
 1k44NKdLzMZf6idgPMdEvpSHgEhLcskUHgBoJ4CzhQHRDCm8zD9Jvo3IEtIHI08Cl3Hw
 yoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437169; x=1747041969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LkJBvAij+BeLqgNXvmMKNFf1ZbTLAbXQaKB0E6RcS9A=;
 b=usvqT6ji0a5AkiKXZWzWeYq04+hv09E9HenVUYNDggCGvO2LYIULFG5KejMnAuj0g5
 DdAPOhpdDQkKK2bCO+25sptrcQMP+0NlgZUYXipoYBZ9kQoW/sUS5nWBnZdp+LKcSckd
 xmEla32IlBnqJ7KzZKUMJdmfttju6xec0b1Zt6epk0D8+hxuDkIgndBswEMVfgIPwwNF
 mSwTfo+QoDydcCf/1NPkEfgkHK3i5sET9GYGnoimmnci4RUFHUS0l4yimXKLhuuX79Xa
 i9xBB6+fcuO9owTCXSBUOlhZxUosZNQZBb42BoBtYINIBcjC2ww1EHkqTmGHkKQcJGy8
 9LKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEharXVKfPi8vVc+Z2KnvuZmvCoDy+f6O9pMYWYbsfa011epqpcXEANbW1NdvMAVbnvvJVSfi96Ekx@nongnu.org
X-Gm-Message-State: AOJu0Yx6uY4d1Dd5i0u/IZuAA5WjLZbhJ1UBtmeUxd3z/D/2BceFF8S4
 IftolEifh1Ci2p0rXKBScErrPxkQj+i9gn7yH39t5yJ9zpb3Xar2UyJ58TN+UjI=
X-Gm-Gg: ASbGnctqKbiaIBAzgy7qaW2O4da2loNEy1dUemMbC81reEnFkeEIyLUwY9HOxJwU+yk
 AhtQV2s3tp8WGCxy0Jb/EdG0+H0ta5K1HjdznmOL+2HEe5Nxp+gz2BfPr1pxiizDFJWH+JRnJtD
 ab2472w9D0Wx0Zgc3JZkkOzcT2I2BAMVuwlN0tPZW9WyCgvHfMvkeJ8LlKaUvzIUbZ4Y3x0M87y
 3PZJMBTP1jadg9VataYEU6uQSnjCHyQ99onuGyd9mMt13g+O5fQrK1sPVptSV0KEQRaq8EYH/SR
 33GglHYB8Qb7V/yRDSxAgZCy7ngn+TNDXNwAlkp25M2LrM7Ih5HUltbNzmdy4Wf7l58jctAyei4
 OjVVArpAOl6+Spn0kFw==
X-Google-Smtp-Source: AGHT+IGBUozd5EYxw4BoCEA839SYHPwbLeyOSqqYp+PZ0NADtZ2JNq1DEBFV3Dr/Uf6fGGTyyAn6UQ==
X-Received: by 2002:a05:600c:5007:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-441c1cfc3ddmr76356555e9.16.1746437169275; 
 Mon, 05 May 2025 02:26:09 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315c8sm126580365e9.35.2025.05.05.02.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:26:08 -0700 (PDT)
Message-ID: <9eb73177-2601-4098-837d-9b2b4a81fc30@linaro.org>
Date: Mon, 5 May 2025 11:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] accel/tcg: Add TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h | 7 +++++++
>   accel/tcg/cputlb.c          | 6 ++++++
>   2 files changed, 13 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


