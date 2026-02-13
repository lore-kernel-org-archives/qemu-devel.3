Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68EAEF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqyFj-00008s-4D; Fri, 13 Feb 2026 13:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyFO-0008NX-H8
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:50:35 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyFL-0005OA-AI
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:50:34 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-824af5e5c81so1163978b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771008630; x=1771613430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XlpyhyszKqn+zcsW4NoIpcCC9ghbjbpkouG+YizjxQE=;
 b=k5hgWqkEZ0sbvyEyYANWp2DyEJg5mUd/AJI8N0twcSxdNUUREJS4sBJIqjDQEw1PAQ
 zwlx80oIW9+mJoAsoM1QPWL9+84V4TlP8bTbpxCrNq1PIH21b1cBQVNVJt2rcgadgMrM
 VCoPb0gLxVgL0GrHdG2AC3XG7XKnsLtEeC/b8ubTD65cGDmqyaoq/J0xtCgrEIEO+Cnz
 aqNGl27UukTbiKgOfzooU1MFTjehHyj+IHkQ9tlnZhC39w7xt7sL/q2i7PhBH37pYBlG
 +2SZQCBAJVfjE7w1vMwTp5Tx13QiEyg2Xqiahhh+hLFZKaoaYx0SnlD4kToITA6TCcql
 Mgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008630; x=1771613430;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XlpyhyszKqn+zcsW4NoIpcCC9ghbjbpkouG+YizjxQE=;
 b=qT279G2U2lOHg2UUUrwxobmBmjxgvL3a2k2ZU1QpPY3tKiL0/0jB1uNe2vce54APfw
 NMMx1EJnvCkZBVqNVuZRYO+yUsY8y9+7Jcd6LObVZCFiM1vsTGOJhkkL/5N7gAbpYMtU
 bKtlYYnktxOGnbNdLZAhj1Z20vxbgvyez9E0Vbe9kZiCbR4MTAcpBDIbQTCJCb87htsj
 4nMyxKnKWlSp83d4C8ZRMHGl5c1B9IfvPtrL7hCN667vMWgDcRRTihToDY90SuXFj2/G
 1XGAtwRE0bL7+py9q77ygnOcl1vjedNQzwO1QBbp0YLSkD36vzTJrYZKtKrVPihfD5W2
 q8TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcE2CKsY4UYnxPrM3ORCSGBXJCXgJzi9xOpyeFdWYIVgy4EzV9sC3H4JlgqQ3l66nTNebt6lfmmEne@nongnu.org
X-Gm-Message-State: AOJu0Yw2mqVdIsvQeSH8d99mLrQzI9wD1MJVJt75pTVpM912zANx8hJ4
 eckuzOL/LZ55UJ7+3fv/9uIdDFo6dl+kQCX6ORn0vxMlltnbKeMHwUkD4fPFmkL6rBs=
X-Gm-Gg: AZuq6aJs4iaWDE2tUY4nv10bStxVur/Nci21CE4pCtYfR65BN8DynDJUGnRtRBrpifb
 wfZ0J6qjk2vP3DtvQSv11Tb+kgVIbt1z/BFn0FJh6qdYqb+5QBppKkSDyr2IxjSR16xmlzNYfis
 /p9kA0+YeLZKQ9zR6PdjSexgmCahUuV9+jBBxPZ35SSdyGSsqax1CqB8ZWwMUo58BDFadnQDC8B
 0+0SMSSjRac220IrXp7t6ygtCaV5RrBLjP3o315Ss243bYsocLnP4bPz2/D5lRm74n8BM+8WU5P
 bgf9wQP4w8vrjtLfs7qmhbp7KkBPQmG/VKzU4pfTGsOzezpdAffV7H1C70Y+KXxNdFbuNREsDW5
 Td7ZwUVJNC/a0woPCJJ1yELeW4oiv6MqUUkH8I1mbQAp30AI7bZearfu6YyBxn2/qCL+43cLW6t
 SNw6s5+Zp7YHecsusLBaMhjr5ZHAbbyDY5bVraIfBu63DLCklh3gPu6VwGD+qJkA4/umvLhXZyx
 /zNEcE=
X-Received: by 2002:a05:6a21:a90:b0:366:14ac:e1fa with SMTP id
 adf61e73a8af0-3946746b79emr3465040637.76.1771008629751; 
 Fri, 13 Feb 2026 10:50:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e197d5e1csm8419681a12.22.2026.02.13.10.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:50:29 -0800 (PST)
Message-ID: <4c4f876e-51d0-4eb1-a79d-dbc85020e01a@linaro.org>
Date: Fri, 13 Feb 2026 10:50:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] hw/scsi/disk: Prefer target_s390x() over
 qemu_arch_available()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
 <20260213175032.32121-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213175032.32121-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/13/26 9:50 AM, Philippe Mathieu-Daudé wrote:
> qemu_arch_available() is used to check if a broadly available
> feature should be exposed to a particular set of target
> architectures. Here we only want to check something that is
> specific to s390x: the target_s390x() helper is more adapted.
> Besides, it will allow to reduce qemu_arch_available() scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/scsi-disk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

