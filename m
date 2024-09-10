Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24600EE01E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8PP-0006sm-9j; Tue, 10 Sep 2024 17:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8PN-0006jl-Eo
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:28:21 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8PL-0002Ov-Od
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:28:21 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d4ed6158bcso4261168a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726003698; x=1726608498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a9bH10G/e8jqyvXUWfdzUhJ37BLwWekALfOeKYAyo7g=;
 b=tNVhEsGppFnrQF/L6qhkvrH1z0+GferAq/EQSycfwutXiHsUgA6brLSadW2sS92HZN
 yGoI4SvARI7Duhpp+yelgp7h0q/77cdIF/w6/jMSgpeJIaMpI3MlKNSAso2vL4aA1U9K
 3jeJT9TYvjL31fJtj5YJTUr8b/jVWg1dPgf1goL2QZvAB8D47Ht7vrjD3ntWXnvToef8
 /h4sbDtKOl/8m3Gb6h1BJ0EBRz9/PrDSaEegDN5r2u8JBQ6IbVFtBq7nBteWtiU9Y8gV
 T7b8GslTyoc5jcNA1qRTEmQZ0aRiGJMt8iTkdYSJRwMHq2gB/BXG5mNp9OUsPFFNvzvo
 41HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726003698; x=1726608498;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9bH10G/e8jqyvXUWfdzUhJ37BLwWekALfOeKYAyo7g=;
 b=FaEDCPntEiL2WZWCXX+1yLvLxOW5ULD/qEl0XD5HyfihV6zl0MuV17wv4CAqzeu0rk
 BUqNpBmxJ4cbA52kpGgJzFl/pOpMy6cNXlDejK4FDale12su2vX6j4deGq1FVow5FJOU
 IvFxAQm9EZulFhOeOLhzYKGKDabqH3oQAMiGLcjuOaKEju0pounrHKw9EVo9doAf0ie0
 6PyyW4DkoS4D/lZ5fCicwX/Tftp/9QAbPQHvEsnqhaw6DuyYSvuap3xwpujdC/nLxC+z
 D+oyb7gfjsb+FNF+5l64ts7nAON/0hK9hMxpEFpPvHxXvp0e2yw79V9yMlaKIGHLnO+T
 8YDw==
X-Gm-Message-State: AOJu0YxRy6KlYmosYzIT7sWnnIxbAdTDmyFeVt2PBr/0zKBC70H0cX8S
 IvQUhOvff2G5/UlGVWBVlqLAwLJq9/otSgrtmFhusBQziRyyKxRsW/2IlW60o2QtvDUOwBzRgOY
 O
X-Google-Smtp-Source: AGHT+IFJlKNlxSaqF6BhU/uSazxBzISFUk+bPMUb6WYjaSwxV5+Nu7kDXEKpu+v58pQ2X02SiAZDtA==
X-Received: by 2002:a17:903:32c1:b0:206:fd9d:b87f with SMTP id
 d9443c01a7336-2074c5eb15fmr22314495ad.17.1726003698107; 
 Tue, 10 Sep 2024 14:28:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e33969sm52864815ad.103.2024.09.10.14.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 14:28:17 -0700 (PDT)
Message-ID: <f7f1cb70-08f8-48aa-9db7-cc7a119a4234@linaro.org>
Date: Tue, 10 Sep 2024 14:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tcg: Fix branch/label link during plugin expansion
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org
References: <20240910212351.977753-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240910212351.977753-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 9/10/24 14:23, Richard Henderson wrote:
> With tcg_last_op(), we always get the last op of the stream.
> With TCGContext.emit_before_op, the most recently emitted op
> is no longer the last op.
> 
> Instead, pass the op being emitted back from the allocator so
> that we can link it to the label without needing to look it up.

Oh, I meant to point out from whence this comes.
The plugin uses a conditional

  ld_i32 tmp18,env,$0xffffffffffffdb10
  mul_i32 tmp18,tmp18,$0x18
  ext_i32_i64 tmp17,tmp18
  add_i64 tmp17,tmp17,$0x575410edadc8
  ld_i64 tmp21,tmp17,$0x0
  brcond_i64 tmp21,$0x0,ltu,$L1
  ld_i32 tmp18,env,$0xffffffffffffdb10
  call plugin(0x79a2abfde66a),$0x1,$0,tmp18,$0x0
  set_label $L1

Note that the branch is X < 0 (unsigned), which is always false, and thus the branch is 
optimized away.


r~

