Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE9EFB44C6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBCw-0002ic-PW; Fri, 24 Apr 2026 03:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGBCs-0002iN-7q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:44:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGBCq-0005MH-LE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:44:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso56221475e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777016647; x=1777621447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3EnesgIeeNTPrEUM822wrdXyIeBqadCh7YpZ7ZJRa50=;
 b=HMseTqvEcNSwpcUbDdzPfmIoc3XwOQ3yM0Z4XByGfkFLbrG2f14yFXR0pA+RrME8Py
 sLx5SCpdl5eBA7DKo6WNAnV/Rd4xur2LIDLNlCAjC05ZrduwerGL+6UxxT2Kkn0mpkU5
 mhtCmTnF1Obm1+oGAsB0Ao8yN6x95mT9Honhi5DL5Gq44/zcHuJljQeBSgjJEPXBD6Ke
 1xp14w+9AsFog22G/trcRq2PYLNoBTY0uEi/5vqiPqRyZF0WKSvK0ml1RnJLl3814csq
 PaYv/NwkcsXcMxovSnW/yiSmHqpoARgp/eBFGS1qHCS1AaTW4eIkrdaWR5Zbb7/OHfrb
 J7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777016647; x=1777621447;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3EnesgIeeNTPrEUM822wrdXyIeBqadCh7YpZ7ZJRa50=;
 b=qftPosyC1nh1oGWdGdb+Rk6hV3OX9zzjzHxV2kSPr/Zj6FLijaPpnIPEglqJz0FmmC
 ZZenUs9TafuFxUyGPwbdQHnAShhZ61ANnkmhppQVjzWSc4Or0lrfhs3lSSLy4VD06YOe
 VN80G5BJh0FSjTE1qUKROmgqBFI/+pAEtWg7e1HwCGAOex2h8FaQPtft4qbBK8Fk2kl+
 TAhwhr+tTKU7/BtRnfwIfyf0YFDsFfd72WtAKsoTIPP6Bi9ef0Ij5JS/Scr9zpFmrGyB
 LZ5Ymsie/xOm2z9TEbHlz69pjhFLi2QicVXPMUBs/YvQnW1bLB2jNvkxlhX7Je8Qr3NB
 d2oQ==
X-Gm-Message-State: AOJu0YxG8uAB8gVPp10Ceg/ehCXyvv5V6PB4pCDs6AcVuLWy9+ad4ZMN
 a6LIHkVaUTnf1aZQlkJX9dCgFaHX361tEQJwkEsWbUhGYR0L5Ur4Q37XcRY3eqL8/oI+mPKRO0x
 /cICgDuA=
X-Gm-Gg: AeBDieuCAz+4os0L6Dwbug9qdFLLr/ljRSMuP8OcPJ1BnXLtCfxDsROYf1JiqpFikLb
 9WYvJbmPjvziQnsYbkQGql93+RRooWTMauOXeVE5eEFUQzkOBr1wLzf0rSI5w0IvxSVoZ3na2uS
 6n69/11qHrpBkCfz78bSAX+Y3MGZHaH4KZDE0WAeQLsV7s4FWYEaEH258JxhOpSHUaZsVXmlVZ5
 +N/kbXq2sWT1G0JD58qScWY3KQNVGI16cu2OB6ZTEx5z6JlQPWEhUL6CJ4ZXRvRNqOhISTYqAWy
 MOrrCXRbhrEzZQj2Ll5dX4P/VLDRTazqWIv6+xSV9ob+NRjSQTVEay9/puLJJsH9aYufezPElDB
 Unh75dJyP4skGv2Y/9Tl5nxA4fSaUXXxv4AQOCxl3S7RGTdfVPDnYevAtiJ79g75slcTthxbWXR
 N28po3M1vdpBFxWsfKWCXpIG5QWVVdrUQUlgoJJF4ueMojYQRDGcJe201L13smN0hv1XThjD+I1
 R8Rw/hjaENajElzwenZ18e0cIeYPG+r6RAOljsDZ7jhxxae7KipQT2i/otSRLDO/rS/1EgR
X-Received: by 2002:a05:600c:a105:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-488fb7826femr306684265e9.23.1777016646890; 
 Fri, 24 Apr 2026 00:44:06 -0700 (PDT)
Received: from meli-email.org (athedsl-338307.home.otenet.gr. [85.72.177.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm52481053f8f.14.2026.04.24.00.44.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:44:06 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:43:52 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] contrib/plugins/uftrace_symbols.py: handle missing
 source line from addr2line
User-Agent: meli/0.8.13
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
 <20260423213838.780814-3-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260423213838.780814-3-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tdzmth.1gh4d7ywp7riw@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

On Fri, 24 Apr 2026 00:38, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Some symbols have only a file information, and no line information. In
>this case, addr2line reports '?'. Replace with 0 to guarantee consistent
>data for consumers.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/uftrace_symbols.py | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
>index 895fa1a6b7a..a71865805c5 100755
>--- a/contrib/plugins/uftrace_symbols.py
>+++ b/contrib/plugins/uftrace_symbols.py
>@@ -70,7 +70,10 @@ def find_symbols_locations(elf_file, symbols):
>         file, line = out[i].split(':')
>         # addr2line may return 'line (discriminator [0-9]+)' sometimes,
>         # remove this to keep only line number.
>-        line = line.split(' ')[0]
>+        if line == '?':
>+            line = 0
>+        else:
>+            line = int(line.split(' ')[0])
>         s.set_loc(file, line)
> 
> class BinaryFile:
>-- 
>2.47.3
>
>

