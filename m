Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA62E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgZ8-0007vT-AD; Mon, 09 Dec 2024 11:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgZ6-0007vB-0P
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:24:56 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgZ3-0002ze-Mn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:24:54 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2eb1433958dso3263112a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733761492; x=1734366292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rQ6HhFBEUg7Y5nMS526uaJ8jSTS3tu04kQ6F32MdhAw=;
 b=EjLrjFQhYU5OL6tBQxmVRQd9iQD0i2/Fcb4C4BJ9T013JR7wIN1h7Kmeqq9mwOwTyD
 bFs0saIxy/sEQzmPIZ0XqQLbLNj5Rxd63yG5Q4wsZMbkzX2uUAIWp/gd3A6Q90jq4Rjx
 EFjfixH0DxYRWij+pV9ZPs+XS9LiFaCmkw8696xzT9jli2m2JaO/XGYr2jRkWhVNq3Xr
 fODbiAQ1DiUsr8Ve88qKZM1UnFkAo/iryWpqHr99Xa48jU7q0XI/nwacs3aQctr/Jkn2
 ujD4P/e/K5c+PdJ8ARd3J6wB40RKKJpmwYwSMj6Vc9rcA51thEwG2msPdM6agP9XoA+T
 YCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761492; x=1734366292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQ6HhFBEUg7Y5nMS526uaJ8jSTS3tu04kQ6F32MdhAw=;
 b=SuhSs/zCfvzSlNZXo64kpVjTxuntopULbyIj6BW3N7HTmbN4LRvEe4+Cc/v0LKVwIV
 ThB0i4CY1zXuEAMhR+uAchQp6sYzejBMxfhCoPctsa1eprx8M+IdjkAVmlRM+vWpTYRC
 2prd4I09V0SJTegzicdsSLnJ0+Fs2/COfiWt+DAcKxM9Eb7u3XINmDx1bGuJWBIbFJM6
 t9xCgYcAFSM0A5nOOw4Raf6/hPJV5EXuBVawae/5kBvPpVOfmv6sV/6dxY7XBZvdgru9
 Uxgu3TRSRSEU3X1GUZIHFV1Uf1DWbbEikgP4IggkIIxaUaF/pOCalF/3c7huDUKZXJbQ
 67Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnz9Co+i+l7p91MtDkQeTEtdnyIrwV3rRp984LBGngiSB27pcOiiEuZ3tpKpnHcn8Md9hzjOlcmsUK@nongnu.org
X-Gm-Message-State: AOJu0YxslY2jkn/vQlOfK2RQltN+//d/jb9P0exoyfyhUbpWcPFLuBwd
 yfpCARjqjtBriNxZl9m1Z19Dn0GYfBXGqxFj/XIh2TFQMKia83puwiQw9IQpOh0=
X-Gm-Gg: ASbGncskzimCeb3BPiy31XRyAPqm8GkWBaNPSmDGdwS1t1S/MYFsN1jC89uoIQga+3f
 CtrxT22oMI86A88FQB2tkcEDXL0pMTwoggTkYBUQlskszkJVRt3MQinqCZqO58HuAFp2IBUV4wL
 ffigP3cd0E+P/fnrOmn3bx6EFurLzpqz5jHnoASRjDM/v90b1kVl4E9BiRY1J73KcROV5nyXzva
 28tN4MQdOxPNW1Nkxs0PyBEqz9zkwlbsaQg7gg9uBgnGqw75tSWmC3LL/VTmvG4Qd27oFRKFDeI
 mDTYYRXybac1dlA7k1JrDBRKyZQEeSYJ
X-Google-Smtp-Source: AGHT+IERvUW3VpS1dSDrXTrDdG18SQ+azPUEfNK/FP9Z2UUpB4dCg4KTRRiDgC87/h3fIHA+BrbXxg==
X-Received: by 2002:a17:90b:2246:b0:2ee:f653:9f8e with SMTP id
 98e67ed59e1d1-2ef6ab29349mr20898628a91.35.1733761492276; 
 Mon, 09 Dec 2024 08:24:52 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef6bf32bcasm6395805a91.23.2024.12.09.08.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:24:51 -0800 (PST)
Message-ID: <f85a2be4-f2ad-4c00-aecf-c045b7cd2e1f@linaro.org>
Date: Mon, 9 Dec 2024 17:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] rust: bundle of prerequisites for HPET
 implementation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1036.google.com
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

On 9/12/24 13:36, Paolo Bonzini wrote:

> Paolo Bonzini (26):
>    bql: check that the BQL is not dropped within marked sections
>    rust: cell: add BQL-enforcing Cell variant
>    rust: cell: add BQL-enforcing RefCell variant
>    rust: define prelude
>    rust: add bindings for interrupt sources
>    rust: add a bit operation module
>    rust: qom: add default definitions for ObjectImpl
>    rust: qom: rename Class trait to ClassInitImpl
>    rust: qom: convert type_info! macro to an associated const
>    rust: qom: move ClassInitImpl to the instance side
>    rust: qdev: move device_class_init! body to generic function,
>      ClassInitImpl implementation to macro
>    rust: qdev: move bridge for realize and reset functions out of pl011
>    rust: qom: automatically use Drop trait to implement instance_finalize
>    rust: qom: move bridge for TypeInfo functions out of pl011
>    rust: qom: split ObjectType from ObjectImpl trait
>    rust: qom: change the parent type to an associated type
>    rust: qom: put class_init together from multiple ClassInitImpl<>
>    rust: qom: add possibility of overriding unparent
>    rust: rename qemu-api modules to follow C code a bit more
>    rust: re-export C types from qemu-api submodules
>    rust: tests: allow writing more than one test
>    rust: qom: add casting functionality
>    rust: qom: add initial subset of methods on Object
>    rust: qom: move device_id to PL011 class side
>    rust: qemu-api: add a module to wrap functions and zero-sized closures
>    rust: callbacks: allow passing optional callbacks as ()

Am I correct some patches are from Zhao Liu and got the
authorship inadvertently removed?

