Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AE2D0D178
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 22:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdbsO-00006A-2e; Wed, 07 Jan 2026 17:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vdbsL-00005G-Qd; Wed, 07 Jan 2026 17:19:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vdbsK-0001Ix-B3; Wed, 07 Jan 2026 17:19:33 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607KbaWn032439;
 Wed, 7 Jan 2026 22:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CTsb7N
 Tk7vY8yqRqtNhEKzjcKK0yk285pLsCMRATA+c=; b=Z+0BqjcIxbqFwmHGVTbMWr
 c3H+Wp4oW7FTvs8NY3cQE45ZA5sKXykGbbUvzN9TzzYfudmTtmis83SSfIp7Q4F3
 Rcbm49YQTq5s1ND43l51FxnheOZyYwNh+bgCHJ0/bctHNO7ZECHwKF3E6NBs6zS2
 lErFNiasS7lRRAaLxXeGLBoIG4vBSx14pq3I7KaDgjBwNXuEczmhD/jekz9CYZwj
 1KqPS6h6d6YA3gq4wkd3IE6Bxv/jWMfeu5xPXJiD/wwXG3/E3EG19t+TzY5Q3GNF
 kB+iN7K24f/h/hSH42Mmk7vDYldxxQvkqwOglIKWzKdXMePtcxZGLDJoHmiQOlzg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6bfk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 22:19:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607KgvLi005250;
 Wed, 7 Jan 2026 22:19:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexkbpuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 22:19:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607MJQ8o32768756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 22:19:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A9445805B;
 Wed,  7 Jan 2026 22:19:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6813A5804B;
 Wed,  7 Jan 2026 22:19:24 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 22:19:24 +0000 (GMT)
Message-ID: <54b25823-b644-4ddc-9d44-02f3a2e1867f@linux.ibm.com>
Date: Wed, 7 Jan 2026 17:19:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/29] s390x/diag: Refactor address validation check
 from diag308_parm_check
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20251208213247.702569-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695edbf1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=P_NoP72qeY4FxnBEVQMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3KcmPOeNvSzLy0k0LPIGVSIzbEUDQ94K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE3NyBTYWx0ZWRfX6FT8HWv8alrg
 2OgUeuPtiWjn0cfj/02reh3zPiJkPlJJUZP5CSw5pSxflYbMhtkPWwGRQ1ogYkVBUxM3C6bONkw
 DwEWBzJiq8waCi7/VIWVASHgNQ2eq/49Yq8ayhst/uAcKqyj0P6XPdX2u9KJ+maGfuKJeXQu+Fe
 2wi4BduASsV1vSo9at3P0deXXm5TQr7UGllIMXkmypUs7vH6id70nklB9yM92H4pWYI2Ie6W7nh
 +Ye70/YZlQNOXvVMTEOfZCYS+wpN0QCAA4gU5/Wx5zFCwnfQ0nBJrKJVwrO2F30u4ggtQWA5gt/
 KofrhDCTXVnnnREoLm0sNQ1SfFrUC4KJcme8rhLFuu63bYhljxY5b9critPjU1KyVll+IdJbBHt
 0XUr9KkbRCbefcf1312CqN7TVajF02cZG8IwjtFCoWHTYByi68DEkeQR54Hydt2IyqbBkYs2YUH
 WhQcVVD2zvzWyZmk1xg==
X-Proofpoint-GUID: 3KcmPOeNvSzLy0k0LPIGVSIzbEUDQ94K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_04,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 12/8/25 16:32, Zhuoying Cai wrote:
> Create a function to validate the address parameter of DIAGNOSE.
> 
> Refactor the function for reuse in the next patch, which allows address
> validation in read or write operation of DIAGNOSE.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  target/s390x/diag.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index a35d808fd7..a347be7633 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -26,6 +26,12 @@
>  #include "qemu/error-report.h"
>  
>  
> +static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
> +{
> +    return address_space_access_valid(&address_space_memory, addr,
> +                                      size, write, MEMTXATTRS_UNSPECIFIED);
> +}
> +
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  {
>      uint64_t func = env->regs[r1];
> @@ -65,9 +71,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return -1;
>      }
> -    if (!address_space_access_valid(&address_space_memory, addr,
> -                                    sizeof(IplParameterBlock), write,
> -                                    MEMTXATTRS_UNSPECIFIED)) {
> +    if (!diag_parm_addr_valid(addr, sizeof(IplParameterBlock), write)) {
>          s390_program_interrupt(env, PGM_ADDRESSING, ra);
>          return -1;
>      }

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

