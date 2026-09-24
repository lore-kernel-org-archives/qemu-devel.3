Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89B9C98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9dk9-00051B-CD; Thu, 24 Sep 2026 03:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1x9dk4-0004yn-Vd; Thu, 24 Sep 2026 03:19:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1x9dk2-0007N9-TZ; Thu, 24 Sep 2026 03:19:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5bdlq160185; Thu, 24 Sep 2026 07:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eWrnfn
 BA3cvgRNuupmvbQtVShOJLjfkNRHCCSIiiWAI=; b=Dnh15j+Xf8XbDNEq1KyQ0T
 yeU5QaxJ4AooCvQC6GJIywWFQ4l0ZB/K+1f183YRoEKq9WYI03oebhrOgmew0IFJ
 FINeGzKWLBxwz9+KWTJmC1n6GXwzS124xUiEvuHWpiOmeIHvGYwj0ZQKaJBAFkgp
 4bAHgQ/Gl7CDgGZvQt0eeLgyv6VEjG+Frd/eHq0NoselOB8ctknR5C104r37YQph
 qaIlkrSMQBWtd/gM9SG0l0BFCd7q3+Bh6NoBd6IUWevMzP7kfuS6v/x/Q8sNlHka
 DE4+L+DyG/PRaAVB1vtw2oyv9OwAUF+KxU43jvAv4hdwYtajPM0NyN4uqeeILZCg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqpv3b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:19:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5lZNx1554292; Thu, 24 Sep 2026 07:19:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qmkq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:19:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O7JTtH49742290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 07:19:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 068032004B;
 Thu, 24 Sep 2026 07:19:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F45A20040;
 Thu, 24 Sep 2026 07:19:28 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 07:19:28 +0000 (GMT)
Message-ID: <17016443-d6e4-4b64-9f6e-52f1413bc099@de.ibm.com>
Date: Thu, 24 Sep 2026 09:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Expose pv attribute in QOM
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, brueckner@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, david@kernel.org, iii@linux.ibm.com,
 richard.henderson@linaro.org
References: <20260923083406.64128-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260923083406.64128-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab4cf05 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=3jP9IABV8YOPueX366AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfX0NgROdZlIhGG
 o4nqWzSo8lbdyQPeqbdcicmG67gBtMfICQdebfMwjLB5CnceMm3lvxsfdrdaTkC9wJ6/yUIZ4KE
 KWElRyGIrMZWmgd8s3eCpFfxxsGCZgXb7S14C/CElo5MsBjwHaCGpfYlMzaVoKWEnCtdyb0gkji
 ZogSjBqbgnF6upQQYNKvbNpFZ6L3HBLaAU5XjpXE/4xOS/EGvBEW5RsP1Lb/vNA14dyYiuiBi56
 BKvkTJB4BWFFAs2EIwLmodFy42Z5IVAZ7qdXW5Jt/CJCEj6ZVZhJreyWODEyIF/v1qNaoTHkDTi
 U6WmXQdhnBIbxsn0w+3iO20Dw8ijUUssZYtW/j5ivmxUbqz6aLKoC/Kd0zckgSaTm1M3uSofXLT
 VNw9HCrvGBdNrbPyduVbJP/u/akx/0AvmAIs+wHYFu2EWCje+VczKU1a4edQUtU/ucmA/GNq2iE
 y9y1CsFVLxrHCi+GHBg==
X-Proofpoint-ORIG-GUID: wODia5ChAIY1_x5_KKImFI9M3GA2IVWb
X-Proofpoint-GUID: wODia5ChAIY1_x5_KKImFI9M3GA2IVWb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfX6hbfwDSPKYr9
 c5SHpl8JnTkyzJye7JvO9xjst2K2dzS7V/tSzC1xS6dzaVKWzvz8/uBfKSvSSU6gQkhccYB4miZ
 HNrGo5k5o0p5wSIh9KOJhgQnI5BOdVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240030
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@de.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 23.09.26 um 10:33 schrieb Janosch Frank:
> People doing VM management requested a way to query if a VM is in PV
> or not. This of course does never replace attestation, it's merely
> QEMU's view of the situation.


Maybe make it more obvious that this is really about the runtime property
(has the guest switched into secure and yet yet switched back via reboot).

Same for set_description, maybe something like "true while the guest runs
in protected virtualization mode (read-only)", plus one line in
docs/system/s390x/protvirt.rst. The docs line matters because read-only
properties don't appear in -M s390-ccw-virtio,help


In any case
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> CC: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7fb78d8fa1..42ecfa59f3 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -838,6 +838,13 @@ static inline void machine_set_secure_boot(Object *obj, bool value,
>       ms->secure_boot = value;
>   }
>   
> +static inline bool machine_get_pv(Object *obj, Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +
> +    return ms->pv;
> +}
> +
>    /*
>     * S390x-specific global compatibility properties.
>     *
> @@ -919,6 +926,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>                                      machine_set_secure_boot);
>       object_class_property_set_description(oc, "secure-boot",
>               "enable/disable secure boot");
> +
> +    object_class_property_add_bool(oc, "pv",
> +                                   machine_get_pv,
> +                                   NULL);
> +    object_class_property_set_description(oc, "pv",
> +            "protected virtualization state (read-only)");
>   }
>   
>   static inline void s390_machine_initfn(Object *obj)


