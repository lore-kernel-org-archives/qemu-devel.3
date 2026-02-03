Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002E4E8B36C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnOfh-0006Ab-RO; Tue, 03 Feb 2026 17:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnOff-00069h-RL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:14:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnOfe-00036q-Ej
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:14:55 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso51971045e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770156892; x=1770761692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4qItUiTZzWpWYqzKsjQy/Vh3WgSLWmNx1QCwFm3cZe0=;
 b=lr0UciLM+joDYlo4KcPVyQN3EimXdF3zVWaraClE3JLT5Mg1XKopgpWgQ0xYEGRJbt
 nQz3qKQx74iSM/sbI+YXsNuuV4mPuQu8HrrBTtVaMScN4hQdnzG49Y+kL7SngE4RYMUe
 jRuLt8oeDNa0G3IAWYOSPd6GIf9dvkUbmUVj3TSgU2IquYH9MllowiagzZG7vzEcD0Ll
 gYCMv/3LaXmNm7K+iebeWQFJ3pkOyWV2JyNJUntip3LxLBQwTYMi7RAMT0MOeTZ0O9Ul
 FNYIrObb/yeVyIwnk4oNxSs+RQ+KfmLc2U8L5C1zydJmtemsl6oGebcppYwbz/3GVfw+
 Blmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770156892; x=1770761692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qItUiTZzWpWYqzKsjQy/Vh3WgSLWmNx1QCwFm3cZe0=;
 b=Z1rBimAPo7KYWGefjc+IeGv3yL/Z/06XO5yyZJZplaJheAqk1lZO8j9KjI1cMWqtI4
 i3H1jsT5hJat7Ub33BrYtaTcTTmbkTGfV9dW0B08D/Lf9zF0SxQ2tgzNKbSLUvIo9HSj
 gD7mKjX2acwOampHC0koQG8JMOF6zibxN0diMT2BK8tduZqjDvJfHxE3GojDduIoyu/S
 KpygFCHfrdAZKLqsRXJcSUsMy8jfmZwETr3sbIUNV9mcZCLMRBK52pR63kw0WHSrp6if
 oV34R/0wc8L2/+cXjVFxZqsmkIIFy9fhLGovS2BTWnfCO3Kj3pa3UMSGRhtywPAF1sAA
 cl1g==
X-Gm-Message-State: AOJu0Yy+1pCU0TuJmMUnN98iPxN60Zvrxsa13I5zAaPLUNQi01lIhyqM
 XFe1V67+kFRi7X19YkQBBg9sg2YKTbzFTJfN0xhyznOVppf/lXJ4b2TSDsHJ7Zhuz2o=
X-Gm-Gg: AZuq6aL3AdIsGSpLNdPqK2LGxVnG4wMRE4IKhbA0+L29ivrz8U7zqCXYUaPF4NJDA2l
 A1OdojrvSzy0XAq9l+kW2oVkODbJvHUw02q71bVzZnnvE0b8Zm6ACAPYQnqL8ByioN7DOsr4sg8
 zueMELAvmc1jVdwgbdsrUqaNicHmcwrga4yDPBDDBY7KpPi9PateDNzVCwbu+F88RbAPdyMrH7r
 dTGCpFNyPel+/4FMJdcYqNWleJe8d7cKem6phnU4rXhyXO38CR2uGc9JF9r0zur5wmtv+AFqymE
 7RJVSWpAaas5EYMONLNBGtjQVDjUl77oVFhjGiwAT2Mk8cUL5uOw3aQkLo9MicMGq5Se6LeIL52
 Tv+RBFdV82E35g4a4ZcphjAjfZwXU+kARpdl/XMmYw6ma0afG5jolBffCSOzsePSJcwYtHQ91VY
 i+M4EIdMXdCbXYnZ+5n+8mSHIPelFa7GAawmDkIzQRPUmlR5Ush+W5Ag==
X-Received: by 2002:a05:600c:8b88:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-4830e96d623mr13999495e9.20.1770156892262; 
 Tue, 03 Feb 2026 14:14:52 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fe88ad1sm2998785e9.9.2026.02.03.14.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 14:14:51 -0800 (PST)
Message-ID: <6c07e1ec-2fe9-44c1-8eae-2e413bf26eee@linaro.org>
Date: Tue, 3 Feb 2026 23:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] gdbstub: remove the need for goto cleanup
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
 <20260203115201.2387721-4-alex.bennee@linaro.org>
 <CAHhgW4W4YZjWytqFpbEmhfh6cuZJdtCgqi945q5g42SWZDvEUg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAHhgW4W4YZjWytqFpbEmhfh6cuZJdtCgqi945q5g42SWZDvEUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 3/2/26 23:06, Yodel Eldar wrote:
> Hi, Alex
> 
> On Tue, Feb 3, 2026 at 5:51 AM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> We already set a default error reply which we can only overwrite if we
>> successfully follow the chain of checks. Initialise the variables as
>> NULL and use that to gate the construction of the filled out
>> stop/reply packet.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Thanks for the patch: glad to see a goto gone.

It is not yet merged, but should be within the next 2 weeks now.

Thanks for your patience with this workflow!

>> ---
>>   gdbstub/gdbstub.c | 30 +++++++++++++-----------------
>>   1 file changed, 13 insertions(+), 17 deletions(-)

