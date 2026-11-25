Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783B606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uM153vMv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9tc-0002rP-5O; Wed, 25 Nov 2026 05:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xW9tb-0002rA-Aq
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:06:35 -0500
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xW9tZ-000291-M6
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:06:35 -0500
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2f042b6ef3aso40437755ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 02:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795601192; x=1796205992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01612jM2atsR1/GUpPpAsoE+njy80UF0HzZADHRQwGU=;
 b=uM153vMvlX2BJOuYzjIG2I/q7fGFfNc1cm+YOvOJEtCfp1mThia0bqQzgFjlJck0VO
 bQ0cTwA9CaorCs5/GjyEVdSzexw6GGVXJZsYungEgxuxOpcRwgRwgwFtnVzcPWseoGQ+
 l2T8wZJIKlVJglrK3EsILDF0glOCmsg2W2w9maycOryocS1eaMSG6/6Rl5QVxcbkEP1X
 o0puvDvvOgEEzOcCLp/kbggzHSy3uFDkOQEJJOVhddup2i8fDoB6qYXL6nR6ioFP+njH
 UocdRXb9fiiYu82ihhwmjmQ6AD5WHh3J2wPL6s4sR2Z3ho6DVDC8U/uWy/I+QNgOj17W
 3yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795601192; x=1796205992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=01612jM2atsR1/GUpPpAsoE+njy80UF0HzZADHRQwGU=;
 b=n3USgAeeQNNopUXW+9hPedEwq+1anjce7CXAQdGSysJOtZn090hRYXtogLJjYCIgR5
 yvmOcA49snds3nmSzs9xe1ZrqJ6tVk6K7Bz7ObXa9sZUk0G+omVbBMkOii3d41GeXfkk
 mlobHBaRujGe7gASz4rzuPg16oA13FhBURZqHcNsUT9AUllAk4jLXP0BSEXRU8mE55qZ
 GnMHdijFGjCG+IzgCucydGUmommUA0zSv7psNWcD4IHxPgl5dWd9U+XQ2IcUS7+USGKC
 5o0zQcnRcBv9wvwXzlvZniWGRsevxjYc8zJ4FkbGY458uZNTbqXYUXkWXdf0tvN1BcmW
 I1hw==
X-Gm-Message-State: APuU4Z8a3VASMgITUzP/MhN8JczW//E9AUybsTfq4CMOjL241PKdhQGd
 PDlGNP49ksl/6B+P3QNYBfmrfaYUZ40W95OcECJEadM7zQK1M9lBl3B+
X-Gm-Gg: AZFdTZcgEhLn8H0L4IxavkTo8fhQ7k6U20dGYxMrBVCPK5Zm0P+xlCLsHk1sRN4x8Bo
 W5kcso6T63jzyHKbBNWfqAjiPey2ha1NwKw2vMtN+MXdUs15p05nd13iHL6xXEe8WSFoDjSxo6+
 mTi25uoIAudhKcJ9/2sUWCyScXLaVvH2MIbSaCMGbxuRx1xna/hIi5RyEucgPTFrK2xyrB6TEK0
 3f04okjkPvszXZ6wVPN+AuGsnX81WiHyRVVnnj8xTYf14TZ4hlCEKYaxP7naNhzz1WMNZdtivGC
 Z5V7V8en+CIDdhTWtaVCLMaufijXNDVrvvnZx6dFl6rASrDNyZtjQJPBmQbdxUVtuTTdTyb24aw
 UAckD15kf9+fuO8dASrMk9i27FvW5DRruWNTG6v+407zOxg/XNRcevjsn3JFplLY1xBpSsAfDxA
 TVNSLDJgzQ2wW70w6D5sHUrn33i0Y55PLYNOG08Zh6FIGbI8kT18LRKkSTlajcZ+7sA8hvZnJ/S
 OtNzXz2pVPX12C3lfN0l9ilWYRDbVtdw+v1AyOX4cuiOzM44CHmHp27lB3mJ+e2dxhEObwWJmUF
 pcsgr1vHeYJMEdoFHrzhTeSjCQ==
X-Received: by 2002:a05:6a20:2446:b0:3f9:6c37:4b3c with SMTP id
 adf61e73a8af0-401493a666cmr19885050637.1.1795601191567; 
 Wed, 25 Nov 2026 02:06:31 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:3645:b698:a929:4bcd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e456a7sm8688496b3a.29.2026.11.25.02.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:06:30 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: asrinivasan@oss.tenstorrent.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zixin Wang <w1355457260@gmail.com>
Subject: Re: [PATCH 0/8] Add Spacemit K3 Machine
Date: Wed, 25 Nov 2026 10:06:04 +0000
Message-ID: <20261125100604.128764-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=w1355457260@gmail.com; helo=mail-pj2-x0b.google.com
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

Hi Anirudh,

Thanks for the series. I have also been working on a SpaceMiT K3 machine model for QEMU (a Linux-first subset that boots Linux through OpenSBI), and I have qtests and a functional boot test for it locally. Since your series already covers the K3 machine, I will hold my own version and not send it, to avoid duplicate review effort.

Would you like help with tests for this series, or do you plan to add them yourself? I would be happy to either contribute tests (I can share the qtest/functional-test setup from my model) or boot-test your series with the K3 SDK images and report the results, including a Tested-by tag if the tests pass.

Best regards,
Zixin Wang

