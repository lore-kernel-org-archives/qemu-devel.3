Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F50C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbLk-0004BD-Q1; Tue, 16 Jul 2024 02:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbLg-00048L-K7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:07:41 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbLe-0007gt-BK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:07:40 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5ca9835db95so2848694eaf.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721110055; x=1721714855;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ov6aI+oSXjE+lm0l14irEwXo0PxOxCd4gGyYqm5Gf/Q=;
 b=QS+jwBJVri+lP73YYmOws2d9UtChka8Y6/xqHjy7li5k29JV350YeAiNaIoSpvdxge
 OIqmF2G/m27Rdw1c+zzk4JMFd9vC5ftKb42ttSGBb70MYDip+5yPy8ysdh+J4NA8ba6T
 9d3lW6S6UZcnSRLNTIbHmEO8liYU6wBuBrd2TWUT8R5x1nhxAls2J9/Zag1LD7xzaR+p
 Odmgx4GB4smv/vlDxqtIa4TWvMQ2yK0ASTwbcX/eb6Bd4erIj7GRSrwhtUOWqdAlGLL2
 FG3yLVe4H/urvg29iFJccdkuJ1hKnwrgwRLpf8dbywD2D4rQB8OGVnq3tYlTX3m9mPfg
 Ndww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721110055; x=1721714855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ov6aI+oSXjE+lm0l14irEwXo0PxOxCd4gGyYqm5Gf/Q=;
 b=ecKa2tVKtLxIJ8ik9DGoVkeJ0cZ+5k/Py8ZkinzM4VHamWajCypTO7vWF5sVgo42o1
 STqviKin1yTUFHKJH45eGUy7M8t1/6r4VAl95qSXo2ZxjmYdPfvD/Q8qR3Ntl9Y11mSY
 oWih5jYLDqngM+xwwxKrqJVd+FVA79bzb5XJDEcR3yY2ON65+LFBlfVVFyOSt59KMm4W
 Cfmr/ZSkjozprMJyEiuyKicPVvFLpT36QEUuHcaLaBE7Mhszz2XIuLmcUrsrpo4+8JdR
 K4tPARkVLLXhTxgXdq8YHZwiH9cfQjra0x3R95WqYpAb5RGqeeh+lWj+/yiphuA+pceE
 tmEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7sVPhM15Yj08x+w0dj71YNqnZ/PgVYhHV5bWSVRNBoGJJEzlGbYw1Y5oqBRUW1wwnzwqyA+G9VbXOtfCZSOCaKpx8d8o=
X-Gm-Message-State: AOJu0YyHosHAm8yEgGyjlTzJTmwki8/M8Z52GAx+nwj90aIDnYAPP3tE
 jkgE3gRA7iXXRrZnwGNVLAWSUhWlouhnBO0sSwcvVMpOdAOW3vmHNCJERS9XPu8=
X-Google-Smtp-Source: AGHT+IEBs2uzPARDOdFrAJb+5XSppA5skgPksdMswHwsejJ54kPw1swzVIZo8eBbaFFjU06ZE8HxWQ==
X-Received: by 2002:a05:6358:5397:b0:1a5:28a5:f2b9 with SMTP id
 e5c5f4694b2df-1ac901b234amr84483355d.2.1721110055164; 
 Mon, 15 Jul 2024 23:07:35 -0700 (PDT)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-78e34c36e53sm4222030a12.44.2024.07.15.23.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:07:34 -0700 (PDT)
Message-ID: <eca02ec3-e2f2-4994-baf5-b86908fa0418@daynix.com>
Date: Tue, 16 Jul 2024 15:07:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, agraf@csgraf.de, graf@amazon.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org, lists@philjordan.eu
References: <20240715210705.32365-1-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/16 6:06, Phil Dennis-Jordan wrote:
> Date: Mon, 15 Jul 2024 21:07:12 +0200
> Subject: [PATCH 00/26] hw/display/apple-gfx: New macOS PV Graphics device
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This sequence of patches integrates the paravirtualised graphics device
> implemented by macOS's ParavirtualizedGraphics.Framework into Qemu.
> Combined with the guest drivers which ship with macOS versions 11 and up,
> this allows the guest OS to use the host's GPU for hardware accelerated
> 3D graphics, GPGPU compute (both using the 'Metal' graphics API), and
> window compositing.
> 
> Some background:
> ----------------
> 
> The device exposed by the ParavirtualizedGraphics.Framework's (henceforth
> PVG) public API consists of a PCI device with a single memory-mapped BAR;
> the VMM is expected to pass reads and writes through to the framework, and
> to forward interrupts emenating from it to the guest VM.
> 
> The bulk of data exchange between host and guest occurs via shared memory,
> however. For this purpose, PVG makes callbacks to VMM code for allocating,
> mapping, unmapping, and deallocating "task" memory ranges. Each task
> represents a contiguous host virtual address range, and PVG expects the
> VMM to map specific guest system memory ranges to these host addresses via
> subsequent map callbacks. Multiple tasks can exist at a time, each with
> many mappings.
> 
> Data is exchanged via an undocumented, Apple-proprietary protocol. The
> PVG API only acts as a facilitator for establishing the communication
> mechanism. This is perhaps not ideal, and among other things means it
> only works on macOS hosts, but it's the only serious option we've got for
> good performance and quality graphics with macOS guests at this time.
> 
> The first iterations of this PVG integration into Qemu were developed
> by Alexander Graf as part of his "vmapple" machine patch series for
> supporting aarch64 macOS guests, and posted to qemu-devel in June and
> August 2023:
> 
> https://lore.kernel.org/all/20230830161425.91946-1-graf@amazon.com/T/
> 
> This integration mimics the "vmapple"/"apple-gfx" variant of the PVG device
> used by Apple's own VMM, Virtualization.framework. This variant does not use
> PCI but acts as a direct MMIO system device; there are two MMIO ranges, one
> behaving identically to the PCI BAR, while the other's functionality is
> exposed by private APIs in the PVG framework. It is only available on aarch64
> macOS hosts.
> 
> I had prior to this simultaneously and independently developed my own PVG
> integration for Qemu using the public PCI device APIs, with x86-64 and
> corresponding macOS guests and hosts as the target. After some months of
> use in production, I was slowly reviewing the code and readying it for
> upstreaming around the time Alexander posted his vmapple patches.
> 
> I ended up reviewing the vmapple PVG code in detail; I identified a number
> of issues with it (mainly thanks to my prior trial-and-error working with
> the framework) but overall I thought it a better basis for refinement
> than my own version:
> 
>   - It implemented the vmapple variant of the device. I thought it better to
>     port the part I understood well (PCI variant) to this than trying to port
>     the part I didn't understand well (MMIO vmapple variant) to my own code.
>   - The code was already tidier than my own.
> 
> It also became clear in out-of-band communication that Alexander would
> probably not end up having the time to see the patch through to inclusion,
> and was happy for me to start making changes and to integrate my PCI code.

Hi,

Thanks for continuing his effort.

Please submit a patch series that includes his patches. Please also 
merge fixes for his patches into them. This saves the effort to review 
the obsolete code and keeps git bisect working.

Regards,
Akihiko Odaki

