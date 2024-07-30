Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB18C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcMO-0000Dz-Ne; Mon, 29 Jul 2024 22:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcMM-00005E-Mp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:13:06 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcMK-0004qq-Rn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:13:06 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8111f946f04so178136539f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305583; x=1722910383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tjxU4Pd+MXWcR+5/JzQwgIWtGtDmaE39V6TRa+KX2Pg=;
 b=ZvUFAvU0I4zYpoQKyyUjZexsXsi0MbTY1O0wp3gcbRWpRqh1cffSyK1YawSDwNQ8Lx
 6Fr904cYBOBuMUVZu+pssJk374oVjuumF9ycuHgGe7pXko//4A9/Y/Bkrd99NJUOcSMh
 RSH1yAahWZMkxy33cCrozYhQKpZ3FDcI31OryTRU+YVnKXMDjTmWxr1YUVNZbSKqK0yP
 XyN00RxBF6lGZo6lt3mZ/Psg6Pqeh2vUzz4CToJe8vOPxFzY1zI7C9l1Sr1g6vOuKHft
 kwogHvlEJqctYcOztOPr435frHPk+Ky47iFX1NBhecCvxlSlQLLmTdkxQalE5r1QDujM
 20Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305583; x=1722910383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tjxU4Pd+MXWcR+5/JzQwgIWtGtDmaE39V6TRa+KX2Pg=;
 b=aq488eOB6ZVJimWE1BaHQqq8lECOeQDuGmyhVTbnl0sFekw/tugItzmC4GjynPErOb
 oQuSRJ6b3iSWn3i8f6qQc51SGEuDw2MNXOVMcqP+wWKu/NSY8/PAcZId2N/Rvx5gRgue
 DjDrmHJiOyMPOYusUDcaXLaY4FpOrWVpCk//KcX6hhOPuVtXcAVcTJ/T1ITA/PbJXVWH
 fYabvwk6T/y/neBUh8k+bfxm6ZfAVNO5PUqLyYo2awvKZDp+eCCwUicfpnjwlki+EMXm
 X7dmB538qnfzPDALl6JgikweB+G6/BFNxL9EuztIcX19RYnRdWN4aCaxrqkfWyw9d4kK
 1+SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmpS4h9+Nm8BB7YygIsM/bKpu5uf3WLcuUhqlg4QGzzwJtZ8qAuSBD3pQ1th+9PJl8Vxi3Db40A/z7ZoQS4q12gknhQBk=
X-Gm-Message-State: AOJu0YwhOPbpvnQ4xw678KOiWTgfEDXjPAUASXfAfrgmgpV0g9gUz75p
 IjUJof68QhKEnpRV+j65w6xq81HqvBfTjBGIX8TxlBGHkWuBgl63ZqELgWDGHVgE+IZxWto4jIu
 nv4Y=
X-Google-Smtp-Source: AGHT+IEeoICMu4UL8jj5vpvKUwRnacnphXa0cwGaygpZOKxgi5XrmPj3+lc+O9rYm0Lgz4EzQEDi6g==
X-Received: by 2002:a17:90b:4a50:b0:2c9:5a8b:ff7e with SMTP id
 98e67ed59e1d1-2cf7e216b0cmr11112138a91.25.1722298708561; 
 Mon, 29 Jul 2024 17:18:28 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb738fe0fsm11220403a91.10.2024.07.29.17.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 17:18:28 -0700 (PDT)
Message-ID: <100fdfe8-4c9d-48aa-9d92-95c818bc08db@linaro.org>
Date: Tue, 30 Jul 2024 10:18:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] QAPI patches patches for 2024-07-29
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240729063722.839708-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729063722.839708-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd32.google.com
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

On 7/29/24 16:37, Markus Armbruster wrote:
> The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:
> 
>    Merge tag 'pull-ppc-for-9.1-2-20240726-1' ofhttps://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-07-29
> 
> for you to fetch changes up to bc2e34e343b40b83cca82409db9c126df2e28c81:
> 
>    qapi/machine: Belatedly document target loongarch64 is since 7.1 (2024-07-29 07:29:47 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2024-07-29


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

