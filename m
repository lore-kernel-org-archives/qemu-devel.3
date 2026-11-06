Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8F606A334
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p54qJqAE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQQF-0008W7-3c; Fri, 06 Nov 2026 15:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQQ3-0008Jn-J2; Fri, 06 Nov 2026 15:20:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQQ2-0006VB-1A; Fri, 06 Nov 2026 15:20:15 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6IEQGR3180668; Fri, 6 Nov 2026 20:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=97RrwfeToIPHm7t0HXDUKfcv8MqU2Eug81oBRi6HFK4=; b=p54qJqAEMwoo
 d/QoJqknXJMT/bTxri2GGMlXPMSm6FsQWms+0Qr6S2PcXQooQeE8SQz6oA4colSI
 jTwoDwXxZik4klO9orzvaGNQyFD2pRzm8AQq+E30+7uQEcA/YPGi6N27kNPzHmEi
 LayuZX71JSE8lpkMrb+CMhV0FhGOQQ41seqmRi/5keL+rde6PuV5iNPK2NwADN3o
 5QCnAcMEn2g8oVjryyUAZXHUpEBXy/8ostLnCQ15Z3OhBYCAqjttFQIUucfhGRVm
 Y9zCzxTQSsp9CTwz6Pgy3Rg18v+EadGP2IRR1OE7bDutQT4lUHd8vQ9bbMG1yEac
 VV+vCBDI2w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9fw7p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:20:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Jqm853878300; Fri, 6 Nov 2026 20:20:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7wtvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:20:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KJLuY25232116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:19:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18ABC5805A;
 Fri,  6 Nov 2026 20:20:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89AE35805C;
 Fri,  6 Nov 2026 20:20:09 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:20:09 +0000 (GMT)
Message-ID: <198e792830bab184d564a4ecd7304eed855cf0c0.camel@linux.ibm.com>
Subject: Re: [PATCH 5/8] hw/gpio/pca9554: Convert pin properties to class
 properties
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:20:09 -0600
In-Reply-To: <20261106110440.3552588-6-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-6-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LKHz05W9 c=1 sm=1 tr=0 ts=6aee367a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=PEI-9Z2BaHhFn6PDOIIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QEzm8p7cqVXITSnM2I9Jw887l7wB9_vw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX5XGHMzJr+wiH
 C8Fb+t6VxozK78IiBHVLaZvqXA09Ao5MQ5RGTYzB9fIfgR8zhFYyOWwFMUh9T3WkBwRwrK6hQpC
 faPqApr/iUMlxQVCDfBqlqFtwpMplKU=
X-Proofpoint-ORIG-GUID: QEzm8p7cqVXITSnM2I9Jw887l7wB9_vw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX1En7LZYqZGEf
 kJ2kZv8kkrc+9KocqTzDfnx/yk+xUcOA2R0uldt9KFnr25z5OhJ9pe6UWbObEZz05c7K7YqogZa
 OIjvm1AOce51ZuTjlIyKDoXleEQ6DMiMfHsPlE1odC8/6jVPL2gjpytWOs1P/hjEyPY/5cAMUcO
 9zubXUolury+M6jvVGoRNg3fMPyIeD5ZDlKjyrzQQ+1FQgZTfY4ge8RQyWi/KLjK6ukfrf20JdM
 JPkg2ULco2oSzYtQFmVi63ndONOke94l3wgOGy1uDkdRuLNF3a0jtFFLbiT/kV/4S4PynlKITI9
 P0H3gzEB2Z/9jZyXCQm+Q80DbajD1GEWnhlrWvlSxDzJURVqgCIo7u3Q24OlkR14/gLwTdeULwR
 KY/eyCmd/sre9Pp32eMJCGYBki9aUpNWwE+xHkhIfL2G7ljI01rvCl/W/mq9sGMGR9t3l8QLdAZ
 HwZbY+f8a7JabCChHbw==
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
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Fri, 2026-11-06 at 12:04 +0100, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/gpio/pca9554.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 1362b605c2..ed304e4639 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -290,18 +290,18 @@ static void pca9554_reset(DeviceState *dev)
>      s->len = 0;
>  }
>  
> -static void pca9554_initfn(Object *obj)
> +static void pca9554_pin_init(PCA9554Class *pc)
>  {
> -    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(obj);
>      int pin;
>  
>      for (pin = 0; pin < pc->pin_count; pin++) {
>          char *name;
>  
>          name = g_strdup_printf("pin%d", pin);
> -        object_property_add(obj, name, "str", &str_type_info,
> -                            pca9554_get_pin, pca9554_set_pin,
> -                            NULL, NULL);
> +        object_class_property_add(OBJECT_CLASS(pc), name,
> +                                  "str", &str_type_info,
> +                                  pca9554_get_pin, pca9554_set_pin,
> +                                  NULL, NULL);
>          g_free(name);
>      }
>  }
> @@ -352,6 +352,7 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
>      PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>  
>      pc->pin_count = PCA9554_PIN_COUNT;
> +    pca9554_pin_init(pc);
>  }
>  
>  static void pca9536_class_init(ObjectClass *klass, const void *data)
> @@ -359,13 +360,13 @@ static void pca9536_class_init(ObjectClass *klass, const void *data)
>      PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>  
>      pc->pin_count = PCA9536_PIN_COUNT;
> +    pca9554_pin_init(pc);
>  }
>  
>  static const TypeInfo pca9554_types[] = {
>      {
>          .name          = TYPE_PCA9554_BASE,
>          .parent        = TYPE_I2C_SLAVE,
> -        .instance_init = pca9554_initfn,
>          .instance_size = sizeof(PCA9554State),
>          .class_init    = pca9554_base_class_init,
>          .class_size    = sizeof(PCA9554Class),
> @@ -378,7 +379,7 @@ static const TypeInfo pca9554_types[] = {
>      },
>      {
>          .name          = TYPE_PCA9536,
> -        .parent        = TYPE_PCA9554,
> +        .parent        = TYPE_PCA9554_BASE,
>          .class_init    = pca9536_class_init,
>      }
>  };


