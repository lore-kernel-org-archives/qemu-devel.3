Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3367AC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcRY-0002eh-Bn; Mon, 24 Jun 2024 01:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcRV-0002eR-Au
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:40:42 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcRT-00061D-D1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:40:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-706680d3a25so960959b3a.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207638; x=1719812438; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyGtdwMI0rszyD+Q4TkSM2eREuaE56crnIAOVOO5YBU=;
 b=xO+EMbiDBJvmvsaOrUZe/3v02sc5O9QyAz6oLD6EufXPTTtFJoC9K+q78kU/ljziUM
 Wj/AesnOzMmJQlCLPTGT5xw5l4jwyWiO8Mfml6Q7BruJGLZ+YBJv8zIeUJJj4Pcw+fWK
 Dltba68+hnnNOTXLKgxb14g9B2mCa+dQrX5ayuMacpqpu0RZ1IZSibAwsTEbUP4FxcLR
 PFRgL4Le0ycwoJ/x7RCgC22j9Vt9O6D2fMIlSnbAwyYTCjjpGmeBqW/c9h/gZ8E3ANFm
 tW1N/yfYvN6LBRcrLubRzr+vXcY+diACxJATiiky2vg4OirlMuXQahncCwEwrSVCmhrd
 j7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207638; x=1719812438;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyGtdwMI0rszyD+Q4TkSM2eREuaE56crnIAOVOO5YBU=;
 b=XicdYGD+/66gKy7URZTv7lQI2n4yFfSV1KhIKC9aOa7cEe1ASwqu0CxKjLZaqtYnXi
 eltoQmJLs2Mby363cVX/hJyXSHKPBkv0ttcIHg4OLwFuVW1MaLFay0mpGR0/8WHX86WE
 WyIUxJFyIn03iBV5JJbOFBrWNhdvrfi5X1e+VGaw6l8wBqEHIo5vygnLDbNvFY46LQOG
 Psdl+jXxwE8ETprn8UfGRrmZdqdwKRNNcpEyvJAszSXDfbkNw3V7mtlEdD8sd8Em28Cn
 FeG0jnRIcWEgDY20ei229GE5njvQkBtLr8c+HpzF0E/hLogz3hgqovYx3vj0mgYTZw/g
 m3eQ==
X-Gm-Message-State: AOJu0Yy2Bw/FuJbsNw3EtAMBxTrX34++0FznKtYld7AfcQUaf+Klr3Rs
 kQcHnv70uTXIwRfKK/r4XIEmzKH4Sb9RA9C+vgS2Ea721nC1Dx3GXqkienp8x+8=
X-Google-Smtp-Source: AGHT+IGWhq6WFAEkjB4Yy82T0Hr6APa8sv7UV4+73bnGnLfGpSPAQQWqrTj+qL0oOx8tc3Zq5lAmZA==
X-Received: by 2002:a05:6a00:2d12:b0:706:7052:205 with SMTP id
 d2e1a72fcca58-70670ee94c2mr5124185b3a.18.1719207638087; 
 Sun, 23 Jun 2024 22:40:38 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b401:1758:f7d8:1e03:a6d:61a0?
 ([2804:7f0:b401:1758:f7d8:1e03:a6d:61a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7067049d14esm2816461b3a.115.2024.06.23.22.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:40:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Add MTE stubs for aarch64 user mode
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <87ed8zttge.fsf@draig.linaro.org>
 <29b9c8e6-055d-f895-f178-dddd407bdc69@linaro.org>
 <87h6drew4r.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <f6b92270-90af-1b4b-e098-eaa6d5dd4e56@linaro.org>
Date: Mon, 24 Jun 2024 02:40:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87h6drew4r.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.379,
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

Hi Alex,

On 6/17/24 6:50 AM, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Hi Alex,
>>
>> On 6/14/24 12:49 PM, Alex Bennée wrote:
>>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>>
>>>> This patchset adds the stubs necessary to support GDB memory tagging
>>>> commands on QEMU aarch64 user mode.
>>>>
>>>> These new stubs handle the qIsAddressTagged, qMemTag, and QMemTag
>>>> packets, which allow GDB memory tagging subcommands 'check',
>>>> 'print-allocation-tag', and 'set-allocation-tag' to work. The remaining
>>>> memory tagging commands ('print-logical-tag' and 'with-logical-tag')
>>>> will also work, but they don't rely on any stub because they perform
>>>> local operations.
>>>>
>>>> Since the memory tagging stubs are not common to all architectures, this
>>>> patchset also introduces three functions: gdb_extend_qsupported_features,
>>>> gdb_extend_query_table, and gdb_extend_set_table. These functions can be
>>>> used to extend the target-specific 'qSupported' feature string and the
>>>> handlers for the 'q' (query) and 'Q' (set) packets. These new functions
>>>> are used to add the MTE stubs for the aarch64 gdbstub.
>>>>    Note that this patchset requires a GDB that supports the
>>>> qIsAddressTagged packet (recently added to GDB), so the gdbstub MTE
>>>> tests introduced by it must be run using GDB's master branch, since the
>>>> GDB in the distros hasn't picked up the change yet.
>>>>
>>>> Once GDB is built and installed locally, the tests can be exercised, for
>>>> example, this way:
>>>>
>>>> make GDB=~/.local/bin/gdb run-tcg-tests-aarch64-linux-user -j 32
>>> It looks like there might be some BSD build failures as well:
>>>     https://gitlab.com/stsquad/qemu/-/pipelines/1332635371/failures
>>
>> I fixed the build for the BSD target in v3, however I think that the GDB in
>> the test containers need to be bumped to GDB 15 so the MTE tests can pass,
>> because support for IsAddressTagged packet is necessary. GDB 15 branch
>> is created by it's not released yet, so I don't know to proceed..
> 
> Two potential approaches, you could extend the configure segment:
> 
> if test -n "$gdb_bin"; then
>      gdb_version=$($gdb_bin --version | head -n 1)
>      if version_ge ${gdb_version##* } 9.1; then
>          gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
>      else
>          gdb_bin=""
>      fi
> fi
> 
> and set a variable exported to config-host.mak to then test in the tcg
> test makefiles.

Done in v4. Thanks for the suggestions!


Cheers,
Gustavo

> Or you could implement a gdb-version-test command in
> tests/tcg/Makefile.target which you could use like the existing
> cc-test/cc-option commands to extend config-cc.mak and use that to gate
> the tests.

