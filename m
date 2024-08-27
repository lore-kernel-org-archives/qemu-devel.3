Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57145C5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 01:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1silGC-0004XY-Vp; Mon, 26 Aug 2024 21:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1silGB-0004WR-Nk
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:44:39 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1silGA-0000gr-Bk
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:44:39 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d2256ee11so19622515ab.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724723075; x=1725327875; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q90d7/IBHmwLtf046uvYtnaU1ForFQMFhOFZnHzTaqI=;
 b=MRypYVfdONKU0sxX0YBHcObRwb62+wDawDpmaAKuAeaoApmk8xpokFZYqegwdk+0BE
 cI1ggSqhHpR+bLr4jlNsJC/UtGmlcexINjKNpCDRrCTcjHPfEazEyDjR1LY785kPHoXE
 u1t+sxwscLaE6McVoPxmzPyrKrp15fnCNHe7ye53eFIVCANKt7a6BmGTLzHaxLm64m7U
 dn2pZaYNB5qFxYFdlu4RREegYacxPOhLmBZs8OUQSDCn8BM+2dB/vewlDYVRtLP8pZWy
 e2jgXdU59koNF8/p3umWnpGCnhVZSTNn8Cu+f96pUMdh3M4nvXQGowQEDYBIde7Q2HmT
 a41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724723075; x=1725327875;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q90d7/IBHmwLtf046uvYtnaU1ForFQMFhOFZnHzTaqI=;
 b=GmFWJmRtDWBRO+E4ysjDTUTZWOdt0YgRBJhaW4DTXcihjn+N/DCBtV1GV0EfWT9ija
 8GVjqhBcGp0y7XNw5z+cKtJo65t2vWYjvOn/f4H+sIkiilfBDuN984JrthEboafnmE16
 mpt/MfvHt6ep5z18//odm8GVIHlK0OFB5US4mjRJjacPK/etVmgi5fZ5tGzuUd32SKs7
 gvNRtqNHNhCGkYPCyNVvhDExgppcbJ5zTV+CaqLaIjohypZANCaO2kbRoxcxBLrgHyfj
 0HznJB0ag1ka406QajoO/8a9sogUMDAqFkF2TBR+RW+5oJxty78Hz6zGObeA0UaL3k1j
 CSYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgaaX85nXxeq5xtbtSvKoNt6T05sRdFwnkx3ZIH55rHF3Djemr8tg/PDGXCxPfH1Fqy6x5AEADnG4l@nongnu.org
X-Gm-Message-State: AOJu0Ywe5LYL5ZxvZnfHrRMl1s8Nb//NPbr8Hrn13slZKg+PBXi4DOui
 aqrtoqnlYeYWHigSgLCyZ4rTPIjUzAj1oPJxI2iQSPjHHjmiChAn
X-Google-Smtp-Source: AGHT+IEOG3sVSJshgR6LWg9PFE2aclWMXnGh3lMByRfqxe4lnhNwBUceQ5smT72wilHtnv7ZZZVvpw==
X-Received: by 2002:a05:6e02:164f:b0:39a:e9e5:62b with SMTP id
 e9e14a558f8ab-39e3c97532amr146115135ab.3.1724723075086; 
 Mon, 26 Aug 2024 18:44:35 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:d990:ff71:59bf:a3e])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e68e4asm36405065ab.10.2024.08.26.18.44.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2024 18:44:34 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, "'Laurent Vivier'" <laurent@vivier.eu>
References: <20240827002631.3492200-1-bcain@quicinc.com>
 <20240827002631.3492200-2-bcain@quicinc.com>
In-Reply-To: <20240827002631.3492200-2-bcain@quicinc.com>
Subject: RE: [PATCH v2 1/2] target/hexagon: rename HEX_EXCP_*=>HEX_CAUSE_*
Date: Mon, 26 Aug 2024 19:44:33 -0600
Message-ID: <000001daf822$ab12bf40$01383dc0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLd+W9ohof6Agj59aNvpT7d/saPhAJaSiC3sCF//nA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Monday, August 26, 2024 6:27 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com; Laurent Vivier <laurent@vivier.eu>
> Subject: [PATCH v2 1/2] target/hexagon: rename
> HEX_EXCP_*=>HEX_CAUSE_*
> 
> The values previously used for "HEX_EXCP_*" were the cause code
> definitions and not the event numbers.  So in this commit, we update the
> names to reflect the cause codes. In HEX_EVENT_TRAP0's case, we add a
> new "HEX_EVENT_*" with the correct event number.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  linux-user/hexagon/cpu_loop.c |  4 ++--
>  target/hexagon/cpu.h          |  2 +-
>  target/hexagon/cpu_bits.h     | 15 ++++++++-------
>  target/hexagon/gen_tcg.h      |  2 +-
>  target/hexagon/translate.c    |  6 +++---
>  5 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



