Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B5FC27C79
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 16:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI9Me-00014W-U0; Fri, 14 Jun 2024 12:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sI9Me-00014D-AZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 12:01:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sI9Mc-0005wX-B7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 12:01:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f717608231so18117935ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718380874; x=1718985674; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UD7vV+R2V+VoEdETM2iLDUT63aEBuOiPfimjUI6Cj7A=;
 b=rwR4WD8Du/0qu8DdI8LQxYUjNsScFiL99WmagWaYNsfYUZGrXS8A4/ifxQTf/czErS
 eOXK7/Hbh9I7w7hNgAnTY3kHD+G4AiRStUzlwK/5vFq+z7X3Zk228v7ujkj1Ln9xXijD
 167ciqrZdeyWB3jBk3PI3VyW/Tyg+qn92uilTN3AWSpQkgfGePkSIJLiqVgeXS7A4x0y
 26LZ3jLdlUca/JSgj0BwmqIuprBfR3lzO+KgNei+Relr7JfWZvYdsjUvNAOZVS1+iJ0o
 6sVLFctkBvUL9xVdCSUpMZLy6BxSIWY+FZEufJ7CKiml2Of+wVkB4OoJyO0qapZq8Lcy
 UijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718380874; x=1718985674;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UD7vV+R2V+VoEdETM2iLDUT63aEBuOiPfimjUI6Cj7A=;
 b=JYfZ85HMLaG3CpoBspKyKc4iSYa3kaSVo3Jx6JVPCYUjn2RfFC771hQbBvV+pHs77x
 zgNGYk3iy8VVSy4dCWeuK4NARv2TFbV471lrHXZ48B3i2w78AFxUeh/2Hcew/R/C5FwO
 XGM9NYnDkjGppTRmO4xF/J4PdK2hvxi1oFky2L3VRhkc43bfyLnUW4bX0UqABIL4zKrU
 gwxMfM0+RJKZEYtbhfRQ8WaL4m6g2ekjvpRexcbEgY0mKcfsmHHC7SsRktOuCBBtkQ7k
 XJIRN2llwp26wxgvQNrM4W5SXUyMxDxmiAUCS8eBKu5mc0EBKdbszsGXrS2GkqIvgTCy
 hB7g==
X-Gm-Message-State: AOJu0YwCGxrCPw2x7MvgacBLDvTmoC4q1wPVhXJ6mFHO9Z0j5u2L3Hlw
 GZ+voHWQCsjXUEMbTmXxQMEkfY7zgDzo3hk5l6VJ3+5Ib8o63JocX8bLCwXYWF8=
X-Google-Smtp-Source: AGHT+IHUK3WUOYn83PnzOOyiZTiYrkCpmZAkgxVqBXLDHa6OmjbYYCwTvWamp4rFBdvxnGtoG4i3Fw==
X-Received: by 2002:a17:902:f547:b0:1f8:6e1d:7f1e with SMTP id
 d9443c01a7336-1f86e1d8514mr12789135ad.40.1718380872795; 
 Fri, 14 Jun 2024 09:01:12 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5?
 ([2804:7f0:b400:8dcb:db2a:52bb:5a8e:66c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f4d159sm33743265ad.289.2024.06.14.09.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 09:01:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Add MTE stubs for aarch64 user mode
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <87ed8zttge.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <6a8e380d-b20a-da3c-678b-4cf72c4350fd@linaro.org>
Date: Fri, 14 Jun 2024 13:01:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ed8zttge.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.018,
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

Thanks, I'm looking at them.


Cheers,
Gustavo

