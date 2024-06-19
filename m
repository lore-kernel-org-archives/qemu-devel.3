Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409A0C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1hY-000264-E7; Wed, 19 Jun 2024 16:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK1hX-00024z-4e
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:14:39 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK1hU-0001Y1-M2
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:14:38 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5bb041514c1so95282eaf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718828074; x=1719432874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nGRKSNTR6ypHI+IdIH8HliM0Rs+3Cj0CsqIcW9FxCyY=;
 b=Z+/7avOfmstGc1RdvfXVQKT5vikgBiFNWqEWZJgB4F/B2IPWGYuk22cZq9qKgJv/To
 Utl6xt1FKKdDuXIJ6jecbXDoi8L7TamWWTPDjgeuoSw2/j8T1KCufWLrOnqsXB4gOJvj
 7fcgkrajJR34BGhHA+me69/r5l/8hBMgduqw59+4qipmvi7LlKp8Qe672V9FoSTwrhyb
 Uzk00i2cVLyBKA2zxOS/OE8ptNaJp9Cqkt8NLQ1QMjiro+1jWbazyJDnhWXN6IoG7ofD
 gts5SQxprE4j3MNYy5U0+QNaa1CYjMwcFSQsscBHZavdWAdvGmiAQm5/u1K1KPG+b4pD
 SO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718828074; x=1719432874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGRKSNTR6ypHI+IdIH8HliM0Rs+3Cj0CsqIcW9FxCyY=;
 b=N33wTZEzgaiArL1QHMgfOHENonj/+0KeXSVbBDXtZKMSbwJIKLEulKoe0qEtOHwTML
 ZfH2Z6iEBI846hL8sPGY4EPz8z51XCzqel1lNkwFJQvB/rp7wrvS470r+tqtJwLUbyQG
 y1UuodBQ+L4sY312sA6frX8pSjiFYHZiyyzpkKQRxpQAuXNfo+sovLoJUFZHxvDnaUKI
 Xovm1cVHi/5MK1FiT0xxzz2OvNTAUaPjqKdP9rynYCqm4HplqoLwdJ7U5U9ZTAfkZGiq
 l+x4wn9pR42CqB4+okaOAQykTZ2nVI+jxvz6pRD0lQ1Q5fwQ6b3ey17eTs0v8vTAnfHn
 VxKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5wqzVeX/t1EWsvI5PW53NtzuwyB8GCu4x3LWnxzvfuzd3apKiK2HAqPagxi3TQb6+HWAQKY2oEhvSZV19I1PiGRy26MU=
X-Gm-Message-State: AOJu0YwjuXDpHGReD6C+KrhrW2re2OXkmNQcm0e4U7rgQ5aToaDiKCW9
 ZXGyHEZ/7eF9z9u2oj+Y1MVIdATlN8YTDQTVTZtpRdbY/HlrTWz67BivspPgtlM=
X-Google-Smtp-Source: AGHT+IHjC0w/IioSwz+a6odYKxz3rm2WMC7n6sQXE5Ddtftve/hGUma/Dsk67QOI01j87L6u+mvg7Q==
X-Received: by 2002:a05:6358:7521:b0:1a1:d084:87a7 with SMTP id
 e5c5f4694b2df-1a1fd36ee38mr457738855d.6.1718828074369; 
 Wed, 19 Jun 2024 13:14:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7116bb574d0sm1486989a12.62.2024.06.19.13.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 13:14:33 -0700 (PDT)
Message-ID: <0bc57050-0219-4f72-a616-589d1fd85921@linaro.org>
Date: Wed, 19 Jun 2024 13:14:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/74] Misc patches for 2024-06-19
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240619105419.49303-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240619105419.49303-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

On 6/19/24 03:54, Philippe Mathieu-Daudé wrote:
> The following changes since commit 223696363bb117241ad9c2facbff0c474afa4104:
> 
>    Merge tag 'edgar/xilinx-queue-2024-06-17.for-upstream' ofhttps://gitlab.com/edgar.iglesias/qemu  into staging (2024-06-18 13:08:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/misc-20240619
> 
> for you to fetch changes up to fc0870c180872d0f40e63507cc6bf8565ffd8d98:
> 
>    exec: Make the MemOp enum cast explicit (2024-06-19 12:52:21 +0200)
> 
> Spurious warning (3 times):
> 
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> Deliberately ignored in ui/ (also 3 times):
> 
>    WARNING: line over 80 characters
> 
> ----------------------------------------------------------------
> Misc patches queue
> 
> . Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
> . Always use little endian audio format in virtio-snd (Phil)
> . Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
> . Introduce x-query-interrupt-controllers QMP command (Phil)
> . Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use (Cédric)
> . Constify few uses of IOMMUTLBEvent (Phil)
> . Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
> . Fix inclusion of tracing headers on s390x/TCG (Phil)
> . Add few shortcuts missing to readline (Manos)
> . Update ui/display entries in MAINTAINERS (Gerd)
> . Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
> . Fix Standard VGA screen blanking and cleanups (Gerd)
> . Fix USB/MTP reported "free space" value (Fabio)
> . Cast size_memop() returned value (Roman)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


