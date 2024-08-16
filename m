Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18DAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewe0-00077B-Al; Fri, 16 Aug 2024 09:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sewdy-00076X-FH
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sewdw-0005Ct-OA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723813522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fm/MW6IVb6SWCnHEMBJaX5UWV2lDvT61ZY3tnZSrf8E=;
 b=CAXLjesHHfAv8PQ8JHbdL8wLU19sc+y0Jz3Fd6qtc9V84fDTKojBp0fcjlFyxgXPtjpes/
 0Bhlgp+ylWkO0R459/VHwT5UjkHlAcGCN1tkfYDCMqk4UTOjq1WijNC4rpjAeluK/e2Wyl
 5fevQMD4Vt8KmlnRgRjTqR559/RgRgo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-OTlBr-vLPYmmhGVMzJmB1Q-1; Fri, 16 Aug 2024 09:05:21 -0400
X-MC-Unique: OTlBr-vLPYmmhGVMzJmB1Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280cf2be19so13772615e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723813520; x=1724418320;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fm/MW6IVb6SWCnHEMBJaX5UWV2lDvT61ZY3tnZSrf8E=;
 b=q2BvzgGapaDt3X2BCFSNfcv6agblgJHpd7v5eKXyQpgDA+N6L5BL1anezYvOXZdxOk
 Ns2pmEDjmsmny6juv9VnZzyfoHZZQVsQT2pWA2Kv9ZEYw6wlLLGjEKKmIGDqWl4I1+06
 O7+ooCnwGnsbdGNHyvOVdw9hEtxiqbJjQcAEbv6jorG/a31ltHc3xOgWYhah6glS6wQW
 LbyKs1w/2ikyTnOsJcK+8Y6eNJbdMjS1TlmVnW1N2ZW75SdY45jgXyMjWclfg06cMZHe
 tUNilSNNrNutIikWL4OFu5jRm8MInkIn8dlcOxmkFXnpjxeDPIBHuzQ4rBuRl1AVhZ1S
 e03A==
X-Gm-Message-State: AOJu0YwGfH2oPQuBu3RLMmDMxPKIOXm4b33iyYLOQKGO3bOj344/jnjg
 3p1Cn9XdcYx39vIfsWHwO3knjgA9Xrw51QeLzYOhWHWFvn409lmKwSbP3WdQI+Di+4XOQydug4U
 puhPamvcPg9fzy2OI23eQ4cZY93SLJZCJMCXRZ7nca2QBF0gSifW7
X-Received: by 2002:a05:600c:46cc:b0:426:5f8f:51a4 with SMTP id
 5b1f17b1804b1-429ed793d36mr17394815e9.12.1723813520435; 
 Fri, 16 Aug 2024 06:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU7kfyfp1etvh/Dp4yEjf8Rz8U2Wts2Fm+hWJNn0kaABLbE/5SnlZzXQtA7dEK6j/jqhB6kQ==
X-Received: by 2002:a05:600c:46cc:b0:426:5f8f:51a4 with SMTP id
 5b1f17b1804b1-429ed793d36mr17394605e9.12.1723813519924; 
 Fri, 16 Aug 2024 06:05:19 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed650e41sm22148535e9.19.2024.08.16.06.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 06:05:19 -0700 (PDT)
Message-ID: <c2c05892-cd7a-4f54-af3d-e8e82aa06dfd@redhat.com>
Date: Fri, 16 Aug 2024 15:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 9.1 00/21] Some fixes for 9.1-rc3 (build, replay, docs, 
 plugins)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
 <f0f5f04b-9ffa-46ad-bb2a-a497de3c1c41@linaro.org>
 <878qww39xu.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <878qww39xu.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 16/08/2024 14.54, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 8/16/24 00:48, Alex Bennée wrote:
>>> The following changes since commit b0d6c037ea0a825192285f149af72a73a1baaa04:
>>>     Update version for v9.1.0-rc2 release (2024-08-15 20:32:37 +1000)
>>> are available in the Git repository at:
>>>     https://gitlab.com/stsquad/qemu.git
>>> tags/pull-maintainer-9.1-rc3-150824-1
>>> for you to fetch changes up to
>>> f39cbfc9f8dcb17e8168735acb6fb75638d9904f:
>>>     plugins: fix race condition with scoreboards (2024-08-15 12:10:23
>>> +0100)
>>> ----------------------------------------------------------------
>>> Some fixes for 9.1-rc3 (build, replay, docs, plugins)
>>>     - re-enable gdbsim-r5f562n8 test
>>>     - ensure updates to python deps re-trigger configure
>>>     - tweak configure detection of GDB MTE support
>>>     - make checkpatch emit more warnings on updating headers
>>>     - allow i386 access_ptr to force slow path for plugins
>>>     - fixe some replay regressions
>>>     - update the replay-dump tool
>>>     - better handle muxed chardev during replay
>>>     - clean up TCG plugins docs to mention scoreboards
>>>     - fix plugin scoreboard race condition
>>> ----------------------------------------------------------------
>>> Alex Bennée (2):
>>>         Makefile: trigger re-configure on updated pythondeps
>>>         target/i386: allow access_ptr to force slow path on failed probe
>>> Gustavo Romero (3):
>>>         configure: Fix arch detection for GDB_HAS_MTE
>>>         configure: Avoid use of param. expansion when using gdb_version
>>>         configure: Fix GDB version detection for GDB_HAS_MTE
>>> Nicholas Piggin (10):
>>>         scripts/replay-dump.py: Update to current rr record format
>>>         scripts/replay-dump.py: rejig decoders in event number order
>>>         tests/avocado: excercise scripts/replay-dump.py in replay tests
>>>         replay: allow runstate shutdown->running when replaying trace
>>>         Revert "replay: stop us hanging in rr_wait_io_event"
>>>         tests/avocado: replay_kernel.py add x86-64 q35 machine test
>>>         chardev: set record/replay on the base device of a muxed device
>>>         virtio-net: Use replay_schedule_bh_event for bhs that affect machine state
>>>         virtio-net: Use virtual time for RSC timers
>>>         savevm: Fix load_snapshot error path crash
>>> Philippe Mathieu-Daudé (2):
>>>         tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
>>>         buildsys: Fix building without plugins on Darwin
>>> Pierrick Bouvier (2):
>>>         docs/devel: update tcg-plugins page
>>>         plugins: fix race condition with scoreboards
>>> Stefan Weil (1):
>>>         docs: Fix some typos (found by typos) and grammar issues
>>
>> Patch 19:
>>
>> ERROR: pull request includes commits attributed to list
> 
> What does that actually mean?

Stefan's patch has:

From: Stefan Weil via <qemu-devel@nongnu.org>

>> Please re-spin.
> 
> Should I just drop Stefan's doc tweaks?

No, IIRC, you can fix the commit by doing

  git commit --amend --reset-author="..."

  HTH,
   Thomas


