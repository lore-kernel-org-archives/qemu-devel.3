Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E483C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQq8r-0007Ji-Ep; Mon, 08 Jul 2024 11:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQq8n-0007Id-GL
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:18:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQq8k-0004uS-Qc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:18:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb4a807708so31088985ad.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720451933; x=1721056733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Brx/pjbBrf4gPD1zTABIkQDH+EWiC6ARJ/Yb2uETsOg=;
 b=exgrYkrZbMyBSppT0LDIm23dcQzZ83CS4NOmmXqzRJfOK6VRNpyAgdb/KaFLZB5CNx
 VChF/NtxkvDPlezExXjnIjP1Wsf4dUHoFWNid1UxdIZnwAF3787v7Z4Vdvi8mvTus7Gx
 y65fGqybWfoVrUZVSKv05ezebrDKVT5StslLh9nWxOTku3zOjnvcwADcqG9fgHAnb9Yw
 dbT2BTXYPmjCfPY0wcj3fmoR0U/Su9J7/LQVyYE29i/CEu97F1yBFwe7mUSjsuE1Oq0c
 pTvqCSGp/43rOH7tQOMxt6JEdfQNhOVVhC3r9xS+Foz31jEDdg3GnsyZitg0/6A/PEl8
 bRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720451933; x=1721056733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Brx/pjbBrf4gPD1zTABIkQDH+EWiC6ARJ/Yb2uETsOg=;
 b=MJr9xuQL3n4YpSEzO4obA50taFCP/Cu/dbu4hLeEG5azql6TkMsjHw9jVjjUVzbjDx
 E+IuTf+LMg5QmS+tajOmXl1NGE/LzCV5JlEvhMjrkJhB7jWbhu9LByVk+jbPA8fAhvXv
 asg9Tym5OcrDdbxYODlS6AsUHYM+cfoR1s9CQWbAt6qUsIuT4TuWUHTrq7VU9hK1+I5M
 VRtwYEzPZka03P76cQ+/Go2Dj0gWyqLtmJjVZPQg30vhQOozOn7vJF7B2aCtlHx+bgGY
 lKWECNcrmGxNJzVhe8BaWuM2aA1LM8Zu0NAAYf9Z4y25NUnfoY+is3k3IWw9FBdOr92T
 9zPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR4cMWL83ceoI5+GrSEIhRvIIsYxkoQVTB6R9pkCf6+BlzBywxdprfhspM/BQg6Nw8CfiwbHvc2C4o17QTvQyBwnQYCa4=
X-Gm-Message-State: AOJu0YwiqcW9BOawWc+c2MeFw4auEnpKD/6Q4h8/9HttR6CPZyWNwDPO
 DM5B5n/qIOAC45Yc3Oc0dyuD5pp0GrL2q+2H55b1Fu8VSv7OK6xx4omiwulHEX8=
X-Google-Smtp-Source: AGHT+IGNPhxqRgYk/FUjl+Wa9cX/CeR5kiEAny4MvL+UFa5Qv1+F9JPg/erzdLQ+c3Z9nkMKzo2dVw==
X-Received: by 2002:a17:902:e743:b0:1fb:7978:6b3 with SMTP id
 d9443c01a7336-1fb79780b8amr57369675ad.25.1720451932829; 
 Mon, 08 Jul 2024 08:18:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fafb173f05sm116859245ad.104.2024.07.08.08.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 08:18:52 -0700 (PDT)
Message-ID: <9c3e738b-12b4-4a2b-b39b-d8cf2f7d20e7@linaro.org>
Date: Mon, 8 Jul 2024 08:18:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] QAPI patches patches for 2024-07-06
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240706072416.1717485-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240706072416.1717485-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/6/24 00:24, Markus Armbruster wrote:
> The following changes since commit f2cb4026fccfe073f84a4b440e41d3ed0c3134f6:
> 
>    Merge tag 'pull-maintainer-july24-050724-1' ofhttps://gitlab.com/stsquad/qemu  into staging (2024-07-05 09:15:48 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-qapi-2024-07-06
> 
> for you to fetch changes up to e389929d19a543ea5b34d02553b355f9f1c03162:
> 
>    sphinx/qapidoc: Fix to generate doc for explicit, unboxed arguments (2024-07-06 08:58:24 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2024-07-06

Applied, thanks.

r~

