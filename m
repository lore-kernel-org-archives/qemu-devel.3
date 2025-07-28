Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9430EC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNMX-00029j-7n; Mon, 28 Jul 2025 08:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ugMlx-0005D5-OM
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:16:14 -0400
Received: from p-east1-cluster3-host2-snip4-9.eps.apple.com ([57.103.91.150]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ugMlq-0008BC-C6
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:16:01 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPS id
 87AE01805908; Mon, 28 Jul 2025 12:15:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=dx9iNuCXde9aI1tiGl0SdyHKxu//3jAepAe8xuGXnJU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=yAHi2+WugsgkHUZHNi3aYi/OWR5zfqg1t92wrMteDBpO+RpaxGgS6X8OWnruRj5EXkI31DtzRxkPiVNWoZfU62OFuKNu6ODS6mxbMIRuBVz0T/anfXofNyb5jy79JRnMXUeqWoPxfDO/E16GEJwkOjApAnONYVbDYyJlVwypHvyQuD0Qrh2LZMoOQvZq4lYdUR8KRqDxpnaVK2o8d60Q/YGT5rTFfNGAGD6prqx2rNZek0xoUMrp9DNhfHBr4UtDQW76qAZoaF4glpqPykQr5Wqx0x6YtCqhnEl4EmTX9P0UrBP8XJYLmo4EHEQMHgdqhXql5LHOjxa9uRZEEWG0iA==
X-Client-IP: 212.60.126.184
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPSA id
 7CED4180591F; Mon, 28 Jul 2025 12:15:45 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 04/15] hw/intc: Add hvf vGIC interrupt controller
 support
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250728055701.38975-5-mohamed@unpredictable.fr>
Date: Mon, 28 Jul 2025 14:15:33 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F4C322B-8D95-43D0-96EF-66B0C4C5E55E@ynddal.dk>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
 <20250728055701.38975-5-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MCBTYWx0ZWRfXxTc3XBufyFSn
 jvbhnz8olQNMEfa9gE3okmIg24GwXmctbhworkzsxQgYQHRB+8oT2Lh1JNfQvC6ubdxHTJARcwf
 Pnf8Z9H1vMjAK25l2rLZV1ekCLXzIrhL06VGf1/7g/KRnH2WOoqCB5Q5rQQVISDQWdRI0fBn0NT
 uI9j0teb4pQP6MX/0dM8dE3LFHyZ7pQIyaAlWWKKgAk3+1ClhqIC4LjeQtFgCDhZwu8X5a1p7zB
 52KONrpipzNKdSGib+Zd3dx2+c7gZBjhwX43T6IRcXBwBU7o68vwpSpcJU/v/P09tZeLnEk+0=
X-Proofpoint-GUID: tNSVMNe2o3ZpgqID28LlT5lGvDL_m3CL
X-Proofpoint-ORIG-GUID: tNSVMNe2o3ZpgqID28LlT5lGvDL_m3CL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 clxscore=1030 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280090
Received-SPF: pass client-ip=57.103.91.150; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
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


> +    /* Redistributor state (one per CPU) */
> +
> +    for (ncpu =3D 0; ncpu < s->num_cpu; ncpu++) {
> +        GICv3CPUState *c =3D &s->cpu[ncpu];
> +        hv_vcpu_t vcpu =3D c->cpu->accel->fd;
> +
> +        reg =3D c->gicr_waker;
> +        hv_gic_set_redistributor_reg(vcpu, =
HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
> +

Sorry if I'm belaboring the obvious, but I think you need to call these
from the owning thread of the CPU. This is also stated in Apple's docs
(some are documented; some are not!).

I had to do that in the branch I was working on. You should check the
return of the functions 'hv_gic_...'. They give an error when called
from the wrong thread.

Could this be related to commit "hw/intc: hvf: add migration blocker
when using multiple vCPUs with the Apple GIC"?=

