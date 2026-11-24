Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7A606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IOH2pST6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVyDI-0003cQ-U3; Tue, 24 Nov 2026 16:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVyDF-0003as-IP
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:38:05 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVyDE-00070N-0d
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:38:05 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3b3fb193c03so2152941a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 13:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795556282; x=1796161082; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zhcNQXedod9i5fkiIjQ4ZEhkhxml3kRh9gcExODqk7A=;
 b=IOH2pST6VTZAwg9atx8mfGJT3g2s0vxHh58Vm7O1huQbr5mm2xmoHUS5BTKcEHwPIf
 3lyNAedbqsq7LErbYSptVAym+ChE2mmyafcxnAxta35PihBoUrv97nS1KJqvHDtdoSIz
 sv3qU704bdF0MEf2+gTP1U13VdjkPBYvsRrjLfjuETnR2F1tQQbc6ewHC6A9lCh7NVTc
 Pt8tjzgb5Bec4AQQ4vHLiBVYQIlC131S5cVwDLn1fcl2uhPxQ/ADtt/Y1L1vIT1OLSQi
 q6eWSU8Acf8L+cZ0SWXfDT/HOa+XIGz+UitKyrMlqCdVzVZdeJX5wOcr/8Obm/sCXD2d
 OsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795556282; x=1796161082;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zhcNQXedod9i5fkiIjQ4ZEhkhxml3kRh9gcExODqk7A=;
 b=dLdOkCWg0cbycXEd4BEr/F5D1XpLbj+GtzJuyViBlBYqW0/NPEGFtNzYrdfDF5RhYs
 y1+iAdb7DtpvW42NPSvbwEjQG/FUAo8m+8/vpNC0lmY8OVjkvyZcHgumuYZaGdkKpgqv
 +9holYaQbllGCLIH0qQwh1T0iltBXvKcwWQ8/zGLA0sd9FNXie/ulKhFV68B/K2cxW7W
 3pf4goRKoknwGYm2unPp9y80g2CRs5ObzBLAourRN5eTHAIJNLu67OFf/hGQxso3ObSm
 Pz0he6TpXt6rlVQ+TwGlocBAmSbDyfoLWykeoR0X/kvH8VbWavFg0w4QrQo0WJR35AVE
 wOug==
X-Gm-Message-State: APuU4Z8xFh1y+wmcJMqbc0Em+dHdzptICprknI0582gIWtZtMpHGoJvh
 eqbHrLatnt5Ok2zAi7GJbwpPVGoZXb0g7inRQFhvnJrS2u1MZZFiCvz85N9hO5AnPho=
X-Gm-Gg: AZFdTZfx37Wa+E2GFoatTrTCNjBvyP8jrQA2jK3FayStZy6mf0QdN4aT6xaET6ffeXm
 AF2dDoUw199FTwtm+F3yHek6s7dPJxeVfWWX7M8GnhCp2sNF/jJm4kSwvlpvNistnw+wMtKgXSG
 GuGZabSOfqhZhZkTiPiSA3tQ09PIV7DJWhaZQ5Os0At1nBaf1VjdlCqGrswo20W1np6p3S2k8US
 bxQ4yrt6cMQIOBrCyU2f0k/HY8KSV2TXCn2LwB+JXbUzsbkJW9RTad/JSi2VpvPiBq6YSGCDP2C
 DU08QLzRptB5hP3WKcjXmNa/vPQLdsk8N/SRd/eVmXQbGS+bGe4CqzLQSSFag91tj9BTRcQbG4f
 kV0LcO/KxcUXJS1oyf8ZoAY7qz+1M3epLTYs8tp1NTz8z8Pw33gEzF4FXaRZKmVTwVnQtTs+6P8
 qLxRq+cZ4rKIHEJqJGuQK2j5pQTfGVY95tNP4gE7BmB4k2+9lrQoKb+TjBACbCt+igKZ4cwR7IS
 pTA1VmjSGTpQttT4E/rrMqF9Jalr89BmczDZKRG+ALdA8a98krmNOPsBOKStwlJ9YVtNpq8cf/K
 NaZMZXdnyg1GOb3qgDd0rEBlr8oHcRhK2Lk23Feh/d0=
X-Received: by 2002:a17:90b:4c4e:b0:3b4:d22:85fa with SMTP id
 98e67ed59e1d1-3b41c98a150mr14722112a91.14.1795556282361; 
 Tue, 24 Nov 2026 13:38:02 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0a33fsm24830193a91.6.2026.11.24.13.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 13:38:01 -0800 (PST)
Message-ID: <0e0f553c-6741-4808-a138-bda1d327cba1@linaro.org>
Date: Tue, 24 Nov 2026 13:38:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less than
 a page
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
 <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
 <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8-UQPdJ4na2EXfFff+Nw547nYVDfQcK-pjLr6ykW=ThQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8-UQPdJ4na2EXfFff+Nw547nYVDfQcK-pjLr6ykW=ThQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 12:38, Peter Maydell wrote:
> On Tue, 24 Nov 2026 at 18:42, Peter Xu <peterx@redhat.com> wrote:
>>
>> On Tue, Nov 24, 2026 at 05:37:23PM +0000, Peter Maydell wrote:
>>> The atmega.c code explicitly calls
>>>          vmstate_register_ram(&s->sram_io, dev);
>>> which is why #4877 reports that we crash during migration.
>>
>> Ah...
>>
>> This seems a hack.  I don't see what we benefit from g_malloc0() rather
>> than using memory_region_init_ram(), it's hand-coding how allocation is
>> done.  IMO we should switch.
> 
> That's what it used to do before commit 9f99072fc08 last year,
> though. I should check with RTH why it's doing that so we know
> what we need to test to make sure we avoid breaking something.
With respect to AVR, there were complications due to a change in 
TARGET_PAGE_SIZE.

Leading up to 9f99, we allocated ram at a target-page-aligned location. 
We still do that for certain cpu+board configurations (

After 9f99, we still allocate ram at target-page alignment for certain 
cpu+board configurations (mc->io_size >= TARGET_PAGE_SIZE).  But failing 
that we must allocate ram at a non-target-page aligned address on the 
same page as other I/O.  It's that sharing of the target page which 
requires allocation "device ram" and not regular ram, so that it's all 
considered I/O.  Thus memory_region_init_ram_device_ptr and not any 
other api flavor.

As for the question that Peter's actually asking: I have no idea why the 
memory subsystem is requiring aligned addresses.  My first suspicion was 
something related to qemu_ram_block_from_host, but that properly handles 
arbitrary addresses.

My preference is that the APIs don't enforce host pointer alignment, 
because I can't see a good reason for it.


r~

