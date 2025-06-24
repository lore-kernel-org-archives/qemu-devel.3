Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37A0C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU5C2-0007NY-9d; Tue, 24 Jun 2025 11:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uU5Be-0007Il-I8; Tue, 24 Jun 2025 11:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uU5Bb-0002Dc-T1; Tue, 24 Jun 2025 11:03:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7IUNC009021;
 Tue, 24 Jun 2025 15:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nhUIss
 i9J6/JOzXa3AK8XYaZ6IZv9uvMhJvLkPiK3vE=; b=JfREZ95MWglvsxQnjmZm41
 9xjb+12FKxKguNVY8rE6zicKi/T0PiTZ7txq1dV2nSMsHS6wCEPviP7Ku2YJBq/n
 K32i6c2vzYX10yzq4ahzNBl1zGnn+iC8oTei9bydbQ6ImGr++iwxLB6cVqEkycTi
 VZc1v/TZ9pjP0lmMwkd9DRHC39ZtAOcMrhJLiIR16Kkvgb4zVs0jp2keVE3DRG0E
 VVlerYkQ+ysv36h+chfmU3oWTCGzkxOxUwq6Apss59xCCGLJs37vy2oGNCj/vLaA
 XP1WgiIq6G4xco8gYU98gmul9jitzPXuhfYSusSQABc3ttZOtWwUuY35aAyoS3bQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tsg18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 15:03:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55ODxERd006408;
 Tue, 24 Jun 2025 15:03:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82p4m07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 15:03:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55OF3hK222937884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 15:03:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3565E58065;
 Tue, 24 Jun 2025 15:03:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 962A458059;
 Tue, 24 Jun 2025 15:03:41 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 24 Jun 2025 15:03:41 +0000 (GMT)
Message-ID: <4cf2bc35-f735-43d6-9716-d449cfc43980@linux.ibm.com>
Date: Tue, 24 Jun 2025 11:03:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/28] Add boot-certificates to s390-ccw-virtio machine
 type option
To: Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-2-zycai@linux.ibm.com> <aEL0bVhOFaCQbiBS@redhat.com>
 <7451ec24-1e42-4fb7-8a6a-4b7fa7009452@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <7451ec24-1e42-4fb7-8a6a-4b7fa7009452@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zzD5GXCeBrQ6havNhf_ANS0FW71AJp0D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyNCBTYWx0ZWRfX5FpW7vczgTcV
 vk7v9uc/QpshAFdRUCnIYTgGG1bGShncvokEyg0KdtQyWAUV4HL2mEddehZi8ZdnpR18PqBP/8z
 UXPzDfHQ9Cjru6Mcre6zhSFkTO/b9uf6il6YN7fQjXbqCJSTdFztTl4vj9CmI6xClxbNL4M7Sfn
 4GJAGoJnUhd/EjXrnjQ/uWz2JQ3uGqlEANq5UZF5udZZ/ndm6TRx3y+21UMZXSTYdG0Xp+0+CHH
 lnU3WRD2hfqthG7+m0aFxg5GRK2HW0GJ9Rp36opMy/wmSgbFYpcq0vDU/RXAO82cGb7okiOEpGQ
 Gy7FAS360Ju0Y271UesFlzZkKZcNS8fbHo/edG/tPOVfb2ImB6NhixcIQgOZJualvcUxHn2IvPY
 oejSMCosBoiP+pvh4dhVr5HzFZiz0VLDNBzK5r7GcJX6cIfQvmMN41jaTSVx9VmEO+8IDRDa
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685abe51 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=XBQat7D4HaLM-cZr51sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zzD5GXCeBrQ6havNhf_ANS0FW71AJp0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=879 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240124
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/20/25 11:45 AM, Zhuoying Cai wrote:
> On 6/6/25 10:00 AM, Daniel P. Berrangé wrote:
>> On Wed, Jun 04, 2025 at 05:56:29PM -0400, Zhuoying Cai wrote:
>>> Add boot-certificates as a parameter of s390-ccw-virtio machine type option.
>>>
>>> The `boot-certificates=/path/dir:/path/file` parameter is implemented
>>> to provide path to either a directory or a single certificate.
>>>
>>> Multiple paths can be delineated using a colon.
>> How do users specify paths which contain a colon as a valid
>> character ?
>>
> It was suggested to separate lists of directories and files with a
> colon, following the convention used by the shell PATH variable. As the
> colon serves as a delimiter, it’s expected that individual paths do not
> contain any colon characters.

I'm not sure if I understand why this is needed.  Why would someone want 
to have the certificates in two distinct locations, as opposed to all in 
one directory or in sub-directories of a single main certificate 
directory? Supporting only one path would simplify both the 
implementation and the usage.  Could we just not allow multiple paths, 
or is there a use case that requires it?

> [snip..]
>

