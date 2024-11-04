Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD1DD1CA03
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85Cl-0000Kt-CF; Mon, 04 Nov 2024 17:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85Ci-0000HM-T0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:05:44 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85Ch-0002Ul-7S
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:05:44 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso3816586b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730757941; x=1731362741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcQzosLcJUq1zXITbHE7EHgkPGEdKTdzfvxpDrX5NO0=;
 b=O5vkb7oGBoC34CdlQr2zh6kZxLWEtGHCw37zjX7fM9XJlL6MDipnW8ECCJATAIpaMh
 QlEXIgILvcz+MLb22hh/QoWvML3QArIb0/xEoy90yi/MUc9S+USzeV254lBHVgmbQzSd
 peNGV1Df5PC6fB5h/0UL3EV+ru7Yh43z/+mkbefIEL5WEaM6Miwkh5ZeYa4K3POlX90Q
 0mQ9npN/hqPl0Bd1iklekeG6j+p+q6TiWeRXEIxYi/UJU40/7o4YUn4mc+hG/KgamgoW
 wAtpiTUldDUym8WA6mrUfiM/pJYVMcSL/Xis8XzIqtsgIMmzy47MwRXEjF75J0iSqo1W
 8r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730757941; x=1731362741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcQzosLcJUq1zXITbHE7EHgkPGEdKTdzfvxpDrX5NO0=;
 b=V9iZ5e2OXJy+TT6+CQjvdE3LDwsELDIAifpXh2D0mpvyGurAlOPh/ESJA6wBf3ybTG
 G2HjIN2EnfKd6Ekjvv0FTvrU+9JpVNVJkf+xFYm9vbF9JCJBg9HU5ErxnMEAvwhit6/z
 OTdJ7dAUhQS1e0KzGAIl78pHqxbXU5sHpBJocGHSzGZxMXTkXc47rpypU4jrP7nufmqi
 3rHiC4TxzKAEy+bbTYUx31DwVlt88KxLeD/jWYvhXm0Cs5j8CTeN+4Yoz/wy0E5MZJI9
 tsBzp/QJpHNnQ3P+mwb3cIrV2r+fEIZGKnExKZfU/AW2KS8foW/xK4E4u1swDRv8LZL7
 t/pQ==
X-Gm-Message-State: AOJu0YzH2P+KBKQvdXOIdo9WG0pT17qF9O+WgIv9PWsrFTZunUFvfzXw
 y935rGfkjOTZ40hPepKHv8TySLwy7G+hJzXroZZ2Mf9YZLCFTVQmcUdPo1vAM80=
X-Google-Smtp-Source: AGHT+IG0z5msHSsGv51nKPFYy/Zhm60s3DqLHOD9u7Yjg5DwXUW4s5iAr+Mhca+AsUiB9UcPYdxIOA==
X-Received: by 2002:a05:6a20:9282:b0:1d9:c615:944e with SMTP id
 adf61e73a8af0-1dba5219032mr15904692637.4.1730757941414; 
 Mon, 04 Nov 2024 14:05:41 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc313b55sm8100429b3a.186.2024.11.04.14.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 14:05:40 -0800 (PST)
Message-ID: <4b1efa1b-b53e-4be2-8682-1acf2359ba7a@linaro.org>
Date: Mon, 4 Nov 2024 14:05:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] docs: add information on how to setup build
 environments
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-13-pierrick.bouvier@linaro.org>
 <CAFEAcA_gNGb4yHvCQf9fOi0gkxn=whVWK8_ztqDBzQ8RcJ-5UA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_gNGb4yHvCQf9fOi0gkxn=whVWK8_ztqDBzQ8RcJ-5UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 11/4/24 07:58, Peter Maydell wrote:
> On Thu, 31 Oct 2024 at 04:07, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> MacOS and Linux are straightforward, but Windows needs a bit more
>> details.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> We have documentation on the wiki currently about how to
> build on various platforms:
> 
> https://wiki.qemu.org/Hosts/Linux
> https://wiki.qemu.org/Hosts/Mac
> https://wiki.qemu.org/Hosts/W32
> 
> I agree that we ought to move this into the main documentation.
> Some of the information in those wiki pages is probably
> out of date, but some of it looks like useful extra detail
> that we could incorporate here.
> 

I noticed that. Is the QEMU wiki considered as "deprecated" (no new 
information there), or more seen as a complement to current manual?

My goal adding this to the documentation was to have a simple (and 
single) "how-to" per platform, instead of trying to cover all the 
possible details and configuration.

Would that be acceptable to add links to the wiki instead of adding all 
information in our documentation?

>> ---
>>   docs/about/build-platforms.rst |   4 +-
>>   docs/devel/build-system.rst    | 100 +++++++++++++++++++++++++++++++++
> 
> I don't think this is the best place to put this information.
> "How do I build from source?" is a question that most beginning
> developers and some end users will have. The information in
> build-system.rst is mostly about the internals of our
> build system and how to modify it, which is a more niche topic.
> 
> I would be inclined to put this in a new file, maybe even
> in docs/about/ rather than docs/devel.
> 

I was not sure, and adding a new file for new developers seems to be the 
best solution. I'll do it.

> thanks
> -- PMM

Thanks

