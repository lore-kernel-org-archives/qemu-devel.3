Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2688C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rid5H-0005Oq-QV; Fri, 08 Mar 2024 11:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rid5G-0005Og-Bu
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:28:34 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rid5E-0002eL-MB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:28:34 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a45cdb790dfso263747466b.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709915310; x=1710520110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBG1yVNIsyQRq4v4zNQSqJ0XiEBJ86Vn80nHsc+3Mho=;
 b=snd5p742XycAMCd6LWAcZGZ/dKoDUvTBDIH70yNbTo/TrW5OJ5sRzbxv7g0bV8tGrR
 26HtFa8m6OkAx9Eei21vEe0qJeyhHaZfi3dXtbxZGltX++zxcYxvjVVkpdUMdyvSCVyY
 lLDVCZZDcwwJy2dioEY0DTSd6fRlhhyUmr3LKOTklvYYua+ynE3kUcGRWTEcT5nAQR9g
 z5Uwz4V8HVNxOQ1L1e+vaTPIzM7qk+7Pcd8qUAgc00w9FguojzM0idh/fX5ouzetmLHJ
 z11oI2AxO9jlGmEIb/RH5W/aZQqP5M3OoPHoKuHa1Z0WIpkfBaJO0V7PS8li2t87a9gY
 wuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709915310; x=1710520110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBG1yVNIsyQRq4v4zNQSqJ0XiEBJ86Vn80nHsc+3Mho=;
 b=mMSIBiIvhkWivJUi8FM2F6O8wN3AY78H1+XIOIOcG2ChC4nY+M4KciLxN1hiAvSVn+
 fJm99qczKwIWv+SFbZ9fmcKbHlZJ+KsS9Z/YjujrWBfqne1xAyT9eEk5bC+UUxSKVDB0
 utHSAj9gz8Cs0W19bBn3t7F23WPBAugBUwY0w7O7STBlwqAoW/dm5yhlkbRzLorh9JvX
 /Rkf0ZAURfLws5CDWul9zttePARu0DvjIgvP22PclV87Cym75Z8TBRlddWcrybFONJKy
 gt0klYwlRFsDEyJriacqJeeoobwXhPAOI0BT1UOnX29+hCyIsH9zwwJx+TDPViizfhom
 5JfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFzr3IRJs9PkT7fRNhjUGA1JGpy3L8YEYbrcuOOfxRV+TEQHhRFEogZhcdnniy9cqX82xqMMlH+Lt+LKfMvwAXOFMz0fY=
X-Gm-Message-State: AOJu0Yy6DVa4SqLyPJ6CvBsaqY56NPmcqtV8MKpVnTpt78W02ZbjQIEE
 QmkhUWcehuTLfd5clnbH5TLbS59d6pbgffo595VzWHKMOpZQle20idH+6H8Oor0=
X-Google-Smtp-Source: AGHT+IGV+LaWniDgICUSGJYbGKVZO1S9H4XJ35ZNEpNOG8tAhX8KPJfx8wwk8IihXZmAa2OhcscXJQ==
X-Received: by 2002:a17:906:19cf:b0:a43:f588:de2a with SMTP id
 h15-20020a17090619cf00b00a43f588de2amr15701200ejd.66.1709915310505; 
 Fri, 08 Mar 2024 08:28:30 -0800 (PST)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-62.dsl.sta.abo.bbox.fr.
 [176.184.49.62]) by smtp.gmail.com with ESMTPSA id
 z21-20020a170906715500b00a45aa673ae0sm4025715ejj.168.2024.03.08.08.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:28:30 -0800 (PST)
Message-ID: <67e36088-0ca2-4175-a672-0bf4c66e99e1@linaro.org>
Date: Fri, 8 Mar 2024 17:28:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] docs/interop/firmware.json: Use full include paths
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
 <20240306-qapi-firmware-json-v1-3-619f7122a249@linutronix.de>
 <87le6s21kh.fsf@pond.sub.org> <Zes4PfcvOLIE3LPD@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zes4PfcvOLIE3LPD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 8/3/24 17:09, Daniel P. Berrangé wrote:
> On Fri, Mar 08, 2024 at 04:19:42PM +0100, Markus Armbruster wrote:
>> The coupling with the main QAPI schema is unfortunate.
>>
>> The purpose of docs/interop/firmware.json is to serve as schema for
>> firmware descriptions: a firmware description is a JSON object that
>> conforms to this schema's struct Firmware.
>>
>> Such a description should be installed along with each firmware binary.
>>
>> QAPI tooling can be used to check conformance: parse the firmware
>> description JSON object, feed it to the generated visit_type_Firmware().
>> Success implies conformance.
>>
>> If you find more uses for the C struct Firmware created by
>> visit_type_Firmware(), more power to you.
>>
>> firmware.json needs machine.json for SysEmuTarget, and block-core.json
>> for BlockdevDriver.  The largest and the third-largest QAPI module just
>> for two enums.  Almost a quarter Mebibyte of code.
> 
> firmware.json can use BlockdevDriver, but we could question
> whether it /should/ use BlockdevDriver. Is there really a
> compelling reason to support every possible block driver for
> readonly firmware and tiny nvram file ? I thin kit would be
> totally reasonable to define a "FirmwareFormat" enum which
> only permitted 'raw' and 'qcow2'.   If someone wants to
> justify why we need another format, I'm all ears...
> 
> For SysEmuTarget its a little more useful, as in theory the
> firmware could be extended to any QEMU target. In practice
> thus far we've only used it todescribe EFI based firmware,
> which is relevant for a subset of targets. It doesn't seem
> to be a huge downside to define a FirmwareTarget enum with
> only the arches we've actually got a use for so far. When
> someone comes along with a need for non-EFI we can extend
> it, and we'll need to extend libvirt at the same time anyway
> 
>> qapi-gen.py generates more than 12kSLOC.  Without the include (and with
>> the enums dumbed down to 'str' to enable that), it generates less than
>> 800.
>>
>> We could use Sphinx to generate a manual from firmware.json's document.
>> Except that manual would be useless, because of its 11,000 lines of
>> HTML, less than 800 are for firmware.json.

=)

>>
>> Options:
>>
>> * Live with the mess.
>>
>> * Refactor QAPI modules so firmware.json can include just the enums.
>>
>>    Drawback: we spread the mess into qapi/.  Ugh.
>>
>> * Copy the enums to firmware.json.
>>
>>    Drawback: we risk them going stale.
> 
> IMHO copy the enum. While the risk exists, I don't think it is a
> risk worth worrying about in reality. If someone points out a gap
> that's important is a matter of minutes to patch it.

Since I concur with Daniel PoV, I'm queuing patches 1 (with
Markus reword) and 2 so far, so less to carry for v3.

Regards,

Phil.

