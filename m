Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00F4FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISRN-0007HL-Vx; Thu, 30 Apr 2026 10:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISRE-0007B3-Da
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:32:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISRB-0001Ac-Pc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:32:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U9cJJp2674716; Thu, 30 Apr 2026 14:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E9If67
 mycnnvvl033rjBz8r+z9vhJBq00b2/gbRRc+Y=; b=ntGLGdlofX+JOYddWM7NW9
 yp04lZSwCD/lHA/Fu486BzoOV1LdfgHFvbRHRE/D7JTmZ0+EuilFvzbfmibywcQ4
 kiijnM7DNwtMsFOc7GBKFPN7Omy4cfJZFsLn7KzOBxyJxAo04qeNig9qBEFbitgp
 MWry1dpO/ltYIoB5zVMNWTdDzVn5XdF7/yISN/McxFHWzaH/YPW9+PdPY8mps/n9
 QarjZgDgvn8gX3OU9t470VhGuog9dXQI6ZuqPCfl50hgc35f8e0s86cqPmcuu3b/
 FwH7Bh1wp2YZPoDhiK3q9tqDVAkB78CEDIqVRLqRF/zt4thLwVuasRZ+fieZokdQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jxpsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:32:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UENsg7029991;
 Thu, 30 Apr 2026 14:32:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw3f8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:32:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UEWIOd17040004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 14:32:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5753158045;
 Thu, 30 Apr 2026 14:32:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC00A58052;
 Thu, 30 Apr 2026 14:32:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 14:32:17 +0000 (GMT)
Message-ID: <92d20108-aa75-40ee-a561-3fbab0fbebad@linux.ibm.com>
Date: Thu, 30 Apr 2026 10:32:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tpm_emulator: Limit number of bytes read to
 negotiated buffer size
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com
References: <20260430142337.2104726-1-stefanb@linux.ibm.com>
 <20260430142337.2104726-3-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260430142337.2104726-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE0NyBTYWx0ZWRfXxSS6gPxEj6O1
 6GokHn+hJtp4w0gq0mo0AR2ojLCjyt3qRqRHUxVh1OGzp8ww0C/sAFu8ukit7r3q2RLDOHOZFaS
 s2zHc32ppteiVijQzmoInJJFkFxA8QPzbNWNy8p600yd127M0DPX+gZc3KhxzgyQLeBz7gA61Lg
 CILBRXWMW5ctEV2Q7Nt9xUljyU1suGWiyWcf1IkKN1uPeA6LIc9Ogc3CWjBc5mrCepCxQF8hxUT
 2Ar+mQ3+q89xsHDcVM9YbEJjsiFVrVwdMAqVSo0aMlj//Oe9jhR9nNI9mGfLeQTXYfbd+9xMNuS
 9XnqA0zh15ZHjfXsO6HE0kpZsCXcZ7w04gQ9vFyzg4o0HvszZEt9Es9kzkoLKF+Jalv4tmAcPUn
 M1tVy1s59dKw9c+DVvI4bnUt2p9iEC1ecZDfB+PESMZucosE2Aq+HMx/bndh86PUjjJ0GxLJdGj
 0N4neiYRceztkXDlbCA==
X-Proofpoint-GUID: I6IjdTBkFD5o20KujGJXkphYnTzTV9pq
X-Proofpoint-ORIG-GUID: I6IjdTBkFD5o20KujGJXkphYnTzTV9pq
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f367f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ximnn5mWO66e9a08BlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 4/30/26 10:23 AM, Stefan Berger wrote:
> Limit the number of bytes read from the TPM response to the size of the
> receiving buffer, which is the same as the size of the buffer negotiated
> with swtpm.
> 
> The TPM TIS and SPAPR use 4096 bytes and the CRB 3968 bytes. There are
> currently no TPM 2 responses using this size of a buffer and therefore
> no response will be sent that is exceeding this size.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   backends/tpm/tpm_emulator.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 10ab909474..b8ae113774 100644
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
> +    to_read = MIN(tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), out_len);

It should be:

to_read = MIN(tpm_cmd_get_size(out), out_len) - sizeof(struct tpm_resp_hdr);

> +
>       ret = qio_channel_read_all(tpm_emu->data_ioc,
> -              (char *)out + sizeof(struct tpm_resp_hdr),
> -              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp);
> +              (char *)out + sizeof(struct tpm_resp_hdr), to_read, errp);
>       if (ret != 0) {
>           return -1;
>       }


