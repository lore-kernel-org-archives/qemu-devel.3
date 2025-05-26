Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A81C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTpU-0004xi-U2; Mon, 26 May 2025 05:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJTpS-0004wo-4C
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:09:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJTpQ-0000yg-Gr
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:09:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4c6c0a9c7so1276745f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748250543; x=1748855343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BVVHJrnqgKDdsEMIY6MZgO6VQ21TTmH16Pf06Tilm6A=;
 b=lD8goxBMmCviXLFZCUKFNHieFc66oFwABnNdyK+dGdl4IT0WQNlltreBtvQxfYXXfP
 //hu9dxmtLATOMBh6DDD013xLAV9XU23rSFOCIZnhEzY5hLNGODuWZCIv8HadKDy1/cg
 K/nodbhifdbEBWQZ7mjpG/yRHNA6m548tQotFSER65mW81N7cuWdqQPgkdpghGDOyCDd
 eT8Il+0MDpU7cixKQjFc6FBHXtb0Vda9RQd/bb05mORlP8zpS/FO8qNroYPcz4BQcXpm
 W03atYFS9bf3r6mxZq7J8MBhMBDnIDCE3/6rGcrBHLmnXLaKvDwjnTejRntFesyg2zIa
 Xqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250543; x=1748855343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BVVHJrnqgKDdsEMIY6MZgO6VQ21TTmH16Pf06Tilm6A=;
 b=BDhhXLGKaBa+LWXVIOKTXH1m+5sbJb108+sh4WY+cNipVXo0jfp0R6jGg8eXxLciaU
 c2FzpgKksYvoy1QzQpcNh5scoBwcr+fRw8UkS1qB3gtT77qBS17F3dNXCC1aDTu3CRbO
 lcxyR6WaU8O0eCUNA9nKbgaxP4y+Nk3XtM0fWHb8dQUoo3lf2JXQZionGtd3Aebau+Ha
 2qx30wVLQHUqhpSUXQACfiK7IY7MUCBLpvpCkSGwvZ9ug22pfQMJOscPdFJvi6ZRVRpR
 Yh4qygqcJX2IknVC0he8T3CAPO1/vjuoXwg0T9Fvnen9Zkt4IR6FC2ky+wyMD5Mzu4pT
 QtUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtykFW5UNWN2wLcOobAuEEdmpl6qq4PSdDBICWFgvBhtucQtDWLMQ2uttF406HUVgooxW7uj1cFTj/@nongnu.org
X-Gm-Message-State: AOJu0YwacsRWJ63MfjuVMMm+5Tj2kkB90rPEFQEoym62sJIFU6+mhQya
 YjjQfvX2WN+iZBFoZFUB3cFa4HLGlwmUTqHqrouaDMYH/Q0JaGRXEunNcRGM5HQO6sc=
X-Gm-Gg: ASbGncsL5m56rwmMAyWmpA04iXRn+7aRMsNa8X2UAFaBq+VrZH5Jmcke6HoOaJrmKer
 aGg/Y/SGE+s6g5+O6uPhPo9vjU2Uxleh3zhJ/TNFyBJtJZs9LK8sX0ewRGrYBPMVHEiR2VAONjL
 IgJEQ+xs3LQKZbiLwB77YlfLZkpGVhzIsKu6SIB2Ijww9l+6M6JhbiJhemFtz544Z5wNFSWV31O
 0bzUaIu5FXECb3z/Mm1cr+PjPzir50hTBNGNeaemMqdfWX5/cEsYwrQiALbB8LuTpPC5+QC16b5
 qCNWmtpF8OhI84NrMU+ruGm4/aCWFeaktT9KBQba4TGCxI+sNB0OMCKlxLzXM0aNbUsJ1Ff4kYo
 uCYd1+iAoXsjuZGPDggTiTX3q
X-Google-Smtp-Source: AGHT+IFLXwwQWH2HHNGbDgecQQJq7m2j11Z5PElxFLD3znU/iO8pIQ3BTqlD0L6E/jzGMEVA2OAX7Q==
X-Received: by 2002:a5d:5f8b:0:b0:3a0:aed9:e34 with SMTP id
 ffacd0b85a97d-3a4cb4c62b0mr5805406f8f.48.1748250542949; 
 Mon, 26 May 2025 02:09:02 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3814262sm229641385e9.25.2025.05.26.02.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:09:02 -0700 (PDT)
Message-ID: <b28805fd-f57e-4f3f-8444-f202ebe8bef9@linaro.org>
Date: Mon, 26 May 2025 11:09:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] qemu-thread: Replace __linux__ with CONFIG_LINUX
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <20250526-event-v4-4-5b784cc8e1de@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526-event-v4-4-5b784cc8e1de@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 26/5/25 07:29, Akihiko Odaki wrote:
> scripts/checkpatch.pl warns for __linux__ saying "architecture specific
> defines should be avoided".
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/qemu/thread-posix.h | 2 +-
>   util/qemu-thread-posix.c    | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


