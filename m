Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56586C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1so2-0006Ho-RS; Wed, 02 Sep 2026 17:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1snu-0006HI-Vt
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:47:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1snt-0006jC-10
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:47:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHIad1962876
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 21:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kgPfFMh2731J3KD2FI3VFJKdIkQyqiwcDHFWL0Gqmcs=; b=SacAlGx/lkUfWODo
 rLcgQUmDVnDGQl/cwX9SKdXgjZ3nNjVpo8mUzgTZ4o5OZcN4w2TsvO3lsT0SRLXq
 Qk8OHI8FqqVHATL2RM8cd06eyCt/TnIMz2YPkjiVgZFcORCuhWWJih4+u/uQ0WG1
 wVDefOT4+WjDuQMETpLlPDBkjHRDaT2qwXOu/HIJIN07a+GqbFx/0eCRsTQWfYzd
 IesKprDuCFCQJ2Qap6SzAPcXMBYel0jIoKMw7GWT+yRSDzZB94Bcb8R1MS85jtl9
 qdeJp8HISZxW81bPiAMzeb4y3z121oSi/ArW3SkmDW7SRhlTgsfVRQlAamPCEj9X
 Ts0HzA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4t655-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:47:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936708f129aso264892085a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788385651; x=1788990451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kgPfFMh2731J3KD2FI3VFJKdIkQyqiwcDHFWL0Gqmcs=;
 b=SUceVO986gRbxJHKG1hqgHjMLPloO5XZy9Xkp+OP7i8oXqS4ggUWtRbDXLw0HO/gQy
 7VaSXKrTm455vGFAPMezW1S/Yxy3KyvlIeEOd/A4krkCyDFBZQ0w0eglloDtC/kAY/PE
 78Dmw8sXQC+28khUF5pSdHjEl3aCIOSifOQZxEEbVKxut03x4M2ga0E0bpF06td9zgz3
 YWRQXiQRghehdsy32iO0RKdMbuTxf5k5pZqkJLMQR9+XbV53RsJ7eKyJjPidDEnMkqZ9
 DZaM/zDp0bnt+FTBeB2lNbGzjLR7+bAns9AyOwVoEKdHO55vLjPj6quSlZ1Wbd8JgwFP
 KBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788385651; x=1788990451;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kgPfFMh2731J3KD2FI3VFJKdIkQyqiwcDHFWL0Gqmcs=;
 b=g4Wu58alSp33zUpM94hcQynzGq4MKBvnWLm0N/I0J1rvaANWIy9ILj65PjztHU5u8B
 y06QmDoy8jyQFmuMRGETPqRauslcrmPmdOCvXjEV6+Omes7zm4sMpCeIi5mD7vgj+s8v
 PERT+cmBwLQ4nUFPh0cIz2Ya6y9dZB1OyT+sIq75NEJImCYULM7bPYxjXjuGHyK/iuWH
 99lW4v4MmcEndUQY54u1RmsWanVvs6sfpHskX9orHshj0FABI0qX9V3WNy5mx/wypr5S
 Sg/RPFDiip5dL/K0L4tZG7Eiob8xt2bWHoosotZJFCLgcO5RbqTDRKCZtudCSAFTLS1A
 CylQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzthH1458HXcClToops6oyVCR8+UmP56e3CQtDhmrb3Ea8RLHX249ce/raKqNgv7lFuqImAh25+zfrk@nongnu.org
X-Gm-Message-State: AFuF++mzDiGE6U3f+362wO5hTChvGvOgD0bp+yCvQ5ISsAWh6g8G5G37
 wX8MooMhoxb+LJ2gIXdQWyhhiNOgWDotIqF7rPOvvGg1KuKAWe096ZnrabuPjVef3JuXUnCJdNf
 eFnaDxTMog+ydd/HF9svPS7xW9MoKBxzsD+Tn/96aRkf4GDaGuHTo+6+PgQ==
X-Gm-Gg: AYBFou1+SfY1yHkAy6MxbbWaHW3W1VsIwP6xXl3DmGyxy0cyRbYfHSS7CZKmu1m1x4L
 Gc17hzjmS82SsK5yI2j7sUg7x4V1winG7P+7Twxacs8A1Y7sqQWfuKrAm8v8a5hnMSYqxtxLDmg
 vkDwQTvhyjrcMfmCxw5sg2ja/spelGMXIBM6lwx47q9ulqlny6oqroCE7DLENAx5z0gSwffx86Q
 4Nd4Vk0LevhWVey4bUu3LPDa3XF/U0rIMONbtKIBlAfAFNUC0DeiwaAyb3NIneQWMhGf6nYqQNn
 MA8Cv68Qf7ANo+OCTxejxlMNGxXBqfNSIdtbNkIdI4FtiLLq7EJs0Y/A8ckojYd63drf7PJq+y3
 2H4YpZLk7BxAapcX1JGiHLRg0dVSUbQCEVw==
