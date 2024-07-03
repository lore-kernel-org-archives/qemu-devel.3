Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234A1C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvWF-0001y9-C2; Wed, 03 Jul 2024 04:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvWC-0001tZ-GM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:39:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvWA-0000Aa-KQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:39:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4257a390a4eso27458815e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995948; x=1720600748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SfzEpk0Bmax6b35euPBIAs98xDuBX+Vp68Dr5Bla9yM=;
 b=SeNFcrPzMIjgfMC8YLqYjxWvVsNJI+ruzwzsf8RjTVEYz2EFmJMrUd+f0yDSdkqV1K
 OxOwwvjwNxVTIMF2AT0u46nLfJ6RhCwoOMMrsj/JWW3NkhxrWLF08/JX4Xm8/5o+zC45
 NusifYigrF7Zb4w5cizkJ4uQuFMcsOBOdT1WFHDB0ufo2ASdS1Xb1GIxthVnGlPbUFlw
 keHv8UlRJGs89B4jbK3flTN0JPdmoJp9F3kA0UAqZPFSmydsUwQeP0nSKeqh0Xgo4SUO
 mR+k5y6FZ/thMxe14NS/Ny/5gNFROalN014kbGYJ52GUtkmrBKJjrWFQOL9AG7nwbhzt
 rkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995948; x=1720600748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SfzEpk0Bmax6b35euPBIAs98xDuBX+Vp68Dr5Bla9yM=;
 b=bRBv7A+4HZRbzPIbd9/sgW1lfLjI+JI5yodsgABP3W5VaZ9Y8egBjDSEsJe6/SSzYp
 gVEpDIfW0XQHK4CpccHPjwcctsONcjwd1W6R5sQyV2RWEtwerSRQfdeAyLJnn1keFzfB
 5iz6RVPKA3jOYfcJ9xhp1Kec2ZfBsWmRgu8qtc8zSpuYhP7SmsMFtGXTEspvRZMc8Z9D
 NlJtSVul2HhtHPMOOgbyYkVw3ZES6FevILf7soPRojdDFBoINHICe7TGdwD35Fi3JsAq
 RN5zznsUEwoqDFRrbPh0NkKPc/nyzxjsE9DNKp5X6zB/VPxBNoeegoe0Zq5KdUia5JtW
 gLnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8w6vFkQfg7F5vAwT4iGoF7hC0p8RF+9UEq+h/QETdb2m4ZDOb48ZMQD+0HDqXJpQY/wy93LrWF5IkqJwsS8tc3vTe9gY=
X-Gm-Message-State: AOJu0Yx0kYAWlbDpL3wUhi5yAocPeyct0a684o6C8f6LJoz7HJx3Npai
 4iius+I7r9vK6KNfoJH+7b4bf8vDVfFMPy/oojKpWhBtXE5wLUTd+mWj3cUZT8k=
X-Google-Smtp-Source: AGHT+IE1xBbmINtT81/rIUs2KD8NB8HLHXloEwgLuc9K/dznx6+ym+QNT6KEFkQZisQzbxfBsWkkmQ==
X-Received: by 2002:a5d:4241:0:b0:367:973c:aa7b with SMTP id
 ffacd0b85a97d-367973cabcdmr79827f8f.2.1719995948034; 
 Wed, 03 Jul 2024 01:39:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1046f2sm15188632f8f.112.2024.07.03.01.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:39:07 -0700 (PDT)
Message-ID: <5146719b-71c1-4ee7-865d-6f3fb6324348@linaro.org>
Date: Wed, 3 Jul 2024 10:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/22] qga: conditionalize schema for commands not
 supported on other UNIX
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-12-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 13/6/24 17:44, Daniel P. Berrangé wrote:
> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema  to
> fully exclude generation of the commands on other UNIX.
> 
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
> 
>      {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
> 
> to
> 
>      {"class": "CommandNotFound", "desc": "The command FOO has not been found"}
> 
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build          | 1 +
>   qga/commands-posix.c | 8 --------
>   qga/qapi-schema.json | 3 ++-
>   3 files changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


