Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBF2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwML-0003aS-5L; Thu, 21 May 2026 01:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwMI-0003ZK-HY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:54:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwMG-0004JP-Hr
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:54:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso49877625e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779342850; x=1779947650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8TrD97MLyc4ijScD+ozH9Iq2BkQSTQgoRtagh/gONGo=;
 b=qGiG44GiN75+cNlRpIXc1eUkj1hEMXMOZAdzu1p4nVOrS/w2acivKqUjRUe5jQgguF
 LKCuvwdiXraJYp6+u3pEXlq2FkD/gfgvr368f9AtnJvhUvJJ7vh6FwgObaJdDmopgSk5
 byPYsP7xKeGKj9i+6ZZa1kN7Q7mey8D0qjis11kzNqLvN4XRnr43cVB2dsA16nJk/FQ5
 yBwvrCrbZV1hPcMtzkUKBqYs4vQbHGfZs5E5RCSF8t7srEcVq5IEUnDgMYVXaH8u65jO
 9fuDvMHMO5tP70oE0ssLZ291V4Wqq4GL/9GRT8pXVtqePJFMwY8QT8u2yIJWjIRPd2yS
 Tzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342850; x=1779947650;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8TrD97MLyc4ijScD+ozH9Iq2BkQSTQgoRtagh/gONGo=;
 b=V5+0jUmB0+6RASeJgdbSGI88a4cNZYqw74BbA1qVH/MjHPQxGzXBNYHV6jOUDv70Z+
 cG+jLK+Z1Qrs+UQyF3dLxpg78llZb2Xopyk6rHQr5fLqwdO05xWdA4RRG0vrz8eoWfnW
 i9WdvEjdwna1aQ2fgSlaZ2zWXJWQNb40o6DLo9dSDWKEo8q6TSC+iJZhO3J7sbnePGeV
 WGAryhvSPHCG0d5xCKZWJvg3PwRgumGSg3A5QwxMk7Fj0+mT2zqfnGovr1k15fE8abbH
 aD2Asp3swW7/pZHV1uPsj4aKoyXO6yI80ysY9BfM+foVPojNNa/bBV8kdVFxYyXg9+qQ
 UpKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gkKMCiclCwNLz98D6hEnFHAIHvnIUB6puCntKM5ZtTsN8bZHlA80Fm+9/G4j2meiXbyVVXZYrlzOA@nongnu.org
X-Gm-Message-State: AOJu0YxCTi9Ib4kRHf2vrWD4iv+jtRJVuS+mdptrNgmfkFSlSemdG/tm
 M1KYKNF05jVOoSXod9QcbI0I341sj6vgsbz2bfxUZ9YlY6KZSDsKPVv9cJmQynXGbtw=
X-Gm-Gg: Acq92OF4xaWWhkLj0H5L42g0A1JTFhvzFTJoq1nnP+8ZJqkmC9XeSvCDxv49PazBW8D
 Hnp/M5v/6+breN3L2itnr+n8omofNaB08KUPzW+AP7D3VN7dG3ISYtOldogCDlgb324wV4Y0M3/
 yYwtH5U0uQqX/HHWoP2n07guNTV8+jsSCYvHs7bwN2q+SDzBL46G9PT5J5GhsVsuqQFkS0VgORd
 iHlPvXectJUc/DsId6wkGjrSfMQGYhIaMWVjNiBJD6N+ENtNVBdaYDWrWPfEF1gqLNu/5r+7vzB
 p4oaJRdSn9KVNsxlWSFyA06Eb32m0GqLzkkooux8NcNoVvLr0LQaskC1L8GLC3fNZxGA6oHvwda
 zlC/1eRsm9/t05GgImRZ7CGO5bIXz6EPXdph7nygBzUzkQUIER1Hzxlv2r3Up8ilZIKLmAwTr2g
 rW06zmmjOk22ovuLMJoeWmH0M/i5sYBgJWs3z381bLI49KcqZlxE+J1ZEtecA9WLJMQw==
X-Received: by 2002:a05:600c:8592:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4903605d40emr13178335e9.14.1779342850535; 
 Wed, 20 May 2026 22:54:10 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm62151109f8f.29.2026.05.20.22.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 22:54:09 -0700 (PDT)
Message-ID: <31fecfcc-5629-49de-81a0-2f31ab50b2aa@linaro.org>
Date: Thu, 21 May 2026 07:54:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/40] tests/functional: use query-version QMP command
 instead of HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-10-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-10-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> Replace the human-monitor-command based version test with the native
> QMP query-version command, which returns structured version data.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/functional/generic/test_version.py | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

