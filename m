Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF4EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdL7-0002wY-Uk; Fri, 03 Jul 2026 08:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfdL1-0002sU-Ev; Fri, 03 Jul 2026 08:49:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfdKx-0006cQ-M4; Fri, 03 Jul 2026 08:49:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636IUqS1813201; Fri, 3 Jul 2026 12:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TTzA6S
 mFvxF5wWJE/zEu50CxLp1rDLwUGtX1ay4KD5Q=; b=LFH1CYoua++Bf+yRZYjJCg
 rJlQR5jf9ohiQ+TcAie8V5/VATdlueqtGCMEx1ytRCYbWOVIsw3bycom4lLdgXBJ
 /fEyuk8kJu8zy4iSKELjpffdtLPRo8/kfSaBwEaQibO7SA3bNPjpaAmJ1j6afBDd
 vWcuY7aoaCr0LG9NYA/WCTO1ZmDuDDDo4IOuHTOBUaPgcC0MePewgnGrH20GMqMZ
 YEuSBDcefXsm8EtMHqeglrgwamlp1l3NPa4PqMwsDM+kuRAMSbMX2MXjgFUaLV73
 4PupUgvqWVL35HAMUIdrdVSWZjfUQr/d1ZXtSJ+pXDmtZ7whNdr/Tg7eG87W/8ZA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qaevk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 12:49:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663CYZLw025924;
 Fri, 3 Jul 2026 12:49:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wgy75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 12:49:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663CnSdt49021438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 12:49:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F4E620043;
 Fri,  3 Jul 2026 12:49:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C00D720040;
 Fri,  3 Jul 2026 12:49:25 +0000 (GMT)
Received: from [9.124.212.167] (unknown [9.124.212.167])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 12:49:25 +0000 (GMT)
Message-ID: <a52771d5-0179-48de-a0e3-eac95192b789@linux.ibm.com>
Date: Fri, 3 Jul 2026 18:19:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powernv: boot OpenBSD on POWER9
To: "Kirill A. Korinsky" <kirill@korins.ky>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>
References: <20260702130152.89334-2-kirill@korins.ky>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260702130152.89334-2-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfX6iTvZXA0DW7l
 m/zqe8gRDyxeG5PLbVPKfG3BatAu8+h3YJcnBj1lSQ/MFcWg+6gmjY0FtXH3Bt/Y3D2dlJCNhuA
 Z66IsUxbBH2gYg1QnFRxjXyDxaBH2anP6USojqhXtXgCx7OUnnUgQjO+WcJ6RVnzz9sRhMN6LQM
 FMAa/+LDUKnW8/WjepWTc+tzQ9Lq4uAOaS34EknQ308W7rb03fF6dIOvfgB5PdnQODxcB2dc9uP
 7VxCFZjjp6n2yJF9bpIaay/ntN1Wfigw9ce6CFf1TKKZaN8+XwaJgX3qQrneV7KJfzMO1HzycDV
 FQCQk7cr8sTCsMCOuJfN1JPLyLBTapfz9LZUXAx2IjJq8HGrxH8kx08ZBA7n0YBnxpsbs/PeDKC
 TUO+23kU4s6yXwNn6Jdxdma4E8snbwFaYqo1vcNeE3EkHwX+d+hAvxVdI1KsXdZ89eCBT26ib28
 Q1RXIOEWSLso0FYoHJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfX8a5DfPcSWi3D
 bc6h2jF6chjQ31dZTgYDNCJc/4p89zHC6SA20+vsHAKajNCqUuNLcaihYsNArzloOJzYVHf1qJW
 vABppNa2bBlA1QZZUrbr3b90CkbJV6c=
X-Proofpoint-GUID: yuJv-yj3PAAh1tU_jGOj7d0PkLiLSsUf
X-Proofpoint-ORIG-GUID: OrapF7u5k7FzMcrfho7eTkAfcymow_RT
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a47afdd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=7iU6MPg3lQ3xOPl0O5cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030126
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 02/07/26 18:31, Kirill A. Korinsky wrote:

> <...snip...>
>
> +
> +bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
> +{
> +    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
> +
> +    /*
> +     * Keep the existing ISA v3.0 PATS interpretation first.  OpenBSD/powernv
> +     * computes the value written to PTCR as ffs(PATMEMSZ) - 12, which writes 5
> +     * for its 64KiB LPID 0 partition table. If the existing interpretation
> +     * fails, accept that form only for the bare metal LPID 0 table.
> +     */
> +    if (ppc64_v3_get_pate_from_size(cpu, lpid, entry, 1ull << (pats + 12))) {
> +        return true;
> +    }
Thanks for the patch, though I still have a doubt here about PATS.
PowerISA says Partition Table Size=2^(12+PATS). But seems OpenBSD on PowerNV
populates PATS in such way that Partition Table Size=2^11 + PATS. Why does
OpenBSD populate PATS this way, or am I missing some document where 
Partition
Table Size was 2^(11+PATS) ?

Rest of the code looks good to me.


Thanks,
- Aditya G


