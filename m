Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA1CCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXWy-0001A1-1B; Thu, 14 Aug 2025 08:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1umXWu-00019r-CH
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:04 -0400
Received: from p-west2-cluster4-host11-snip4-10.eps.apple.com ([57.103.69.141]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1umXWq-00045M-Dv
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:03 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 97F711800212; Thu, 14 Aug 2025 12:57:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=HNADxR8s6utf4HepPrVf3YVfoL+tnSikU2SoCAMdg6c=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=G4ijT7JK+SNLJlO033yfz9QhvC6JW57Noji1ZasNyvlYEPlGYn8NZgOGECv+xrOmZ5BT/kJGF8tiKywZX+FqwKippy2C69p2APwb9Y/w3sQsNW6iIMatqXTatx1W+xIdxcIoz2psJTLWQto4dF9qduVzYyYh5vvWhKQDHhaakB3Z8J3TbiOK7BZUve0D5uyXSxFb0Nrg0QZTcV45dFpgFUGVdEth2gD4tOl1/lMF92d6S1Izs0KgVVARrFJ1ko+29QWRf9yzcIg1FPIdJrqMXF/R8Wft41OMom8QA3vuDpWccwdeBePs6HXj8Pbb3fDsyLhsXNOxCHxLagznVLfOXQ==
X-Client-IP: 212.60.126.184
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com
 [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 D2BAF18000A6; Thu, 14 Aug 2025 12:57:31 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 04/13] hw/intc: Add hvf vGIC interrupt controller
 support
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250808070137.48716-5-mohamed@unpredictable.fr>
Date: Thu, 14 Aug 2025 14:57:18 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <40259CA2-A38D-41C1-A726-5144FB9EA166@ynddal.dk>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-5-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: Q69cHdScBdiRdeFfgLPgif6LY_VO_RjW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDEwOCBTYWx0ZWRfX1x7hYDt4nmNi
 XEvr2JlGqD/E1Tl5gEKUmlmNrHjZkz4XKlLG7wIk4iLh/8l/XfjIPVoMOak4nLy9YpcDFfL0srb
 81+gqnWHV2oIN6RU8A0QDX1wYMdLpb/mf4BhyBa+B0YOOaawkKNDMZ11RHmUtWdqj1k9zpMtqPY
 +oksTp1OINeevt35p/ZEgoQA8bBAOmsTtyjqo7cVmCWLYaLSKbLW8GcjDpNQPM2XyRJf4al7vLT
 4EG1dmhuBkY9f1pvfoB5e87f3Bj2gf4HR5lCnx0szW9cBdgUfz2auyXrLokVEHeohFNND1VBg=
X-Proofpoint-ORIG-GUID: Q69cHdScBdiRdeFfgLPgif6LY_VO_RjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508140108
Received-SPF: pass client-ip=57.103.69.141; envelope-from=mads@ynddal.dk;
 helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


> +static void hvf_gicv3_put(GICv3State *s)
> +{
> +    uint32_t reg;
> +    uint64_t redist_typer;
> +    int ncpu, i;
> +
> +    hvf_gicv3_check(s);
> +
> +    hv_vcpu_t vcpu0 =3D s->cpu[0].cpu->accel->fd;
> +    hv_gic_get_redistributor_reg(vcpu0, =
HV_GIC_REDISTRIBUTOR_REG_GICR_TYPER
> +        , &redist_typer);
> +

I think you should go through all your "hv_" calls and do error handling
where it's possible, and if not, at least check it with assert_hvf_ok.
This call to hv_gic_get_redistributor_reg is failing on my setup. I
don't know if there could be others.

I've configured my VM like this:
-machine virt,kernel-irqchip=3Don,its=3Doff
-boot menu=3Don,splash-time=3D0=

