Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D94C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvNe-0000Zx-QL; Wed, 03 Jul 2024 04:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvNY-0000Z3-AG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:30:17 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvNU-0002f0-FO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:30:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58b447c5112so2070947a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995411; x=1720600211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I6+4H39F5abq09aOwE0dDCYBn5yuWFZmap9FGeGFlPk=;
 b=d3jy2Oc7djyVGWacNX+9RIAp+BFxMcL+S94mkKNOUt7o81Mg92xP9zmuDhLmv3cikY
 8gETGAX06lsOCZeliG1W+4p5tMLSIwTwVptKNoNyyjAF6Ra1maS540RsRKcrhvP3oWxC
 lEGysf2trasLpG3ncI47qHFznXQi0QqSobnCf0NcGSVkzNnIP5y5r8p+m2BylsIkq804
 h75Pbmh+dx8SmuT/rNuO6rZrBeISQZTPc9zm1PYSngCe+ATETtSWDKT5Gpl/gJrBrlwC
 7F7fFwBJhkKCRnGYbRwrTF5kRRJ8knLodZlwApO82BLU6ut1zM33h2yq6Ej45wsp98RW
 j/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995411; x=1720600211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I6+4H39F5abq09aOwE0dDCYBn5yuWFZmap9FGeGFlPk=;
 b=PiflQqZxe/pkZGpoMtsh+Wprfu3KlBiivpcO6GyClrrTRFFLyA0ffgERxaoPa25iFO
 +2gzh3mqBaDBLQJR/jwMcEvBOKRgOyJewJwq1THtPjTMNU124Vi54NBkxRtjZmzzS9qK
 XcHHuiw/NgkdseL1aAFB9xoj0F5HnIyK1woKPjeV5etaSfjlJLcYG7n8Fmq9RTF4neAU
 3FoIIhHjAkF3dDg5ZQvISv3gviqVh1zilgNyvlXq/r1TxOI2aBUzJMc5+Q1gXLjEkyeN
 tFMvBKT29PwdDxUGJXkaZ0cETGQuhDNfvui+VGLAEXf/RTC5D7HPSkTyMlvmeyD9Ljaq
 1GdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCTJtti90qRBG69kV+49duZk1W6t2KOqCFmcpm6CbD128osqHgqL9JGTYNdy8oP76yUpOm/v50LZo14CxjEifW8DGkVTM=
X-Gm-Message-State: AOJu0Yy23SW/CMakpo/4cnGGU/VZcBgisS47Xskq7QKcBvFJyE5MePCj
 2oYkVu8TTrxtvKKgtEXDvFNjX849xRnWp/xkB3Z/s/sUvv2bnnhoBWLLu3ngcX8=
X-Google-Smtp-Source: AGHT+IHMtf0DNiatPlc6P5aH6zgVWnvJafrrqIUwaaxd2P8KSEb6YzpWAJdv6vtl/NZEd+2o2dtb8w==
X-Received: by 2002:a17:907:845:b0:a75:2387:77f5 with SMTP id
 a640c23a62f3a-a7523877912mr714328866b.49.1719995410683; 
 Wed, 03 Jul 2024 01:30:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08d0c1sm480291366b.164.2024.07.03.01.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:30:10 -0700 (PDT)
Message-ID: <5b8bef45-b9f2-4dbc-b58d-56be75db6872@linaro.org>
Date: Wed, 3 Jul 2024 10:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/22] qga: conditionalize schema for commands
 unsupported on Windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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
> fully exclude generation of the commands on Windows.
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
> This also fixes an accidental inconsistency where some commands
> (guest-get-diskstats & guest-get-cpustats) are implemented as
> stubs, yet not added to the blockedrpc list. Those change their
> error message from
> 
>      {"class": "GenericError, "desc": "this feature or command is not currently supported"}
> 
> to
> 
>      {"class": "CommandNotFound", "desc": "The command FOO has not been found"}
> 
> The final additional benefit is that the QGA protocol reference
> now documents what conditions enable use of the command.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-posix.c |  2 +-
>   qga/commands-win32.c | 56 +-------------------------------------------
>   qga/qapi-schema.json | 45 +++++++++++++++++++++++------------
>   3 files changed, 32 insertions(+), 71 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


