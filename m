Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F97C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 22:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rddsS-0008H1-IK; Fri, 23 Feb 2024 17:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdddH-0002AJ-C5
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 17:03:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdddE-0002KT-JE
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 17:03:02 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so10995695ad.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708725778; x=1709330578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gnb5KADM9/0vveYxc+cXc7XU6tL8RQmHf1g+yfBguPM=;
 b=V/8sMWPJs0ZR1lLjL0tuRjCK6Zl8C4XiWvH67+OdzJl4FMEvWRwtuN337ZvFOAe9Wj
 c6R7G/24bzmE6rkuliuWSm162ciy7ieoqFdjYe7JIWkLflkk0Y6Neiwedur5w3hLJW8D
 2vXyLsSFmKpFsKLb7B7J51gV19jX4GIP+DT5LYRURgsby/3B3thwLOQSysiVUpUCdK9w
 KLJjtt8GsuW2l53JV5DvoFG+xszR3bS3zSh1s1BfUVIHZ2uOjYzJid2C+B+uLH8mr4tp
 AV5UayenSC8gGW5luXC7nBvq090EPdgH1o4s08qB7qFCjYQC0V6Ts62JTA/+LN2zVNoW
 0XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708725778; x=1709330578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gnb5KADM9/0vveYxc+cXc7XU6tL8RQmHf1g+yfBguPM=;
 b=dUXTLP3vYfJn/dNmh+A3m7WtJWkukbqXu2Om+oeejgzo3IBh3EfOlhfcVx1inLEma7
 iSxJRaNkPSggL3uf6vc9htnZzBIZU5hYMhe4G9ixpW3UbqxbSYR6y32HZCvKGarKSVVm
 bontjB98OXnzpzac9ozue4f7HRFwM/Y8bSQqdH9CHkoPKiu/JPM14isI8xOEMfgHOkhN
 TqlDrFWz3cV5K46w/RCpt41IJkBeXCj5ErVwCWJc/U8L51D5qDUb0iftNHpLkHe0TKUY
 p/theTiQNUDAATh4xd1xi0d25+PPM92WuHMQM3joeR53gDYDOuHbLDc81Ww726jNQdIn
 nk9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCULLW2CsbH8JkXPG9Jwc70rtZvdc/zmDS3Qhvnd/nbkzxaDrUc9tgnpL+NYDdI3yarQKGUoRP6HUvn6cfHfYRw3KBG4W6E=
X-Gm-Message-State: AOJu0Yz+5WmF42RihZoDmO8sJJQDqM8kI/FJvMDv/anUKZssoGpOICpq
 RJq1QhGfO/0wrxVgSD8QFFfnIsQzyttJ+ItuSNcrcBrDs1FQgCR0OoQ8NvALRI7pXrRD9yi4XcG
 G
X-Google-Smtp-Source: AGHT+IGyFRprTnuklIAo/z3+skxh0ebP22IpciEsn/33jdzQQBA2nH+YQAAG6Y7YahokVd8CnGCJbA==
X-Received: by 2002:a17:902:ec85:b0:1dc:652d:708f with SMTP id
 x5-20020a170902ec8500b001dc652d708fmr1497599plg.15.1708725778129; 
 Fri, 23 Feb 2024 14:02:58 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902e9c600b001d706e373a9sm12052710plk.292.2024.02.23.14.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 14:02:57 -0800 (PST)
Message-ID: <1e5d8d7c-d3e2-41c8-834f-6241f037999c@linaro.org>
Date: Fri, 23 Feb 2024 12:02:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] linux-user: Rewrite target_shmat
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru
References: <20240223030309.458451-1-richard.henderson@linaro.org>
 <20240223030309.458451-4-richard.henderson@linaro.org>
 <jwyuvao4apydvykmsnvacwshdgy3ixv7qvkh4dbxm3jkwgnttw@k4wpaayou7oq>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <jwyuvao4apydvykmsnvacwshdgy3ixv7qvkh4dbxm3jkwgnttw@k4wpaayou7oq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/23/24 01:35, Ilya Leoshkevich wrote:
> On Thu, Feb 22, 2024 at 05:03:09PM -1000, Richard Henderson wrote:
>> Handle combined host and guest alignment requirements.
>> Handle host and guest page size differences.
>> Handle SHM_EXEC.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/115
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/mmap.c | 146 ++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 110 insertions(+), 36 deletions(-)
> 
> [...]
> 
>> -    /* find out the length of the shared memory segment */
>> +    /*
>> +     * Because we can't use host shmat() unless the address is sufficiently
>> +     * aligned for the host, we'll need to check both.
>> +     * TODO: Could be fixed with softmmu.
>> +     */
> 
> Are there any plans to introduce softmmu to qemu-user?

Long-term ones, yes.  There are *so* many places for which emulation doesn't quite work 
unless the host and guest page size match.  There are projects like asan which don't work 
unless the guest has a *very* specific memory layout, which often conflicts with the host.



r~

