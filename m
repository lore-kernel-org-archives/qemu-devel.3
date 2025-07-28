Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F31CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNtr-0006us-LP; Mon, 28 Jul 2025 09:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugN1K-0005we-He
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:32:05 -0400
Received: from p-east3-cluster6-host2-snip4-10.eps.apple.com ([57.103.85.151]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugN1B-0002uQ-8i
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:31:58 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 7388E18005FC; Mon, 28 Jul 2025 12:31:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=nlrgZyq/9wcmBEA+bg7bfnPGEkKlQkD/kDzVGgAN8H4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FUHr4+qPPZRVvuWv2R9zPoDEB+JQxG/LD5ZHJqsDY+u7oUZtLkso6KAUuKyWKnJEh+rLSQXwiKaSdQ56Py2G883d4Kb7V+2W4jsrK7C6tXAWsC/pyPfgHvoyDLqXFVPeFAJA2/9mex7qaWTNvWkj0sGEBn1a3R0hsd7HUAWaRAufC6gpzS9ypT0CLn3RSg4DTDUf49STpNzYtuewreg5qoQ5wgRoDHxPtdfXah0VxQcFp/mHuSAt+foIfBK0wNJyQ1SxkhpfRBEYEdc5UlfUSv+IF/EVnSnTIDbucrnHyR3sEOVo1u08pbq+A3ZGiD4gSxAURPd8mA4yvwI+uuq6IQ==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 62B1F1800602; Mon, 28 Jul 2025 12:31:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 04/15] hw/intc: Add hvf vGIC interrupt controller
 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <1F4C322B-8D95-43D0-96EF-66B0C4C5E55E@ynddal.dk>
Date: Mon, 28 Jul 2025 14:31:26 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <932A2760-B5E5-418F-BB16-C23E4AE176AF@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
 <20250728055701.38975-5-mohamed@unpredictable.fr>
 <1F4C322B-8D95-43D0-96EF-66B0C4C5E55E@ynddal.dk>
To: Mads Ynddal <mads@ynddal.dk>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MiBTYWx0ZWRfX8MI8nXL0oqsX
 xTV7+NsFbUy+uEQRdluv8M3Tr+XO2TmFRgu6Kv7eduljZlrUzEMEifTA/lApD2vpNvgeVMycdM9
 VwU3UABijN/JZkLBR+RLopOICOuNGsNQZxmRgMaxmd8I/HlOcEWmdMNKNWyOoOg3uWEm72A4sV5
 Ml4eNo6pXyAtqTV41AbaJSm32G+TsKNMCEY8bW0kp5/Y/Hcj0U/9m3Oh3odgHQthSW1F8xguoa7
 LeFsrWcLeswvbj0mbh6xwk1Fz9MmQfC/BF4+8lEU8PENMASN216H0AbvqQ3/5MevHeRSucip8=
X-Proofpoint-ORIG-GUID: e6f5Pm4pEeM7MixEWG5BVz49uGLdQWux
X-Proofpoint-GUID: e6f5Pm4pEeM7MixEWG5BVz49uGLdQWux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1030
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507280092
Received-SPF: pass client-ip=57.103.85.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 28. Jul 2025, at 14:15, Mads Ynddal <mads@ynddal.dk> wrote:
>=20
>=20
>> +    /* Redistributor state (one per CPU) */
>> +
>> +    for (ncpu =3D 0; ncpu < s->num_cpu; ncpu++) {
>> +        GICv3CPUState *c =3D &s->cpu[ncpu];
>> +        hv_vcpu_t vcpu =3D c->cpu->accel->fd;
>> +
>> +        reg =3D c->gicr_waker;
>> +        hv_gic_set_redistributor_reg(vcpu, =
HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
>> +
>=20
> Sorry if I'm belaboring the obvious, but I think you need to call =
these
> from the owning thread of the CPU. This is also stated in Apple's docs
> (some are documented; some are not!).
>=20
> I had to do that in the branch I was working on. You should check the
> return of the functions 'hv_gic_...'. They give an error when called
> from the wrong thread.
>=20
> Could this be related to commit "hw/intc: hvf: add migration blocker
> when using multiple vCPUs with the Apple GIC=E2=80=9D?
Yes that was it.=

