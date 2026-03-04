Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3EFEDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxflz-0002RV-QU; Wed, 04 Mar 2026 01:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxflv-0002RM-L6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:31:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxflt-0006EA-Nx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:31:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48371119eacso78530925e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772605908; x=1773210708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FDbF8zS72eIt9AcTW/DeoO98hhUFmOmOdyOOYdakiks=;
 b=wLG1QUvSlQwRuocQDOZSErIg8cXNANP0pDBZrIpYlpL4+3+Asuuh1nsPO33RHKEJ6H
 D0o5XJiSemSb5iCPhl8sZLeNZRSHnBc/ivTutzhha/KAwrxZmGeDHjT+MjxUbrFgqe3l
 I1L+a6U30/DjoVUyuqMSP4qxpEz4eUGGCBeYFuacBoF9p1bVcI0Aks50fCXGywKbM9DB
 fq1SQxNjnE28bNqrMWvZ7CottiIlcjE2yZn/pEIV1e7+ceMZMIJ1USPsrdy9u3YzWyUg
 fdnsRantD6lqP6+LvHRFU3EUL+TK2/EjlEnJZpJIGz9CgFGyaHa1uDSnqouQRCzBdyVF
 SRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772605908; x=1773210708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDbF8zS72eIt9AcTW/DeoO98hhUFmOmOdyOOYdakiks=;
 b=UfoRAddayXP/oJkGwcegfjZOKoWv/ahmUc8/lxqRXRVYlbCc5aPo8Y/5WhgRPTqRum
 wBXKII0qRrGO2zjAnNCsMZZvVZ2/z0wwmfz9gxnvQHsAdzOhg6uL/oZAuDHXgltbQ/XN
 gvy9HWbF6XbpB2utwEJVDSn35TYCzZydIvpnV+QTrLtdl55P421qNgpRt6DMLxLLFGGe
 fTlZ77mAMaSg80y9jkS0WqTx7Jnj6NDU1W9aK9q0GmxHfl+sG6q5c7zMdpy/cqlQdwrE
 3YrpmI4QPNqxQcrcWBCNV17zh/kungoieqqzs4r/ZHW8ewtob5/WjQXY48DbgTEmHFcc
 yWcQ==
X-Gm-Message-State: AOJu0YxqVcozDvsHcb2MyGgb8QZ9PgP64tFJr00waJFvcibDuQWWu0oW
 VaVXObzuGN3s4ybrr3XO1jAvDQ4YRZ6fhu5+84q0w95vSJhCiKuuJhmnuoXjjU8ZxZOV50R5Wsl
 ukuUN+nk=
X-Gm-Gg: ATEYQzyEgSdfjCbhJQ04ChSAnGpoSrw5DK0VkpIbsNDLXZoQaKotsrJAsbqbGX5UUsA
 9VRrhIjruzD52ufBB8LCKMnn8vvukhpyvHzwr6USnUKk4zl/RLRx1//CfoK1IyXjOpQpaUIvRKi
 ykX9jlOQy4hSSv19IzI+s7eUnJFNNiDxBa/lI965Jeovz4G6hkpyshzgKNycsu40PMuLoY7UAIy
 wl9r95XCrvjLgEo/+XICA+E0PhiCVeQRph++e5uq7O2fXiIW4nmj6gpX9M+cLRd6dNwpZQSiCMq
 DXSGz+MdLKTbqRHzhwiWb0qKHB0EDfef5OyYfkKb+RtK3D6uQ37R6cchwBiArZ7eeE+c+qfzbk6
 17xhSmVGyS51UZ7Lh0fdHimr51zuBbL93w6W8TViIF+M/ZH7H2EyqlFqqZPp4u6TTQwSBbV8Hcl
 trG6jcXQ5iXCKSV2Z01li1K80ViVVYg8T0uwb1UoPs2vMVxiIATUmStsDv2u21j7xDRg==
