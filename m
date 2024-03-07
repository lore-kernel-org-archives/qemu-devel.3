Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF91C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDfI-0006Pt-Lu; Thu, 07 Mar 2024 08:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riDfC-0006Op-9s
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:19:58 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riDfA-0004KR-HA
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:19:58 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso1066919a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709817595; x=1710422395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vFFAY2R0FaCdTq3MFXlkMEVxoGurAp7MjYZvdjaRa7c=;
 b=RFeo7gjloymBFtvPWcNjDa8lz5ZgOavSNj52isnyKMQqjbdzUZz9UjW38nyNS27x9T
 uKUdPTCfbozNRvLGTRDLR84+CsBCRFtKEzPGgwepisqOciB5v9+twcbeF7lxL2Z7cBwb
 rUT+6hH4JMGf+4BGZ32n+YOc9QuJ2EL6K9klQdXgNJC1XMuoRQVqg0oPUN9i4p6YStlk
 vlyl8DW+r9qVhTBRPg5XWeNBSn+itUEaNd5YHvrLYHtR2n64WZtvlI0mZvIPWWtq7lbb
 x+ItsZdc26mVqfrHhDvY+RufaiOFtO7+QMhuHjnuGYQ9oRl5Oc8L0AZOjXULrzrBCTUY
 6pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709817595; x=1710422395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFFAY2R0FaCdTq3MFXlkMEVxoGurAp7MjYZvdjaRa7c=;
 b=Vl3qhAoFJQ5LZzdMjfuJ/thrMYI51QjCPxmQnQXGlwQbcGCbOAG/r0MRlgLqac4AmE
 abyjMF2An4/2Cwt7uupsj3WZ9LvMQ1vCGtMgfWLxpoFJJeGJYLyVVfPdDzsvuJMxsFmb
 N13rvESf9KE6NUFHyftQ4bwtXe5AsA+GtZQyC7R3tQV5BKXbX8KVWHe1n+9a/2LHZa/h
 QRzcfs5BWnvipPFxZ+EQRCkYFZtp5E1sRG1RQbaAoZoh45gxZbrr6WllIJDdGiuDIVq4
 yikUUZ/k3jTlO0vvTUfRI0pc2i+89lfbZK8BVDq++69WmZugCakgxIyLaQO/6CZX4kto
 yMpQ==
X-Gm-Message-State: AOJu0Yy61VOtuUYd44ebyicMGzMC1yxPBT80H/RqyzFzVATezgyP1LVu
 rekrbBwPxIL3hM0VdNLKISwE0kIe85NIc+SOj4bQ43h6dXfqpp2cWk1AzSMHDwc=
X-Google-Smtp-Source: AGHT+IFFlfWmajHmwFFfbkZPAR+HQEPmFPRRp6s1Hm3LbLb236ESWBgYQatsQqk0pMnPE9Gw9AJw8Q==
X-Received: by 2002:a50:8dc9:0:b0:565:ddc7:6dcd with SMTP id
 s9-20020a508dc9000000b00565ddc76dcdmr11881696edh.8.1709817594756; 
 Thu, 07 Mar 2024 05:19:54 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 b13-20020aa7c90d000000b005681599a033sm800314edt.13.2024.03.07.05.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 05:19:54 -0800 (PST)
Message-ID: <976841b4-25fc-4b7b-bffb-ddc2090d84c7@linaro.org>
Date: Thu, 7 Mar 2024 14:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] docs: add test for firmware.json QAPI
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
 <20240307-qapi-firmware-json-v2-5-3b29eabb9b9a@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307-qapi-firmware-json-v2-5-3b29eabb9b9a@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/3/24 13:05, Thomas Weißschuh wrote:
> To make sure that the QAPI description stays valid add a testcase.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/

The 'Link:' tag isn't really useful, so I'd remote it (maintainer
might do that). Otherwise thanks for adding the test!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   docs/meson.build | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/meson.build b/docs/meson.build
> index 9040f860ae1a..bcca45a342a3 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -99,3 +99,8 @@ if build_docs
>     alias_target('html', sphinxdocs)
>     alias_target('man', sphinxmans)
>   endif
> +
> +test('QAPI firmware.json regression tests', python,
> +     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qapi',
> +            meson.current_source_dir() / 'interop/firmware.json'],
> +     env: test_env, suite: ['qapi-schema', 'qapi-interop'])
> 


