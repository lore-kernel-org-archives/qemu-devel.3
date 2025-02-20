Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88773C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl3hx-00085o-Cg; Thu, 20 Feb 2025 05:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl3hv-00085N-D9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:23:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl3ht-0004Mk-FQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:23:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso4239305e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740046979; x=1740651779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcD3/oF8+1GRTMekWH3zJZq4K+jC9xAo30QhkePCkzg=;
 b=rgfJsBA3D0PFfBK+nqmNsbUj1xiWnfqqeX7Qbi3PpxMQIts2IM0WsfJc3bsF8ybTbr
 JlpSVinfNWeRqSgnML8ZqpEcIi6dzMrdcLqpAYMBDTdU6sKZppJY6I72i4IaUnhBG/en
 SUqfUpuOt8wTPB9SIK4IsWraxH9QkR/ePtFtjJREqEfmFsElAFadaIo3mIgEzn/vTsZX
 dr2J7d+T4O2Qxpuhy9Lv9X9ICGaon1obNupYVJ9tXbc8EWFLmtaIszYXJ6oIouKKBTYh
 FkEiitL9WyCuUQbXdBIEvHF4zCPRLKmZA6lEBz2o/kmaDVZ3E51AvXkic0QEl5AUAFRy
 fTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740046979; x=1740651779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcD3/oF8+1GRTMekWH3zJZq4K+jC9xAo30QhkePCkzg=;
 b=tOg6ZUk9VarApZv+bW2pM2B2exO4rMUX+LraXQjXq1awUmrOrTvUIZ90VNlZ5RAC+c
 EXxLT8Tnv0k4zMkZ2eA+Nz2pj4SiyGBXXAwlHqglFV/sg0Gsj7XPboRpCIW4lHo7nJ5N
 KDF0qHbplKAuWLOgPGLKpeKzzyuRKApTT+8Dt2lue7fb0pIjEou8vTxZFBEFDIFG10LH
 4UZq1tqLs8NbfrBrDpxliaeeuApziKMO5k5ZgtFkf+BSMp8rfrNLzYCc3ksQW+/Yt46H
 RANv+cf2qkPEbZkGL6iny/mrfNWN+6Rw6sYj/64KUtjmB9L0z7m3K0jHWJ9KltoQTxB+
 S88Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXryh2N1e94hRpfUfTi18ExItRf7n3NfykwTaDiVsrZ93d2+6+X9C348dOy4/zYXjzI9nS5w/pBtVT@nongnu.org
X-Gm-Message-State: AOJu0Yw41GAXG2zxILazurIfYFXTwGpHw+doYJvT5DzJ0t1bK28nqkKA
 zRg5NyQi17MZOP9S1pJqza9TBUKIjq1ijRDVO3ZmWm4mu1Tl6A/075n68JHr214=
X-Gm-Gg: ASbGncuBPTA/5cwTMQ3psUYkue6KChGhtLlzy6q9o0Di3OJ4NHkn3tMWZBI9u3//2B3
 ZHvb2RqetaF8Eqad8HzEq/AlVuoxOJSYWSKbYV1SneeTy/b6oGmaeg1xGXhxopv/BbDYd3TjdYe
 j3qIYwUFUm4BjQEbzCPC30z6O+ludfH4/XOaQ9fvvnQZTJg0Fu9WathsoC6+3C4UTgZDrmvfmVO
 9KDW/VA7rmzxG2NtuFANPLoXGW7sMV1DZNF983fYGq3K1XutRgEDDTrjgoqADHPe3jdrIZzUHyE
 zyD///JfSf2Rkd8mXPl6lX+/A6JVOGhx99QdXtgrv8KMABkcXWmVh38kpYc=
X-Google-Smtp-Source: AGHT+IHcgZb/IS/AYKL7uUqq4wH89neAvqc0ToUj1kpzZo7aad6goJBBYjqI0FfgvCGSJNZbGSkOYw==
X-Received: by 2002:adf:f503:0:b0:38a:8ed1:c5c7 with SMTP id
 ffacd0b85a97d-38f33f57fa5mr14851922f8f.46.1740046978978; 
 Thu, 20 Feb 2025 02:22:58 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f561bee3esm5598701f8f.21.2025.02.20.02.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:22:58 -0800 (PST)
Message-ID: <19752891-400c-4563-bef6-24138c424134@linaro.org>
Date: Thu, 20 Feb 2025 11:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Any plan for command line '-g' option (graphical resolution and
 depth)?
To: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <97e66ba5-488f-4246-b4d9-466d29a86dff@linaro.org>
 <e514d6db-781d-4afe-b057-9046c70044dc@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e514d6db-781d-4afe-b057-9046c70044dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 20/2/25 10:50, Paolo Bonzini wrote:
> On 2/20/25 10:20, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> QEMU provides the global '-g' CLI option:
>>
>> $ qemu-system-foo --help
>>
>>    -g WxH[xDEPTH]  Set the initial graphical resolution and depth
>>
>> This option is used to pass resolution/depth information to guest
>> firmwares in the machines defined in the following files:
>>
>>    hw/ppc/mac_newworld.c
>>    hw/ppc/mac_oldworld.c
>>    hw/ppc/prep.c
>>    hw/ppc/spapr.c
>>    hw/sparc/sun4m.c
>>    hw/sparc64/sun4u.c
>>
>> Examples:
>>
>> - hw/ppc/spapr.c:1102:
>>
>>    _FDT(fdt_setprop_cell(fdt, c, "qemu,graphic-width", graphic_width));
>>
>> - hw/sparc64/sun4u.c:716:
>>
>>    fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);
>>
>>
>> Obviously we have default values, which are different per architecture!
>> Clearly these ought to be machine properties.
> 
> Yes, we should have an easy way for machine to allow, in addition to -M 
> graphics=BOOLEAN, the structured property -M graphics. 
> {width,height,depth,enabled}. Then '-g' can desugar to -M 
> graphics.width=WW,graphics.height=HH,graphics.depth=BB.
> 
>> It is also used to set TYPE_NUBUS_MACFB properties in hw/m68k/q800.c.
>> Here i suppose we could directly use '-global nubus-macfb.width=value'
>> etc. although I'm not sure it is the recommended way.
>>> Should we start deprecating '-g' as a whole?
> 
> Only if it's unused/useless.  If the option is useful it could also be 
> used for EDID, for example (adding Gerd).
> 
> Global variables are hard to track, and the one-off nature of the option 
> makes it hard to figure out (without looking at the code) which machine 
> support it.
> 
> However, if the properties were available and introspectable via QOM, 
> then it wouldn't matter if the -g sugar remains as an isolated "case 
> QEMU_OPTION_g:" in system/vl.c.  For an example see -boot/-smp or -no- 
> reboot/-no-shutdown.

OK, I suppose you are pointing me to:

commit e6dba0481363ad343c5f984dd4de3dd06d79ee68
Author: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Date:   Fri Dec 11 11:52:43 2020 -0500

     qmp: generalize watchdog-set-action to -no-reboot/-no-shutdown

     Add a QMP command to allow for the behaviors specified by the
     -no-reboot and -no-shutdown command line option to be set at
     runtime.
     The new command is named set-action and takes optional arguments,
     named  after an event, that provide a corresponding action to take.

Commit 30e863e5a7a ("qapi/qom: Add ObjectOptions for input-*") already
introduced width/height notions in InputBarrierProperties:

# @width: the width of secondary screen in pixels (default: "1920")
#
# @height: the height of secondary screen in pixels (default: "1080")

Maybe we can extract a QAPI structure including depth.

Anyway I'll have a look, thanks for your guidance!

Phil.

