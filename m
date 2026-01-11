Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E774D2502A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veiwC-0000eE-Fh; Sat, 10 Jan 2026 19:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiwA-0000dq-Gl
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:04:06 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiw9-0005rU-2Z
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:04:06 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso2350253a12.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768089842; x=1768694642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wVjgMK2V5uep8Nup0v4P3JvcT8zC9Me8BjrSI9d0XaA=;
 b=B47pnvLXXZ/BhaCslOGwpYi1rCES4ysiz1vmrmHWj7xCVRhMXLvCKNe+LHFhAtHPWm
 XwuGUJakx6s5ZfEUeYj6iik1pI5boS5NgE7OlwdVFgyHfjLoboKuuEHmju7xo3pFCFCZ
 BgtdiMdiRNIa5ri+h5FbArovu263cLtbbw5K9kKJEfvxr6VGTrc6t1DBAHGLoi0ugZL8
 BQgi4AjVeOuoEYyagU5RYWFIbpBO22cMExpjyqRf20nDbPZCDJHePCs3tCeCzWINpnXB
 fwxZqM3fR44Z6SUK8umNWULC9iv+UclKWj2M7hABF9HsHY3DLB6o8ddsSQl+PLiaM+NX
 N6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768089842; x=1768694642;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wVjgMK2V5uep8Nup0v4P3JvcT8zC9Me8BjrSI9d0XaA=;
 b=xInT5iAxlvUSs7XbtvD5YWG5pF7lN3JwJyspqjEi85BeSAzaljnX9N3AQkkqy0HoUr
 VSDmKT7GS9hzeMe79ChvRzbFNKYyDfBUpYMyb3JdjCCDsOlboBta5Q4ML1HWK6rBMs9p
 PSEVZbfqhGernat6rq9GIs4rYVm97qUdAerx2JEU7Gn0RjCLG8cAXMAjlDrs/55dDAm2
 JwcaUPKmM+6bh+F+8wp5QIhbtybQI33D8clHXEFuS4QevuT1fAdvFcKm/oZbeE5slvdl
 5/QIhQlfE+RUOQustkKomWrhqKPkP8P9pbFodzFaBxjVstSyMqj7wjcTewc5H6dg9Uge
 zwfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmpOPtSzgjKhR/pnQHplYBugIHCopnI6KpZqnEAGpgHZvAe3hpGVNaXOI4TaPc15lkG52HXj+T3SFd@nongnu.org
X-Gm-Message-State: AOJu0YzBjOywSwCB+dF89tn4VVS5ariOyOoof7ZIl9LPmIvtMzF7ZJcF
 7CHurIJBsCLwNxATyuWxmFCe1OnaK22EkHmt1PkpR9uVmdUPace0QRyl8bZUkRZeYMI=
X-Gm-Gg: AY/fxX4XLlHde3h4ptukZ3bDvyuUbmu7TJ817QYWyJblxo0fieFPkL959d53QraaMHC
 YPmwT6TOaQ2WDLYH5t6hyFZAzPao16mUIp0bTMvvWuft7ndtt///he9IFAvvMPbCP2hENFePhBU
 pomFFttnkHvUOxFN5bBWyf/40u665Y+ryZEZmsfJTA0d71uRGUXeqYvURymE6YTwAEomG0IaYbW
 +fOCk84Q4jqaLGfsCQ+RPReHbaZ6QfkjwxW4+P4376Eg2amEb+xtlzaLnGzGBHrF32UKUcpIDtJ
 KTwlxaEwYivfkVApK032Fr7ETDusvvqhK43qbgoZ3UXa8VtxX0OAaKm82rgZxi6uANHWTO86fe4
 4PwVrzH3itXnRFwJXbyihzl9/UNXVuZOOueFdgMnmY4MsglA4Y5IH3jwYcPYJPh0wIYYAwjLvN/
 /p8t/3M4OmCLKkgahDJpaQCpVrgw==
X-Google-Smtp-Source: AGHT+IEZWeUQQdi42Aj/Il4gocKb+9DTFyk03r3VFXXw/GYKqi3zZ7NbY83832ucLhB3KSSo55qC6Q==
X-Received: by 2002:a17:90b:5846:b0:34c:6d33:7d34 with SMTP id
 98e67ed59e1d1-34f68c20417mr14146511a91.16.1768089842214; 
 Sat, 10 Jan 2026 16:04:02 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b09f5basm4278190a91.3.2026.01.10.16.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:04:01 -0800 (PST)
Message-ID: <97057c87-4e3f-4ac0-9cca-71d85e368eca@linaro.org>
Date: Sun, 11 Jan 2026 11:03:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] linux-user/syscall.c: consolidate statfs calls
 further
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260109214158.726916-1-mjt@tls.msk.ru>
 <20260109214158.726916-4-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109214158.726916-4-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 1/10/26 08:41, Michael Tokarev wrote:
> Since statfs & statfs64 implementations are exactly the same,
> differs only in "64" suffix, merge them into one using a common
> macro.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Most of the common code should be split to a host_to_target_statfs() and(?) 
host_to_target_statfs64().  Once that's done, there's not much use in a macro.


r~

