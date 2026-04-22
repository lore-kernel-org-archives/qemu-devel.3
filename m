Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42247F9B5E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTJp-0005j3-R3; Wed, 22 Apr 2026 04:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1wFTJo-0005is-AS
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:52:24 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1wFTJm-0006FZ-TG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:52:24 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8a15ebb3abbso75824196d6.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1776847941; x=1777452741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vLJ6jjlyXA6A4VsEMVcFuuQKoSuUS/x+yvmr7gecmq0=;
 b=LAx8/VQ1+prR5Fpz8feAm/UYLCXayUYzPxQWVkhyfS+qYPgYH9Tjt6bvAMBrrhSN3+
 Ft5sAu7U4EL32dsAMfDVae4Xc+EdMUhxJtHRVV4FM0pgDIU27oyOHFIIPkJcGcLt1Igm
 ncHVOQnTwvqS73NWqswBAM401I5tGR3DJGEbrP//0za9qfGt3rgtNa8k/WW+GqlFHzWG
 GlKu9+7LFhs635QUefvjoI8hqT7B13HBUpGAyxKZFLRfXwiPYA6Bb72zSL/1/mPWJCJO
 wPEJV7r5anCg/DCSwp+ykOriq9Rv5K7h6r0Fle//UvbtBc1P8QF/k6aJuLJ0j672nyGn
 RAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776847941; x=1777452741;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLJ6jjlyXA6A4VsEMVcFuuQKoSuUS/x+yvmr7gecmq0=;
 b=PrQExKRJEvbmotvd/o/oUIEGWWL1ZSHEB3Lcib/f9ke7d7BNLnOesvBgknEoD5wTf7
 McQuxaDyc10J4COtULtsuy0h7xCNRS1tVIB/TdgKzpFMMV7oVX6N+ED74IUFb84g4L6r
 PYJWtBP+TmcK1pwpb7n9qndTeS3PXgjzdn+GHbGGePOCe7pme5Wr7ofPVNVXtAPORDe1
 /Er2S0dKGpdAXxc3BlHoQu22yrCQjVwKX4SQ7rAaY+P3eP/KenrP3Zfb4A4W1Bi8a8Fx
 9l62Zm9GEfd8u6tZw43Xq22G7Pv1JmhyJY6f5v094oMPGNyd19hUS0actFrJcYbli5d8
 93hA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EEGVJ9QHYXPz21o8SDeMjpgwWsHHA0VYcVzHeScFHDtgvvXssoWwVDVA2r4wFCwSo2Tp2hBS9TJg2@nongnu.org
X-Gm-Message-State: AOJu0Yx8R2Np6kOrEj5XLak/g4u9gUngixq4KJ2iABO4eV5SgrLCMCiD
 u+rGJ47nBJFUBaYvtz14pa9tQu65ToIgzVs0OxbtNOddqe4BT2mIYeI8cmpNI1s3tLU=
X-Gm-Gg: AeBDiesZCd8a4hkzzAVH7vgtWm0IJZ4vehh8HsXhHmPSQC+cBs095nZ5ObAB6mRYbnp
 XRkdPw8sudfPLwBT0av+bIyLvWDtWsB1MfFcrRk2kJaC/dT5c/UKI+Bsl+/zK+CoiBwT+EvjoeH
 AKqWNAOcCgu+pUr2Tvh2xUU8xKRUQlrUIw028yajGVgq3QC//p4l0sz8GeOVNDR991qTHa4l4+M
 wvgNEEoG4yjjjoSyRFHr6kGsNCClW5Vgxlp0L5Mp9AohfHGRfJrfNWAHnXFOs1pqwSGrON0rii7
 Mi8hFrbHGrNuXAKvoqVGA5t0aahfaM8KEMw5rtKP0N0VRlZvUsNLH0YXSSPjdqbpa5Zm++9D/Ey
 1bbHPoI2c8HBrSy9qV8llYvMvXjMHuZhndmgV/JCkpCkYEwsJnLzml6dvc/Qyi67D2cdlTveEBU
 b4uStxk8PAM8n/1CXea4GNz1CmsnFfjur0PhAOlg00veW1KRjj6n+ThawvLGqpbjnUJ5XOYdyOO
 nYrBHsS3YU9CDLjTCkWpXaPl1XcFY+roXvrYA01EMF71ZpA8OVxYWv4NMdw+VkugzeySRlY95SI
 Lg==
X-Received: by 2002:ad4:5dca:0:b0:8ac:b258:71d1 with SMTP id
 6a1803df08f44-8b027fcc65emr328471846d6.3.1776847941407; 
 Wed, 22 Apr 2026 01:52:21 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc?
 (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de.
 [2003:fa:af26:200:51a:ef03:a698:a1fc])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac4513asm120970706d6.1.2026.04.22.01.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:52:21 -0700 (PDT)
Message-ID: <fd49804a-c223-435f-a88b-c2183b391459@grsecurity.net>
Date: Wed, 22 Apr 2026 10:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260327175210.369113-1-pbonzini@redhat.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20260327175210.369113-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 27.03.26 18:52, Paolo Bonzini wrote:
> Queued, thanks.

Ping! Is that queue visible somewhere on the Interwebs?

Should the patch be backported to 11.x to avoid the confusion related to
CR4.CET I had?

Thanks,
Mathias

