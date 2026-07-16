Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEEDC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLgG-0000By-EG; Thu, 16 Jul 2026 08:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLgC-0000B3-5i; Thu, 16 Jul 2026 08:59:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLgA-0001mj-Lg; Thu, 16 Jul 2026 08:59:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GABoEX1019574; Thu, 16 Jul 2026 12:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=gt0rcvZr39bcuHIMabiqMvA2qbPdwSaKT2SUKVhHcJk=; b=HmPe1emHyal7
 4RIBOjRRkhG2wxXAqL6g+S57pRzloY8zPNi0LMe0ubQ/Aq7qinhsLbfTdAFdAekr
 +xGzkV80bEWoXEegJTefRNEMQs64W1pjHi7kGfucOK701VAhwctzJRXxc0AZUAKv
 fm0zKQJve2jZBcXZSt2iIjyjn+1bdJDmggvVCozN/fmblHRDcsYyN0ue+ss0fkia
 ETHOFq1IhDLe0QKznvaS1uMh5D5C/SBZrRz1FALwGY/d1+OQC0S3TQF8KYhoQQYe
 9d2T2TTg5BbBtfCS+2xkwHXLL/Eu2IJ2VINOvKat3cMBVIIkfMG6Pxo9Ju8VFvgJ
 wAGKx98S/w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33he54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:58:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GCnag6022918;
 Thu, 16 Jul 2026 12:58:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgmu9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:58:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GCwdso64880926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 12:58:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC05B5805C;
 Thu, 16 Jul 2026 12:58:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9F2D5805A;
 Thu, 16 Jul 2026 12:58:38 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 12:58:38 +0000 (GMT)
Message-ID: <09b0278c2ad58545ba90b086ead579ecd7ef96ba.camel@linux.ibm.com>
Subject: Re: [PATCH 03/29] hw/gpio: pca9552: rename I2CSlave member to
 parent_obj
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
Date: Thu, 16 Jul 2026 07:58:38 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-3-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-3-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX2bUd/1vEcNRT
 uzWRgEG5HSwUYBmLqMI3uk+QE2UVS61Ciq40Rg9ZSaDOMKoAIujRd9tTe2Vvw4fUyywK27A8bUS
 HPUezbrZ76acyAZN4Xq+o0eo6/cfGdk=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a58d582 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BjX4JLUsjlLduDaIeOIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qHNNLTvKH2V5xjLf5Nu1hVaREqcICgae
X-Proofpoint-ORIG-GUID: UWt-2pCZOj1AYkK0DC7I-qOrrqA3TWuH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX6geMPl2/drC9
 zgfHiRM2YuHFYmXzJC588c4d+25hY2My9LBJRBlsZmWxU8BGN8O+fnZQkZc3LIqSVU9ch30x65B
 GCrop7NNDrGYJjCw1de+zkbEHSILZ/8tv0KmzrnuZO/hZ7jEy3Wsq9xUWB1cQCs7VdGq4AIyWJ0
 deISMjxwGiif08YfSWNnMPVjdFanOKBQlStTcaJV2YuOe37IaWLR74X91F8xFE+EAA4d8Rac+6Z
 7pNw18cfLL+534BFWBns39yV7H0KyFElPWNSpGBQ8nfdJAYRN3LdwKdiGmBXZ9UuI0U0UIl4VjM
 u/Z2GQTQa4VsG06MUdch5wApA1FWuwc/NOMUhHcVODzjmOWb02+7noxF84OAjp7Oy55Db38TmOo
 m+36twQ40KqwmpSCIKIe2Eb97kT4HbMIDqwuFkWEhG9Qek+HuZhrXsQin6GdSoQ/kSEVJ7JaBMe
 UznIO79PvhiUE08EXGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-07-09 at 17:23 +0200, Emmanuel Blot wrote:
> Use the conventional parent_obj name for the embedded I2CSlave instance.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 36bc4f86ed..da21e56aab 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -34,7 +34,7 @@ OBJECT_DECLARE_TYPE(PCA955xState, PCA955xClass, PCA955X)
>  
>  struct PCA955xState {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CSlave parent_obj;
>      /*< public >*/
>  
>      uint8_t len;
> @@ -401,7 +401,7 @@ static const VMStateDescription pca9552_vmstate = {
>          VMSTATE_UINT8(pointer, PCA955xState),
>          VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
>          VMSTATE_UINT8_ARRAY(ext_state, PCA955xState, PCA955X_PIN_COUNT_MAX),
> -        VMSTATE_I2C_SLAVE(i2c, PCA955xState),
> +        VMSTATE_I2C_SLAVE(parent_obj, PCA955xState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> 


