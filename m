Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A728D778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 23:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjQG0-0000M2-0c; Fri, 23 Jan 2026 18:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjQFy-0000Ky-FH
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 18:07:58 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjQFx-0006H5-1A
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 18:07:58 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso1011664a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769209675; x=1769814475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fgD4pFnTLJP9LksK7yiXxAb3KC+w1d9D6uPLNL1ILzc=;
 b=JrsOPQ2VBSccrOibhJ539B+J3hM6WOXPQK1Z6AjYoFa6Oi0fVm/1rJ6LCDFhAtWZph
 8baxUUk7cfoVAL6VW9VhsZesICekC5BPg5Rrwqe6rWqktPykWr8JXJSrwFFOWT9DDeFo
 uOzytWDtvZlFYCAq608lLSqwVLE/DWiwWPwm7yPci8Lyx/kDwtW9kE22JZnDHdUEG1+1
 8eSVbje2bVWtH329LIPx+M0NjpNIzTHm44BvCcEaCiaWszgHp3aO2gRWLGH8kNWARNHm
 Nh5ct/2Q5/6sGdMFATARGCkMsQeVzeTSnGVJTtSbKZn7hInSZrIYWk6PJpztEFfeboUU
 KfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769209675; x=1769814475;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgD4pFnTLJP9LksK7yiXxAb3KC+w1d9D6uPLNL1ILzc=;
 b=Y/FT5wtFXQpY8fd1r1RsD7tsVBNs4i1IA/imLiy6CqZmC+zNVQtXg2b3LQIL4s29Kl
 L+UcYfTynXOyjRaKGJFcpwMg/DqKeSS+ixzbyrJ2qNxH61hblQUpuohJJmyYcNi4bOQO
 qwfJqqdl0EafaPjrEeLTgz4FfAHnoQ9RXAIpcf4NA2lcbXolh0QNDmKQ/HIrl0XwAMNU
 HOmo6C3oySC57ms1gOC3jGOEvunLiDs8M7W9RYa1TOEtJ0iR8ZBAk/RkKFChgHHikJPg
 cOOO8ldloIzzY8ymmtDcvsbU2coJM0a2YPk8kkHYBoTglmpNza1o5UQJmoipksrajDCH
 QEzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6XliLRuJTLh5sNi6EZCq8sKhXnPLD1KD9ckPot8aF9C67aejVSKH9TYGr9uKEnIl9E0EB9526/0PM@nongnu.org
X-Gm-Message-State: AOJu0YwlW0Fj2s1eSrsWEGYBVPW9u4kxoeN2PUUejkzQHWxSCDGRbkcD
 c7q0r8ebCVvrJzUCEG1KsrC9XkAgA5XN34dlaXAgp1Wqs3db6Egj5FSYD8U9j0R7gxIhK0iJtYR
 r6IYLb1lGkA==
X-Gm-Gg: AZuq6aJL99WIqwSVY1TbR49HINWoMNrrB0yRvl9YNdqlpADCf0HhzjsFkQ9J3fubX7c
 SIEz00S8iXmNGDgGp9m3vPC/Hp4hcPbMP4lLLgdQ0qnoJsVQkVSfuFo9gv+BjGmTdmDPUj0lpBi
 ZFFlNTZFG6SRkEdi9lHz4lRIzUE19lLfiZC1cEUb6D9c3EJYBOP+FvC8CXgikKtbtHuqzYNmwHN
 80OnV4hJ7w1gFMoi54CQG6u+nu3tdqOLho+fmYHUR3vHOifgX4wyLsNFSxlSffurcZZiKNXmGWF
 ZN1RsMA4PhuO4IZ0hYtWn/07uXmOpm6YbWs4e4B42jaiK749C8EwJbw0RDmWwn5OCWpyhieIJ9J
 xQMHj1xgQlukfWFmBv7SMegYKM3xj52FuI+Fdx9mq147xD4JF1hUxA44TzC/g3U6UiD+VjHiRIA
 gEafTD8YG6C52SZcnQ+yIWsgSIjv7xkg==
X-Received: by 2002:a17:902:e5c5:b0:2a0:b461:c883 with SMTP id
 d9443c01a7336-2a7fe747425mr42698015ad.45.1769209675343; 
 Fri, 23 Jan 2026 15:07:55 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb02c6sm28865215ad.79.2026.01.23.15.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 15:07:54 -0800 (PST)
Message-ID: <14561600-0503-4124-acc4-fa19c4e81031@linaro.org>
Date: Sat, 24 Jan 2026 10:07:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] Net patches
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20260123122102.51422-1-jasowang@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260123122102.51422-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/23/26 23:20, Jason Wang wrote:
> The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:
> 
>    Merge tag 'hw-misc-20260120' ofhttps://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/jasowang/qemu.git tags/net-pull-request
> 
> for you to fetch changes up to 014c06435f96c82d0e0be67832d40be43133dc71:
> 
>    tests/qtest: Add test for filter-redirector rx event opened (2026-01-23 14:47:24 +0800)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

