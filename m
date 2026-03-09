Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A12DF3C245
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZvJ-0006cS-P3; Mon, 09 Mar 2026 08:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZvI-0006bk-0R
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:41:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZvG-0003e5-1b
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:41:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo5420023f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773060080; x=1773664880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PTJsVYXrLdwdlLrcLJNvC82vqdAcza7hARZryXtaqkU=;
 b=mqMjpzHML8XL3Df1oho6+zVa/faBeDda2j4S0bnJA2g03qc8B7rylxTZTmYztPmM45
 fH7Hk+h7CPDInZMcHbjdcrNMTT8w5KQx5+6Ra1gNn6qxQV9SgfW8XKty1UYNTeTEjA3a
 e0JvHIi5F2B4lUNDD4zbOfcwqB/K170f8FrGiBdUCcAMDD3G7braLPzKo20nVylLp/IS
 vg3QHWjQC35xrktvNgnRFk6vVtyxk4Zapj5On8bRlXCl/5Lu5FC1gMFbDQyWAJmWNrHa
 ShENUwltniQFUJZ4C4pw3hKpqbME9tvOTV2a5+xk2l9O3M+E7EguyyxFm/95z3TEXKG9
 ircQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773060080; x=1773664880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PTJsVYXrLdwdlLrcLJNvC82vqdAcza7hARZryXtaqkU=;
 b=CLcvOeA4kaIq8eZzgnE4Zy4NqX0mlh0ThbvN5A+m1xDzvPlnIhGRwWhMJZFArPSbf4
 enp8aneXpmq8p8xp2kSYshFZCQXIpfm+DBiWItgg7wrEzad5tc41OxoFdPoau5MnT1Hx
 12Ay15pZsT2VovCK+IiX9UXZJwLz0OIrfT21uHaUvc2r/oGHP6sThpselrcHEndFvsn4
 Fv57lPc1sqfk2ksd9PU8/1m3FLNulDpk/ogi6Xp0HWjlMohQCrE3iNF3lj1pq1lH5qeM
 A69xsfts3Q+F9qY+8iySwMK528k8un/nQthzzey1u8xdKFJDgVBNnYMw3Qw+y51DN1GD
 voVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9c0lnQHz3dFGpWi5g8AqJoODDLDUOgvxKbKc2JnDLJ2o/6rdGNaf76vHbqR1yoYs81KiWacQKm3Eh@nongnu.org
X-Gm-Message-State: AOJu0Yx6+P1cxabwN2mr2Y0vag8XqGZTv5yoyHQrGFBhdjKAhXFy+Op3
 J77b3D1Qo8++SVkJUdtRR7N68g4LoEIwbkLBPuVGYdBObcMVNCuVPdJ/qAM88KmDqQg=
X-Gm-Gg: ATEYQzxBMNxJ5mIYWIvdQ6sgjRZDqOUEq9Uzq4mvZpXymXRFFHCgeyqrFC0KLm/t/d+
 yziXaZyblRQllx+jo8Ht/9pphYWh/aLGWvi04/U+CubrqvKPsz+Lfw5DLoOS3MG6cs4fS7KZhZU
 vxooKE1yZ1kYlbEOf73e8h+71tpsub2nQ0BMAqY8ZLl50noIvusjOjLCz8R0CX48LZSQ79rmkDC
 7bFGQrnbmTB4E9e5nh3QDRs9zczJNA/b4iRH2Pao3ucJ9FQQ04trMq+ZrhsqdwigOsPsInCJZg/
 BJxm0gynYlp3dRwKRnJzW6IkgT/fVuyJdjZHOxmqAuqorn8zMIhAZ4EgEmJJcQT9Ram0ZZ2dBnx
 KU02vTJrOM2GPPviVa0wXq71fcw9Nvhkdugzm3UkPxzP50qsQ1btawWLfvqJJ02BLBqg5M2GQB/
 ya/uuCdv2pAQq0L2OMUNXbT2IRG6ZnflxnuKHCQuEW+1Xgi+QzjeMNInOi0qxd9ifaWQ==
X-Received: by 2002:a05:6000:2285:b0:439:c67d:9fe8 with SMTP id
 ffacd0b85a97d-439da3526ddmr18641164f8f.22.1773060080097; 
 Mon, 09 Mar 2026 05:41:20 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb85b8sm26284079f8f.17.2026.03.09.05.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:41:19 -0700 (PDT)
Message-ID: <a21630bf-5077-4b64-91c8-498f92f9f8b9@linaro.org>
Date: Mon, 9 Mar 2026 13:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/sifive_e_aon: Don't leak timer
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
References: <20260309095129.1406506-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260309095129.1406506-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/3/26 10:51, Peter Maydell wrote:
> The sifive_e_aon watchdog creates a timer with timer_new_ns() in its
> instance_init method, but does not free it in instance_finalize.
> This means that QMP introspection of the device leaks it:
> 
> Direct leak of 48 byte in 1 object allocated from:
>      #0  in calloc
>      #1  in g_malloc0
>      #2  in timer_new_full /home/pm215/qemu/include/qemu/timer.h:520:21
>      #3  in timer_new /home/pm215/qemu/include/qemu/timer.h:543:12
>      #4  in timer_new_ns /home/pm215/qemu/include/qemu/timer.h:563:12
>      #5  in sifive_e_aon_init /home/pm215/qemu/build/san/../../hw/misc/sifive_e_aon.c:286:21
>      #6  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #7  in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
>      #8  in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
>      #9  in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
>      #10  in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
>      #11  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #12  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>      #13  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
> 
> Allocating a separate QEMUTimer with timer_new() is not the preferred
> interface (per the comments in include/qemu/timer.h); switch to an
> inline struct initialized with timer_init(), which we can clean up
> with timer_del() in finalize.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Incidentally I notice that this device doesn't have vmstate support,
> which is unfortunate -- devices really ought to either support it
> or else install a migration-blocker explaining why they can't.
> 
>   hw/misc/sifive_e_aon.c         | 16 ++++++++++++----
>   include/hw/misc/sifive_e_aon.h |  2 +-
>   2 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

