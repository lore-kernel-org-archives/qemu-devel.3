Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6609C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMmzu-0002bV-06; Thu, 27 Jun 2024 07:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMmzc-0002Zt-CQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:08:54 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMmzW-0003hh-9j
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:08:44 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50aso65481041fa.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719486515; x=1720091315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o2XCYxT40DbL9y2Narcb3mT+cwq7XXW09HIX9xIHGkM=;
 b=ozyMosVnRpLhpI/6fptgBLRtkuy+9dr76ERSC8XSxZmcDxaiLhUc0SC+HMlu3T8B39
 YWHsP6jHO3IIc0TxqZNb76MN1UmF7rCl03gvMMFxja5WlizekoMRmA9uRtwMGaHPtbIN
 34/qR25p+CG5NtAQV3zvlbsOi1acmILpTZRrz+O2xWzFReoSnGsREXV5IEOfBCouJFYu
 4HpxEPnyUw8IIM0CHIrg+s/GWF10M2PuKRJolQd1BlBvXexrf9BtbzM++czK/bF5nOXd
 aL7L6M1exO5Xutj7/1hHGfg9DUb0bZXHIchhOMoG7VXttnXo43/qeabTuRTqD9pXJGr4
 zhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719486515; x=1720091315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2XCYxT40DbL9y2Narcb3mT+cwq7XXW09HIX9xIHGkM=;
 b=wbotkwSAJV8FCcNjsB2BYG3opT0OVGrP0NZulBpMTUUJWh9CMk32cwJK7c3UF3vG6s
 BkULlQ7sm1PjOf1C+C+tf1q03kd+aQblfwTUJIF8Xcbv3RbkNF5oti9/Xx1HktTTYwy3
 Te/1ve9z1EpqMw0BZXi1MpY1cBaBuIEcagY6DRAzQ90fXOoFMgJ2YLkhqjSACq4dBt/0
 JX2xpUmrPrddq8obwmiUXAZzAm6vSH9UaTUrf2UpdR5L7FaOWF9rpLuYbm4ma7nUlRt3
 KOUcSgCkVvA4fqwreIvSsn5XPyljjbRDGw53Q9S+SRMeYS/ABh1fuq/pVHmszIF248aV
 jRDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0b3St8k6EmQm7wYHRX6mcBy3AmUlPLK72Ao0NuZn4tiufPX1Vc1BqcE6cxYYKnkc2RAKoBaK0EIzqLZTxP3kfgpP+VbU=
X-Gm-Message-State: AOJu0YwkuXKl1HLJ4DiDnFX0piG2yF4VruZ1yLfXAXItDxAhfverIbmw
 QoeNxtQpQ2aKBXsWDFjsKvyVPpy81iMeq8i3WYzvHqIxoo+j+RyrkPQW5M+oZKY=
X-Google-Smtp-Source: AGHT+IFcbK8snw1UpZCkkK/fbYRXItddDuleNKKncMy49sWuS783EwY8WSMh1pgnqOSBF3yKu88L8A==
X-Received: by 2002:a2e:a442:0:b0:2ec:5019:8fa4 with SMTP id
 38308e7fff4ca-2ec7278a341mr44327031fa.49.1719486514989; 
 Thu, 27 Jun 2024 04:08:34 -0700 (PDT)
Received: from [192.168.236.175] (72.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8245da9sm61189205e9.1.2024.06.27.04.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 04:08:34 -0700 (PDT)
Message-ID: <43547a69-1caa-474b-96b9-e76b65100f9b@linaro.org>
Date: Thu, 27 Jun 2024 13:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] sysemu: generalise qtest_warp_clock as
 qemu_clock_advance_virtual_time
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
 <20240620152220.2192768-7-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620152220.2192768-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 20/6/24 17:22, Alex Bennée wrote:
> Move the key functionality of moving time forward into the clock
> sub-system itself. This will allow us to plumb in time control into
> plugins.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20240530220610.1245424-4-pierrick.bouvier@linaro.org>
> 
> --

@Pierrick:

Use 3 '-' if you want the changelog to be stripped:

---

> v2
>    - use target_ns in docs and signature
> ---
>   include/qemu/timer.h | 15 +++++++++++++++
>   system/qtest.c       | 25 +++----------------------
>   util/qemu-timer.c    | 26 ++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+), 22 deletions(-)


