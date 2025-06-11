Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CD2C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHSe-0002LH-AT; Wed, 11 Jun 2025 05:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uPHSZ-0002KV-Tl; Wed, 11 Jun 2025 05:09:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uPHSX-0007YE-EJ; Wed, 11 Jun 2025 05:09:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AKFMNV010843;
 Wed, 11 Jun 2025 09:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5UiqMo
 RrrWYJNmVLv01tNDC42vgiOVCZwKhR6GajRrY=; b=JTTcezTlpRAtuwVQXfw6rf
 b+K4cyzgcSrhMQZaLu7YsG6Pgwngta1UDEy/sfb5U75jZFMiy/qXeISzITyLUyEA
 +DPLWKdekW9cH9T0J1aSUz6YLv3hygnlg3hliZ4PzCVaIViDvFyUCtadT0fd3/Na
 Pn3aBmldID8eF/D3U1ZdrUOrTEzDX/1SdhEeig4bA3RDMc+Z57ZKT8wtywbxN4vn
 AfyUgAnK4wuWlcpGlcOe5fpypIadTI6RZxAh6ktFFnDReyLqIY/AqSapCKH5/8XO
 bSZVvs9C4ljJZN1dcG97MbUYIaqa6ix99EH/Rh9gsHzWP+7Bq4eSrUXqY1b3RLwQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgujkur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 09:09:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B6dMPf019565;
 Wed, 11 Jun 2025 09:09:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f2ekqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 09:09:17 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55B99GDY24838570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 09:09:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE55558053;
 Wed, 11 Jun 2025 09:09:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC3685805F;
 Wed, 11 Jun 2025 09:09:13 +0000 (GMT)
Received: from [9.39.28.10] (unknown [9.39.28.10])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Jun 2025 09:09:13 +0000 (GMT)
Message-ID: <86776769-2a7a-4294-94a9-0556b2134afd@linux.ibm.com>
Date: Wed, 11 Jun 2025 14:39:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/31] hw/ppc/pnv_occ: skip automatic zero-init of large
 struct
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
 <20250610123709.835102-25-berrange@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250610123709.835102-25-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=684947be cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=f7IdgyKtn90A:10 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=yBPMMN9q8ypsF3GSx8wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WMNgCahv88rqYApPUIT87_guPOSn00DD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3NiBTYWx0ZWRfX0gD4oh/Vkx62
 JP1WROr2vBAUVa0ZxEgZGz/M20H0VmGouLpHDmuMx1/1NGjl7w4pOyejMnOuBdEO08WXdlQh7zj
 cHpwwH+P7Umavu5ubOyRk1t5JdHaCYnKxmyknZnVGufw+VGx2LpVAOpQpYOEKml3Dp6LdTgfhMT
 gDqSKpdDHJM23BdR9GN2vksU+6izYOWP/vLXipFW8D26wBNJOb1/VJZjGjAfv/ek8QTVZmKed/q
 dnMpYYFcxNd4VPuMgQPV8XJn0Fa9NBHqRRFpvUOl+KzMg32W0QqAWXKGHcZJx4s1tIYtsemZGio
 CJzonyOaUeVdhb4VZ3EU7gas8/KhFrkI2CK2LdbUg8/2YFg8w2tmZoEqTbfoWenrpKezOF0N/Fu
 YU5Ty5DABDmM/14eq+Aw1YMfA/Dx9gA+Vct+CD76RK/pIP6y7H17MALHgFw2P2M5X/WZdhgI
X-Proofpoint-ORIG-GUID: WMNgCahv88rqYApPUIT87_guPOSn00DD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=821
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/10/25 18:07, Daniel P. Berrangé wrote:
> The 'occ_model_tick' method has a 12k struct used for copying
> data between guest and host. Skip the automatic zero-init of this
> struct to eliminate the performance overhead in the I/O hot path.
> 
> The 'dynamic_data' buffer will be fully initialized when reading
> data from the guest.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/ppc/pnv_occ.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index fa6f31cb8d..24b789c191 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -789,7 +789,7 @@ static bool occ_opal_process_command(PnvOCC *occ,
>   
>   static bool occ_model_tick(PnvOCC *occ)
>   {
> -    struct occ_dynamic_data dynamic_data;
> +    QEMU_UNINITIALIZED struct occ_dynamic_data dynamic_data;

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   
>       if (!occ_read_dynamic_data(occ, &dynamic_data, NULL)) {
>           /* Can't move OCC state field to safe because we can't map it! */

