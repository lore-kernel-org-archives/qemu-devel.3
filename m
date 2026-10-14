Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA93C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5BT-0002ez-PW; Wed, 14 Oct 2026 16:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5BS-0002eV-5T; Wed, 14 Oct 2026 16:02:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5BQ-0003Nw-3a; Wed, 14 Oct 2026 16:02:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiGRp2562250; Wed, 14 Oct 2026 20:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=k/i3mitAbXS3UrT4AXWPP4LpvSgtolHFepuv/PTMFR8=; b=kWVx/d8IHe6t
 4hjfNHg5hI2qJad/RTl/mMTaLCNUjI0DukXEidGWZqtz+snJWw/lnV2mH55WZ7bR
 c0BaHD4kIiiS9bEnl1u5rZXdt1DPFOsI9XaJjV3tU+Omuy2p9f14DMN7KeiS3PxL
 2Ro4jG7Q/L/5BNEf5XHPsIOfVSrLga/3yNJOWXwyoIQ0Gq5aWOxO2HrZgWlcR63/
 SmjiBBsBnWWaXtfBc/eAYyDArcZLjofmNy6RgqN1zGSJ2TjEw8OUzWRkLT0bUk42
 idiMpkMDZ4fXIyioGsZymNPl/2MCJHIrrZ2HFwIk24vZFPlG/qppDAP7AnMHt/kW
 q4n1N2mA2A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugpgge-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:01:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIl19I669873; Wed, 14 Oct 2026 20:01:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq3veh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:01:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK1tWi35324286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:01:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E14F58056;
 Wed, 14 Oct 2026 20:01:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDF1058052;
 Wed, 14 Oct 2026 20:01:53 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:01:53 +0000 (GMT)
Message-ID: <0a89d4d7abf1054008ccc90e73089c7f528bf750.camel@linux.ibm.com>
Subject: Re: [PATCH v2 37/50] tests/qtest: ina230: cover operating modes and
 triggered conversions
From: Miles Glenn <milesg@linux.ibm.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy
 Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, Patrick Leis
 <venture@google.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:01:53 -0500
In-Reply-To: <20261012-bmc-minerva-v2-37-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-37-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acfdfb6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ahjBMUgcp2ig2-Mr0kAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FtZtWPagZLwSMBiwMoIjZKfbsbJdtHpE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3AuqR3jP3K9w
 yoAyhOPU9r0/WHRroxv8b2ZEREzmUh8XpMilixSQBJFoXiDdhryPpylc189U+0lELtjm8C9hVaR
 zTD00Jb+NGEGEP7yUPP9N/N+GiEGPpcI50hJv7aGWCQ2Fl0nfjGkIK1U23tVhIajyAfJn2K4I/B
 KsuUvZzPHPasPKqGYzTF/sAmgitSSViFFAwurMax4UcIrhQi4xKvnCB8YD44RszVKSZueqKGNcg
 JLfVpeUnJw42Ugzpe94MlDvbKB/V0dW7lB442FCAKj1IER75Yyk5Xq41gW+sOB/JUSDfsT54iZ/
 TBW6FaYG4vDfax557d8X48oy1Zv63m+tScl4sbSUg5R6A6QtN+jDszBae0IuIgerjoX1g1ZwtDO
 N3i9WB3cw/r4M1N8IxKEHULVR9g6LneFTHwMhGBEUyQUt6mV2ILgnCyPwlyx9aC19k539Kprq4n
 JWC/MzHLplkCH1k5BCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3wIw/uDjF4HS
 vCQNW+FZHEMl4ePZKv7j3uIYPpBx75tAj3oP7eGOoD53eZPeARw3fWieqQqr58LkFz8ozFNqpKB
 jqrvlRHJaR/PTl5pelkpo4zjL/hYkJs=