X-Received: by 2002:a05:600c:8b53:b0:483:498f:7963 with SMTP id
 5b1f17b1804b1-4851989024emr12093475e9.26.1772605907471; 
 Tue, 03 Mar 2026 22:31:47 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851884a7absm33103745e9.8.2026.03.03.22.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 22:31:46 -0800 (PST)
Message-ID: <dae98d2b-6e0a-42bc-bfdf-5c33e74cd390@linaro.org>
Date: Wed, 4 Mar 2026 07:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/16] target/alpha: Use explicit little-endian LD/ST API
Content-Language: en-US
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org
References: <20260202212019.94205-1-philmd@linaro.org>
 <20260202212019.94205-3-philmd@linaro.org> <aaRSXzwmZBoRD0e7@gallifrey>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aaRSXzwmZBoRD0e7@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/3/26 15:51, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
>> The Alpha architecture uses little endianness. Directly
> 
> Wasn't there one, odd case of the T3E running it big-endian?
> (I have no idea how that worked in practice).

Richard said it was not necessary to mention it in the code:
https://lore.kernel.org/qemu-devel/20260106155755.53646-7-philmd@linaro.org/
https://lore.kernel.org/qemu-devel/75b13774-93f3-45db-bc1a-5b8687fcb3b9@linaro.org/

I could have mentioned it here in the commit description
for clarity but didn't think about it...

> 
> Dave
> 
>> use the little-endian LD/ST API.
>>
>> Mechanical change running:
>>
>>    $ for a in uw w l q; do \
>>        sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
>>          $(git grep -wlE '(ld|st)u?[wlq]_p' target/alpha/);
>>      done
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20251224160040.88612-2-philmd@linaro.org>
>> ---
>>   target/alpha/helper.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
>> index a9af52a928f..80542cb0665 100644
>> --- a/target/alpha/helper.c
>> +++ b/target/alpha/helper.c
>> @@ -214,17 +214,18 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>>   
>>       pt = env->ptbr;
>>   
>> -    /* TODO: rather than using ldq_phys() to read the page table we should
>> +    /*
>> +     * TODO: rather than using ldq_phys_le() to read the page table we should
>>        * use address_space_ldq() so that we can handle the case when
>>        * the page table read gives a bus fault, rather than ignoring it.
>> -     * For the existing code the zero data that ldq_phys will return for
>> +     * For the existing code the zero data that ldq_phys_le will return for
>>        * an access to invalid memory will result in our treating the page
>>        * table as invalid, which may even be the right behaviour.
>>        */
>>   
>>       /* L1 page table read.  */
>>       index = (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
>> -    L1pte = ldq_phys(cs->as, pt + index*8);
>> +    L1pte = ldq_phys_le(cs->as, pt + index * 8);
>>   
>>       if (unlikely((L1pte & PTE_VALID) == 0)) {
>>           ret = MM_K_TNV;
>> @@ -237,7 +238,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>>   
>>       /* L2 page table read.  */
>>       index = (addr >> (TARGET_PAGE_BITS + 10)) & 0x3ff;
>> -    L2pte = ldq_phys(cs->as, pt + index*8);
>> +    L2pte = ldq_phys_le(cs->as, pt + index * 8);
>>   
>>       if (unlikely((L2pte & PTE_VALID) == 0)) {
>>           ret = MM_K_TNV;
>> @@ -250,7 +251,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>>   
>>       /* L3 page table read.  */
>>       index = (addr >> TARGET_PAGE_BITS) & 0x3ff;
>> -    L3pte = ldq_phys(cs->as, pt + index*8);
>> +    L3pte = ldq_phys_le(cs->as, pt + index * 8);
>>   
>>       phys = L3pte >> 32 << TARGET_PAGE_BITS;
>>       if (unlikely((L3pte & PTE_VALID) == 0)) {
>> -- 
>> 2.52.0
>>
>>


