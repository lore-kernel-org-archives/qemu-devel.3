Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80403C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 21:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf4YH-00058N-7L; Fri, 16 Aug 2024 17:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sf4YE-00053m-U5
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:32:02 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sf4YD-0000XH-Db
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:32:02 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81fd925287eso102008239f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723843920; x=1724448720; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vy/n8mlzqwKn7GxhQdAMxiuJghrT1X2vOr0nkwydxW8=;
 b=csVSd0UlWkmdjp3UAihuvlm1iRyxk4w/0JycLxtAwp4wzW+NeKtmNKE9yI42C6rupG
 TzBuBSMcOw+P3+EXN8VZk62NqTZC++Sx4BEiS88Id5iXs/8uhbZe8WhOvi2n411VKyK9
 Ge+EefWJmov3zK+lhNZgw2BrWByvZpZCsMSdrlcjH5OfoxjO7MFGKWBUDWKwa3SZaaL+
 yBSecFbtSzSX4I+RbpZUuZ4RhAXE90FzvgAbJdRnwUmMxgtJ7p3WG5FZpEM8D2ip4fc0
 tSZSXxSJYppuBiqlrZhrC8ZsfRVwx3W9JViKwQq4doTQZPP2KULDWMCRmcQEMRP8G84c
 Ylyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723843920; x=1724448720;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vy/n8mlzqwKn7GxhQdAMxiuJghrT1X2vOr0nkwydxW8=;
 b=KaNZB7oCFF0jAU3VCd+xzBX1MbpstER9kw4QJH/cCr/OEnUYFj0GGMpIs7oT58VtcY
 ibK4LwXwwmbD+tlHVdCa55l1Q9cKxFTqo+MV2EYU9nO2jgb88ioJTYwl4kwiMuACyl1K
 h9e4vOoKloov/5chB+i+bKAniZgb6KqSU9OXoVNkQCowCojv21rGNBu7O/hAO7O55tqB
 u6A/sptkgiltio+RDdnP+wUOMX0xhw6G/YbM7eya1zOet0IvJExwvAWRUtqARXOADY5j
 IBDsPn3lohJSJ+aC3MQmW66n/gjMrsi5XjZzig4jXeOKefHNUQMONfx8gizRnyKoXyYZ
 49Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4e9EGlPxxqqrxFciN1+zQQul2yC094Aarxl+hJCWi+uf2IKa5qxuC8BFVY7P8SWcVerlm1GF3sLk8poU4YptyiKQ+t4M=
X-Gm-Message-State: AOJu0YzFpkg9dEa7K/6mSI9cSuxHKqdZaNQ9/AyB8a8ZK0NSSdYLgUgJ
 BtkXmXdV5RChX2RwI41PnBBsvWluTLrkZAMiyvsHu5XV92w5jGPtvy4M6g==
X-Google-Smtp-Source: AGHT+IFQL0neHSgmiSLOfSYHdcCofx+p7MwN8SVrLF9Db4Spb11I0JG3Q5e1EUyrZK1WMVHhG5YoKA==
X-Received: by 2002:a05:6602:6084:b0:822:3df4:64c5 with SMTP id
 ca18e2360f4ac-824f2642fd7mr493939439f.9.1723843919801; 
 Fri, 16 Aug 2024 14:31:59 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:8166:7e5b:29b6:51cb])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6e9d253sm1474145173.72.2024.08.16.14.31.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Aug 2024 14:31:59 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>
References: <20240816190620.1418311-1-bcain@quicinc.com>
 <20240816190620.1418311-2-bcain@quicinc.com>
In-Reply-To: <20240816190620.1418311-2-bcain@quicinc.com>
Subject: RE: [PATCH 2/3] target/hexagon: rename
 HEX_EVENT_TRAP0=>HEX_CAUSE_TRAP0
Date: Fri, 16 Aug 2024 15:31:56 -0600
Message-ID: <019b01daf023$b9dfe270$2d9fa750$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHkSSDsbHa0lsPsUwH6PIsqcGtF+gHS+MQusgkc9SA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2d.google.com
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
> Sent: Friday, August 16, 2024 1:06 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com
> Subject: [PATCH 2/3] target/hexagon: rename
> HEX_EVENT_TRAP0=>HEX_CAUSE_TRAP0
> 
> The value previously used for "HEX_EVENT_TRAP0" was the cause code
> definition and not the event number.  So in this commit, we update the
> name to reflect the cause code and add a new "HEX_EVENT_TRAP0"
> with the correct event number.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  target/hexagon/cpu_bits.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