X-Proofpoint-ORIG-GUID: j-djpvX0movUyMzNXg8QHU2IOrz6FgZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2026-10-12 at 16:32 +0200, Emmanuel Blot via qemu development
wrote:
> Add coverage for the MODE field: power-down retains the last results,
> the shunt/bus channel-enable bits gate which registers track new inputs,
> triggered modes convert once per Config write, and bus-only mode still
> derives power from the retained current.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> index 36c899efee..f8b982686a 100644
> --- a/tests/qtest/ina230-test.c
> +++ b/tests/qtest/ina230-test.c
> @@ -142,7 +142,97 @@ static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x7FFF);
>  }
>  
> -/* Shunt voltage register, including two's-complement negatives */
> +/* Operating modes */
> +static void test_modes(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +    static const struct {
> +        uint8_t mode;
> +        uint16_t shunt, bus, current, power;
> +    } cases[] = {
> +        /* Power-down: no conversion, every register retains the baseline */
> +        { 0x0, 0x1F40, 0x2570, 0x2710, 0x12B8 },
> +        { 0x4, 0x1F40, 0x2570, 0x2710, 0x12B8 },
> +        /* Shunt only (continuous): shunt and current track the probe */
> +        { 0x5, 0x0FA0, 0x2570, 0x1388, 0x12B8 },
> +        /* Shunt and bus (continuous): every register tracks the probe */
> +        { 0x7, 0x0FA0, 0x12C0, 0x1388, 0x04B0 },
> +    };
> +    size_t idx;
> +
> +    for (idx = 0; idx < ARRAY_SIZE(cases); idx++) {
> +        i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +        i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +        qmp_ina230_set("shunt-voltage", 20000000);
> +        qmp_ina230_set("bus-voltage", 11980000);
> +
> +        i2c_set16(dev, REG_CONFIG, cases[idx].mode);
> +        qmp_ina230_set("shunt-voltage", 10000000);
> +        qmp_ina230_set("bus-voltage", 6000000);
> +
> +        g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, cases[idx].shunt);
> +        g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, cases[idx].bus);
> +        g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, cases[idx].current);
> +        g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, cases[idx].power);
> +    }
> +}
> +
> +/*
> + * Triggered modes perform exactly one conversion per trigger, where the
> + * trigger is a Configuration-register write. Injected input changes
> + * between triggers are ignored until the next write.
> + */
> +static void test_triggered(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("bus-voltage", 11980000);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x03);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
> +
> +    qmp_ina230_set("shunt-voltage", 10000000);
> +    qmp_ina230_set("bus-voltage", 6000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x03);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x0FA0);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x12C0);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x07);
> +    qmp_ina230_set("shunt-voltage", 20000000); /* A */

Is the /* A */ comment intentional?

Thanks,

Glenn

> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
> +}
> +
> +/*
> + * In a bus-only mode the current register is retained, but the power register
> + * is still refreshed on each bus conversion from that retained current.
> + */
> +static void test_bus_only_power(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("bus-voltage", 11980000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
> +
> +    i2c_set16(dev, REG_CONFIG, 0x06);
> +    qmp_ina230_set("bus-voltage", 6000000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x12C0);
> +    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0960);
> +}
> +
> +/* Shunt voltage register */
>  static void test_shunt_injection(void *obj, void *data, QGuestAllocator *alloc)
>  {
>      QI2CDevice *dev = (QI2CDevice *)obj;
> @@ -377,6 +467,9 @@ static void ina230_register_nodes(void)
>      qos_add_test("defaults", "ina230", test_defaults, NULL);
>      qos_add_test("soft-reset", "ina230", test_soft_reset, NULL);
>      qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
> +    qos_add_test("modes", "ina230", test_modes, NULL);
> +    qos_add_test("triggered", "ina230", test_triggered, NULL);
> +    qos_add_test("bus-only-power", "ina230", test_bus_only_power, NULL);
>      qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
>      qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
>      qos_add_test("shunt-limits", "ina230", test_shunt_limits, NULL);
> 


