Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C151FCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5E9-0004BO-SL; Wed, 14 Oct 2026 16:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5E8-0004Ay-Rb; Wed, 14 Oct 2026 16:05:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xH5E3-0003mH-RK; Wed, 14 Oct 2026 16:05:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEiVaI2562494; Wed, 14 Oct 2026 20:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=cQZhYzCHNw70V91KAjuA3h6b5R9qy9GuiL2LcMAr2GM=; b=qNwoJPFJIkoh
 /3xsymTXr6lq7AOf8AYq/88p9fGLd8w34nnm56esgXPm6TIFEVDXznoQpEC+Z+Cs
 v0KTL3lz6iHLRBCAbE8Sm2PhlKM61twiF0N0m4aigiAe1Rmbb3aKxzLOdHRXW/uY
 oSDXVAXeyJlg7+8IIwwZ2JHxTq5IX2TmjEtkT8QcrH9fP3JgHLPfUppjYCqMcM3w
 rY4mS3bNkTJi5d8qMi2d17kEUOdSSmBG5j8Y5C2p4YkMYGyYQSUE3GnQ4uV+ThAi
 7S2XkRY8dltJ4HXWmCE7rZicAQ0nWWFiA/LSgH9uJrXixla0zTZsjc1hf772hUKc
 PPDrOGj/2w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugpgv9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:05:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIl1A7669873; Wed, 14 Oct 2026 20:05:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq3vvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 20:05:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69EK4xMr55837052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 20:04:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE68C58050;
 Wed, 14 Oct 2026 20:04:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 417515805E;
 Wed, 14 Oct 2026 20:04:58 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 20:04:58 +0000 (GMT)
Message-ID: <617108c575264e0c64f79cac78ec10a1fdc140f6.camel@linux.ibm.com>
Subject: Re: [PATCH v2 34/50] tests/qtest: ina230: cover voltage injection
 and power derivation
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
Date: Wed, 14 Oct 2026 15:04:57 -0500
In-Reply-To: <20261012-bmc-minerva-v2-34-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-34-4c3dff084ec9@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acfe06d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=F3-Yzu9HlEloCHeRzwwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ByGHNDrXIYKWn1FWPkfaAVLj4EHEPZs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXwkwJj+GNqi61
 Nlw6ABiQffxLhoTv6VWvr0pdaNYqUEgFnSYF7+0927LXr7Jo3yXyxCmqsA2nSgKcv6MXwfLxkNb
 jQtiK0CU4RrgBfRpiWDzs7kO/3kUaqrrhXhmIICETJnSuIpiAnBrIY0cszeEURk3Lf6ytcCPFmQ
 p07had+6/kZNt+mO7dl2PODKg12mHdQUcTYiX0FZCWUdTOX9109+iO8zvLJCeDmHI0tnTbEUF7D
 +iASHI1eW9SMgH6FdCUvQNETGHZOwKouNrIb4TfFsh3OW1HdknVXOhXPWrifgQJi5lGOqKk1giD
 +26Qut+81Lh/6h844T0GRZLFw9OpsFiI73HflKcPkaBvn34h5/uJbvQIm1F8meGa6ijRXlSNJJX
 cx5Ig5PQk75otSJFqQL2/niWJ0ruGOK+lmUlOZf2I63i/zkJpswsq58yLfjq/X6wl9XOj7mNo5p
 Cip2OGgFDft5ONgERVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX35A1iYiUNeI3
 uiBpgxFobCLQVTZcACvC0IiOMagdlzDCDJ5QA3HopGScHn5ykiI9OM94Q3M3Eg6cs1/nYbSZ7S9
 B7Zlh58bo1u//FM8acydd4p+bXymqvM=
