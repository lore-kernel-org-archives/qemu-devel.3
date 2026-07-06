Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D4C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnSD-0003c6-AS; Mon, 06 Jul 2026 13:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wgnS3-0003Nx-WF; Mon, 06 Jul 2026 13:49:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wgnS2-00079b-M3; Mon, 06 Jul 2026 13:49:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIdij756400; Mon, 6 Jul 2026 17:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gESnZ2
 2q5y2MQlGZlTSGD8MImV0GzzgOK6BvaWQrluU=; b=NxIZ3YQAUmx2yVA1fAJOod
 tonV0clhMvpbUCMqxFCk0XWRzI80SdI0R0uTlCklYEEXS5xV92D+NH5pQoeJs6je
 eu99DsNUVXzdbcuUdM5JfzjfTt/8u0yQ7fY4tMFq/BbSAUizkoEWRUXMAKWHz91P
 THVZpuOiffan7+gg4IagWTk0rYhoLbCdL6j0f2d2Y82ckHVsUF9f9VoWyaiNUKQZ
 AMel5Wl5zjf14pNu/Mg9+CnWGKpofTbzWOOzRIaIAkJltG3zsvDhJIt1cXNqDvk/
 DMPdrXqeoMxmK4ML7GQ/ZomR9o3+DHb0ztCMC2DCXWaswLyxHTPow1xZTk9O0QkA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknaspt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 17:49:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666HnhNQ001055;
 Mon, 6 Jul 2026 17:49:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xx9vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 17:49:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666HnAEg47579550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 17:49:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16BF55804E;
 Mon,  6 Jul 2026 17:49:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F24DC5803F;
 Mon,  6 Jul 2026 17:49:42 +0000 (GMT)
Received: from [9.61.71.99] (unknown [9.61.71.99])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 17:49:42 +0000 (GMT)
Message-ID: <987a1fcc-7b0a-436f-82d2-7dfcd7bd98b4@linux.ibm.com>
Date: Mon, 6 Jul 2026 13:49:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x/css: limit number of CHPIDs in description
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-6-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260706091909.864405-6-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4beaba cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=s4EiWy4W94h2rYG5w-gA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: cAMscXqUTooFz38cOTia8O8NbgXGLfaT
X-Proofpoint-ORIG-GUID: cAMscXqUTooFz38cOTia8O8NbgXGLfaT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4MCBTYWx0ZWRfXwBQba+4But6P
 yM8KAJv+tiD4Ter5fpgFEcx/GcVhSZhVBq1zdXsTCJG1/1QjuNjrg/D1Aic2Nnn0pUqyhiSHFMU
 ixWk7Tndr8FxctOxPQ3wt6ejE1zDiI8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4MCBTYWx0ZWRfX2XipnuhSbWhx
 rWg918mXlUwv3Pvx626C3JREi9qcGdmtWX+Zln8zAZFhma55zXwJCH0zm5KUK0vhRLXBeTiYL1f
 TWlH2vfOqYk4/B0orRdEPIfTD6jzcU0fR0X4655xtKb+1f2dyv/G/2pWArEgCoU/fHhejWqpNic
 8Rgzn0HNBsjuJYnqPD/yA3lV+d8Go0LLRY3gX5jrxXhn78NQ/jWUfMJLPSKmcn7KwEth9izdbfL
 /OvU97X27JawXYTPqBa17oSpe0WGvpsFP5geNdcrG8+WFEDKUczJFAyaKxpnqxI2sUCUWEug2A2
 lZvpB9FHK5PT5ZqKFL8J3DKmCNhRgdolQNJVb2vvFEBxEmo5DpYRyI4u/Da3Twa0mBCXKp51Hq4
 S9WI0TVv2k0/M22OkZ+1QdPC2mgKdP+074gAZWCCJVq6IA4/MOboBlH0qZWYlCoqBKzF1LcBS07
 J4IhOTCfTZmPHWe9FyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060180
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/6/26 5:19 AM, Christian Borntraeger wrote:
> From: Eric Farman <farman@linux.ibm.com>
> 
> virtio-ccw uses a single virtual CHPID for all devices and
> device-types, but vfio-ccw (passthrough) shares real CHPID
> information with the guest. A sufficiently large passthrough
> configuration would exceed the defined response payload.
> 
> Fix this by limiting the number of CHPID descriptions that
> are returned based on the given response format.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


