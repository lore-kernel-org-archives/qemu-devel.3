Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFDBD277C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLx8-0007Ob-Sr; Fri, 09 Jan 2026 18:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLx5-0007Ni-5u
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:31:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLx0-0005VT-R8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:31:29 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so35553995ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768001483; x=1768606283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6hTDhR4oVItq0Oes4TQkRt/bfJ8n9RXixDrf7NFd2/8=;
 b=FZ6r8kD1eSCgCPlVBY2bmv3rQES+cWqfveG8RxllHuayI53/P2eLz5zP2V6oxls4Pg
 wTfxTB1DNrNYR/TQ53vYr90IXGUUIhfLIyZqyX6leYOq85BPvshjQqC0XF5A1I32quom
 xq7FHIkBkOeH7gzD+LJIMpPCxI4kAmGoYMaa65rTEjt1ohq+kjxLz/GtXjm2lzSs9K4d
 aKcz9nQie5QBN3jp5aBWwEEN0KAAMFM/3S2lGRHj1i/bvuzjPuhSV1iVbgZAH35tF3dK
 KLgOT7fUX40y9HCQ9bma1JI8+gaBjz85tMlmZH1xeF9tvKwCUphEfOb4vYcR44d7ktd0
 Be0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768001483; x=1768606283;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6hTDhR4oVItq0Oes4TQkRt/bfJ8n9RXixDrf7NFd2/8=;
 b=PkgF3pYRF9mlEd42vVSht7bW+FyQTBR5z/QmDwF1hVcjXx7GmMB6BmX9vczeEGYjEG
 COuXcdFDtOjEjzO7Inz5ZJMOxf1Msk6TWT4ZhzvAw32+GoOY5PHAKkf4+MzK//kqaNgi
 /1OyrL6lXiQm+QLpIOiAvVNMSQ6EjAOxEETXtIGWwPwuJBfBHrw6JcaUuJYnKKnPn4/F
 zAg/S/JzCqsjqGJ+FU0sfaIdoIB8KnNl12wgCHFeVF4aq/i5uSjJz/nAGAbNZQb2czef
 buIQw7Xg+boRde8Gfyn1jZPXSg2k2FKqZ4VUIU/kOWa9bGwC0pzKYCxjL/GAYA4njXtj
 lYAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl1wBXt+7xGvZHBfgR7m6vaTkHKN2l++jedtRHxnv298UU17crNYx6yZq8cOGdFrr42dDWj+88ojI/@nongnu.org
X-Gm-Message-State: AOJu0YzzKa7VHlowBBOCdrfjwFrz752jstFD80UR59V14RRh8Vt7GQcY
 7AZ/H5AounPNV9jcSkopatKovakqYIgmFSrZZIXFe2jPGiE130SVxPaHfV93ij+HqvA2kuxyOLX
 am7m8Bf0=
X-Gm-Gg: AY/fxX60oOI9sR1AEtSwY8tv9XghXnLc2FqcZR3wX1cwEG9d6uiqEyr+GNo0dHXDlfX
 47+nYHU74cEAUi2Fawkjc8A1GkL8ZwN7KG3TuPe37D+EldNbwfRsUm3g36O2+OJq2qQ1SxXO3rg
 oiJo5xwd+fOQSntPAWSYstSh/g9cmLncVo+3OD8thazM9NWiEb4F00oehRMh4l/Sje/hSxToaAV
 O/8Bfd5ObHFgjaP8vzb4G30cM1vsBF0IPCV8rJjCi3/eN6/E5cPa4kLfFJHGaHLML8orT9fcHRY
 yjLODkI43ZG9DEFicC7oKx5qtQhueR8c3nJLEc/Lr8WV9+tC50Br3xpZ0aSWZLIVcpdfXBeD8b/
 715XM49Lpvz5y0FWasRSc5NMl3hspQz6n87mEWnUW6yqDpd5cr4076rxrufBmaxXa1K49xTr420
 AVGVzXCjEQnqIU1bFX9S9EiZN/ag==
X-Google-Smtp-Source: AGHT+IEZgH09IaI1KlZqBk7KKBeJGtcfs/XH0YrI4uSJkVKusJzl/ADr9aeiYXIvKBnCrA1PYP6Ivg==
X-Received: by 2002:a17:903:1105:b0:2a0:cb8d:2ed6 with SMTP id
 d9443c01a7336-2a3ee4d9b4bmr78855565ad.51.1768001482687; 
 Fri, 09 Jan 2026 15:31:22 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc87f8sm113346245ad.77.2026.01.09.15.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:31:22 -0800 (PST)
Message-ID: <15e903f3-8fcc-4748-8541-18d3c16afe4c@linaro.org>
Date: Sat, 10 Jan 2026 10:31:17 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/17] Error reporting patches for 2026-01-07
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20260108070625.1586474-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/8/26 18:06, Markus Armbruster wrote:
> The following changes since commit 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0:
> 
>    Merge tag 'pull-aspeed-20260105' ofhttps://github.com/legoater/qemu into staging (2026-01-06 06:52:47 +1100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-error-2026-01-07-v2
> 
> for you to fetch changes up to 1f674a2b7aabb49d5a8308ef3949b2bb2fd70281:
> 
>    block/file-win32: Improve an error message (2026-01-08 07:50:32 +0100)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2026-01-07


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

