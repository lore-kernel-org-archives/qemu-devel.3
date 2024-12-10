Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FEAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxCt-0006B6-80; Tue, 10 Dec 2024 05:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKxCr-0006At-Bp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:11:05 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKxCp-0003yl-I6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:11:04 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43618283d48so1472255e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733825462; x=1734430262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1nhWEYO/AxLPM1TXBswyvX/YeNJD28O9EWFqgjgXjk=;
 b=MkTiiZ147TALIkvrA3X0US236ihMfvbhFYTP4TXcRUL+qpuqDQEamPfgJlwHO+zTcn
 sk4xXTcZaUJUMSonji2u2xBCi6QGuRo5WSlx1PDEEfJ988I4Xa+RbEi+PlHMDrFE2ibl
 veaAmso6yyrT45lw2fJy0oOtsk7IKx8HsEkn1fJzQqEiWtOfoLjcGddq0b6efFvoPGSc
 IHv6i/UFLfK+kkKgsJ8EkApzZTf0nv0myF/yPSRvSZqIYC7xx1UNR1Rs825QyZsenqlG
 Auz4a86f4mDNYUgnooVzidJ7hMFRSiJNUXk+pFHKZvrW9Ct1R63W729f2/7/PNVWhaJA
 +IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733825462; x=1734430262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1nhWEYO/AxLPM1TXBswyvX/YeNJD28O9EWFqgjgXjk=;
 b=wpTjg6vpA/BKPbXs34m4ewNofYhX73jwQHGunBM+q5s6i0LuFBQEo+wlg9FWQPkWap
 BRVjYZ33qrCTIV+51adFpXyAMjXMLmaP0QYLxvq5DqxMSv0zRfKwhZoKYfvpxeJexMDB
 TCeV88vms1jONTp6DjBfgnIINv4dYl2J6S6I3MyLRANFgdidErb0JNfpLNk2CSKRMN4Y
 ykmxOgd3kF+EFPsvK0cTGgozVnh5Euu8hgxLv/sCcU6gk+vEtkaWrPMtAplOq/GF8DQ3
 Ve+do6k/8izez1nnu+u+QgTKrnLOxeAef8W9EBcBI7wlnBETU0gBrfKJHZ9NRLPVMs1b
 8O/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpi7ItgHC76KHefchCTWBErOUThaa5PIwmuUEJCdEqFinpcbSWBwj4bZI/vN546/R1SeQuCG34nNr2@nongnu.org
X-Gm-Message-State: AOJu0Yw3Owp+j5CfPxlB9S/E5/PiWa/vBcEJjjETAMMiZxpRK7FuhSTn
 Qu5lwdClar6te3JQqEiz/MMr2K9bTcp2PsAzZrE6aLEpxJzMShgxtsX/jfv0+lQ=
X-Gm-Gg: ASbGncu//3BuLdVThgIxylazyoLD+47Lv78/vRPM59gr8wlL5q0r4zj1UBp83yXxeYA
 L2gJmr4h2n/wBObn3cU3Qu1+oD0XnwHpn+Ocbu3DRLlsA7UNCj8jdPe9tSbwdljymV+0cXOSLbi
 f88vDNpW+nhEmoK0GssyiJR/+TST1skns/HmcNbrX8rJwljzpWjnxrpuLWvmdg/81VDrpzz+Vdj
 IjctoWHkKYM/ybpmFD34/oEz60+MKvY/yFTkVZZk5b/mB32TDp+nbFkjqjavLAOqty99+pzRYdH
 SVRwF3UNZd2mEGhMOmoDcFbtP2KYepA=
X-Google-Smtp-Source: AGHT+IH2TWO6qCWYg5Ifc8i5opmaQvIekHhkRtLbKOk8bLOgHOpqGsrKWdv+LqY17cBc0vzceAiVOA==
X-Received: by 2002:a05:600c:3ca1:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-434dded743dmr112921385e9.25.1733825461883; 
 Tue, 10 Dec 2024 02:11:01 -0800 (PST)
Received: from [192.168.224.213] (1.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434feb1b30bsm40197025e9.30.2024.12.10.02.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 02:11:01 -0800 (PST)
Message-ID: <1424773d-1e06-4581-bd5b-6b216e4bad5b@linaro.org>
Date: Tue, 10 Dec 2024 11:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-3-pierrick.bouvier@linaro.org>
 <73cdfb51-aef9-4731-914a-7687f988997e@linaro.org>
 <a88854b4-5004-4734-9fc4-6f34eafba5a9@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a88854b4-5004-4734-9fc4-6f34eafba5a9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/12/24 08:52, Thomas Huth wrote:
> On 09/12/2024 21.33, Philippe Mathieu-Daudé wrote:
>> On 28/11/24 21:15, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ...
>>> +For this reason, we disallow usage of bitfields in packed structures 
>>> and in any
>>> +structures which are supposed to exactly match a specific layout in 
>>> guest
>>> +memory. Some existing code may use it, and we carefully ensured the 
>>> layout was
>>> +the one expected.
>>> +
>>> +We also suggest avoiding bitfields even in structures where the exact
>>> +layout does not matter, unless you can show that they provide a 
>>> significant
>>> +memory usage or usability benefit.
>>
>> I don't think we should mention "significant memory usage benefit".
> 
> Why not? That's the point of bitfields, isn't it? Or do you mean it's 
> included in "usability benefit" already?

To not generate a reactance effect :) Developers trying to optimize
memory usage via bit field uses is extremely rare (at least in the
QEMU community).

Anyhow, I don't object to this patch as is.

