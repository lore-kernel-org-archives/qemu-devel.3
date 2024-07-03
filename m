Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA595C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 16:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP39b-0008Hr-Dz; Wed, 03 Jul 2024 12:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP39a-0008HK-Ac
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:48:22 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP39Y-0007CI-Pl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:48:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-706b14044cbso4212149b3a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720025298; x=1720630098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6CHw3yqCSskqhgkAhvOaYaaEp0jr/Ot8CMgsBnXoqQ=;
 b=Pgz0NFjCE4jQlJvKfdd1+9uC/Q+Ga5YrVF+Piy/55Di148YYyiFmqdx0Q4Xe5LI/bo
 4sasd88OgKmMQa07/3UnNBvYk8Fblv1nstDuVaZNstJZ4aYwgyS8VBpnb+h/wS37V3gX
 K7olFvM7z7Hbm4jM4JIxl0USECxQZ8/xn/3Y9GBFftabzAYAJtbyhI3NbV73XUEfFxTj
 IOX/UFHAmDNo48h8nj50/kp3w9qzr7DNi4ae6ZeYFlmCaVNc6WDaC0w1BdzJv0QAwuzF
 0K639PhVOfVveVg1kHhL7ftnODer5wAnG1N2t17gFqCRAToXu/ynIiwRbXQdAM7GnbVf
 Q5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720025298; x=1720630098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6CHw3yqCSskqhgkAhvOaYaaEp0jr/Ot8CMgsBnXoqQ=;
 b=pgMVeBNFAjhWhD2MWTuoX1ofLn+FrNdOSloTUvtQLa4Awjc0q8s8VQP2wgipXdD7ho
 agIgXRWEDbVa7Zm2sc4CtKFBmRVEWNPm8wVxEAK47S6HMCJlhanxRHDMJCNDr5uve2Px
 WB3lTsQ7E6RmHmLdS1sSuaj3ced9+8p2xV2tFVCV0TVKhUzOSfntt39EylQWrzXDVVVG
 PstrNVMYXYjaE0nGXy+H4AJtsCWeG6jpQ5qMhsRaITrbe3jZt7XahEjNYgKw9ceNT+NB
 5x5h8wOkEP5BFuvXaXfLg9+kW5O++mz2jJStfvsiHd65pKSgnsyzvqx1CaGBTBteQcyB
 7uLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHVdgJ4Cy8M4un1DsDffpWz1wJ280EMC7dxlbEPfw6OMjhbp0GJXlPDcg/MEBBm0L2PgKmZohVcCcOImmuqe1EEJMHHsQ=
X-Gm-Message-State: AOJu0YwSZHkxRDgp82wOgEyFP3R3tJy+WAWp7HdO5lmNUmAoevIJoGf8
 WaPOTA9g7grGyVgg9v4wJO5Jr7/G3cavjYc7Ur/T/35jUn/LEF+eEndukrIngf4=
X-Google-Smtp-Source: AGHT+IHFqxoJaaiYHnlV2miZdbTR8z11emqES0qnv6m0K6P7nHKCgRdsX0tZTP705UKH+cjTGzinwg==
X-Received: by 2002:a05:6a00:124e:b0:706:b3d0:ffd8 with SMTP id
 d2e1a72fcca58-70aaad2b50bmr12374612b3a.7.1720025297882; 
 Wed, 03 Jul 2024 09:48:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70804b8ebebsm10628589b3a.214.2024.07.03.09.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 09:48:17 -0700 (PDT)
Message-ID: <72a2c72d-3e6e-4c12-b8ca-5af3d39256f1@linaro.org>
Date: Wed, 3 Jul 2024 09:48:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] target/riscv: Adjust PMP size for no-MMU RV64 QEMU
 running RV32
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
 <20240703144921.1281-3-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240703144921.1281-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/3/24 07:49, LIU Zhiwei wrote:
> -            pmp_size = sizeof(target_ulong);
> +            pmp_size = 2UL << riscv_cpu_mxl(env);

UL is almost always incorrect in qemu, as 'long' has no specifically useful meaning.

In this case you can drop it completely.


r~

