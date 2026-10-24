Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF022606A321
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gn59wB/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKdQo-0008Bp-RR; Sat, 24 Oct 2026 11:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKdQn-0008BZ-2D
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:13:13 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKdQk-0003XL-EO
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:13:12 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-35f036b17easo3761612eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792854786; x=1793459586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5MgAObAt2kGe6ofnsOmOtna1PX8XasUe2TTb/NY/xW8=;
 b=Gn59wB/qhb3VJc1R4tD/YiBTPhkdElRoNhYuwp0c8uSCcFNyVgAO7XZNZk62hDApxc
 e78cFAV0PEqgeW/D9l8EubYJPAlDJzhuOsQ1xNDlaamxbzRp4xF80sOw6vyy3mntYTUU
 uZH+Tn6P3RGeBJ4af0mm1tBrc6bV30NKZN86JkczbD6W+Pgs3Rr6k/NfRfvIbAqm7YZI
 I/1K53PnBiOERXq6OwwoWIh4lLwr+RrQ3yIn1lFqS7c23Na0xh7TllXlVy87hpPBwpOv
 9KOZqYIjF8qcKv8ultVsH9zGocA3YjyGweZIPE4mddOfGvgpS0B9fYe8f4K8uxztmemM
 lQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792854786; x=1793459586;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5MgAObAt2kGe6ofnsOmOtna1PX8XasUe2TTb/NY/xW8=;
 b=xJFHw/159D02BmddZqlaHnRutIxMmkTNzMOcpsTrJXVZLpzPVIjMjzJTZ8fL0y9OJJ
 wAtBAl66dmQXmNdj5bWtb/IeKsBww7YBNGFj/bTLKbUYhv4VmwjMFuWQIkjoDK2hfFHw
 lgejuam5Uso2cCQCqPM5IYbRoB6Ko8l0nqTB8PBAEtzFGhyibbQ2lkbt/nPmPQa4LNnC
 6jZRuClBiqOeI35BZHVpfJAn1Ss+Ps//Cbpve0JmmtN0LkP1AVtKKA5hxqsZV39ah01z
 kgN7cIhMeF4lkqTaYGwyvqmqdjPN4jxswRqtHlsX4cwyxDYGiO3+L3aq4PBRMEFjyqeU
 4N7Q==
X-Gm-Message-State: AFq9FYKY/Jtpk5t2X6tvlJM17FBaTzQhmvV2L9ZWvepuCSo8b1k6sQUU
 nGv80IDcGzm8T+VHDy94c1jPJPa+d2eXIarPzDYOKx2cmFCt/lZN1hraRO3MWQ==
X-Gm-Gg: AYBFou1p/4BDObsNf68aGUYXg/o7R4ZNAjhQ1TkGjorwoa23BaqNmwpUX8Ok0g/HQo6
 v1t8fr9LlXEp4R3D1GufZQx6RZaxBM/Yigr2alZPeq56RwrT3gAS6SiYRhnoEhrVb9YCKtXTPlU
 O9UEgr1+PNLosARF6P0aIr92UtXF5B2ddjNQ/8Gdu8ZJB90ORTzha/bySkd1sJaF/JmPex5WrOt
 /O/U0h+cqdawOaabekQuDnNcyL61GeG/6BLYjz3Q1J5guFZQdPHeRe3lyZqF2IlFeDY/Akr2CwR
 m6UYEQxaEMD/CUq/UxWrxZMC+M/zc/6ZXbT2Yz9OLYOlXo9PW50yya6cT3b4s6gGlMvYeng4H8b
 UQ+yei1DAr3/lm2MXLxYQ+/x4EEC/jDbqfEczYMEmo07s00IMEZaYPF4txi+8bw3TojcFAxmCm1
 Pk10tknJETgvD+MnZmX/LjZTVw4lMMydeVpk60HqhhE3JH+kbT3Gc34CI8VsMZix9seTQZKr1gg
 J3LL/e/LhdhPUd3nRFiq34sdH79PwenJi72ooNWKLdSqJA=
X-Received: by 2002:a05:7300:2442:b0:358:2e30:8e5 with SMTP id
 5a478bee46e88-369e836b382mr3881382eec.1.1792854785692; 
 Sat, 24 Oct 2026 08:13:05 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d5b841sm9578168eec.9.2026.10.24.08.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 08:13:05 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: TAKANO Mitsuhiro <takano32@gmail.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] linux-user/i386: reject bad CS/SS selectors on
 rt_sigreturn
Date: Sat, 24 Oct 2026 15:13:02 +0000
Message-ID: <20261024151303.586126-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024134118.474313-1-takano32@gmail.com>
References: <20261024134118.474313-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x1335.google.com
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

Hi Helge,

please drop this patch -- it is not needed on master, and I should have
checked that before posting.

The abort reproduces on 10.2.1, but not on master: since

  9097087147 ("linux-user: make syscall emulation interruptible")

a #GP raised while a syscall is being emulated no longer longjmps out of
cpu_exec(), so a frame with zeroed CS/SS already ends up as SIGSEGV in the
guest and qemu survives.  I checked this on a clean master build
(8967b2fe1b): the same frame exits 0 with the SIGSEGV handler running,
while a v10.2.1 build aborts with the cpu == current_cpu assertion.

The same holds for the v1 of this series -- please disregard both.

So the fix for 10.2.x is a backport of 9097087147, not this patch, and for
master there is nothing to fix.

Sorry for the noise, and thanks for catching the name.

Takano

