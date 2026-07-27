Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82D9C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMbh-0003m2-KE; Mon, 27 Jul 2026 10:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woMbf-0003lP-PY; Mon, 27 Jul 2026 10:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woMbe-0004V8-7d; Mon, 27 Jul 2026 10:47:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDnTan513836; Mon, 27 Jul 2026 14:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BCsiq9
 IaedngDUaUGjjbjiJsJ3OWquMhqxqs6BC1858=; b=i8/aRWlG4JVdJaLtlstdyg
 bAdAD9puoYYH6BupQ09vKhGMP+akZo4YKmDmM7r52Fdp/Q2fewfFtdO9KP902u4z
 I+hGVG1Agv+b7+FgOz1JDm6lzh0G/+C5SbeEz64uQv9IdvKa4uJ0uecxCe6/QU1h
 7DAqscED45k8n17diN5C1ujPtn1emGlE6mJgW4chnlEl2gqVyi2z10YwjPLT7tvS
 5cbhKB0F3ayH4wxnOXoZVhTcmheAdh8BIuD3qalCcAV+EV8HhNSOnJ2Wa9BkZm9Z
 hXRXXEwPbm4HH5lDzu0+W0USsQsQkQ9sSOBEKbKVA9NpZcdnDDKKhU3O571qfvKA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc8j3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 14:46:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REQJBl004083;
 Mon, 27 Jul 2026 14:46:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvwwf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 14:46:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66REkrwm525050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 14:46:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 818DD58056;
 Mon, 27 Jul 2026 14:46:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EBDF58052;
 Mon, 27 Jul 2026 14:46:52 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 14:46:52 +0000 (GMT)
Message-ID: <2b2a79db-30d4-41bd-bd72-d86c58ff534d@linux.ibm.com>
Date: Mon, 27 Jul 2026 10:46:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/char/sclpconsole-lm: avoid guest triggerable assert
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <20260727115052.24289-2-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260727115052.24289-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ntW710vVpebQB6iJs5Qu7lqcwyDnLqJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX6YRkSysxxQqr
 uIp3lNYy8zSNlOl2emAstH2pb4RZMQ1WzXPpuSGsEluCdkg2ROi/O3QtLrNjMAtvM1GM31PIKrm
 4jkrrLccv7sdU5kJZEasG9c1gxtHpQqoLUsk58o4xwViyD1PU7dV9pTbhIwOtKUjXMWfwQx8G33
 oN85Y00mU2Keyi4GtqAUXidZ9YOojy7Gs1jyx8TGCWqDnJi0Kdh8b+4zol3bea7NXJKSScmB+xB
 xS7KoGUIUzOTi3tAd61P0HcA3SGoD385qHluVizviq9RVY4fn1bX6hYyNT+2yqG6lSEhCuLCqdo
 gxEFHR0Ch8IDxSZWJzntNK5zjD7Z16q4nujIkX3x3096w570m6Ja4SjfY+T0orVNwQKGfIU6pc+
 0BZe9Hd4mT1RFqxzYMsC7SEigM7BbMlhiRapsynTyJc5jcJt/aPTWhcsLHInIKQOGILxDUQC9Ou
 uhaoSyu06JMj+ntO4Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX1HvWERdkApQk
 UZ2InV4jyI7LzaYbm5gG9l6bGIb1VXpTtmZEca3b6FuOeZL2DzcEQTZp5NylVxqPXZ0kEr3SAxJ
 RtIjIGP6swmyGZPSAVe8TSMeyB80fzE=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a676f5f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=s3Oye56dAB-iQekpRjoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ntW710vVpebQB6iJs5Qu7lqcwyDnLqJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136
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

On 7/27/26 7:50 AM, Christian Borntraeger wrote:
> If a guest uses incorrect message length it can trigger an assert in
> process_mbd which kills the guest instead of reporting an error.  Fix

Typo, s/process_mbd/process_mdb/

Maybe can just be fixed when applying?

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> this by adding the correct length check.
> 
> Fixes: 6a444f8507 ("s390/sclplmconsole: Add support for SCLP line-mode console")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  hw/char/sclpconsole-lm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index 9a16896d22..f6ed282f1b 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -243,7 +243,8 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *ebh)
>      SCLPConsoleLM *scon = SCLPLM_CONSOLE(event);
>  
>      len = be16_to_cpu(data->mdb.header.length);
> -    if (len < sizeof(data->mdb.header)) {
> +    if (len < sizeof(data->mdb.header) ||
> +        len > be16_to_cpu(data->header.length) - sizeof(EventBufferHeader)) {
>          return SCLP_RC_INCONSISTENT_LENGTHS;
>      }
>      len -= sizeof(data->mdb.header);


