Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEED7CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wchOV-0002CF-EI; Thu, 25 Jun 2026 06:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wchOQ-00024y-1d
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:33:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wchOO-00040M-Bw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:33:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juCG1723061
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 10:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BwonDuDvUTqzbD2hzdFQS/YLiP+C8wMvWlHld2exySw=; b=Sf4s0AoVfn42CpQf
 AAElrPkejsdvWM+X6i5Kp21ApW8s0aFBf6IQpzjPDPcy0Rier+wSTGmb4m4YDvb+
 4WrJZjdfPD8pO7/BYgDsH5+EChg79Wq/LvcuwlD87b1vnPWA8kJOvq7/yPQj6IJz
 2Vwo75lSLVPe7+H1xD8jtAlelRxGs2SCKS7qd4b3d+e/ogaqMi+RtgIfWOXs9GD/
 65s51ygp6g4S+RdOvIvjlJwwZbJj1OOkDxaOy4fwtyjP6MpXwU//6gyVaKUPRKcC
 66e0SzBYDSw2tnXE0RY4Z69cru2qjfUQYZhSgDJZTYxFjFjm0N8wyu/iHyd0mF2t
 /dY/Rw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7duv5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 10:33:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91931144870so394304785a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782383584; x=1782988384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BwonDuDvUTqzbD2hzdFQS/YLiP+C8wMvWlHld2exySw=;
 b=e0WCHjn1AGzNNoZ2S2sADPCvocQXG1TlqmFStsczXWkKLilqQDf+M8vWsrLYn4TyAQ
 DdQvcrhlmr7uB7l6FMpgg7aCPES0pvXLD8oiCFcl5IfezrU24ImoKw/yBM7QjUFh+D8B
 2xk3MhIP4kQAsPgYbCPo4m5wtPi4KRiKL/lh2MmnJ6y3ilmaKdkuzPpLBA9thp6JYpA8
 hjqlhu9Wv4B6ibCqULDwspSqVmqW8w+Nz5PF2sHMgI3OtAk+6Is47OPrcmMfxLBSJHfX
 qn0rCJwJ63fMAzZau6xCBDbMmDv6lxPIam3REYgiXAiBrlDWaSjbhVUAVTPDpczpzxYc
 OvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782383584; x=1782988384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BwonDuDvUTqzbD2hzdFQS/YLiP+C8wMvWlHld2exySw=;
 b=N+C6Yw2pAdtO558JQh7uA8O4EaFybtEkUyFV7bnFWznbzs68wIJfbJNhC98AR2qA7K
 Gtpx0OKgNZcAhz3xNCqyOx1g/YLEq4hP6KXjRxnlP6HWlkBCsldIopxxgXaLJKVma+Gq
 hmJIG6WaZ9ekenh76yKPwsp3TQ4RUJGTHxfYXfnv57+8RVqBVW91wBT7Nwv8x2CbTfv3
 +EHVH5yDuSSqqzLPwHMQzAMw89RK4J/q2J4/Lvv8iZWEXFWI8WD94PUXpDfdNe6IbsoX
 UmpYDYgylKnUwg8R52txPlL5ltQ3gFqdaziO+Fi1QV38SLtMZmC6PrlBIHEiH2evrE+a
 powg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ilgFVxXeVxqUPaBREgSYhd4syXMnXkL0fy9vzaoxQcwUVG4Qy5l34kjOXRB8ASx9V86Zkn9Dik5CM@nongnu.org
X-Gm-Message-State: AOJu0Yw/LaVGQyfLMGxRf+dqk7NnR6nifQbw3iohuANmDeurN/F2Gzxp
 0LkjU+jy3ooc+TnsR3RxGSEHcXi9nn8ycpKYgrY4svuWegwMQ2fnBFPU1bCepgiA/f9gwfwY/IM
 6zOMxRIoMiv1ntWsdmIQBevWPMBODMOBIc8NdY4Ag5prPSZ5kB8UPFRftiw==
X-Gm-Gg: AfdE7clt3LUnrIXJjMr17vYKU7mRgSLI5OSDrm/a+dgCs8N7i2iPbHoyfmgeHfBjgL0
 XF3sk97EHsMu6v5aK+WGQlo1X1gPoKjCJR1FwE3YfyvsM9t6L9NBeA1x1O9HeeR89hngUv1KXR8
 LRZt1sH/fcdJ7Y494T6q/8Eld23dhzKaQvpz5wYCnCnKEdMWHDWVO3ZoKlzpi8FArXOAU//xD07
 lWEMRemAwIp/v9lHfhbjzw0mFFUjUBNpNrC/HyOBma4I3Hj7FE0Z9xBh0Ov/H53Tajw0IDFKUp6
 bDtEeJ9gioj2ipivx6rHgsjuVEoNDjkmuRUjQaClMPp9Iv5PI9BYUjMz3XycoH+y8mkJMn8euEH
 HZ2tLhDbfk0pZaq8ERpqPHsVPyw0OWNln1+vfgYiIMKuai6SFrofqnl6sKraBmQ==
X-Received: by 2002:a05:620a:84ca:b0:915:a953:4b93 with SMTP id
 af79cd13be357-9293a2cd5f3mr251325385a.3.1782383584300; 
 Thu, 25 Jun 2026 03:33:04 -0700 (PDT)
