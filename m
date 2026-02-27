Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6093103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Uy-0006Tv-6U; Fri, 27 Feb 2026 17:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw6Uw-0006Ta-Jy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:39:50 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw6Uu-0002i1-2Z
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:39:49 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aae4816912so17233875ad.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772231986; x=1772836786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3aBn7oDstSF5pDlGBNmOROIEaCP7iGPOrlkqVK9y4Y=;
 b=IRxmSWnHj2Mmn2l82WiBEXxnzFzhn7eTxMw2m3b10YfP5WbpUDPLVTsLZJRxkJw8nH
 J81DYh581azVBQEUNnzODN2VM6S5rV51LFccsokYSzNP3SDwYL8fbSnS8HBth9GGjtdJ
 d51JezsE2nUuZQBOYt3qhsLOlJAjjTa4HBO6iz94LC3j8wE5miFCUu6jPflLW0yG8Cui
 Ee52UYzU2NG5UmrSTkfN4630QJrgZuqk73BucRpgV4VYvq7tsaiIg3gESjGtjIsbHaEV
 qG4urRvmf14yvhDEC25HPZfPVO5s/YFR0Zc10UvA2g0vfPYnmNAyiPI34zsZGuDVifvX
 ZE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772231986; x=1772836786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3aBn7oDstSF5pDlGBNmOROIEaCP7iGPOrlkqVK9y4Y=;
 b=EBA+624pBumBbLzss0aJSA6uGikTk93Lo6ek0mo2Ye4SIzHStJ3hTXXEF5znnlgxRR
 7RF1l3u7SK2l/ZH42hN2rvrnLm11p7T1LVikdvfr6B4+Y/o3wmcNyApZlBEp74fT6Z/1
 4z7mvNI7geokW2CwakXIzH5XLbIgq00bCqhxi4LjWF7qbx7tWsYQuGCR4Ll9aKgyxPr+
 dPDAQCm2wOKKVbmCOC0l0/30qD/eWuWfWAiUvHcVu3pGQklxWRWoPjOD/Ao+wqPGX6i5
 ilpLZJ59QFzhqiP79WPgdahsPCHaWvrFq0U3OVoqs8MmQfMVykacXtU4MhwI9PDsPo+D
 5acg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9kXRh2Hph1IPKVuib+2ySCVoreuoTxhSYOuwQktOlzEuxdkEqTiovEfdo2+ViRFBQw68Zx/c9XZ89@nongnu.org
X-Gm-Message-State: AOJu0YwXjoLNjtAysaskfvcD20JaGnz2z3ab2AnjT789i19KzzgDFAO9
 wBs4LUx4JSpO32fQnWko76UNQhUil13OfdB1/URWyusvftGVEMGRVh+PVt2H6iPPSSc=
X-Gm-Gg: ATEYQzyq0qHwS4yZFw9NaszCxjuz/2b0svXfJhHivxtgp0mJLlpGrUeOwY7LrqHYayL
 YnuECORQ1T65ZZz9C0ey0hReREVSBApV9vfYP3pY6wtzq42EClzqbxlNaipBQTq5NI5YUW5969r
 OiBI7WGCF+3lH+HcPM05dn9J0Uw+JVSjV24Ats9mWUZ5u9f1HDREG5qmojN47VQBJF336TB2xda
 xZxYYRtc0ZNoYkoUb4huo6h07VTZzTSNXAl7qrEEjXe1XkUox0McByoy33SqXqvCGsMvP+6J9Vy
 000UF7oLaDEnoWqHajPVHPAJqkxUQteEqFc50bhAoXalCxpGLQz0IgZ2UevM1hZzmh1GCQ/ZjPp
 sRUCOXlp8hvolQlPBCxJhKu9he3VNhenU3hXtGs1YaJE+YIu8quvq+9J/ylWghiU+zhGVtRWrqt
 /rM9pvbpsjYSlHlxK96h0EJJKhnAvN/g/Tcfj+0pSmaNnGe3spXvP7HPArkfWQlVdI6kek
X-Received: by 2002:a17:902:f60b:b0:2a7:51b3:859c with SMTP id
 d9443c01a7336-2ae2e500d6emr42164195ad.57.1772231986108; 
 Fri, 27 Feb 2026 14:39:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb69fff3sm71527415ad.48.2026.02.27.14.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:39:45 -0800 (PST)
Message-ID: <d381b443-93e8-435e-801a-eae414216940@linaro.org>
Date: Fri, 27 Feb 2026 14:39:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] gdbstub: Always infer base register index from GDB XML
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
References: <20260227213958.21170-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260227213958.21170-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/27/26 1:39 PM, Philippe Mathieu-Daudé wrote:
> Generic fix for a latent bug reported by Florian:
> https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Use the 'regnum' XML tag for feature base register index
> (after fixing the incorrect m68k FPU ones).
> 
> Philippe Mathieu-Daudé (4):
>    gdbstub: Have scripts/feature_to_c.py generate more verbose output
>    gdbstub: Make base register explicit in m68k GDB XML files
>    gdbstub: Emit base_register index in GDBFeature entries
>    gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
> 
>   include/exec/gdbstub.h     |  4 ++--
>   gdbstub/gdbstub.c          | 16 ++++++----------
>   target/arm/gdbstub.c       | 21 ++++++++-------------
>   target/arm/gdbstub64.c     | 19 +++++++------------
>   target/hexagon/cpu.c       |  2 +-
>   target/i386/gdbstub.c      |  8 +++-----
>   target/loongarch/gdbstub.c |  6 +++---
>   target/m68k/helper.c       |  4 ++--
>   target/microblaze/cpu.c    |  3 +--
>   target/ppc/gdbstub.c       | 11 +++++------
>   target/riscv/gdbstub.c     | 18 ++++++------------
>   target/s390x/gdbstub.c     | 15 +++++++--------
>   target/sparc/gdbstub.c     | 12 ++++--------
>   gdb-xml/cf-fp.xml          |  2 +-
>   gdb-xml/m68k-fp.xml        |  2 +-
>   scripts/feature_to_c.py    | 14 +++++++++-----
>   16 files changed, 66 insertions(+), 91 deletions(-)
> 

See some check-tcg failures:
https://github.com/p-b-o/qemu-ci/actions/runs/22505136358/job/65203283939

Regards,
Pierrick

