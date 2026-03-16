Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AEEF506CD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28Bd-000737-5f; Mon, 16 Mar 2026 09:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1w28BQ-0006wI-GT; Mon, 16 Mar 2026 09:40:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1w28BN-0004vX-6g; Mon, 16 Mar 2026 09:40:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G1Tx591290637; Mon, 16 Mar 2026 13:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oytOZP
 ylOAhqcuDPdLjT3g3LqvUXB64MAkUtNvFz6iU=; b=S7gVa75+7WOUG8tXPzdbgz
 9S7NFRWZqFLiDhDKZ315j+5cQURwx2vn2ZraJGNejTGz+v1p5tM1PsNVrbC5f/FI
 KwtjpZviZXFZRzdBOYJbyGcA5GYC/T6887f78H3+W3RZWslzj8DGjfYczUG8gXvk
 nknzVuHqYtvuwfd3rkFWuIJMs6OudFhcEW3xNv7NtWzi+pkfKMpGXYVg3L2p7Er8
 9aptndQwZZi7i+d+Bf8COqLcZggrSxmCizjJ8JwvO/ileBO3/k2cvNEqweNo7obp
 QS1PTqmlRIg02u1FNM1oL11HpUQtTpyfr09w8evuJWW/ukg1TTBeQfcDppyitvyA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau7p1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 13:40:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GALs2Y015644;
 Mon, 16 Mar 2026 13:40:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n50ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 13:40:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62GDeSsa30933638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 13:40:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EE925805E;
 Mon, 16 Mar 2026 13:40:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 657005805D;
 Mon, 16 Mar 2026 13:40:27 +0000 (GMT)
Received: from [9.61.9.100] (unknown [9.61.9.100])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 16 Mar 2026 13:40:27 +0000 (GMT)
Message-ID: <cb54fc3b-5d8f-490f-aaed-f8cb9e0bbe8f@linux.ibm.com>
Date: Mon, 16 Mar 2026 09:40:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add another reviewer to s390x boot
To: Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20260313113424.15583-2-thuth@redhat.com>
 <20260313194810.1844241-1-farman@linux.ibm.com>
 <20260313194810.1844241-2-farman@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260313194810.1844241-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMSBTYWx0ZWRfX5QXJWld2/ome
 j3tDBFimEmCPlkB+wAn3zpLkhCy5hKssP9sr73UsVLU7UnxY8sBXXCn5w6ZIKnOuXxaZEq7s4AG
 NNv3j1I66/BGTXRixS2srxjwsFK3qIimdHMLJ7IWhveUXDE7TVUJbiTnSiLjufRseEEOGKH6gxC
 fDgY3g4sivj4xDfa+GUf02IpNAFd4yHaJVuTH3l/jM3tAIhySwNoIXL2gSYxBy8a2AdEIP2ELn/
 0Y+0Lnn/IqUEyYxEsM4cYzSA1P7DrhCNj9orJ4YoQk6PiPKTRt9bdBBBzkp9+zLTel+wfqQ13gg
 nSkK+Cd9zI/P1Sy76Gc1qgLBIeid3TmpJZPCAeaTJ1kTMi7ZnN4JQy8DdCD8K6YmWQRZrUocrgu
 F9ZN+tVI73ZRNWrO8x3BCPlz4DspEtfSSOYQTgSOSmyzjVvnMaOVXYsB0rEP2BSEPmDMHQL8V2/
 UjhcCIgEvTuO3qA8XVQ==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b8084e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Pl9V7em4pPg2a3i_iyQA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9Hxb80HTxWV9-HDb_qQI6Z2PkXoHMA5A
X-Proofpoint-GUID: 9Hxb80HTxWV9-HDb_qQI6Z2PkXoHMA5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23562aaac2..e83ff3826b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1866,6 +1866,7 @@ S390-ccw boot
>   M: Jared Rossi <jrossi@linux.ibm.com>
>   R: Zhuoying Cai <zycai@linux.ibm.com>
>   R: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/ipl.*
>   F: pc-bios/s390-ccw/
Acked-by: Jared Rossi <jrossi@linux.ibm.com>

