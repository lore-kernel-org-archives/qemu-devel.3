Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2B2D172CC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmUz-0008Vx-UR; Mon, 02 Feb 2026 00:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmmUy-0008VZ-2l
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:29:20 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmmUw-0001Xs-Gy
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:29:19 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso2465098b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770010156; x=1770614956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QgqVfR1bNGuRQUWbBAdWA9UmhTzj3B2hpLOHKByyZgI=;
 b=hbUSGxswIr3bkvHJqtwEj2Zv/tMJvqoDbtIVXQlz64qopMM5wipF+9rJh3pZwQuBzp
 BmZa6GF3BfPSmJM10Q3G4FS3GxjNYJ91g6QgtfWa2Yl5upYrP1NaVThK/ZB8wyKi2EaF
 THkzu0kZt8pdTb9Epq6BaQrHYFwwZX1FT04mi0Oz9A7GR0FKsuDbFC7lcQ1nwX6J/BXk
 X3UvUU1xQBWFkviNGdie1soqFoAXjgiMHrRWVpUURXuMaWaZa6W9RfL7FlG+RzIxN9Gl
 Fc+dJgV8E63IbC0TCXtjXmqz5DY2XvF51F3AepLPXobj3ML5BuaSjTNZgoyTdVBb7oq/
 49zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010156; x=1770614956;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QgqVfR1bNGuRQUWbBAdWA9UmhTzj3B2hpLOHKByyZgI=;
 b=P4huRXSMMueiSWoVs3MUB0MweFzThjC/8UUFuxd0jKF2sqk0TEWbGeFgBLRM/ElSUd
 KDX96w8kpP+ffoMuKh+/N1FMOOPomzwjtjwHrh9HGo+oP0tlY2AU9ayIFj9wQCbqkDnP
 WlYOcOPeXfOkRH0YVmn460YnfVJoyxQ+9E8pu4RIwH8LHOesEPajx+tdsc/zYy2Bj9Gl
 yZeoBvNyVASb9MTG8witDx+57OwqOFSPlj0DzfAFzRyHlfPWz4hPCtfwMP4+XZr0uk++
 UQTZkkkplv1zM66BFLsoI1poWklHFrG+Ho+ed8OEaM76wpeX/fxBJ5sHPAw2ki8iDP42
 QYlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzdmE0pKcpBsEThJ276k+8G3ZiNktsV5bNokHBvtGzw2aMUA53aKvGUMYvfwB06trfwJu2iwDkxEu5@nongnu.org
X-Gm-Message-State: AOJu0YwqY34Zs3wEc5RdHDjUvG553jdbwr2BClAIAwc7THnUSPYUTe8l
 LTCGuHI+XQfgZErrgJad3PpICPo70hRAj33Mwdt9MniaOghpUbb2qNsnetauOV6K9gU=
X-Gm-Gg: AZuq6aK8TNyV8U87YGqeK6JNSXf4P36bi23Or+kkyHhxoLKUUNKQwIUyAPBuPGmtbHY
 WUksjJsXL0ErFkTY4BnFBa0YoDtW8Wwe332vRvgsf+2rTwNCyT4cK5yMbW5gkA7laIu/HIzH1Vt
 2Zcz4r/mHl/FFG5zSNhdWTFLlA2Rtro4N0s3jvPYW7qruotzdaxAiXxeMEMcR3zUiPPwZ0cVGgO
 5Spby4VGiHh4UplKhBbZf6nhexGrQamoRfqiY15/TCWFT+sT7PD3ZdeTMn0OYmAwlklioBGHMMF
 1ROP+jNfyKzjcVqOeVu2bejvAqmIfCNLTFl4NRT8SnoB28ZRFvHXldzZ6yY0VW3emynqIuagFnl
 Wj27v0cgIuScwMaDfhdkJzLyY/05etswRmDrfrfMA851oH/INEzuLaTlCKlbV4ojki6L8JbV2Zj
 /x+Pv0JUCWE3CO2+hW6fIbEGnkjBzyYXSNV1CnjMI7T5X7sH6QGa6vfNKC
X-Received: by 2002:a05:6a20:1582:b0:361:4fa2:9757 with SMTP id
 adf61e73a8af0-392e0130cb6mr9524234637.55.1770010155679; 
 Sun, 01 Feb 2026 21:29:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c64276efb16sm13266762a12.4.2026.02.01.21.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 21:29:15 -0800 (PST)
Message-ID: <3470106d-2be5-4c73-aaf6-111dd70a3bd9@linaro.org>
Date: Sun, 1 Feb 2026 21:29:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
Content-Language: en-US
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <cover.1753857212.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/29/25 11:41 PM, Alex Bradbury wrote:
> This series contains one minor feature addition and a series of small
> bugfixes/improvements. The addition that motivates the submission is to add a
> limit argument for the hotblocks plugin, allowing you to control how many
> blocks are printed rather than being hardcoded to the 20 most executed.
> Setting limit=0 and dumping information about all executed blocks is
> incredibly helpful for an analysis script I have downstream.
> 
> This is my first contribution to QEMU. I've attempted to follow all of the
> guidance in the "Submitting a Patch" guide, but apologies if I missed
> anything.
> 
> Alex Bradbury (5):
>    contrib/plugins/hotblocks: Correctly free sorted counts list
>    contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
>      blocks
>    contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
>      PRId64
>    docs/about/emulation: Add documentation for hotblocks plugin arguments
>    contrib/plugins/hotblocks: Allow limit to be set as a command line
>      argument
> 
>   contrib/plugins/hotblocks.c | 20 ++++++++++++++------
>   docs/about/emulation.rst    | 12 ++++++++++++
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 

This was merged into master (a8e6997ef).
Thank you for your contribution!

Regards,
Pierrick

