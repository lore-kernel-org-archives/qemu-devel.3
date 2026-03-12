Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9272FED2F7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ckf-00081a-EY; Thu, 12 Mar 2026 05:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0ckX-00080Q-1A
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:54:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0ckU-00075n-Gs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:54:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439c4a93841so591114f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773309272; x=1773914072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wq/Y6V+EU1rzkkYyxFjrdXfPqNXD+NsvyBEqQ3aovvU=;
 b=eo4wVb2L7JLkk3uoMZvsaB3ql4GDtc8aww0mbvLRhSFc/3Ancn50++5SFpm379h/9G
 VHb161mlev/J4qFEGIYuZi0f8fpSTqOE7n5NNsbo95gcEbtwoSWfSnUvrzkg+WUylox5
 o6nodVAJ/61GE14cl9fM9Ek4HwzuV/TzqL+dyjPFSzCK7zNoKueIX+mSyItu+hAK724R
 6HUkml7rE7VSu5fS8UTcMrZpC79AIJ0NLmimjVNqv/6pgu+e+PKe/ot+qtJXAPLBOcI5
 PAzzKJLDKUa9JZuXmYu8CVD9/Qn5gBPQX6Y86rFDgJO9rdIB8m6zffodD5B3I2JtqwxU
 JK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773309272; x=1773914072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wq/Y6V+EU1rzkkYyxFjrdXfPqNXD+NsvyBEqQ3aovvU=;
 b=SQ/fEol86lsB8AgieO5g/SPLgVPo8tW2i2XcglN2Y0Xg8eibmfqKFqhlZfuFryAbWN
 a5hvED/+X6s0SalxbGFsfgGs1evZUEWvOJyhL1NVVCfCl5yGjg0k0pjt+a1FW9ivUM++
 MezSHwzeQLkZsTaYY3iC5APt4Hb7lCMiCKm2PTxvtjWv3UH1vfnUT/CSeAXig52yrFlb
 9noFCrpdJhijgPH0HiXAgMB0HFKA6kdtCyXHKL0fHNCxmutej/gwPX0YbIqvHoeanST9
 zqnlIxAv5coSqoUb0zUfD37Ivze7FmoNce6og1wWvqW122J/LRX5ned8FXbYlNgz2WQj
 yyxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNY/QsPRZKiYd+ZsvtigyRVNb4v9mcZIFsPkrst3W95YBT2MkTYM0RibC+uaIMuCmuV7KpS0TKToA@nongnu.org
X-Gm-Message-State: AOJu0Yz3/Vihi6ugxoD03HmUKFEvZXpHRC7KB7NnZW1zoOCjoGx9OpUu
 rW0Ev8ZDAqW/dg2aPXLQlfHeuYka+c0OH3uHcj3bETscuq8GzLP6dDL1SsqU15KsZsk=
X-Gm-Gg: ATEYQzxlMh4796eULgRr4O3tJZ7QmS73dnJokIc9I6b1S/D8bchC5CFzo1zd5lZq7dV
 Gz9azIyZh55NgrikKRuRYlP0KRFiiIcxsG9qFRM51Kswdldr73xBiZPu7caQGOl0O/YlKPgeoSH
 W2y5uqsoBbECgClstkcMymXLeWt2RQn5qBddG19LA3iJd/tvL+diNdTMf6gW+vZhZ02uHOkJ89o
 oUeX4rp/Qa7RibJVtD8E799SKwxyCyT964JLd/Wzbj0psrZ77MLNMc8mqJAMrIt2UC3VQdPVkBE
 bI6TCFDyxNL9Qs/FTpsVwv8fivypHLJLaQLGIt9dkz2hUhcHJhlFsE/nuGIc1IudrsVqilUlJLI
 b6ZkZqHoVJmCErWnMJKH8rGyhcJ2PXdI1wp4evSYI3qSm5tlQpCiYGbYEcWprApIGmE2equWBPW
 9WvG5EwCmuGz3rb4ZjyNR1sF5UDFSAydCGvpx68kfphzrFTs7VSAMMyuxBIhALrG8V0Q==
X-Received: by 2002:a05:6000:290f:b0:439:be3e:52fe with SMTP id
 ffacd0b85a97d-439f8209ab1mr10959390f8f.26.1773309272269; 
 Thu, 12 Mar 2026 02:54:32 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe23afc5sm7612598f8f.39.2026.03.12.02.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 02:54:31 -0700 (PDT)
Message-ID: <24455ba7-f1ca-43aa-8e38-7e507c6bc142@linaro.org>
Date: Thu, 12 Mar 2026 10:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] gdbstub: Always infer base register index from GDB
 XML
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
 <6ea61ae5-0a83-4279-8a8b-897a162d54a9@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6ea61ae5-0a83-4279-8a8b-897a162d54a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 11/3/26 02:41, Pierrick Bouvier wrote:
> On 3/10/26 6:38 PM, Pierrick Bouvier wrote:
>> The following changes since commit 
>> ae56950eac7b61b1abf42003329ee0f3ce111711:
>>
>>    Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/ 
>> kraxel/qemu into staging (2026-03-10 13:32:30 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/pbo-linaro/qemu tags/pr-gdbstub-20260310
>>
>> for you to fetch changes up to 6511d4eed79a7e59f03e661f31924277e4d6e600:
>>
>>    gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[] 
>> (2026-03-10 17:12:18 -0700)
>>
>> ----------------------------------------------------------------
>> - [PATCH v4 00/16] gdbstub: Always infer base register index from GDB 
>> (=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>)
>>    Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-1- 
>> philmd@linaro.org
>>
>> ----------------------------------------------------------------
>> Alex Bennée (1):
>>        tests/docker: add gdb-multiarch to all-test-cross
>>
>> Philippe Mathieu-Daudé (15):
>>        tests/tcg: Temporary disable multiarch tests for PPC targets
>>        tests/tcg: Disable prot-none test on GitLab
>>        target/i386/gdbstub: Remove stale comment
>>        meson: Restrict gdbstub to user/system builds
>>        gdbstub: Simplify gdb_init_cpu() logic
>>        gdbstub: Add trace events for around XML parsing / generation
>>        gdbstub: Have scripts/feature_to_c.py generate more verbose output
>>        gdbstub: Make base register explicit in m68k GDB XML files
>>        gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
>>        gdbstub: Emit base_register index in GDBFeature entries
>>        gdbstub: Consider GDBFeature::base_reg in 
>> gdb_register_coprocessor()
>>        tests/tcg: Re-enable disabled multiarch tests for PPC targets
>>        gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
>>        gdbstub: Move gdb-xml/ within gdbstub/
>>        gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]
>>
> Send this PR for Philippe, as it's the last day for soft freeze, and 
> that it's already the middle of the night in his timezone. We tested it 
> together.

Thanks for the help Pierrick!

> 
> This series fixes original issue reported here:
> https://lore.kernel.org/qemu-devel/e44df309- 
> d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> As well, it enables gdbstub tests that were never ran in CI since gdb- 
> multiarch was not installed.
> 
> Regards,
> Pierrick


