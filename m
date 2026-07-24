Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55F3C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFgR-0002mF-V7; Fri, 24 Jul 2026 09:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wnFgB-0002il-LH; Fri, 24 Jul 2026 09:11:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wnFg3-0004HR-3v; Fri, 24 Jul 2026 09:11:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OCwZiO007673; Fri, 24 Jul 2026 13:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JIIbSd
 4A/gLdRKAyNrmNK8XXhRXzdNuJjCwBcPz+tCI=; b=suMj2AXjOtgx6hC7TzNDxe
 IY5TFbb62IAmBvM/KA1gPjVhkVZD27XvYA8PXckx2CTyk4fokJi2K+PFXkZEnUj8
 D28bc1r0HqeG3g1RCLH2iBEUzwIlDQmOWCSp6AKBacsy8LP7bJUziinYIhb+F1rk
 q/v6MjX35m5dz01/p7X/OPAjQ+R4b5LnkYl7WqOQBVogQdvrzG9uwhzudXIC9JTa
 lbXhQjw6ynobkWQDoCh4MHQB+N8bwna3vCHlz4j9fTYiKSdRuthitrAdBSXZDgEU
 n+xFX3F/p9N/YtNTHT9FFkjI+IY5zt4aJ8israNvQVGZh8h0tdN6MM+SBTA7I8SA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs81w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:10:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OD4eOE003238;
 Fri, 24 Jul 2026 13:10:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahgy60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:10:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ODApAS14287414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 13:10:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3C1658045;
 Fri, 24 Jul 2026 13:10:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7548E58050;
 Fri, 24 Jul 2026 13:10:50 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 13:10:50 +0000 (GMT)
Message-ID: <e0ff56b0-42dd-4075-8f36-edf877cf777b@linux.ibm.com>
Date: Fri, 24 Jul 2026 09:10:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] target/s390x: Allow 2G hugepages guest backing
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 cohuck@redhat.com
References: <20260713155212.287444-1-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260713155212.287444-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX/QGLJau4cMD/
 CzGo8V6XWtaW4kwRwDJm9y5VU0ppJTfftToIKGxCvoLeowoJsZRBSTtdOEa9wwvIbRJXYb5PlxP
 NiMVJ41aywXATv55UAcp+iZQWrg3ZSg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfXwwGOCKDeuEZi
 +LbbA6jIM8wmQEQQ6N9Jc44S/rIP9l7BRye5ryIOhkxzwhkqgOZhjyLj9GeaSbKWj4+CfSZG6nm
 XCvbyEPbC/x2+xG6aHC3vzIabbrapreNHWcY56Ve0Y/MpUZQv85DFa7WIPqQQd+pd5OaBnAKF9y
 Y+udxRWSPtqpQeZtn7x0Cf/4garhAJsuOlbMCcLjcNpNMEx+A1pY+9kTRyjaWMrXB35XWzEQGJd
 VfJZDXei5Fep+L0T7fShbG3U+tQnfrObVNM0wf9S4NMOLJmnGwwyYLJm2UCjVxuofZ+MbcRLA65
 k9qPpIGWGcKpue9AKOLN9syM+DMSjJGt93IfLShAb2noy10iGHn7yyxMnBHATVHR68/FKJR8vMI
 tCm5x0YH+0fFXA90t+Mcm87LWaL/WUxDjVy/GolEUl2oHLywBlsWa5bZ8EpPtZw0JF3T4L6lZ/O
 gQdkvL74O1YEQrTaXkw==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a63645e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=V0VQRYasDu0-N0VjWjgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uMYAuRcUUEoGQNJ_5ysXoPc45Nc7nz7G
X-Proofpoint-GUID: uMYAuRcUUEoGQNJ_5ysXoPc45Nc7nz7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240115
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/13/26 11:52 AM, Claudio Imbrenda wrote:
> Allow mapping guest with 2G hugepages on hosts that support it.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  target/s390x/kvm/kvm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 72031a5714..23fa714b69 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -298,13 +298,13 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
>          return;
>      }
>  
> -    if (pagesize != 1 * MiB) {
> +    if ((pagesize == 2 * GiB) &&
> +        kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_2G, 0)) {
>          error_setg(errp, "Memory backing with 2G pages was specified, "
>                     "but KVM does not support this memory backing");
>          return;
> -    }
> -
> -    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
> +    } else if ((pagesize == MiB) &&
> +               kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
>          error_setg(errp, "Memory backing with 1M pages was specified, "
>                     "but KVM does not support this memory backing");
>          return;

Just double-checking -- If you successfully take the 2G path here you
will still set cap_hpage_1m = 1;

I suspect it's intentional to fence diag 308?  But then IMO

s/kvm_s390_get_hpage_1m/kvm_s390_get_hpage/
and
s/ cap_hpage_1m/ cap_hpage_any/
or something like that

