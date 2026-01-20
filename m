Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4AD2ED11
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 05:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi4Cw-0006YR-VY; Tue, 20 Jan 2026 00:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi4Cn-0006M5-JQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 00:23:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi4Cl-0005MR-RV
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 00:23:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso33515295e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 21:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768886582; x=1769491382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ypLxl3JUA61p+0cp4u8H24rNYVH0VBvsJ96rBibZ3bI=;
 b=ztp9OUMsVsdQpkgEm8wD2Z0bYl+73adLwvwB7KUOBnZUXlsKirSEtglEPiYqFdR//A
 0wt1C+YbTsMP9f9Zj2ZBPNMvDbqn6R0ESFOz0Vz5UUg59G/8jJvwMi2g7nEQGFO1bpW8
 HTotg0lPjHmViYJARf47tnX8BLLekE5DPrIABev7Q6wxcIVF0bH+lLmhq6nECz4XHoYj
 N7Vqy4Db5RPeyrzD25/KvrcPfM0ihDDr6zpdqffi+s130j794NeNdbr6KQiy1fvi1axd
 uQoXQCSjdkpE0qcT/bAHELTmlwAMOrnH9vAVOCebHj+Me8sFbwnWMGEDh6KbCLLbrHEU
 8WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768886582; x=1769491382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ypLxl3JUA61p+0cp4u8H24rNYVH0VBvsJ96rBibZ3bI=;
 b=MB3kEQP0cql+B8LKYfaHaydfqqAnTcbkTqUX/T4vTwTdmVVYQVmUaXGvbyMDTGAom7
 V1pYz7huC3AO6C0vgGIaQx+JcQk0a/d6resVu9YZTGr14mISOerffO4WHkXra15yU45O
 H3RalBShp7hIjs+g9x0WQIxqfCpttJtFaQJgCkKqPorwW1VzKAuSHnWeOyW/BxFIe/i7
 bq+h4zOkMxp9DQIl2rGlVX2tNem88m4k9GI2PgzfJQXNSGnVSV5J0lhbBRHKeJhAHHKy
 RUML7KwDFmC+Oj8uGWiyc7AfpX2MBu2wqh7jyo9IoIkYHnpRzG4HcUfhbUqeT44vx7LD
 m9xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzSooSYZ35EwAFAJEqC+BkDMJwUiJlddNaH4EXhPVH3bXmIcyTEloPuSjkDwvTVR1tXIMJ0wrZfd/x@nongnu.org
X-Gm-Message-State: AOJu0YwW4FpVSZ1u0/nCvG62p8ydBqzqtkQn5gIOKJsXDOsTCkUy5HVX
 zoGCz5g5/MEaTi/jw8R1t7gaXTNGyWqm1fb632//jLojBIQlVz797AtTQ4ujPOqdChQ=
X-Gm-Gg: AY/fxX50XERi+nhmBbTn3ooZIrxhQjCup0AIEtYHKkv1HysPGvTu2ANRYKQYDnlmd02
 GIGybdTKteyblKkBsu0/PWVpx6fNMTnUwIC9c5pwKQkARfhu5DzM97dF3ItoUsqrC920LFxuRWW
 XY2ckLwN6tQ9euJ5sttWrexlirR4HshgQ3+EtCd9dl1hxJ/RWiw35DiEsZHExMWATkcdR05HPaS
 Ks/aSwvCrnqb0039v3XF9NNqgEi1iv4mQWAPocRUtP06V1/ZwunKmmXpZ2Lsd8cIHgu4CH5wjmK
 y7hdGHo2QC9kRRQ5jD+L7OAu679VmLpzid1hnBpaHQpxcTikEyTWpbfqTLtK0byWRIbv7RK5GPL
 GVCHn2iqubF/NvFgSFTTFwpGxSjZXxUgTYl2YEKgXLHMjvaJA0hhgri6vHjvndwtLDTBC1bHc0N
 FmPZgb8jF65S0qls0p6atYOXTRBHWd3z/cFWhHzx1Ikbc5vlNwPG/ORw==
X-Received: by 2002:a05:600c:c04b:10b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-4801eab9e81mr131146255e9.4.1768886581808; 
 Mon, 19 Jan 2026 21:23:01 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b7aasm289067695e9.2.2026.01.19.21.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 21:23:01 -0800 (PST)
Message-ID: <37c56641-346d-41d8-88a0-57f4994c6ca4@linaro.org>
Date: Tue, 20 Jan 2026 06:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] docs: avoid unintended mailto: hyperlinks
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20260115142629.665319-1-peter.maydell@linaro.org>
 <20260115142629.665319-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115142629.665319-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 15/1/26 15:26, Peter Maydell wrote:
> In rST documents, an '@' character in normal text or a parsed-literal is
> assumed to be an email address and will result in a 'mailto:' hyperlink in
> the generated HTML.  In several places we have mailto: hyperlinks that are
> unintended nonsense; correct these by either escaping the @ character or
> making the text use ``...`` preformatted rendering.
> 
> This commit covers only the simple cases which can be trivially fixed
> with escaping or ``..``; the remaining cases will be handled in
> separate commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/devel/submitting-a-patch.rst     | 2 +-
>   docs/system/device-url-syntax.rst.inc | 4 ++--
>   docs/system/vnc-security.rst          | 6 +++---
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

