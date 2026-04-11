Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD37F3ED6A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBh2H-0007Ri-Tg; Sat, 11 Apr 2026 18:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBh2F-0007RP-Oc
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:42:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBh2D-0006aT-Sc
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:42:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so42807845e9.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775947356; x=1776552156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvCq3Cy7wX+HL0FMrT+YMOuJcoj033MC/MGno2ssRlk=;
 b=z7BMqzmZR0vr1rpVxtZZEXX7z+n02Faeq9V5n7F4nWgj1fGRF0HB3YGbe/Smbsh15r
 2sMYneS3Vv3xwOjIVtqtonqBYSBICVDwNYrsDlMYdJ9AIyMtkq1BgjP4ZK1iUq/8jLQW
 6btLzVaLKf4c+tOF4gnW+wwMlHSxRKvfLiz8y3utOqWLffVRl8lQ/p9qX6OBtb9bf7Sg
 BorZu8xBTEbBHbrjCWvta8jjOA7OC/GAaMU1VMFLnpzQXNRFPXsvLV0F8bVdFJDljsPx
 ZNKPlGunZTpFIo4pPDPL3SGzCSiho/21mzWjBs3rSnmURBi3pZQ8xxHmpZe/AjYNfFWF
 2h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775947356; x=1776552156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dvCq3Cy7wX+HL0FMrT+YMOuJcoj033MC/MGno2ssRlk=;
 b=dQB/0IkYM9fsqnq5WmsQXbHh+rKzL2exMIxGhxz9z+hPqpjBMgmzPKTrg+lPXzbpDU
 3cYHiYOSSUoq6LF3UYkLT6MhS1Do0fHtuQJgwbAROcS+JZ2O9CBQwVgvWRfipHRQDl1q
 4j820shep9uGt4JDcP/kal9OltqzPGWxfbaKL5WJ8nFJ/RE52nNe07UU4DfyTdmN9r+b
 4mS56b0y5v3EmJkJ9vC1peCOmzeUHPeacyCciBUJicf8XBE7qiwyQiolEiJCYTJQnqN4
 jkDgfyoCo8GmHmGue+oqlTj8kOBThUZs2OejEMfBnPVNqUyIcT7zgs81VyfuJrQOQQBC
 g4Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrxjErnzk15BkZq2/AM23BBc5jNDCF6t6Q7+6JgZb1k+QTHAFeeMYSkCwOqAX9bqMpJ3J8aEy+Ocpr@nongnu.org
X-Gm-Message-State: AOJu0Yxu2sNNCwagce3EDw8xJCOsCg1GQgKT8KEEJh9Q99GgsEgi5+It
 TCeBmzTzI/cU3hYXj64ErnOy4nPLeIFnrQ/fARC20WwoGrC5tP0IpmFR6i2wEsH91Wk=
X-Gm-Gg: AeBDievAS8O1Mmmjd3sqQZ9upWS7o4q/uZkUxWis4lspHK7v5uxHwF1WSWpjldcZ2gs
 I5LCDAhLDv/sX/FWENeSUnqgJgpe7Z8nGfUMzQGYeDBvvysZ/9TFPvPGKbBudMBr09lC1WZEq47
 H5cEAgxt1K0WBc/YLonbhjtFb7VCibJ9rIQo+8LwO/Mz9HU2baO4qroG2ErZbFc9kYAlSD1UshP
 9O5ERshPvhB5xFD0LIY/2uXdRuXAbM5EIAs/Ax1oSYXxoMpGMLKy4G1zsPMLWc1PLTDbL5epte/
 wURLndAB9c95OJN1+vs26MOBYeIHk9iDr3GJ+VhtYVGQ0rjh/vn653D+RiwruiwMzPuUHQARWUq
 n8vnQ2GHxkFm/JgiVzydd8E0pJuP5BaVEgVlxEy7H3iQfTXvPHpwkaeTgXM/7qkIj+IYaSPwUPN
 RR+dpWxubb8VPier3c9eBK3iA8HbRWwqPn0va7/A7LVxXhbToCn/Y/n+hTCDcWyu4FOg==
X-Received: by 2002:a05:600c:3acf:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-488d68a8275mr93503425e9.28.1775947355989; 
 Sat, 11 Apr 2026 15:42:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50015sm20507085f8f.27.2026.04.11.15.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:42:35 -0700 (PDT)
Message-ID: <3a2f3e97-816c-4a41-b632-bbf8b3b16adf@linaro.org>
Date: Sun, 12 Apr 2026 00:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/67] ui/console-vc: fix off-by-one in CSI J 2 (clear
 entire screen)
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-8-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-8-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/4/26 21:18, Marc-André Lureau wrote:
> The loop condition used `y <= s->height` instead of `y < s->height`,
> causing vc_clear_xy() to be called with y == s->height. This clears
> a row in the scrollback buffer beyond the visible screen.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

