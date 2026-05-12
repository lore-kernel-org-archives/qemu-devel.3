Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138ECCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqG7-00026a-V5; Tue, 12 May 2026 12:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wMqG5-00025i-4L; Tue, 12 May 2026 12:47:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wMqG3-0004C1-2r; Tue, 12 May 2026 12:47:00 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CCPobk2759967; Tue, 12 May 2026 16:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HYbyiX
 S78SVYje+MFOdfqHXBxAqUB02pKAN5xsQxMS8=; b=JMb0OYSKGI2L4umGwYlZdA
 zKBsclKaxo2224897Kbi7OgHszQb1+migrMVfD6y83S75ehl3QIxrPWsoB0fceuS
 hd3usXR20YzIuZny3t/9wnQ6GwZsWUEQbyNuTxSG9OX9ndMk6SLY1PH+JfxcXKJl
 yHWaoaIS5V8aeBEH4wDP02Xjvwh3QLp9mJavF+qbABCOQ00IjwxxbkoEp0XV0RMF
 rNtgFsvvp1yLJTy5HXdx23zoi/AjUkIBwvk8Zmq/GOxIJtGL4nyT6CC9G73nu576
 9wC0mNeJ3PgzHnwimf8yR00p9QrnqD54PbgFPK7ZKNr3IgVJH1Nwm4evaPHR1VOg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6kw2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 16:46:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CGdkLm030247;
 Tue, 12 May 2026 16:46:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgm00f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 16:46:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64CGkrqJ28836504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 16:46:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 158BB58052;
 Tue, 12 May 2026 16:46:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A2A758056;
 Tue, 12 May 2026 16:46:52 +0000 (GMT)
Received: from [9.61.251.114] (unknown [9.61.251.114])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 16:46:52 +0000 (GMT)
Message-ID: <ba454c98-82b0-4a95-8547-5c06c3736f8e@linux.ibm.com>
Date: Tue, 12 May 2026 09:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: restore cpu_models for system builds
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zbWfG-HwkbaIYcXbyrMIO5WORMxTaXr3
X-Proofpoint-GUID: zbWfG-HwkbaIYcXbyrMIO5WORMxTaXr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3MyBTYWx0ZWRfX/S8SFeL9q/4L
 8m0R0d9dd1/U9wmEqG8wu30x31G72EYGakFF5ui9Jr2oslJv1H3VXNSoytIn8oqHcuG6NMybSQh
 wqxvzJIBUQlmTU5pcs35WtoIUE4pYavdk/csOkbA1r8tKg8dR+8m2LCg2ji8P3XnSVZGdxOW8Yx
 ssQiTk1Z1AgN5S3YOCNNUMeNwVYmAkFHqwvUrVk7Qrru6l1mGKjjrMTqyBnvvFhjv2JPRVeXTLX
 ACGxgA8ya/CZnPbgIc9ecRq89CrTqzgTp7vwrfSdy8bTVbO5YtMQ/YTs+xVXC8ZbJehN5AHw8D1
 bjDHdoCtFmr26YE5ii6m93PZmhW2XUT7EGmkom8vaKvEeuh5psj64TthpJjJmU3f25qZGET2RP/
 5u9S9P7Lz9aItXvgO/40TBmsKbnSCgE0HExIzhxjxBoISNoiyStUSWfL63IZVhZX9BITtPJM9yA
 Tw3X7raAo/rqQd5R4kg==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a03597f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=EFTX0l31UZ4cIo77J4UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120173
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/11/2026 9:35 AM, Eric Farman wrote:
> Commit 0b83acf2f05 stated:
>
>      Introduce a source set common to system / user. Start it
>      with the files built in both sets: 'cpu_models_user.c'
>      and 'gdbstub.c' No logical change intended.
>
> Except that's not true:
>
>      git show 0b83acf2f0 | grep cpu_models
>          with the files built in both sets: 'cpu_models_user.c'
>      +  'cpu_models_user.c',
>      -  'cpu_models_system.c',
>      -  'cpu_models_user.c',
>
> Restore the s390x_user_ss section, move "cpu_models_user.c" back
> into it, and re-add "cpu_models_system.c" to the common_system
> section.
>
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   target/s390x/meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
> index 44f58ac291..6adc2b896d 100644
> --- a/target/s390x/meson.build
> +++ b/target/s390x/meson.build
> @@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-features.h',
>   
>   s390x_common_ss.add(gen_features_h)
>   s390x_common_ss.add(files(
> -  'cpu_models_user.c',
>     'gdbstub.c',
>   ))
>   
> @@ -38,6 +37,11 @@ s390x_common_system_ss.add(files(
>     'mmu_helper.c',
>     'sigp.c',
>     'cpu-system.c',
> +  'cpu_models_system.c',
> +))
> +
> +s390x_user_ss.add(files(
> +  'cpu_models_user.c',
>   ))
>   
>   subdir('tcg')

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



