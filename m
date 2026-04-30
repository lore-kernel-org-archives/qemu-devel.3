Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048FECD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVZv-0004pq-3b; Thu, 30 Apr 2026 13:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIVZk-0004nR-Lq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:53:28 -0400
Received: from qs-2001e-snip4-2.eps.apple.com ([57.103.87.45]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIVZb-00052n-RO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:53:22 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 701D518000AB; Thu, 30 Apr 2026 17:53:11 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAk1fDl4fBBdGGVUERx5dVkIeGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQU5d15zKQVGDVUKKXFfH0R6T3VAdSlzRRQ8dVoGWwZFeDwLVQ8rRx5JClYJXghGEVsUVkNRGQxQTQFDCAoIRwNNF14yUwRfEVAW
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777571592; x=1780163592;
 bh=Fer44NeLjO7L2mClHaF44+hsVoMmh8C+tGf8iYaG3cY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=L2bD/xPkyMPofcZY0QQFzve7kL5bEVnU1Mjm7dSodC/tbr/saoVyY8LRchelIsJDu+xmsI1qsY+X4ymNqcrorX6q9tnMMdOP8W/LwdKoEGR2kD43OHRZR66BxGw/7kIaqBQvP+XhZ2MtiojJBS+4IEAWkC90qtipDFjSWilYM1rr9BPgD2Iz99WqyYHVAc4sP4KJsYk/SOALbXfWXmVB16dwc4pPNeIk7/jeSo/tO/zSXUSbNA9OgUKRNXJcyiN1Xf3SbLk0ad4wM3a0b2IfQL6C4/OKshczrYSJQyTawDidGqc4w//3tn9MXJy5mNhqF3zDhzk08ONbjbpSMWjIuw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 40F631800114; Thu, 30 Apr 2026 17:53:09 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3 35/37] whpx: i386: nested virt settings
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <7c15ed6b-f0e6-4582-a28c-2ac28ae37197@redhat.com>
Date: Thu, 30 Apr 2026 19:52:57 +0200
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD3DB764-9DF4-4C7F-BBA5-DF71045AD888@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
 <20260422214225.2242-36-mohamed@unpredictable.fr>
 <7c15ed6b-f0e6-4582-a28c-2ac28ae37197@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE4NSBTYWx0ZWRfX9qe10CB10tfv
 CCyo3Tm9RmXQ+p1RRqM9Fi+UUE/QjNmZg5cGfkPfalWOa2VxSAFH24e1h3iiczuA45iLtbOEx16
 jbsHNimvMvgCyugGx5xCKmLBm0FIc4Xf5BrDhcxr0lbo9Z2vyl4Lceevoc7KJqSn1JwAbIpSCeP
 p5S2hmza6SAYhpGwIczTPiRVRmX8nJ2iwqiRouw3z5Q4B2p0ZbTIyMD4CmNjbqcxLIkfby4QhGy
 SA7KFh16vO6UEXKw0HdSV4SBxqnylXqEL54tDMl+gTRGSI2gSuq0YbmtHzzbJJJ6/Qk1GHwImVc
 r3fCNXueDevvrlzw06Zje7C9QWXQLbh9ODo/PssyKXvqIWepBxMtW7LkhG8B8k=
X-Proofpoint-GUID: _grq1OOA6m2ujD7jPTDTCA3XtgZNzHCJ
X-Proofpoint-ORIG-GUID: _grq1OOA6m2ujD7jPTDTCA3XtgZNzHCJ
X-Authority-Info-Out: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69f39708
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=yvMAekbIZjN1x74S5jQA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=57.103.87.45;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 30. Apr 2026, at 15:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 4/22/26 23:42, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
> This should use the VMX and SVM CPU features.
>=20
> Paolo

Hi,

The problem is that the CPU comes way after this, and this info
is required for partition initialisation rather than later on.

(And the same problem applies for the `hyperv` accelerator property,
which is why we can=E2=80=99t use the existing -cpu [enlightenment] =
bits)