X-Received: by 2002:a05:620a:f13:b0:937:2ac8:bbda with SMTP id
 af79cd13be357-93960f52da3mr885272985a.35.1788385650587; 
 Wed, 02 Sep 2026 14:47:30 -0700 (PDT)
X-Received: by 2002:a05:620a:f13:b0:937:2ac8:bbda with SMTP id
 af79cd13be357-93960f52da3mr885270085a.35.1788385650122; 
 Wed, 02 Sep 2026 14:47:30 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea468sm9387504f8f.26.2026.09.02.14.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 14:47:28 -0700 (PDT)
Message-ID: <97e2a6e8-d1af-4509-b530-bd81f29fcd79@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Register device ops in drives without media
Content-Language: en-US
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-stable@nongnu.org
References: <20260723205847.137001-1-berto@igalia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723205847.137001-1-berto@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE5MyBTYWx0ZWRfX+roSa4WFn24H
 rTI9RdW6hLg/m24GurFWPxRyWxCzs3YLwZxcmek2RyzUJP8I5Ei6S2s4L3QH3tVRZGkZs/gtFql
 RFmcEa9gyqaEvr6kMmSNM9GuTupRTLhScyv2QuP/oFuC6Xw+qT3y0VlQKgg8BkPQhWGDcC9bAh5
 pC6CJLDONc8EvF5EaXZ+Mq+/4mzFlYFTz/fc8vzhbu7Jjvq0ixDT+dkNtBjFwtnJ7nKY8f8fcmJ
 vPD9eJ8tDYpWO6IxyHmlcrJh08whL4kb/gDG+qev8Mn0WnS7ne9N9UJfXdNwGuZ21Ijopr+e9ly
 m3ElwEX0DCfQDqq5SysBSvyH6LW5XA6Vn/tfwHhYDEFrVu1CN2hUz0BatOK4WoCCT/opt2WXVmE
 nd0DgjQCRVCS7cFfucbsFp2VwRJzKCN9k21548Jpem1tdLMqn0Wpa6SXIjUL4zBmS/MlpGSj21q
 rymG72gmaZmdQd0UbvA==
X-Proofpoint-ORIG-GUID: d14xxkc09q1XNIehqsr0P-v0-dFXZyG2
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a989973 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V2sgnzSHAAAA:8 a=EUspDBNiAAAA:8 a=QHGuHTh-TSDxaHYrn_0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-GUID: d14xxkc09q1XNIehqsr0P-v0-dFXZyG2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE5MyBTYWx0ZWRfX2Eb9fm/BXwvH
 rg1iLdab4xmm1jSqcPRR23R99HVzOkChxf5hGtn4DQDxSlfCIPh5DS2ZmnqR/Qy6vF2KeFVRrCe
 x0i8xr9/ou9/tT45nKm9P/ED6qsETR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020193
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/7/26 22:58, Alberto Garcia wrote:
> Commit a362b19a39 ("hw/sd/sdcard: Fix size check for backing block
> image") accidentally moved the blk_set_dev_ops() call into the new
> 'if (blk_size >= 0)' block in sd_realize().
> 
> Because of that, if a drive is attached without a medium then the
> condition is false (blk_size == -ENOMEDIUM) and blk_set_dev_ops() is
> never called, so the drive is registered as having non-removable
> media:
> 
>    $QEMU -device sd-card,drive=sdcard0 -drive if=none,id=sdcard0
>    (qemu) change sdcard0 sd-card.qcow2
>    Error: Device 'sdcard0' is not removable
> 
> This patch moves the blk_set_perm() and blk_set_dev_ops() calls
> outside of the 'if (blk_size >= 0)' block so the device ops and
> permissions are registered when a drive is attached.
> 
> Fixes: a362b19a39 ("hw/sd/sdcard: Fix size check for backing block image")
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   hw/sd/sd.c | 47 +++++++++++++++++++++++------------------------
>   1 file changed, 23 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued, thanks!

