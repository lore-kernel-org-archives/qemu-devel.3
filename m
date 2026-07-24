Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128FDC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn9XV-0000bd-R3; Fri, 24 Jul 2026 02:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9XT-0000ac-Pn
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:37:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9XR-0003ei-P3
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:37:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lO2o2162961
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lojtiL5/MkP/yaGs6LFi2EfTqm/eXyHpKFY25E7nhwc=; b=Io1sUYSAlj+5uP2V
 IOcOBYZtyCzCfU64xBGW5x5tjQuUHGvze0H7b1kAlo8pHCi+fb+MKyNxOS2+voyd
 QYYVGzWpz1ZPqo/IxRDnYVYobGpbHcqvSR9D6pcf1xrOIA7K32KFil+hCKe+LLMQ
 gsC3doHeQUnNUiUkHy/zun/hahrEVcHuixTHdf2bRwGrx/iP++Zx60dlQ3SuzX0I
 0U5XEXOnzLwWI6Q40+Uo9btCXvUgnMy28Oilm20abMOIXghfKaWOeTVarOlVc4qN
 GOfl8z9wPv4PdIopGfToAJEmTkPyX8ePNjmVF8AkDr12ZV68EfQh/TG27htodxKt
 QdcMcw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vju0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:37:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so1775381cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784875049; x=1785479849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lojtiL5/MkP/yaGs6LFi2EfTqm/eXyHpKFY25E7nhwc=;
 b=X+v+30Ca0yc2CNdW0JEj8M6iMB0EMf5ZwKuD5Rvnsyvs0zzdbTOUXboONSshr3/Zff
 0zQA6DNQUdSU2iHThNDsZ+ezBbdg8xQc2t6TWxMmePu8UmI8SiworT2KI3YMpZvRoPfE
 UgS48RypA1nslqCzIPZc+1xjWmO1ClsJJvWNPmqumPZcLVYhRNtDc0quE6p6rewKiZ5u
 t5MYHSG+UvjlMTHQB+/4kJVK1JvQfTBvS1plGlPuhsmxlPQBZZUhzcAmGrm+LdFW1zLd
 TjmGS4ahqVyedRSNMA6Wdza/7wTGeC6/QlzVpSe5g18dlwZGh9NbPGqq/5CzKZZ7P9fz
 m1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784875049; x=1785479849;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lojtiL5/MkP/yaGs6LFi2EfTqm/eXyHpKFY25E7nhwc=;
 b=jZIKSyyYSlmgRWcpnEAsPV+ix1/O6er/Ih8Sby/YZu1lhyf94ZhZOdqB1EzJklk0So
 iR8oW2OrrBCjudZv/scTx8x1xQlKV/lxymfe1rTULxSqDSk1NOOifpJCRriyFhCwRsBl
 Ns7zZPK9nx4nij1NnW0VXeDeAUGElUlpsS6c9t2t/JKpm4eT3zwFV3Dk1jmxUO8GMp5N
 JYCNY/fK+GY3AznN7gTv6FOcI6uhXRRuZR3rOdI+5Zz1Pm+zJs5UtyHChNe0U2YuOwqA
 qQo3fw+sRpWAEspQaLbHlnbE5Dx16xTxsxSYYSwRJdyiHFZ2KbTxKA70J/RTDP3QW4BQ
 lzoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7tRXsk+ddbnttFiCsYhhT2IAlf6TOwHO6Z04QaVQrqykhAHn0xIaIcXYRJBAW5AIvEM97o4VHcKWa@nongnu.org
X-Gm-Message-State: AOJu0YxZwjV9y7lQ/0wtKrX1qDSyZMPh1QcRkZIeLuvzel+0u04SrfO+
 159/90Z+oVj+ak8uEcHLjLaLVpWq4l1CL9edrAD2p1URsIwMgYoXZDVuZRttny1XplaCLpmcNRI
 kWMHJKA3N1pSqhb73+yG05YwyQJbFwR+mhzjJMD8GPiUY7BkMvjLZxT2cRA==
