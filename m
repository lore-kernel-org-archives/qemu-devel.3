Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95884EDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUAU-0003Av-9L; Tue, 03 Mar 2026 13:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUAR-000384-5T
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:08:23 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUAJ-0002Cj-5x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:08:16 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82748095963so2978686b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772561293; x=1773166093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s48lV2J2Dlql9cKxvznvCtwN3MJTUr4kVXBIVHCP+TA=;
 b=kTIGnQaCZAWHVH4vnmuMuNtn5HyYD8TqxJjnmyeN3Mrs5kEkjNPLSBmWUFG5YV35bS
 Th0AzIIKFD0ehyg4BhfYplmkfjIhbfoV/Ftm+jtohGpworOhQEgeoyuCVEmNkWpnizy5
 JpqQHmvYoPuF7Cm+BZrsO90VAPAUIlkiwofhpzIjM5CkPCkzjHtmLX8YIQpGjNwp//l2
 LwbpMza8fGAEPNhCIa1MmWXeOioYh0k0WV+pNKm4x3CuESa6gpjodeTmj6ajVBK/snFM
 LRXuDgwTXV+SvcqqGIUJYMu2XcacmfXe9yTK95FlR+zYufEryYD4HJU+Bna8Lqm4eOSY
 rc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561293; x=1773166093;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s48lV2J2Dlql9cKxvznvCtwN3MJTUr4kVXBIVHCP+TA=;
 b=DOrGgPn7JIaBtaynehRhB2E2tMvfiBGuFv9ORTttSk7DxdYIFpcIEzB8FFssmyjOfy
 QedI6mwPt8eEHqGI9xEJwZDGUZ3BulZet8UC+68Yt5Z2+u6vRPVRkRTABj+/qGLXkuii
 LLoAk/PlxkHvi/IIjjsS6ERCEIrYB8kpJIlJNFoUuaKTYbyAKuqzMvrU0gY6OHU5mu7h
 h1ZVtnWmCd8NjXe4b7izi9vgloVsLgMTFNdGcKzqsvdxkqLDUTg+ywrJRFZ86Km9rLjg
 sjY4ZNpx1dWkNcnhvxbb0e0/a6AhyJW4CJuL7+5auS8tBUeKSvIJJG0Kr2X15r1WCf7H
 yyDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeLKWU817/B2i/XIdPHF6klGcz4YQL9sgFXQj0GwxedfN5ic1neInstHFNtDkX6WLh9ESr7gkzY0Xn@nongnu.org
X-Gm-Message-State: AOJu0Yy9sYe1HQHTH5JPqYmDGs2+twCzuS7wbcgCBflysStMsLzBglq2
 Fbx1x4R4QRTMeREZqoWOV1jvF6fkh9c+pjH3eDaOIkKpKgskHVhjm734kusV39IZbN8=
X-Gm-Gg: ATEYQzwheSMkLXiUp8GkaySVaQwe3CEXi353XE2Fh+bCC0InfFpUBWwHKqN0wbqYKPc
 WJ/LKEtsMDvRmCeZjMA12wWxMjQ8HD8koXogbdEyY+Cx3JRMCA1n1fdGLP8zIx15hI6U4ZmiG9m
 IGxeOSVnNV98UzzPikDj4wooyS2FSkpiP2V4fqlWLrMNctiwinyDJnaapKqqFojmizMEHfSv7X7
 kPLfNBVydf6H5C4OnkhXfx+t6QPU9ncwTioetAOVjCjPsP/KExHoh2MpAL/dg1kAtc+grBRwZtR
 fO1By+JtvvvMT6LgxXUHSzPzs4Q0xY8/OZHozUwyNel8/W6eoii0rkdf3nDF6MGCeXjbO3MaOYP
 4jBse/SLWnOOIAAGFsz/g7bmcqXguty5e2E1lATx1zxC/nWbXcndR4kE9HLpynwU+exwCZTq8DI
 tezLYAiv7Wb6RccAbJ8u5DoOt3fSfQQy/6yRROoGt4aN6f68yaOVeJGu1F1i2kBHX+27DK
X-Received: by 2002:a05:6a00:90a3:b0:81f:d605:b2c with SMTP id
 d2e1a72fcca58-8274da08925mr11000953b3a.48.1772561292816; 
 Tue, 03 Mar 2026 10:08:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d49423sm16620708b3a.4.2026.03.03.10.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 10:08:12 -0800 (PST)
Message-ID: <45ce9420-b884-4121-b51c-8be86dedc5ab@linaro.org>
Date: Tue, 3 Mar 2026 10:08:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] plugins: add flag to specify whether PC is rw
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-1-15c77cfe184e@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260303-setpc-v5-v6-1-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 3/3/26 5:07 AM, Florian Hofhammer wrote:
> In addition to the flags specifying whether general-purpose registers
> are read-write (rw) during a plugin callback, we add an additional flag
> explicitly stating whether the PC is writable. This is in preparation of
> a patch that allows to explicitly set the PC to divert control flow from
> within a plugin callback, which is currently not possible.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   include/plugins/qemu-plugin.h |  3 +++
>   plugins/api.c                 |  4 +++-
>   plugins/core.c                | 29 ++++++++++++++++-------------
>   3 files changed, 22 insertions(+), 14 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

