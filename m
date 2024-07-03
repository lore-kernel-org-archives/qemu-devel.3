Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B16AC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvP5-0001oJ-F7; Wed, 03 Jul 2024 04:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvOv-0001i8-1X
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:31:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvOt-0002mW-CD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:31:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-363bd55bcc2so2752957f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995497; x=1720600297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tL/+axddxz7zD0HyYYSH0I/iFm5cKQ5MNEFegkNsma0=;
 b=Y7BwOjJouaQnzyiJxlzhI2k+rHwwwDQ1kS3xywX2yNUrrYKInuJFToSYISLc0j22mG
 wIwlWVj+mNSNnUooP9opCrVsS4Y94SnMnUrwv8v/+iTkbvR8s25MbAJkq97OYmYikBEg
 /cSg7roM83sZ4GP3j5bwbPtN6Wbt3MdmmSUok87her9J+6myq1lplGnd7lP3S0A1Gyb2
 zhaTBjCNgRdSu097MwAp6R615ziq1BgR1Po4UWo8wcDXj+dTmrfjc+HKIyEsDrYHGE6t
 QuiNPRDvhk1FsEPUOpKO7eSZ0WQWM5FvgAHt5GzRRA45xjtSQZ608u3RXL61tK4Oe2lj
 GoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995497; x=1720600297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tL/+axddxz7zD0HyYYSH0I/iFm5cKQ5MNEFegkNsma0=;
 b=fNkw3TWts+e6GMXb+we4ZSEp2w0Bz4UuGxvYBFnrtcyy/8hgv2Ucfi5PNr05xNIzcI
 h/PoZCbAFnm7Xxd7AAP/E7oa/1zdTJOohPjK1xClK8VenlI2ITpmUZH1wvk8cmOjzAFW
 nNiTAhsgHXT8Ab6M4AnFzf73Hnth8Ezeigk9dugZFyOHN371NElROhdGTeQRwXywTdp9
 PGAMQAAVqszq+n62MjKQWOeUyhurT+OWZg3eoCv4T7VwC6Zf4+bQgPtMFPD/MSwxiQud
 Fvw9/55E2bMoxeYSvAPYh6g/yKlEof0cH1zRgMmUp84+9YezlJzQHuwMuqGv/2X1+QhI
 t/oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT3fEBrDl0It+P27ZoCM84tiZk4/EmoxqEfQVaWweEp2xLNdWv5c0uspcWYQZBR6zxhQyA5j3AagA55EI6A/lWLdU1sIk=
X-Gm-Message-State: AOJu0YyuF4HOrlFwkpBuO9MU+ACUFKEqpsqGWkmox8Um5scI3k4KcmM6
 Oz+Lpnci4Sr2ThSGxyZsdOtYyenavJainvOHJYPB40+9jALmNukKIIGjyi0Bgi4=
X-Google-Smtp-Source: AGHT+IFSj0bukzKkNLYAG5vthUL5pGYMaV2OuzulxmQM3oDX00CK/K2v3GjiN+zqKU/Jr2FArcYa4Q==
X-Received: by 2002:a5d:47c5:0:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-36775699799mr7578712f8f.13.1719995497215; 
 Wed, 03 Jul 2024 01:31:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb973sm15224630f8f.67.2024.07.03.01.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:31:36 -0700 (PDT)
Message-ID: <202e5ff7-3188-42a6-af7d-5bda71048f51@linaro.org>
Date: Wed, 3 Jul 2024 10:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/22] qga: conditionalize schema for commands
 unsupported on non-Linux POSIX
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
> fully exclude generation of the commands on non-Linux POSIX
> platforms
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
>   qga/commands-posix.c | 66 --------------------------------------------
>   qga/qapi-schema.json | 30 +++++++++++---------
>   2 files changed, 17 insertions(+), 79 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


