Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D6C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNYi-0006kf-SB; Mon, 28 Jul 2025 09:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugMsl-0007Jg-Oi
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:23:11 -0400
Received: from p-east3-cluster1-host4-snip4-9.eps.apple.com ([57.103.87.42]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugMsi-0001GT-Q6
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:23:07 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-9 (Postfix) with ESMTPS id
 771F6180012A; Mon, 28 Jul 2025 12:22:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=iRSBJ3+YFY5bpcRbO8wn3QXXOuEey9I9ax0VsvWdEuo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=PeTz0KezFKxZkmjdfNNfTfggAZ/4sVLW9UyS2i1B9/CoV4SHHCT+ruS0kerB8x1YGC4JhlY5+GT4vGaDIyGaLBNoZRelj0RsyfLZS6z4ZL64CyP9TrwpoRcOuhDfh+msCVz2Ax1U9+DzTvt22uw1i7R8kdDKofgqr89MV7wUVfnevLyb+/AWiKbIeuz8gPx0MAltcKL5LepWdEf8YBAfFYwZitQqGr9Q/uLAQp1WcWvJkSliffmyqttR5aSG4Z2iESdAYWpnlFlZ6kJpTLB87kHJOjYzqJj2iR5Y7QNf7cZcdvms3HE2omMSGcFKBjVn9I+3QDh1ypk5whYheT827A==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-9 (Postfix) with ESMTPSA id
 936BA1800153; Mon, 28 Jul 2025 12:22:57 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 04/15] hw/intc: Add hvf vGIC interrupt controller
 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <1F4C322B-8D95-43D0-96EF-66B0C4C5E55E@ynddal.dk>
Date: Mon, 28 Jul 2025 14:22:45 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB956BCB-3A16-4129-86D6-E16CDDE07EE9@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
 <20250728055701.38975-5-mohamed@unpredictable.fr>
 <1F4C322B-8D95-43D0-96EF-66B0C4C5E55E@ynddal.dk>
To: Mads Ynddal <mads@ynddal.dk>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MSBTYWx0ZWRfX4GimhmplMfXw
 T3UIcLJS83DhhTil3svyL+KfZM16wWK80Y+MZwvct8zfn9R79ednaZXrwMqBFuyeDCfR5SCIfVg
 XgA14ZZScdNhIVEgpRb0XKbo8x+sqViUOxTJs8ajPV9RFiGZwkzMmWVdF/8Sl5JNTKyA0ymq3Oi
 BGQ7kdZHxxz0Cu4w0qnY+HkiFSv+XnOWq/l9RvI8yj/pBEdc+n7u9lSwGnqRCqHky4wQ5lREOYV
 YkJG9fMhm4Z84dmpVSRFOoIYsxELapUBRN9jCuPE039HeGa1pjjeOJAgnkTWrtf3hZ8DmstF0=
X-Proofpoint-GUID: RxYsj6R2EDwegrKlOP9R6pxLS7KWEhtH
X-Proofpoint-ORIG-GUID: RxYsj6R2EDwegrKlOP9R6pxLS7KWEhtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280091
Received-SPF: pass client-ip=57.103.87.42;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Oh that makes quite some sense=E2=80=A6 thanks for the hint :)

Will fix this and see what happens...



