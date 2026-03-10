Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D0FD4F02
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzVI-0002PM-9N; Tue, 10 Mar 2026 12:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzV7-0002O1-R8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:00:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzV5-0000is-TZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:00:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48534e9076fso19966985e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158401; x=1773763201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VtJcwKU7Pxauh8E0AG87j1wMykvC2RluO+BcIBe1Q8A=;
 b=rbRm5blQq6WeJ145ytDvPdD+12spiyR+ZFywKWoUK7qLDzTPBaA5OqkP3qET0FKfL2
 DPCdjuTCSwfoj45BNgFsVq1TBwpVbPetqavX8QYijM8JdfbQfkRgddAtiwkOm+f4lLoi
 VmN54qPYmRstC8kga95B+v877eFF0tR0JBMrHtAPDpetLJJ7cDJgFfglmh2gv5gC3snm
 i2ewkHlTAcOpkU46GP2cPdt1VKfgQEI7HOICgKMvhdg8FgWNR1NDUNSIgUHtW11Qgcbt
 To7kH4uiyE/GTea4TlA8hjIfO5Bxy3laim0+ssw5Obt+E7Un8zdmnu3HSXk8KWqecuBS
 p/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158401; x=1773763201;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VtJcwKU7Pxauh8E0AG87j1wMykvC2RluO+BcIBe1Q8A=;
 b=hlFwEQSBYDThiJ2ubPjAbnvFNv/gw4BhakXTKNqNF8dEy5woBuloWlCBwR/UqVmr2S
 jWjC+uTXDLAcKyhn0AumE2mfSRoCLOyH5RIhddap0Z2lZbbmETujIqmcGTUuRNm8PpkM
 qkcxyfdOJRpAivyHYY5LmdX0sHWmrbqXX7Tkw5tcPD1wQU6qq/SpSO6suwry5qiuEewE
 MexJOj8WkxXStZOID315k13VBUkX2EwDECuIMPtUjj3hJzb0SHreRpkHeuPtHvsLh+zH
 Rfa0NzvMWifC2G/dO01QkVfbsI7BvbMtxxKN9M9bv5pCded1KeO3rKaGKFYwYf4oSos+
 A0/Q==
X-Gm-Message-State: AOJu0Ywpv12QrZcdy7INn9m/Q7CDNf7wuh4nxngkiM1tHeNHOLfnMLKo
 ETmZeWGKoGfGumvHvJGzEiRizl19SFZJNWkkKCa4dylG0SAJLPlB6wyBJsnr60TyWUJYtnHnO/H
 523TwDk4=
X-Gm-Gg: ATEYQzxYZM3eOe5FYvGC9SWHVrRO3+H7KE9JmlOoSz79d5MUeF+7hGalgb/sAjHaM3u
 ZFjcL4yQ4alGMzFpdnyR1vVt6v8B9fqVE6CvHcwEakGIUsXJB7xWzn6OYxx2JTfbQiyQHFLx0kA
 /IvEj1rVmuLGPVZQ7IAI6dq6lZscRkjhWQ5Ny1hJp9APG9iY43DpfWG426esPxBcDizPs9cdrpM
 DF9D+G/554uaaPVkL/DXb+3L3jFF4g6OaQc6Oj8Gqug9EisusYqQzbCIP2l5AqK1oIJqaSZIhA9
 lQyv9s9xpG/O2cFiIfPyrgZTEzY8ZonjB1mhp+33j4GYNauqAYKk6+exdF3aqY9DCZL8zSwPzld
 pQ5EO9Ac7TrX2FJdjlutfhEtUrIx1m23I3/2p8vzxfSLlhG+JcU8deZ/tQoG3nGb7eyHFduCHjj
 iDDMhvujYv80QtHEEYZEbU8jqAaOMYM6n2aYXgShU0bDFXw1Yu3Qhi3QpQYKYNFkMr1A==
X-Received: by 2002:a05:600c:c4b7:b0:485:3fc8:de9c with SMTP id
 5b1f17b1804b1-4853fc8e5f5mr83928925e9.12.1773158400773; 
 Tue, 10 Mar 2026 09:00:00 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48535c7fae3sm102945455e9.1.2026.03.10.08.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 09:00:00 -0700 (PDT)
Message-ID: <ec958da1-89fc-45d6-a346-f1e6e417f6d6@linaro.org>
Date: Tue, 10 Mar 2026 16:59:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] gdbstub: Always infer base register index from
 GDB XML
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-ppc@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 10/3/26 16:53, Philippe Mathieu-Daudé wrote:
> Generic fix for a latent bug reported by Florian:
> https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/


> Philippe Mathieu-Daudé (13):
>    meson: Restrict gdbstub to user/system builds
>    target/i386/gdbstub: Remove stale comment
>    gdbstub: Simplify gdb_init_cpu() logic
>    gdbstub: Add trace events for around XML parsing / generation
>    gdbstub: Have scripts/feature_to_c.py generate more verbose output
>    gdbstub: Make base register explicit in m68k GDB XML files
>    gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
>    gdbstub: Emit base_register index in GDBFeature entries
>    gdbstub: Use GDBFeature::base_reg in gdb_register_feature()
>    gdbstub: Remove GDBRegisterState::base_reg
>    gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
>    gdbstub: Move gdb-xml/ within gdbstub/
>    gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

Rats... PPC fixed but I get on Aarch64:

Python Exception <class 'gdb.MemoryError'>: Cannot access memory at 
address 0x0

I presume an improvement over:

gdb.error: Could not fetch register "APDBKEYLO_EL1"; remote failure 
reply 'E14'

It would be helpful to have the tests report the host GDB version ;)

