Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF49D4A605
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeHh-00089T-N6; Fri, 16 Jan 2026 02:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeHe-00085g-Dq
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeHa-0005Vc-Ha
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768548609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JX5h5jnW9stWJi+gMRKoMGKUWNB8Xv/N2ESBj2rkRCs=;
 b=bS8ToD3D6SmWlptd7WimgvpXkFiHyOUttl6NL2z9iW/GNp3rs1DMdj1j/tJsmEFcyEYAxp
 9Q51xiFQGFJD48WXghoSWUEifBadB/ZyXe4vkQtomeSk+COoawDjpgGyegX8TkuNiAVOX3
 ke4BTpoT0QRT7BKDWynnNV/bLp0fptk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-eZfZRLfDMFmU2wCY4WxGbA-1; Fri, 16 Jan 2026 02:30:08 -0500
X-MC-Unique: eZfZRLfDMFmU2wCY4WxGbA-1
X-Mimecast-MFC-AGG-ID: eZfZRLfDMFmU2wCY4WxGbA_1768548607
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b876b03afc5so455904366b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768548607; x=1769153407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JX5h5jnW9stWJi+gMRKoMGKUWNB8Xv/N2ESBj2rkRCs=;
 b=cSlgFv7DoyjmopieEyZQ8szEPNgDbUVd8mK9GypIywoS85S3qWe6TIoG581TYJpnEx
 obF0UNtIryTHRIeoEv3/bZxeS9jBPuAhKq4tPv+mB6AG+OaWUwAzdZ2VwxYE/BXkdNZh
 gTRXetEkr7JkXrSo6gGM/ntSdHyP5XNXNJjbEVTeHzp9eaFSuVvekIjsi2B5MH8szGtK
 Rofj/5YuXPasUJ5IetOoCBeU43B4rfneSU3gJ4D4CAkyDVfQfU+d2hffE58gr5/6DVR/
 VE1VTOgaalHhMvDG4EehrfCykqDwGcfPOVT1fZ3t9KbIm/HZHl0Gb1zBtbH4MUNLCutW
 loWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768548607; x=1769153407;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JX5h5jnW9stWJi+gMRKoMGKUWNB8Xv/N2ESBj2rkRCs=;
 b=ImbIFojmyBzmY7q89CVrXEYIxJOhzhizWFWWeBH5YVLiYkribDyoylWZ50vTG1nNGo
 j+vyuxUnPfiDNToHs1krqH9bhBqvIUsKqJqRQCRX7OrX02VnHlbMEPyX5h43l/SwtIM6
 +ECLp2bvQEyZxtYnQdr5oyAQcLO8bgul6v/YW3wu8/vUSTGMSTVvR67jU/LkIaVYdyDg
 x68F6G4DEwKz3tE/SvWhfZ5woMvlkZoiy3yYT6OnPYinOrBBA2WsBwSAhU3vn+6wjxQo
 /RzZc6Q4sqyYcSseHFoRRIauAmcDgPG80ByKhrQE8lso5NZy0hS7mXUXqsU+/Bv1/owK
 F9Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYqZ9rjsj8MPSwWbp3+ySk7ulPTKGqqvpkp/wJHjJGpMs3MjYUZ/hwVd7pAjjdGOOb5VmFFgF7gUWm@nongnu.org
X-Gm-Message-State: AOJu0Yw4yy3ssHvkl+PT17rOU7Cwpx3JpeVZ60FoeRcUcXGe+O36FidP
 7cRuaIY2lDqVA5gOCmsFkwftx3jOd9K2C61WOhU+h3RkAuSoXLei/742HipaaigRFQ6+0O3xqbo
 FiD2MfszNaaoVTA/CF2pFpnvWb8kY1FtjBK/inHHYxjJ68TkaYCxFIsTs
X-Gm-Gg: AY/fxX4LKOG638m+2TfkAaQCscGHrNu0SegsqhvoYNjeSvbLlQy34jhcgDUW007Vvxp
 lPGUVv7Xg0zDsqv3MbK77dHEnq4WH7552C4B/zwDsaNHU+y3wsgXrUcDPT78yWXmWrsRHDG3IGz
 m2Ki6QVy7GqSWMsXwpPOlkiBFqcox3BHN7Juqj3QUELRMdkCryl5u34TCJBLavKZUnX0NcVNcPF
 Z7LFZ95QIWRpYR3QbGd0SAj4xRl6ReAkzraAWrmkHJC91XAIJZf9cCCDsZR/vUCXTsb+xZWLU9d
 Qn2NYIRbC9pI0gaLrxSkwBvJWTpzfL3pWZCr4xLonfUMmdSkgf4MWkTAHSWX+lzIzutQzq7YVH7
 BAxXGXsU=
X-Received: by 2002:a17:907:7ba5:b0:b87:191f:4f96 with SMTP id
 a640c23a62f3a-b87932557e2mr180744466b.61.1768548606501; 
 Thu, 15 Jan 2026 23:30:06 -0800 (PST)
X-Received: by 2002:a17:907:7ba5:b0:b87:191f:4f96 with SMTP id
 a640c23a62f3a-b87932557e2mr180742666b.61.1768548606156; 
 Thu, 15 Jan 2026 23:30:06 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513ea20sm167256666b.12.2026.01.15.23.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:30:05 -0800 (PST)
Message-ID: <ebc3a7ce-17fa-4468-8a2f-ca70c91df4b9@redhat.com>
Date: Fri, 16 Jan 2026 08:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/58] tcg/i386: Remove TCG_TARGET_REG_BITS tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com,
 pierrick.bouvier@linaro.org, pbonzini@redhat.com, philmd@linaro.org
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-18-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260116033305.51162-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/01/2026 04.32, Richard Henderson wrote:
> We now only support 64-bit code generation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target-has.h      |   8 +-
>   tcg/i386/tcg-target-reg-bits.h |   2 +-
>   tcg/i386/tcg-target.h          |  13 +-
>   tcg/i386/tcg-target.c.inc      | 552 ++++++---------------------------
>   4 files changed, 97 insertions(+), 478 deletions(-)

v2 now looks fine, thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>


