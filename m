Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B33FC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 15:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSdwA-0001nU-7O; Fri, 20 Jun 2025 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uSdw7-0001lg-K8; Fri, 20 Jun 2025 11:45:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uSdw4-00028F-8c; Fri, 20 Jun 2025 11:45:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K9fv62003039;
 Fri, 20 Jun 2025 15:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=q7uWgi
 RrTwJ0Ng/X8aURzI9miPUCSmSoj283XrkZeFI=; b=XuG9hbAnlIdh3aW3guPQDv
 ugcitsNMi23VIBcr6hXEWnHkD6yjXi6Cak3lM1FxCuGOAhYCnpBTPC5KCQM68w+q
 wVWoNFUeBuMY7WXx8taGmIA7HAaxdlomjvn9dtDQEJ0Em6W0D0zZhEGpYHoy8riX
 BtcbcKI25QVH5qFlef8riDXthLjtsTXjnho1i1czd6d0TdOWV3qY5bMTbBY8WQxk
 4XiUh1bUHRtA9PFgqVBwpWt8Yzcd8DistgPi+fAJoAm13uwoDBpUbBBwRnpxxMVn
 v/kmDw7cjmLa8iHtKBE83hDX8osgNzBGJfV0kjS/qJ7IkBjsL/rV7xWwXR85Xi+A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47beeta8cf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 15:45:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCVBvM010853;
 Fri, 20 Jun 2025 15:45:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtv46n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 15:45:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55KFjcWt66847094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Jun 2025 15:45:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD69458057;
 Fri, 20 Jun 2025 15:45:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9DE558058;
 Fri, 20 Jun 2025 15:45:37 +0000 (GMT)
Received: from [9.61.49.33] (unknown [9.61.49.33])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 20 Jun 2025 15:45:37 +0000 (GMT)
Message-ID: <7451ec24-1e42-4fb7-8a6a-4b7fa7009452@linux.ibm.com>
Date: Fri, 20 Jun 2025 11:45:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/28] Add boot-certificates to s390-ccw-virtio machine
 type option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-2-zycai@linux.ibm.com> <aEL0bVhOFaCQbiBS@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <aEL0bVhOFaCQbiBS@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ake9q5OTmtz0ZxlK3n4BFOY-kJvBEWoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwOSBTYWx0ZWRfXwdh/jZMN4nj5
 oSlrTUkQHBKZOLqWJ7yzKsyVU+UMShacgE4RKVya4rK7jwmahx3sQQ6bmFCK8oZJyunTdC8Xy6k
 m3crjmTSoIwgIPoZiXouys43xWsoylSjE1UbYDZGuAhq8DGGA082X35VFzrq7M2b/W/vMkNWxBX
 i2Ft4LB1cZRr+5jnoW5r1RPblXAsez+bw1BEv5ZBKFaQER8xkVK+36vlprWOTAder92WEHWYZSx
 0ltAg6hXWFpFEsEPHZFdku8KcN2DoHYz867nHfN01x137qmTny87lUgu6a7nNZMzba1YgY+bZex
 cUj9H9u7iARJZnkljzYf4v9Ruj23M1MurOfETeMQgbW+EcUXh+po31lirknYA9lcs9yNYO+CXDg
 5W2HZoWunTa/wRxxebXQ6rqcWWAc1rwWQUMKorF8kd3Zo7kPVhh+IFvPGlidE7qYvzYdp+p0
X-Authority-Analysis: v=2.4 cv=PrSTbxM3 c=1 sm=1 tr=0 ts=68558225 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Uu-oxMWvNaNqOFKj1Q8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ake9q5OTmtz0ZxlK3n4BFOY-kJvBEWoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 6/6/25 10:00 AM, Daniel P. Berrangé wrote:
> On Wed, Jun 04, 2025 at 05:56:29PM -0400, Zhuoying Cai wrote:
>> Add boot-certificates as a parameter of s390-ccw-virtio machine type option.
>>
>> The `boot-certificates=/path/dir:/path/file` parameter is implemented
>> to provide path to either a directory or a single certificate.
>>
>> Multiple paths can be delineated using a colon.
> 
> How do users specify paths which contain a colon as a valid
> character ?
> 

It was suggested to separate lists of directories and files with a
colon, following the convention used by the shell PATH variable. As the
colon serves as a delimiter, it’s expected that individual paths do not
contain any colon characters.

> Ideally we should be using array properties when we need
> a list of parameters.
> 

Could you provide an example of specifying the boot-certificate
parameter with the -machine option using array properties?

>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
>>  include/hw/s390x/s390-virtio-ccw.h |  1 +
>>  qemu-options.hx                    |  7 ++++++-
>>  3 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index f20e02de9f..144ef52f34 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -798,6 +798,22 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>>      g_free(val);
>>  }
>>  
>> +static inline char *machine_get_boot_certificates(Object *obj, Error **errp)
>> +{
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> +
>> +    return g_strdup(ms->boot_certificates);
>> +}
>> +
>> +static void machine_set_boot_certificates(Object *obj, const char *str,
>> +                                          Error **errp)
>> +{
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> +
>> +    g_free(ms->boot_certificates);
>> +    ms->boot_certificates = g_strdup(str);
>> +}
>> +
>>  static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -851,6 +867,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>              "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>>              " to upper case) to pass to machine loader, boot manager,"
>>              " and guest kernel");
>> +
>> +    object_class_property_add_str(oc, "boot-certificates",
>> +                                  machine_get_boot_certificates,
>> +                                  machine_set_boot_certificates);
>> +    object_class_property_set_description(oc, "boot-certificates",
>> +            "provide path to a directory or a single certificate for secure boot");
>>  }
>>  
>>  static inline void s390_machine_initfn(Object *obj)
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>> index 526078a4e2..45adc8bce6 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -31,6 +31,7 @@ struct S390CcwMachineState {
>>      uint8_t loadparm[8];
>>      uint64_t memory_limit;
>>      uint64_t max_pagesize;
>> +    char *boot_certificates;
>>  
>>      SCLPDevice *sclp;
>>  };
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 7eb8e02b4b..6d01f8c4b2 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>  #endif
>>      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
>> -    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
>> +    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
>> +    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n",
>>      QEMU_ARCH_ALL)
>>  SRST
>>  ``-machine [type=]name[,prop=value[,...]]``
>> @@ -200,6 +201,10 @@ SRST
>>          ::
>>  
>>              -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
>> +
>> +    ``boot-certificates='/path/directory:/path/file'``
>> +        Provide a path to a directory or a boot certificate on the host [s390x only].
>> +        A colon may be used to delineate multiple paths.
>>  ERST
>>  
>>  DEF("M", HAS_ARG, QEMU_OPTION_M,
>> -- 
>> 2.49.0
>>
> 
> With regards,
> Daniel


