Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAFBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6vF-0001lM-SK; Wed, 01 Jul 2026 22:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6vD-0001jx-Ma; Wed, 01 Jul 2026 22:13:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6vB-0005AY-Py; Wed, 01 Jul 2026 22:12:59 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621L3TO2348150; Thu, 2 Jul 2026 02:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8NHBZI
 jQqva353Gl+ud7iGD8h3QuFQbMIS7xMGa8JQg=; b=GsYmPDdXAp2tWjOD5jSnm8
 xsVnvCJ62oErYNEYS8qbGaWKNb6npIdOiLkn4ne7A4M8ZUBGFSmGQebC7pyclxnp
 nkXop2khxieobUvsezGvp6WqkE4jsu/XaUw5aymgp4CYvwC7fRECY3i+cwR1fYet
 ePgZTN/+v8iYYlsSXSZzJiEX7+xP3UfvTmZxb9E3OdyKu9wUph5AYOvMO1jIPmhi
 rp/QxVyqFi7c6569ENHIFkQrLyi6uINnvGK/41glvUMSdED9C3cbz/HjIg+c+buL
 qBVuZUKRF0GXPTYW2oNILLRB04p1Dyrbipz3pfnI7FIiKEQYyijF5cezq/tWWSjg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjy90e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:12:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66224jt4000398;
 Thu, 2 Jul 2026 02:12:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyhsdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:12:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6622Crda23331360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:12:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6DAF5805F;
 Thu,  2 Jul 2026 02:12:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0F7958043;
 Thu,  2 Jul 2026 02:12:52 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 02:12:52 +0000 (GMT)
Message-ID: <e0708599-b62a-4239-b5c7-a884fecc14ef@linux.ibm.com>
Date: Wed, 1 Jul 2026 22:12:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] s390x: Fix intermittent errors with IPL from PCI
 devices on s390x
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, nrb@linux.ibm.com
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260630141917.673995-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX6RpTZhE2mZPW
 x7C+BiO/pP9TnvVdyqK1SPqRI1wMIWfO/EodWDPFuDbTieFRRbpbKAsSjPppf/c9IGnaUMzf3/5
 ELFikaFp/3yIz1hQ/rq4ABxuOm5AUmCC44G2vSgbNIE0t1BUZM4l/4oG4kxftmtHaaTgrD6+ODj
 PknhM0IAg/lnEZjkJLP9VRVZAtyyJ5zY/FLjzCv0ONTrY4PgElioaMhUPJZNkvHuOhG0pV8gdnP
 xet9sGiwsUYdOqiSflmNCVhpNLy/wMYbIqdDXdIoyTnv3byZcHUMNTJ/YS6O6ucvi+iCE/B2E+2
 LWgc5FWXooaNhLBYzNmhkeHGaT6zmAXu2Wyioh8qMyyOHVu/QLJTUvxipJOQX35ZJ1uehpw9dN3
 qfx5d5L9dJ8Mmuzyi9WucnK535ogon5MhvxeNtwH+xlMce2B3GJaaxiy2Ohw6+YPTbCmIWoH7LY
 VV+Lv7GhMCGRQrDGeQw==
X-Proofpoint-GUID: Iv6B07Y4FUzJ4jLUrrTIncEKQvuZeVOW
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a45c928 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=4dd3q85qQy3E_-S_7H0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX4/0umDlBlS17
 GQUKYd+2gJ6bh0v0MzqqC9m+PLmpArdhWt3ImtIoJT0YtDzq+/NnGhamG/V62vDPDaiohm1r9ly
 fUKBCjIaJx+6zxqi9e6oGei+UmH/h9o=
X-Proofpoint-ORIG-GUID: Iv6B07Y4FUzJ4jLUrrTIncEKQvuZeVOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020016
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

On 6/30/26 10:19 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> When booting from a PCI device on s390x there may be intermittent failures
> caused by mismatched byte swaps.  Refactor the byte swapping to ensure that
> it is properly synchronized.
> 
> Correct how the queue notification offset is calculated so that it may be
> used for multi-queue configurations in the future.
> 
> Handle some switch cases that were not caught for PCI devices.

For the series:

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

Worth nothing that, with this series applied (and after generating a new 
s390-ccw.img) I am no longer able to reproduce the error reported in:

https://gitlab.com/qemu-project/qemu/-/work_items/3350

Thanks,
Matt

