Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11416606A33D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vates.tech header.i=@vates.tech header.a=rsa-sha256 header.s=selector1 header.b=IRJqKkLr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwOP-0002zz-3A; Mon, 16 Nov 2026 08:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1e34487400006d3f@swg.vates.tech>)
 id 1xSrBa-0003Pm-0T
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:31:30 -0500
Received: from prod-mta-13-02.swg-srv.net ([185.255.28.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1e34487400006d3f@swg.vates.tech>)
 id 1xSrBX-0007OK-UH
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=Nwwt/4vBCR1lInQ0cdZE9AMRK8Aj0Ye4cseam+DoC/c=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=IRJqKkLreZnrqVs4FHeJk0ETAB+yrsf/0SSwEAuqKgB9E2YUpEVIT3Dzzhekctk8k6+otHvca
 67f+LR29YPxGWxQRoEFD+dL4q3mTzOjIs39+pehowLVHvt0dKu8qbol/L9XuOw44h3J5+nxHwIw
 xsJWbtwVYr6PrUtSjmdbe4gpceN61EKabzQL1PQMyuzjp+O8Y3gtz1Snw7Bhi/UbBgAWMFbmyhK
 d95es603/rT0zP4wNAfM6ErO+3BE98auYQtTpQHpKS+Efp+ObdfrYuzXA+FncD8DotRiwXqownA
 cEPonCsIXskmkJ99VUmogWJSjoIuF6fkUY069vm2L9ug==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender:
 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-02.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id
 1a1e34487400006d3f.004 for <qemu-devel@nongnu.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 16 Nov 2026 07:31:21 +0000
X-Zone-Loop: 9f489d3a630d9053ef35eee23652402f8ba54bb8c710
x-campaign-type: default
x-transaction-id: 7e646f60-1696-4d53-830b-7ce9edd2da1b
x-swg-uid: 01-7603fd69-28a3-4761-bcb0-c650d41fd1a8
X-Mailer: Sweego
Message-ID: <1794814281.8631fc262581453bbf619ec5b2062170.1a1e34487400006d3f@vates.tech>
x-swg-bid: 1794814281.8631fc262581453bbf619ec5b2062170.1a1e34487400006d3f
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
Received: from [192.168.1.97] (82-67-211-29.subs.proxad.net [82.67.211.29])
 (Authenticated sender: julian.vetter)
 by mail2.vates.fr (Postfix) with ESMTPSA id 8FF6881B4B;
 Mon, 16 Nov 2026 08:31:20 +0100 (CET)
Date: Mon, 16 Nov 2026 08:31:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: Mark legacy Xen backends as hotpluggable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: xen-devel@lists.xenproject.org, Peng Fan <peng.fan@nxp.com>
References: <20261116-qemu-xen-usb-v1-1-bff36d5b646b@nxp.com>
Content-Language: en-US
From: Julian Vetter <julian.vetter@vates.tech>
In-Reply-To: <20261116-qemu-xen-usb-v1-1-bff36d5b646b@nxp.com>
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative;
 boundary="-=Part.179.c6946c0d6bf33d1d.1a1e3448446.59381d4b10d6f84f=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1794814280778
Received-SPF: pass client-ip=185.255.28.35;
 envelope-from=prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1e34487400006d3f@swg.vates.tech;
 helo=prod-mta-13-02.swg-srv.net
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:05:00 -0500
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
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

---=Part.179.c6946c0d6bf33d1d.1a1e3448446.59381d4b10d6f84f=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/16/26 03:56, Peng Fan (OSS) wrote:

> diff --git a/hw/xen/xen-legacy-backend=2Ec b/hw/xen/xen-legacy-backend=
=2Ec
> index 7977b527127=2E=2Ebf4396c9460 100644
> --- a/hw/xen/xen-legacy-backend=2Ec
> +++ b/hw/xen/xen-legacy-backend=2Ec
> @@ -640,6 +640,13 @@ static void xendev_class_init(ObjectClass *klass, c=
onst void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    /*
> +     * Legacy Xen backends are created and destroyed dynamically from
> +     * xenstore at runtime, after the machine has been initialized=2E
> +     * TYPE_DYNAMIC_SYS_BUS_DEVICE marks devices as not hotpluggable,
> +     * so override that here=2E
> +     */
> +    dc->hotpluggable =3D true;
>       dc->bus_type =3D TYPE_XENSYSBUS;
>   }
>  =20

This also fixes the legacy vfb/vkbd backends with -machine xenpv=20
(qemu-system-i386 -xen-attach -machine xenpv -vga xenfb) on an arm64 Xen=
=20
4=2E21 host=2E Without this fix QEMU exits with "Device 'xen-backend' does=
=20
not support hotplugging" as soon as the backends are created from=20
xenstore=2E Tested on top of QEMU 10=2E1=2E0 with an arm64 Debian 13 guest=
=20
(xen-fbfront/xen-kbdfront)=2E

Tested-by: Julian Vetter <julian=2Evetter@vates=2Etech>

>=20
> ---
> base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
> change-id: 20261116-qemu-xen-usb-1a36b002a561
>=20
> Best regards,
> --
> Peng Fan <peng=2Efan@nxp=2Ecom>
>=20
>=20



-- 
Julian Vetter | Vates Hypervisor & Kernel Developer

XCP-ng & Xen Orch=
estra - Vates solutions

web: https://vates=2Etech
---=Part.179.c6946c0d6bf33d1d.1a1e3448446.59381d4b10d6f84f=---

