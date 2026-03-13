Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0447107BCDD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 22:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Ab5-0006bI-4D; Fri, 13 Mar 2026 18:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w1Ab1-0006ZB-6r; Fri, 13 Mar 2026 18:03:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w1Aay-0000B3-Nn; Fri, 13 Mar 2026 18:03:02 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DLYOKN3001809; Fri, 13 Mar 2026 22:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RRk1Ey
 j0uU7+Jdu8qhsPxp0yAp4BmXCKa/UctoytmBA=; b=S1b2uGwDvgm4r8264j4xqi
 xen67TAoxDm5n3j2me/XQz8EInYVvhfhsQPEL/WXqH6xQ6HKm/sSs79elPK7FTjv
 yYzbQuja54+efXXqR79ub6ZdnV8fZ2lGaCVzmbMnSwMzO7Elv+zmAeqkrFxk2E7q
 5X6+oLoVR8P6H9u6Y/gnXgHYVMsIkM8KX07qHl3bEkNrlC93HIUTiB/4N5Vkxd82
 rvig2U+XYeLAkXpkuUYWV5+xpGHwOhOSA1xtHZbdMTnqUcmzpK/IwH1ucHv6D7eE
 NC9gzd3X+a03zdBV5hlmIEgU3zvd/7GSXhZ+8cFLrFKNnWLSsoBVh3tQHGmmkrNw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96hk8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 22:02:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJeH0R006042;
 Fri, 13 Mar 2026 22:02:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9rf54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 22:02:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DM2ua91638918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 22:02:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 900A458052;
 Fri, 13 Mar 2026 22:02:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8EDF5805A;
 Fri, 13 Mar 2026 22:02:55 +0000 (GMT)
Received: from [9.61.92.76] (unknown [9.61.92.76])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 22:02:55 +0000 (GMT)
Message-ID: <21151ec6-088e-48bc-a11f-73405d273858@linux.ibm.com>
Date: Fri, 13 Mar 2026 18:02:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add another reviewer to s390x boot
To: Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20260313113424.15583-2-thuth@redhat.com>
 <20260313194810.1844241-1-farman@linux.ibm.com>
 <20260313194810.1844241-2-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260313194810.1844241-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE3NiBTYWx0ZWRfX/gaBeQ3xD6Zq
 hUKiyDEPGEK8Vv30Yq3uEjVqJ9b/PzDVQn19sptyUOkxoj6+UXGZhzwQv2IcCtBZ0eGFye7NRXa
 zaP91cB5ckf+hncivUnFdAmLZKsISuObuK0GiBzbot0jAYVDMgz48DNv5AT2QLVuOgASf/492nO
 bQK8gTyfNT9r9XzSBi5TpZrliQEQGr9MqRRYyH+MK1ne9j1eIOxJs1j9Jrdmxfegm4LXHqn3DRW
 fDVfAMUaosNRzPj/Dd8f9MO8vq0gCWwtRluJGJSn0DoSLWaHvQ1Nd4I8XiLZal/PNS3RA5te9tY
 8rY5Nc/W+SbVT9bv8ihxDhF/PLd34c6v1CSkxeLOkDJShrVuo1eRlBOzQTlOCJM+RRvvJBr+q2y
 0eJYQOqHk+TnO3/67fPCKPJ0kywZ2uGab9Gg4OKNhu+G65H/weq6J/t6Aex43qM4bEF732/+F1C
 GnkFJVtnq2KgJE04xfQ==
X-Proofpoint-ORIG-GUID: 9Yg53qYLvzzUx9vNERnVAk1K7sVLZ-3v
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b48992 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=K3oJJphijqaC0nxcXBEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9Yg53qYLvzzUx9vNERnVAk1K7sVLZ-3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130176
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/13/26 3:48 PM, Eric Farman wrote:
> Jason offered to help review this area of code;
> let's make sure he's notified of changes.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23562aaac2..e83ff3826b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1866,6 +1866,7 @@ S390-ccw boot
>  M: Jared Rossi <jrossi@linux.ibm.com>
>  R: Zhuoying Cai <zycai@linux.ibm.com>
>  R: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/ipl.*
>  F: pc-bios/s390-ccw/


