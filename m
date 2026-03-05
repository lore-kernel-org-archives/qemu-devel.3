Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C5F3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBOQ-0001uR-PL; Thu, 05 Mar 2026 11:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBOL-0001sS-4Q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:17:38 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBOJ-00054j-G3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:17:36 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8cbc593a67aso773382985a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727454; x=1773332254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=glBgEqpSJAIJ02AC7FsJ1DIWIfooMnMH2MhY377g8is=;
 b=egIJsVqjwRbcLBII+Ctw5wpyz91IVqQRozO1+LboF1ur+MtqBLpM9IeR2ljJgqxKa/
 7GV3XtVRzUKWs3FwdHeipAVA32+ohorF7N1F+CjHzfaM0jG5VRxvDAFci5SrC7KKnoTE
 jS+9Llna/CbsEwtdgmJK/eJTraSLfupKqy+yhY2KBbkaQe2fkOA0pjKdQDWdaQa3BbCJ
 PfE4hmbER5Js6CgNhV/R1OZVVKymmKK1lK19qHrBMWdT46xoxz0dt0coheowTFFhI4kp
 4OpHhT8cF+js33+RY97JBZBuAzCtmHxwAmznmBA5CV4uYOS5TYqIaBjv8t4S01rsVAGr
 7M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727454; x=1773332254;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=glBgEqpSJAIJ02AC7FsJ1DIWIfooMnMH2MhY377g8is=;
 b=lZFnWAmj8BbnxRLwlaH+2GjVvU8bERL7y+J4HOZJekQgXllAP7lzAhr2pznqXUSelR
 SKNh94nVLFwjR6X9xAlW32IkS9IZXSSmmiURpAYexnjukICVKUctD4kWIEt5ZBDKq6UD
 JIhGxvCKrHkt7W1Z5vysMPvUgd+6+r1NGRl3L1pjiHYnU9MF7NybsogDgDfwoZtsQ7iZ
 +eNgBOd208AitwiB8dlAnlJUgA3v+y2EB0bHfui8Sv1C4bl9NiV/tbrGDMjZWTpCtgI/
 0FKYhkjXBuLF78gg2gtMbWTafVDi/+IZ4O/PUSw2kAde0oc5TMMsP2VTv1NsN8LNBxTW
 yzFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnkEPD1ZPJClLIKdHO7fpyzLMrFWtmKugpNFH6z2J2/Z8/OqJRdDXe4RZKka0hN3RUowP7Gg4r6owc@nongnu.org
X-Gm-Message-State: AOJu0YzfjwqFDtf1vVSvJYLacmoB+mic5/mw+tvbXs7WcVs23RQpAcMX
 sBrpmAX2g3BKgjiVVlXNR5E5K2qndr8D4wdiZxyn7klJsDBZR0zHf8Uez4BFl5OqhVY=
X-Gm-Gg: ATEYQzyM9ysre6qKBe/D+oNgTo6G4V4SxCultsSWUNg6p/VBorKoGDhkscpunpqDTKM
 lTubj0eRqddRlD1Q3jVU5CvQyr3axFF4TQWKkCC0z8sdrKsiVBFjGDrwoShLbb3uSzRS2c95IYY
 AQLe51Lv3YRzdyr/DziUzWpzvIvUi1WbwolH83LBCZuwITf+0CPiyPfwnS62FehJQ9TvJvPyqiX
 qjiJb+a3kr1y+zWIvpfH1S+Er2CnLt1Tvq+lxHclGaxoce7SLAqHNDOq2WSVtEqtfRLxh9yObG9
 hQwPmrqThWkalcCDMPNdkg9tp713+moUB8+cVwlr1aC9ZSWdUiSkLLhK0pgxi/HPy2V1px8SoQL
 Ncb0xLEa8eahvdDhdttn3OiEs5M85zB1XO1OxVX9gZKRvABwXSmOPJUH36bpAE9Sqm9XuTM72h/
 sYDvmMW7HjZxTJ279bQmtBLShWXowKqcFP8aUluclRuHiEPOaVXMcLUIxcbjbIuHrkid2t
X-Received: by 2002:a05:620a:698b:b0:8c6:a2f2:d874 with SMTP id
 af79cd13be357-8cd5af7733emr733880685a.39.1772727453815; 
 Thu, 05 Mar 2026 08:17:33 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72d3casm1942840885a.42.2026.03.05.08.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 08:17:33 -0800 (PST)
Message-ID: <091b791f-b5f6-40a6-a665-c43b26d287e3@linaro.org>
Date: Thu, 5 Mar 2026 08:17:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/plugins/patch: Free read_data in
 patch_hwaddr()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260305161531.1774895-1-peter.maydell@linaro.org>
 <20260305161531.1774895-4-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260305161531.1774895-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72c.google.com
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

On 3/5/26 8:15 AM, Peter Maydell wrote:
> In patch_hwaddr() we allocate a GByteArray for the data we read back
> from the guest; however we forget to free it, and the leak sanitizer
> complains:
> 
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>      #0 0x56c00ad48293 in malloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-x86_64+0x1a9f293) (BuildId: 62e2a7dbe5ff146b2fa14d26e24e443f1967edd9)
>      #1 0x7b3e4cc91ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x7b3e4cc54c12 in g_array_sized_new (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x25c12) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #3 0x7b3e44b06b49 in patch_hwaddr /home/pm215/qemu/build/x86-tgt-san/../../tests/tcg/plugins/patch.c:68:29
> 
> Indirect leak of 16 byte(s) in 1 object(s) allocated from:
>      #0 0x56c00ad486b0 in realloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-x86_64+0x1a9f6b0) (BuildId: 62e2a7dbe5ff146b2fa14d26e24e443f1967edd9)
>      #1 0x7b3e4cc92819 in g_realloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63819) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x7b3e4cc54b36  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x25b36) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #3 0x7b3e4cc55276 in g_array_set_size (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x26276) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #4 0x7b3e4cc55574 in g_byte_array_set_size (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x26574) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #5 0x56c00be2ccc1 in qemu_plugin_read_memory_hwaddr /home/pm215/qemu/build/x86-tgt-san/../../plugins/api.c:524:5
> 
> Mark the variable as g_autoptr(), as we already do in the equivalent
> code in patch_vaddr().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/tcg/plugins/patch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

