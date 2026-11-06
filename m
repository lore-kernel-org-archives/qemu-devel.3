Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11B606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rk3vBL9V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQRD-0001Mr-M6; Fri, 06 Nov 2026 15:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQR8-0001IG-CF; Fri, 06 Nov 2026 15:21:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQR6-0006h0-Mu; Fri, 06 Nov 2026 15:21:22 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6IECuM1545935; Fri, 6 Nov 2026 20:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=SBZhc42OfepVtuuYpcDiAZ9PGK5lN0Jtnz/E04LROns=; b=rk3vBL9VKlQM
 vMMxSvpjQ5I1m0SCFeBzRKQmIJhjvd2Ewn74aQkJBoOfAEkauhQRojvk5A4e5cCE
 lAA83WVTyYFh0sLJAFkkmYZ1DcFvRLuxjbG+k20FazIZZrk8T/v1dCOMt6gHSBkE
 rfEaJIBDuBHX1VHu9/ESz/BkqubInuRlcfXQqBDkh/fHr9zXEsMi9RIg6TTg2/Li
 2t2RGIRNnNsL8SD91QFhrjS1OCzXw2rR47bCNBe3jQHT0VrpAKvSusOs2din/OzT
 E9E68YTopUT1xKfe4/XIsSpmBMrOUm3ul6M7ZdkpXx1OJ56dBbGfp4UGd1onvIwI
 tih8g4qKyg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rayyq7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:21:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Jr1uI2652249; Fri, 6 Nov 2026 20:21:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h165gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:21:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KLHpf40501700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:21:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7366258052;
 Fri,  6 Nov 2026 20:21:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E58558067;
 Fri,  6 Nov 2026 20:21:17 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:21:17 +0000 (GMT)
Message-ID: <b2d13e9b7f51f35b32253edc8de70d025385c1d0.camel@linux.ibm.com>
Subject: Re: [PATCH 7/8] hw/gpio/pca955x: Improve @qapi-type reported by
 qom-list etc.
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:21:16 -0600
In-Reply-To: <20261106110440.3552588-8-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-8-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aee36be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=sWN3zfszUj_efFXM9Y4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WpEX86U4NGkBekw68LhIi0KYyCcGsGTD
X-Proofpoint-ORIG-GUID: WpEX86U4NGkBekw68LhIi0KYyCcGsGTD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX5BDuJIYV0COV
 cGCJJii3HrKZ63N0ZPxsJSGkBhojChYPen4jW1fDWkIVyQE6q1rxBTl/94qMp81VfUt1oZm+ax8
 j6O36ByHwNwK9T+EMv85+S2Lf4pFZjw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX5Mek1HGFqexD
 vIPUx7DojArgcqSmIRKGJCchs1nU9kL2Y7AJ6a+4ejPOB8CwlobZGLWBPO4QlprefoEhKA56323
 y+83eOg/SYjI7jyBKXZJY+OHgu6XqgKddE16JhDDQw6RhV40fv2L5qT8czwcPfXefskhpRxZYgg
 1oJLuaMkVU8sI9fwPD3X4bVeNJN2JdQfSIVGPpchDxcUpakmGe4+UEyfmM71IzeHVGoMP5UzVi7
 8mE0pVD3t4/PXR0CP9KmGX1Qyon1ebBmbWjRXrXxZmwoyZRyCDfQ2qJ1JL+81nmTMJFzE+Y227E
 4kk2SXOdf+/t89T/0j+qva+kzUag6RFaxi91heX/GvbvBx9aM0qZsP/7v6h05ZLzjhn60STbY+p
 PIkpRzHBmEFvG8xKksX56gQSqD9jzNCc1NbQQZIopPnoDzUThHiavUTFi/YfRWdKVEo2SnCMvRq
 LatCWDjG4ZBmQFtRkLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060080
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
>  hw/gpio/pca9552.c | 6 +++---
>  hw/gpio/pca9554.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 99c4e0c0e2..f97ad6d083 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -23,7 +23,7 @@
>  #include "hw/core/irq.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-type-infos-machine.h"
>  #include "qapi/qapi-visit-machine.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
> @@ -547,14 +547,14 @@ static void pca955x_pin_init(PCA955xClass *k)
>              /* LED variant: expose the LED selector state as led%d. */
>              name = g_strdup_printf("led%d", ix);
>              object_class_property_add(OBJECT_CLASS(k), name,
> -                                      "str", &str_type_info,
> +                                      "str", &Pca9552LedState_type_info,
>                                        pca955x_get_led, pca955x_set_led,
>                                        NULL, NULL);
>          } else {
>              /* GPIO variant: expose the pin logic level as pin%d. */
>              name = g_strdup_printf("pin%d", ix);
>              object_class_property_add(OBJECT_CLASS(k), name,
> -                                      "str", &str_type_info,
> +                                      "str", &GpioPinState_type_info,
>                                        pca955x_get_pin, pca955x_set_pin,
>                                        NULL, NULL);
>          }
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 7bbfd5ed5f..e2d481866f 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -17,7 +17,7 @@
>  #include "hw/core/irq.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-type-infos-machine.h"
>  #include "qapi/qapi-visit-machine.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
> @@ -288,7 +288,7 @@ static void pca9554_pin_init(PCA9554Class *pc)
>  
>          name = g_strdup_printf("pin%d", pin);
>          object_class_property_add(OBJECT_CLASS(pc), name,
> -                                  "str", &str_type_info,
> +                                  "str", &GpioPinState_type_info,
>                                    pca9554_get_pin, pca9554_set_pin,
>                                    NULL, NULL);
>          g_free(name);


