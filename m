Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBE0C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Ndv-0005il-8y; Tue, 07 May 2024 12:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Ndt-0005iU-Hj
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:26:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Ndr-0003Xj-QA
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:26:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f489e64eb3so1167611b3a.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715099170; x=1715703970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIv8FscywEVwlamzYg4H1ui6NHBx+YBcmennfBK4cFk=;
 b=Dw2yX6QElTbJljpZ8m8ChXbV1Sufeo0naoLmGD2GFkbEbGLq4pAAgVQ1obtUpty5Do
 XM2l1bk9/JAUyngBLpcNOopEfKD5gptpN0ZBf/fKZ13qK2LHSsM6RzlEJrYbcSYFGB7g
 bROHTBl5Pxneihkd2bQV3Lo7yUJRA0uWUQqbrlhjPdQmQvfqagcvynlMZp46PdRZrxXB
 b4KvHprmKWJFKYrwBXNRjpsUdqEMoAj291MDRJoMOo2xswxFlCNR4rau7wN53SgtyC+V
 qpd28RoFD9Vso/pzxSSe4QgwuWy+eIvhveimNwrVB4IPmkXqoqyDnAzn9IU3izSKucjB
 o8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715099170; x=1715703970;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sIv8FscywEVwlamzYg4H1ui6NHBx+YBcmennfBK4cFk=;
 b=CaUW668UA2Op/2suKKuSnFP6ag/tJYLii2t3aJSJX2Bk1rIT02mpaO/x1P7V3sRcCy
 CyxullcwzReeerT6G+Lzmt5U+iokdtq3EZnBC+ElQEBYRS0EHfZV4bIBqTPDhP4UpFCU
 iX+F9VDe8Yc+VOcm9DXCJN6wEFn4o0mQ2JHzS1OsNNPD2nmiU5gceZ2YYsDFmED1gV59
 DH21a5d4pts/gw4Hh+8Hx8PqXzq6KvwwRcvh821banEd/rBjqg6uK/F6ES4Vl5wGegfT
 5P6DDE/5EqaktMm8mHaMSTfzw1xfrgR1B1/ryWBCmFryIrc/RwqHBX4AElTDxxum2P4S
 LeuA==
X-Gm-Message-State: AOJu0YxPTghMqwpesXZAsvXFx1jH8W6Kc8wnVILdpRSrDMoOT2DL9CGE
 lNtxqqDLO+hqsupJGQOxLoS7e7ChNnxbmxWaEhWHuOq/4gwlpvsHG9TZEe0Mh17cUFLtyvbnPMw
 D
X-Google-Smtp-Source: AGHT+IGKJpwW4w75Syor7eLRoUrM8kh/3PvUYPes8GWY+dweJHSQyqXvgpH0KSDjK8iiKH8hCG4Ccg==
X-Received: by 2002:a05:6a20:ddaf:b0:1af:a5b1:2906 with SMTP id
 adf61e73a8af0-1afc8d1b24bmr218783637.7.1715099170239; 
 Tue, 07 May 2024 09:26:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a056a00230700b006f46bc0999fsm4915632pfh.155.2024.05.07.09.26.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 09:26:09 -0700 (PDT)
Message-ID: <b1f37a14-b4a9-4822-a4c6-7af632e64899@linaro.org>
Date: Tue, 7 May 2024 09:26:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] tcg + misc patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240507143309.5528-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/7/24 07:33, Richard Henderson wrote:
> The following changes since commit d4c453f64824bbeec56c7e72aa83019a7db70d9e:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-05-06 08:34:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20240507
> 
> for you to fetch changes up to f578b66e8c70ddea71d44db6e2c7abbcd757d684:
> 
>    gitlab: Streamline ubuntu-22.04-s390x (2024-05-06 23:40:36 -0700)
> 
> ----------------------------------------------------------------
> tcg: Add write_aofs to GVecGen3i
> tcg/i386: Simplify immediate 8-bit logical vector shifts
> tcg/i386: Optimize setcond of TST{EQ,NE} with 0xffffffff
> tcg/optimize: Optimize setcond with zmask
> accel/tcg: Introduce CF_BP_PAGE
> target/sh4: Update DisasContextBase.insn_start
> gitlab: Drop --static from s390x linux-user build
> gitlab: Streamline ubuntu-22.04-s390x

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


