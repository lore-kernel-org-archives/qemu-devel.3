Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2DDC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 20:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s99FU-00051a-0k; Mon, 20 May 2024 16:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s99FO-0004rq-U7
 for qemu-devel@nongnu.org; Mon, 20 May 2024 16:04:39 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s99FM-0003aD-7v
 for qemu-devel@nongnu.org; Mon, 20 May 2024 16:04:38 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-23f5a31d948so1735535fac.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716235473; x=1716840273; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YPr5ajOTLd+OOBkznV1u7eRICMT3GTm4SeaQ4gQlJsM=;
 b=BH2E3WA1lzrU8WBSNO9czZdLiYrOgD/cLpSrcBxsMJOpZizBJIzg2q0xLNGqAGHidY
 9mt3FmShTVHF7UQ/lV+Tox86xk9dYslxfAuaVP1djWd1iGDAp8LpgbTrpsT7CJJtBc7w
 svyCuv0Lb+tmTFNSE+m6O41GUfGSZfVwpaeh1Wyi69ToT0+GheH/9EicSk6zItu4ofdB
 tG/rPVD68REgaTsBLVwDpRQQJH031rgHI/YNwR4Pynqv6a6dume9cmB5zOcVjXfHbxkf
 zmpv7iDK1hS9HXdSPssD7wfkO/+YsO7lusZd4z1vmLwmySNF96COHMDt3QPw3fR/V0Ci
 QTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716235473; x=1716840273;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPr5ajOTLd+OOBkznV1u7eRICMT3GTm4SeaQ4gQlJsM=;
 b=AUjCQugYfCETOm6HGUoVUpVcl86b/yZhQYouR1DOTSr6eI3u7y+tjb6HOJr6KAivo3
 iUeGJlindGfCwVD0OYzdFJPstfO2PlS79ngH1Bxd2tyXQUkcuVw840GUmoWld6y/ApaA
 zwLipGuFsfdXWlERGjXiW1sOU1Llrr39dnBjVYzQori36m9GxhvTUCN7oLUTaFNvcRvN
 KfmvKxVtm93TPmN1t9y6g6RHpFMu/Mwi6aZ5rOwRpljnFgeTNBzPjRBs8PAmjvsBRb9q
 y4viIZWH4EAtTaD5Rne5WTGxKnfh1eZ8K8fAgHFrrswIHmc0RC5+JIQxzPBxQankDt57
 APOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlIiWEGAuzKa2kE/XNtzakNVfzkPtOPifIsbS66WjU/hnaIJAOFPWbFSZi3rLQin3drv11mF/ynkoD7F0bxS0soRA5iHc=
X-Gm-Message-State: AOJu0YxyQa0oCks1Hg+dxxioAd7pVdkO8vA7Xnh/CdIdLhBMe04EApE1
 Td8gLx/m39pLsTiA/uBcQqZ5BzCb3AtIvCN7iv7+I28WRupMv1hV
X-Google-Smtp-Source: AGHT+IG0ILpyY538x6Y9tDqjTPoLWHa9RHoAbJ3Bs3TAZ8UjRaTdi3hUH8cErl66BSJci84ZjMuNXw==
X-Received: by 2002:a05:6870:d285:b0:229:f988:4305 with SMTP id
 586e51a60fabf-241728f4b15mr34840670fac.10.1716235473189; 
 Mon, 20 May 2024 13:04:33 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:2639:f689:1715:fc7b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2412ac7a84dsm5576710fac.40.2024.05.20.13.04.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 May 2024 13:04:32 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>,
	<qemu-devel@nongnu.org>
Cc: <ale@rev.ng>,
	<bcain@quicinc.com>
References: <20240510145244.5615-1-anjo@rev.ng>
 <20240510145244.5615-4-anjo@rev.ng>
In-Reply-To: <20240510145244.5615-4-anjo@rev.ng>
Subject: RE: [PATCH v2 3/4] target/hexagon: idef-parser fix leak of init_list
Date: Mon, 20 May 2024 15:04:32 -0500
Message-ID: <02ad01daaaf0$ee9d4c50$cbd7e4f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIiYfSnFKSEhNVC54cr1TbptsX+PAHIU+3ksQLbMdA=
Content-Language: en-us
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x2c.google.com
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
> From: Anton Johansson <anjo@rev.ng>
> Sent: Friday, May 10, 2024 9:53 AM
> To: qemu-devel@nongnu.org
> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> Subject: [PATCH v2 3/4] target/hexagon: idef-parser fix leak of init_list
> 
> gen_inst_init_args() is called for instructions using a predicate as an
rvalue.
> Upon first call, the list of arguments which might need initialization
init_list is
> freed to indicate that they have been processed. For instructions without
an
> rvalue predicate,
> gen_inst_init_args() isn't called and init_list will never be freed.
> 
> Free init_list from free_instruction() if it hasn't already been freed.
> A comment in free_instruction is also updated.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



