Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B5606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kxQXtQil
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKc57-0000Zc-Ic; Sat, 24 Oct 2026 09:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKc55-0000ZJ-0u
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:46:43 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKc53-0004rO-Hr
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:46:42 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso4001692eec.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792849599; x=1793454399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gcfjGkYvg2DopM1kqVzf+BV93I6yaVW6h9aoHOn/ZMk=;
 b=kxQXtQilHj6NgSqcnuU88acQGHWW+vzAAUC5UKFxjWxyvYJqW5cG5doJy+4YBgnhqb
 lS2+6+4VzHaqNV3/c8XV/WxE0X7nRkQa5q2E9bspF3dUpDpOZeprqhJ4UUmv9VRf3Dro
 pThAGw1Dc2EwHGwWdoZXtoF/NwFVWphi8ll+BMY4E+Hll7/mf7Y7xwpDhZRf8RNTa3sr
 +AOI3PXAbAsm79vDl96TaGytVKievVt6VGAb1i4oJIpth1nyUDPG/Qbkzn5vu5b35CL9
 rW+bBxv8ciAfciOEZq1pluskAkOZwSK/YqnGM4Y7b76YXM0zVwlIB0a3YPVp8SjtC+Dw
 XCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792849599; x=1793454399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gcfjGkYvg2DopM1kqVzf+BV93I6yaVW6h9aoHOn/ZMk=;
 b=ivRyCGW/IX69JX8R8G5tY0PfzJJzxExJTUr+bHOfFqR92iuBrjgTC8QDld7SJbvnDy
 imLcchBw7fhtKQLPP5cj7k5Vklvi+HEqFm+OAdvWbUn5ik587GVWKQouPrEEJ3VAz7fC
 hxlQtEablsLUQnltgVJBaycQbxkJXdvl7BXNOfgfq+r+o3sn6FQOKBdcKtnEFAeVPZdi
 QkdrNp52LycNtw5V2sE6ljsxBUnvTMjarQRFlSD0gNyxdEYdi1olsJ0nE+gzquQ6ygPb
 vK2Ly04tRcZkE0BKGv6WZ8Yem1UxZVPlC8MmZxUTSf+EcTY58o4BGDLimyufiYSI5O1n
 n3dA==
X-Gm-Message-State: AFq9FYJovfoJZyy6d14gLhZK32lUd8vHt69btk/fzJejyvYSy9VxQLLV
 AapgKQuiBIkAv0eM9hCSa/OjfFtxdIr0TWzM2FM0Q6eofLk/aDge/iP26ndbLA==
X-Gm-Gg: AYBFou2rdRxwOKfO9Fm+QjnO8M6DoghJV/XEOHraswB024CbWz2qu9y/XTfk1Kg6byC
 CbTEcEh6HuzHlKerlR/cFQSn2s3+6Vjgz+Lv0lObX/kg+idLBO8n151+D2bA2BVe/a2I0pCv9dE
 TRHr3eqWqC+jPB/Dz0Lw0+fmKIgJcgkwmwJl7AF82vgIZPsXIu7N0BrLPra/UBNttYxSBNqQCSn
 OmB/e9+AvyOq2/UXYW6vN+BRfQYT3aMWV0Fz31/Al+vzsakvHGASluEc/O1d5gXF1TMb2x15+LY
 sdeOvhorUw4wNLKNLMdMDPlbl96mI1wS7gOqDa1/oj9DYvPS4nj7ocDjI5FJ7aqM8uvvZauDI8g
 9SbzW87iLECxnK+7yQBbNa/yrPgQgPGBMHF4hhQicCda6Gs+hv4GVJjqRl0o9gEG/NGlPR98I7A
 VKVqFqzKIVXQsPmlNFATJy7LgGupLBEtQPdMK/oeQSbpfFFuOPRuo8o8xi58rRhvlHjnkaSjeEh
 +M5EpFc4C6YOiNlHOv5al5jNZKi6qhBWvqm6/8HO8B2buAQDGT/NneAAfyMOIXcuV5t
X-Received: by 2002:a05:7301:6189:20b0:369:f291:49da with SMTP id
 5a478bee46e88-369f2914cd0mr248484eec.40.1792849598893; 
 Sat, 24 Oct 2026 06:46:38 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d578casm8489209eec.6.2026.10.24.06.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 06:46:38 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: TAKANO Mitsuhiro <takano32@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2] linux-user/i386: reject bad CS/SS selectors on
 rt_sigreturn
Date: Sat, 24 Oct 2026 13:46:36 +0000
Message-ID: <20261024134636.479110-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024134118.474313-1-takano32@gmail.com>
References: <20261024134118.474313-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sorry for the silence — I was not watching the list, so the reply to my
first posting sat unnoticed.

My name is TAKANO Mitsuhiro, and the author and Signed-off-by lines of
the v2 patch now carry it.

Thanks,
Takano

