Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D86C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 16:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMVF1-0003RQ-Or; Wed, 26 Jun 2024 12:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMVEz-0003Qp-PU
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:11:26 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMVEx-00054V-EC
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:11:25 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-707040e3018so4761808a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719418281; x=1720023081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6hPh2jNpnxRa+iRt/wOd9PFb9G5Q4pISzFnEJuLmEMc=;
 b=IDUIYqP7V68ocgcEyKiKiwVRHIAwuQcs+oGTbeAkWBWJkBXyaW7RXpL/8m6wbzLO3Z
 0Nl5Jo8Xy0aeRNz3F7QZYzgcDckQzORY9bUblFASczT/8Wi7+vI5I2BZz4SnV/2Y4RrC
 Yb5RtIZzu2SXvJq8xZFsUid855Z1ZopFem6C01ohU2YhI1sy93Abmh59pwDQ1/rDEHTV
 ov5ygDFbMiqVDXh++KUNWfvX/KzKxV762BVXWe0wJVTopsdsSAht3B9vNxTU5IOHEjxM
 PGs1VguZGrNM37qDvp8toTrS9pLdq/5dem52wiE0AIuajyseZ3V5VBMOB+h1tzyZodpI
 YWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719418281; x=1720023081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6hPh2jNpnxRa+iRt/wOd9PFb9G5Q4pISzFnEJuLmEMc=;
 b=K4FSQYjEfbhmLMbYLUbMFpH7x6LWqDWeXNUqfxCNoHcq+Y7zfnhCcFSIN6ada2Aiw5
 o3eBURovxjw57L/+AmkqEyBZcnklCbYgt+GkznTiMMv4YK4Ptj8lVH9pZ2tXatvKkN5w
 YSTJkbWUlHe/O7fjogOeZhtPl4YbthkhVM4eR9OWdWK/eiZXTP3LQOCsT0G5Ugah5sVi
 t+NGm3IhNnox9cOIv77m5K8uTONR8N7oJ4lk/MDOPpxqn2AFVk+cbeba0JUu+oyYXfDv
 nEEUU5j0W8gmyh8Odmc9exK4fNyXjnVgaGBlAf3T1nMoZM3j7LuKq5bQHo42dTnffzl7
 nZAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH7IKChhTIFXlEkU7dPbtjj6On+t+Cv9cyFw5gTAiQxmzBiD2PYm/slOTIQX0nc0XHM2AMV36390EEyys/71kX5dxSNU0=
X-Gm-Message-State: AOJu0YwMJ1vu5yDeueqbN/j7IVRWdwh6FszQ3C+6VMcmlamwqkHEgsRR
 pqJTklCHpN4LSkg5bJMrGqX3bEGNMHsh6lU+4oWijP0+3VEb2nFNm7iE9V0FuR4=
X-Google-Smtp-Source: AGHT+IHC47SL3YL58+TOsXVm5csg84mkvIQSRf8ZA9YqVU1DF5X2zyje9Qa6k3HZFU0AH++1GHXfSw==
X-Received: by 2002:a05:6a20:da90:b0:1b4:da55:e1be with SMTP id
 adf61e73a8af0-1bcf7e75050mr14143102637.14.1719418281472; 
 Wed, 26 Jun 2024 09:11:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7069b36b540sm3308925b3a.66.2024.06.26.09.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 09:11:21 -0700 (PDT)
Message-ID: <730a96e7-4e8b-4d67-b7f2-1362d7473be7@linaro.org>
Date: Wed, 26 Jun 2024 09:11:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: restrict SEV to 64 bit host builds
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
References: <20240626140307.1026816-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240626140307.1026816-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/26/24 07:03, Alex Bennée wrote:
> While the format
> strings could use more portable types there isn't much we can do about
> casting uint64_t into a pointer.

Use uintptr_t, obviously.


r~

