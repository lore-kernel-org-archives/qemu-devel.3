Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B759CFC5EB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syxPa-0001dZ-Ge; Thu, 10 Oct 2024 13:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syxPU-0001dB-Ub
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:57:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syxPT-0006aX-Ct
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:57:12 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e9f98f2147so734575a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728583029; x=1729187829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JlzchucIHSkQoiWmAqvtvT8vIMQTa8p2/7pusd7dRI=;
 b=cunNSpRj+Ae4scY4ZOuvakKHcfnHfXijaQYcJ53uwqYu4f31rTKyaWTBLW3JdRUzmh
 js2STZSGq8XOPVW/9iPNY2BeErX8LATVLJz0WYFuaKEKP7ie926j5GetBH5odCXZyyj1
 aKVD+uznmsbgQwuUcxSPC71yNbJn926Gl1ukyevQ294EbqMCgTM8jQdfd4pl+hVUP4O2
 WcLcH/BrkmlGGlPbhz5bh/cE67bU43CwQV2/+YYBMyms2RiZMr6NavrBPGxvPSWJwE+R
 4EdGzBHWrn7zT5ANTlxO8VlVgudN5qNQ8k7+g5eTv6cgRlXaTwNg/o+rBU63aCOCLi7B
 4PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728583029; x=1729187829;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JlzchucIHSkQoiWmAqvtvT8vIMQTa8p2/7pusd7dRI=;
 b=Q9Eto+8y+S+2a+OruhVfHfCzfK38QyPDnqP8eV0kjFAh5JvQlnaPSGWmdmJ4siv6TH
 Dsp8COkRHeJHTUHaATWryCvNQX+inbyHHReUD9eRdggamNYv4WerA85+OSOdGo4FbPl3
 43/8POuL9GY4DueIhPUoVsJGRkwjRdylyZwNWhjPZYZeqLHLv/O5dQDNtjXyjJ/JjFfd
 l61/2fOlBXI8lh+zmC5+O4GuoqugkXowoU6IPm3tSxTP/bHxyw+dkRMBpqYcPxmGpifR
 KgE8zsY9gHEgqEOA0NbptmavfNQ9qdD8GkXgWM2Lk8mQKf6Vohk9oW1fKx8osZYknOEq
 /cCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbCf7Sg+K5jXKcDtE/ezpBmZkCWAWFNyKUMz18T7a7jgdFQY23iVXzpHM5bAf9mRFZA6z5PDdO/ozZ@nongnu.org
X-Gm-Message-State: AOJu0YzjkBAjG9guYsJTTKIs4lEVjrnWN7Ee6GSVXKtfwNGvfhBTXb0c
 y689xFbC3bAlY9+L1e1gWgyo1TIJD+cRBwDDUY7Gs4P+vMAw33hXF3ziAhniYwk=
X-Google-Smtp-Source: AGHT+IEYH5lbC6qUTixtdya1d9zex10D7WmZnrpmwMZcStGNhOiYKMu1jPWFjFWHZhR23aiPAe+Yaw==
X-Received: by 2002:a05:6a21:1192:b0:1cf:27bf:8e03 with SMTP id
 adf61e73a8af0-1d8a3c1fff6mr10461519637.26.1728583029615; 
 Thu, 10 Oct 2024 10:57:09 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aa93854sm1286118b3a.113.2024.10.10.10.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 10:57:09 -0700 (PDT)
Message-ID: <cfb92ca4-6b2f-4062-9645-a2b6f62e2cf8@linaro.org>
Date: Thu, 10 Oct 2024 10:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] gdbstub: Introduce ldtul_$endian_p() helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20241010175246.15779-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20241010175246.15779-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gMTAvMTAvMjQgMTA6NTIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
bmx5IHVucmV2aWV3ZWQgcGF0Y2hlcyBmcm9tIHYyOg0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzIwMjQxMDA0MTYzMDQyLjg1OTIyLTEtcGhpbG1kQGxpbmFyby5v
cmcvDQo+IA0KPiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAoMik6DQo+ICAgIGV4ZWMvdHN3
YXA6IE1hc3NhZ2UgdGFyZ2V0X25lZWRzX2Jzd2FwKCkgZGVmaW5pdGlvbg0KPiAgICBnZGJz
dHViL2hlbHBlcnM6IEludHJvZHVjZSBsZHR1bF8kZW5kaWFuX3AoKSBoZWxwZXJzDQo+IA0K
PiAgIGluY2x1ZGUvZXhlYy90c3dhcC5oICAgICAgfCAyICstDQo+ICAgaW5jbHVkZS9nZGJz
dHViL2hlbHBlcnMuaCB8IDQgKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KDQpGb3IgdGhlIHNlcmllczoNClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=


