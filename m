Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2C606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B25csijb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQNh-0006eU-Ne; Fri, 06 Nov 2026 15:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQNg-0006c6-0e; Fri, 06 Nov 2026 15:17:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQNe-0006GV-Bx; Fri, 06 Nov 2026 15:17:47 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6IEMaI3180583; Fri, 6 Nov 2026 20:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=m6Uojz4JZDbKVb6e4F5Ke6wecXtWkQnGjGvC/VJM33M=; b=B25csijbFU+8
 6/YmYpDj5YJ3YWOKO3AAnk6ULSm2+YQEPAHxzqf2YPT+t7W1A1Q/mfopq7P7mXr/
 /ulGdNFS/YJrVKjGJS1qPPZtS5EsY7DqfZQ+YAEucAyB4YJ/ZksvjsYx/5JaTDud
 Cu3P7Rvy61mQDqCmL+wTHkAbH/qiELHJF49DeGfgm1uar7QMArMbo/oyDi4rp8id
 JLIHYJqJt8tkaPxrjIcm4D7j9e+gbEVJpxlT1hlcgvz1CFYx3Lvs71+J2++FuGHW
 nEDQv6sKsFkaghHs2w+J6OpshWhmdt3B8+gkLHvxXBpnXvgcwpxfxoWDxSzXAIQz
 SxfXD5j3Ng==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9fvf6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:17:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6K5dar3838964; Fri, 6 Nov 2026 20:17:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hsk809g5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:17:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KHgrb18481886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:17:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 657025803F;
 Fri,  6 Nov 2026 20:17:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4C8058056;
 Fri,  6 Nov 2026 20:17:41 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:17:41 +0000 (GMT)
Message-ID: <c6fcfb91f1afe9b2f3dde478567e25fa74ebc99e.camel@linux.ibm.com>
Subject: Re: [PATCH 1/8] hw/gpio/pca9552: Convert pin and led properties to
 class properties
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:17:41 -0600
In-Reply-To: <20261106110440.3552588-2-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-2-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LKHz05W9 c=1 sm=1 tr=0 ts=6aee35e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=sWN3zfszUj_efFXM9Y4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tiAzQ_vYTBIENNpvVbpacFzoT9_yaLzy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX1p+RENPZ4xko
 Gt/sGFTKGmEEGtKLpLtAiDpMtpDdRlanNF1Tl9/Uxqv88DhZZWcpOhb8wh3rH0kyOe4DN6Po7I5
 /J/W02sOsFAHHYeUDlSZjilftNOeRqc=
X-Proofpoint-ORIG-GUID: tiAzQ_vYTBIENNpvVbpacFzoT9_yaLzy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX3y30zpfWzB76
 qVMc7fnk4cxVfzbCK8aabfY7FHF1Lr29hK9MZUC9IQyO30eXLGi0U3KQpx7TVEvtETO3wXGG0zg
 SbEA0qORI7BOQIX22LKhiQMLHUuXAQVntfXrXIKkquTl4qDqSpc9RU6etr5YbBkxwbJO0x1o58i
 M04ccPUYgeCVavY1MW1u0l9yp74Io9GsheSDB0nNwpUx3PTKRniOW6/dbispbz4AMOBFW+8UxZF
 ICWSeyd6g7hbuWw2SAcihRfqDZrKADoYxWvMnojzv8seHzsxLDTBmcJhAsjumNXP7AQ247IlPa7
 zXkp5Of+F/f3W5x4CpRtFIeojyoGAAokzz4oB8N1IW18uct/RIGhkpT3ADL8G19bud3BQyxJ1xh
 jZxwSM5ZnpA8mMNm2OMVgyI44aB4jJrZneEep5JG/fBWnVzy2Drco8AdP7up6b1cNfoZeR2/u3l
 fdyiFcoek0wQAXab6QA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Fri, 2026-11-06 at 12:04 +0100, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/gpio/pca9552.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 90ccf5170e..65a718ef31 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -557,10 +557,8 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>      s->len = 0;
>  }
>  
> -static void pca955x_initfn(Object *obj)
> +static void pca955x_pin_init(PCA955xClass *k)
>  {
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -
>      assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
>      for (int ix = 0; ix < k->pin_count; ix++) {
>          char *name;
> @@ -568,13 +566,17 @@ static void pca955x_initfn(Object *obj)
>          if (k->has_led_support) {
>              /* LED variant: expose the LED selector state as led%d. */
>              name = g_strdup_printf("led%d", ix);
> -            object_property_add(obj, name, "str", &str_type_info,
> -                                pca955x_get_led, pca955x_set_led, NULL, NULL);
> +            object_class_property_add(OBJECT_CLASS(k), name,
> +                                      "str", &str_type_info,
> +                                      pca955x_get_led, pca955x_set_led,
> +                                      NULL, NULL);
>          } else {
>              /* GPIO variant: expose the pin logic level as pin%d. */
>              name = g_strdup_printf("pin%d", ix);
> -            object_property_add(obj, name, "str", &str_type_info,
> -                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
> +            object_class_property_add(OBJECT_CLASS(k), name,
> +                                      "str", &str_type_info,
> +                                      pca955x_get_pin, pca955x_set_pin,
> +                                      NULL, NULL);
>          }
>          g_free(name);
>      }
> @@ -640,6 +642,7 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
>      pc->max_reg = PCA9552_LS3;
>      pc->pin_count = 16;
>      pc->has_led_support = true;
> +    pca955x_pin_init(pc);
>  }
>  
>  static void pca95x5_class_init(ObjectClass *oc, const void *data)
> @@ -653,13 +656,13 @@ static void pca95x5_class_init(ObjectClass *oc, const void *data)
>      pc->max_reg = PCA9535_CONFIG1;
>      pc->pin_count = 16;
>      pc->has_led_support = false;
> +    pca955x_pin_init(pc);
>  }
>  
>  static const TypeInfo pca955x_types[] = {
>      {
>          .name          = TYPE_PCA955X,
>          .parent        = TYPE_I2C_SLAVE,
> -        .instance_init = pca955x_initfn,
>          .instance_size = sizeof(PCA955xState),
>          .class_init    = pca955x_class_init,
>          .class_size    = sizeof(PCA955xClass),


