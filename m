Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F181CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6RD-00026W-Bw; Wed, 14 Oct 2026 17:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xH6RC-00026H-9w; Wed, 14 Oct 2026 17:23:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xH6RA-00026o-Me; Wed, 14 Oct 2026 17:23:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEifj81270475; Wed, 14 Oct 2026 21:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=13AJsH
 UAvvxAabtSKgc7taflBZH9H6tpV65LfT4Xt0o=; b=IU3Qcm/uNdnMqX/KJ7i9Pf
 LW3hHFXsM/HtDWQkHnJtLY4ipQoegp/SQl4LYXp5QMzLneioBU9qxrSPgAq1e/n/
 ybun43ufBTU030gLByRhmYjMfB/3dnQiX3iFhJIU6R/+hsH+9ixVlU6oAbWloH/M
 x7eevnXn1/OpqYOzu5Ly+Ok7UqbjehPbZCKLykrJUWrfP+bikJQ9zS5rZKt0PK5z
 GtMepwka6B0JmvmtHJQFzi2LZrnJjThsCYaZ2EGLNIdKX2W7qqHsqO2SCfSyPLZH
 NEtgoFiv7UhTvLqcqQ7d/6N7UCQTXq1sCoK5Pd3Z8w7P3F+sQkMOcQLwfddIGUBg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0p7v4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 21:22:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EIXZKI702815; Wed, 14 Oct 2026 21:22:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h97qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 21:22:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69ELMtY029229674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 21:22:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C121058059;
 Wed, 14 Oct 2026 21:22:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 723995805D;
 Wed, 14 Oct 2026 21:22:55 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 21:22:55 +0000 (GMT)
Message-ID: <e6ee0956-7911-481b-a4b3-355b79981a5a@linux.ibm.com>
Date: Wed, 14 Oct 2026 17:22:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 03/10] tpm_emulator: Reject sending commands smaller
 than the request header
To: qemu-stable@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
 <20261008212723.3679685-4-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20261008212723.3679685-4-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX3LD/sepQide3
 j8SuK3nmlADJl3VMrKqu5oXu6gFXNu3Hg8RrhM88d+apmFXyu04ziU2rjy9RsfwmnoZQthgyLqX
 wlSIrK9IWkPcvfGIJduhHUcr+UjjfzUW4zWJ8YGKVxOkyZntqtDtwtLEyEZwEftlElaxs0JO4Vn
 Vm00PngxgxYw6eDP2jWQms7BeRbxOE4pC+qoUo5awvSN4/SXQ1EeV+ZvofLXImPBKsfV0aZ2FqD
 WGFEKLja9CZtXZ3n38/wTmL93ecxwubtFmHGjRe4aViUOIJBh2ZMQadbnjcPg8ER+eVlqNwmFkc
 UunxQ5PbMk9YPFCVc96PIXhNmpo6M1HosrFsP97Ir3/8LUjsltVle+QBHdgKvdxuPGRIqQlymKz
 8mJvYthZmZrLnwwpTqcPodAeWw88V4QBquR+ByyeRh/4BFUrRxyoBMdqWvTV5kXE6C6G1kMhwXx
 jmSf2yY2vpN89DMbLBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX3Sba47gpnvg4
 8nl4lfuSWOa2B+v4ggiWY4LZHiDRnOK8QiS+88OTO/PQdZ2qjotr/Oq7G46pe65nbFhW5QooMDb
 eIECfgyeKhAZbQfhInILq2S9QcsnzKA=
X-Proofpoint-ORIG-GUID: vbAQ4WmQKg0SxHEX3L0D1hwWLMeZOiwe
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acff2b1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=Zh1Cl7eEDEOzCGiM3-AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vbAQ4WmQKg0SxHEX3L0D1hwWLMeZOiwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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



On 10/8/26 5:27 PM, Stefan Berger wrote:
> Reject any TPM request from being sent to the TPM emulator that is shorter
> than the size of the request header.
> 
> Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-4-stefanb@linux.ibm.com
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   backends/tpm/tpm_emulator.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 9c95b4d878..0c9e32f36a 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -181,6 +181,11 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>       uint32_t to_read;
>       ssize_t ret;
>   
> +    if (in_len < sizeof(struct tpm_req_hdr)) {
> +        error_setg(errp, "tpm-emulator: invalid request size %u", in_len);
> +        return -1;
> +    }
> +
>       if (selftest_done) {
>           *selftest_done = false;
>           is_selftest = tpm_util_is_selftest(in, in_len);


