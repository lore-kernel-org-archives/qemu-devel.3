Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9710C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLhY-0000su-GW; Thu, 16 Jul 2026 09:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLhJ-0000qs-OU; Thu, 16 Jul 2026 09:00:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLhI-0001t3-4m; Thu, 16 Jul 2026 09:00:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GACRLu2911452; Thu, 16 Jul 2026 12:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=JJaqmbvIAvY71cjE5wRnG6cnXupQuw/Ilcdqh5GO/gE=; b=kDCVdGj5V4oJ
 tJuS8PsdKSpgp/T5mpO9Txd2kCvUiSsbhlzXIOSx5NtihBIDcA3rbwFdx2oXX3WU
 0qZUK/5FGJcXf9U5JqXQbH+QRC6yZxgBGy0j80KbHcRKRX62Q9+cQquZHxi4PPcO
 s7xt34WogYBk7pQh3HnCd9IDEa77d3Mynmwj095nN1Ieh9fhdpkt+tV+aPONYH6n
 Eq/YmgBS5GLbaZfy9+FWcTagI5O4rPiEGiPcL/ja4XVEe8ZIaynFe+WM9m5z9SGx
 mnvaNO+MTx1wWB1qGrY9zpNELRLHFNqH/6Boa313pRJl6C62yFnZ55+pOpciw5LC
 X3Hvry1GzA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxrw8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:59:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GCnfIM022956;
 Thu, 16 Jul 2026 12:59:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgmucj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:59:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GCxuF927591230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 12:59:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B4D45805A;
 Thu, 16 Jul 2026 12:59:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A148E58051;
 Thu, 16 Jul 2026 12:59:55 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 12:59:55 +0000 (GMT)
Message-ID: <7330879b3b90bb70363520190de2445ba2426f16.camel@linux.ibm.com>
Subject: Re: [PATCH 04/29] hw/gpio: pca9552: default description to the
 instantiated type name
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
Date: Thu, 16 Jul 2026 07:59:55 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-4-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-4-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jltnoybh4oQ3mVfgdNzIQGSMn3pOhtcr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX5oIuf4iw8Pjy
 RkYT/GCQ7RSiR+RAdO5YxGJNO4hGiDSgsyi2omX1XsC50bKGXKfcV5al6t4pNUNFgJ8xNy0mLFv
 gPrZrGNFuC4PSCW3eLZXZAhnaoXZ9kk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfXztGSc+FkroBv
 /DgWo3J5i+QvAlzylNTxdcvs05pgiwyBHdzI2kdwa/iA3WCY/qv6QM+9UtPV+baeYb3zADQsMeF
 jaU3KMOYzFU0/uALaawuDRWSNGdXlcpEM/i9vfQZOOku0YOimZl0V/eIPc3ALPlplKdjJptlp3w
 rFIwNhipBTVCyYBoSclzRafjqli0gR2vfEro1Xm+VXU+jTcBcNzteyAUnytnwpPSFYsSypdNozp
 PqxCD8ZTKiUJhx6BosgAOcqdfHFmCAQr3zIHaR4FgzVppXsDvVOFADDODU617XfJKgJVHm7v3nQ
 NHsiEeF8i7zB4CV2a3XG8aOP1rfn70+mmuoERYV88LNFcCQ+JqCcuJINMCWqic8sIk/elsds8wx
 wNvoIgfi44/hp+kdfZunk+Ynh1pTVAafA//T1q6wOxKXPHh+Cw3H1O0ra0PJhLpuqcu0OSSBaJZ
 Dg2uJzZGhAx76Cp+Ung==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58d5ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Rbrhkx265bOAGaGp-ooA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uLoZdhjolpR6v771Dc9_5gdndpqSy2AX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-07-09 at 17:23 +0200, Emmanuel Blot wrote:
> When no description is supplied, fall back to the actual QOM type name
> (pca9552 / pca9535 / pca9555) via object_get_typename() instead of the
> opaque "pca-unspecified" placeholder, matching the PCA9554 model and
> giving meaningful device labels in traces.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index da21e56aab..ffeb438d2a 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -488,7 +488,7 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
>      PCA955xState *s = PCA955X(dev);
>  
>      if (!s->description) {
> -        s->description = g_strdup("pca-unspecified");
> +        s->description = g_strdup(object_get_typename(OBJECT(dev)));
>      }
>  
>      qdev_init_gpio_out(dev, s->gpio_out, k->pin_count);
> 


