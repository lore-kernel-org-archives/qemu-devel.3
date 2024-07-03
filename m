Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA097C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvU4-0007Qf-Dq; Wed, 03 Jul 2024 04:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvTy-0007Mg-HC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:36:54 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvTw-0007GV-LF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:36:54 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ec50d4e47bso48831691fa.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995811; x=1720600611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OhVk5jAYkCsXfMZAOLxoZqQ9B/QgG6IPQalHkuG3P/w=;
 b=GLN5PwQr91AQJ/CQWO0CHwRAgWclkm+fSr4mYK9CLxKZF70N9T2Iu89kB86pmIveis
 ArBx3qqHnMylrasuhqfw2kNl4vtexmQMfB+GA52H5Wgc6eCIwMu3+9CPYdNebAVWswCY
 ayOFY/OR0GZ7VAWpG33dRhNim8vRfDaNAWR100mPXgqTtiCnd6ETH3cxRy+RP5JwDhfb
 yLbMhxuv/iJjnwoNDpWMOYJTJCTZpK1zJtCbHZfW3K90vSyhhlrl4sM6nWVAfXrXtIuV
 +vuF8YBkSzRCgaMQjQTSurcWvTyAqKMGQ+5ikFVBTdwQGrsQTmn40Z8qYvXIK3rd37jX
 R9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995811; x=1720600611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhVk5jAYkCsXfMZAOLxoZqQ9B/QgG6IPQalHkuG3P/w=;
 b=JUZeo1Xw65YXX3DJ2hnF5WFf35tZPVaDY7dnWpyiaV6oitjbJqFuXz8I06+houzYZZ
 NACHLOKMlrtrilUfoKTPIm9bLMEzz8agJgYNiNzFpm3g+RSCAG8XK3sPUA5R8FcX/dQ9
 PP/rW97U8rG09CiBmOMaVX8t0zQiX6hX8LtNlb5CMz7f/A7XTNykJ5YHavISYQgTsi5N
 rwdLtV3r9nTJQks4dLIEhIVDr/OGAAPAHzmvbcKPulWeZpm55yytUrZwxoBphpPrGi7d
 LfpNTbKp8ytWaD9Le0Npc2TTzVOc+Ypb9kuKpdKSOoyIjJLzLd1BrqMjzd+dNeB1/T4v
 URmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVClPnYJznxyLTuUDQ5QZRSq3jI0KMPn4/tyWQ9qJuoEPGurn9p6zt06fd+oWQ4TQLTl/pae4YYIAuRQxq7uCwTw5ynLMc=
X-Gm-Message-State: AOJu0YzuoxQSW7I7ljQw+04XuQUlwOmbr1RRCzRd1VnNEQKMwXWxySGp
 EazTV38fE5b5j3XrdGf2a55POdn3aSjy3aLTAPLUelFAt9ApcBngGaoSiLhGP1g=
X-Google-Smtp-Source: AGHT+IH0uhpLmrbvP4pCSFAyCs5ICQfSRqNf5uUNT9q523rDG7w4pHJNyAUm90TX6PAsyk9jSMAp1w==
X-Received: by 2002:a2e:999a:0:b0:2ec:40cf:fa9 with SMTP id
 38308e7fff4ca-2ee5e381f51mr66173781fa.29.1719995810636; 
 Wed, 03 Jul 2024 01:36:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1688sm15278191f8f.60.2024.07.03.01.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:36:50 -0700 (PDT)
Message-ID: <1d84cc76-ecfd-42af-b48a-75d0e0bc4437@linaro.org>
Date: Wed, 3 Jul 2024 10:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/22] qga: conditionalize schema for commands
 requiring fstrim
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-9-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 13/6/24 17:43, Daniel P. Berrangé wrote:
> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the filesystem trimming commands
> on POSIX platforms lacking required APIs.
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
>   qga/commands-posix.c | 13 -------------
>   qga/qapi-schema.json |  9 ++++++---
>   2 files changed, 6 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


