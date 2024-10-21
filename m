Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07BED3C93F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lJH-0005tK-UA; Mon, 21 Oct 2024 01:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2lJG-0005ss-4J
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:50:30 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2lJE-0004cl-Bq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:50:29 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so2946851a91.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729489826; x=1730094626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E27TLEuvJa1GsQMdl/LQEcKCAAmRW/AA8or6En70NmA=;
 b=AHSzFk+N0k9Dq+PeDaWk2IID2mjsWZyCDU6oLCph4RvI/e+AqlPxd2lgcCXMMni81C
 wOhZeZWKk+GJswVmitlCMCiKk3nnqbRRz9e9HDgggkkbY1/EXCxuDmaN2IZfYPDqP++/
 Jtoh/HqW89MN4pIYApIhXvyDEkWOfkSJUXMrkvWo5I2yDbcyQ24d96x+wfUbNT8Ru1jR
 9bi+EQg7Aq6t1/sp1KtzeGEB+uBGOJ7BmL7ijtDTiPJJ15SxMdjRbClBGD9ZfKp2PUZh
 UH+x84juDrKT88NAwpinLytu9/0ODS3poO2ty1OguJlmho/OZZRFAG4yhcxTJaGFL+dt
 mRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729489826; x=1730094626;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E27TLEuvJa1GsQMdl/LQEcKCAAmRW/AA8or6En70NmA=;
 b=vMjynJdlrs5S30DX80fNk3oPUTQBmgDp2u90AQvQISUon0x1bUv2lKQJc1SzqDpXes
 BiigDfo/Ax+VxCl3q7LuPtDVtsUBZ0U4rHLsj86s4WT8soIyrO12M9oshRaOqPUgG33a
 8ncJMVMR78WSrKJJvFRCOUowCHeMjCQLevqvJ2EoQ87amW+muqYrGTYDvQ6YXonrlsTZ
 m0jq+bix1gtMGG2qEVedsc/aPeTOzoLoSuZy/KODY54Jxc+FsxOZDOR7w0XS+yQ93fX/
 S6v1pomMKcCDRunwzveMiUoLTPWFJbABKMJj+dmB+36RuTCHCMOZN3gI8NRukoADQoPK
 941A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD4u9q0D5GdYaPIyGqFxDZnpR/ost9IFpURgbDHrb71avif5kHmSqh5/NDIng4IO+5jfLuv6HDoi4J@nongnu.org
X-Gm-Message-State: AOJu0YzdKkGv2RwGTVLg4seppJC1TTnu0Y9fCuGcwJaLFlq0ETcl78nD
 woL9epKPO/fkQdZ92oySpJDeHWQLxAWhw0EFPf3HylEO0IktUBBrDXlRa2DgVFY=
X-Google-Smtp-Source: AGHT+IFqtHXUK41pYUr3w2sYu/29PjA9Ls0LPhwk4+88a5pzfViL6AwaQYltZzJb3J+YqrWlCfJcIg==
X-Received: by 2002:a17:90a:ad8a:b0:2e2:b513:d534 with SMTP id
 98e67ed59e1d1-2e561a017b9mr12725349a91.37.1729489826578; 
 Sun, 20 Oct 2024 22:50:26 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad366d33sm2614074a91.16.2024.10.20.22.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 22:50:26 -0700 (PDT)
Message-ID: <70387fb8-5202-4128-a6ca-9cd9803184db@linaro.org>
Date: Mon, 21 Oct 2024 02:50:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] qapi: change 'unsigned special_features' to
 'uint64_t features'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241018101724.1221152-1-berrange@redhat.com>
 <20241018101724.1221152-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241018101724.1221152-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1034.google.com
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

On 18/10/24 07:17, Daniel P. Berrangé wrote:
> The "special_features" field / parameter holds the subset of schema
> features that are for internal code use. Specifically 'DEPRECATED'
> and 'UNSTABLE'.
> 
> This special casing of internal features is going to be removed, so
> prepare for that by renaming to 'features'. Using a fixed size type
> is also best practice for bit fields.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qapi/compat-policy.h  |  2 +-
>   include/qapi/qmp/dispatch.h   |  4 ++--
>   include/qapi/util.h           |  2 +-
>   include/qapi/visitor-impl.h   |  4 ++--
>   include/qapi/visitor.h        | 12 ++++++------
>   qapi/qapi-forward-visitor.c   |  8 ++++----
>   qapi/qapi-util.c              |  6 +++---
>   qapi/qapi-visit-core.c        | 12 ++++++------
>   qapi/qmp-dispatch.c           |  2 +-
>   qapi/qmp-registry.c           |  4 ++--
>   qapi/qobject-input-visitor.c  |  4 ++--
>   qapi/qobject-output-visitor.c |  6 +++---
>   scripts/qapi/types.py         |  2 +-
>   13 files changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


