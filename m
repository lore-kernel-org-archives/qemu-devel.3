Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2D9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4K4-0007Vo-7S; Wed, 12 Aug 2026 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K2-0007VC-Ov
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:26 -0400
Received: from pv-2003h-snip6-2.eps.apple.com ([2a01:b747:3003:205::52]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K1-000529-Cd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:26 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 8DA5A1800961; Wed, 12 Aug 2026 08:28:19 +0000 (UTC)
X-ICL-RepId: 019ff516-2dde-78d2-9a48-7e5faae37e84
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdD1oAQAFKC1wDRQBHC0kEQAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1786523300; x=1789115300;
 bh=BUBHt6pWcF2dXJ2z6oMGEzPrSy5M22fwYPpZYqJh0uE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=vsd6cMCjxPN9hg3L9icG3/nr/lARMkc0hR2Bug6bGff3S273U/OfmNO5fu+FuCne9mLHL8Yd4NghJyeqrENdzBDCJifKE+bEdk5hSjqM7duuFN+CTqR3Csc5A3Ut006k+TvwcWS4hTRURkyeyeqTuZyFZDzt/qEE4HhD7+FTZzohkKTU+PHuelEQEVJkwxksXuY4ugy2M1B4IFWjHe8Jp1sp0/WNJND3jIwxP9ZwhUZeQsZOsOpm5MIvLIWuIUlASchaYCPF6QNd2b1qL4ChGXe5vHxicViBiWxih29Zr0rH58Uabih8bczraOQ44SLb3GMaEt7yJz4Y6KhIexspIg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 79F391800954; Wed, 12 Aug 2026 08:28:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/6] whpx: i386: some fixes
Date: Wed, 12 Aug 2026 10:28:08 +0200
Message-ID: <20260812082814.27217-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xxLRih_TIXvO1527DVPVJCwvAeKtX_r6
X-Proofpoint-ORIG-GUID: xxLRih_TIXvO1527DVPVJCwvAeKtX_r6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXzGrQSZafjnlQ
 3RkEMJ7q8CI5N5jQFRS+3KYdw7DZObYEcMu0GPPG+UxknJFkO3eZ1uZhCkzyiUr5HCkEj6oZGn/
 lIMW5BCRaJ7wzqDaBlA0NCgK7hu3pvKcvICDOizF4OV/61kT3OdTl1EckTXzpZlbr9sImGgW4yM
 N9IWCHX6tDMq6rg3m9Av7gQQSG1J1ZmXnXS/9DoIGiz7GPDJ6QCqfEANndsBSk8n5HnuraQ0Xkc
 rHHN0s8+4+NlplcrvwfKLG2qFn22riLihq13tWfHzZ7saUg3cqhHvjMKpKocmAvYuWg2uGim1rN
 7ov1PCMtIQ+9qLFGbDGRLLXqlZmKWp7xmJa7nhnFTGFFO3pNGndJUx7AYoEp9o=
X-Authority-Info-Out: v=2.4 cv=IdiKmGqa c=1 sm=1 tr=0 ts=6a7c2ea4
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bIWHw9O_RvQ-l27VP0YA:9 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB7wnCGHRs+lZ/HpAz5aOli1KH3ZAoWUAC6nCIHZ2nMcFBHSAoV2qr4Y1oJmOQlnN6WDNlcypR1rZQLB763x4ty7dST761HrPOJVV9XoHLFEEOCBtSMCVUR7i7t5BkrcNcTbE7RPLpj524m4DbTU/s6Vyd7fHJRtoWMrPFfax2kgPl1uzKD2zAAus6O2kSoNnPIuIUBe1XLLwTllXi33e2E+96q0OwYSlVxpxTNPjS5yJPZiO3o3b6Yi7Ff2N4DgLaFk5QxJ0qfGOZDht4HJQKpvWgsEI57UuCmHyOeU0fhwUZ86SJhFxqv/SVhN50bRtaUwq/dU4JAd6/A0JUJrQGoMO6DOOQnPEpf36VDjHD5HHn9SsP8oaVNkApBa2kzPrDfdUaKUO1FuS/+sLGlvDx/puvsvJcoR9i76X2kxxu4aC2UscH2ObcSg3qUukSmI4SqbR+ScyFL9iBsGGGjQd93sYgk3aVM/JWa869Ep5mfhmCklOurwKIIdfY2bXTkOA1kBD4IxoSbWu6wDpqFQIQSLiGFQKahUIzXzE2QMlSzDYtDopzJXxPuo+8oXJY3VYm5/zuYYUpayK+YAlwSnwCeHYK2RsZUHP+WAllfanWP0a6xZYT9gUMc1sxl7pWDlk6C1BpKDtmgEETEnvj8jW1HHv+gW6N/v52PO+WF0Sal8PjzZ9gUWTSDX/oMqANkyGY/r67nJv+DLH/UwvmwUFcwUBu/OAiXlFtDdXY8c5osJvGxnUfwNjh+kiTrUAKvNOeOcrnRYqx1DowD5xcXWEfRP/mLIKjowO9ri+ddEv7w4P+iZE6qqhZu//J840CKLk7YfrgQOKAO5mE+45WVx6xA2DLi6ZejE5wyoHkxLSUOT81GnKoEO6T8smYiDqnFGFCiZ+Op+1INtvnc5d8KTa0QC0aoBB7KBf3M9+5n1WQjALh9gc7QQeQ62ko2WUt37aIvoxujoLaBVbbkVUJ5NekmX7
 TZY6vOCj1BYLUJhBAmdUl6+xWrpnJw35WUsaraD5rL+DEPmw7sdm8qTgAQcCpzb+1hFAXr4lF0CvSFJXwUQ8/aj/nk8e886WSXIgjvgISMLLHvEaUqM7zN5JvIZPg+OwCF8UlbLKO0ScS2i1rMaxitDhO34dNXXUVIjGC651X2yEyTFOkii/wnpatt5biy1wFpPJhteKq2eYga9pbhBpmRsDth0i63Az66wKpkM/7ikq4WA==
Received-SPF: pass client-ip=2a01:b747:3003:205::52;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Some (backportable) fixes for x86_64 whpx.

-cpu host on Intel CPUs works again without needing a -cpu host,vmx=off
workaround.

A floating point state sync fix and re-injecting exceptions on debug outside
of the int1 case.

Mohamed Mediouni (6):
  whpx: i386: fix xsaves enablement in legacy probing path
  hw/i386: fw_cfg: do not set VMX feature control on WHPX
  whpx: i386: enable fast hypercall output
  whpx: i386: synchronise PAT too
  whpx: i386: work around Hyper-V FP state oddities
  whpx: i386: inject back db

 hw/i386/fw_cfg.c                   | 13 ++++++--
 target/i386/whpx/whpx-all.c        | 51 ++++++++++++++++++++----------
 target/i386/whpx/whpx-cpu-legacy.c |  2 +-
 3 files changed, 47 insertions(+), 19 deletions(-)

-- 
2.54.0 (Apple Git-156)


