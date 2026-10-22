Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B23606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=F/otBQdP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnHI-0004pH-KW; Thu, 22 Oct 2026 03:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJnH8-0004nD-3z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:31:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJnH6-0000wH-9l
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:31:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso12482005e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792654302; x=1793259102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jveg2/e8slfpAkmKAr0Gu490QRow+isSNa+l0aksVMo=;
 b=F/otBQdPl6ActChXS/V9Tz3MJxTPFoOxTgzYISByYmo54HR+Hlagc956gWVDieweq7
 lLwPuTMtmWqpuqYdY5wbc1ZNf6xAyHG7iYTaHKzVMUCA5W1P1DtfpcJk86LXwZWNrsQs
 xG1TzPatuWGuYnUZG5sfQIZQ39ziKoTqxbs6mxB4nkBmx/upqRsYxFznRjxQ/7TF+Gwi
 3Vo6wSrCIu4J12r8pQSL2pEI2dGbVQ0YGx8chiI2yNkxQiExtOPFJC1ELghh5mOK7lwc
 qK8n5RnmFTamZ899GmsYCK6cAKdtfEh+xGEZtAnZOKvfh6zGClOG6LTfRX6nId2uVEj1
 fwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792654302; x=1793259102;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jveg2/e8slfpAkmKAr0Gu490QRow+isSNa+l0aksVMo=;
 b=hiegbIviLdBriTyNm0rDa1f9Xxx9/q13sNideLOtyo4gK/SWATpuHLxobEJnIeD8dL
 6PoJlnh9gz9vEXw51Jzt9CAUmfqHdsxHaOcNXXrUXya1o2Hhlexc+x5tvurJFnwlb4kN
 wNEKzz6eaS3vQkUXZdj8Mer/sueLSTexnJLu510wbVcYFh6sus4Wgh3SQo05P3oHlJ3z
 eB2vFwL2D+sRZTSA8ZD+987uyCUyZ0z9f9JcR9LMqPGUDV8QM/HaDJHMXeE0anFE3WjY
 Qw8W0LwmaQQfw2mKhrrafQ9L7+hRDE+KqrqZIRksKG74dtaDmCTxkoZjRiBqSe1fDU7F
 dFCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxsLcLRTUuZ3zJTZ2ss2N7Utl3Qje9ytlbBFs8NBF0NSaR+B9gIk/Zw1dB6VrRRgHhWU8bTE1xE0Re@nongnu.org
X-Gm-Message-State: AFq9FYJH8X9+H2OtuJk4N4e9Kau+wWlNo/fCJnOyIDtcgCmWauAuaIXb
 xM00fRmikZ8Yb58zs9m7oV9LwQAaB3pZKRS9+6d5VaC0cn+M8gv/0N68KSqKw2G8Iwg=
X-Gm-Gg: AYBFou0HCNfb+tAbbim1vWr+ti0JrnUrQVdX6YS3CylXoJonBadZYECAUXEe1dJlLz7
 ucMW+pzwFMF+Ek8GuwfukF1chGOI9Lxfe7Nt0LRMj0b3GTGgDMhFbskowzjSiDhaDq5AB0aeI2V
 pzON5RpAawozsXINpTEnaWAWL1laiJ/RUNTJWh5GhsbEewovbruH6dEe/VJPP0EvNx9e8gYUmjM
 XlUD04/zqkeuBOIhDDkab3WzYibjEkRoMBNtZGFJZd/u1eI0ZcQllGR9suL564FRISRpBRYuJHj
 sslLK1ZXvpn88m3yaxGGC4uudLCzr59IoSjRMT5ZBn1/eJlMHCNUqW9Nq2xTQ3ocW6iwPgYhIzH
 Ppeu2C4MEHfA0tz7k759XxLKw3dZ4Hf6roYiSt9+c8SEbvqSlS2TGSSFzu7Z8xeIfLBbLmZc4eU
 0XN/IJOUCVpdUoZ/14oLMiqQk3Sws3gVDuBFsoJI8cDZimxC0DIk8DrYuYzRaWOu1S0ClVGNohX
 pFqp0+MhiMnnnSvEZGDVC30+nImWlmjj9dYgasFDWbSlGGtnzZJLNjRXcbaaFPWkQN4Thb9UCUd
 vRkj4M8puS9qNXp4zCW+E5VcYPQ=
X-Received: by 2002:a05:600c:1f95:b0:4a1:e722:a0a7 with SMTP id
 5b1f17b1804b1-4a1fdd19dddmr96405335e9.30.1792654301828; 
 Thu, 22 Oct 2026 00:31:41 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64bf.dip0.t-ipconnect.de.
 [217.95.100.191]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203a56ac9sm53211585e9.14.2026.10.22.00.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 00:31:41 -0700 (PDT)
Message-ID: <89b2fca4-2409-429d-b69e-a367634092e5@linaro.org>
Date: Thu, 22 Oct 2026 09:31:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Firmware 20261021 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/21/26 18:32, Gerd Hoffmann wrote:
> The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:
> 
>    Merge tag 'pull-9p-20261019' ofhttps://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/firmware-20261021-pull-request
> 
> for you to fetch changes up to 966572648f246483b2076149b4fb9d665789409a:
> 
>    backends/igvm: fix parameter area entries leak (2026-10-21 18:26:52 +0200)
> 
> ----------------------------------------------------------------
> - igvm: fix policy handling
> - igvm: misc minor fixes
> - igvm: add command line parameter support
> - hw/uefi: fix pkcs7 wrapping typo

Applied, thanks.

r~

