Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282D1C636C4
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuHaF-0004w8-LX; Sun, 22 Feb 2026 17:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuHa7-0004tF-FP
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 17:05:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuHa3-0000PS-QB
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 17:05:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so29348295e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 14:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771797933; x=1772402733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8xxQezrN1+oeCO2s+GJEytBSvyT8YSM1E5TN7wcEyvQ=;
 b=B5EVvnGZGIiScU3eKCIsfUK153AoFYEtEgsd5S6wm4F+lnjMR7hwsfBe7HsDHJChu8
 quJuKf2MmZTTUfONiN126lUUbuAuxudEsOVMG9E3E4oiCdhNH/MyYeJjmGd1y7OP+JWX
 jLU4dSMyvfIp+LL+IBFIn5mECCsu7IWTPSkLkj6eERdonNuAT5PL2FtyXiJWZPN8+sHr
 LjfncgB5KJ73LNX10PWVrlMNdkz2ymBv5HJgLTSzCzonMGBswrDoCRY+sg/Pq80vtDP2
 ApjJFUVXXqiSIqo+Qgm6E6Zwl2TAhcFlIdxcLsUGuv4xeWlBzYZsZRop+UDZ1zZijjS7
 kBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771797933; x=1772402733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8xxQezrN1+oeCO2s+GJEytBSvyT8YSM1E5TN7wcEyvQ=;
 b=G6zwaUbUEve4PZK6UoegK156/bcan5tD5QO6k0uWcYEpY+gI3wKFs4nH6mLiiAWssF
 Q3ZOCYyk7oy1RX0zgnFc98xf+NpXX3YDjSXIgPvNp0U50ZDpD28AF8zgIsO7kpKK0SH/
 rUgfoPG05zVVjZBgGC2aZTIuHljejCk0bzyJK/9/5qrQ1nCq8ntahLmzEQ7LuesDPjpq
 dRqCAhTtf6+XfZojrIQfU4Btu2py/K/1idrP3nSvqijPVJ5T5nfnxwRJYQ4AmJWPARu5
 9nO7FDji1hoji+45gvYn+F8iTyyy+d+T/n1SfTHF81rieJjujdghH+OjqwEqglRgsAAc
 8pGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSQ4r2u0IfXsulaJE/3bhp9R8dVpVIDFQm3v+oAhL+fFIl/JXmypNXNB11KTvCjmaI7BtUm+4tyEpq@nongnu.org
X-Gm-Message-State: AOJu0Yzp4QTARZ5ippPx0waXagVvGOfOvxY2cRl+i1VgSGZ/cl1zTEgQ
 IIB3iw1L6U8gw66ItDwqfABln6mj3UqJvtn/UEI30Rqbmu0hgsZkvRwKk2WSd/nThzc=
X-Gm-Gg: AZuq6aL8vdHCms/Fcnm5Fgliy5AgpniiNIPgoWLMXt3NvdStVDZc7St77UtPQ54c7Ah
 7CF5f7DWdvaZdXKmjN5QiodlAfuoJr0qOX16DlHIqu8AoGHe0sDhco14wbkqCgcDExb5ZSEboUu
 b8K7r8PcDWFzlFGE6X0xd4iYs6niJJi/1cl+gPJFnW3NFEX77GlqvD+3y31rY37ZlyN4X//p93s
 nmyYyz4mTl6pjTdCwYO1A7OhrYZoIFMm9A+TFCEfI8krAuyu0Y1ZikhGc0VAEclXhhlx8p6ONh2
 8lBIYY8qdC2hWvt8KZx6M87TF0XdJO7Fe0A/qkc0enaLQeT80E0ksS4FLtJAg4FuREoo00vuf7E
 3DHzbmZtuIR4T7PTOB5ls4bTqqIRmfnMD84s1tK2ZByTGmLsMmHhaY8A4STjoGcHVWsIE+nSrH7
 BbraKbo+1X5YPckSSAWBkwmrZYMSV0sVb7fWDF30kycylon9UH3Qv0JBrR/jphs2aXHQ==
X-Received: by 2002:a05:600c:1989:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-483a94c99admr129135765e9.9.1771797933230; 
 Sun, 22 Feb 2026 14:05:33 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9fb2sm15336387f8f.1.2026.02.22.14.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Feb 2026 14:05:32 -0800 (PST)
Message-ID: <d0040a90-60ed-48df-90e7-3c882072f8b8@linaro.org>
Date: Sun, 22 Feb 2026 23:05:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: mark eth_header, udp_header, tcp_header as
 QEMU_PACKED
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212140917.1443253-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/2/26 15:09, Peter Maydell wrote:

> Peter Maydell (5):
>    hw/net/rocker: Don't keep pointer to h_proto as uint16_t* in
>      OfDpaFlowPktFields
>    hw/net/rocker: Don't assume h_proto is aligned in eth_strip_vlan_ex()
>    net: mark struct eth_header as QEMU_PACKED
>    net: mark struct udp_header as QEMU_PACKED
>    net: mark struct tcp_header as QEMU_PACKED

Jason, yet another sensible series I feel confident enough to queue
via my hw-misc tree.

Regards,

Phil.

