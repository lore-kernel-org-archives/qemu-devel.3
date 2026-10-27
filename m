Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF271606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packetfive-com.20251104.gappssmtp.com header.i=@packetfive-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=KP3t3TTN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLcEC-0001Bd-0l; Tue, 27 Oct 2026 04:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xLcEA-0001BN-A8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 04:08:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xLcE8-0000Up-1k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 04:08:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so4008485e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1793088489; x=1793693289;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XR/8VGBPBjBbTdTkZe+sdbwKTziNWQV13+BhySggaWs=;
 b=KP3t3TTN1uk2wW8GeZkaG+ophPm1OVME8nvHJ2k+5uMYe5TJBlVYGX4p22Ebq3e/Gq
 z2ZiaiKnTd08ZkEdUKqWZI9mQzw6e0b7c1dV2T/M1z5Wzzy0MBIbnIjQIJZzGhcyFypM
 S20OL+TsnqlzB9DcP1t0E2EID1NU3t0a5NY3LQN6yPEzT0kQC7QVMWpcopUSEjf17aiG
 PWVhwItMv1M+/wyk1kpqb2vS+2qhVYFFl4alkiGTG5EW7fJaoHpHw0xJhsz9RCn6bPOK
 t6WG6xMw7N4CGWbivbfTUCmRJHAfqQADzkMdJtWPuRl6N0frkO7wBvbs+XiN22EePade
 O5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793088489; x=1793693289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XR/8VGBPBjBbTdTkZe+sdbwKTziNWQV13+BhySggaWs=;
 b=acD3bZXIzGKGyfkznIjRA8Y6Lp/aMwXREWIrLIYyMZYm9y3VB80wYgNKhFPeHn3MnD
 Ayod2rdYvNiO7wGYdbL/0Qdx25ULVxwYRHa5ROF7j60WAhYbvtkM0v70mtLbyogRXt8t
 2N47J9s+Sk9Pl+sVn9PJ85vf9hckihSw18UGlMdqeVXHm+vmrSFRCrIrCypq2yzBApgn
 t8wW3Zs45LHNO1GB5XKoqqpDOcTeMYn4L8YPPN6Fp0LVVGp32fUaXmEtWVXXwDHAj+Oz
 UCC/BglY3nfF6W588v0J52DImkIjHwz0CT8WIn37kAhTpEaBpaHwbE5DRe6oAE3tyCPU
 LVLQ==
X-Gm-Message-State: AFq9FYKtXHHAvJxsyi7wx0MT8Yp7yDSf282NJQrp4/2dvE5v10Ab9PnW
 BwA462pSO+uTK8G47wGnS1ksX1s7GphyqprH//j/ZNWthGvWdgP/Kh99MIso6DFVPMVfR3qQ6bL
 YqZc4YfxJ/A==
X-Gm-Gg: AYBFou29NRftdk67671uDqY9uh4FmCdMGyb/90W1T0nz+gYA8H+KSTGmoJ3sgn0tXY4
 noSidBIZjDrX5+AXMzdFvs4f/u/JqhKHSyHSbXy0SYaq/iYT7NNMJTa+TmfZz/MazrID4YQ+tEw
 cw+4+9tBkvO1SxuchLUF3xmINjn+j16GLueIiYi+rXk+NQjLCFltWpaNoQNUMw5Ho9K+v0VFeXq
 LDmx8LjwxHUJeIcrebX99yZbMOkyI00Zu5CmUb/lf82txxzH3+FtSVQtzarmrIzlnqvjR0woT1x
 pyLH03HRQ7dup3v8VGfNIIRYbiXx5NHOR0m6dTctJirZJg+j9yqmrGK0fWFOjgKbVmixsrWDVhF
 msLnzYiXypthADU+xO6hLintp+1k+oh/mFv2g1ITWaBaR6KiWB7C3kS7ozJrFyH+MmEMcR7wY8P
 7rYEJcwRhjAJDsd6iNQA8yL+SHspnR64R9Iw1HnyY23Qb+HhRH4t50DxIoIKiWMApIVcm/GL/67
 aQTa6XaP5svvCZCCnScdf3Q+Ljy743Ok1ifPmAH1eloJpkogKYl9zd05zizxDFF3h2iHgfm
X-Received: by 2002:a05:600c:46ce:b0:4a2:180a:3417 with SMTP id
 5b1f17b1804b1-4a7bfec4960mr39324685e9.1.1793088488940; 
 Tue, 27 Oct 2026 01:08:08 -0700 (PDT)
Received: from node-dev.home ([2001:bb6:1895:f400:82d7:3295:d92d:e29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bdd59sm159720225e9.4.2026.10.27.01.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 01:08:08 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>, kraxel@redhat.com,
 peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Tue, 27 Oct 2026 08:07:44 +0000
Message-ID: <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::32a;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,=0D
=0D
Ping.=0D
=0D
Patches 1 and 4 (PCI IDs) have Gerd's Reviewed-by. Patches 2, 3, 5=0D
and 6 (CnuasNIC/CnuasGPU/dev models/qtests) are pending review.=0D
=0D
https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@pa=
cketfive.com/=0D
=0D
@Michael, @Jason:=0D
Would one of you please be willing to take this series through your =0D
tree once it is reviewed, or could you suggest who should? I am happy =0D
to rework anything needed, and I understand this may now target the =0D
next release given the upcoming soft freeze.=0D
=0D
Thanks, appreciated!=0D
=0D
Weqaar=0D

