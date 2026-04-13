Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34AFF531DD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPyG-000868-Ik; Mon, 13 Apr 2026 18:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPyF-00085r-Ns
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:41:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPyE-0006ht-62
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:41:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so61422185e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776120088; x=1776724888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aZa7rZjq43B69M51AN1yA/VqH1KKkFmmQzwZ934rRlc=;
 b=ccwFdeCYJUtp/EBKxDF/i+4R98AVTg9SvbJCAesq/tpCMGaf99ZA0HOO64h/IKypsA
 wsN5Li5Geu1cQt0CUTa5X0ddOfhv+O0yDL2dhbuRiLB1MYp7VxuyTxIrvf53HW6FYR6v
 ek2MbbiGNP9895ADmqOZlrE5jQAG2ZgtCdvyPKgOx9RXsp+p1F/U6nRH2xpXMLnk6swy
 bt/NAHVhxb/Xd/Byyd5exTCxnuP/GCxWQ0DL3xIYZmD6jv+34AJfsRvRFjEXaw7DN3Nl
 EAngzdVLX0MAnqrL56r+V7Bvs4fJAoy9jlAGBb12Te8DRNZhbWmgXRKcTQ5rvIsA04TD
 V3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776120088; x=1776724888;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aZa7rZjq43B69M51AN1yA/VqH1KKkFmmQzwZ934rRlc=;
 b=J5j3ZqTLLkp+GhJlVBj/iheLuIJGhAMecD1dirgkYuZpBXjKdCqG78OPFnOy58mfuD
 VMOXPC59HJUcsP4yt8KIeUZ94v/7CBxg5XAV/P1FBNthN+Q98irgP4Xxkp1CfwZgUNoy
 FrV5m0kY/gn8GEa2UOw4w6DlK0cB+iHW2rtJ9+fZffyVF6/5R6IsuPe2rnQ8Az2pK4kC
 dQOns8Ukuqp+GE8WmlCz0TfdA4p0H1j3tTZBL/+BAEkLVlGidXLx3vKBWRTdKWzlNIEJ
 bjS4q6UEC49oNrzHL0ZWO6tDTcl58lIFVcfod5Io5JD553YdlYsTP+Ire69EloynE2rp
 df9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RSo7W27V2KbR9frOPR6nLGWLYBzngW0gG3wA7ftoWvL2+Q9BT2qdbLXu580tfvqR1Q7pJnaeeGwzS@nongnu.org
X-Gm-Message-State: AOJu0YztxKk80SLVtKuKoInkDUCbMzGoPv+QDFYtzHPjQz0dLZsD91eQ
 a/aRANh7wu9yKvwg2mk65rrfyp2pGvnxJ8anC/794JAIHXNphTmCYmiTa16sXjPV0w4=
X-Gm-Gg: AeBDiet+3In/TBlIjeVrPDFEy2c1d52jJnUeUprkV9hpIzsU4sk237JBWlGP+65/w5i
 +HRLpcvxvnGLMeYI5tnToh2Ln3NQaE+6S05kMMKvMGT0LO1AjZQXr79/73aIBVvoTt4wGh+PHqT
 l7IPKFxyhAnVl9JJk6Kgd9aEdKHEgaKgm1wvnU1gGF+M9V6NskVAoZA6oZtpscM0wW+M2V7d57F
 SsVZeOemU3XiF5HsDMPdniuIkkgTIdFvvql7IGlmXHeHT5UpSzePyvhH7VJSRIV+HvUZ5TW7x0y
 7T71HHM1P2LyeE92gI8Ba36cT85Zmwo5fEkqUEjRMZgRoFgICCGGgtaTk2tePXV5v9cabbT5noC
 hhR0viefV2fV2iyhFqUUkmETkZLH7z7tQ1xaZ2TrdqFF3kRjDH931DcIl8fzFtmxqVoLY0W0u3I
 fg7na76utQojYwPv9EMxQmH3WuFm7uEOJKb1p83R3tRd4Md2UJk0sS/BKBsemBRBlKsg==
X-Received: by 2002:a05:600c:a11b:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-488d687c06bmr171513215e9.25.1776120088142; 
 Mon, 13 Apr 2026 15:41:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681edd2sm110043685e9.18.2026.04.13.15.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:41:27 -0700 (PDT)
Message-ID: <640ddcc2-f373-4738-8e66-50effe56de4e@linaro.org>
Date: Tue, 14 Apr 2026 00:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>
References: <20260319185203.11799-1-philmd@linaro.org>
 <f0965bf8-b736-4e53-b809-374945f0f48e@linux.ibm.com>
 <63ddd321-067b-4c44-99e1-9c6c0ac60003@linaro.org>
In-Reply-To: <63ddd321-067b-4c44-99e1-9c6c0ac60003@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 21/3/26 16:26, Philippe Mathieu-Daudé wrote:
> On 20/3/26 20:28, Matthew Rosato wrote:
>> On 3/19/26 2:51 PM, Philippe Mathieu-Daudé wrote:
>>> Replace legacy ld/st_phys() by address_space_ld/st()
>>> then lock the target again further legacy API uses.
>>>
>>> Philippe Mathieu-Daudé (5):
>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
>>>    configs/targets: Restrict the legacy ldst_phys() API on s390x target
>>
>> For the series:
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> For good measure I also ran some s390x kvm regression tests, took a 
>> less comprehensive spin with a tcg s390x guest (on s390 host), and 
>> forced a few of these codepaths as a sanity check.

Does that mean we can also add:

   Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

?

> 
> Thank you very much Matthew!
> 


