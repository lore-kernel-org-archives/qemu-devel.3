Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A984ECD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCA8-0001je-06; Thu, 18 Jun 2026 08:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa4mU-0005lg-IJ; Thu, 18 Jun 2026 00:55:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa4mR-0005zv-Sp; Thu, 18 Jun 2026 00:55:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmEpc1106598; Thu, 18 Jun 2026 04:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yQE187
 49MRtja1lfzJ89eq/Z7UNJ4PwFMUJsbIBu77A=; b=gweY9sMJyC7Zrv8kCwY1dh
 z+qZlRCfDGiYwrvHUHuBBngJv+BRcruurKHC/kfJdEU2meHAVEwaTcKgnEF4kfCP
 dLkJm7AFvrhJL0NRKo5Dm/rG9UaZ1YyeQtIS1kZY5Xj901/xCETatq+7nqFxzk+g
 FtKddc/HOi2p8F+au4ZwJRHf5Ek+Oa8Z0yqISTAwX4Nyo25K0xk+9MbRYMfzW8l/
 U88cgz+W+7nYgRNL9SRAQz6Dj+rkSR49woXuzU1zPiuseejUVLKp8F3I1/FnbuCP
 I2stlN4fqdRkN6akmlocjxZhL/+Io8Wzid5JuDhq1b5sxWZtf3YYuomtdvcMyutA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtpc6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 04:55:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I4nfHJ003842;
 Thu, 18 Jun 2026 04:55:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17220rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 04:55:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I4suHb44368262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 04:54:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1D2B20043;
 Thu, 18 Jun 2026 04:54:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E0F920040;
 Thu, 18 Jun 2026 04:54:56 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 04:54:56 +0000 (GMT)
Message-ID: <b844be5d-1b56-41ea-82ec-7520c08247fb@linux.ibm.com>
Date: Thu, 18 Jun 2026 06:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/17] target/s390x: Move cpacf sha512 code into a new
 file
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-3-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bjhiOaGrWzgty4ywE2GhovracoJClSH8
X-Proofpoint-GUID: bjhiOaGrWzgty4ywE2GhovracoJClSH8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0MCBTYWx0ZWRfX1rkj5hx1TTQY
 rN1c/BXTmpCnpK5DDKvz9w1GgxH9OMD9xDuM4qOwo+APkURFANCzPqNWUzlFRHiF18OCa5qGjFw
 K1qsNfgITSOYkaTXE5FVvr98iObih1DHkzVWUwHRLwjotGT4vcKn/w9e8AeZd/sD7l+TOdBEUE3
 VDRNoYLm+tK56i/1e1tQXmaDkPhpe3QReUuMbuD2eUEYhHxIHm+54KisB3RhZ6V+RAF/JHC5SiO
 5aUIuBcV506yXE3NJzT8QUxkB38szjTGlJZ05/2NdRDUUwB8JOUVpw0Iv4YVeoVC7dwSaMxzXHI
 l+ZD7D70J52QmJAlNtY77Hkf31IaMnzr0Q+viA0mFKeGjVHbcmi/wv9ohevygZ0GN8mv/MCFEnH
 FY/gfqCXTI4ZJhdSO0W4DJJQaxTQMAMj4Ud+TG1rOWr3BGU6IG3qLUxwfHofCMEh7lJSvXW75zU
 YxoB06TNxHlrYEMaWCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0MCBTYWx0ZWRfX/3hkw7dFCDeQ
 jAGc0ENdnHzOnhHKoOxpkxckKzjGo7k82CJV8wXMNaQ/AnGLBUemW0T2IpyaqgT0I0ysGydZKvX
 mqfbyyNP4S8K3FZqKGSK0GCuWnai+hU=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a337a25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=AARKpvnCM0ca1r4D8OcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180040
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=fcallies@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:00 -0400
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



On 17.06.26 11:48, Harald Freudenberger wrote:
> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and add a
> new header file cpacf.h containing the prototypes for the
> s390 cpacf stuff.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the one typo (see below) fixed:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/tcg/cpacf.h         |  16 ++
>   target/s390x/tcg/cpacf_sha512.c  | 245 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 227 +---------------------------
>   target/s390x/tcg/meson.build     |   1 +
>   4 files changed, 263 insertions(+), 226 deletions(-)
>   create mode 100644 target/s390x/tcg/cpacf.h
>   create mode 100644 target/s390x/tcg/cpacf_sha512.c
> 
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> new file mode 100644
> index 0000000000..d27839ddd9
> --- /dev/null
> +++ b/target/s390x/tcg/cpacf.h
> @@ -0,0 +1,16 @@
> +/*
> + * s390x cpacf
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef S390X_CPACF_H
> +#define S390X_CPACF_H
> +
> +/* from crypto_sha512.c */

It should be cpacf_sha512.c in the comment instead of crypto_sha512.c

> +int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
> +                 uint32_t type);
> +
[ snip ]

