Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5CCC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76oH-0006gM-A5; Thu, 17 Sep 2026 03:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76o4-0006ey-U0; Thu, 17 Sep 2026 03:45:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76nz-0005QS-7l; Thu, 17 Sep 2026 03:45:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61tMt1715877; Thu, 17 Sep 2026 07:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NrBKfb
 zGUmkYlkgtselORpFwpekqsxk8nUMaAMItjMo=; b=kcckrglBjnnoPxHFImZOd5
 yQS5u/uj4nBsPF/vWEpB10PD7Y9Eal+Ip60dHAY5h7QLUC0oOZ7L9eQIn3FAky6s
 IYAiO+83z9rbDAuYQukuWUFlUiYiUTHYuM0Skv0J3ChP2KJ+TY8sKE9Wo2uq+H/W
 WNxREtSzY2VRKRA3LeHRsI8EPgYNRgZfpqUHrZqSaSgyUUyXm7InNmXVtgbyqcO3
 WRGvldJA4GEJM5NYatgEmcqw7RABiXBgYR7S45yRm9djDz39pzSNyHMQ0KDPSBf7
 qYd4fk8OaAYiC9aW9yH1sWVxmkffjNEP7P6P4ikZccruo1Z2vEjWdxmpZMrCfXfw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5930n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:45:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H6535K2713836; Thu, 17 Sep 2026 07:45:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ff9c9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:45:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68H7j2gR44564936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 07:45:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26CA62004B;
 Thu, 17 Sep 2026 07:45:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE42120043;
 Thu, 17 Sep 2026 07:45:01 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 07:45:01 +0000 (GMT)
Message-ID: <a68f223a-8664-433d-96fb-16236aeaaf43@linux.ibm.com>
Date: Thu, 17 Sep 2026 09:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR
 ioctl
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-7-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QfGXUYqZ-az4x2QtfAiUxKC3negZw09T
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX5KVfaZR9sIM1
 44bdBzwd1R87VmeZaYqfd9WT4CTv43/4WO/blBmupPr/eI60SAjkDHRq7aMUzRc79ouvPfPuUh1
 y6dardawt0X99eBvlfn07xzBil0sqEw=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aab9a82 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=wnKNa6hROk9B0vxDUUEA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: QfGXUYqZ-az4x2QtfAiUxKC3negZw09T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX6kiIPL7+OfTL
 SC9oG0gyQgwI2gdp2ylBvia/fa4a33HeQjBkrP4cVHpuTvVXWQ4EmEXVWVPESKe8bZpQBBhMvMX
 jS8LnRFhgptMIs6VnQYCkzBhUWud4jNzf7wxqR1x5GtfSovHQFcf3kUa5Ut1t9pJZ0mEJxPdpMR
 yTy0bjqexFlIUdne9EuqXh2iowGeSupo1wAFZltn9xIbnfEDCfuPjTknNajkEirT/TmWtdn/j9A
 zhMElZBLpz7BnJW+zmoUVpLxqsMdTkKZVXymtQQpO3nCTJaVvn2BlKoXOMW7wlxMkqZQ/bJwczI
 37e9rtabiP8VsXrfYbIizJ9p4TbBlndvKQn9MZ4oR4Mrv0rZOSYtFvej0O8YZKbU9eOXcoG1bFB
 1EbpdLxLQJbQQ5Z9gboFs9ANu2FgASzVFpket0nnbKRjYVIPqTygcZhm5u69XlE4wQ2QNToRDmB
 HgEI/e8N8tan3m0wEdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170101
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 16.09.26 um 22:32 schrieb Eric Farman:
> The ioctl to determine whether KVM_DEV_FLIC_CLEAR_IO_IRQ is present
> receives the contents of the attribute struct as its payload,
> rather than a pointer to the payload itself as is convention.
> 
> This may result in erroneous errors from the ioctl, which would
> result in clear_io_supported being false when it otherwise could
> be used (which is helpful in device recovery).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9eccb8622c ("s390x/kvm: add interface for clearing IO irqs")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/intc/s390_flic_kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index f833a3996a..5e6d422fba 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -633,7 +633,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>       /* Check clear_io_irq support */
>       test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
>       flic_state->clear_io_supported = !ioctl(flic_state->fd,
> -                                            KVM_HAS_DEVICE_ATTR, test_attr);
> +                                            KVM_HAS_DEVICE_ATTR, &test_attr);
>   }
>   
>   static void kvm_s390_flic_reset(DeviceState *dev)

Certainly a correct fix but maybe its not as bad. Aggregates > 8 byte are passed as
reference. Looks like the third argument is a pointer to a stack copy when testing, so
the old code might have worked by accident.

      f8c:       d2 0f f0 a8 f0 d8       mvc     168(16,%r15),216(%r15) <--- stack copy
      f92:       b9 14 00 20             lgfr    %r2,%r0
      f96:       41 40 f0 a8             la      %r4,168(%r15) <-- pointer
      f9a:       c0 31 40 18 ae e3       lgfi    %r3,1075359459
      fa0:       d2 07 f0 b8 f0 e8       mvc     184(8,%r15),232(%r15)
      fa6:       c0 e5 00 00 00 00       brasl   %r14,fa6 <kvm_s390_flic_realize+0x136>
                         fa8: R_390_PLT32DBL     ioctl+0x2
                                             KVM_HAS_DEVICE_ATTR, test_attr);


