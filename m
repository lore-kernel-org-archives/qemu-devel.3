Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C767FC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 03:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSqV-0001T7-Im; Tue, 23 Jul 2024 23:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSqU-0001SS-DZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:39:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSqS-0004zO-RS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:39:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so3631905b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721792355; x=1722397155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MwX86XiSvrSMbaVVwsHL6ma4G90RROhSkri1L+buda4=;
 b=OnE4ZMPfU6tt6A3rg5vI91tHzbNIZEiZ6Ybza97KaGVm5V1M0+9eDpGvHOarOWro4V
 3VVUjeXUYL80gKg3uYxrgZZCMlknqQ4Tz2w36GaMlY89qaQPYMd/JFQt6IVLti4eVVDK
 LHUKpahpt4RSAzW4i0kmHQUvKCHDwJUMRQzqUaDVwyOB4eEFED4LaQhM3qPWxABAtg7z
 6t+n8VswAX4/Kd9nbN0qsaTx8lDWVBwm1WrSIxqsToIdsl6yyB6aZZqUNKC6HHQVAQ/K
 s2YW7VRpi735Bafpr+e7+Uic336os4vlzANV/FPjAhoTM0ITFG7G1uUo1rjhg0WgOJkC
 hPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721792355; x=1722397155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MwX86XiSvrSMbaVVwsHL6ma4G90RROhSkri1L+buda4=;
 b=VJok5CAF5LVR46uzS8DdLv3VcS8LBa28jDrb0JN1vu7keD78+l+GzaOVrClYxNRfUw
 48Y3m/S/95yso1/6oG/C9hzkVHyUjIWwdNFnt9vQ58XLa06t1/kvNsvcybJTH5yB4IJ3
 j0ZSMVUMfmw6ohvuiRXTgpRWMs/ONNl4ErM9hxiXN2EC3n6LRI7i9KDNJAZCC+dJ54iU
 gAs+2KQdGkNEAvpvasNx6XV0dRkTOxyA+wjgJdgJ9UFshNU7NBzhRLuFdBzMAZHlRCIH
 GbORl8FYkLRcaWKNGhGV+aVXDC08Zsrh5tXFO8gdPq3gbvV/QMQE7og/wpAv58ofbL0N
 tBqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjjebkKKx450Pp5XY6C+aHIFrRzu1Y3J1cCGGaNqWBkp/B2W8mqH4keAySzL5SWuYe9h5lxn2SiZ2UPXIiET7/btSTLdk=
X-Gm-Message-State: AOJu0YynSFN6xmfU/NWhW/2RXQ3w6nnDtWYbluq946wqyFCySWg2xF7d
 hCodqW4t3+nMvCp9OG/I/iMrTFiyCu/EAS8X601W7+q/1r18r2EKGSbPfW3tHxE=
X-Google-Smtp-Source: AGHT+IG4NjgDcDidp3cxV2YsbaHU7MJudmVgEYwzUvhajeTebc5hP3iHRmWSgrQkpmO8M9wEIw5BgQ==
X-Received: by 2002:a05:6a21:2986:b0:1c2:8e96:f767 with SMTP id
 adf61e73a8af0-1c46197307fmr932012637.31.1721792354692; 
 Tue, 23 Jul 2024 20:39:14 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f44f26esm82872415ad.211.2024.07.23.20.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 20:39:14 -0700 (PDT)
Message-ID: <a90225a0-b945-4bc9-8ddb-e3f595ef0f6c@linaro.org>
Date: Wed, 24 Jul 2024 13:39:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Rework x86 page table walks
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org, berrange@redhat.com
References: <20240723010545.3648706-1-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723010545.3648706-1-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Hi Don.

In addition to the other issues, this really needs to be broken up into many more patches.

Every patch should do *one* thing:

   - Code motion
   - Introduce an API
   - Introduce target-specific support for an API
   - Use an API to implement a monitor command
   - etc

Patch 3, 'Add an "info pg" command ...' attempts to do all of these at once, and so is at 
least 2000 lines too long, which makes the whole thing extraordinarily hard to review.


r~

