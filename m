Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CF2D46607
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRaw-0006ZU-CP; Thu, 15 Jan 2026 12:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgRat-0006Wt-PS
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:57:16 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgRaq-0000e3-Gs
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:57:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-432d2670932so991696f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768499829; x=1769104629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+mMd8+uq4RQ9gxshvZ3aMOaigD8tQdNbIE/NTd7OiDc=;
 b=p2B/QYnYUt12rWV/79sEFa4C8UF3DrOz5C1ojJwhqZwI+nAyKsK0XCHBTgLiqHez7t
 vu0XHUyOQzAF0XA44taRaV2uTmUrE9412fyw8huKvM7PdbgsoC+NZYuUJWmEs1g/oCAG
 pd+Bx3f9Le0lC0+/f99g6u8mQrCCl4LRjB67e4N9hYwM9QdjK4T/Gw4gy0RWErO9jvLP
 VgQBbQsZKbOBxQkl3DVSGbqbELY0QX7TNNaf9HBKsuTEPbMGhuKPCKUMkeJnCxtZ8+Fd
 ASjq/34WgCHCcRwh1TjiNy+FdyfbAo1/4Cg4t6frQJV5yRSBfokT4V4ILFyxDX+boKqR
 9TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768499829; x=1769104629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mMd8+uq4RQ9gxshvZ3aMOaigD8tQdNbIE/NTd7OiDc=;
 b=BnZoPJe/K9ts9nmAnTrbfzASWdsXfH+pC47yodmzQpjK4lDooKqlYO3/JtRbtJ5joL
 EMVNK7A8j4+5RdZSANeas8lspP5si9ZC7GSCzjBtQnrcrpEcXaApd64lJPSjjEYuWKuw
 DoauCegcFJv2POhqbTqpyrefUGWyhzTQzyDun/yX7kTWW6dzk3VvaEz1OX3RbqJyX7kO
 gbfitcYVgUPKm3h5nip8KUq+EBgSHMmppo48EL2qWRrzQ1Z9QAGHIa2JU8dxFF9WfwJS
 ML5BhpWk1jXROtDMO+JGS4xnaUSO44yPrGnt2bYM0QBG3zFFI9Ks3Jrp39jBlBCkU7Aw
 0bwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDgnYgsu4TW28itJiC1DSw4P9oPti9sy0DmItUh2xidVYkwWXM6i9RepPJUMT/P2JqpiqOPdocQqxB@nongnu.org
X-Gm-Message-State: AOJu0YzQwiUUMGUkkc9faSOX8DOFmu7EWAnunY5SiSKF05Z5ZU7xdjnM
 M5wenxRLHzpXvdT66dvtM9mPQZLPJ/CrJExwl2irRCwb+aI5kiEqplZ/KpTzB0kC2i0=
X-Gm-Gg: AY/fxX485pSPoTWus+JA5i9ipzzZdYGZKgRu/hYvGWSrIeNUDNHP9BKx6RATK/DaqtG
 w7ur5OXFVTEvkjiiDk/0eG2ostbgnjvleoMFmAquI9V6I+esdQB7euYvF/6tWoyYJ+Ard0KouWo
 z79aqJyEYoPCY8DkgvrF1bmM2s6TobTLobgj7ex5YyIbAjCF6+wPcDv1tKkd+g2sjIGv1ncb6sm
 NM9ZeQ3v7i+tQsHP6FJ6sc8RMGjauEr+TLOxM9TLfa27PMz2UchQfIX0KGjjKib99PNlUIg6IHw
 Txmrh1MreONUajJyIRepy7vu8j2pHGN+cCpyy4cM7bk9QDcmOiRY0TnR9HhRvKOxBWA8E4qGPez
 fQjigfQEDVrWl8zf/pg6E7HbRmZzArxsbAuaIJTQNIO0f3218aNmhhnu5n6pr9v1F4xTIqG1AeZ
 NZr1iL7B6dDOnYa6ILF0E5j3u4R6+nWnjMHaYolWgJ2rsUpcdbOMNSdlBda4S3Gwru
X-Received: by 2002:a05:6000:2910:b0:42f:b3b9:874d with SMTP id
 ffacd0b85a97d-43569bc4a81mr259220f8f.37.1768499828800; 
 Thu, 15 Jan 2026 09:57:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569997f41sm283293f8f.38.2026.01.15.09.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 09:57:08 -0800 (PST)
Message-ID: <30ca8aa6-3e07-4d09-b09f-58d7a6a480c6@linaro.org>
Date: Thu, 15 Jan 2026 18:57:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Be consistent about capitalization of 'Arm' (again)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Ninad Palsule <ninad@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260115150545.669444-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115150545.669444-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 15/1/26 16:05, Peter Maydell wrote:
> The company 'Arm' went through a rebranding many years back
> involving a recapitalization from 'ARM' to 'Arm'. As a result
> our documentation is a bit inconsistent between the two forms.
> It's not worth trying to update everywhere in QEMU, but it's
> easy enough to make docs/ consistent.
> 
> We last did this in commit 6fe6d6c9a in 2020, but a few new
> uses of the wrong capitalization have crept back in since.
> 
> As before, "ARMv8" and similar architecture names, and
> older CPU names like "ARM926" still retain all-caps.
> 
> In a few places we make minor grammar fixups as we touch
> the sentences we're fixing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have left the uses in xlnx-zynq.rst because I fixed those
> in a different patchset that overhauled that file.
> ---
>   docs/devel/testing/qgraph.rst        |  8 ++++----
>   docs/devel/vfio-iommufd.rst          |  2 +-
>   docs/specs/fsi.rst                   |  2 +-
>   docs/system/arm/aspeed.rst           |  6 +++---
>   docs/system/arm/b-l475e-iot01a.rst   |  2 +-
>   docs/system/arm/nrf.rst              |  4 ++--
>   docs/system/arm/stm32.rst            | 12 ++++++------
>   docs/system/arm/xlnx-versal-virt.rst | 16 ++++++++--------
>   docs/system/guest-loader.rst         |  2 +-
>   docs/system/replay.rst               |  2 +-
>   10 files changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

