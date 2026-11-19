Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC49606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EcLWFaYO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3lE-0003f8-4R; Thu, 19 Nov 2026 10:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1xU3iZ-0002Y3-5i
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:06:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1xU3iX-00027T-5M
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:06:30 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1376508f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 07:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795100787; x=1795705587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UIXpiuPmdd3zgeei7vxXr80oFgq0HsbfPuNa1a1alrg=;
 b=EcLWFaYO7IxZ3EPVgm/1e1qhp7fKCpz7D/2HSdsXFzBgiP/mliLWHhParT6wxAa9ZQ
 hhSfxuqTl9D18yJPBlhH0vXRnbu+N7HzKpX+QcIIW/3o8cCtKs0dWPOQV0IKcupxpvv5
 hHJrPQvdRV9eJ13Xb/oykYzy5XvD1vfQBCDsZ49+vmmgJ03W6za5Zn9jTa2iFnXF2PEl
 ZJYZONfx2UCg+Nh0ZL2qCS29gDHM1RpXB+K6pJZ0nBqiqXJA8NgGu2HozqILxk2/RRJx
 zgtiQ0oRcwemZb26HMuomyeZTFQnF1162IaGCXyMssBruWRdL/pMlVy6Y1Mrmaj4DW5X
 CUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795100787; x=1795705587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UIXpiuPmdd3zgeei7vxXr80oFgq0HsbfPuNa1a1alrg=;
 b=tX/AAiiHEfprFwf3T2LAEjGVXnFuST8VwoGir+4JgBJLTBzRJ0bmrJx/xbJwhxjaoc
 s2vpoSo2NP/wBcrrNG78xsEzkhn4pnH1iDyoJFJt8RCdOohfpYb3hfa1Q7hhJjTpyeSv
 GL1XMys29g84/uHm+K7RLbWKoAp0079RGUhqt7RHRBZ8g551msA3q2sBm78UzI00BP0S
 oVZxgQVnIUBEQDrG27jpYuQTmhahO/YTlvxyiOLF9ymM00xolbeYUKdqcJmjaLZbJbK/
 PLJW0HJOMxxQyxLGEkr/DtY1V1Vk/kDo4SR/wldbQ+YOsKdll10ngh8TMcqwYHTfe4wN
 Fs0g==
X-Forwarded-Encrypted: i=1;
 AL+hErFuTmCrfNuRVjWzdkF0GzSKyJahaSgm8pc1CVjkaveKku5N7C8o/JqJkZmo+qZ4YPfJQV1mQjTRKk4H@nongnu.org
X-Gm-Message-State: APuU4Z+vwFFM5h7yrx1MjtdvMJF7z3iMbVphoxPDILb/IPQtiA5C3ud2
 ugeDUr6f06G+pT9UFf3xUenMasQ+eVm2aNtFT1orocqKYXjHMbsip0o+
X-Gm-Gg: AZFdTZe918J7ExIVlM3UV75n55pt004f+hkx1DTVxVhIQpJ1cZCWhd0qqMtEhvF6aWK
 l1pdthceUWN1Ha0WohyOrfVwod+Wx8H+5Oj3o1hOm7OKjvhVZgAkPsAbPhHAWCQ+O52z+RnfQyl
 fOf9c01WEpHCj4QwIepUPm1qbw1S2lHbHF+nDE6Yjmy3M9+Pz8MMowOjJY2FiRn0hUyPru3SgBf
 G8s+ifCsB/+oHwMmG+WTBtq+74prnZgam3kRwufEeHEO6mV6RuSKS+8NKembQCPN76pc7auMPdV
 eF6dPNHZgLui4t8vN7fgINi5eNvShNAQZj6mFTS9uiGp9Ygu9zNoLYS3VT7uSDzR80UMziCa0uM
 kgXfJ4qcuE/GPASateHwNqupcTun7kmUjEEy9egnA10GuceBklhavbUxE/4ZguIFb7yeFZUl2v3
 ExrC8tOuZVGyFOTZ1wzb+t+W62oYRgySqiiwtLcaAUV5ULPxKMry1OC6U35/WeGrfEuuevF0KHQ
 3c2LbgfUjunhkqaaKLuNkzebhR7j62BsqWyp9w0PTjjEb25qN4bZxbRuyD+qynzgTwlNltI3f3y
 SVslbx/qiOWht4OIH3BpRxrRw5drXskB0oPfmA==
X-Received: by 2002:adf:e191:0:b0:4a4:f86e:d90 with SMTP id
 ffacd0b85a97d-4a63beaa18dmr12153364f8f.52.1795100786768; 
 Thu, 19 Nov 2026 07:06:26 -0800 (PST)
Received: from NB-8855.yadro.com ([89.207.88.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm137538f8f.8.2026.11.19.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 07:06:26 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: sergeev0xef@gmail.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH] accel/tcg/cpu-exec.c: Wake up gdb client after WFI
Date: Thu, 19 Nov 2026 18:06:21 +0300
Message-ID: <20261119150621.64922-1-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102132630.1424100-1-sergeev0xef@gmail.com>
References: <20261102132630.1424100-1-sergeev0xef@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=sergeev0xef@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello! Please take a look. It's RFC for now, cz the solution seems a bit hacky, and would be glad to know if there is a better one.

https://lore.kernel.org/qemu-devel/20261102132630.1424100-1-sergeev0xef@gmail.com/


