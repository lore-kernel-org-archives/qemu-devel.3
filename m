Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E3C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkSm-0004eJ-RP; Wed, 24 Jan 2024 16:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkSl-0004eA-0J
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:07:11 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkSi-0001wA-Bj
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:07:10 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6dd80d3d419so1780096b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706130426; x=1706735226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4ElbIcff0CHPDqU1I8wUrQFcsPXxKnQT6oSTHK94D0=;
 b=CefUfLQO0laAZXTHPGWe4qGtdu/UjCXwc1HWCAP3bif1DcVukGB8Fyse4D6nOdg8Kr
 tp5ByzuFxYEB/TxpuPY75BTIjxPp6PbAi5Slv55zXCSqO69vdf626dwsVdPgoJ9FKQvk
 B82F2BJbK0MJFedLObvEDh0+DQqwMndb3aMjEpN+gutDzHOLLUcx2UptCc82M+JrelwG
 e87QoaPqR4Ur8Up4O/yRyS9t918CO1cndJjt5G6mYm2m9pgQgGLeTNH6aE8zjgn1h6G6
 At1ujkYkQAfHiCKAyYiyYvxV4zFNmTLoD0GGRskrL9thfoSoJKIa6H76NrBO0z21cuuW
 U1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130426; x=1706735226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4ElbIcff0CHPDqU1I8wUrQFcsPXxKnQT6oSTHK94D0=;
 b=QgCRUqDmqS3wJ5m5H2BwqkI6+HH93XAUXqp+nDwL2IaUXgPtaPSDQgR+JUKgbGLtUc
 ETgqXemXbcPvI/04s+/YNufXR2zSmL6aZ6neGgwpPHlJDyqhoa1gkJS/kZW7rhTZAQCc
 eM8VqWce7JSTaJl04QLyLUWn+6MWgt0j/KolQG4FmF6iDeQ5N3hpM66gzWqrzIxVi3tg
 j2M8FatpoMH+ibI72Ahs93CKvgkrptpx7lcDEGn6WF3xGvY4rIBU2MADlwM2CCrpX7Mk
 NKofczMyKDdN9BiiZxiWuE2aGsRscKoaIPcJXkrSSAGsldrtjf6nJBHrNMNkdMRpV6ig
 Ftfg==
X-Gm-Message-State: AOJu0YxfUJ1mPKIy2YxCsm5umZu6EqYi0JX0+mVacyoGCrpAwvx5u4HC
 h0RpomaZipwzmQqoVL2akLLYkroKBuh1qUVYOJHgSnISrKfDcAmEvw91bwV6ZE8=
X-Google-Smtp-Source: AGHT+IGqhMsXarAOnI3havs5nKD2Pe/+PS5TCgG2uSYqvolZ1u82RqYQbR1h3mlaGAGNwMVg1f5U0Q==
X-Received: by 2002:a05:6a20:1591:b0:196:6d16:6db4 with SMTP id
 h17-20020a056a20159100b001966d166db4mr56234pzj.53.1706130426294; 
 Wed, 24 Jan 2024 13:07:06 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a63d90d000000b005ce033f3b54sm12497610pgg.27.2024.01.24.13.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 13:07:05 -0800 (PST)
Message-ID: <4394fc8e-3646-4811-adeb-fc44e307e90f@linaro.org>
Date: Thu, 25 Jan 2024 07:06:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] target: Make qemu_target_page_mask() available for
 *-user
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240124075609.14756-1-philmd@linaro.org>
 <20240124075609.14756-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124075609.14756-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/24/24 17:56, Philippe Mathieu-Daudé wrote:
> From: Ilya Leoshkevich<iii@linux.ibm.com>
> 
> Currently qemu_target_page_mask() is usable only from the softmmu
> code. Make it possible to use it from the *-user code as well.
> 
> Make use of it in perf.c.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> Message-ID:<20231208003754.3688038-2-iii@linux.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/perf.c       |  3 ++-
>   system/physmem.c       |  5 -----
>   target/target-common.c | 10 ++++++++++
>   target/meson.build     |  2 ++
>   4 files changed, 14 insertions(+), 6 deletions(-)
>   create mode 100644 target/target-common.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

