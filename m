Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E4FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 23:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTVIY-0005bA-6p; Mon, 15 Jul 2024 19:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTVIT-0005Zl-02
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:39:57 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTVIQ-0004T2-Fr
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:39:56 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c9a10728abso3202081a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721086792; x=1721691592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ynxO8Q0iYfJjfmUxAPk8u3dEiEiFcADjvdVCKwbNH0g=;
 b=XKDticaZ3ryElHEGZlvMKmEsqK3DiEGncn6TPLZIlOIF0UhNPqUlDeA9M8JvFafYu0
 +pCAzqWAzVR0AWVqQmkGWuqFqjq28Nr1LB0lT4m9xCiTWZMCs26+r6zFwjs8sUK+uHpa
 Nov0u/vrOYfeAVKIAPWWx7QFcabStor3Y8NQ9U/149N08+5jXJEki2xYfBatZ7J5fMKp
 HvK0kBIVNr5Dxiy7ddZheYTvYCR6KO3Ab5KbZYKZlKvMgsNF0RVOPrgztFdZ02EOaSu0
 eRPs+/2OVKhnn7klJLoG7xxrHf1ZgwMFYHLD1AojO8rju4I+a2bU/nJxd9wZKFgqs0+2
 FH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721086792; x=1721691592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ynxO8Q0iYfJjfmUxAPk8u3dEiEiFcADjvdVCKwbNH0g=;
 b=QDhIf+fzHGaWySg4HGExWUgrY9m6QfyYOWDNlO4tWWVVFUDGrmgDaKwwLSLUZka03E
 Mi+QJLy1i12VZpKGuxDlRirGDCDExK5IAAN2EAZ/N4w5PVZiakzLeHOCm8jb6ylKOdMw
 4F4al7kugzVVO3WyWZ7jKqutcb8E6PqSf24zQwRi4M8FnAqmHGePjDMJzATrzodFPv+b
 Vp7B8Tp14dyrrR6pW2YxXMXYR2U9AcDXCXz9Ohx/+KIoq011mQ6ZPs59osfcQe5qMrIg
 QINvFUuXxzLhsYtVYcqA9iKX3GywrE1b5BNtUL0dAQDEVEnn1QEqiA3e0GUv/zEBI3Z5
 hvPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5c5iH+GOJo10YRxeQganObknaW2V08MRcb9GZ6yobiwFJRKJlzPPXdvuSDtgPmgiviqahxoM7bIJwaEOorABbuaWODco=
X-Gm-Message-State: AOJu0Yxj2VD/M1xHj0HgxFbv0nMRr2hWi3QM+PzeKDhM34Aw3vNd8DAl
 MCMxOst5CFft8ecRjsnGcNY5Xn/qCljUp1497q1A6jFtLMx/DAK12LViGM5xOc4=
X-Google-Smtp-Source: AGHT+IEM+STmUFQIupfqRLJzlPQ4mKMHtClji3BnTA7pmTBchVJMPF16GJ+OF091J0lkpfid7wmifQ==
X-Received: by 2002:a17:90a:b788:b0:2c9:74cf:7dd6 with SMTP id
 98e67ed59e1d1-2cb36e25213mr388188a91.35.1721086792179; 
 Mon, 15 Jul 2024 16:39:52 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd3e4aa8sm7026514a91.22.2024.07.15.16.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 16:39:51 -0700 (PDT)
Message-ID: <fa1a326c-df98-45a2-95dd-c703f15bf13b@linaro.org>
Date: Tue, 16 Jul 2024 09:39:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Python patches
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20240715173241.572048-1-jsnow@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240715173241.572048-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 7/16/24 03:32, John Snow wrote:
> The following changes since commit 4469bee2c529832d762af4a2f89468c926f02fe4:
> 
>    Merge tag 'nvme-next-pull-request' ofhttps://gitlab.com/birkelund/qemu  into staging (2024-07-11 14:32:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jsnow/qemu.git  tags/python-pull-request
> 
> for you to fetch changes up to dd23f9ec519db9c424223cff8767715de5532718:
> 
>    docs: remove Sphinx 1.x compatibility code (2024-07-12 16:46:21 -0400)
> 
> ----------------------------------------------------------------
> Python: 3.13 compat & sphinx minver bump

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

