Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418F9C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf4My-0001iK-3G; Wed, 01 Jul 2026 19:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf4Mw-0001ho-Ra; Wed, 01 Jul 2026 19:29:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf4Mv-0000Zk-4D; Wed, 01 Jul 2026 19:29:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661LmKBU2088556; Wed, 1 Jul 2026 23:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=czCVKl
 w8ImcypJUjmm77TcVD5/GScVkU9OqO/VI3w4U=; b=so66K/T3H+BumG/+5Kie+D
 dgoeUGPGu+nmhxlPXAup3ZW3RkQxhnQoVahnONG4JrmRbTNqb2MDnG3mbOlAsewu
 PLfRkyg+e+n5PGe20kQ896TQj0Xo5wNZUMvmLdhkjKwd4QO2eAc0FsOALRY60oEU
 Imf4X+qep5ZcRBVPP4ruxy+cWZM7/jwEl+iFrxbnklmzrSoloAUTib4yPcdP3AzQ
 UWQ+AafaCnSJx40bHmKcmIWNhBdg//JrCrpUJdBnO1aU2NuoC8QCjr5pvypewbgh
 XaXS6TFwSS6G4jr5SO9a0cwPtZuVIYNkhGQUg5/z8Eu0yOhWDVY6C0EDThhLnjvg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe7708-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 23:29:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661NJgKV017884;
 Wed, 1 Jul 2026 23:29:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqhs5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 23:29:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661NTHlQ19530436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 23:29:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E40258053;
 Wed,  1 Jul 2026 23:29:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1223558043;
 Wed,  1 Jul 2026 23:29:15 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 23:29:14 +0000 (GMT)
Message-ID: <d0ef1f64-f56f-4820-8329-4431363b63c1@linux.ibm.com>
Date: Wed, 1 Jul 2026 19:29:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/35] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-10-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260701204922.1320349-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zQOWqXiZpkb4ZqmBomWaj-ViKAqgJwRZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDI1MCBTYWx0ZWRfX1hNq7nce/YY3
 ESn97EYBW42yCYXWhstGFzmiewYTO512EgWWnDh0tALWEQ4gZ5Gr6m+jH9PwgzKI6RGxrZQUbBg
 DkaJ68m1L2pb2RImzvdISn5vIQsS2OE=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a45a2cf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=bWFHa_THwJjUE5D_Tp4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDI1MCBTYWx0ZWRfXztG7yKsgLzgk
 my7D+CK5xeAv7cTHdOI5FtXS54uBd1DwHn+pOdMOYMEbchB3MoVNNtMWWJAK9f8F8TT6ROvMSg1
 MoHcqpsYzjf6LTRlkBlHZQ1Wo7tovW6bzIB3kl4omU+79KcpYG7M8cho7f/HbZcDwGMbKdcPO3G
 audU1VSkl6xXiENqjGoZPbgfb385wTsVpyj4bh6CTDJ+6e1HqEolR7Zv44Ig77fHeh8JseNtKh/
 H3+ISeGq23mLpTBTSRtuzzucCZM/LpWJxkkfq12wf9z2eFkTRG71Q2r7h9BfN0pw1BtRLT95nvx
 dI95TiiINWlvGvy9m/U5CZvJ5QV9pmb5JqjTsfLG5PIocr7xTaugKPp3azJaRb3aMjK9Ch+Jbfz
 WDgXK3AsqkOIewVX6rTEaSPQbhtnwbzY5z5iuzwGKi9zgwQVcAbPn8apEdqHHGsMCntvAawLSoU
 padWQiWq0Shu47C11lw==
X-Proofpoint-ORIG-GUID: zQOWqXiZpkb4ZqmBomWaj-ViKAqgJwRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010250
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

On 7/1/26 4:48 PM, Zhuoying Cai wrote:

> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
> +                                   S390IPLCertificateStore *cs)

...

> +        g_autofree VCEntry *vce = g_malloc0(vce_max_len);

You are allocating with g_autofree here..

> +
> +        /*
> +         * Bit 0 of the VCE flags indicates whether the certificate is valid.
> +         * The caller of DIAG320 subcode 2 is responsible for verifying that
> +         * the VCE contains a valid certificate.
> +         */
> +        if (build_vce_header(vce, cert, i) || build_vce_data(vce, cert, vce_max_len)) {
> +            /*
> +             * Error occurs - VCE does not contain a valid certificate.
> +             * Bit 0 of the VCE flags is 0 and the VCE length is set.
> +             */
> +            vce->vce_hdr.len = cpu_to_be32(VCE_INVALID_LEN);
> +        }
> +        vce_len = be32_to_cpu(vce->vce_hdr.len);
> +
> +        /*
> +         * If there is no more space to store the cert,
> +         * set the remaining verification cert count and
> +         * break early.
> +         */
> +        if (remaining_space < vce_len) {
> +            vcb_hdr->remain_ct = cpu_to_be16(last_vc_index - i);
> +            break;
> +        }
> +
> +        /* Write VCE */
> +        if (s390_cpu_virt_mem_write(cpu, addr + vcb_hdr->out_len, r1, vce, vce_len)) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            g_free(vce);

... But using g_free() here.



