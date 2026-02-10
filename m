Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F39E94626
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpbCX-00010y-6e; Mon, 09 Feb 2026 19:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpbCU-00010P-IA
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 19:01:54 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpbCT-00064A-04
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 19:01:54 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2aad1bb5058so2339885ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 16:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770681711; x=1771286511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wxSE1umC0cwB40v2IhEo0OCZVDQ+Sr9vwYOq0ucWta0=;
 b=eQ0s/4lUayHdOnElK8i56cVTQTbPY71pfVa0Hg02cmepOUT/urWJUTBNrTd1MFAGww
 2huXF1gjoplWHAzSxshtZticPckfUGlJFGCqx3mgPLhx9llxh74ZM+1BoMbYiVLo9fc4
 oqPPL59lBDail+BA5Df6aZLl/yIBUykgZk8EGdXoT2INBgIY3jrHYJM5OerOMOsGVMlM
 61fFEPoDYk224po7B9VAFuSyWsp/zlo7Z0T/ytYQAneCPwWGJWjDzd/8JDWRG3LONXmH
 gJ7VNuIEV7nLGlIWHDmADYiQPiNiRrYdmOlNVHdshq1K+C8OS+vpG1KOOnkB+Xsm+gYR
 my8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681711; x=1771286511;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxSE1umC0cwB40v2IhEo0OCZVDQ+Sr9vwYOq0ucWta0=;
 b=TURg14rup4Lee9Wvc0CCSBXoHEcJcA47twb0pNO2sASDxG93lAdCj565XSII9sYXWF
 xmxB5g+Y7+8Xxz2PJnyJvVGiAVS0mY/JCGvYaumi0Jb+2fOzlJC6tXuNGZmldlZnvbvb
 9mnlV4+DcMceEzVt2UXntRYMERcrUW5q8yAHAAjUyL0EXN3l51jutPkUAurmjo5XHMNP
 IKhsHt4M8v0B0WXwfPCrzPIlCh5kuSQmImUEMEWKmoF+90gtur+KEnLrKDf697lJjfen
 g4utLBh2eiDQ7/q2SMCFwr8457o1KOUXVm07m57uN94mlI8t0VvCJoolDtxaJVCTDvcK
 TftA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURjyySLlCXo+e8k9ix4PIBbOxB3L+/ILWieiA56Q0BoRpESeO3A7ueZuZa1tN8ZLRSkbr1r2cw/1ha@nongnu.org
X-Gm-Message-State: AOJu0Yw/uhDD8wPrPmae/PWQkKYlrmvgW3HqBE2lozrKN34uv1/uZWkL
 y/LC162oMhJRsSIp84asifXa4ImDQheYFH342Ody4BlsDqiqPpqO6OuxgZ3yhLpjHek=
X-Gm-Gg: AZuq6aJ6T14kOlvtRfPyc/ntE4fY1GyyPBLfNAsf4NqVKE0QgNLXXTUk2aG2fF6apZK
 cBMCAJHbNY+A+PLrjqoaRe+Xl0tHgWElLIlBF+UIhIEqyWV4p9qIQ62HhW1UquEw/c/SnXrn4X2
 fHMtR8i0O/9+9VlVNfKi83eKUlV5Vudjq+mnmZd2LuhXP3upKwNVEQ3rkhqvUihut4I7xJQlSHK
 mNtqE46Gy0JLbmfawY7sdruhk5iXHnA7W3DsH5mqqsZ+1TAW2ZJpzdBjJbz8Ve8Gk7s9DNv0qf0
 8GudjEwLfsK8+qE79cHxV3NVv258p2Zlm8uTYcRm34lZDTmTQKglW2D47dbWwlfAV5l2gmSw71Z
 SMp23ePqjpCrcKScyj6tBvNDs9K36MuocdhtV7a7T7hAwJ73GedOHodR7s7w6j6wmh24HB601rs
 8ZU+boO88m0TsE98uMDrdaziroNFATZ9cxtJpjLESjZ0vlW4Wwmju764FdBZVNxygvnI04
X-Received: by 2002:a17:902:e890:b0:2aa:d320:e979 with SMTP id
 d9443c01a7336-2aad320ec62mr88475255ad.11.1770681710880; 
 Mon, 09 Feb 2026 16:01:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824416ca5edsm11297065b3a.28.2026.02.09.16.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 16:01:50 -0800 (PST)
Message-ID: <51df2f42-1fbd-42f5-976e-0ec51d06fc4f@linaro.org>
Date: Mon, 9 Feb 2026 16:01:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] target/arm/tcg: duplicate tcg/arith_helper.c and
 tcg/crypto_helper.c between user/system
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
 <20260206042150.912578-7-pierrick.bouvier@linaro.org>
 <6c5eb308-56e6-487a-ad7b-8f0da70ab7cd@linaro.org>
 <e291f290-a188-4106-8648-48d4c464dfed@linaro.org>
 <a6320ab4-7ece-4618-8d73-549df7a34886@linaro.org>
 <c0b0691b-3cef-4ec7-8d68-227420167481@linaro.org>
 <b23e5d00-19cd-4eca-9cff-38ec78f87929@linaro.org>
 <11a09f7d-5274-4ac5-b6f2-90d9490751a4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <11a09f7d-5274-4ac5-b6f2-90d9490751a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/9/26 3:45 PM, Richard Henderson wrote:
> On 2/10/26 04:09, Pierrick Bouvier wrote:
>> Does a simple #define tcg_use_softmmu false/true is enough for you, or do you expect to
>> see proper ifdef blocks in all tcg-target.c.inc?
> 
> Just the #define, so that both paths are always compiled, even if dead-code eliminated.
> 
> 
> r~

Good, thanks.

