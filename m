Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RGfeoDhE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKH1z-0002ye-80; Fri, 23 Oct 2026 11:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1xKH1w-0002yM-SF; Fri, 23 Oct 2026 11:18:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1xKH1u-00048v-P5; Fri, 23 Oct 2026 11:18:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NEEADg1516955; Fri, 23 Oct 2026 15:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bXqi2d
 rK7tIi1kwUw6JcZ2RznlEWiGvkGE6+ctR4vIg=; b=RGfeoDhEBhilGeqb0uE0BN
 xyBcIdMeAFjEWeuTNJmu2c82Vh9JhyRKlXH1xaBTguZUmL8wUE6ABiE6nEwgUdIr
 yKT/GOhIP6/MUPi1c0BmGhH18FPsr0fRh7Wn+6KB7HhILytJYu5SP7D0uFYdlKDy
 dXO4P7O67eY6BrRP5QZzWb3EVsH36zE1l+JW8Ztqg5oAUAVqY5GzCz88Xk0Wi+eo
 EoqwPbNMRJMnlvvWBHVoMCXQoWHN3iBbfztbR6vEfTgsAnzVWL9ZqIEPH9MoqBnv
 JM8AO21fYqt1GTjTVB4t6PVPmC9hMO955M5Bb6suYBcQti8WBdwMixwLgVSTHdkg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bx359-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:17:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6A2r2260541; Fri, 23 Oct 2026 15:17:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn54a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:17:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NFHuBr17564224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 15:17:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DAFB5805D;
 Fri, 23 Oct 2026 15:17:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75DE558052;
 Fri, 23 Oct 2026 15:17:55 +0000 (GMT)
Received: from [9.61.249.190] (unknown [9.61.249.190])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2026 15:17:55 +0000 (GMT)
Message-ID: <47294e9a-0e3f-48b9-9a4f-b6a41b343d22@linux.ibm.com>
Date: Fri, 23 Oct 2026 11:17:54 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Update s390 boot reviewer
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>
References: <20261023151229.1196404-1-farman@linux.ibm.com>
 <20261023151229.1196404-3-farman@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20261023151229.1196404-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5RKEeQ2sE7mPJCuWqFH3UkCw-8CihuMQ
X-Proofpoint-ORIG-GUID: 5RKEeQ2sE7mPJCuWqFH3UkCw-8CihuMQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXyzHoQ5kPfHxS
 z4Ap/ArzOSDabBT2KQofWVTYsR4cl/ljgSI2JDvQbzvtGBVO8V0Pna71PxxxBmU4Zf9wp+do+6v
 TkPkTvkOj0BtCo/QHcety2VM1wE/BQ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXyMF1PBZa1Oj/
 ESW6BkXd2elo8fwaPqs/OW3ApF3GRQLlY/CQDpaXRy0qqLrXv/3mb8/A1LfcTPxUsVVg5CM+QlY
 iZlGpsqod/ED2KekjZWZKfRMFlY4PLZXdQcsx7jYroifqBTM1+eS78nfkliTE0d/qSeChB93Zjv
 CxgwF4V5qXLvO/ywMdqxJxmTf2DKWoaL6mshJUR2Nfh6rZIDCb98PgGysP5fIDTPYddabP3H+/d
 anmTYjPw5TpAr5aAkGr3qgzqFznZJyFxj7SHxpE8BZV6btmGadXtnUxvhiLVSXIqwR/POqAmbRH
 rnRu6hzA38rHAIUergzJOXe1saqBoVgQGRoLbtYklAYsMaLFji9ThFD74RveQalnJAww8/zyIAS
 v51zsuy35S7blLVMvLhraQFfZ2b4Bdz9AsFwrtwwiQch2cjnKOmXj6Xk2RMmv9MXY2qFPmdETOw
 ow2E5MyoCke1Q3PUoCg==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb7aa6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=F0Ws6z8yqILDv8xPEwYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 11:12 AM, Eric Farman wrote:
> Josh picked up some recent fixes in this area, and offered to help
> with reviews as well. Let's free up some of Jason's plate.
> 
> Thank you, both!
> 
> Cc: Jared Rossi <jrossi@linux.ibm.com>
> Cc: Jason Herne <jjherne@linux.ibm.com>
> Cc: Joshua Daley <jdaley@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ee1800707d..f35dfd06c22 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1987,7 +1987,7 @@ S390-ccw boot
>   M: Jared Rossi <jrossi@linux.ibm.com>
>   R: Zhuoying Cai <zycai@linux.ibm.com>
>   R: Christian Borntraeger <borntraeger@linux.ibm.com>
> -R: Jason Herne <jjherne@linux.ibm.com>
> +R: Joshua Daley <jdaley@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/ipl.*
>   F: hw/s390x/cert-store.[ch]

Acked-by: Joshua Daley <jdaley@linux.ibm.com>

