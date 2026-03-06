Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517F6FCC073
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 20:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyc3Y-0003Wl-U5; Fri, 06 Mar 2026 15:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vyc3G-0003V2-4L; Fri, 06 Mar 2026 15:45:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vyc3D-0000Oe-FP; Fri, 06 Mar 2026 15:45:37 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 626JXo6X2063768; Fri, 6 Mar 2026 20:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=m2vvmS
 pj5KfX6MMA2fNIGRcFbBgh/O8CFS0RMtSZLuk=; b=TaCzWDbnIM4owH+NH39zEX
 Sk176gl/ojNjFPtkVSMuirZ5TwrTx+fm3SbMzUEd9auwrCZz74I1MtExdbSuFNAw
 umnTyDNkidbOt+7u7VukUJBp0YmlmxtdoyvN5XViX5mlLWybzCwprg/U3lyuFo1Y
 8Eb4gr/HMM9nyxM7orYP6IWUNj2Fa3DvV52XylQypnXiQumEWBefKXSF8H32vF7D
 YK42QHzk0RyVR4ho+kwNeKTLnsvhIgi4CtRKgBvClAoz7pzK2gamWtjttOWR9ztC
 5/b/mbTDvrLxpFUKEYE0aYniWpHiWXXJbngyIVNVzLpbsM00UPZC2Xy37XtiIEow
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc9rs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 20:45:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626J6cZB008779;
 Fri, 6 Mar 2026 20:45:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1s7hb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 20:45:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626KjVa520120066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 20:45:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E5525805F;
 Fri,  6 Mar 2026 20:45:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95A775805C;
 Fri,  6 Mar 2026 20:45:30 +0000 (GMT)
Received: from [9.61.242.241] (unknown [9.61.242.241])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 20:45:30 +0000 (GMT)
Message-ID: <8fb6a32c-ea14-497c-8ec1-dd456d561d0b@linux.ibm.com>
Date: Fri, 6 Mar 2026 12:45:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc-bios/s390-ccw: Fix compiler warning when compiling
 with DEBUG enabled
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260306203645.28232-1-thuth@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260306203645.28232-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PpuYCoAOzsj9r3vIkZQbmPQrvSEYCrzZ
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69ab3ced cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=OPmJUrkXEcskF6f5NOIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5NSBTYWx0ZWRfX83Dsosw+UU6c
 wcIh86gheK0lm2AhH/Er8RTMOIdfuE+axtxE2L66FgiNhMAnyxU2C6Slzht8j7BIODIyF/Vvn3Z
 dV/M2bORAbBOiIrEqAs8BddtSBn4WExiXygumraZMI21gpo7Y4jBfbUIiBPFXGB+zvDQU2iLlBE
 3KzTDPJ9AqdVs8YObYQB5L5vzKozCBnSEu/nF+Jom0d1eN/yPkIGbW2UGACfV07FGqZd/8Kww/5
 CMJQO5155s/fzVUAhQ6RLNSsENXV93pjC2CFJIbRjn1WJDjeciiqnPvGYx/mLYJafp/im89IrtR
 O3SJHiGXkP8jxJEiGdW8TdUe0pyLMV5i4Aizy+crFBLIvG8Kav6HKGtXmSsALGNhBFJ6UAV1Z0t
 E84oi3znBw9YhA9pwKkACiOin7VCjo8WEpleg2LxaeYM0OO+eJi1ApOC+oBhSug0IOkYNoD59uz
 smrgG7REuQlpOlq+wjA==
X-Proofpoint-GUID: PpuYCoAOzsj9r3vIkZQbmPQrvSEYCrzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/6/2026 12:36 PM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> When compiling with DEBUG=1, there is currently a compiler warning:
>
>   pc-bios/s390-ccw: Compiling main.o
>   In file included from /home/thuth/devel/qemu/pc-bios/s390-ccw/main.c:14:
>   In file included from /home/thuth/devel/qemu/pc-bios/s390-ccw/helper.h:16:
>   /home/thuth/devel/qemu/pc-bios/s390-ccw/s390-ccw.h:122:31: warning: format specifies type
>         'unsigned int' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
>     122 |     printf("%s 0x%X\n", desc, addr);
>         |                  ~~           ^~~~
>         |                  %llX
>   1 warning generated.
>
> Fix it by using the right format string here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/s390-ccw.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index b1dc35cdedf..6a0b987e303 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -119,7 +119,7 @@ static inline void fill_hex_val(char *out, void *ptr, unsigned size)
>   static inline void debug_print_int(const char *desc, u64 addr)
>   {
>   #ifdef DEBUG
> -    printf("%s 0x%X\n", desc, addr);
> +    printf("%s 0x%llx\n", desc, addr);
>   #endif
>   }
>   

I am curious, this change has been there for at least 2 years...any 
reason the compiler tripped now? Or we never built with DEBUG=1 before?

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



