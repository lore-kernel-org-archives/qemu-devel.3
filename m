Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0E606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Bzj2ey5g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0TR-0000aa-6o; Thu, 22 Oct 2026 17:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T8-0000SI-CH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:04 -0400
Received: from st-2006b-snip6-1.eps.apple.com ([2a01:b747:3001:203::e]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T5-0005po-3B
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:00 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 DE3BC180036A; Thu, 22 Oct 2026 21:36:52 +0000 (UTC)
X-ICL-RepId: 01a1658b-a3dd-7c14-8252-2987a42a96c0
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQghLBVkARQBBD04GQAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792705015; x=1824241015;
 bh=qJdyKHDqvoQ9lhFTAPM0CouuHEO2N3IrUCuQnYheluU=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=Bzj2ey5g9uQq4EdRdXLA6ZemrUyPaB29LkeKFkJNWnLLLnCU2YnDVeezBqXJPqf/HxRvluN2gTlpIgKpa6BgDhfvbFfJSdwRlp8GpXzVdCY6XZv73SYqlsc67hubtjL4z0wc/DZOkf03U6kfOZ2gHMJRVihNHNgIIG9K0XN9zJ7LvSpXNVEhjedIovzRTdWkhJ9SiOuRU1lernZPodOCVYJ4nhSeylAKySNVs8NrSYXoILojFWWXlvX0xWAY+06g/3JZR1spBwJxZd4l3j+Aw1V8aTSkfzeGMC7w8oUJtK6s1PyWx3tNNlYyv6kMsPtSmsUVx9nfRkDXIT1nY9PluQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 2FA9618001D5; Thu, 22 Oct 2026 21:36:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/6] hvf: arm: fixes for QEMU 11.2
Date: Thu, 22 Oct 2026 23:36:41 +0200
Message-ID: <20261022213647.21665-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Ser6t/Ru c=1 sm=1 tr=0 ts=6ada81f5
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=qD3-HWHhWnyV75aGXcIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P9A2yQ9vmoQ3IUl7ZxN0ygJ0ooa1nCc2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfXzNU7HbCQHEJf
 QLMX1qK3nPrdutl0+USDkMZmPYlNN13VE70PbN04d7qYSyqaTWyQjTkGWhDX/Xc7wuIBv9h0GXD
 t9SRZarAwTe7JHHAwO/CjvNPi5rhrPo2PkJccB4j/XvW+1O7qwHkJh41zLFmVZOQmYhQWKLSote
 N86KPNbFVDdaH2xfJPTuGxEvFJESQEr6ug1AibZ5XsARI8u6i4JK0A3DAN4WVUkv/sK/5UkVyJn
 DPZ8q6WFDQm48SHiqu4BxTA4HDAzTte3A+S+PsZisg5Zxd/Hyiy9CkPqMZmv6KJmKwlIgQhRn5q
 2Lesueg+EcYyvyEZf9MCYCtVWTa+ibClYNj944epTztUnRfOVjzvF/qQq79LcY=
X-Proofpoint-GUID: P9A2yQ9vmoQ3IUl7ZxN0ygJ0ooa1nCc2
X-JNJ: AAAAAAAB9JDbablMVYK7/XQ9CSWaMLzXJSzksZmNtFuZDKfpwO2jEIFtVJ/x2y4zZ04tY5TwZijJ+1XlScRHvf+tWaMIRpsCuPRopCyyifJbcrsjT7wu+1dHfzA4TCKIIba1iELV2DdrjwVAXULLSFVF6X6tPE4mEBTB9X9Vkdgooflg+HdPxgBUvRwAun2PiGLT5CwMvpeCXVEdBAgYfxWqpgKb365kHA8sy5YODcgsXhv12sC2+8t162UOK4YurWyh6D2d9xgcg+aSkQgj/1LjPEg3dINECxDSKWPgsDdEzT/U2te3wjgdJZlCtcHEqCmEJ5933XrVb3RuGPWAFinmmeb8bTNLXyvPppYI26ApS5aBZrf0wR8CgEvTOdpfKT3l7jWj4Al/LLCGeh1K84keZhOpUiLaqiZQnm8a/FfE8L1W29/WcJ+2lszMKaUKG6fUjYSk241wfAk4jfBDj8Vl9/f1yuChukAuZtBM2yHeMv/badQ6GqsC2zvK/d+2yVQnvVqqblZQh3NckDC3Zc4zr0tSrL8uMzpMcEnVv18ZloHb4JXE8fAZYUTpQaFG/O2ePnQj1V4xFKmk9DVYybp7BlXP5cvJaIKRR9+JmOSM7PkGeRQvWdDvAsnXiC4IRAECEqnvsNhKThf2hQ/57hy4IXUwHss6rlL7JSr0LzFeG/DnIwDHUSeEKJuBPdIPxOpfJknhVUErby8XsRZ6A6C3S7rK/RBJVG1487f4/HmhLlS8lBf2FD6umpjYy/3t9OY2385D1DVddGIEIdl8mnuttgEVbWrW4Ftxf6M2Md2LKCo+ja6gZfGm5axr//4VQj9LJOD/wnMAvG1ntwDblHiQauP5kmte7+g95ZSCZqxGk+mupv5GuNnL7LjZiq6a1aGxTJ10WVglKX9ZcisYY3bLXu6lwwfOIVxLMA+nzrJYZvB2pMxaLqh7ri5VyPR90KO6mQ+YdqSEco2XSV+pTOUb4ypCJEl
 KJY0cklBmYBqHNEeNzt30eHV+SbEQk4PwkSGh9LqhbH9Uvwofyx8gapldwkW3Ch0F5O34l3L0GstMKyjlP4Sg+4KgaPpO/NVTh7bbEOMeqYwEib70hol3KEpLfrztY2cuxxHIuAz38niBKtxvXf7q8gMmQ9Ab/Hk8yGkn+gbLB0zATPsMbl39WOMtMbtsS14uqJVzGfV4qC7dd53DWvUE0YoklERFsgs3IVhmM+M0psX2/MigsVWTzCboH5dlR5RnBKJJjgBiAFI45FV7PAdB2180QPyXAnI=
Received-SPF: pass client-ip=2a01:b747:3001:203::e;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

- workaround for presumed Hypervisor.framework issue
- save/restore SME state only when SME is on for the CPU
- add ID_AA64PFR0_EL1.GIC sync to advertise the system register interface

Adrien Kohlbecker (1):
  target/arm: sync vCPU state after PSCI CPU_ON reset

Mohamed Mediouni (5):
  hvf: gicv3: manually set GICD_ISPENDR on edge triggered interrupts
  hvf: arm: save/restore SME state only when SME on
  hvf: arm: remove broken ID_AA64PFR0_EL1.GIC sync
  hvf: arm: advertise ID_AA64PFR0_EL1.GIC
  hvf: arm: fetch more features

 hw/intc/arm_gicv3_hvf.c   | 20 ++++++++++++++++++++
 target/arm/arm-powerctl.c |  3 +++
 target/arm/hvf/hvf.c      | 37 +++++++++++++++++++++++++++++++------
 3 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.54.0 (Apple Git-157)


