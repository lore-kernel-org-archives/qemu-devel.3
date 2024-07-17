Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDB8C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0ot-0005OJ-Vg; Wed, 17 Jul 2024 05:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sU0oq-0005Ep-3A
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:19:28 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sU0ok-00045b-7U
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:19:27 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-25e55d0f551so640937fac.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721207960; x=1721812760;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+HqLbQR8AE0OIOoWSJ/tTDT9kFeGA7wJTFydkB35CqA=;
 b=O/rf+ZCx856u3EhKA5UJgwxIE5WMPih8P5oaU8HAOg4RZGiiSrUKGNRCZ6lSnAgmeX
 n6yZaeUYi6dJfEuXPgL7Pg9Ck45etYKoNC3aQeuWgOe2bfxmQq1S0WCcqNWzFZzAfdDq
 v+3QAYDOIw13suvkvYFLANpjr8g66W5JQwjV4oIXM70pgGvYZXtHGrPOgfrKnWA+i20T
 qttl9NMI61QzYqplzVGLFy/w/mUG1gT+sgDOwzJckcpslApcJiT/vert13IauZAxtTvL
 qyUpoB6shflr7EXm1E3BKMt1G5iHeQ1Oja6P7C7sjEizeAad04N63Xh+Xonjyzz7VjH5
 imgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721207960; x=1721812760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+HqLbQR8AE0OIOoWSJ/tTDT9kFeGA7wJTFydkB35CqA=;
 b=RmwR7QSR3H9XmXu7YiBaKusP0be2DKHaXdIwL2J5SXdwLganBXCEibSqizIsxXD0Xc
 BtJc/rI46BGcKHUAN9RWTfqyloXxRu4L5VYxxUsWS9GE5eb3/T7N16cFz8bRi5mLVeK1
 lfNa+/Cl3se5FignoV3brAgAy77jew1iGGGQG8WUJyAtrxEhs4KPPEdzLc5X7eKszAC4
 LNTTvJXN7Ub0bRhvIalYE8kMhcS729tdZjj/XTjV8cYZmDiQP5vXicN0h8pGqY39grAx
 JPfkZjthf/a7lOKX+Pq4MYO+GPdjCTEmzi/eLMKD9LPpyjWK2gWc0fzVbMVwD2vIxO04
 RJAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Xxx7+2bSq7LrWYmjZ4hTaoXXsIXpGoD+dDSzjb7mxM8l0pZkPwaDwIZS90J+m/C+1jfPxSxX/1kAoPbS9NsAmw4NcaI=
X-Gm-Message-State: AOJu0Yw9q2QAyiv2vzbSjPzMyjM7fQ0EZ14MGua5tp+PSQp+z6TJA/am
 +lMJkosdIMUukK7RJ3L1BasMu4atPeYNgRbppbBZnLUUkyOlIoPBNqnuVTPZsfs=
X-Google-Smtp-Source: AGHT+IFv0rxe1xAtFkvB5M8Dmy4QqxNnMjJ4jRmhhVyBa+wl0k9z5UW65B+U6uLBA62xri7yyengMA==
X-Received: by 2002:a05:687c:2bdf:b0:254:d417:34ff with SMTP id
 586e51a60fabf-260d9175702mr723421fac.4.1721207960009; 
 Wed, 17 Jul 2024 02:19:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ec7c5f3sm7698682b3a.107.2024.07.17.02.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 02:19:19 -0700 (PDT)
Message-ID: <e51f8691-47cf-4a13-8704-1bdc1041d71a@rivosinc.com>
Date: Wed, 17 Jul 2024 11:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] osdep: add a qemu_close_all_open_fd() helper
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20240716144006.6571-1-cleger@rivosinc.com>
 <9eab74ef-5aa4-4bc7-9af8-061eae7625c3@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <9eab74ef-5aa4-4bc7-9af8-061eae7625c3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=cleger@rivosinc.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 16/07/2024 17:52, Richard Henderson wrote:
> On 7/17/24 00:39, Clément Léger wrote:
>> +                    /* Restrict the range as we found fds matching
>> start/end */
>> +                    if (i == skip_start)
>> +                        skip_start++;
>> +                    else if (i == skip_end)
>> +                        skip_end--;
> 
> Need braces.

Sorry for that, I'll run checkpatch before sending v4.

Thanks,

Clément

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> 
> r~

