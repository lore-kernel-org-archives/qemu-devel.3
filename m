Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C25D1CA05
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85b7-0002hx-7R; Mon, 04 Nov 2024 17:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85b6-0002gy-0C
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:30:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85b4-0004tx-JV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:30:55 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c8b557f91so49158905ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730759453; x=1731364253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vIKJ8bKdIDwGrlD1NH/uLJjFcKs3RcVYir4XOYA+m/M=;
 b=QOe1T8MOTLwoNHUcikGK9PPnBH5HfNvZSnuMA9NU789o9Wxl6LF1Z3JwUCoztsJaOT
 S9MTDYSjrnaN21kRS6pXF0be+FDmNSAJ1E77llQb6Dc6v+r0/+Kdbu5tLsuOdIVcK/1h
 jQEmV7iJI8imzuasrpyJPut/v/TJAC8GPy0cuv2BMO6PK/gE4yoM0k2yvveeQNNnZyj4
 ojUr39I6yt3AnrPrOYTfPY1OgarwsL1ODAeQErQ+y33G9S67T+Yt9cLri5OLEVYoN/Ib
 5jq8YuppcKKIRdm5oYhoUwyM2GeA0Q43eyXduGrAbMTNAR4is0pkMDEoS60nHvxd1w1T
 cI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730759453; x=1731364253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIKJ8bKdIDwGrlD1NH/uLJjFcKs3RcVYir4XOYA+m/M=;
 b=NivNXW+NMOZJoePY0l1ZdrNxyi906KRXZsEHgZ+RV1A/qgLwYhnuP7FNTEvh2REa1n
 pVDZQg3oYMkOJemrDne1uFceKTL3hESiqksvwj52oWpFX1c93qDIIIlO8ImFDy2xgFK8
 1oln7+N0UgJD1EutxCkF6uH3SQCsbrJqbObf+k/2wAMHxnLW5DRVc9dNx9WajBumLRO2
 FKeoXnhfD9ddy8QTtDup/L0wXZEONtUy2oYUlrG3gjDGKINaedBa1tTf01HC/i+4xMGj
 mqotjFUR1GIdadQJ2dJSZdozhQ1DNjm2Qk7pdlZIVoHGGBfgRXJIhP10dPrFFlPL3NhY
 ttOg==
X-Gm-Message-State: AOJu0YwY00IwRXFkWm6dg0/mSwhDgG9ujtpvvnMbZK9IA7POMqE2OVMa
 O3d9sOO9UJWn6DRz2Fkui0qhdoaaPfaylB2nZ7i2Qn6Ff1RSiEBuFhSp8imSPhQ=
X-Google-Smtp-Source: AGHT+IH0E764+DyC4uC+9mwMkM9Fwx7jSian1SnwecSQzKtP+34bMvl6VHCXU+brdCtB0wy2UR7DvA==
X-Received: by 2002:a17:902:e88e:b0:20c:f39e:4c25 with SMTP id
 d9443c01a7336-210c68a9c13mr448618265ad.8.1730759453080; 
 Mon, 04 Nov 2024 14:30:53 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93daac739sm8236283a91.20.2024.11.04.14.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 14:30:52 -0800 (PST)
Message-ID: <310197ff-754f-4609-b2d1-edbe61a3d0dd@linaro.org>
Date: Mon, 4 Nov 2024 14:30:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] qga: fix missing static and prototypes windows
 warnings
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefano Garzarella
 <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-7-pierrick.bouvier@linaro.org>
 <CAPMcbCp8343bXBV36jwJBtdQxNjd8RjtbRO048jMpt-Q+Swh+g@mail.gmail.com>
 <CAPMcbCo74T9j0V9QE1Yr2EEdAYDOen8Kehzw1HLvUoy8MquxEw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAPMcbCo74T9j0V9QE1Yr2EEdAYDOen8Kehzw1HLvUoy8MquxEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Hi Konstantin,

On 11/4/24 05:43, Konstantin Kostiuk wrote:
> Hi Pierrick,
> 
> I got this patch in my PULL with QGA patches.
> 
> Best Regards,
> Konstantin Kostiuk.
> 

Thanks for pulling those two patches before the upcoming release.

Regards,
Pierrick

