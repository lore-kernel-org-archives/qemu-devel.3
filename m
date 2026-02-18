Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C266FE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfOT-0005jL-1T; Wed, 18 Feb 2026 06:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vsfOR-0005in-5u
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:06:55 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vsfOP-0003yJ-NI
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:06:54 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4359a302794so3795671f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771412812; x=1772017612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b87vLX9tTX1XT/JhPNlGCRIwLa50acRgBi249pX4ytE=;
 b=DoBLrCMQROfz3I2zVTj8fAG0qOSNtMA7XARLlBAn/ZhPJrG6jTOlyL23yRUwJvTbDB
 jAyUioQTjR+8QzjcSjGC6iOQ1rl6Y9ln8jq0SEGLJp0bXJN5ZogYev5z4Xyz8OuEnw4Q
 dRTQtoUSE5HRWJdpzj5IdCe4hZ33P527LmlmPLTC/1vD5msNJzcMiIHKTfmk2utry0OH
 7en+k/j+n2AHz+c64Sqjw2gH3wc5iAq190G8sBdTu/iHdtqxMI5Bp25KWH+jNdLWSpeo
 E35Pw0RtD6CJy0vVJYZmAR5hD6pvDbI5Da9cefvIFPXZVfcxUjIE9y2yIr4nq5AK/dYW
 MTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771412812; x=1772017612;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b87vLX9tTX1XT/JhPNlGCRIwLa50acRgBi249pX4ytE=;
 b=WhfGtBSI4LpEkq+pcZnlAViRx52hgzewjc2H84gGsO1RfKW/9Z7O4E9PbJcwdWRu/9
 sZ7M0x8wVOgmEZ7s6Kdk+B9xG9V+HUEE3woGka7ApE1OuJ7/OIuawlxF6R05TJtwwUTe
 F5b80GQ68xsgbudKLxzH/prkmltcMN673NG6keqNQBOzqvfRBQvwLoGvJmMSNbsz/RyW
 CA85GgFXSiS1310vUlDoC9CdKW8wN4Lt8+95nnjEgVTnrw+KUdHm2W96e73fedB/Le4T
 jSPLxmwKRjf2HYnfEbfDO9XxHfRQVxVWIxzpnvWrrNIQV5hmaeG37o8gppUZscyhG5UX
 8qtQ==
X-Gm-Message-State: AOJu0YxHMiU+csKuRAKEk9HA6fKmHG/XFK24swZ+Rr4rluqAiCKsZer2
 vVDytMkAxa2/2zgdzxH9FutM5oj2Ajrx1sUznW+hWN6n4iQ90YHQwQs/
X-Gm-Gg: AZuq6aInLy/SL/eJJHIRsm7aszOdMXu8wHiFuSh6B5/8A+wEj5kskQ54VflPewh5QpF
 cY2qaKoQhVQEBQG/3jHLFyoqQUm0UUrUueDCMEjiGLb3XIXNEwZLtV6i6mGvVQUuUbz9P8mAQCV
 ej1Ny/TBOsd3mWAsR6S1hH2IA87LrV/TOtNYs0YUmYOQrIeYLk3iZPaQwIBMD0hPBLo/tejOXAq
 8wkMutFNfvWHJOqhZPSmb0L7DBXPej6iwtohleWZ0ux2L7LnljMb7v8ky1rZAnOw81sABG+LTj1
 l8BGZGHz4OVGEaJiqMZFLgaoqg45rI7nYUBwr8fX3flfI3HINqlwTtcMI0Mjk1o+ykzDze8+Wf2
 a6dLJuMH2c+Ls8Rm8a36g/+MVXD59c87+YWnJwzd0L3sQjv251fcaYkIa0OL0w/TgNMquJf5Nk5
 nTfI0pXiGOkoVcYRfburhjriGdtS00GMJVqQV5IcNY
X-Received: by 2002:a05:600c:c095:b0:483:7f4e:fef4 with SMTP id
 5b1f17b1804b1-4837f4f00dcmr181888305e9.25.1771412811425; 
 Wed, 18 Feb 2026 03:06:51 -0800 (PST)
Received: from ehlo.thunderbird.net ([185.238.219.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439567aad3csm6790373f8f.36.2026.02.18.03.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 03:06:50 -0800 (PST)
Date: Wed, 18 Feb 2026 11:06:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Wei Liu <wei.liu@kernel.org>
CC: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH 0/3] i386 emulate fixes
In-Reply-To: <20260218063156.GC2236050@liuwe-devbox-debian-v2.local>
References: <20260214131659.31378-1-shentey@gmail.com>
 <20260218063156.GC2236050@liuwe-devbox-debian-v2.local>
Message-ID: <6A22CA41-E9E6-4767-A550-161EC472899E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 18=2E Februar 2026 06:31:56 UTC schrieb Wei Liu <wei=2Eliu@kernel=2Eorg=
>:
>On Sat, Feb 14, 2026 at 02:16:56PM +0100, Bernhard Beschow wrote:
>> When testing Mohamed's recent x86_64 WHPX updates [1] I encountered two
>> compilation issues under MSYS2/GCC which are fixed in this series=2E Th=
e last
>> commit fixes a missed optimization opportunity in MSHV code=2E
>>=20
>> The MSHV code will be reused in WHPX [1] which allowed me to test it=2E=
 I
>> didn't notice any performance benefits, though in theory there should b=
e some
>> due to less guest memory accesses=2E
>>=20
>> Testing done:
>> * Use a Linux VM for a couple of hours
>>=20
>> [1] https://lore=2Ekernel=2Eorg/qemu-devel/20260213034556=2E13471-1-moh=
amed@unpredictable=2Efr/
>>=20
>> Bernhard Beschow (3):
>>   target/i386/emulate/x86_decode: Fix compiler warning
>>   target/i386/hvf/x86_mmu: Fix compiler warning
>>   target/i386/emulate/x86_decode: Actually use stream in
>>     decode_instruction_stream()
>
>Reviewed-by: Wei Liu (Microsoft) <wei=2Eliu@kernel=2Eorg>

Hi Wei,

thanks for the tag! Note that there is a new series including this one: ht=
tps://lore=2Ekernel=2Eorg/qemu-devel/20260215052225=2E22513-1-mohamed@unpre=
dictable=2Efr/ So for the tag to be considered it should be added to the in=
dividual patches there=2E

Thanks,
Bernhard

