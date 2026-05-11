Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F18ECD37B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNvm-0002jB-TY; Mon, 11 May 2026 06:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wMNv2-0002h4-7i; Mon, 11 May 2026 06:31:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wMNv0-0002pm-Es; Mon, 11 May 2026 06:31:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B8nxUw2604219; Mon, 11 May 2026 09:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eDbt2M
 Xxov11TqZBQraNoY/1WXXUhHCpBWXUWRgRECg=; b=WxgHu34U6tLPDPdPy1T6Jv
 oK6vLYpsAh8v2YJDEgd+cmnRxxM8VgOWit01KxwLYDGHMcuRs8GjeVwC3ZSoOMMI
 fc9lYGej3jI9b4izMVoSE4wxrZnPoWOB35WyDC8xabDw+EizfcBenL2YiPtHqOpj
 kc+8XVnBYmKe8DszrADPG7cffZ2T7oBfJlNwCioVJqibCaCSrS0DAFoZ0za9iMFZ
 kl/AxDmpKu82G5eW3jFvwq9D/uoTdICHgFArxXBwlPwqVu+UL71bQTd0VO7QWWgD
 cz5WHN9GyaldzrtAAv870yAbTrrdBzzhTu1A3ODEuu5n1L65kmNxNNG1BUyOYe1Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju70my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 09:28:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B9OZRf013993;
 Mon, 11 May 2026 09:28:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg4enc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 09:28:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64B9Snih59703590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 09:28:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73CBF2004B;
 Mon, 11 May 2026 09:28:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13F4F20043;
 Mon, 11 May 2026 09:28:49 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.133.4])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 09:28:49 +0000 (GMT)
Message-ID: <abb08329-b6c0-4c93-ba23-a06a18e8ef6b@linux.ibm.com>
Date: Mon, 11 May 2026 11:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: add gen-features.h dependency to
 s390x_system_ss
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20260510204640.2178926-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260510204640.2178926-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a01a155 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VgQHmgxU-P_RjVidJewA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ams2_PGv3vjEsTwUsQpxkazYP4QPq9cf
X-Proofpoint-ORIG-GUID: Ams2_PGv3vjEsTwUsQpxkazYP4QPq9cf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwMCBTYWx0ZWRfX9AtPeJyjbnfu
 sU0QJbayiDRLEdkJgVAs6ZYPkfHo5n5b2atnguSRDOLCHmqiBc/5Hy4ZrYHErUL+P17vE/G5cBi
 OZt1Q5ByWg41IHTwysbvfL/JT5UfD3TK/tfDoup0JDmkcQcmanoTgRkg26tEKJ9dOrl/Qz3SYXl
 8chf8N17k9ym91Jz00YkVTK51frWcGxYSm44BsbfTBA7BozR+8pxjl/ceSyO/mqv6Cs8NwNRHjH
 2fAD83gxsxr2YLHNYBtTq98wEilm2OeR+uPuUQlRZsWk/ha0sQvYZotLs/nnf3/JG0m+oNG+OGj
 h+4iVVbyKc0vYpdVqGFW+C61WmA2ZSFvsGOOIkMmG7BDq49G/S1a++MnK5Qahss9Qzg1I/iltf7
 LUHdoLP7gbxEBjy68WisMp65hQ11NE2kFdz2kvtx/sQpN1nGJ8bIeSDmoEsrFfnZu9/jTXRkgoU
 hFqzbIhcpO4OA9wuwtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110100
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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



On 5/10/26 22:46, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Commit 0b83acf2f05 moved gen_features_h from s390x_ss to
> s390x_common_ss. However s390x_system_ss (containing ioinst.c) was left
> without the dependency, causing a build race: it can be compiled before
> gen-features.h is generated (via cpu.h -> cpu_models.h -> cpu_features.h
> -> gen-features.h)
> 
> Add gen_features_h to s390x_system_ss to correct the build ordering.
> 
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   target/s390x/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
> index 44f58ac2919..bc4459e8ed7 100644
> --- a/target/s390x/meson.build
> +++ b/target/s390x/meson.build
> @@ -26,6 +26,7 @@ s390x_common_ss.add(files(
>     'gdbstub.c',
>   ))
>   
> +s390x_system_ss.add(gen_features_h)
>   s390x_system_ss.add(files(
>     'ioinst.c',
>   ))

The patch makes sense, but somehow I cannot reproduce the issue.
I would expect the following to do the trick:

$ make clean
$ make libqemu-s390x-softmmu.a.p/target_s390x_ioinst.c.o -j24

because if there is no dependency, then the header file will not be
generated and compiler will fail, but this actually succeeds.

