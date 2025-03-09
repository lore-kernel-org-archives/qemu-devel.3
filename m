Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0A6C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trLda-0005CV-Vb; Sun, 09 Mar 2025 14:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLdZ-0005CG-A4
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:44:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLdX-0001IG-Bb
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:44:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2930566f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741545869; x=1742150669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XOa/6szbRL/x9pwGkKgEoBcCfTN7Ll7UF7yaYgZwfTk=;
 b=PYX3CLRCyV3VcfWsliLd6s2AngwgipSV42LXmvQnff7qQ4pKdiAY/y8hJLEuJIQuao
 JD1w8PNCl8k+h5rB74rcJASf/IHK3v2CIUQKbNWq2xl6iBhf7p4wHR++L0fNqHscCUmZ
 3Jq/NX6bhU4lkoE0AYUSNcUM+QXwZdvsbZ/AC/XGW/JbFWEx+SvyTWgzJc3q4cddHW6O
 OY7DZvjKRPt07ANNYxATKfxlwf1aOZVaPN26RGG+Ha47s4yeLApy0KLcanHJJoePJsLm
 SDbQ6++kWWiL4UOWvnbMvspMy0RHyAjvI7c4Yl7u7v23hbZNO2qWEUDm8gCU3tfUF+4C
 nVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741545869; x=1742150669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XOa/6szbRL/x9pwGkKgEoBcCfTN7Ll7UF7yaYgZwfTk=;
 b=F/gplMrKHF6ci8UjjI82x+eRCxkftYckG+N9xqYvH74p0AK9TbkyTSkuB7Yi+SNZ+M
 chvIQO67ZC5l5KQ5Yovez3oeDzeYwWFqNMVmNXMs04XUIL1gokzzdTNN9+vALNrSa7PX
 ICr0b6GPgP5mEiLdPp8UsdLMdKLLRv5CdbzIo1j3+ULEDVubaIW6UV0fbAFDmzECWdJB
 +DOFxu1HVGVdaWZwmyPaelT8lUJJhGGse4ij1c8nR+YHy0HPcHYLYcD2jDTGnlNdg58E
 e1uEcrZawc2B94kcD/Pklsnt1PjO08TC+MG8DRIwfgeJFRRfiaGdOL2pvbNGzd88tPVW
 6Emg==
X-Gm-Message-State: AOJu0YzsIKxsjtTlV2kyCwgF1h3vExeXXRaGXYONgrifMVKfk1SwwRSy
 PgvsVR0UWFK9hJF3UjzPwThZr30tOhQSy7VKheMUeJJxgVHLz/kDrTDyzmvPO33yqbqm8KgUZKw
 67Pc=
X-Gm-Gg: ASbGncupjyzr5gNTlo0fRqckTNoXvTDYsgscp7qQl9o7Ve2qpMW0C6HekI8UO00hv7z
 KSIk5IQC1GJe3r+mqlbBP3fVQgyOFrJyd96qjCOhyLQWabmc6ahUFzKsdAytp9pkAUwHpeQFEQE
 KAHO0u6vv70SHc0fXN0bYqdWjailLT4idxhJD/WF6mE5MSeuYubp3UX2rMU5t8UfvZIHh5pcHmJ
 lc/t5/15VbO1CSmqNmHGlzOQn50JAOes0vmcpBNcXDhOSEw+HSrjM9fONl5jJK27ILdox8QyZ1C
 WCl+wDpeB2hYg/vlop79zWeqRyzoK1Cin/S5fNHXpe/29P6gMH15Uy1f6UqNFGJWb0UiWFRw4I1
 RX9lzmcyA5nSt
X-Google-Smtp-Source: AGHT+IFJvu/9gK5bwaHhAlhr3ducWGJOGmU/tH0/f7rOkh+ombKCmLeIktJC83xj/f+ZyNZt4XmYCw==
X-Received: by 2002:adf:a398:0:b0:391:3fa7:bf77 with SMTP id
 ffacd0b85a97d-3913fa7c21dmr2254276f8f.31.1741545869225; 
 Sun, 09 Mar 2025 11:44:29 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm69096135e9.12.2025.03.09.11.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 11:44:28 -0700 (PDT)
Message-ID: <67922a9f-b9fb-42bb-b20a-911502439019@linaro.org>
Date: Sun, 9 Mar 2025 19:44:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240530074544.25444-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530074544.25444-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Cc'ing Pierrick

On 30/5/24 09:45, Philippe Mathieu-Daudé wrote:
> We are trying to unify all qemu-system-FOO to a single binary.
> In order to do that we need to remove QAPI target specific code.
> 
> @dump-skeys is only available on qemu-system-s390x. This series
> rename it as @dump-s390-skey, making it available on other
> binaries. We take care of backward compatibility via deprecation.
> 
> Philippe Mathieu-Daudé (4):
>    hw/s390x: Introduce the @dump-s390-skeys QMP command
>    hw/s390x: Introduce the 'dump_s390_skeys' HMP command
>    hw/s390x: Deprecate the HMP 'dump_skeys' command
>    hw/s390x: Deprecate the QMP @dump-skeys command
> 
>   docs/about/deprecated.rst  |  5 +++++
>   qapi/misc-target.json      |  5 +++++
>   qapi/misc.json             | 18 ++++++++++++++++++
>   include/monitor/hmp.h      |  1 +
>   hw/s390x/s390-skeys-stub.c | 24 ++++++++++++++++++++++++
>   hw/s390x/s390-skeys.c      | 19 +++++++++++++++++--
>   hmp-commands.hx            | 17 +++++++++++++++--
>   hw/s390x/meson.build       |  5 +++++
>   8 files changed, 90 insertions(+), 4 deletions(-)
>   create mode 100644 hw/s390x/s390-skeys-stub.c
> 