X-Gm-Gg: AR+sD13xLUeBsrkrJLX6ckPCqT8aFbx7bj5kp2a76GsH2kEiqbzqVJ1d2l2d2ak6h3o
 V5c2yWmdCgfbs1iXPhcDRNPehv1UP22nJjhqQtaf1yfuBYMLuPJrN5D3umEcZyAFI+JG2XnX5Hq
 vynCO1r2bA5gfDibitrv96iv4rf2f5xjLfnnPtgN8Ixha4xOCd9HqhDIJxm2waW+EhRMThXrxFm
 x35ztO1dRKeB+pbn/HU8iUXHkXQKtdzwMLiWsu0DJclI5aBoXdMyDCia0EKOJP7hr9hwD//2qxa
 JXRq9lQ9u7S2MaBq4YCLBzYumZIciKgiCz9cp1qALDJlbdL+TpQe1ftpSCisty1kWnuo1USlC7D
 ZGxRlaEARoBnYF4cHsGFoWENBWyU=
X-Received: by 2002:ac8:5a95:0:b0:528:30e1:b5ce with SMTP id
 d75a77b69052e-5283dfd5ac0mr57338001cf.78.1784875049235; 
 Thu, 23 Jul 2026 23:37:29 -0700 (PDT)
X-Received: by 2002:ac8:5a95:0:b0:528:30e1:b5ce with SMTP id
 d75a77b69052e-5283dfd5ac0mr57337821cf.78.1784875048790; 
 Thu, 23 Jul 2026 23:37:28 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm20249914f8f.16.2026.07.23.23.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:37:28 -0700 (PDT)
Message-ID: <4a366476-13a9-4861-b431-c18cb5eda723@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 2/3] dmg: refuse to open files with no chunks
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260723144519.364701-1-stefanha@redhat.com>
 <20260723144519.364701-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723144519.364701-3-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OCBTYWx0ZWRfX1TtcImsxUg7G
 BYnwNANWAugmG1MHj55U7TQiZjmRQQy7i6fpnS2yIt4q4UB1XPIq7dlmYShoNUXCWhkeARx/ITr
 qIJ37uSfCn++kcs6n436FZ8C4jpPWuQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OCBTYWx0ZWRfX7Twxmc+dyNXC
 h3+5h4jmZYSSdyPism7Qz8gI9ev1LLcBS1Ogcnh8l+guGgxtga4FQHbO/8DSSadqb9hWUEwE1Bh
 E/Z/I43tA+gKw25KgNPeN4c0uGzQkn32tzqI8qMXTbNe00VKjmsBTOklDXGrWrazc4l56DxEwhi
 g8Wlqcd6vOq9TMF2cQjjDpW8/ubV+B2cLjLtXhzPa2ZXKN7t8RToINtSoqpHYf9tVuAkpfcvIxC
 mc0buXE/WOjn9lPhRy1CYlRwy3Zk0rU8vAF8bs718hjeP3Va5weZIPLCZ5v0B6X/PTQ1eQxpSxp
 B2BOtYwhScxrJcQ5AxOSly05iVang7eKPcgRsj6eNCFn/8mxHd413H+wPjqSYnG+6OknwjezKEY
 WiTy+mnOqaibWgBsnvJdQWsvGWOJ0cL2woSwdbsPKh4QmmVpX46LaWnhFzA0qTpCmQC/BWcKRGk
 a4d0ia27VKAcrBvuu3g==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a630829 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=J_-Nd1mkAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=dANMlV-2VcxuEYxLm5kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: YDE7m4vVGjF_DR-rmQdv4fXEHVMECbLu
X-Proofpoint-ORIG-GUID: YDE7m4vVGjF_DR-rmQdv4fXEHVMECbLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 23/7/26 16:45, Stefan Hajnoczi wrote:
> The dmg block driver expects the disk image file to contain at least one
> chunk. Refuse to open such files. This ensures that dmg block driver
> state always has non-NULL s->sectors[] and related fields.
> 
> Note that the previous commit fixed the only known way to trigger a
> crash. This patch is just for defense - let's avoid opening the file and
> having NULL pointers in dmg block driver state.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4021
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/dmg.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/dmg.c b/block/dmg.c
> index e325127d144..6f8120e0338 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -559,6 +559,12 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
>           goto fail;
>       }
>   
> +    /* There must be at least one chunk */

dmg_read_mish_block indirectly updates s->n_chunks via the
dmg_read_resource_fork / dmg_read_plist_xml calls. Both
access BDRVDMGState @s via bs->opaque. OK then.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    if (s->n_chunks == 0) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
>       /* initialize zlib engine */
>       s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
>                                                 ds.max_compressed_size + 1);


