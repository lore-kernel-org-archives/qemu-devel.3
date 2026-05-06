Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAAFCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKeBO-0002X8-L3; Wed, 06 May 2026 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wKeBN-0002Wk-70
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:29:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wKeBL-000088-AR
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:29:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6466QGAq1531488; Wed, 6 May 2026 15:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5jDOib
 RqY5hQiCzMJro3WF0vLkIzzFqxElGJJ2b+lfM=; b=cVtHaQXpfwaFw236AWQggs
 G076huxxRzu5rm379q8lF1v/O63TRflsQKD705GKPpAaWif8zvWRj1fTNKO7GzBe
 j0QY2qkFMz8II4fzgQ0r7rq8euphYkUr2fmPkGlFUYn+QeLW7hIRxRhOxs3Gr2tv
 vJYujsHPZmcvdg+rv8jch2gHrfXyAeJYKdVFMIM9ApK/DU+H4PAm/yn1cwttBss7
 CapUwBWb3HxHOw3HJZZlTdixZdL3Kg76no7fP4oSO3n7B8g3xbrQNlW3EFmSC1ch
 06UZy9462e8aviqP3qun9Et8ASEv0ujxagE1iTyX/bKBdzJVAPi2geGUG+VcUkxg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4sckx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 15:28:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646FOhhu025880;
 Wed, 6 May 2026 15:28:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqf0qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 15:28:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646FSvNp17302218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 15:28:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47FE558058;
 Wed,  6 May 2026 15:28:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB9C458059;
 Wed,  6 May 2026 15:28:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 15:28:56 +0000 (GMT)
Message-ID: <a1e4f566-3fc6-4fbe-8d24-daa8a41f5370@linux.ibm.com>
Date: Wed, 6 May 2026 11:28:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] tpm_emulator: Limit number of bytes read to
 negotiated buffer size
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com, philmd@linaro.org
References: <20260430155150.2139517-1-stefanb@linux.ibm.com>
 <20260430155150.2139517-3-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260430155150.2139517-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0OSBTYWx0ZWRfX4xrfD83IyZDC
 gzFspzw43m9l+qRU8a9iaizItt4QvHkWwlhe2NX8nWO9HX+SBT/97YbizHh3WEM86hDTtMvHsR6
 OUOEi5dnxdgiH59WxQBNlZ0YlPBKGKVMAL2IGmwmEWB2GUt7YkxXNXj+HR4sLPSRCSqVsA8w2ln
 5jos6MaDL8H48blxELFifeXL3sV3mp90RDwYmxQTOY3chAn87aGOzQJ/XBJfgFdBd9MqFQ3m4I5
 pdTlEABwfZBsKtWlP6+S35WYBqBAWRWWk1GPjFhrj/5YPRQmV6e3SN+JEvvftQOs8P6xI80E6E4
 PjTaoN43xefj435nnHmCnWvdtt/LqUklW6q/6k8TZsWQYYGfChyK9r9HkKCd4dpMT6ikYujI7KV
 ZR/H1yPDrXzj5ypz3mLAvdpQXRQ/w4Wqe6OLZ0SK32x71AmroTKLYemlQ/efsk/b2wD9AG6OeaZ
 PGaqcvieZzu+UdB2hbw==
X-Proofpoint-ORIG-GUID: zYYe22P_LLO-eSxrc2XVtGZnjXyzobj9
X-Proofpoint-GUID: zYYe22P_LLO-eSxrc2XVtGZnjXyzobj9
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fb5e3b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=zoMV5YINSlgt8-0i0Z0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/30/26 11:51 AM, Stefan Berger wrote:
> Limit the number of bytes read from the TPM response to the size of the
> receiving buffer, which is the same as the size of the buffer negotiated
> with swtpm.
> 
> The TPM TIS and SPAPR use 4096 bytes and the CRB 3968 bytes. There are
> currently no TPM 2 responses using this size of a buffer and therefore
> no response will be sent that is exceeding this size.
> 

Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")


> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
 > --->   backends/tpm/tpm_emulator.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 653989ac0e..050a1f4225 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -176,8 +176,9 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>                                        bool *selftest_done,
>                                        Error **errp)
>   {
> -    ssize_t ret;
>       bool is_selftest = false;
> +    size_t to_read;
> +    ssize_t ret;
>   
>       if (selftest_done) {
>           *selftest_done = false;
> @@ -195,9 +196,13 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>           return -1;
>       }
>   
> +    /*
> +     * Size of response from swtpm must be <= out_len (= negotiated buffer size)
> +     */
> +    to_read = MIN(tpm_cmd_get_size(out), out_len) - sizeof(struct tpm_resp_hdr);
> +
>       ret = qio_channel_read_all(tpm_emu->data_ioc,
> -              (char *)out + sizeof(struct tpm_resp_hdr),
> -              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp);
> +              (char *)out + sizeof(struct tpm_resp_hdr), to_read, errp);
>       if (ret != 0) {
>           return -1;
>       }


