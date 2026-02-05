Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6251EECD981
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1ea-0003E0-Fz; Thu, 05 Feb 2026 10:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1eY-0003Ds-73
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:52:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1eW-0007Y5-NQ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:52:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-480142406b3so9464035e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 07:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770306739; x=1770911539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BG3MeOcj7rfEQSRnsWYkeuAupQEMw9QQNCL71b1+WZg=;
 b=hLIwOeIcTmVmt2yEqKOTHUxe2HIzzwPuUNmCIVlusJ41+1WZsbEeAFKE/D+jJ+6tPw
 K6auOgDdDYv4KeYhLibQOt/lWOdhgbToLBUUpxt73ap3dCbHfK6kLoIEOw4IQ5DGwYH0
 Aiv2+cwUtkzhU0jdQtilSZk5M4r6QahbGQpRrjDup5soWgec0sL3XtC3TBWwLfi4D9ha
 iDnnFQzrNJ7U5TN++EedLUA4ZYE3WUhbVsNSvX2pPwjoKBUr1srSdNKCU3rb24jOyWYp
 efeR92//BwRDnmGwXG/I6ARpBriFVnbcvuRvjWGOAflUcDC469nF0SSMO/bhPC0qIAyY
 l3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770306739; x=1770911539;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BG3MeOcj7rfEQSRnsWYkeuAupQEMw9QQNCL71b1+WZg=;
 b=Di9m+KK7MYXbK1AQoTG1JHkOLu5CJW0hJ5iTAJnAPyYq8sLxdmgMNB2XWlbCpMu2TH
 T9CCRpI+QiK7hyOcO6zZrvSbbXXe5TxXjDmkbCfp8qYGb4NWnnbuqFpUIxQwHRdx0EGU
 ppF9+Xc4ViH+v8IpFxzVCPrQc/H9IIhwd/7GwJzpaBpEe3lgA5sNfamPHRvPVZhMkddr
 Bgny3ET9sP7ubWTiHDWF48v4eQkUyr/P2DdNQ/9C2U5u5FX9pdKY48ft5HX0zsle6yaU
 pyGpa0jSsaHIiylO88Px+XQm/OkY4AY9OM3+WkIcz5M68cy0o3tPqJ48r/ERYl9bh2T7
 6s1g==
X-Gm-Message-State: AOJu0YzuBwLgQEulw5VbMkZ8wGlxt3tTb3H7IxGOy2kaZehj1GPrnv17
 xUlqIPs4zjh0/Vt+4Gmp97qOGQlvPFjeOLnil/b5ZyowfYcFGhx6W5HBXsZZ7Aks0N0=
X-Gm-Gg: AZuq6aIk53Nh6NXY680fsYpK5vnRR5wTVTn/8sL3RNPecLmQeQEw89eAWFtko33LbMm
 0tq6onYSnHE6no4DA70G506iK6utuMnZgMuvm5D6SJZ8GYf0MZ0EgOokTMwIcnYL+elNq28fh3G
 VBNbmPereu8V40aAxVgyIbC19E0YlvyLrZP4ledcbUHhp9tPQ9F5iLmM5GJdNyN+53ukBRKIuLO
 Afe506aQNcURJIdmGHA+9ImJqipkB66Bu/exqSXXm5IVV5orfAC9gfW/jwcjO+/h/+pI6ty72mk
 XcCUzTniwxoyJQOI74fdy+hhIdv/AHr8iTmAXWUTIS3prhyE7kRcLa5HBIstelxy79YdN/wH9IM
 Vpi4ZCm4uFDJYjTMeBcxTmX8CTx55Y4Jd8jo6PIiyrZ1FX4r4GhsjetLnxQQp6bs28jcCkt0IG6
 CkODQR3plFeZ7xQShp8CHsLhTqDTp/J96lQ+Aw8+SaBjt4Hi4ycEzmsg==
X-Received: by 2002:a05:600c:c162:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-4830e988f0amr87658825e9.21.1770306738714; 
 Thu, 05 Feb 2026 07:52:18 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec4a5c6sm70116045e9.2.2026.02.05.07.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 07:52:18 -0800 (PST)
Message-ID: <c576354d-5f22-4f7b-8a31-c34c95fba769@linaro.org>
Date: Thu, 5 Feb 2026 16:52:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/vmmouse: Fix hypercall clobbers
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Justin Forbes <jforbes@fedoraproject.org>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <ae0b8f2c574abe8053e742260c794adcaeda975a.1769110562.git.jpoimboe@kernel.org>
 <479166c0-8135-4c99-a2bb-0532633d384d@linaro.org>
 <pdtkpdg52ijsmoknnuwe2geylnqonm7wvbwh2g77de4vyg6tdx@muqauymjdw5s>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <pdtkpdg52ijsmoknnuwe2geylnqonm7wvbwh2g77de4vyg6tdx@muqauymjdw5s>
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

On 5/2/26 00:20, Josh Poimboeuf wrote:
> On Sun, Feb 01, 2026 at 03:27:46PM +0100, Philippe Mathieu-Daudé wrote:
>>> @@ -221,7 +221,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
>>>    static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>>>    {
>>>        VMMouseState *s = opaque;
>>> -    uint32_t data[6];
>>> +    target_ulong data[6];
>>
>> Could we use uint64_t instead (also in the callees) and let
>> the implicit 32-bit truncation when assigning env->regs[] on
>> 32-bit guests?
> 
> That would work, is there a reason that would be preferable?

In preparation of the long-term heterogeneous emulation project,
we figured the target_ulong should not be used by hardware models.
We are slowly clearing our code base toward this goal.

