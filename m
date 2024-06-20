Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A5CC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 04:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK9fh-0006FV-AJ; Thu, 20 Jun 2024 00:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9fd-00067Q-2c
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:45:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9fb-0008Lz-B7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:45:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso356638a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 21:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718858709; x=1719463509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBm+YQCAUYnn8N48+BvlGT3isSG97JbC3ggo4aExDtE=;
 b=kBIdQIgbg1Auz9hz7zXAWV9KA4aVHXFO/5c9qJD9b+Li5wcnDA00cL6B7sa+SfF1r+
 Iw7Gqs9aHYzd5vW0QXlWW2QLCNOQtECTaMNuI2Pf2ba/VVoECtS1O4loYQQQBnBI2wE6
 BZu5HI5Prvztru4EyFtm51M03fJCTD1mgEOYjDijLiz6KdrNiRViNqljhVqh7HXvvdkv
 xcuWEHE730yS2+tpJJ93mlGvZ2bxl5ShKoMlQ8KoOQ8x6E57gF8r0OcCfTVkLVtVQ1iM
 Ghjlfs5JBFXVgI06p7jrvfQpcz8FhTPRQWOdA3ed8O8+CmAFBBMaX2pMXCaUMuLq6QxI
 oRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718858709; x=1719463509;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tBm+YQCAUYnn8N48+BvlGT3isSG97JbC3ggo4aExDtE=;
 b=qKcHPHgZc0I9/tSNM20Bq+Xi6Qj1gW0mK57B3aempdqxhN0G6Mfmts3FvjiSrvBMom
 PwOalcHPiiuo/zCaEeg3S+PFFA1rG1C3D7l4TRL+WrALt9Ih9oT1lfWoBk4y/KCKgKZo
 nV2l/S0c14UJsUAUZyqnFqXfKHL3Rx1FU1xLUV4gUzPQBbgY1qEi51ZfbAJzr2FuWwzy
 63SHYJ1C+o6uZk/saynzQBraQor5rQlr6bjgkqdVNqJKi0G9UN9LAFFS3WDW0NUL6u7s
 EkpxgTCf0F9SJjqm4f1Vh5gOMPmoJVFouJ5mavTmvXCp2LQSBnNCaapm0hmLO+fCwn/V
 an5w==
X-Gm-Message-State: AOJu0YxDREAbL+wOutgjdI5WWL6AE29U98vsHEFjpjYdEV1kd6OhdFZV
 gl1R09oZMRZnieHsiu8fXb/eR28c7xUQL4Zij2oTpUWMgLTD1KEhFWWilyoF6mtvfrNxCAxEbxU
 i
X-Google-Smtp-Source: AGHT+IHrYVbjzkVd8z4jfFv/c/jubSGmI3y611749uqgWXN9IzNlZuegDLIkkbNuz6gaTG9MKUSJng==
X-Received: by 2002:a05:6a20:1722:b0:1b4:5d12:63f1 with SMTP id
 adf61e73a8af0-1bcbb45cafdmr4226213637.26.1718858709375; 
 Wed, 19 Jun 2024 21:45:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f497a1sm126185055ad.283.2024.06.19.21.45.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 21:45:08 -0700 (PDT)
Message-ID: <ae5a82bc-f9c6-425b-a812-13502207b3ca@linaro.org>
Date: Wed, 19 Jun 2024 21:45:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/24] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240619205952.235946-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/19/24 13:59, Richard Henderson wrote:
> The following changes since commit 223696363bb117241ad9c2facbff0c474afa4104:
> 
>    Merge tag 'edgar/xilinx-queue-2024-06-17.for-upstream' ofhttps://gitlab.com/edgar.iglesias/qemu  into staging (2024-06-18 13:08:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20240619
> 
> for you to fetch changes up to 521d7fb3ebdf88112ed13556a93e3037742b9eb8:
> 
>    tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers (2024-06-19 13:50:22 -0700)
> 
> ----------------------------------------------------------------
> tcg/loongarch64: Support 64- and 256-bit vectors
> tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
> util/bufferiszero: Split out host include files
> util/bufferiszero: Add loongarch64 vector acceleration
> accel/tcg: Fix typo causing tb->page_addr[1] to not be recorded
> target/sparc: use signed denominator in sdiv helper
> linux-user: Make TARGET_NR_setgroups affect only the current thread

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


