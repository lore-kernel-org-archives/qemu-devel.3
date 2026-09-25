Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C780C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vto-0001OA-Nr; Thu, 24 Sep 2026 22:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9vtl-0001Nb-Eb; Thu, 24 Sep 2026 22:42:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9vti-0001G8-EX; Thu, 24 Sep 2026 22:42:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P25N473911028; Fri, 25 Sep 2026 02:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L2yRcH
 4x5xFmDkZXN+TtsLPd65F+bXVZUjMEO6GLAUI=; b=Y2ATTK2egIC5esNcladxIb
 8EvJz4GRgFWKfg2+pvMsujcXhfKb7GyHyloxdup7iQbXiADahXyvi0mVC9cJgvrR
 cbL6dL0+vsNLiScEptmGkJFia890Rp4MDiB/jx1LlQ/td2GLnpQB/AVb62zOOims
 EL1edyx/ZWJTic7DHrYFCswiIPkeIF026B6G0k0TLEkOS0AvpZrYcO5ty1VvN5cz
 EBtgHetIVU9lGsxmsYOJ4rlg5tmFLRjUllC2D659rJ42RMPmawuL+aUud/8XzImN
 Ji/H7DPKz/7kqgKwXY/6luJfCEZ/3npkHi1s7QLBrsM4p/YLRObMkNlqnGFb8PUA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsmq00-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 02:42:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1lUsC3040611; Fri, 25 Sep 2026 02:42:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qrr8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 02:42:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P2gXih9306734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 02:42:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5D715803F;
 Fri, 25 Sep 2026 02:42:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D80958054;
 Fri, 25 Sep 2026 02:42:30 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 02:42:30 +0000 (GMT)
Message-ID: <831a1dbd-b48c-4430-8444-a1d3a5c1135e@linux.ibm.com>
Date: Thu, 24 Sep 2026 22:42:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 qemu-s390x@nongnu.org, brueckner@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, maximilian.immanuel.brandtner@protonmail.com
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <20260921121641.1354712-1-maxbr@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260921121641.1354712-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab5df9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=d8_TefNUAm8_ZYuZkFIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A8Py_6GWDQ-qJp9-7Y6kkX5Qe0yFjQJa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAxMCBTYWx0ZWRfX8FJmTkb6FLdi
 8KAYNuFaZ0rwGInfavf61v5A5+Kjvj0dNMHaucgCunl02m6gRc7l+JMEaRa9kVqP6QXsWUVVoH0
 qeJOSRkbkX3ZWiowWvyjFFzWnWMCb0Jk/1TeNyqoo3gVxnVnRKQiHpeyjnwo6bTrTZiPpu6mt0V
 NfcbkCjJTcyfYkyJp4AtltIhHFu35J4u1LTdRf/ngoJbfQqTimVS9Nkq14RzCk1WZnUxFy4kR/l
 6WmmKhtCe7/gADUp3V4sYcjId6Ap7VDfzhZyw5syHegWkptHfKc0wx2KwC7Lkwb1sBjvU8eHFW1
 cUyrEKb9RmVpp4CvmfKRkaq39Dns33gj+reSa3h/AgrnvBeWz685C3p/LxYoYbYk+sj1xEvIFMu
 4EciDMdyFaFyPHENkNvDMuV6/P3F9e8DKobtyxj7s2RI4eENh2XA8rWEKlSU8hF2WZOwPglAc0C
 uDlzwnHC7ivV2ub1+wA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAxMCBTYWx0ZWRfXxUQ61PWZeWHi
 zaYz94y0PZEERcWzgGpPn41HB2dAQ16p0HPMkGVs6LhPnSWrNCik0FZv/Of3pDzbDtkGPrxPa9x
 /KvvgnnRhVJ30G8R0FDRPC/2d8UJ4Dw=
X-Proofpoint-GUID: 3-T5njCrg0RX9ym_k-jthw03JCokYb6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250010
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

On 9/21/26 8:16 AM, Maximilian Immanuel Brandtner wrote:
> Adds a tty code to indicate a resize frame. The body contains two big
> endian 16-bit integers rows and columns.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> ---
> Requires the following pre-req:
>     [PATCH v7 00/12] virtio-console: notify about the terminal size
>     (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)
> 
> Testing:
> - Tested on QEMU: commit 38879a667f with the following patches applied:
>     [PATCH v7 00/12] virtio-console: notify about the terminal size
> - Tested on linux-next (commit c1f49dea2b8f) with the following patches
>   applied:
>     [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console
> ---
>  hw/char/sclpconsole.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index 179d12745c..acf1fea6b5 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -42,6 +42,7 @@ struct SCLPConsole {
>      uint32_t iov_data_len;  /* length of byte stream in buffer             */
>      uint32_t iov_sclp_rest; /* length of byte stream not read via SCLP     */
>      bool notify;            /* qemu_notify_event() req'd if true           */
> +    bool resize;

Does this need to be in vmstate_sclpconsole / included in migration so
we don't miss pending resize events during a migration?

Also, should the resize value be explicitly set to false during
console_reset()?

[...]

> @@ -105,6 +128,28 @@ static void get_console_data(SCLPEvent *event, uint8_t *buf, size_t *size,
>                               int avail)
>  {
>      SCLPConsole *cons = SCLP_CONSOLE(event);
> +    uint16_t be_rows, be_cols, rows, cols;
> +
> +    if (cons->resize) {
> +        if (avail < 5) {

I dislike the use of a magic number here, when it's tied directly to the
combined sizes of a few structures.  Can you derive the size instead e.g.
sizeof(*buf) + sizeof(be_rows) + sizeof(be_cols);

> +            *size = 0;
> +            return;
> +        }
> +
> +        qemu_chr_fe_get_winsize(&cons->chr, &cols, &rows);
> +        be_rows = cpu_to_be16(rows);
> +        be_cols = cpu_to_be16(cols);
> +
> +        /* first byte hex 0x08 indicates a new terminal size follows */
> +        *buf++ = 0x08;
> +        memcpy(buf, &be_rows, sizeof(be_rows));
> +        memcpy(buf + 2, &be_cols, sizeof(be_cols));
> +        *size = 5;

Ditto



