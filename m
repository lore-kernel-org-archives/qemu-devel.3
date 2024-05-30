Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF67C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjiJ-0008IC-Sw; Thu, 30 May 2024 13:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCjiI-0008I2-DA
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:37:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCjiG-0008U3-NQ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:37:18 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70222db9bf1so1080886b3a.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717090635; x=1717695435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YwWeP+bBjX93xtC0zDYrGUkw77Oa4RzL3MCG0ZBFyYY=;
 b=bCIr5H0dJNLjKimyTJu8LRjo9NJdsB17Y0QfWeMNQ54Nm9rhOiFmOeqYKtEo6cR2WP
 pR439spEurmjzNSdedu0KmcyIIpxG06nKmZDLmpLs7j2SfAGtX83zv/Td7RsWez01AB+
 bLvXdtYFRjdK5ZwsjLoPe9luwFGWLPdfLqaRPPzGvWW07mwae0qVWe1DVhOPe30NReG+
 gTwWzZ0eUuCrsP9ZJQe8cgSlRLVG127dMjprsmfkpQ2nxyPc7RUrCamt8H38OpFZh0Yo
 3d9GEkAXpYZrgwxkL69fwcp2U1UJmQbFp/ybRYSKBW+Q8lv1YKcj0+jpYnmZuYy4/2QY
 yR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717090635; x=1717695435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YwWeP+bBjX93xtC0zDYrGUkw77Oa4RzL3MCG0ZBFyYY=;
 b=ZFi0buWP6iooIvAaWiq3Gu1cPizq++Hj4KJEXanH6vwiysAMIe7EFyDg7SPVfJQb2L
 JKNGiazRmhiToNFLGaa4GrofDZuCP7bj2O/fas3nHu6KRmonNkG3rdpckYAgc/mzjpxS
 DRoc4ggfeJxMCj0cgyJY8beIHokaPy+Lrk6JwHf/fOy4hDmbNYHqBVa1pooHXfQgMV2n
 Hsb367Y8pW5LWpuG//GgrrIMI36oeBYBYOxmWD/cYzYT9BggpMCOAo2lgAv1hCYR34cc
 FiKXQRgmSkuROJm5jCYXdk8E95sdJaGflz2YwP/qUSIn5+8/3M2PVT5b8Cb6wYCJhDAJ
 BXJA==
X-Gm-Message-State: AOJu0Yxj4g+9ckrDxRcpAgXAd4usDrCcjGfBnWdl7sJsz29uw6Adn9zF
 qupZZj1OyLvq+pRDR9MIrM7ue8kwtQYQqacP+vh/2hsTkbNS5iezbjczFQDjkH0=
X-Google-Smtp-Source: AGHT+IGtiexcyYU6S9P83OkhvV8oaM2TsfdMSWJZoO5BikZRA1ke1hqI0u3ILt2qfeXtCUN0sfNxSQ==
X-Received: by 2002:aa7:9306:0:b0:6ed:d164:3433 with SMTP id
 d2e1a72fcca58-702311344b2mr2967843b3a.14.1717090634590; 
 Thu, 30 May 2024 10:37:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b0914dsm12002b3a.179.2024.05.30.10.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 10:37:14 -0700 (PDT)
Message-ID: <c24794ec-cef2-4963-8161-5a1ad63c7a7c@linaro.org>
Date: Thu, 30 May 2024 10:37:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RISU v2 05/13] risugen: Be explicit about print
 destinations
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-6-richard.henderson@linaro.org>
 <CAFEAcA83_tyi+mwffuM18LSiUjXksgyO7P-oyZrAo8Bup6ZJGg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA83_tyi+mwffuM18LSiUjXksgyO7P-oyZrAo8Bup6ZJGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/30/24 05:51, Peter Maydell wrote:
>> @@ -87,13 +87,13 @@ sub progress_update($)
>>       my $barlen = int($proglen * $done / $progmax);
>>       if ($barlen != $lastprog) {
>>           $lastprog = $barlen;
>> -        print "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
>> +        print STDOUT "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
>>       }
>>   }
>>
>>   sub progress_end()
>>   {
>> -    print "[" . "-" x $proglen . "]\n";
>> +    print STDOUT "[" . "-" x $proglen . "]\n";
>>       $| = 0;
>>   }
> 
> These are the progress-bar indicators -- shouldn't they go to STDERR,
> not STDOUT, if we're going to be careful about where we send output?

Why?  I would think that only errors would go do stderr...

> 
>> @@ -163,20 +163,20 @@ sub dump_insn_details($$)
>>   {
>>       # Dump the instruction details for one insn
>>       my ($insn, $rec) = @_;
>> -    print "insn $insn: ";
>> +    print STDOUT "insn $insn: ";
>>       my $insnwidth = $rec->{width};
>>       my $fixedbits = $rec->{fixedbits};
>>       my $fixedbitmask = $rec->{fixedbitmask};
>>       my $constraint = $rec->{blocks}{"constraints"};
>> -    print sprintf(" insnwidth %d fixedbits %08x mask %08x ", $insnwidth, $fixedbits, $fixedbitmask);
>> +    print STDOUT sprintf(" insnwidth %d fixedbits %08x mask %08x ", $insnwidth, $fixedbits, $fixedbitmask);
>>       if (defined $constraint) {
>> -        print "constraint $constraint ";
>> +        print STDOUT "constraint $constraint ";
>>       }
>>       for my $tuple (@{ $rec->{fields} }) {
>>           my ($var, $pos, $mask) = @$tuple;
>> -        print "($var, $pos, " . sprintf("%08x", $mask) . ") ";
>> +        print STDOUT "($var, $pos, " . sprintf("%08x", $mask) . ") ";
>>       }
>> -    print "\n";
>> +    print STDOUT "\n";
>>   }
> 
> As a debug-print helper routine maybe this should be STDERR too?

Likewise?


r~


