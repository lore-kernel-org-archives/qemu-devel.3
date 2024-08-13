Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE57C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0ck-000730-G9; Tue, 13 Aug 2024 19:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0ci-00070i-Lh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:08:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0ch-0003fJ-2C
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:08:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so48399005ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590493; x=1724195293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rIr5Kek334jA+KHddVuUM7N8fUHn6telaG6/+TPh2bk=;
 b=SqOXOVAjFoKFLNcaJDqteCgkzDD6Y93JHVjP5p/FFasn/UnNPHFswA9HLVjGNK+RJE
 vXgm2L2uaT0yA1tTVg0iYzqiI4pQnaurGm1BMsSuAaY8skJbCoi0XSnZfDy3cU+yj5Ip
 zqcu/V3RO4rF+UmEAEFHl+Cx2WNkBoHvancascBKsF06Y/XmIL4YTGOVv+QVutPnLA1N
 ockb6Q7/5upJX5QQ8QqYEWBwDPcHvuVM8xkeNGQ65a23fVWmVulPGCOS9/61Bik1q8ZN
 LNecUL+4KP6GgJPIsA/uZWBFbctZf5aD6qnBsy+smMEvcooTKpywf/T712gOgvbs5nTL
 mpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590493; x=1724195293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rIr5Kek334jA+KHddVuUM7N8fUHn6telaG6/+TPh2bk=;
 b=cv66/8v1C1Wn8O0r6i0ecUFnTiA+26L2VUVfXAs6EB6l679p9I+erRCHiRLhJMj6fa
 GZLogSAaq/6F8ztzx9HAYoMk+I7yYkTEGou6hhKwpFdIDjYeM9SPSjVuf0Df+p3X+EU6
 nHy+4Rob9P7q50d/T31pPYNKTS6W0BFmZ5Jt2XbpL09n7U+afF1uVNeKK80W4QrpMVkW
 Xjj04uai1hIUNpqKsfz3AhjXNzvoJbuW8QYTiGt4+IgCRy1QyAeMKczxKpe2jeTkbb0s
 KSF+KPnGNFk2P5T166cpGcnuZYFwEH9xFTV8ZhrNK2sTGcvLYfNpeclR0BXn4dwsXlW/
 3RLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrtF3R+gpzNQQw8sBQpE84Ch4X/Gp09r8RxwFDlxeXSes8Omafwa/BJev21JZotGUgphqtNuRIxnq6AXDsrDWqmLIlIc4=
X-Gm-Message-State: AOJu0Yy8v+gU56VO51w4Ze62Lu6GcIa/oczEIXHrOYzRK3WQliVgQrOg
 WOENVlIdpEcTTgVr1PnhYOvnSrWDUccPPIsRs2QctxHQ2ELztjCqm1UUyW9r0nA=
X-Google-Smtp-Source: AGHT+IHOZeRMd+i16l82ff0V9STR5RZtIllAnJFDmQvNAMkGsGF3goDqpBLGEUOm0qvoFrPmgLah7Q==
X-Received: by 2002:a17:90a:d510:b0:2c5:1a3:6170 with SMTP id
 98e67ed59e1d1-2d3aab8eb76mr1143502a91.38.1723590492587; 
 Tue, 13 Aug 2024 16:08:12 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7e80e5sm132743a91.17.2024.08.13.16.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:08:12 -0700 (PDT)
Message-ID: <cff007bc-12e5-40d7-a148-b3bca0569717@linaro.org>
Date: Wed, 14 Aug 2024 09:08:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 04/10] target/alpha, hppa: Remove unused
 parent_reset fields
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/14/24 02:52, Peter Maydell wrote:
> The Alpha and HPPA CPU class structs include a 'parent_reset'
> field which is never used; delete them.
> 
> (These targets don't seem to implement reset at all; if they did they
> should do it using the three-phase reset mechanism, which uses a
> 'ResettablePhases parent_phases' field instead of the old
> 'DeviceReset parent_reset' field.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/alpha/cpu.h | 2 --
>   target/hppa/cpu.h  | 2 --
>   2 files changed, 4 deletions(-)

Yea, it was sorta, kinda on the to-do list, but I never got around to it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

