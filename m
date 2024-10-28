Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0354FD5B156
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 21:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5XBB-0005Sm-NT; Mon, 28 Oct 2024 17:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5XBA-0005Sb-De
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 17:21:36 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5XB8-0005FS-C6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 17:21:35 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so3760718a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730150493; x=1730755293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j0iJVhoRpdeUvteOGUnPJKMywbu0q2dowPa4nk25deo=;
 b=JtEJI4S5fPSkjpTQpzc/Ffs/gLLZmCjT32/HGbpzUqjbP6PZn9m+KTmvTTlBDPlqLx
 oypzf87ep4auiS1jeFJfiafzPq/y3ctSFaORbcPTrRQBJgWO/8fzURaMMavfW69uGqWk
 DDpQd3RAZs3bFH0ZzBjI90AHJCp9E44eu8H7tuQ725GLvZt+RovQCEHUuKc1pCoiQwoE
 uwFZ9EAhTsiVzbvCK1zbZRRHQ9iO4ihA4/H11MnHhOzueqmEvp4bc9/fpm2nNXRP2SLr
 /yv6nsYqeOTX+l3Iw6j7dC2aZsd63wq0UDiCpldVzBC8tDsJ4fCR8Hp5z4K8aCS+WB+O
 b46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730150493; x=1730755293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0iJVhoRpdeUvteOGUnPJKMywbu0q2dowPa4nk25deo=;
 b=ac/w1p/AG/fsXkEE/IXyOWoWTbG1j5GUYRPMpNfgKpEtjt+fzJQq8rxQaSZCIEgRoG
 EZGTSWPJym8VpKLpoSITfKobLNMeriwSXRmPlFwLeUmtfiaX82FE0muZNnZSOX8ARJxA
 5SR+ZuIOW2EuzRA/gdXNA4hh3ptXTXA27LEWbIFJhWxipDZhkeapNZA6cC7Qm9zt43dd
 +jm3TZNGQrPtehDsfHLqOVn67FTaQ4AonUnVOOGwCfeDgaJbImTcpuGkZZJ9AhF6HQ1W
 I2VBIL7EdHrDTRDdC6NvEhSsmmFblCCSlD081WsailhmIEYp4pM8KmJ7hfGizfbsv9nE
 VUHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQiTxPA3h4BrVcs0tvqqRjueCuYxx/4gYR76KyvXcIQR1w5X5/pUNmz8K72cE2zpw9P2SxxiCNCEGt@nongnu.org
X-Gm-Message-State: AOJu0YzFSBsd5PhjJ2NYPzxrs+Bc5bp11/0oB2Engff8DsnaN5y5uYlN
 wE3gbvWK2XeVguXmFpeE4kWb11q5nRWy7mlZgSDYvgVEQiTWSpptBtEfW5xWu5k=
X-Google-Smtp-Source: AGHT+IG/S1TlxE22WFDTUsJgjDbWr6XoQmA8whxmlNSVe4u7t2s22SglvL2GR5iRgEQMWHuiN+szAA==
X-Received: by 2002:a05:6a00:230b:b0:71e:4cff:2654 with SMTP id
 d2e1a72fcca58-72062f86088mr14669738b3a.6.1730150492652; 
 Mon, 28 Oct 2024 14:21:32 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a0b9b1sm6253547b3a.133.2024.10.28.14.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 14:21:32 -0700 (PDT)
Message-ID: <33cfeae7-d392-4d03-8f22-bb1a1e5dd48b@linaro.org>
Date: Mon, 28 Oct 2024 14:21:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check-function failing on func-arm-arm_aspeed
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>
References: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

Hi Peter,

On 10/28/24 10:14, Peter Maydell wrote:
> Trying a "make check-functional" I find that the func-arm-arm_aspeed
> test seems to hit a timeout:
> 
> 18/18 qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_aspeed              TIMEOUT        600.08s   killed by
> signal 15 SIGTERM
> 
> This is with commit cea8ac78545a.
> 
> Does anybody else see this, or is it some oddity happening only
> on my local dev machine?
> 
> The "full log" in testlog-thorough.txt doesn't seem to be
> very full. All it has for this test is:
> 
> =================================== 18/18 ====================================
> test:         qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_aspeed
> start time:   16:54:50
> duration:     600.08s
> result:       killed by signal 15 SIGTERM
> command:      G_TEST_SLOW=1
> PYTHONPATH=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python:/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> MALLOC_PERTURB_=238
> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
> MESON_TEST_ITERATION=1
> QEMU_TEST_QEMU_IMG=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-img
> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> QEMU_TEST_QEMU_BINARY=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-arm
> QEMU_BUILD_ROOT=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_arm_aspeed.py
> ----------------------------------- stdout -----------------------------------
> TAP version 13
> ok 1 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_04
> ok 2 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_07
> ok 3 test_arm_aspeed.AST2x00Machine.test_arm_ast2400_palmetto_openbmc_v2_9_0
> ==============================================================================
> 
> Is it possible to get the log to include a pointer to the
> actual log for the test (including the guest console output)?
> It's hard to debug tests if they don't report what they're doing.
> 
> thanks
> -- PMM
> 

I didn't observe such failure in last run for my dev branch (which 
includes commit you mentioned) [1].

97/148 qemu:func-thorough+func-arm-thorough+thorough / 
func-arm-arm_aspeed                                         OK 
    141.44s   8 subtests passed

[1] 
https://github.com/pbo-linaro/qemu-ci/actions/runs/11559006814/job/32172747854

Regards,
Pierrick

