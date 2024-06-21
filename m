Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21F8C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKVsj-0006iI-6C; Fri, 21 Jun 2024 00:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVsg-0006ex-8k
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:28:11 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVse-0000e0-F4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:28:09 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso1137664a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718944087; x=1719548887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qhwBxA8Cry2gh/iMTyBt4l8rW8l9lvyPSWyqlZMdwnk=;
 b=hTZE+4qcvOY4cX7teWHCoFh5mifZv7CNTmsxouj1t4tcZuScPKXaB9E910uDpY82gB
 1T6Cu1DnAjKQGFynrvixqC2rwjXPauLzoFFQ2EKeUYBjBoY+ZD/CJxrDy5vWerx5/1ny
 Be25THl8hocVg9CbWmPsaUo0q5ynx8HwobgFzaJBA9EV++6Oo6CqgISiBpsOJfWfAOjd
 wHkjV8k7sX+I8MwRQIahC/HEeAfwbyAYBUn8LFfaej84tU92fIMsPZ5AHyldLVOFjx3Z
 dszCetBF9x7Qsq+s215NSdl+1wgQ0IEvr+uoRe7zg9CW071Axxz2NhgbgUmCvZSwum8N
 0Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718944087; x=1719548887;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qhwBxA8Cry2gh/iMTyBt4l8rW8l9lvyPSWyqlZMdwnk=;
 b=pHvvzJyrd4QAdVe20sV4+Mio7e7yzLhW+lDZEToNImrLdN599dixDASjQipjphh8Lh
 zayX3mMEPMVyBVPqFyuvnyil0AGbemwRyV7vKq1vbF2+/miRiXIdLFyA7rlzEIbXLOM5
 3RUL/JbfGbbvQcO6qqObZEX+C5gGDIMHqyyeViuXXiZVKgfM7+1HbF+BZLMmdqdOp/56
 VKro6NMcLjLjgbdlrMSBEC5ThafBiF+cEwYpHg4aChtFSilCv58UUWPObStz5cumlId/
 TmutREt5edgm7DGJIQpl9+zeQMaN3JtVnaxn60UN8kR079equrWA+4VS4c4F4ag2X3I+
 NJbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV80sM/3Kd+foEKX+EjvrofhY/WPKVaR0mVJ7BXOCHbgcEiQaFw7hZkxq3X2RzG4sar5H3HZJyvrG4aDco77fPcM3IPgI=
X-Gm-Message-State: AOJu0YygfJP+WLhBbeEjT7iuiNC5ZD33CygoPZvDj+99tZ0vG8LE6joR
 g5PKmUoNpO629WgXdNl67HXe5/ZujthB4bpVIKLyiGDx2BkAKv0RBOYM6oPKiXQ=
X-Google-Smtp-Source: AGHT+IHlKiS4c269/ny8VJER6mTcA5oCnsuyQNmrCIpuJcEEmvfcGKXL6wEOBPVRBoLAOUkfUCS6Uw==
X-Received: by 2002:a05:6a20:1e59:b0:1bc:ac14:5a71 with SMTP id
 adf61e73a8af0-1bcbb3dd764mr6553308637.10.1718944086753; 
 Thu, 20 Jun 2024 21:28:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c819a7edecsm537569a91.24.2024.06.20.21.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 21:28:06 -0700 (PDT)
Message-ID: <5d2e2b2b-9272-4d26-9c22-29c39c90b5e4@linaro.org>
Date: Thu, 20 Jun 2024 21:28:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] gdbstub: Add support for target-specific stubs
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-4-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617062849.3531745-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/16/24 23:28, Gustavo Romero wrote:
> +static char *extended_qsupported_features;
> +void gdb_extend_qsupported_features(char *qsupported_features)
> +{
> +    extended_qsupported_features = qsupported_features;
> +}

Assert these functions aren't called twice.
That should be good enough until we need something more complicated.

Speaking of more complicated... do we have a plan for gdb when we get to the point where 
the board contains multiple cpu types?  Not yet, of course, but we're working on it...


r~

