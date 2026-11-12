Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9F606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qAa7qhD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRchX-0002uH-I9; Thu, 12 Nov 2026 16:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xRchV-0002u6-1J
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:51:21 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xRchT-0000zM-Dg
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:51:20 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so1540495e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794520278; x=1795125078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6tysNRGkuMavTaIUoHhz49JRBKbO2q12nPJnFVqvecw=;
 b=0qAa7qhD49O4npt3E4tm09eDtmgrCL0pT6Rlg6/g2JpbuV/BDXwEDVsNiusPA81bzo
 Un40e+v2se+HhtnTeuhPitlcgj0fQ59Gjk8BElSbdVQQoiVjfyCpjlasYi+/cXiMWhEd
 uQPQ4K59OZD9g6/zTsAWQrjZLBVrQApy2p86a8vwq0w1pYe+Msd6rVfMxmkPscrNZpd1
 UaEVCFtGB2WT7yZz+0i4/gqMXRYNlgVXd655+lwoXBICZ6GJXZxkjt3ovSSof5E2bMjq
 aRiDJgPUlVtyicd76GeLLcHGIom4L05WWvsjr7JU6F6zyWueVIgw2KN5Kbgx3VFv4TNB
 Y+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794520278; x=1795125078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6tysNRGkuMavTaIUoHhz49JRBKbO2q12nPJnFVqvecw=;
 b=jCcOvgBoWPEjEud0RDEAKJ24olFwswhK0Z8CjJt4ymMDjpCx67n6OnAI3KOSUBOJyM
 Wz7Ndeh03pJR/VJVhfCGbJP3V+32zxLdQ3Zzk5DLPYPUzogzlhM3Uh9j3bhxNI5MmBks
 P9mSYkqh/ctmhzHz5SlrPIrn4jKPLL4LzKbYaE8Cq8+dQIK4YvWEP8CR0UAnAlfhKWwg
 uakqgRsp9D0g69xqNVyC2tas/v5qkwHxYUUhIukij/u0m9bJSM5vnGl0MGX3PBWXVuuI
 BOGgpObMR3OhGThYBD1udwwgdG3L3yPBZZ/0q8wTEveOYOcUgyY5VQepMKucafgbkyiz
 FNFw==
X-Gm-Message-State: APuU4Z9LcA5i4GyuwWctdf5y8PbUjBpNJPD07SreJBKL4O79QhDI5Jas
 vHNZ291mGoH6pKNBTQWCyZLBliC5hADa3K33qRXgA0QRsFT8fl9AlmFS
X-Gm-Gg: AYBFou3KVuGVDCmnwL4Ue1AUwhQhUVCUDWzSbOZKifTntIBkp/uLAF66U6yTKRUgRBb
 HtWtdJuUoPSSAalKbh6YhIuiIwgVPu32DUbuECRrrj5/i2Py6V+fZlxKkhuAs40xYIxADlN/5DP
 tyKmcE0uNDWPRsdJ5alcSlHAU8qyRRU6twrGYJ4PIt/KBMgkzTPLGr7bRAGyq51v47gQKGI/Yqf
 JY+34URugIkAExyBXd0UT33YB23813NKIg9YecJmHdzuEif2drkl21zEDGSnJvP4NvH0eIOzgO5
 qs/LgdWCt5m8DXxGCJps2NGYXVyu5eDHzCzXGMUd8PD++BvVSIi2hHOJ1hpIo9i79ShAndqWsR+
 eWA6oMcmguX+B8b0Jzw/DAl/e9OUOz2q2jqrHJv2FdWs4unISfhH9n8o+wKqd9nH9AqsZFuiwvv
 v2ORT6wujiwhgXH4UTJHWicSDONgWIVcVdW2Pjth++dHmGnI7VM72wsxXYkDVeXaDbOXR2bRQVz
 40//QUHlRHN8KyifVMB/ZY2fOY/mkoFWHD6Wth90+b98y0PFeAinXy74Zsc/55JuD7Q0vZ+JExO
 KZ4PG11EJnFXM/zNkuTPtMyPWCeb3ef/+18WC6CiLYdkLxTL1K/F/3W7K486+FtznE4WhuNNhiP
 GLN1E
X-Received: by 2002:a05:600c:3e1a:b0:4a2:191f:7cbd with SMTP id
 5b1f17b1804b1-4bb55a3e31emr11235455e9.11.1794520277474; 
 Thu, 12 Nov 2026 13:51:17 -0800 (PST)
Received: from DESKTOP-ECOGLG7 (ppp079166142084.access.hol.gr. [79.166.142.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb566221dcsm4360935e9.3.2026.11.12.13.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:51:16 -0800 (PST)
From: NickSampanis <nicksampanis@gmail.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, nicksampanis@gmail.com
Subject: Re: [PATCH v1 0/3] target/i386/tcg: Fix 64-bit RSP truncation in far
 call/return
Date: Thu, 12 Nov 2026 23:51:14 +0200
Message-ID: <20261112215114.1783-1-nicksampanis@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <601fe158-f510-45a0-92d7-6732af1ef023@redhat.com>
References: <601fe158-f510-45a0-92d7-6732af1ef023@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=nicksampanis@gmail.com; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I answered the previous email in a hurry. Now that I've had time to 
review it, I realize I didn't answer the question about stack switching.

The only case where we switch stacks is through a call gate to a more 
privileged level. When we are doing this with EFER.LMA=1, lcall can have 
any operand size (16, 32, or 64), but the CPU ignores it when going 
through a gate. Because the gate is 64bit, the pushes are always 
8 bytes, and there is no path that pushes onto a 16bit or 32bit stack.
With LMA=1, only type 12 is accepted and read as a 64bit gate, 
whereas a 16-bit (type 4) gate raises a #GP fault.
https://github.com/qemu/qemu/blob/d73149283205/target/i386/tcg/seg_helper.c#L1762

As a result the the path that is switching stack(fetched from TSS)
was already correct and there is no case that we can execute the
other path with LMA=1.
https://github.com/qemu/qemu/blob/d73149283205/target/i386/tcg/seg_helper.c#L1849

Of course the other path of call gate is the same privilege path, 
that is using  get_sp_mask(), without checking if the shift is 2
or LMA=1. That again ignores correct stack mask for long and compatibility mode
(Vol. 2A, the SAME-PRIVILEGE, CallGateSize = 64 branch).
https://github.com/qemu/qemu/blob/d73149283205/target/i386/tcg/seg_helper.c#L1924
That edge case makes the suggestion that I made of just using get_sp_mask 
with SS, CS, LMA as  arguments, really difficult. Because in RETF case we 
wanted the truncation not to happen only when LMA=1 and CS.L=1, while in 
LCALL gate case we want the truncation no to happen when LMA=1 regardless of CS.