X-Received: by 2002:a05:620a:84ca:b0:915:a953:4b93 with SMTP id
 af79cd13be357-9293a2cd5f3mr251319685a.3.1782383583608; 
 Thu, 25 Jun 2026 03:33:03 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c3bsm15735187f8f.10.2026.06.25.03.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 03:33:02 -0700 (PDT)
Message-ID: <a24e7a14-c37a-4d6f-93e1-6af3ba07fb25@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 12:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio/pci: Propagate errors in vfio_pci_load_rom()
 using Error API
Content-Language: en-US
To: Mario Casquero <mcasquer@redhat.com>, qemu-devel@nongnu.org
Cc: clg@redhat.com, alex@shazbot.org, philmd@mailo.com
References: <20260625094307.148542-1-mcasquer@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260625094307.148542-1-mcasquer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9CK59bEd6suNxXsWrOUJkOa9DMlZMVGO
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d03e0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=JgGFZziSFi4rzet4RtMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfX3BJLHGxwkkrr
 9rI7UxRFyNOv+7dvh5KzN/UsD5k/Eitj5M46aIiVcxhHT9TigFSMHQFBLCLiylNH9+GcXJaHaL+
 +jkhSoVc2aMYnkzTSoZlXcbknfbnzkg=
X-Proofpoint-ORIG-GUID: 9CK59bEd6suNxXsWrOUJkOa9DMlZMVGO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5MCBTYWx0ZWRfX2IBBWjDbXxAq
 q9G26KNQMtEiThXcAVjROcoFaCo2KtWzSGLeap8zJ1L3arg031/vNDR8DGZkiOSvDP0lsqMif1W
 ODjY4sMPweXClxzomGY9mbULcTzv+CzzM8eMBfCo5ShKpz6sDCE59XigxWfD3QLV5qgoALzb0ta
 FRZoEsQMt6/nxai4llKVS5IXUX9zTi2tvmfdsaKtHkcCWIWsyoS2NXyICLvsTHDKawJKg1Q83yC
 EsxpdRKl7rrShRBhf8XjGrz49a8r/YzCCxJKi/NP1LUAkXqOU9gN6qh6zualmY3O4XcFdsYv3Xp
 2W6oCbCo74PynQP3SZ/l5HYaf4RKpJd8gKFNIAA497AND3Iw3o7MShmiq8AIpNG25Z/wmje8GTV
 wUeU9N4BP7ajJmO1a0cZLlfx7oGJ8LtQgc7uvnipDA5Ao0IqgzPTyrhkdq1g+9oHFi1HB+FMrru
 zV5a3P9VUM9RVKfDeZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250090
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

On 25/6/26 11:43, Mario Casquero wrote:
> Updates vfio_pci_load_rom() to use Error API for error propagation
> instead of error_report(), improving error handling consistency.
> 
> Signed-off-by: Mario Casquero <mcasquer@redhat.com>
> ---
> v4:
>    - Use error_append_hint() instead of error_printf()
>    - Reset rom_size and rom_offset to 0 in the error case
>    - Update error message to "Device ROM size is zero", different from read errors
> v3:
>    - Use error_setg_errno() instead of error_setg() with strerror()
>    - Reset rom_size and rom_offset to 0 when freeing rom on error
>    - Use local_err with error_report_err() instead of passing NULL errp
> 
>   hw/vfio/pci.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9df04fa2d7..61b4a6a5a3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
> @@ -1040,7 +1040,7 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>                                         &reg_info);
>   
>       if (ret != 0) {
> -        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
> +        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
>           return false;
>       }
>   
> @@ -1052,10 +1052,13 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       vdev->rom_offset = reg_info->offset;
>   
>       if (!vdev->rom_size) {
> -        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
> -        error_printf("Device option ROM contents are probably invalid "
> -                    "(check dmesg).\nSkip option ROM probe with rombar=0, "
> -                    "or load from file with romfile=\n");
> +        vdev->rom_size = 0;
> +        vdev->rom_offset = 0;

Alternatively use reg_info->size & reg_info->offset in place,
and set vdev->rom_size & vdev->rom_offset once at the end [*]
of the function when we know no error is pending. Being at v4
could mean this function is doing too many things and should be
split.

> +        error_setg(errp, "vfio-pci: Device ROM size is zero at %s",
> +                   vbasedev->name);
> +        error_append_hint(errp, "Device option ROM contents are probably "
> +                          "invalid (check dmesg).\nSkip option ROM probe "
> +                          "with rombar=0, or load from file with romfile=\n");
>           return false;
>       }
>   
> @@ -1076,10 +1079,12 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>               if (bytes == -EINTR || bytes == -EAGAIN) {
>                   continue;
>               }
> -            error_report("vfio: Error reading device ROM: %s",
> -                         strreaderror(bytes));
> -
> -            break;
> +            error_setg_errno(errp, -bytes, "vfio: Error reading device ROM");
> +            g_free(vdev->rom);
> +            vdev->rom = NULL;
> +            vdev->rom_size = 0;
> +            vdev->rom_offset = 0;
> +            return false;
>           }

[*]

>       }

Current patch looks good enough, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


