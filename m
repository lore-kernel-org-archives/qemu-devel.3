Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933A9FD88CC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06PS-0004un-L9; Tue, 10 Mar 2026 19:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w06PQ-0004kO-BE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:40 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w06PO-0000HY-OK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:40 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-50904a8f421so33497181cf.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184957; x=1773789757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw+8QgDCYV0/GtTQTC2i5YIQgvEUmwa1akmN337tICc=;
 b=ureWnlzTV3yhO3lvzMinycm9kcqtsFLm1aUrkSz3JmmdkaHr99NOjPz9ny9q8PShUL
 xV8dUQun1HMn7lRWgDw/W6siebaIG239tCg5dNuLDeqSetkmimqxveMPxsQtRlaEWElB
 1AgvEQhcekNS+HQ4ee/93lRg7072L8N95C99iy/XMSQESH5uyVEo8iXcTfzsuiGdtTN5
 v3Xqau2IiIWFCFUazxpuMH1K8F24k8JT7g8o3pPIpqmRqKgZvGhEixaBxPuz1x3Mq2w5
 xmP3gzHh6HZ5IhaTTMJOArQI9lhrcrMfpWqQJBCVxWRZn1dTyqktvN4oXOXOkjnIytkp
 4s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184957; x=1773789757;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw+8QgDCYV0/GtTQTC2i5YIQgvEUmwa1akmN337tICc=;
 b=t4UXBvguBidDRiLwKMFg9aoOIuvtLFRsObPrX/fbVpnLikxTgKnba2QdcbbtPnZ09m
 1hNDHoK+9uBAGmucqKjYCsndYhv/N2C4ZkdXwWKbPGg4xNJ1rQ5M7vAmIYAEBySMhQKs
 sBVKaIwuU5McG/mVrgonF4fn7q3s7JZOSkNlEu/Q5xzV0SDTtvw3T/YIIK7LLoiPLNqV
 +dpUjA3hQFQyKXnvZQ9qoo96ImeDmzSzOWRg8M+Xz9Kal7xiqgT/0nSzl1iSsR76LTRx
 mDLOrfRbyWKi5t0tmjK/z2UDJ4GP82f+S1m6nSD0aOVSjBNPwmM6KPkf/7Mo4BcQROCt
 n3bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjfrb0iwdXPYVtFT+FuwdkW2TNPJSk7sBLUy0CRwiSaPPds3uRip53kIHDNxWlMqNYY4lpbSzTkxFV@nongnu.org
X-Gm-Message-State: AOJu0YwKR3ZsWK+pSGsZP51NCvxqmK/MrBksKTaBWOJLqYvFywtUjRB/
 4V3A2cKqpJv9M6KLnjJYwuAeSGJophfVDuKa28h2dRIPikX37LWdsTscSW6+L7/R+b4=
X-Gm-Gg: ATEYQzyrzffyqfHc/xIyedENdtihyIstyRePextTrAI4puyPSwrYqnm5llmm7daZ5pa
 yikW83QfJ8Xhr0uW4OGilZrtv0eNOS6M/SOFpSYsR8NDsGBmD0DgiZlKogMWduHBJlAiS2nxfgV
 92Fs/rabH2lqDfLzlHo533EzvhllD8BMrFrjXUuls4rRuLWQXFmqytee0a3+BiuaDFUEQtoV8ML
 RHQHQLnjdYiWCmcWSpZy2/2xypaQyt4ULMERL9jofPQzlurVPNdhpjX70X0s++ypcpZS7IqeJB+
 ov5+49rQj2oP4DkKLcvWs38p/xaAlx4U5KhHc7+1P/1xKQirXxYcU0UaFZct+UuSbSyOLsdf4pz
 GtgSID1mhg2f00+9e0g3jc2YpXmG2krd7rwfE4SDrR5ESb00tMmwanqr/ucTXorzJuSus8XvqrB
 ehJ/jzz4vfmxcITU7jTY+d55rBHegTla3BrmP7yNj+N+avEdGdwcz2514pPhLqtARNUDmV
X-Received: by 2002:ac8:57cc:0:b0:509:25da:22cf with SMTP id
 d75a77b69052e-5093a21e7c9mr5471911cf.76.1773184957393; 
 Tue, 10 Mar 2026 16:22:37 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5093a1192d7sm2256841cf.26.2026.03.10.16.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 16:22:36 -0700 (PDT)
Message-ID: <97506340-18a4-4691-8017-110ab2fc76b8@linaro.org>
Date: Tue, 10 Mar 2026 16:22:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
 <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
 <7e6cdb4b-4cb8-4968-acce-56db2f0ee307@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7e6cdb4b-4cb8-4968-acce-56db2f0ee307@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x833.google.com
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

On 3/10/26 4:07 PM, Philippe Mathieu-Daudé wrote:
> On 10/3/26 23:33, Philippe Mathieu-Daudé wrote:
>> On 6/3/26 17:17, Alex Bennée wrote:
>>> This allows the gdb integration tests to be run as well.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
>>>    tests/lcitool/refresh                                 | 1 +
>>>    2 files changed, 2 insertions(+)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I'm getting:
> 
> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
> address 0x45001fff
> Error occurred in Python: Cannot access memory at address 0x45001fff
> qemu-hppa: QEMU: Terminated via GDBstub
> make[1]: ***
> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
> run-gdbstub-prot-none] Error 1
> make[1]: *** Waiting for unfinished jobs....
> qemu-hppa: QEMU: Terminated via GDBstub
> warning: Could not load shared library symbols for linux-vdso32.so.1.
> Do you need "set solib-search-path" or "set sysroot"?
> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
> run-tcg-tests-hppa-linux-user] Error 2
> 

To add more information, we tested it on GitHub, our machines and 
GitLab, and for an unknown reason, it only fails on GitLab runners.

Which is unfortunate since it is where QEMU run its CI.

Regards,
Pierrick

