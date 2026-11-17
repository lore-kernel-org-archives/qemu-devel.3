Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29C606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=O2p4T8fF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOVR-0007NX-U1; Tue, 17 Nov 2026 14:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOVQ-0007Mq-7J
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:06:12 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOVO-0001UB-Pm
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:06:11 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so127803a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942369; x=1795547169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lH+HHzA7JaLtWOt+cNCGQZO6VmmgnQH7MnC+PLpA8s0=;
 b=O2p4T8fFlPpAtnaZ9Oy55/ZF/XufZvya6Q3Xd6lozs2qMdPgg5FivqcsijCzFwU//t
 ledte8+uv+IsxqGtWgCgMAAL24svnu9/4SCXWJ8qpAYCNIaLMHGTL5c9uwznDRMEeOJT
 oGDXvrzAJl9/7lnskS4+H21RVtAp5e2Nh25972zEo+wl8ZHR1zKzHUHW9H4OlQA4vxvc
 5QkmshIRZSjxUly2RWXs98EB1bW217oRQx6ZcfzWQpPq6b7gi4vr1wFSJ630h/HOBN2D
 FkZhHwE1l4ykMV+p07auhoo5PDglROURc4yXQ2pf7AqRoVWDfR9EbrQB8/198ZHrXtLw
 rhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942369; x=1795547169;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lH+HHzA7JaLtWOt+cNCGQZO6VmmgnQH7MnC+PLpA8s0=;
 b=jkW8jCT/yfRN1WBXj9SVs2+oAx+Pb7fFvHjuZYkneQCDDDbQ4pl07hR+IUqbmlndMR
 +cJp84shx+w81VEs/Osnd8mEBrdBAEZWrcAo0IDsTsvyiC/ItzUCUPedOmMgxOXFtSmR
 ytOqNQfBkh7/3MkuL0NyE2Dz0Sfy8jytUl7dZaAR3lj+Hp2M5Cc3ojJwH5BfFQJ039qr
 zEDR9IaSwsSlv0jc5R1tfDdovyDaKc2TwJy9txo3eRTv1eyHu0Kr+7nNYRp5gU13FOYy
 8QuvzmuOgfh9Y7TbH5wV2MEij1vbG4b6XsVFtrr/oWlaTr4J+as0udN+bznIqWM/5wKf
 nEig==
X-Forwarded-Encrypted: i=1;
 AL+hErH0FZ3BSVnyPc2jCPWKAW88H3bj8ixp82CQnfgW64sK+JM3oPR/V5JJW+/WzF+p5rb7zHK+kjtco9YA@nongnu.org
X-Gm-Message-State: APuU4Z/EkRnLCfBVoyUtZGnWsqA7DkvIEtLrT1tRHPagn1b0pKjUbsKo
 Eowl1aplFj7tWH/QeKw+VbC74BNJ5zqdHRWvPHL99J0fbLSgo97z/t1s0ZFZt9KWbTY=
X-Gm-Gg: AZFdTZekN7kidjHkja652Amu4TyOnobX73sFA50Xef8hXtu5URwIq1QStPVJLuC4f5f
 OIZdkdaLujZ2u/d/OR6BIJ1OR0TyF2Smnhs+Vh94AiH4YEqapmdhimYg9I/VmRcPxXMbBrSvG5V
 O2BUycEjy0aTObMp1IUpaLmrkpg7UIrdh/DEcI1hIoBaKBAkxUUPUfvhg/y8gpsoOOJ6CpFOfZO
 SecxN+nMbwNEvy63joxEOFaYQ5icqVR3i3zbor1rAfUUGL+BQH9mhboidnQy1uDDQK4XS+Febiu
 xUrQS7luLt5dEkxII7LJI/oCXUf+VPltzTwgxvhen4lvYd8iKYEl8Lt6PqJlyivl3FubpQcgnCL
 xQ4CeM12+DlchC5Bstj++RpZxqi8Q60NnucLT8TMaYW9XkhX8cwqgAi4+oYa6/rnOIgiVCZ7o7t
 DC9u2QxRne56HAcqTEwovAQX6tgOR7oN5DXV1k0nEZtnWNaTEZBKjdhJDffDxIsZVJPDUY/bZIh
 sZxoRqkd8g9oF0GRUcBL8QilAmYwxmol8JCDbghOTExteJObBtlSpE8a16r8djmlJpsQsCnOemm
 ouamCh94k+YeL/zyF4sH5wrlwkfPur6hTp/bRbkNTNLS94943ykVlBx0tMF7pQzQ/hZWi6qEU+9
 cK8upx29TBW5UZX3S
X-Received: by 2002:a17:90b:5605:b0:3a0:a912:e759 with SMTP id
 98e67ed59e1d1-3b3d07649b9mr296187a91.25.1794942369079; 
 Tue, 17 Nov 2026 11:06:09 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac254ba6sm5260950a91.4.2026.11.17.11.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:06:08 -0800 (PST)
Message-ID: <e29b6e73-8133-428a-bcd7-c461fce06530@linaro.org>
Date: Tue, 17 Nov 2026 11:06:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] target/mips: Fix reset into microMIPS mode when
 Config3.ISA is 3
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-7-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> The Config3.ISA == 3 test ANDs bit 14 and bit 15 as two separate
> constants, so it is always false and no CPU resets into microMIPS
> mode.  Test the 2-bit field instead.
> 
> Config3.ISA == 3: both MIPS32 and microMIPS32 are implemented, with
> microMIPS32 used out of reset (MD00090 rev 6.02, Table 9.67, p. 248).
> 
> Fixes: 0bbc0396809f ("target/mips: Prevent switching mode Config3 ISA bit nanoMIPS")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

