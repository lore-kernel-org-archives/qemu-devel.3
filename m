Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB1CC5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvEvE-0006LI-6P; Sat, 15 Aug 2026 09:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEvB-0006JF-AL
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:59:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEv9-0003tm-7v
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:59:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMdah642797
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oxEhByDE68f3uMvm/IT1zYO75Qyc8mfPBNs6GENLEH0=; b=JHipOcWEXbj6Y/Y0
 LjiMeQ32lcishYs6Fo88GhZCu5ycaMwhEmNvxXkanc0J2+yBJalZC+a4r0VQ6Nki
 bI9JrmIuu4ga/OHm4L5bl8MulmfHOvfiODaisIgaIfPlIsSqWqv6VxjJpAS83Son
 Eo3Ta6eWE8w31BNkbVe2m4Kr47K5BwHx89pJ2quhBj2GFT91IMd52thUqQ05/P02
 XWv6+YiA3E9dodvHnvfJeISq1r0LHhJv2yv9ewbyZzoB1GRZKIL7vt0WaAgcHgoR
 7/hmLb5AQBDvecYNasCm+T/0NdhcOHBcr3xS97jiFdAgaQ5E78zGbYHXAvZjy7bL
 DRuuAg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfs1tu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:59:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930b571432fso189966685a.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786802370; x=1787407170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oxEhByDE68f3uMvm/IT1zYO75Qyc8mfPBNs6GENLEH0=;
 b=BgyxKBKKCpAXVHRNnE47ErvRz0HN4X77/Bw+HdB8CElqaPZuR7bTt0hoTIMgT2J1qn
 4IQQl8ge3kVnhnrx2uOyM3sz5Y1+Q6JND3BVslWm7nJBNtLUEZpJ+oo1a/PXTudyiT0y
 kuGe8ASbkNVG2DLYaGwhAeQkIyZ/yPVyn9OpQe2E1CyKy/dE0aQLGrVWPopnvwipkQwN
 +vkDC9G4CVO/WNItjchZMn5ltvaPz0/TRxw8VFR7S2fOrey59DSRYxb0VdVJrjAOP5LR
 C++Kj0GHJodgTlWVX+sDkxQcvNIW2D1kAR+iEPojXx1Rz9b60pQoxtFaLeLk2jk4ujZc
 74pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786802370; x=1787407170;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oxEhByDE68f3uMvm/IT1zYO75Qyc8mfPBNs6GENLEH0=;
 b=IqsK1tnuL3yClUjzXwffkKTcM85/j90GKNgDqUq44D7NwQBwe221C58NglrK823MXu
 3Agzk9dPSWooUIwbZa4zSdTRs94rPp0YUOPr5tFUiZvwYffVg+DCWXvDK5qjUhleR8Km
 iHEt9onusWs+4pYK3++wauyqN4xBi5QQ+vS8RigGvQAsjvH6vuYe9h7lAJYgtxXnHddq
 MJbs9s0yIKYp3913RaA3hr4buRBRf8ehkA/oL64A/vpUY/R9bJtLBnOMpijV7KdkxHlW
 CbGgPzwg59VjmMRCL/uL4cBbQo6pWqccyvVy4vUdY5y3SlqGmgX0RYs/9DNcGVIot+NM
 +kHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlOr6OcCJh68jtyzg4W5PBzvpOkkvHmdP9gwI9SAaXLyF0wb01eb5LH5YeyXA/Ix2d3BujS4B+6Yfa@nongnu.org
X-Gm-Message-State: AOJu0YztnGF9GMyiOXtYqIlNCip01ZBxYdLrqKhEmfmG8zwXccIkjFym
 0zFhpxcAUWjgKU2ZL5GcwkLvv3mLDZoK9B5Au5ipUeXWZXAmFmHwrWebaRM/sEkqBw5RJNhzXxP
 jZyPRj2c9Tmj7FThB7Uk2qf4GWoJ2nBhHbygvqIzoWuHbLRVpbHvNxwVtKQ==
