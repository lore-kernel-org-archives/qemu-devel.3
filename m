Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08F0C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYRB-0008Ix-7T; Thu, 01 Aug 2024 12:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYR9-0008Ad-5t
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:13:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYR7-0007FO-5W
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:13:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428e3129851so6074885e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722528831; x=1723133631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KAXwL2mhIWfi7sHKoa5OtK/N/I+aT6da9xS5mNjTsvM=;
 b=QgcBa28aZ1CMIL06ckEOVFhGnHGBXRuOjj0PmvCxxnUj/ABuZyN6M99XiD2pCbaVZg
 LkCNHK1bGHQoVy1sdBy5x0JourAeXfgyt+F5QUT+Ezvf4mflbPx8sbN1SansYgO35z0j
 m3/Lr3+ezlZaDOcfJR85+j1NyMNPWmHk1G4D29vqzTXs7pDr5x1pXyXNKNsjjOnlc1lU
 wDLT4yNMSTnhgTYPCUIiJ+132NZCrFHpfMLjGD9cGDEooKptbKNH2leNgAhoiimphc8U
 ywvLJUE+ns8HAP/2eMidi/SHDoGWwKw0qg2/QABtVdPF5+mypCz9GchyjOv0mq5JJtP+
 rgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528831; x=1723133631;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KAXwL2mhIWfi7sHKoa5OtK/N/I+aT6da9xS5mNjTsvM=;
 b=DoTTmWcsB6ztY5hDJFurAcCbqIBOkMAAc5v013G1D+1uvcOlHbhubXOyKaxwbZYBhY
 MeNNdPlLo/wOXf6EWONAk4nAW20b4wVncLkAO/by8Gvi2uQKolQ7/wlCMSIHYgoMWFyM
 w15yyhrTSCi94OYdGqurCk403RV1z9PvDIpJWU3b7TTcrZLn1g16nlfmNAdKh+Qzh8/w
 9b64uq50WX05U46HW1TEVMdMAULa/XuGWGxvVtKEYvbvGMTrDpAT22HUiBcnaaToiQs7
 Ho6OrzXdGrKfWo3PT9OX60hmLt2eSTL2kO9ZK4grFZSejBNxAFIPZk2KZ+mGyP1wCIu0
 J5mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF/PcQx7O7Vvdovg092uQkG+fBMkY+xlDDFsG86OrsxasF7W2dR05AGhAXq8Jzvr1Nqg7yVaKtWRVaghVRKuLvzihJxdw=
X-Gm-Message-State: AOJu0YxZVPiq3JGst9ksr1JkTkQ+i9djq83SFMIfBghCn6kPnjvMIEE3
 qqh73R/4UBlN9jLDa4uZvb39XBzjjes+YzNlP4M5mergaViIqAjlqgMquynSkxw=
X-Google-Smtp-Source: AGHT+IEQ54Yd8VTxMPlSyDD9v2miTnxQjQmIRu0139C4Kssx93UNzgLZx+nLSyk1+qJEhlx99B/WGA==
X-Received: by 2002:a05:600c:35d2:b0:427:ff7a:79e with SMTP id
 5b1f17b1804b1-428e6b08baemr2995335e9.16.1722528831393; 
 Thu, 01 Aug 2024 09:13:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e9c9fdsm1877295e9.41.2024.08.01.09.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:13:50 -0700 (PDT)
Message-ID: <5928c6f5-98af-4853-82d6-ff424e67680c@linaro.org>
Date: Thu, 1 Aug 2024 18:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/24] tests/functional: Convert avocado tests that
 just need a small adjustment
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-8-berrange@redhat.com>
 <66e83689-3b38-43b1-855b-3f4b167f07d5@linaro.org>
Content-Language: en-US
In-Reply-To: <66e83689-3b38-43b1-855b-3f4b167f07d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 31/7/24 14:55, Philippe Mathieu-Daudé wrote:
> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> These simple tests can be converted to stand-alone tests quite easily,
>> e.g. by just setting the machine to 'none' now manually or by adding
>> "-cpu" command line parameters, since we don't support the corresponding
>> avocado tags in the new python test framework.
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/meson.build                  |  6 ++
>>   .../test_info_usernet.py}                     | 11 ++-
>>   .../test_ppc_74xx.py}                         | 74 ++++++++-----------
>>   .../version.py => functional/test_version.py} | 13 ++--
>>   4 files changed, 53 insertions(+), 51 deletions(-)
>>   rename tests/{avocado/info_usernet.py => 
>> functional/test_info_usernet.py} (87%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/version.py => functional/test_version.py} (78%)
>>   mode change 100644 => 100755

> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


