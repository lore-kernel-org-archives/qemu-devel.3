Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63065C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURUa-0002pP-H8; Wed, 25 Jun 2025 10:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURUX-0002on-Ti
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:52:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURUW-0005p4-8H
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:52:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so1105898b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863166; x=1751467966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZTCVT0nhkI4i5YROTKfQgtR79411v2iYeSAfWkQY8o8=;
 b=NimpBYYj4QGfRBhDwlnha6WGCWrRgpWTXlu+kcVbpcb+I7X5m2BDWhAgIsisicaR1h
 q4NLIgBhbGZ3yIYSfIgzEL8xO1VLj1KFaWRezBMxVrBQ9xvhxHvzEmo3vKdW4C6chEj4
 o1NTmSiCtg+sT1c2TyM3D0Prt1ctLeznbn+jiVENKE4zzDfXNlukPqbENqL0HQcBjGKs
 wuB+nlbYKzzEM+vZqQjHm9RUms6eg8n92ecB0HPLi273cYaprVEuZ0ij8Irk4rmM/MeD
 pebSslImVPCMCHOpfafntXAlhsPUm38F30ygbtC1Al1UglJG8NOLo+tyQD0PCJhWx7O9
 zOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863166; x=1751467966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTCVT0nhkI4i5YROTKfQgtR79411v2iYeSAfWkQY8o8=;
 b=alDk22rLexqntjYCSdUK33ZpEWaQfULvxIv1XSkWba20IHnKbPvDcXHyfC+GG1gwdH
 idhSg95tvCamepn2jOxj6G2J5QMGrhK9Wy1DQmiR6EjyXGdQ4XWaXMfbcbyzF00k02JK
 MCWK4/c7sKHY7rPEz2SgBZCBjEN6rZNMH5Ngw6sqEINsnRUnCHJUVgUza/hLqRlW35Mw
 y+zBOpHeuETbZCMIz50V9xJAnUaLLAs//9QodaxUdzP4xit25Int7Ih/IzFGG+E2h34t
 ZkHe85FpV9VcQUMrjv3lba12AWUm3XN+uN+KICGNMeFDIE+wgn7pDoZEv2TOeWuFUr1J
 NHbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhSpyOE46JSh/v2jwNwYUD0SFLohQLJV2JocAaClsjS0z/ffLHXlRr9rEhg8jPZM3gjg7r06zEqMnR@nongnu.org
X-Gm-Message-State: AOJu0Yy27e3pWUbPbudsBble0XanzuZrIAYPl5F/9nxM7Xht1Nc+xsDW
 3Vhx9RpoPI+Qo7o9a0PRBFaIt/IF4ixFx+8dc6iRVDEpUb0f3Mb91On2N2w3iOXi7qM=
X-Gm-Gg: ASbGncvnM2B7ebvFt/E7I4usHxXmig1fX+kwdeCgC2r4FHpXId6HEVc5qqRlOuhoioX
 npdiqgRn+2urdSQMU5WCSCqsjCvNAlLzNBgU8M7zbSxv38rNIxxxpN7SJEN9ynxlK1zK62fdCuh
 H6m1Us0CF/ihD1mbOe8dVgCM1AigELNACCRLiL+smRUZt5Rh3lhhL45Ga7Jt1OkQqL8DayhvJoS
 IzSu8166rORASJBO/T/xKNMoUquLdW3R96pWWTgLNkPPQ7c1ELFHiqDkOm5ldbAUzuXHUY2WF+b
 zKf2pfrVzS5AFqNeaQ1egi+/MxVZXlJ5Ovwyg6+xlWaICkOgO9NWs4YOSqH9nfGCSO15pnTr01c
 =
X-Google-Smtp-Source: AGHT+IER9JbPVLTAw1LJrtdXAqyQCpYEk+CIoQ6srP0EMMY93g4bw43/dJFz9J4Urdvv2J/DmgqV9g==
X-Received: by 2002:a05:6a21:7a8c:b0:201:2834:6c62 with SMTP id
 adf61e73a8af0-2207f27d5e8mr5678773637.25.1750863166144; 
 Wed, 25 Jun 2025 07:52:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f126b6fesm12992930a12.71.2025.06.25.07.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:52:45 -0700 (PDT)
Message-ID: <6251ab3f-8727-49d1-ba2b-db2e4305632a@linaro.org>
Date: Wed, 25 Jun 2025 07:52:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/27] tcg/optimize: Build and use o_bits in fold_bswap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 49 ++++++++++++++++++++++++-------------------------
>   1 file changed, 24 insertions(+), 25 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


