Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C166C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOKv-0007Af-Jt; Thu, 16 Jul 2026 11:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOKu-0007AP-H6; Thu, 16 Jul 2026 11:49:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOKp-0002aJ-L4; Thu, 16 Jul 2026 11:49:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDg0sH3285294; Thu, 16 Jul 2026 15:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=MBaogVelM5qmxX74UeR0bYxeAWlAnV9Z+sA/oReMod4=; b=nWu/iNvAjVgx
 bsolHOksb2kjoobUvumAyljZtrnugjxfsmkT/4mrl8P8yeH6MZ6Uo6G0DDzS9xFZ
 inMY02Sl+Cwnpg4pHsEi9dbORCL92/vvXRZGx4OPPBG0vSG+AEBRFc2RnNX9PdgA
 XwP9BdYSGCCCHuUHw8AB+qG8Wyo/BfNJP/YXqCLGvYRXOBcWJSN7Tgsg/eEGjJFA
 qomgFhbtvmEjzAMwiehvGqaJfADskDhsooNznCOx4QE47LvtVATuZn7er9eqN6ak
 TjkyQkcScySVb+lmTaONsjb+giPPcQTYU6PH2R94PCOTdUDDAgFJqlZYhkgBN0za
 nD0S03C2ug==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2agymp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:48:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GFYcMM032679;
 Thu, 16 Jul 2026 15:48:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwdtmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:48:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GFmntM30474968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 15:48:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63A3D58056;
 Thu, 16 Jul 2026 15:48:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A18E958052;
 Thu, 16 Jul 2026 15:48:48 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 15:48:48 +0000 (GMT)
Message-ID: <abe01b7fae240135243eec01401ce9bdbb229775.camel@linux.ibm.com>
Subject: Re: [PATCH 19/29] tests/qtest: add PCA9554 register access tests
From: Miles Glenn <milesg@linux.ibm.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Corey
 Minyard <cminyard@mvista.com>
Date: Thu, 16 Jul 2026 10:48:48 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-19-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-19-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX3le4S8mGuzRx
 HW4XyH/dXXN5KRBFdytbYH9RTCSaxtzhIFzu2KZBeYJ137FjUXnppNALd1jgS84zoRRUgwAZn3M
 FY5UK3TGnbQvGL+eQlq2GQKxcqePmt8=
X-Proofpoint-GUID: RrHkgZUlT8p5DcfOMx99QgV9e3ty1HFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX+Mh/PZqqq5S/
 +mEn+OM6+1YRONbLRovkBbJqlH+mYmPja7atPZ3aOm61YyBPS5EZlEENem9/selcaO4gXmJ2o8H
 UVSLmmwWAIsfZrTaUNY51aOGFUAzNjMxZoXV9PzACUcaThI9opP0HH4VaeTlY7lVDxwLdBuy4aH
 0THXRK+lqcuveP4a1adTPUseRZyozT3q0uhIY61EbZDEqBHASa+jaHUlpkS5wLEEq3MUz+McntO
 cxmz6xYfDeW+yi/hf7jhmq4r1dDlOriRot/+C1xgVUGgCAXB64/k5F3lukrd54wycQgn4uSQLDi
 3q7jvPvA2wpqgDPuCrPTnxFbxOXJVz9KIXLNLobnX+Kx+SjkWMPlsGDfrSUD0QXVgOGzjXcflvN
 kD44klKM5O8sKb0bwvlTvxXwBJlsvxAFoZKcJZuJh+ZU4j+6bplcaHha+bPuyqTP+tXQlQ6+K+0
 jhaBKTfkrwV6IaJgo3w==
X-Proofpoint-ORIG-GUID: -TkTlCRQxIUxmyUXKgseH7_drVq5Zl10
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a58fd63 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VabnemYjAAAA:8
 a=VnNF1IyMAAAA:8 a=s28BrN_b0GBEnfV0YMcA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-07-09 at 17:23 +0200, Emmanuel Blot wrote:
> Add a qtest for the PCA9554 8-bit I/O port expander exercising the basic
> register access: power-on reset defaults and read/write of the OUTPUT,
> CONFIG and POLARITY registers.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/meson.build    |  1 +
>  tests/qtest/pca9554-test.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 2c283708a5..2f35bde630 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -318,6 +318,7 @@ qos_test_ss.add(
>    'tulip-test.c',
>    'nvme-test.c',
>    'pca9552-test.c',
> +  'pca9554-test.c',
>    'pca9555-test.c',
>    'pci-test.c',
>    'pcnet-test.c',
> diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
> new file mode 100644
> index 0000000000..a5f213a59c
> --- /dev/null
> +++ b/tests/qtest/pca9554-test.c
> @@ -0,0 +1,41 @@
> +/*
> + * QTest testcase for the PCA9554/PCA9536 I/O port expanders
> + *
> + * Copyright (c) Meta Platforms, Inc. and affiliates. (http://www.meta.com)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/gpio/pca9554_regs.h"
> +#include "libqos/i2c.h"
> +#include "libqos/qgraph.h"
> +
> +#define PCA9554_TEST_ADDR 0x20
> +
> +/* Verify power-on reset defaults match the PCA9554 datasheet. */
> +static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    /* All pins are inputs, pulled high, with no polarity inversion. */
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0xFF);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x00);
> +    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0xFF);
> +}
> +
> +static void pca9554_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions opts = {
> +        .extra_device_opts = "address=0x20"
> +    };
> +    add_qi2c_address(&opts, &(QI2CAddress) { PCA9554_TEST_ADDR });
> +
> +    qos_node_create_driver("pca9554", i2c_device_create);
> +    qos_node_consumes("pca9554", "i2c-bus", &opts);
> +
> +    qos_add_test("reset-defaults", "pca9554", test_reset_defaults, NULL);
> +}
> +
> +libqos_init(pca9554_register_nodes);
> 


