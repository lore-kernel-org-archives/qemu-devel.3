Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07F606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CvNZeZ/g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5z7-0001rZ-UQ; Mon, 02 Nov 2026 23:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xO5z6-0001r4-OX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 23:18:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xO5z5-000388-4E
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 23:18:56 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e98798cbddso17881725ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 20:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793679533; x=1794284333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N4nbK0uHEmstLviHBUk/dBzbts47FL3aRPhrN2feTUE=;
 b=CvNZeZ/gNI6pNuKMpcRx/uOJjZb1McjWZCHpQgkvIxZphmTNInB+YRyE3Vzcueyv0R
 nlVuA4E1nLb70S0wkpfi9ODf1NDdh3SUavGrlBHQLn7ICBXNAgL4U0b/w6f0H3jGAJcS
 H/nxpva5cE6ibuIb0MJCKcsj7wILADuE/sg03DqQAuwbX39xnTGgPNqq+4DhRY/OOmoI
 jKyqJcTitCZPic8JOyIkBy4IUHEBecwSX3H7FQus2BKQvGBPW8ATQrpQLYPiUb93ruLn
 fw6iu2igjfWR+R8TnQ8TfdLmZikygZsCpSC6f9tVNwH+lHzn9ETefBDk6h0E1ZVbHLI7
 lrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793679533; x=1794284333;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N4nbK0uHEmstLviHBUk/dBzbts47FL3aRPhrN2feTUE=;
 b=cNeoC+tiMcakCjyK1tXPRirT/LyiuMr7LXWYZxYzFbhdMHexUVpIo2Bx2veq7VIs8f
 RN/X1jmxkS+aCUpQitT5fvNPTfZSpDnPFxSAWPrR5b3VzO/8sHsAUCSFN1FhOpkSobeX
 DcdTvejOw2aEzrpE3kXlIabFQMCZ3EUkoaO1Ys485xSJSc3W/VrJQrI1suhdVMjl26ao
 BTBMN+lb8O+4ceuiDV3Y9/2y4JUy8H0XBts4OPODKAK284/6wgjilNU7TVRlsdi+PRau
 f3CB7p7p52XF1z11UncH8OqOM8wbvKSNADjltteU9g5Uj8G/L8eLIKIjL0eiPwkKBIe+
 BhTg==
X-Gm-Message-State: APuU4Z8KAIAEAdmmAr/ndq0aNv7dBI69S4g6rZT3WLunBbdWA3NcafZI
 LHmEE/1DZ318XRWI0kRruATIc5JHTMmarJ2Fkr7hI56T/hUH8H84CeJ4pLVwR8hPtxk=
X-Gm-Gg: AYBFou2GM4zp6fSEH0hid/IA/PoJesrk6IjqhzUmycP3CrLU7ZLxQC34oRwJ5jg8+iU
 XbPey8cfp3CVlZgTV3oOyKWTXwndWnBPoyMLqGA9LQmm+WtChPNdJrknoqHctDZA42bq9vTGa9v
 jO+K2BVOiNRU02+Lb+eUgBtCGoodALn0RwK2YJMe42iZYrwlvwJqdktZ0XdxjBcYdSowGrknOd7
 NGEI0sbhNZrtUs1SiLzUu7z+pBGa6tOAPTMAZPwgsNUsi1hZr/iXTbe4RELZdBkfQvALJ0uyDVa
 UAeLqz8pU+1lQBAf1rREA//VyujNMkyD/acFnH8E+dTqIjpZXsdxQ+0X3r0easub2ECTR9k0Stx
 k5+ZgMJa99Y+Z0891ZC6RaO6N5VbKH8lIF+SmpIyNlmPP1u/HHyu7ObD8DzlCoFHjcbCNqbggIl
 3wlP8uO7oCRfH9P8XnmNE4oQrp5bNgGozdBJQFUlJ17oTQL/Xmpn+VY5sIyiwrKQaU4bAtD5vwT
 9coEH5d53erPp4ptJ2SAy3y8r5mnOBbmme6JzgPiw4yxGQ4k6t/u5yU/x9OJU3N/Xl9loxPFC0W
 KJyZyEkdLetcHeYVHdswgzaQq44NjKF/pl57ZSepKUVbzoqiJHHw/OyKC5Z02P5xIWXnyw==
X-Received: by 2002:a17:903:2407:b0:2df:4dc5:e12e with SMTP id
 d9443c01a7336-2eb3649f0c2mr106497135ad.27.1793679533295; 
 Mon, 02 Nov 2026 20:18:53 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3927e156sm34550655ad.49.2026.11.02.20.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 20:18:51 -0800 (PST)
Message-ID: <a9cbeb05-7082-48fa-93f5-cd5685332ca9@linaro.org>
Date: Mon, 2 Nov 2026 20:18:49 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20261102162955.268763-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 08:29, Kevin Wolf wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 6e641f2440aa637c670b7f0fe512ea3fc2611b99:
> 
>    block/vmdk: add eos marker for stream optimized disks (2026-11-02 17:06:37 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - mirror: do not require a root block node
> - file-posix: Add 'accept-read-only-device' option
> - vmdk: Fixes for converting to streamOptimized
> - virtio-blk: Add support for FUA write requests
> - Print simple help text when calling "-blockdev help"
> - qemu-nbd: Add --all-bitmaps option
> - coroutine: Fix default idle pool max size on Linux

Applied, thanks.

r~

