Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47772D2FEC0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 17:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkmXS-0000fA-9r; Tue, 27 Jan 2026 12:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkmXJ-0000Zl-CY
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:07:32 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkmXH-0004IA-Qu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:07:29 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-34f2a0c4574so4866559a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769533646; x=1770138446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=acW6Prt/pHI3olEXKApYcEBxu2yEW2Wg987sHosb4Dw=;
 b=h4EfZ3uI5hM0EkDygyGIWS7TH/vc5+rfcaNF0kwfRYS6X0f84v4gjoJQKqOm5D1WTp
 fyWB0VzF5qO4ssYMCi8L2D6XDn7ZDwPccvW2hO/k33geteva8F5HUN6+QwQSQhA7qRia
 bF82oyFIMos3aKXpF3ILpGcbOTcYrp9idlYo2nziZJ3oyHV/GyWG/38BtcXvjGuMwayY
 J33Vakmh0NkSGuVvLkL+QcPfR3vPHk8c32RSTpAhW25lvcCHWeaDPJCZ6YV2oUq98KMu
 83pYUw6dH6tY9ORDvd/AgvEgqr5w/Z0wvQ0g21bAE/rI6Hr7Cug36XumOc8zopHKCP7l
 gmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769533646; x=1770138446;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=acW6Prt/pHI3olEXKApYcEBxu2yEW2Wg987sHosb4Dw=;
 b=A5fkMHfClmFU4iZWy4sHDrIKtdSiHAJxogBJD+PDCogai3WanX929lTZKXeTqFtjaO
 G6Phy3ocogK+G0w28YsOdUa4gaMoJlg7Qj8Va/eoj2QN000eXbppnhH0aYpy7eRzYWRV
 la9USHl5p6WzHf9eemHWve9DorIXZAuCrKYqqFouKPYwHagTdh6PlwZJUanH8F35XT/7
 YkSjs9hVr1N9zJ78hUQXhMu7oQ2tUnre/Wmtn5hzFdk3cwmGh9Ww/Tqz8XpkzE6qzyyb
 BmjjWglICzzQzDt08iPN+DHV7yAgxvW8FCenLNIDdcPAVo1vXu9RYgwa+/Ynt+fq3rre
 iluA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWid5ZkvRgMemDIuaMCw4+UxKthYufREBEzR9aDcB8EGNFoqDSqauYAv6GeGPDoSH00HQtW2N1JgMTC@nongnu.org
X-Gm-Message-State: AOJu0Yx4IFeXRn5JBGnSby+5WQVZHc35nybNt/W+DFdHczeF2s8yQq4f
 ENwjyUnaT/o6oR23XPr7SWut4n8DlN5mcompoklbUVIFAviDnwd++EnmOXNdekEVS8E=
X-Gm-Gg: AZuq6aJvslZJSuMVC/DVdyJnTcu6go0fDf/Dle4tlo9/3dOvrD1DUdTsJ8aN5GNAn8m
 lm3JnfQD7LPgGk3Sl8upILBy6BuGyAYE1vPdukjrgKVCl5bB9l+NceoVZmLFyNdTPQBO8Fjy8PW
 N2wfL83uVrJvtoIQU0eGpDGOHfZQeqv77Y5zbDsLatM4IApIA2m/iSouoJ0wNu0CKydQskkCp0+
 j4ICgZ3gcEomENkCM/pXy0DXNQmc6Ey6Bq5co0N3LL7zzHnm36khpUXkx75C1+Rxnc7jkUqI8v3
 SJCTyUgJ0HHjyS7tj+G+xadR2HhjMhMbAMr91ukTr2CKkNSqQm3LEGGi7Xn7QDqsPHDPT2NXESr
 8C5H99kSe/4xvsYAYcRb2nRiaLDU8E8AO1/DNkgJE7uq1LiV9brNL7Dr50CVXo6/ktekoMZV8Fy
 nZrFxEUafL9z4RO52hUsIKPmEdraDBFUHBdVRjc1NfO1SJTWi5aote1vk2
X-Received: by 2002:a17:90b:2ccd:b0:353:30df:5279 with SMTP id
 98e67ed59e1d1-353fed08123mr2318985a91.14.1769533645804; 
 Tue, 27 Jan 2026 09:07:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfd71csm96400b3a.35.2026.01.27.09.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 09:07:25 -0800 (PST)
Message-ID: <934986a1-19fd-4e92-a151-726e2e3fb41c@linaro.org>
Date: Tue, 27 Jan 2026 09:07:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/docker: rename wasm cross container
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260127092745.2978371-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260127092745.2978371-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

On 1/27/26 1:27 AM, Alex Bennée wrote:
> Now we are 64 bit only there is no need to keep the generic name. This
> also fixes a check failure in the weekly container build which was
> checking containers based on the expansion of DOCKER_IMAGES which is
> based of the dockerfile names.
> 
> Fixes: 4203ea0247f (gitlab-ci: Add build tests for wasm64)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/container-cross.yml                                | 2 +-
>   .../{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker}      | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename tests/docker/dockerfiles/{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker} (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

