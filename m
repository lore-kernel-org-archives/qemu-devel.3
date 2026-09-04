Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6279AC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WPt-0000rB-EU; Fri, 04 Sep 2026 12:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPk-0000mM-7H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:16 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPg-00063r-9t
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:15 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c259e5c22ffso186671766b.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788537910; x=1789142710; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1cvn3fubt0HS5qwzW/iu5vHt3JNvdQ6MqYhsjSQG8vg=;
 b=Hcqk3+P/9fBI9odxDnSRml+UVYT7SeOJCML6TU4ulhCIHOOS7/tM5vgVV1H1n6kaQY
 gsFZUCqJOfOmNkEqQ0Q/gJNCahOLb0gV9PZUFrpRONtW0GqGgYnQLIMSGccDm/N33CFQ
 9va0ptWwMaWKDlTwJPgocTdTX7d2kZfjGUFCxEnISB7pPxKJIcJm44BFH/KraKYUCGG8
 UIK2kE/lmqWXEqmy32ZjpFwG//uF5Ez96j41aZSgkfbgvGJSdeQ3pWkmgOMoXL0HX8SS
 CnX4EMnmzCr9wW7luxEMbZbLprrlLzCdzUZ1HOxy1QGfSRlfvVlUNjC60U6+TYK4L6kR
 aTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788537910; x=1789142710;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1cvn3fubt0HS5qwzW/iu5vHt3JNvdQ6MqYhsjSQG8vg=;
 b=PB2p2heU3E8ZI4SSNHYQgz0+aVNpo+Jp3ienycODnOI47WWLphgBu/LdSxqsjd9Fgw
 ukgkrPr4nUFpbnMibvFF0crxmm4VT328bVmc35rssHnMcvL4jvpXIZf8xXpQkbMKHHh4
 5f1xwcx1PuFZSqKmY2aCj05n1Yr0B1wxin2Uwkra5DeCGnNJrCJX82bQe4NURl29jgdD
 1YZrlaF7LF9vDBEvpWKLeNrBm3MoEtKr+Ikg9ZFJ4zBC13E78oa+CvaTdr3cCxjTvN69
 FpwD1TdSfIs8qPa22se4te+mkcRyBX3yDIbEqbNVlSaHefHUXscD3mRbOq4Qsdk1IhQE
 DLWQ==
X-Gm-Message-State: AFuF++kO/SzMfE40mP0Pu6I4y2PsLB1J9RrKyqgxqQIovJjbVlgNu5HP
 LsnOJlyn1uYcKdRBPhOxukEJXLa9zTUzL2S+HdvY/aTLx0dBoOkOAapdKOA6CtByzNI=
X-Gm-Gg: AYBFou355YQ1VAmeowcDPN89X3fiIS3otseUQzDitsRsWe9Npa1h41mUXZvlsQlekhX
 M4A9EWwak9rgjgcNhrHnjDEnre2VrUvCGrIEtYJeKOi6GRXmiNgMGievJ1wo4rExgyfywPXIvPW
 8RCwKwFAgpZYAm6Ss7X2QAFqXyNehGOWHi/WjRQR+lx2IcSl5DXignUj3GFde6Eiu8+Uyvq49Rz
 pp4q3GzZ00y6eRtuMe2598HtahVgpniU09lTN8cqQ4UCXaNieHMb6vfKr1JWRvb7YFgkNtY1BQA
 KxWrLor4LCIcrgDjxdOvSa08cmP0Yvn7ZJlUZB8rvHLrn8B8QxXYvXwU+DiE5tu49FBb0JrJFQe
 CHvde0+Z+Qz2kBdM1FPPqA++Roze7Fmpg0Z6jGQ1NVYv6sWRptxjUn9zQJRbkWE0kBVNXorMv8N
 1mcWj/5je7cr80nqLQMCjhbwQVVZehUL6fFnN1ChEys56zGC+gyVfIUO5Upa3QOpAwJnB4+efAq
 xI=
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b374 with SMTP id
 a640c23a62f3a-c261691ba04mr203799166b.45.1788537909458; 
 Fri, 04 Sep 2026 09:05:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:60d5:49d3:5d47:8dbd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d036674sm133815966b.8.2026.09.04.09.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:05:09 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v2 0/4] RME-DA preparatory work
Date: Fri, 04 Sep 2026 17:05:00 +0100
Message-Id: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACzsmmoC/32NQQ6CMBBFr0Jm7ZgWQy2uuIdhUcoUxgglU0M0h
 LtbOYDL95L//gaJhCnBrdhAaOXEcc5Qngrwo5sHQu4zQ6lKo6y2+JicR5kIe4eL0IJW1SZ4qw0
 RQZ5lGfh9JO9t5pHTK8rneFj1z/6JrRoVXlRwXV3pzl+r5smzk3iOMkC77/sXwtSqCLEAAAA=
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a subset of patches from Gustavo Romero's SMMU DA branch work,
featuring patches from Pierrick Bouvier and Viresh Kumar. These add
capabilities to the PCIe root port and ICH9 SATA driver, and also refactor
some code in hw/pci/msi.c for future use.

The goal here is to upstream work which is independent of Tao Tang's SMMU-V3
patches, while those are being reviewed. If/when Tao Tang's patches are
accepted, we can proceed with the remainder of the SMMU DA work.

I have spent some time understanding these patches and believe them to be
sensible, but some parts of them may be outside my understanding. In 
particular, we may be incorrectly advertising features here which are not
actually implemented; although this doesn't cause any problems I can see
with Linux or our test suites, I can quite easily set the feature flags to
zero and keep the code structure if that's a problem.

Jim

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Changes in v2:
- Removed RFC tag, rebased to current master. No other changes.
- Link to v1: https://lore.kernel.org/qemu-devel/20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org

---
Pierrick Bouvier (4):
      hw/pci: add IDE + TEE capability to PCIe root port
      sata: add SPDM + IDE + TEE pci support
      hw/pci: add DVSEC RMEDA capability to PCIe root port
      hw/pci/msi: extract msi_message_address_register

 hw/ide/ich.c                       | 72 +++++++++++++++++++++++++++++++++++++-
 hw/pci-bridge/gen_pcie_root_port.c | 38 ++++++++++++++++++++
 hw/pci/msi.c                       | 19 ++++++----
 hw/pci/pcie.c                      | 15 ++++++++
 include/hw/pci/msi.h               |  1 +
 include/hw/pci/pcie.h              |  3 ++
 include/hw/pci/pcie_regs.h         |  8 +++++
 7 files changed, 149 insertions(+), 7 deletions(-)
---
base-commit: d2843fbf80260e4346c856819e8cea11768c9d0e
change-id: 20260818-jmac-rme-da-prep-8096fc816eee

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


