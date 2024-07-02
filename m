Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4475BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOel7-0000gC-Lg; Tue, 02 Jul 2024 10:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOel4-0000Vg-PB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:45:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOekz-0007IT-Mx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:45:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f9e2affc8cso26254015ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719931520; x=1720536320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqJzgYV+5bwAuEHrW8O3OpZu8exkLV5WR6dOw81LlmA=;
 b=lrfol+crPdRGfBZf+XtZXhmPkdUkJ1IIXZ30ZYbogEy29eUWhgKKz3NUI68DfRqQNK
 RkBLoTxQ6yviZ0aDxLkIuJJ2isuJttczwzo/vb0aoOF7NMy527gvOXoc3PJvjKKY/eP9
 C60pWHw3wbBhsYUOMpO2QWzrmZF36aY7sdMPfYQVhRu2ht6ss1dqLQwWvWbx+CzIBnqm
 COrdF03O3/fy3Q3VpfwiW/qv1wGqRFrqbhe2zXGIAUO+fgqcfH8lFi+jvkye+4RVR8rS
 2+p+XtxA5NGYxX43z4CAEFCPOtKPyJwnjUaNMqHIBrBjU3ZQtMSUuFo3ZJKqUXTyIwOs
 udKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719931520; x=1720536320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqJzgYV+5bwAuEHrW8O3OpZu8exkLV5WR6dOw81LlmA=;
 b=VE1aoxvVHE36zcNeKqK/WSpFnrP0KjGUlzDjXteKOtq3KpmHhr5PD/Mk5mwb9Zdveo
 +cQqx4ZubYgcg7RUohsU2umwqhI0ymJJhtpWWUqoyTBTF/xVokrWeLLHOI2Vwc/Y/HFM
 G3taMGfN7o78cHKzgitxIuzvR0UyyNTktkaTGsRm6MYRfWgoCJF0CfHZLFFCkUtMg3wj
 Cb2xBjxVGW+GcISlWE7AaKCQv02WZtMXn6zc4iF2CE6c2kEDbfEvt6YnDB+wUfMbDZG3
 UZxWPIdFMED+NGmR2Dajy3B9xT/znqyKVjvGJIDGd1aFPwScYTGbiqBGDVxYR9zkmcvV
 GYKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW9uI0uK7fAfC3Za3zhkgUOPvcsGv+snS3gBfeZjeJ5xjLSft75AfTeFj1GwDnETQN7SlU69tKxWE0xoaWJXjR1+RmiC8=
X-Gm-Message-State: AOJu0YzYjQo2vnT+dsd5HHv+wZkYvv6UokBTPwlJg+JImovufKNr1O5G
 anTrFtX7PDh7Y0grezgtSS4hsd+9RkR8Tu2TwHygyqWKIgfwUNI38y2+6Qnuq2kROX/DI5dF+6y
 v
X-Google-Smtp-Source: AGHT+IHrXgB8PC0elEyt04WUgP+PeBEh9lC0Dq0/5DmS8dFofaWMvqXUopGudCA0FEFoTdjlr0pNjA==
X-Received: by 2002:a17:902:e54d:b0:1f8:5a64:b466 with SMTP id
 d9443c01a7336-1fadbc8eb4fmr52312115ad.21.1719931519689; 
 Tue, 02 Jul 2024 07:45:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10e2ea7sm85452175ad.81.2024.07.02.07.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:45:19 -0700 (PDT)
Message-ID: <785db67d-be21-48d4-9087-973ace828609@linaro.org>
Date: Tue, 2 Jul 2024 07:45:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org> <mvm4j9gp0xd.fsf@suse.de>
 <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
 <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
 <mvmmsn6lawv.fsf@suse.de>
 <CAFEAcA-dbLncCmY8zyZAz8e+AWeoGC437B=nV3wPznER+RmhbA@mail.gmail.com>
 <mvmr0cdjjlh.fsf@suse.de> <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org>
 <mvm7ce4jjvf.fsf@suse.de> <fbe9c88e-677a-4248-9901-76c56e52283b@linaro.org>
 <mvmtth7j1su.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmtth7j1su.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/2/24 07:39, Andreas Schwab wrote:
> On Jul 02 2024, Richard Henderson wrote:
> 
>> Is /proc mounted in your environment?
> 
> Sure, it's a fully running system on real hardware.
> 

I mean, you're not running it in some chroot sandbox without /proc.


r~