X-Proofpoint-ORIG-GUID: 2lxk07kVEypd6dW6Hi6eslr1XlB8tJq7
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Mon, 2026-10-12 at 16:32 +0200, Emmanuel Blot via qemu development
wrote:
> Cover the shunt- and bus-voltage injection properties and the current
> and power values the device derives from them through the Calibration
> register, including the zero-calibration case and the clamp/overflow
> edges.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/qtest/ina230-test.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
> diff --git a/tests/qtest/ina230-test.c b/tests/qtest/ina230-test.c
> index f7aefd2d97..b01f9445d1 100644
> --- a/tests/qtest/ina230-test.c
> +++ b/tests/qtest/ina230-test.c
> @@ -49,6 +49,33 @@
>  
>  #define DIE_ID_VAL          0x2310
>  
> +/* QMP helpers for injecting the physical inputs */
> +
> +static void qmp_ina230_set(const char *property, int value)
> +{
> +    QDict *resp;
> +
> +    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
> +               " { 'path': %s, 'property': %s, 'value': %d } }",
> +               INA230_TEST_ID, property, value);
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}
> +
> +static int qmp_ina230_get(const char *property)
> +{
> +    QDict *resp;
> +    int ret;
> +
> +    resp = qmp("{ 'execute': 'qom-get', 'arguments':"
> +               " { 'path': %s, 'property': %s } }",
> +               INA230_TEST_ID, property);
> +    g_assert(qdict_haskey(resp, "return"));
> +    ret = qdict_get_int(resp, "return");
> +    qobject_unref(resp);
> +    return ret;
> +}
> +
>  /* Power-on-reset default values and the Die ID */
>  static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
>  {
> @@ -98,6 +125,96 @@ static void test_config_wmask(void *obj, void *data, QGuestAllocator *alloc)
>      g_assert_cmphex(i2c_get16(dev, REG_CONFIG), ==, 0x7FFF);
>  }
>  
> +/* Shunt voltage register, including two's-complement negatives */
> +static void test_shunt_injection(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x1F40);
> +
> +    qmp_ina230_set("shunt-voltage", -80000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8300);
> +
> +    g_assert_cmpint(qmp_ina230_get("shunt-voltage"), ==, -80000000);
> +}
> +
> +/* Bus voltage register */
> +static void test_bus_injection(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    qmp_ina230_set("bus-voltage", 12000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2580);
> +
> +    qmp_ina230_set("bus-voltage", 11980000);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x2570);
> +}
> +
> +/* Calibration-derived current, using the datasheet worked example */
> +static void test_calibration_current(void *obj, void *data,
> +                                     QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +
> +    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x2710);
> +}
> +
> +/* Calibration-derived power, using the datasheet worked example */
> +static void test_power(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("bus-voltage", 11980000);
> +    i2c_set16(dev, REG_CALIBRATION, 0x0A00);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x12B8);
> +}
> +
> +/* With Calibration == 0 the Current and Power registers stay at zero */
> +static void test_zero_cal(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    qmp_ina230_set("bus-voltage", 11980000);
> +
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x0000);
> +    g_assert_cmphex(i2c_get16(dev, REG_POWER), ==, 0x0000);
> +}
> +
> +/* Clamping at full scale and the OVF (math overflow) flag */
> +static void test_edges_overflow(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    i2c_set16(dev, REG_CONFIG, CONFIG_RST);
> +
> +    qmp_ina230_set("shunt-voltage", 81917500);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x7FFF);
> +    qmp_ina230_set("shunt-voltage", -81920000);
> +    g_assert_cmphex(i2c_get16(dev, REG_SHUNT), ==, 0x8000);
> +
> +    qmp_ina230_set("bus-voltage", 36000000);
> +    g_assert_cmphex(i2c_get16(dev, REG_BUS), ==, 0x7080);
> +
> +    qmp_ina230_set("shunt-voltage", 20000000);
> +    i2c_set16(dev, REG_CALIBRATION, 0x7FFF);
> +    g_assert_cmphex(i2c_get16(dev, REG_CURRENT), ==, 0x7FFF);
> +    g_assert_cmphex(i2c_get16(dev, REG_MASK_ENABLE) & ME_OVF, ==, ME_OVF);
> +}
> +
>  static void ina230_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts = {
> @@ -111,5 +228,12 @@ static void ina230_register_nodes(void)
>      qos_add_test("defaults", "ina230", test_defaults, NULL);
>      qos_add_test("soft-reset", "ina230", test_soft_reset, NULL);
>      qos_add_test("config-wmask", "ina230", test_config_wmask, NULL);
> +    qos_add_test("shunt-injection", "ina230", test_shunt_injection, NULL);
> +    qos_add_test("bus-injection", "ina230", test_bus_injection, NULL);
> +    qos_add_test("calibration-current", "ina230", test_calibration_current,
> +                 NULL);
> +    qos_add_test("power", "ina230", test_power, NULL);
> +    qos_add_test("zero-cal", "ina230", test_zero_cal, NULL);
> +    qos_add_test("edges-overflow", "ina230", test_edges_overflow, NULL);
>  }
>  libqos_init(ina230_register_nodes);
> 


