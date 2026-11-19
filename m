Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8EC606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kfNqZMJJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7Cx-0005De-GV; Thu, 19 Nov 2026 13:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU7Cv-0005Ba-JW
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:50:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU7Cu-0000La-00
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:50:05 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ed408b0d9dso231825ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795114202; x=1795719002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L3j+AI8KB1wLfUtvABeMrPQV6HSJeJ9aBgq3vWxYZgI=;
 b=kfNqZMJJy+IjtwKTrCyinKLdg4030n3QVJ0BprGNA2Wlyemsi9M8uZz1fqe2Brm6qA
 3VYW2FNRN9yE544xJRC11jhL5fPiQomeIzfkofsIJgUVbO8uH9Z1SL90KLHgxcu+fx03
 /dqx6bKQS2+YnBSJHdJPxpbltFaEZH+DWpT6JfTIS8CvzPOcaFD9/f4Ui3JizNQeTTPa
 c59rn8zoiPeVQPIFggsJgczhR857EDybEM6KFuoHVntZDMDRvYCYjC3T3fX65TOoJJeU
 v0mxIiumYD2iWwbRRd5JFMj83jsYPuh03RIpaaE6NN2J+P64DTTbPk+pRh/VOoQBf5wM
 PO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795114202; x=1795719002;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L3j+AI8KB1wLfUtvABeMrPQV6HSJeJ9aBgq3vWxYZgI=;
 b=hPl9TAE651CZTZczTvxjl6L5NqE+KjD2n+reMry7upGeZJvogGWvzM++ZqHZCYmBHY
 qv4k2j/B22fAV6EgwMkoMQ3cftxyS6LABvaFCPQacOl24t8dF2+YYeS+8WNUiICZCoth
 cucLurXWwU/9miaG1Jxa8kQvEQLjjNqwrrhwdoZGOgpg2yOrXI2KxmLk1IKgyLGw4Zhm
 L1Gu6//OPRBgg8ADwvHrbjGSZZz/mboJWmo9rSob+WCMhGHzZhzeZfaUhBm1WprRoexo
 12Am+BFiMYaIN6S7E2XlzXuk8jZPygBEhfNIu0s8qoVBCFhshKrjjBFIgNVngBIucvgs
 bjkg==
X-Forwarded-Encrypted: i=1;
 AL+hErH9tbY+03vn1jjOswCIupI0LGdmAUvxv//3eT5TvyNww9N7+0jakw5TPYE+kx2TfmwE3uth33IA/fsK@nongnu.org
X-Gm-Message-State: APuU4Z95nVXHAImcwNnzXbcdPlFKNLbkqGaqra/0lAb+RO4lQ7JMQxzX
 SZ//8E7vU3RjfO1bkIXi7B7IG8xxJkSt72oebwXjFCED9MRpj1aU0hi0B2or3tYeKDA=
X-Gm-Gg: AZFdTZd1WR6SD51DQd0+0uYXNfTR1JutQArbAVoCIzlNcM5TdGx7rAHa+n8v48EZB4R
 6EXMfyTAdK+WaeZMTg+MCheoNenyjY1Supr3U1IMAtUPg03Jxj2xO628wn6csjYUC0bZ15vduXa
 IWiz1URXXBDMMkEG4dA+8l6G8gupBXrLFXq5fzrmwR4a7pXSTum786o0qavTHC0yB0/vRrka6UK
 amQY5QLifWi0YkIjveg5Jlsr8t1ZD1JZJv6C36wW9cQ36Lo2hxFtW8NBYQWR/j5OfnVzVmhQMeq
 uy/oLWMWYAadBncWQGNWjtvaOwWPSBpw+Ww2DHKhL7GNltsCPEVPCMyP8qHObESHIP8mFD3m8F2
 J+HdI/WZYgvjwsFRGelgOE2Pi9dBT86ixpsce9cVqcZ9AMvkTFMi1QZybX2Q6JZdTqR5RDBSel3
 +NCYoyhevSq49jMRfaBX+72Q7YgV+FKIu1AS2sKejj7PoUzjqsMlkWf0kWF0eqr0ndykN2E+L2k
 c2uewPdufL2yMayXv7CC3h3E3Dig1osOhFoMjzY2TRyU5OKthwr0FFA05F6Fz9qIKo5dVmy7u+X
 BXGlA+teOoSehXj2s9RYh6eqZkSXhxquSayif8vcg9DOSSEDMTvHstjf3sORWWNZ47Y4HbE=
X-Received: by 2002:a17:903:2444:b0:2ef:f5cd:c471 with SMTP id
 d9443c01a7336-2f03f1d5b63mr7498035ad.46.1795114202047; 
 Thu, 19 Nov 2026 10:50:02 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f105b66sm3635965ad.51.2026.11.19.10.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 10:50:01 -0800 (PST)
Message-ID: <7be99d97-a7f4-4a7f-98e4-4666953a912b@linaro.org>
Date: Thu, 19 Nov 2026 10:50:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/i386: compile test-i386-blendv.c with -msse4.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261119130738.269817-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119130738.269817-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 05:07, Paolo Bonzini wrote:
> Otherwise, the test case fails to build for a 32-bit target.
> 
> Reported-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   tests/tcg/i386/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

