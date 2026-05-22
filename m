Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22918CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWWn-0006IV-78; Fri, 22 May 2026 16:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWWA-0005kA-MN; Fri, 22 May 2026 16:30:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWW8-0006pD-6q; Fri, 22 May 2026 16:30:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MFm8wW1562366; Fri, 22 May 2026 20:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uq5RYW
 Nxq3ChBOFITqRX8e21W9Q8VYICHdjdVb0BEdA=; b=YFVCJOS6aRdU8j5Ez4GlIL
 k3Ua7UIqknyZaSMuKaSUkHq+NALJDTJgVMWM6kkwgqhmqFgc31PGuidAUMfZEHJh
 wMovW5b4Sic+6gcdUfKq8NWNxV6e5IYUWmaMSHI0NaYnqXW0mBBwaeONn6YPLHlv
 bigibrcl8Ox3G2qylnw5UPeIPyObcMQK/vzeOg7ZZ2vdpjOuWPm2QiaYuh4vi67B
 plwr8ea8NqijKhRHZIXVHO2vzcGJ/uutQO4mNs1L1THYM9BTC4JPEN9uzUolhORk
 ox4C7wkfyAyeHxiksbH9GX1L23a7n8udDRgW7cId5HarT6HylDocOhKMilfD1GZg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8v658-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:30:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MKO6pG031512;
 Fri, 22 May 2026 20:30:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkjj7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:30:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MKUhK963242500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 20:30:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B3DE5805D;
 Fri, 22 May 2026 20:30:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2946558059;
 Fri, 22 May 2026 20:30:41 +0000 (GMT)
Received: from [9.67.42.213] (unknown [9.67.42.213])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 20:30:41 +0000 (GMT)
Message-ID: <9e80bf66-268e-47b8-8678-c899ece52296@linux.ibm.com>
Date: Fri, 22 May 2026 16:30:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v11 20/32] pc-bios/s390-ccw: Introduce ZiplBootMode enum
 for IPL mode selection
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-21-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260505201905.997996-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMCBTYWx0ZWRfX/WdgKwVhxIIS
 Z2KJMYhsmipV7qN2hzwBZBUWhTSkDRrbIcQD3fI1Gfa6Mpi4FxCyGDlY2aE6Kitj/R/iDYdsujt
 ay2b00Q3vW7ZO9NPnDtzH3IXgXQlb/z3eZaGgIzpsF7iO+RY8KskFiWDRuA8/eXoewmNer/TmTG
 3m775nNSD6uQIjEVFCvQnOIrpgJ/IxwA7wDuoEw4/VIZR3CHf6vy52EVOa6kBcEi8Bl17lF8D1v
 b4s9OO7pBJjxz1nm1DbXo3n94G84QeUPkoalJzubKpXR8vCchR6kQx1hG9e4WgxU/4/og9TpA+F
 MUidWp3KtT385TrCa7GkXsvBWklvym5gp8cL/Ql48HYyWK+DI3+1CiWwj6NCpXjEhxhf7uC+3VN
 hwm1UEPorVTAreFTYrMm/bT/9cgudzs3q/wrRtvSORqHWb1lsYRgqsCPpJaDLl6huzRwvG56wmu
 JeaYQhcQ4SBPI3DfmHw==
X-Proofpoint-GUID: BxbCoKzdiyrWpvJExckOrGUE8bkTbxfU
X-Proofpoint-ORIG-GUID: BxbCoKzdiyrWpvJExckOrGUE8bkTbxfU
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a10bcf5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=IrZvC-waEUVJwRxjAe8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220200
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

