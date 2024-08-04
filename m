Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FF9C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVZi-0002NP-73; Sun, 04 Aug 2024 03:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVZg-0002Mr-EB
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:22:40 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVZe-0002El-Li
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:22:40 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso86955295ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756156; x=1723360956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USsQtartNiA3EHoMTd6HIA/rN0PTAAkjk2EjuUti61U=;
 b=hrC73dtCdB44EOMjZpXigbdEBRzVC18vLhkHTSiczhlohASVdphiHNUHG53AG2kGRs
 YF8IIwzjuHFWG5IaoP2dDTWMFm8/z4UOBmStn90hwTf+FnA5SM8rFldBtBs7YHW1BGb7
 7c/aDtrlkxx1cvIAObMXh77OqN0WVFtvpwO2VLbkBb+pmqMmBVHrzbWQO1WYTJP2Ht7L
 3zn7sbyaQU5CG74eBlRizRV0TOQZZiZdIa0BhQKDW4wLsz6UtQVQB/UoE6MeuRroPfIv
 Quu1ZN0hHYh3qxg5AvpKe2vGekTs83I6YaU7FDtcuJA4yNizfwflP+dFsawgqmjvXqYI
 +BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756156; x=1723360956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USsQtartNiA3EHoMTd6HIA/rN0PTAAkjk2EjuUti61U=;
 b=lFiTZrj7CcERc+eKdabuuazkhwIxc4jm4YJ6h/BqAT3HI8KbM8K60itXvAeYQa/DVq
 6myaKDAL7C57RJnVRlE/uqr4i6ddDRc2BsmSK8HZ/n2qhsqJ8YP6cKhwccyTS1Vhc35c
 z9dQEEHrjL2dPPlsYq0RVNyN7pFsRH7rGIM+Xcme5L0e/SdtQBsyhwVS45NT9QNmFwCS
 wb/0Q8unkSMwaSgXoe1kMPSCcfm2vo2HSQryiFw+O9z1KVMfeyvnhpEq/Ew/j6wsGeX4
 QRWmiV/b/uYmhtFUsGvoPzMSk73G/2QpS8xquHzksStMEozDgF6LNn3JQph0KNCzcnqA
 nTjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2El08yi72KvxADa42GJMo/TJybXfbnLNKKWhwG5FXW7RoWUheqCnVZBa1gxbP6E9cTyKbhOcoGhYBVd744tEQ4HeZmC4=
X-Gm-Message-State: AOJu0YzaUimnvDzg5ho+Mb2wqlhBm9YLqf9EiWJKYdrNT8xlO0rYACpm
 Mf2uFb4P13ny9UqGQe0AUfp45vOP7gyCGTZJmYmBSW+NcEGaOEVtRnJ1oofz58I=
X-Google-Smtp-Source: AGHT+IHjLwAraKVwO11Tu77V4GmK5RfrRMdmOauV0/l/tUc8ibSfx10ga4hsC5FGH8TgMjGRC2/gfg==
X-Received: by 2002:a17:902:d4c2:b0:1fb:6663:b647 with SMTP id
 d9443c01a7336-1ff5722debemr110738845ad.3.1722756156171; 
 Sun, 04 Aug 2024 00:22:36 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59280810sm44609325ad.226.2024.08.04.00.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:22:35 -0700 (PDT)
Message-ID: <49d1a8d7-f80b-487a-a6c7-5d409adc80dc@linaro.org>
Date: Sun, 4 Aug 2024 17:22:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] bsd-user: Make cpu_model and cpu_type file scope
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-4-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-4-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> linux-user already does this since 2278b93941d4. That same commit just
> added them with main() scope to bsd-user. We need the cpu_type, like
> linux-user does, to create new CPUs outside of main to support
> threading. Move both cpu_model and cpu_type to mirror linux-user/main.c.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

