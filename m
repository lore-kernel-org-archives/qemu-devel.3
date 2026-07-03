Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E24C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcqf-0004Ep-OR; Fri, 03 Jul 2026 08:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfcqb-0004EI-S6; Fri, 03 Jul 2026 08:18:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfcqY-0003WM-Ne; Fri, 03 Jul 2026 08:18:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636JFf01762649; Fri, 3 Jul 2026 12:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=judqb5
 Dv8h2rRURnjZiTaUuSLE2JmwTNnvgRpM+1qcE=; b=F8vt5R6AIe8nhGS+z/YqGx
 66ktKGeqk8tuJ3DgFXZhj9HOV8R1xVjk/sGnh4iwf12mh4oJXk8HWbyU/z8IiYHi
 U7q3OnatoH2J5w/+4yPK5tD5R0jQ5nJC4KmpfofwaBhnHYolxbkqSz6Pwh1XY4TG
 0iRN+XdVLEJRgwU0d01B6Sq6nBWUZIIjb+58ibAn6vT0RZaV+3yvFxBip9sfckrl
 U9TnW+paWeMbBKf/lfq0TQ02F5UAGGpRmR2lFwrdldf/sRYZwG9NweF2XVsXiFXa
 x63CsjxgsVwIia0zIxawL8gr4VsQJ+macDtmqUnq22oqwFXBLP0IoVbMYB6lHX3g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk6q2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 12:18:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663C4gY4017906;
 Fri, 3 Jul 2026 12:18:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukgrw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 12:18:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663CIDpd19923572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 12:18:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ACB558065;
 Fri,  3 Jul 2026 12:18:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00F8558059;
 Fri,  3 Jul 2026 12:18:11 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.9.239]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 12:18:10 +0000 (GMT)
Message-ID: <05e7789035f36a99cb01091993fb98b96d723d58.camel@linux.ibm.com>
Subject: Re: [PATCH v13 26/33] pc-bios/s390-ccw: Add additional security
 checks for secure boot
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
In-Reply-To: <20260703022933.1805010-27-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-27-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Fri, 03 Jul 2026 08:17:23 -0400
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyMCBTYWx0ZWRfX54q1vILnKETV
 igVw0eE2mjSUqqjpZOgDGMyXlawK3MIPkDgotZQ4xTp6VWAHE1U9W2B4JJF1yWViql/t5GPjFW7
 F3JvV/Tmo3WeZqp8EL0VYTnP5yRGlMPukCH/jNeKnSD6qela9td9DmCnGQhOjoya9V9fiY73azz
 nIpF9Rdh7MOigo5iEhGM4kqiP0ZfXVth16zCXur5QetEMVgXy0iFrN/zcPz1kOMYHc8wJ4o3d6j
 ru2/aMO/Y//O2OB+vR3tTot3e7P0uE7h8zFXFbcLCKactJMAaxa7Fqu1BZ8fy0hAH58wQ33Yoqq
 OpAsqtCiPTVrqsyT6zxcZFD+kY0hdhie+Xk+GPMkskKmltn6XSXJNPhR1Tg6FMq6gL9xV+EPRbD
 4LWo9VChj2hZ4Nbsl+sl1YV4tU/n3USmJX4+mIks5H5XMyIkUfuHyNE+T21vcNGynA2O/u5+A88
 PFnYOvY4o4xIA8rzCCA==
X-Proofpoint-GUID: MVhbZloDOwVmKGd1WRJzSBrjnfoe7hXi
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a47a886 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=XMBjRswBOKp5J3ctqEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyMCBTYWx0ZWRfX4naXse1tpehD
 yupRZi4mVxQyILRII+HUngiqEVwMwG010E7RCvO5gZ4T0ZlrXDFxK06qcxwKXWDX/GAXG7fikpv
 1S7vW73Jl60MVZdYSI2RCMp8lKm5+DY=
X-Proofpoint-ORIG-GUID: MVhbZloDOwVmKGd1WRJzSBrjnfoe7hXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2026-07-02 at 22:29 -0400, Zhuoying Cai wrote:
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
>=20
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
>=20
> When the secure IPL code loading attributes facility (SCLAF) is installed=
,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
>=20
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
>=20
> When SCLAF is installed, its content must be evaluated during secure IPL.
>=20
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
>=20
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/qipl.h   |  29 +++++-
>  pc-bios/s390-ccw/sclp.h       |   1 +
>  pc-bios/s390-ccw/secure-ipl.c | 179 +++++++++++++++++++++++++++++++++-
>  pc-bios/s390-ccw/secure-ipl.h |  51 ++++++++++
>  4 files changed, 255 insertions(+), 5 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

