Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA75C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 23:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1wTD-0007S3-5X; Tue, 30 Apr 2024 19:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1wTB-0007Rf-E1
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 19:01:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1wT7-00076v-9A
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 19:01:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f043f9e6d7so6391857b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714518059; x=1715122859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LNMjvbmMxz9F4bqWKdFpgvaWR2eMcNcNwxhNNItpZjc=;
 b=ZlA0KdzmE99Hh1sHRRtqPciJnu9P88pal+joi14KRolsTw0DHGJkAOJt4mO/GvpQ4R
 8PfhxtzCi4egN8x36TYI7lN9GJG5EBmOPWCTzYeUh7K8AZO4tPUG4M5yzHWbAqFK8W7C
 z0Bq98WLtlnvmCkEkuUCFQfGODLIRj7sfIk2xiqyjxjVGfambRMLVn3kvMtDGt0O0UJx
 DLTtg4rntlgcrT3suYYjx/hdwt1986tdBDfosK3fmGHHtAQhfmIQ4E+8fbWooyomxz4a
 jzuYXaA015LQfSZwTTFJT2PRSKa6S7squSgLuDeKTS0X9QamvaGRe0jaGcTJNuJqOLUn
 +FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714518059; x=1715122859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNMjvbmMxz9F4bqWKdFpgvaWR2eMcNcNwxhNNItpZjc=;
 b=GDyjvKwJqb+qo2DwCByhGnag/Kx/8hm+shlVk0Z6FC5Pyyjx1C1KUU7WQ9X+MtB4MX
 oWEmXFVI0a3g7eowyo5mhJ8MrgKypuvyw3NCp8CASJ2rS6tqtw8kwjgCTLY/ET9q73Jk
 +AMJl+f/1EFn1YSYHc3nkyZu/yej/Q/2EjyzWbt5hDsGXlrk342P+5Qi409uQlK5yoL9
 LyLjHdydnAeXE9ZdpBUpgMWPIncuqF1AhVf6kGDM+ok85vCFmfSy7tFE+Mea8niv3W5c
 li2BS0ItgaMCbRIIPVgmJUQ9tX2W95+fsAD0gBtT8Q9iJoDExgPPwSMcwW1k1mijfgCw
 esIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0xHbYa0BI6Rc8Uk8r2VjVL+nLu+QbI1A2wJY93o3qP0AT3muySM5AWjOzdKem9IutJMaMZAuaIGIpiN1lvm8DQIFLTJA=
X-Gm-Message-State: AOJu0YxPGLBxCN8CvLfGuRwfuRtdxbrN+S7En7aaAhL0UFT2GFxH8rLh
 N70Ergu3rPE9SQW80POnfSQBOZFG8Os1GIsDSZbo0UMONPcMJzcPeGdQxL8STmU=
X-Google-Smtp-Source: AGHT+IHxh+TgR4HrvcEic8XVEL6XJDD8kdQuJHxQE5kiHEPY1iUKk+3xkDd+ggwlQ6pdeBxgRe7OkQ==
X-Received: by 2002:a05:6a20:3d90:b0:1a7:7818:720e with SMTP id
 s16-20020a056a203d9000b001a77818720emr1546000pzi.21.1714518059308; 
 Tue, 30 Apr 2024 16:00:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b006edd9339917sm21600292pfa.58.2024.04.30.16.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 16:00:58 -0700 (PDT)
Message-ID: <cec58d31-b737-4af3-8552-d46c039e8f1f@linaro.org>
Date: Tue, 30 Apr 2024 16:00:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] Misc patches (s390x clean-ups, fixes for crashes,
 ...)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240430071340.413305-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/30/24 00:13, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 5fee33d97a7f2e95716417bd164f2f5264acd976:
> 
>    Merge tag 'samuel-thibault' ofhttps://people.debian.org/~sthibault/qemu  into staging (2024-04-29 14:34:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-04-30
> 
> for you to fetch changes up to cc6cb422e09592158586279fddeef107df05ecbb:
> 
>    .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs (2024-04-30 07:09:22 +0200)
> 
> ----------------------------------------------------------------
> * Clean-ups for "errp" handling in s390x cpu_model code
> * Fix a possible abort in the "edu" device
> * Add missing qga stubs for stand-alone qga builds and re-enable qga-ssh-test

Just an fyi, this test failed the first time around in the gcov job, but passed on the 
second attempt.  I'll keep an eye on it, but it may not be stable enough.


> * Fix memory corruption caused by the stm32l4x5 uart device
> * Update the s390x custom runner to Ubuntu 22.04
> * Fix READ NATIVE MAX ADDRESS IDE commands to avoid a possible crash
> * Shorten the runtime of Cirrus-CI jobs

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


