Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891B6EA3F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvkP-0005OC-TB; Tue, 10 Feb 2026 16:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpvkN-0005Mt-A0
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:58:15 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpvkL-0005B0-Vq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:58:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48327b8350dso39227945e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770760692; x=1771365492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tcA7sn6CW4GwfOM6ayVN5Eb6f+qLKKiPpfVeslJ3rL0=;
 b=JaTUAj3POFplAiM/3hblNX+Ee0WW/Rz7iLqWE6hWayi5dzJ+Hhq7r4qjIBZhlj4ZpK
 FQ4KSG2VfM1fdL6zT9d9yLhUz+oMcIbSTy4jOHiKIuGspXwIwySh91ji47cniyQWqCHs
 A2vRA+fRhLOSy+KnzPf4WV9kaumMu77iop+xysB4egWsexSmOgKYzv2Q5jKbveiEOiwx
 iqE7QdSYsWwOedtkxsdsfqC04ATDKf+i2cdhh4H7ntRYAxnas/wAkYPGfgtP3Cwk+aDa
 jV1KwLq2Y1d++QBUvXBxXFCn8couOQco8SFixtaQ9Ox4ZWdr4TPThV0vBWF2IwCZ+g1U
 m1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770760692; x=1771365492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tcA7sn6CW4GwfOM6ayVN5Eb6f+qLKKiPpfVeslJ3rL0=;
 b=BFUY/lYPZoeY3/nE54BJfj9xR2tVtfXqLVuuvsAo+z4oTkP5QVPwwoVdRa4YZWy3f3
 IMoMaCfoI6L8OYEAYiA8YeMoUdhDgNAYjeRXackS+rzWctxQTL4gWL5ArfR9ILx4yE9O
 ioisY4TjMEHU0G2WkzMvv5aJMgMW17xXXU0rnsmCNdC53Ii4lPV3nn5hsR7F5B2krGES
 Qibfbba/sC1FreRjsl6zcGx8jhMPHXkS9Qn7OvxkYYbMsQkydzvJAUY2UFgk0crlkhJE
 3feRDeUuOZBoyT5/7RL6GEZVjCriI0bRPVos6exb7VQddh3wjkrBvKEZ4PIV9Deo9DBF
 LzZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9T6ZK17nC4GUc1xbL8dkbTNlczmqul0TgPurmrr5z19jzqvbpEq45u5kahRO9LFPAvKmJl2DJ8dkT@nongnu.org
X-Gm-Message-State: AOJu0YxIPF9t9Frbv4WPp5WekXS/KT3b+TQkbFI2F6gefWHW2Jy9ULpg
 rKWhkZ4SIzbO8jCy+noBxJ8437zigOU58EsVklPWhiHI0kTOxP18e19fmIwj/S+fVgA=
X-Gm-Gg: AZuq6aKinsenseBSLeUl0oTz+x/9JOvkO9hU/gEqyb6zHsH+s1EO86RYYkX3unx0nE1
 l786C71Me2ZmreTVKTOq+ABUF61rLbOmpvVMEFfWFQYmoKIFXhdTBLEiUV52ZXZK3MZRfiAMA8N
 4su9pV9kUrMR3haOtpTW62Anh5WPuxPiF15g9xjK8rXL0isAEKgBnLSCGPwVbkSyN30+ZJW/DtQ
 bpB9nDd4AQlz6j0gMSj5BSWrAlyXbwPWCMvYw3ct8MywJPXk0sIDs3vCLs07DYsuVOoXTyq2efG
 4V5TY2aA2oDBJZ3O2SNtFSzSaPMjnQoye9i4ZLsoJ9S2o46eNjde40AszGFUmPWLdw6CF1yuLAL
 g/KZfFnqst3KKAvqtjtQ7t47mLbeIt8Vay1emFGwO/W5M161YbW8SH+4vLzZFYVgY+hbZ3KKWvw
 hWcWJFqJyJmKWkZzLsbYykaVyrstZahR+hERiZSUoMOpDkoyFYL9iiWzBYVr2AuSXMWEIxI2BG8
 pSK
X-Received: by 2002:a05:600c:64c9:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-4835b92bfa0mr5400205e9.18.1770760692509; 
 Tue, 10 Feb 2026 13:58:12 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm78313765e9.8.2026.02.10.13.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 13:58:10 -0800 (PST)
Message-ID: <48d6d5df-1a87-4cd4-82ce-5f67d8658e44@linaro.org>
Date: Tue, 10 Feb 2026 22:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] target/arm/tcg/translate.h: replace target_ulong
 with vaddr
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
 <20260210201540.1405424-11-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210201540.1405424-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/2/26 21:15, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

