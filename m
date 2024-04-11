Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A67CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 08:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rupcR-0005Q2-LW; Thu, 11 Apr 2024 04:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupcO-0005PT-Ix
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:17:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupcM-0005HX-HK
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:17:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e4266673bbso36618975ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 01:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712823429; x=1713428229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QbyICbgQc6MdWIYxl7YkS7lViiMSn8SHJrY55ezy97k=;
 b=YLBFey/OZvrKAZWtzFhWdlwA/1+se/HSVmKUhQtz1+a8lySyFrj9smbWTEKsm5nXoJ
 wNhZHCqNdrBqHov6iZOZXrp+A/lA/C2I4oDwxLyHEqTNzPqJKKZiV1G8IUYa/qhzR+FL
 Ef89lOgwAYnxJUB/xbomQGMoqNXXCVNtfOBIfzaQlboWejakRwxBCcglmjM6TmDBUn5k
 o/TUmgUPnKIDvbzrRZko3tuMTq94NLscaiTFDw/YyWJHL9fjsmLuYuTj2siJF3OxSN/x
 5km/CdbAorDVKSE1CjHcBflKLY50++g5W3VrhLyaPF+EITC70s0DP0S3Vxg6Z5p73nUk
 1XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712823429; x=1713428229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QbyICbgQc6MdWIYxl7YkS7lViiMSn8SHJrY55ezy97k=;
 b=huKvYDkWnbSDf/yCXu5mar1gmHSDaIz93bQ3u4aXujKec3c4zcwGYwwoxzEtGcd7Dt
 METASFvbtYFIpibZa/2Zk6T8PAagTU43kmWCYqsje/yTJcOVMgnea6jemjRbZ2HB+BFN
 lTvuePcuvvIFBDmnKjkAB/3XXKmrFVoozg3pj8S8VDIVJIOFvNmhIxTTdBlbim6/qtKs
 PQehpbMOpjHdnCKoRvipL6DZelpR8ty8DNHoKH2oQ8x7SG/pJqPdSLht63xpMYK8FvHo
 h4K9RNPZqElFBVvZlp7diXD39EOjcwCJ9OVUV0njkTiD5Fk6/nkesVMOW5ztvXV4LqGc
 Uijg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoyMHleT/eNBF2g5dXa7dmcNoKjcT+W8vcgqM3Zbz6mWKZcnM6cueI7v9mltzAHGj21z3JNImkGfM5qGMn8NgPiVgC/Co=
X-Gm-Message-State: AOJu0YxRJaQWGVOr8j2zTGTwI96N9I/svOQvmRpXIgTIup6Qf4wG2GWw
 Xp1snLhZlISMsmvDHW/1x5rUZw/U2IfIGoD8He1e5mQzIgftDU2wpSxfkFKM368=
X-Google-Smtp-Source: AGHT+IHj2BaGAzrIbJYLKuPYaK9m06G+Yzs/KTNRJjNOZkdj1sb9VoFlQqYxDr1Fb5ERR4gvR3pNmQ==
X-Received: by 2002:a17:902:f68f:b0:1e3:c9f6:c4b with SMTP id
 l15-20020a170902f68f00b001e3c9f60c4bmr5834287plg.10.1712823428967; 
 Thu, 11 Apr 2024 01:17:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a170903245000b001e55d7c5c41sm475855pls.267.2024.04.11.01.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:17:08 -0700 (PDT)
Message-ID: <ebc75323-3297-4fac-acb3-eaedc7dc47fb@linaro.org>
Date: Thu, 11 Apr 2024 01:17:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 18/19] target/i386: split legacy decoder into a
 separate function
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-19-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> Split the bits that have some duplication with disas_insn_new, from
> those that should be the main topic of the conversion.  This is the
> first step towards removing duplicate decoding of prefixes between
> disas_insn and disas_insn_new.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 58 +++++++++++++++++++++++--------------
>   1 file changed, 37 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

