Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24F0C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Nh-0001ZL-Ju; Mon, 17 Jun 2024 03:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ6Ng-0001Z4-SY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:02:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ6Ne-0000l7-Cm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:02:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f70fdc9644so37521205ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718607737; x=1719212537; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Nk9sdeQm7q7Id6+903KSpohEI2EqAd9kI2mLTgvphQ=;
 b=vrl9vqh4PRZfd/nv1WVlAwI2SOo+owQ53S5ltF6graWF2Gr4ldnXUTkMX5zHbnz+y7
 M6Yz+frerIyLGQF1isP87ch30pmoYa46TOF1/IRZhGRJdkSIu5AnkXkQx3AqOJcwNnG2
 VFaJiOS1eXtwZaw8KVab1H6A/kj6rt0tLP6Z1Z3KL1f6lJ5WMAz0kaqwizzUIw0fDCjx
 41Biy9CPnI8Xhwz1oF+IRBsa9AABdQG+9XW6XKyGErgpXGWX5yWM1MVuwXWR/Gmc2w++
 /tsc6v26sTIu2j7Y2tAVG1Zf242KdnMiYmKsZ4AxAYqmH+pUjiBzchtNhd+tBVWbXTVk
 NH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718607737; x=1719212537;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Nk9sdeQm7q7Id6+903KSpohEI2EqAd9kI2mLTgvphQ=;
 b=JP31zCbMWYYICStPQfXsOr+j9aaryDE7m9fFmp/oFHjpyzJaJGBVKfCs+8dq5N2Rab
 AyW6A2qlHRsKl0byNlxIBsoFAnjqlFQwrBgNYt/tqrSQQYv9ZpFI66BGMBW4+rzM4cCI
 ixUUgh3X7GISbVcoe5c5l4QqFTK7GkD4BqRcBHuV0+NJXa5ytD/2Opj+RldfQBA0ofLh
 CLnnOHwhq3deaxoziED3dsMOca8saN6ogS9Tpnf5bw17Tf8HIeM8JXH4z6fXZNQR61g1
 wH7LRilbyONjGqpcjbZbIRXZEtEDc6WugNH4M2agIzZOzcf7Pnyh8S8y/tQwEaAolW9s
 nW0Q==
X-Gm-Message-State: AOJu0Yzp3PsEUHeGiKkwEjN/abinAxI0s7Kj2Hapwp2lTfXkjEEAr1+1
 TExO8Mug2C0VuEJkOqIKzyecvAFJKhNJo6gbcaH71NetGlnKus02cWKUZNXfc9g=
X-Google-Smtp-Source: AGHT+IGm1AophtB/1RGcH2KDvvfqQO8rLQl/v4Ly+chT/VVLOY/bgGgSg0nT2hLsL5WcZblkFuX5EQ==
X-Received: by 2002:a17:902:d2ca:b0:1f7:207f:7081 with SMTP id
 d9443c01a7336-1f84e1d39e7mr208384675ad.14.1718607736536; 
 Mon, 17 Jun 2024 00:02:16 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f5c56fsm73596515ad.305.2024.06.17.00.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 00:02:16 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Add MTE stubs for aarch64 user mode
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <87ed8zttge.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <29b9c8e6-055d-f895-f178-dddd407bdc69@linaro.org>
Date: Mon, 17 Jun 2024 04:02:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ed8zttge.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.677,
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

Hi Alex,

On 6/14/24 12:49 PM, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> This patchset adds the stubs necessary to support GDB memory tagging
>> commands on QEMU aarch64 user mode.
>>
>> These new stubs handle the qIsAddressTagged, qMemTag, and QMemTag
>> packets, which allow GDB memory tagging subcommands 'check',
>> 'print-allocation-tag', and 'set-allocation-tag' to work. The remaining
>> memory tagging commands ('print-logical-tag' and 'with-logical-tag')
>> will also work, but they don't rely on any stub because they perform
>> local operations.
>>
>> Since the memory tagging stubs are not common to all architectures, this
>> patchset also introduces three functions: gdb_extend_qsupported_features,
>> gdb_extend_query_table, and gdb_extend_set_table. These functions can be
>> used to extend the target-specific 'qSupported' feature string and the
>> handlers for the 'q' (query) and 'Q' (set) packets. These new functions
>> are used to add the MTE stubs for the aarch64 gdbstub.
>>   
>> Note that this patchset requires a GDB that supports the
>> qIsAddressTagged packet (recently added to GDB), so the gdbstub MTE
>> tests introduced by it must be run using GDB's master branch, since the
>> GDB in the distros hasn't picked up the change yet.
>>
>> Once GDB is built and installed locally, the tests can be exercised, for
>> example, this way:
>>
>> make GDB=~/.local/bin/gdb run-tcg-tests-aarch64-linux-user -j 32
> 
> It looks like there might be some BSD build failures as well:
> 
>    https://gitlab.com/stsquad/qemu/-/pipelines/1332635371/failures

I fixed the build for the BSD target in v3, however I think that the GDB in
the test containers need to be bumped to GDB 15 so the MTE tests can pass,
because support for IsAddressTagged packet is necessary. GDB 15 branch
is created by it's not released yet, so I don't know to proceed..


Cheers,
Gustavo

