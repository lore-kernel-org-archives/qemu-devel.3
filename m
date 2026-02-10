Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575B8EB2711
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpupu-0004sx-64; Tue, 10 Feb 2026 15:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpups-0004se-Fa
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:59:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpupr-0008SA-5C
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:59:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48069a48629so55572315e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770757189; x=1771361989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yoUxpI8CKskuHSFKwKvBdOShGEOC+hm/mm3MCQVpEBw=;
 b=o/3BhXew0PbxLcUW+ny4yP41CRPY/LPqHCzzR8RMoK5ljj4GqF3tJCd7Slq9VSsh0w
 Rt2f7CPPk0h5J3uUf+xPE/sFTxv44Z3bY/stF9yi/bIutcKyWhLth7XZ9YGIgUTtAGG9
 nK45Ni0ddUHZ3t2azQFh4ToJ8SD42MFJUmEpb6EhVFOhf1eh2Q6twnfWOiFNT+vRUei1
 SP3rR4/nmN8cI/ja+n1Hb4yMUL5iTgNTHN3N/qKqHI6AfLAFP3uDK6Fw22CwInW7jOKk
 cyJpZiWtJ4axzgh/VCgYc68ccCa3JUMWosjcgeSo3voB+zz57GxaI99r3HSlLOEqIwmn
 n9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770757189; x=1771361989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoUxpI8CKskuHSFKwKvBdOShGEOC+hm/mm3MCQVpEBw=;
 b=Pnc+FYYGV+xzgf/Wmc21YEeKWSYJemH9fP2syZ5SSD08vpSLzpRc82VyVcv1OypxED
 qYJZB2ecb+hz5yw9ks4wufShzLj7QgFxKvL0JZVzq2Wszo/61aNqSu4nrhM13oYV9AcE
 XXYDI25ooaZXm2kNziR39h1oh9ufh4DhLPTgO/CLddbqUG/CXw4i846E5JYUrLw/w4J3
 4V3p7W65JCrjCMIydEExm8EZt95Ev1Xg5yb9qTqNvNOmFvsZx+pyZgzuhylUtCc0VEgv
 g0bs+O5otGqzcXt4n/kJWPvUlS1xsPB2eHjXYsnbrWi1PfJ+IO/A8ripcAulOdEZb02P
 cp1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuT7EvH6XJ2SkYMRYFcCAkzYA+fd8GUdDYQHdQIVOHtX6/Mp/21HvI3TqehkeyFP5XlccoOPWIc/lF@nongnu.org
X-Gm-Message-State: AOJu0YzeCKMES+k+NN+d0n0W1nAVlG1nWyLaaraJTzfofIzO6uPV4Bkz
 bDiAp3xM7TZzm6Om4HoiEJxIHWhfTxTdOeifMBOFMK9dycbcFNR1dVCjPXwvMjNUYKQ=
X-Gm-Gg: AZuq6aKby49XxF08x2JsQ6pzT9NalvMgNH34tIC0rlt8DbTtFCCSVl3crEZn+wJdxHY
 r/ZZ5tMfuCEfrAtVFnRPuPkiBBY5Hg8UWeRswd9SDcbIz8qDY2haf8Z1esXqaaaShpr+EonT6rw
 xqm75be4oW1oGYgD6Vu0gCKjFzf2dNOjzBd7NbeXGoOrt9mmJq2omOlMvzjGnCLtKXxM7m+x58U
 y/tw/yF8YLldEDUS3RUCdCgrn5HU5BEC23Xv2Ouy+VlSap0oAHxnFEIqfxUN/pUOqO5YnplSAWa
 WsnbwYDqGJe/wbKCo4gI814pv/FH8qZquOxEJWCncs+O3VgijAyWWzJCayk/jTbapUCq5fTxAek
 xmFYUdeA6cB3dSbAdoZG7KKI+hK7y3LPQqnxKe4kqXrRMYA9zXiRv/68a+iXPG/i2vXYh4owgqz
 kfKpyeiNgge16P8dKznT7eo9z6QZPFUN0t+vVgq89HVXWawMCMURv5uoj9pMiWIS8=
X-Received: by 2002:a05:600c:c16b:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-4835082d1a3mr52309265e9.31.1770757189501; 
 Tue, 10 Feb 2026 12:59:49 -0800 (PST)
Received: from [10.123.89.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4376d3a32basm20266442f8f.14.2026.02.10.12.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 12:59:48 -0800 (PST)
Message-ID: <5f146dae-9ca4-4595-92aa-7a351ac7f775@linaro.org>
Date: Tue, 10 Feb 2026 21:59:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] contrib/plugins/uftrace: fix infinite stack unwind
 detection
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 anjo@rev.ng, brian.cain@oss.qualcomm.com
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
 <20260210201344.1403613-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210201344.1403613-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/2/26 21:13, Pierrick Bouvier wrote:
> So far, we were detecting infinite stacks but not stopping unwinding
> since break only exited inner loop.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