X-Gm-Gg: AR+sD10voBRfj3ntirRQ9bxHcVLwTKlg7SmnIIU9/7SES3cx82nxZULKg6wPj+LkMu+
 MdcCdshU+YISFaaHlrpq7rR4kb0a5dZT7Woc5fo2YxIsuOi2aYPWmntM17822+5SZ2G5eDLhUOP
 UDueSwj4QX3Z07EtU7Vk4kuAn0AeRF4ULG2L/5Se3hxNOGeNPPE1n7fr56XS4XsTJeo9jr4qNkh
 HppK3fWfnLVyLDnS/CNR2WpIDIAun6CF+gbDggKQ+YpV+9U7hWVf+qN/TDDlgb1Xrr9Nq5XSlKi
 jjh8dL2242xp+e0+luRYO+c3skjSW08IZzGQaESp3STX1txsAWvBcZsPFy0VIbq8E9kSidhNmsq
 FPdxcLdYK0t8vBPuZ8Oc+iJ2+LU2Woz09n1k=
X-Received: by 2002:a05:620a:4442:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-936c07231e8mr2029781885a.15.1786802370486; 
 Sat, 15 Aug 2026 06:59:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4442:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-936c07231e8mr2029777285a.15.1786802370055; 
 Sat, 15 Aug 2026 06:59:30 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1fc2sm17208328f8f.20.2026.08.15.06.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:59:29 -0700 (PDT)
Message-ID: <b8ea980a-dff4-44ef-83ee-6cc1402a313a@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 15:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 00/15] qdev: Clarify and enforce the device
 realization lifecycle
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfX7fOKPVXvgapG
 mXkPxs5xXz5Yb7PYznT3GciUhlSo8g2i0rhpFBzpCoOfuiCptmi4yygjh7sdN48Er+En443dQag
 JnbaXkdVUEKRN6d8mPuezubzyMs6C+4=
X-Proofpoint-ORIG-GUID: -Fy4OOGMoWBC-RbNOzSUKVP6spRqAGvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMSBTYWx0ZWRfX9fhf08Orzbsi
 ITWs/Q9aDSCgUNFpSgVxKQlfsOLRe4ksheYb1bVX+K0RWnfm7j39p5dSxpGjmd/qBE6QbCY6xvV
 TA0Yo4ASXf5XErCcHfpTC0jclQNOoNkTySk3hKPScM2PFeDbePP0rVJGcVGazNj6KvAT+YbidHV
 lcuQmc7bwmsYQ+vU/raxAa9ZCiQmDAe/xhCcGnyR9tZWvRQYnyOSJmcHxYRTCfvFYjbTlnoYTFB
 MR3ttfb2EOcezzHHDeMQpGjNXQ2MKNIewbzA3IE369GgMWJRnzQBMYTvYaW+LjLU9zB6pUT7l9N
 Hdw3gQUlBs0Ezu3/VPR6O6RLk8rj/YInrxocwG8aqmWXVEJH0+sz9EQXytdDIGzc4eHGz+ijKEL
 1Hc+BVCPLVv324mIyqev0tM/M2FdW3/Aggnz9n9xF7YtezhAF20czPaRYFXgRJy6XC5XGmC8fSO
 QRtIhRxE+gVzvsIlYug==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a8070c4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=N8Ew14HRFJzZzxbwEQcA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: -Fy4OOGMoWBC-RbNOzSUKVP6spRqAGvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150101
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 21/7/26 10:16, Akihiko Odaki wrote:

> ---
> Akihiko Odaki (15):
>        qdev: Clarify instantiation and realization
>        qdev: Make qdev_is_realized() take a const DeviceState *
>        hw/hyperv/balloon: Use qdev_is_realized()
>        hw/intc/apic: Use qdev_is_realized()
>        hw/mem/memory-device: Use qdev_is_realized()
>        hw/mem/pc-dimm: Use qdev_is_realized()
>        hw/nvram: Use qdev_is_realized()
>        hw/ppc/pnv_xscom: Use qdev_is_realized()
>        hw/vfio: Use qdev_is_realized()
>        hw/virtio/virtio-mem: Use qdev_is_realized()
>        hw/virtio/virtio-qmp: Use qdev_is_realized()
>        target/i386/cpu: Use qdev_is_realized()
>        target/s390x: Use qdev_is_realized()
>        hw/qdev: Parent device before setting parent bus

First 14 non-controvesial patches queued. Waiting for Igor or
Michael to comment on the last one.

>        hw/qdev: Prevent devices from being realized more than once

