Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2F7D5E39B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 07:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA25P-0007ig-R1; Sun, 10 Nov 2024 02:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tA25K-0007h9-Qj
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 02:10:10 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tA25H-0005yy-7V
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 02:10:10 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c7edf2872so37146495ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 23:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731222606; x=1731827406;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzR5FQxch6iZdJ2G6xZNMSnzArOzVGdnFhFcZDcqkxk=;
 b=uc3yrynNhRyIj6/V9wg99CiQGAAQzEEdhlIQJVN/iuoGjHLelnGDfc6pvjCkzfkojT
 8NXAB6/w0Ot9ips/3CwKudGG9mwJmTE7jfmLt2y1LvPw+Tve7Ds8Pokma3PgL51Z8e/a
 ZxWw9Qhk8gg97NsU7atXldp8mFDtyy9mTC5keuoDi2o9FR6s5FOYFvPhzObktg4gtNjp
 WLDduz6QsajOZfruRK+gPnPc1MNsjVB8zwkS9bNnNoaZGUocAoYq8O5BHZG2KZuJ8ZKD
 JdmmaEJX0E7cKEfc6VhXcpXVDGsxhERE8Mp7s0RcgOktUvWCSBdLUqROtx8fWjRJGKe2
 d3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731222606; x=1731827406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SzR5FQxch6iZdJ2G6xZNMSnzArOzVGdnFhFcZDcqkxk=;
 b=DuEPHGnBMQOS2dic5R1vH2eY2K/bfNkDWuNgM+P1RIIvYd0/h4nnHLaS1L0YPEj7iS
 BGsbNx8dQHD039Qofgf+p9Z60eBuVA9mB8qfS+jqI1bLuz7U2kJJ3+3DbyYnXIv9y2PE
 Sy5D2JM9p/w4SIZCwR2B8zvb8um0RxpRSXZmROopS2xkhXRWMtKFVy4fpV3kLasE/FWA
 EBeMC9qB8sC8HX8bjxK707Ekq5R+1/GxegxbJ+rrya18uegibX9DS53U31ILXWmRaLLN
 PoWg5bFGEneoTzEVIzoGcFl1JzRM7NctsVNngYRQMPCM/J8+erUWcXWXYzyqD53NmGDr
 Kr7g==
X-Gm-Message-State: AOJu0Yz1vypcxxS//umplgfqCeSlX8DEUawutABcqqIuIG6HuVsHYHqy
 7yTIcDet2VPrCiDwrho2Rc9Mq3qeTayYvhA5Mf3s3tWzWQbRHSTwDV4ZYgY5ehQ=
X-Google-Smtp-Source: AGHT+IHKM+7VFs5m3+7OVHeUfpNBDnHaPjsz09+9hClq8XNtokojh2r7BSRRUNI7hBOQZUiED+0G5Q==
X-Received: by 2002:a17:903:230a:b0:20c:6bff:fcb1 with SMTP id
 d9443c01a7336-2118369d530mr131393595ad.1.1731222605630; 
 Sat, 09 Nov 2024 23:10:05 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc970asm55432285ad.52.2024.11.09.23.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 23:10:05 -0800 (PST)
Message-ID: <07ec41b8-922c-4c6a-b550-63fc4481d019@daynix.com>
Date: Sun, 10 Nov 2024 16:09:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-2-phil@philjordan.eu>
 <9c2e0b96-2125-4041-9f66-116d54accb04@daynix.com>
 <CAAibmn3NbtOEwWLQFOo_UmAGTehOj+dDP04A=-JGMZVK9AYMDw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn3NbtOEwWLQFOo_UmAGTehOj+dDP04A=-JGMZVK9AYMDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/10 16:08, Phil Dennis-Jordan wrote:
> 
> 
> On Sun 10. Nov 2024 at 08:01, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
>      > macOS's Cocoa event handling must be done on the initial (main)
>     thread
>      > of the process. Furthermore, if library or application code uses
>      > libdispatch, the main dispatch queue must be handling events on
>     the main
>      > thread as well.
>      >
>      > So far, this has affected Qemu in both the Cocoa and SDL UIs,
>     although
>      > in different ways: the Cocoa UI replaces the default qemu_main
>     function
>      > with one that spins Qemu's internal main event loop off onto a
>      > background thread. SDL (which uses Cocoa internally) on the other
>     hand
>      > uses a polling approach within Qemu's main event loop. Events are
>      > polled during the SDL UI's dpy_refresh callback, which happens to run
>      > on the main thread by default.
> 
>     GTK should also do the same as SDL and requires treatment; I forgot to
>     note that in previous reviews.
> 
> 
> Although it‘s possible to build Qemu with GTK support enabled on macOS, 
> that UI doesn’t actually work on macOS at all, and apparently hasn’t 
> been supported since 2018, see:
> https://stackoverflow.com/a/51474795 <https://stackoverflow.com/a/51474795>
> 
> I don’t think there’s any point making adjustments to the GTK code by 
> guessing what might be needed if someone did fix that to work with macOS 
> at some point.

But there is a GitLab issue saying it "sometimes" crashes, implying it 
works otherwise:
https://gitlab.com/qemu-project/qemu/-/issues/2539

