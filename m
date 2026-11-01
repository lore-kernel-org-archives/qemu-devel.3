Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1A606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BxRdLY5p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNYJR-0004XI-Tn; Sun, 01 Nov 2026 11:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJP-0004WX-BH
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJN-0008MI-Qw
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:39 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4af520023fdso4008995e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 08:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793550096; x=1794154896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/6YBiYZ+QK3WluY3yWpbh7daE4I8gR/HYZYvR0FbOOc=;
 b=BxRdLY5p8hOhFSHbvo4LcQCzejPciJbD41rR08M3qIgHzq3cekDx8ktWoohMJTptRn
 2cTthuhiwBUZzircoHqI7HcL/bHIA5znWyvqng12+qKJuNNj+r+2GU6eKfh9E14XOtn4
 1Zhybih+c5bQhtmO9JXso0I5INOexK+k9eeIvmVm2A+69EMVmA7C+y6s1zjrTfNdK90b
 2FUNFFyDNyn+TiB+brtsU7kATjuK9zxmhWUqdoZyEeuHTXR90V34TKlQb/tjP/8Ihgdm
 ZAe8l0E3yc6CfqQ3R/lt6/WTRIZ6AkrbFnYUbJAFs7sR8ZZW5L7/GaheujBFxA9L9GLj
 /I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793550096; x=1794154896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/6YBiYZ+QK3WluY3yWpbh7daE4I8gR/HYZYvR0FbOOc=;
 b=Qij37NViTGaPNQD7FhYAbx4aPuGbIdOYr8hvabA+oBqpaXBxnWmOmCRB+acrYp02Tv
 +kdMVlt/69+bgknKXPsJ0IFBD9sfE9K/19ioE82c8AshmXzymoskKloTY9VlTnYexAoF
 vlcKwN028FzBz1J7MdvYqGkPrP77amQyHS4rTPF88WJzANUZTZhH6kHTHARWH6xIXGts
 0jUWr+MBqdKttuOLlXqyjY7lH+wvIIZRhvnB3lLzcQKiO6OtDAHbhLgQVLqZvT+6Qbcc
 MGXTiTlEcidumHZYloIY8QMYQxLIQxkY30GIZ7X17AbT9UpewCUO06gpP27j8BkQElYY
 jxcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwXD/GglQFNiB+c+QrzD9jmpCrOUWMGFR8jeEFbHNwIEdeaFGk2MfXMilr/Y3e5mqOBQNMBW8is4Rq@nongnu.org
X-Gm-Message-State: AFq9FYKrKr7GQJjm0vx2XF4fsiiTuzIv8DpPh+Xvb7mFP/axIZv2wLB5
 e5GWFUy/tXfph07VbYJi4kXMIHJpeYFlDC08MFkMusRO4HydNex6Bdlw
X-Gm-Gg: AYBFou1t/9fIB5finKbOiwfTD1/W3d63tmRIuopQa4I3P5OXr1OHspUT/IZxo0ggZvQ
 kHb+YNMf0JdBD+fhzgbxPbrLIQ9uGCNqsqX6cMr6oug1RdVdsPu2EF9acBdYNSbfvSuBGaTJkgc
 U8YS93S7YmmaXNl43dXn3I/gurXneGdtuO4vmQr7bZ+vl8qG6heUFa2/kmuLppW3JgErorGMtWh
 5SXE2cX/POPF1vRNOuJtCLLcwPQrDQ/Cp+uRLg+1DLeD8qaogPkpRQNw4D2PC0IqrOSwXgGkntR
 mgGZhmhpuVeFlHhNRrQ/EHwukosGOVfDOP/YeXtvHNFpQywhwUpYP+esxPJito8fZiw9kfs3OqK
 HwxP8SruoIT8A7235B61W31elYH0bbQ71QfAtZ8xUQ1CqEpUTEXewF6b0VN7+qNFIlFaYiWgjsd
 VSeiKIOxQYZooEYxUhyhI3fQ57Lrer9Bjdt5U/nyzi8WEd3uZQVa5ubYzBGgPDPjVQfPvqdgobH
 UKVTxBDk6BSNii0if+FUc2VygL397pcY7tuOWwXguaGnNb3wakGdCkmnTG/u3v2B9fvXwAUxujA
 QzCF+Xn6VErq+DVndD8llh2pfddGeZvaRdiP91LH4lO4fSYOU1amWQHy4R4LjWQi8LXh8kalabA
 9+DlwS82k7w==
X-Received: by 2002:a05:600c:a5a5:b0:4a1:e774:370d with SMTP id
 5b1f17b1804b1-4ac1765d60fmr117179945e9.1.1793550095841; 
 Sun, 01 Nov 2026 08:21:35 -0800 (PST)
Received: from AtiePC ([2a0c:5a87:5006:4800:78cf:63bd:d449:f7bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm283897765e9.4.2026.11.01.08.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 08:21:35 -0800 (PST)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 0/3] pci, pcie_sriov fixes (null dereferences, checks)
Date: Sun,  1 Nov 2026 17:21:28 +0100
Message-ID: <20261101162132.147838-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x330.google.com
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first patch fixes a null pointer deference on pci device registration
failure, caused by the accidental merge of 432ea8cc7d27
("pcie_sriov: register user created virtual function before realizing it").

The second patch reintroduces some checks done before that commit, which are
present in the v2 of the patch introduced by the mentioned commit, but due
to the accidental merge they are included in this series.

The third patch fixes a null dereference that I have discovered testing the
previous two patches, it is not a big deal since it only occurs during device
realization of a PF of device created VFs without an ID, when there are already
user created VFs, but is still nice to have fixed.

Cc: qemu-stable@nongnu.org

Daniel Paziyski (3):
  pci: fix null pointer dereference on pci device registration failure
  pcie_sriov: perform additional checks after pci device realization
  pcie_sriov: fix null pointer dereference when initializing PFs in a
    system with user and device created VFs

 hw/pci/pci.c                | 11 +++++++----
 hw/pci/pcie_sriov.c         | 21 ++++++++++++++++++++-
 include/hw/pci/pcie_sriov.h |  2 ++
 3 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.56.0


