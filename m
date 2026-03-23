Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD06EC01B4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bhb-0006fE-7b; Mon, 23 Mar 2026 05:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bhV-0006en-Cz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:35:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bhT-0008K3-Kx
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:35:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso23178865e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774258553; x=1774863353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fiiZIwMzq8PY86YSknlnPOVO2MTWQcM+SlqeNiROp1g=;
 b=UJqEq2BUexYfkCgFEby3kA56XkE5Jjqifqlt1ZCWl7pKJTa2Aw3JJBHA6M+lRCXMn7
 WpVDmnMvtKGZ0KEj32a4TxzL1K/zR6+eIECCewYshquJBPy/X48of0J7+LuZeZmdqGLg
 5VP8sP9vGzEBNCAbEmpFKw84J3zBG9fLyXppKEQvloxGTEXN4t07juDOcakZLDtP9E1i
 FLU1TyIrRjgLY+2xT9xC4GySzQ5JQjxrCVovoeKlgrxL7vc7T0CE7Eaq4mgAN7iH+Ouj
 eqekMpb56RvSFkhnwdcP14dMXjZDphhU8QOOlX0JnaykaRMcDgc2/xCX5ypF9CtUxomO
 4Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774258553; x=1774863353;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fiiZIwMzq8PY86YSknlnPOVO2MTWQcM+SlqeNiROp1g=;
 b=rIbBPv5CJZi4z1DtyIQiH/O6ej/vor9eg+N3s+JQewmBH5EHnQ8ygzWk9LRFzfc4TD
 3YPFTMgCWBsGmOYk1IkRLy5y/JB/xM88aocj20hYokOWweENMJjGbtHdbCmnsVpcWiNE
 W8ZM+M5OUC4GH9iGNynI3HhVftJlt8IWS+ZxyHLlFjVCAwtcuAQFAnv0SO8Vhfg/Dvtm
 d/iXI4gzfj9+F5lWVG1eBY8cPo4YYV1dHsW8r05n7rVL0BYYOil2rGG3HcA7H6J5aPk3
 BmP4A+CS03O9iVTF5zZKlUrD/S0ZENSlKTpJGJXC29FhYc3kYWUSC7+rg+OA9Hz0Y+0e
 o8hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu9vN7S6NnlfpumAF0zW2sGOwD1zuGU1EcSVYKH0iQfQElb0E9TFt3jQqV8yKxjoC17eY12268ef4k@nongnu.org
X-Gm-Message-State: AOJu0YyKa9zZc42+LjWU1IwHuhWBV4KL1a0YKwS+UeNjbbDmnVyGikVV
 Y7vlQSfJ6LXuZ1n7RiNi+Gi/6ik5yDBEAT8vnOkg77ABllDlVbotb38t7/tkx0Q0lpA=
X-Gm-Gg: ATEYQzyHU7jV7RRFJgN7/O3dCE8l1U9S1DNPtaBLZivIV0AIknzXJeZ61jkBXE3prGz
 yteCf/ehijanxVGVhgHLPFi4DaFNjLnlr9/jmFFCeJfD/1fZCFqtZ699Ko46BMi2yJyTaxp9Bb+
 BZ7zL1CqIAW1ovI/ZStA0t6W67Rp7azRK6Hgo8MHUb6ui/tcqP5FrzaQ4EYzzVV0+fsdimYglpE
 wIH5JR78Vx3TXdvzRXaru/4phwKA1JnfURTW2VszvmoAKmrYZGa5G5yxwz5Gaq1CVcnha0akUor
 TxMD9eLC3p/DRCRgfAV9MwJhG6o+R96cUQZNBSpJ2HYtCM4B+DFhRcxkwkPN4hhRF1UuPegvUQQ
 6BYsnQ44ULnrDMpyogQdi9ECsnaqecG9AsU/mhjPDGE18tBSS8DGG3/zEk4vIcbqfKSgxOY4zJ/
 v8udUQNoooiysAXt5ZQGIgYjC9x/53zH44649bp4SKIZKx1v4ZWogOq89NHdwt63b8TA==
X-Received: by 2002:a05:600d:4:b0:485:34a2:919e with SMTP id
 5b1f17b1804b1-486ff02af67mr127357835e9.33.1774258553344; 
 Mon, 23 Mar 2026 02:35:53 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1db3absm74462385e9.36.2026.03.23.02.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:35:52 -0700 (PDT)
Message-ID: <e9df395a-388e-4ba5-8b24-268b0e91c06f@linaro.org>
Date: Mon, 23 Mar 2026 10:35:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Monitor address printing
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
 <32d3d036-77dd-414e-9cf5-45044c98069f@linaro.org>
In-Reply-To: <32d3d036-77dd-414e-9cf5-45044c98069f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/3/26 10:00, Philippe Mathieu-Daudé wrote:
> On 23/3/26 00:38, BALATON Zoltan wrote:
>> Hello,
>>
>> Noticed that now addresses are printed with a lot of leading zeros in 
>> monitor:
>>
>> $ qemu-system-ppc -monitor stdio -S
>> QEMU 10.2.90 monitor - type 'help' for more information
>> (qemu) x/x 0
>> 0000000000000000000000000000000000000000000000000000000000000000: 
>> 0x00000000
>> (qemu) x/x 0xfff00000
>> 00000000000000000000000000000000000000000000000000000000fff00000: 
>> 0x60000000
> 
> Likely commit 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr
> argument in memory_dump()").
> 

Thanks for the report, I'll post a patch with a fix similar to:

-- >8 --
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bad034937a9..59d49b00f7b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -537,9 +537,11 @@ static void memory_dump(Monitor *mon, int count, 
int format, int wsize,
      uint8_t buf[16];
      uint64_t v;
      CPUState *cs = mon_get_cpu(mon);
-    const unsigned int addr_width = is_physical ? 8 : 
(target_long_bits() * 2);
+    const unsigned int addr_width = is_physical ? 8 : 
(target_long_bits() / 4);
      const bool big_endian = target_big_endian();
---

