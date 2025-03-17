Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9210CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 06:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4Ey-0004EQ-Ua; Mon, 17 Mar 2025 02:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4EM-00045F-BT
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu4EF-0000SN-G4
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742193935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=781+xg6HnjjABuYPKkMdiErpSv7mzW+5jjzPTMjXV5A=;
 b=iuIZ6V5D+5PeDtibpXL/XwcEEe5ZpEiE2+XkH7G0cyLG7sW40KcBGwYojbHKs3K67+ia/E
 RHGdCCT+03joY8VFOFF7q8zyYJdDGCr1/2BwNKXeClNbSpxJc2g5trLWtl25zfMcoKTfDf
 +5RKRjqiHsiPaTZc7bwQGq+y5LkRmyE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-grSH83RwONmdWHymceas4g-1; Mon, 17 Mar 2025 02:45:31 -0400
X-MC-Unique: grSH83RwONmdWHymceas4g-1
X-Mimecast-MFC-AGG-ID: grSH83RwONmdWHymceas4g_1742193930
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso10362845e9.1
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 23:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742193930; x=1742798730;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=781+xg6HnjjABuYPKkMdiErpSv7mzW+5jjzPTMjXV5A=;
 b=D9w9PZ3qZdLvsushWVr5YDZOqZABQx92RQJKXI4todLW23o2zLglgVmN2vIr4/pYNc
 PJ/9Cq/K3Anlda+m1hcAYEsZHtCk4QXivZWkOFlMJ6y50zew7xmzJLmk0LC/+UmZVaIj
 t6cWTmOC/jU314jHhqZvAUnvcZx6EfURkv48i592wjclYGXIDq+85VW77M6Ra68SKf4e
 g/+fSbOMFIDwM48BmfwcjlzvH/fWWEJa5JMAQghVMuxk8CldK8z1WVCuH2+Wglg4izw7
 lnNl+8AhVrOW64DRsA05HEQIsU07eLpNZXm4/GLSA0V2ZjQPaePfbjC3/BpW8uOGBivd
 iqmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVBWXhzhHFDtuURZM7bEzy4WtGnXpSKTWzdnVzp6/STEaPASxbpYDavYuaeICXH7q5RrlUkNRVjupg@nongnu.org
X-Gm-Message-State: AOJu0Ywu6UuRm3C7gX8zVqZw5UiIAX9AJKAK7LBUN1WCIgH48WWUoIN3
 ghClbiEmguqFdsy24I2GT7NWrjOnC739WZIaMwiZhE8THUTLI0L/4/Oks8xrIsPkv4xfNk20Jen
 hFhJFoxJjZnfrJioY3ACzVjtaS/YQYs3vDDDDBzseF93SoKA7B/PN
X-Gm-Gg: ASbGncsOi3qcxCGa3QxJRB8RLmIvatt4UnKNaN619aMfR6zEwnmpf6JbL6enlr2TMg9
 soMO0s+rD9K0qra6KBSQllm3IdKgIUmIEofmXgNaK3VtDvFERldQeUNCf7Cuu8BCoit6pOBFVY7
 suYrXuZ43pXqFNtMwr7TSk+uelnm/FjUsWarAwkltm7/9Q+6Uilj5YLhzDoaQGmOJ76PDfX5SM9
 JbiEBy7Nqb3TWskIr8KKuqsVVxZHhO4ThRFAynV2krzxoTLGt7QgvNDq3BxUF7mTc7+73VZpmkd
 nU7rlqkvofTsqlfXs9o+cVdaWv20WUoFUQzrBPL+K6/4yBE=
X-Received: by 2002:a05:600c:cc3:b0:43c:ec28:d310 with SMTP id
 5b1f17b1804b1-43d24c80a4bmr83057335e9.10.1742193929988; 
 Sun, 16 Mar 2025 23:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrrjoWMGz/d4vMhlg8yrxlmjbRLDQ/KhTLa5fcedM85iFHsKN1bkBG5jHuvcTiCrHDOEY/Dg==
X-Received: by 2002:a05:600c:cc3:b0:43c:ec28:d310 with SMTP id
 5b1f17b1804b1-43d24c80a4bmr83057265e9.10.1742193929683; 
 Sun, 16 Mar 2025 23:45:29 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffb6292sm96400635e9.1.2025.03.16.23.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 23:45:29 -0700 (PDT)
Message-ID: <de4274eb-999e-48b7-bd52-4c2b2aa86620@redhat.com>
Date: Mon, 17 Mar 2025 07:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_arm_orangepi: rename test class to
 'OrangePiMachine'
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, stefanha@gmail.com
References: <20250316210232.46298-1-nieklinnenbank@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250316210232.46298-1-nieklinnenbank@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/03/2025 22.02, Niek Linnenbank wrote:
> The test class in this file contains all functional test cases
> for testing the Orange Pi PC board. It should be given a name
> matching the Qemu machine it covers.
> 
> This commit sets the test class name to 'OrangePiMachine'.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   tests/functional/test_arm_orangepi.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
> index 18ee50216b..28919391e5 100755
> --- a/tests/functional/test_arm_orangepi.py
> +++ b/tests/functional/test_arm_orangepi.py
> @@ -14,7 +14,7 @@
>   from qemu_test.utils import image_pow2ceil_expand
>   
>   
> -class BananaPiMachine(LinuxKernelTest):
> +class OrangePiMachine(LinuxKernelTest):

D'oh, copy-n-paste bug ...

Fixes: 380f7268b7b ("tests/functional: Convert the OrangePi tests to the 
functional framework")

Reviewed-by: Thomas Huth <thuth@redhat.com>


