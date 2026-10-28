Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75990606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=adegDrG7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1iI-0003JD-M1; Wed, 28 Oct 2026 07:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1iF-0003Is-KZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:20:59 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1iD-0002eR-UQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:20:59 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6df5e315bd1so652242eaf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793186456; x=1793791256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E95xK36R2M8GdKYMzYWA1aqG8ySRMzQA8qwSXXWkaM8=;
 b=adegDrG7RavdHmKkLtdJKQDHeR2AA8tG/u5nRNw+PAN/bm9kSR51zg+RYDCQbii6Cv
 ZdGfZfiNiPViDm73Klml/fjtAWNgp1vI2QDuBm5fUFT33rK9/HCQQJqWCxd1e5lRDZAO
 ywoBR5j0AewWfUFbfhmqzVTDOqO571cgdRhzFmgzTj/TJ3g15x69zxNamNCkMetHjYVw
 8ZDjxnHHaqHvGk/06bW6dt3kiW8XR1KYUYhW+Ws00XfeVfD6OwVOJCUBdktucOQSLBc6
 c0VExeLezWl1IyPk/shglKKQjBf198J0zr8gxHOeStLL1TPtjC8aYu/TO5Q9DT2f+C/X
 W8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186456; x=1793791256;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E95xK36R2M8GdKYMzYWA1aqG8ySRMzQA8qwSXXWkaM8=;
 b=ux12429B0m1XY8oDnasWcx2sMdDB05QQJBnE92USssycEVPHkssRJTXsDw80UL6uEx
 5vq/9MiWgngvJ2pZ77YhID7RY9WWpFHdsyNoLLvajsPZpKDSj1PpOhE5YqBMeI4V4HX7
 6oqFqJ9igkl6Cix7B52Pe5ZjVAqAJR7eue/xRAo3LCMevhHA5RcduAARfO0Ygg3pMSvk
 J3/YMjpE6QKe1SyGOag0G5sriv/xDVzSnoU0jdWybaLr6FQqL9cPcsZh0Qd9nAZ6pKOP
 X1fq92yM8QdQhLiPaO9UveRU7rf7KH+JlizsykNWJACnjcFHLip+1tHH3Mgx7xJ+ldJr
 PICQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPk2UA9DYS9IcZj4vbdBre4N0Dv5GdSCPq/EcA/RuyRlkn9z+dTGfYAdBadFvqRzU79/HSzZGDmXdg@nongnu.org
X-Gm-Message-State: AFq9FYKVOlzRDkR60J7RHmfNKtkSWk7UGAMaSXjIxaQdDYd1sWdnOFnr
 0T0DmeUptBVXeEB6d8nDi9IxZNAm50G1wrLmGyy2CvSQIngnNRFVBDq+zti9iC96Aeo=
X-Gm-Gg: AYBFou1Y+WPLXSShE/6fv1tzJBao4ZamD/E9yVq4dLi1rN+ot0ooT2qbSmxSiNfNzQr
 AyYtmy9w+2gKmjHvquxP2jzVmPTEU6JSBaR2H1Xnbf/anL3QGK990La6283xDZJx9lhnoRHd3bG
 UKxfBPX3ByKz2NmYTW+WHwOX9luPv82HAV2PG2O1ZMErqaxXMj7Df5JMjj20QsBgqe1Vtufd+dV
 dvLK4VJFPBaMfroOT837dcf1+JDo4RASjy9V9JrqdpvT0JqVngrtoqlK0Nm9FSVcUJVecN1DAbr
 f8/f16Unw43+D5/jgZD1xSR5gIxr2iOBIlEokiJUHxmLr2IF64JkEio8PZgKEL97SqWqJWNEI66
 zApLjGJUwD8xMsXbUbFslq4m2yNn1nLbSsQDws0xxX+NhQ508+Uv4aNQzpOlWuhcLsnhx88f9ZJ
 omoDEhChLnXqiTyHkDDV0JjopMiLAWNldbLtxIJ/M0pHsGnj7xtMsJQ4ujkcVxFPuLBt1Xc8x+L
 rlKHCvoMRegC/7sNEU6QxjPbW9VNNOh+R16KLJoeE4RGGmRKqTBrcjv5kOfC7LqyJyK1PGZhuAO
 872XR5tv5TaKxYR7EbIXY5X52752JfhSH8XeZD2RSmWa
X-Received: by 2002:a05:6820:3401:20b0:70b:8831:8c5e with SMTP id
 006d021491bc7-713f19607a5mr689554eaf.51.1793186456103; 
 Wed, 28 Oct 2026 04:20:56 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1d4580b5sm1305051a34.3.2026.10.28.04.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 04:20:55 -0700 (PDT)
Message-ID: <67fb042a-8378-4b81-b945-03914664b45a@linaro.org>
Date: Wed, 28 Oct 2026 06:20:54 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] ppc queue for 2026-10-28
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028052024.38377-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 00:20, Harsh Prateek Bora wrote:
> The following changes since commit d29412cca54899ba87d5ea5d61e8bad7643b15f0:
> 
>    Merge tag 'pull-riscv-to-apply-20261027' ofhttps://github.com/alistair23/qemu into staging (2026-10-27 14:27:13 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-sf-20261028
> 
> for you to fetch changes up to 74e68729ca8ee576bef823798ffc80589b1edd63:
> 
>    spapr-vscsi: clamp adapter info DMA write length to struct size (2026-10-28 10:45:51 +0530)
> 
> ----------------------------------------------------------------
> ppc queue for 2026-10-28
> - Misc fixes and func test improvements.

Applied, thanks.

r~

