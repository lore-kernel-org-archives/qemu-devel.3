Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17509606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YEFI+GCe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKH3U-0003eX-As; Fri, 23 Oct 2026 11:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xKH3S-0003eJ-Nh; Fri, 23 Oct 2026 11:19:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xKH3Q-0004Hj-VI; Fri, 23 Oct 2026 11:19:38 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NEECBR1517002; Fri, 23 Oct 2026 15:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=W8XDUA
 4/H07y/L4nOMB/6tMYTy3NAx7pM32YfTi/HWs=; b=YEFI+GCe4g+wVeYJnNEEe+
 7CKEM860NBuGiqVxVPjLu/lDNV2dLSxMQCsdQXM0uM7CJgO2FYmwXNnPVPei5iWN
 q72HFbDBUhQ6Edxb2QNM6HeBfqev4jv6pkPO4Ni1szQlDAvjVmbAucsTgTqPS4kL
 y2wjM/WCZ0MLpAp1ddiqW89/ssOJOZIgHSBI6lSGbXNe/naHEZWelTGN9+vPM0K1
 HOPXTFp0DsB48HyAVH37S3pvlB5wDzrtJHi4iBs+STGXY2VEBlx/ntON5CGkEQN4
 4aQJIhNhuQSVp+GB30gIwwicTn7jXAR4tDH6fEIl/Vai+LUoqO3CdpWfHTJ4fyQA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bx3bj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:19:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE64m42260503; Fri, 23 Oct 2026 15:19:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn54ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:19:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NFJW7e33882860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 15:19:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96C2D58056;
 Fri, 23 Oct 2026 15:19:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1939658060;
 Fri, 23 Oct 2026 15:19:32 +0000 (GMT)
Received: from [9.61.33.242] (unknown [9.61.33.242])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 23 Oct 2026 15:19:32 +0000 (GMT)
Message-ID: <fef6a6d3-c84f-4e61-a469-f356f636a2dd@linux.ibm.com>
Date: Fri, 23 Oct 2026 11:19:31 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Update s390 boot reviewer
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>
References: <20261023151229.1196404-1-farman@linux.ibm.com>
 <20261023151229.1196404-3-farman@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20261023151229.1196404-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8Z3gk2aUHPnvoXxqZ48pxRKPnCpe-gsQ
X-Proofpoint-ORIG-GUID: 8Z3gk2aUHPnvoXxqZ48pxRKPnCpe-gsQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX5w6bQIuyPoIC
 gWkJXCfWPqkStPmrADyTuL6XgNfLjO/mViy4C4PC6BQh8ZzOHRA1IS8YUZH/xpf30GuaBpprOCg
 9sM298v7+CmpeVcOYVTJxIjwy9rnSNs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX4YZWpzrdEGqD
 TRIsJTjJU6ZCgGx598DayDO1uyjHGBvLbbM7apirULnnka9spA0drTLuYrf+lBiyygx46z89lg/
 5u/UvxbVdMxjBxC5fRWgcG0/uJ25l0iYAuhubPCRVploLCGm85wx4rYYVWoTNkMJQ07lwbtgXsl
 iZd1TdZbTT2f4IYswcffZFppF5adH585j5cSbEIdyS4BoefEVjE3pgRkNTlhkpMG0JceR0S/l81
 WHMuWiRIOR1+RqxITbi3hD7xrowJVm72VX6xK0XEGTrJyRkfLkEaGPoHoDvJWAJHupyRZ0vTAWS
 OOCgfTDJKvtL4/AYSGrJWA+DcwN+q9ADbN/ao1ZC4SV0Hci/UPpmDyTkJWIPsQhAInKLWBUb9jY
 wY2pIlVnBrm9gNECoFY9BOxn0/np0brunJaX8f3Guph15G3GvUameB8Uu1SOaGseCkcP2dVGGTo
 eiRpoQPZPlKIG6M7lgg==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb7b06 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=rfQs97xr2rpjeRT9aDUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 10/23/26 11:12 AM, Eric Farman wrote:
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
Acked-by: Jared Rossi <jrossi@linux.ibm.com>

