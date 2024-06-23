Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F58C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 22:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLVNl-0007x4-UD; Sun, 23 Jun 2024 18:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLVNk-0007wb-4C
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:08:20 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLVNi-0007F6-J0
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:08:19 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c8065e1666so2299814a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719180496; x=1719785296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8hEnF5eUoHYPgmkG31WY27sxU3M0+wVBaCBlppE8xpc=;
 b=bFwHDDo3EWIficHgtj/CPiqPKyZHgMn3kJSxVHHCg8dY+HBLvKq7ggzyz/ewO/hDh5
 UPT223B/VgQkk6HGOwyhH4GjpDXOikmVET56UyLRmyz6fdTff+IIrJInbP3Irf+A8Ez1
 6DmLT3bc8pn/eUD+0dORHXdMZqNkqHz3KxZ7q/dKhpxfDGdCNp5BCmlyQFyuE4pu6ZHa
 K5a5Fhm5f4BJZPJ29qMLq2iE3JPsJtUzpk3Koa5Y5sGUs2I5CKwyr6JRkFTnOCHpO2pC
 SKTexpwjE859w2L0UVILQvrNIwLH24BbxQLAxmBXif9p0WZaglgmelh+lK8YjOubMYg+
 Yo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719180496; x=1719785296;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8hEnF5eUoHYPgmkG31WY27sxU3M0+wVBaCBlppE8xpc=;
 b=qh21jzx+knQVWOoX8i+Otu0KoDHbbZx16Kt6OAcheiX5SU6BrJ/Hhm6HTRvmCtt94I
 jbgNED+y7ZByjF8YVbByN1WsxL0F2uPMZ8xqzqsKDIkpm79DMo5CmBS1yMkKMuT6SwD4
 Jd/lynFkCTE1mxT6YWD0HieyaZbEv/muoSqOavCR4mXGWosnME730uFpinSCp6gJHf3L
 tbhYcSdttFTPJK3RzLzLtAuFD5cvgSC10iuLlIRVdV4yy1DE48pUkTGpbsKY/5/vFoqd
 KgBKdxC6aNsAgQND7zEMm1gTHdwgndmq1eiMNFXoSm56u+qkgKdrnGBfZ8laIqDgyUgL
 DDQA==
X-Gm-Message-State: AOJu0Yw91jOBE5aGNccP2F5Uu0BBToE6+txax3qvnuxl6FRjwYIhQOEZ
 bw0n0rl0xcM3VCtHGdFUat5fToPx5x/e4RJgYgrxJe/UdPLj/JQqiidE9HHfdJ0=
X-Google-Smtp-Source: AGHT+IFdQ0hSudckzdGGPTV4hQs8t2se3PENm+CXIzT7RTkDvgV54pAxZlqN6yiOSdzALkeih8B6GA==
X-Received: by 2002:a17:90b:b0b:b0:2c8:53be:fa21 with SMTP id
 98e67ed59e1d1-2c853befb16mr2592825a91.34.1719180496039; 
 Sun, 23 Jun 2024 15:08:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e64ac485sm7298407a91.57.2024.06.23.15.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 15:08:15 -0700 (PDT)
Message-ID: <169b725e-44f4-4fe7-9049-174136c393fb@linaro.org>
Date: Sun, 23 Jun 2024 15:08:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo-aarch64: Add OpenBSD support
From: Richard Henderson <richard.henderson@linaro.org>
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZneEh51XKhxgZKpp@humpty.home.comstyle.com>
 <99682aaf-935a-4986-8832-dd2f2415f4ef@linaro.org>
Content-Language: en-US
In-Reply-To: <99682aaf-935a-4986-8832-dd2f2415f4ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 6/23/24 10:55, Richard Henderson wrote:
> On 6/22/24 19:12, Brad Smith wrote:
>> +    if (sysctl(mib, 2, &isar0, &len, NULL, 0) != -1) {
>> +      if (ID_AA64ISAR0_ATOMIC(isar0) >= ID_AA64ISAR0_ATOMIC_IMPL)
>> +        info |= CPUINFO_LSE;
>> +      if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_BASE)
>> +        info |= CPUINFO_AES;
>> +      if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_PMULL)
>> +        info |= CPUINFO_PMULL;
>> +    }
>> +
>> +    mib[0] = CTL_MACHDEP;
>> +    mib[1] = CPU_ID_AA64PFR1;
>> +    len = sizeof(pfr1);
>> +    if (sysctl(mib, 2, &pfr1, &len, NULL, 0) != -1) {
>> +      if (ID_AA64PFR1_BT(pfr1) >= ID_AA64PFR1_BT_IMPL)
>> +        info |= CPUINFO_BTI;
>> +    }
> 
> Need braces for all of the if's.  Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Fixed braces and queued to tcg-next.


r~


