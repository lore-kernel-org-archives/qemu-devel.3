Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A93D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUjw-0004PN-HJ; Mon, 26 Jan 2026 17:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkUjv-0004PE-78
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:07:19 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkUjt-0001Ap-Ln
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:07:18 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8231061d234so4143018b3a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769465236; x=1770070036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pFo+i25q7R3B0WoddClgftqZK9z1sL2JVdaGFAyRndE=;
 b=nqeI3Fve7EmFlf9LTJ1HFBR2ZrRGv0xZoHPUctFOLt+dRkQ/Okt+LJEN9PbaT9Sw38
 iv09/yRk0JMV080fOYnYyWeyKTQ+aruvor2xbiwKx2UHFwwa1xGt1uu4F3bIgUApdsW2
 MTjzuA4uWSvQqwxsp6GVg09GOdna5oj6af2fj9i0c9fO5gE2DoX/ZQTwbCpdjDsE3F0Y
 cjyASElmv6azqdsF3XkhLVwGAdDH2vdw3ikKSwvZO2msC8h1DnrenXZrln2eEQoHTa6h
 zDC7jPgkD7zYB7XY6i539hCMaE5YWvRl1iVNL0SBogqE8h1gqwiagl/K/9gXrNFVxgLP
 z7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769465236; x=1770070036;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFo+i25q7R3B0WoddClgftqZK9z1sL2JVdaGFAyRndE=;
 b=CZ1ey7Lq6q1MkG2H/4HXDRaFZjnMBMC7pLThJGIpAOkqzT41zX/sOoLtrrFt483rnS
 GhGqTYvkllrPuSzoMGcjX3SDb4IEM/q0mM2X4frlQaubSMY1xDTDSffTCSqSyVweRawK
 fC0+cOmFrK0c4n7zVpwaYnLNLO45YYDXB8RHJcT8Nn2TRVRSj5sJTEMolmkmx/BefdsP
 KGRKzbobuStDpPc3hadjKuewiCbt8vm30kwtrWoqOD3kSeh/jZ2VpPiw9V8ZyJMUHzxe
 hWPllXUxIKW436CvE8V+tJyxfbMJT+Jb13feVcKZoGmrBh5ar2yNFj9MQ2YEcmJxL9Zl
 KZng==
X-Gm-Message-State: AOJu0YzIWiACPmvykTIEwpqCxU67cr2lx4YdNWed+9OjridKAcwHcrXz
 vP5F+Hvkeh3a0X8hZ/dmlJnD6ymM/W3faLJz4QQMirLxtWWNH4Uo4jy0l0OiOn+kr9sxbSiXOHL
 2s3uG
X-Gm-Gg: AZuq6aJwXGKJkC0b4SZ/RhN00Fda49UtfTBB+pIQkfNXMNLh9e8hWJetdbPJfaWkqvQ
 XYmWmgc11Fl2ajaOfdrAQJ616F0CsJj26yLRsqeKYoi0eTRdkuz0wLj2AN+GZ+w+SrN2SigBJ9l
 aVfDm6pISXq7Wf5Xvs3vt9SuSf6ZypFnJ6H5QI93lFK+nCMO/N3/pKtY0zcBLVZKAooJ8YeSi+O
 V6iWUCFTo0GLDadV4t8SEUTrhWoVWZ9LRXJlmKOHIynM3suVeyl+IG5IE0N8TDdw1g/L2zzQO/e
 3fh/j0rahBQfieQojXlpBASxuBYwE3h6OjMmIca41m+dShlX24hlEaw9jFU25qHjd5gjWP/V9ti
 x8WH29Fz/jpChEQRdfM1xZHZUWJ+nW5EaG23ClsbO69YbKy7t3fu3sKy4WEtpFPMhUfnZ6xE99U
 JTxUqHLWmtV2rtuxYfBtpVChWWdA/CaBOZww42zFyGtO1vA5bVGs0v3h/l
X-Received: by 2002:a05:6a00:7446:b0:7ab:5e68:e204 with SMTP id
 d2e1a72fcca58-823411fe36dmr4689434b3a.29.1769465235727; 
 Mon, 26 Jan 2026 14:07:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231873ec59sm10217960b3a.53.2026.01.26.14.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 14:07:15 -0800 (PST)
Message-ID: <13a9dfe6-ce06-4b09-bb56-23162a355220@linaro.org>
Date: Mon, 26 Jan 2026 14:07:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitlab docker registries
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/26/26 1:53 PM, Richard Henderson wrote:
> Hiya,
> 
> I noticed this today, wondering why the daily scheduled builds are failing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/12868286187
> 
> time="2026-01-26T17:34:06Z" level=fatal msg="Error parsing image name
> \"docker://registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross\": reading manifest
> latest in registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross: manifest unknown"
> make: *** [tests/docker/Makefile.include:54: docker-verify-emsdk-wasm-cross] Error 2
> 
> I'm not really sure what the error message means. Do we need to push a built version of
> emsdk-wasm-cross to gitlab, so that a manifest is present? Which doesn't make much sense,
> since the job is all about a weekly rebuild of the containers.
> 
> 
> r~
> 

Not sure how the mechanic for creating those containers was added, but 
it just seems like this containers does not exist in the registry, and 
`skopeo inspect ... 
docker://registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross` 
fails accordingly.
So maybe we should find why this container image was not built and 
pushed in the first place.

