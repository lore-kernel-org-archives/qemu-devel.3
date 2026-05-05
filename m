Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7191BFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDDq-0005N6-Oj; Tue, 05 May 2026 06:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKDDp-0005Mc-Az
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKDDn-0002WM-ID
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777977703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V//fsfMUxv1ZHb3OiX3nESqblOeGIFfGzDhep/Lup5c=;
 b=BECKLgQbc+6xA7GgOmXTeH442HmC6gczkQaPRXyLeUgeEGJFGBnlGw0BhAdOsP/zK2OAKC
 nJQlEjRS0Pk27JQzsNv+sU7C54kpirrBE7rqu4zCNeJ2W0g2BAop0UH5I8IURamoLDaRR+
 BKbTBEmQdfRYjhaa/a+vs8gw3BwYUrw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-0NkZzdgzMPiXO5y6S8-aLQ-1; Tue, 05 May 2026 06:41:42 -0400
X-MC-Unique: 0NkZzdgzMPiXO5y6S8-aLQ-1
X-Mimecast-MFC-AGG-ID: 0NkZzdgzMPiXO5y6S8-aLQ_1777977701
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4411a1f9601so3786091f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777977701; x=1778582501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=V//fsfMUxv1ZHb3OiX3nESqblOeGIFfGzDhep/Lup5c=;
 b=TyZPx05S8H1pSAahqXkhZUIB35wF9sGyEmbpYIT+jjIi9nikAXaIGO6pGXcnm5Q5b8
 cMjCiMujp48HfHb/eBw+WCEY0QM01n+0y2urki0Y5EDje+2eGX0FJ4UqDfQxbJi/WltW
 9O3Hfcr4BcykZ2hEhRmnDafTEWHFVfrBMBELRaidl1Y2EN2GIlLUqTsSdCWxgdXty57c
 uBuFs4F3EOtD5ZqjvEL4KJkmHjK7nudNy6PbiwliNSAt3/KxGQ9XC20S+6TGFjrnw0WF
 jdXmWW6flq1vw13A19ihFuqwaF+SU2NnC39nq88N7oELr4GxOzK6QuAoe5z/AOydARLL
 ck+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977701; x=1778582501;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V//fsfMUxv1ZHb3OiX3nESqblOeGIFfGzDhep/Lup5c=;
 b=nWWQUAMCUWW5w9oepx23bjSnMJKOwsA1XBkP+Hf30F9Fq3GCfD+3+YKiFUveifddLd
 iL663nsBRGdHEothEbvgmK3vlBjsYXMzayur4ttEPQH04jFVVcIG4xGwmuvPr9rarGOr
 9qZaBdRYD1uc1H6l1EURP1XlsIdyVEmPHhPKCLYXpBm0myYxcPSuS20gPBI0qUmw6tLe
 Sg4bb+iJasq15YFrOVjXzHhajmah8f5WCHWak8Gl+b9zs2i1jMthvMHStQiVNTxc1vSK
 zBjm2/vggtHlrzwu+N9T64chhCXZSBKt/6NcRK7Z8FTNc4mp2U9+dwvJxN+Ou59V0Lbb
 a+fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fymwrWPrwSgWE4rQCCzHQSQqrwF7MOpeK3lTuhI98e7AJM6DOge0mMfh9cC3BY8m+SU4ilVpTfRV1@nongnu.org
X-Gm-Message-State: AOJu0YzpgvNjOxZ736+x6A2+g8JaWk5UEv09BXFLprigz/Uj2E2cJVNQ
 YqinK1vfnzM2Q7i3zqcMeIGj9gl6oc3WuvoTdSUZTFrlplbCGSBXz3E14myLs54JmZ9zJGPW3pT
 x3dWih+uAEaQPJjL+lAAtbK7qt07nDb2yUxp+VP0w+nOopAj54X2w8NyF
X-Gm-Gg: AeBDietTbeIExqXvc9+7rtfycaZkUtUIFKwCeqskGt5JeCB0DHBVBUh+XYnyFVpjUyn
 aKCfy35J8yhe+f6o13qDMLTGL8GvLgTiKduxIwZs6Tb830lOJSU4+6C8LT1ix4VCdSH7KX2pCo8
 cyS2Ffz5sYAjxtyEdTPku2Wr1ztY7iDLnjM4UCpQsP1TwgNNInHnOEKZ2RCWYWP5nj9P6YlK8BD
 o25Oee1A8X6H9zx9NExiiSFWO/WExX8IYE9BJtiaiHBu4COPhUW6zEAclFUbIKwrHEN/Bhmo3+V
 +b4MNo99kLDvJrTPFy9uIkaxqkom8E3U6IvjUiIsG3ImTLu8VC5do0bXTDUhyZuGGQn4x6cjNrT
 gZZ8wWsBODlnesOe/6ZmMBYJjxiGeUQ==
X-Received: by 2002:a05:6000:24c3:b0:43d:761d:5423 with SMTP id
 ffacd0b85a97d-450041b05eemr4772900f8f.16.1777977700944; 
 Tue, 05 May 2026 03:41:40 -0700 (PDT)
X-Received: by 2002:a05:6000:24c3:b0:43d:761d:5423 with SMTP id
 ffacd0b85a97d-450041b05eemr4772852f8f.16.1777977700579; 
 Tue, 05 May 2026 03:41:40 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02802sm3530487f8f.17.2026.05.05.03.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 03:41:40 -0700 (PDT)
Message-ID: <d74d057c-f0de-494f-ae13-eae218469620@redhat.com>
Date: Tue, 5 May 2026 12:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ci: drop cirrus MacOS build
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260505103649.68361-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/05/2026 12.36, Alex Bennée wrote:
> CirrusCI is closing down soon so time to migrate.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/cirrus.yml           | 14 --------------
>   .gitlab-ci.d/cirrus/macos-14.vars | 16 ----------------
>   tests/lcitool/refresh             |  1 -
>   3 files changed, 31 deletions(-)
>   delete mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

Reviewed-by: Thomas Huth <thuth@redhat.com>


