Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CFBC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf4OU-0002Eg-Ok; Wed, 01 Jul 2026 19:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf4OM-000291-TV; Wed, 01 Jul 2026 19:30:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf4OK-0001CT-M4; Wed, 01 Jul 2026 19:30:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661LmZFD2030370; Wed, 1 Jul 2026 23:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PL9suj
 TC+Rsht+dfNDe0zDNVNo5SEROdxd7o21ReXKc=; b=MWx2+IKBDr3etq2uE3UCFA
 wZjfoslZe4nODv7dNrj7l5xUw0NDx7jvo9gAKDju2ItUJlaRngWVDQuatSINHyNK
 G/bbmMO6ZZ+Hy1zQJniFfATVEuuuERGWEc2FW8lFj0gkA48//f7zaSsjEZ3Uej4i
 Z3TFFqUaUVkqTysgujZqGLZaSXpvyvnT2rwxJFH2ddcMbwITk/9IMSIhBQJF1Dzj
 DlXsLF2bdPOdtdB519+ctEcabIJhh0Tarmf+wVm1C5v4VF1z7bcxA2cn3fBwpBbV
 gRUNkz3dmTv/kTAasoklEqCc3lzWQ6xpZyzHNbxAS9EttD5Bb2teccJkPk/MaKxA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5y5tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 23:30:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661NJkHj024779;
 Wed, 1 Jul 2026 23:30:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9nq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 23:30:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661NUc7N18088570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 23:30:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB50758058;
 Wed,  1 Jul 2026 23:30:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A416A5805D;
 Wed,  1 Jul 2026 23:30:37 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  1 Jul 2026 23:30:37 +0000 (GMT)
Message-ID: <dbd14a70-ec58-4286-9ff3-a7687ab48f3c@linux.ibm.com>
Date: Wed, 1 Jul 2026 19:30:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/35] Add boot-certs to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-2-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDI1MCBTYWx0ZWRfX7rwM0qjMX5rr
 Iojtuvo1jTPelCfYwG/Ic3oTdNetr2FLwyN92ElG8awT2Nm4wNNL4ctQ0mzjR4ClFNs8Dtg+rud
 YdBpGJF2vshnynUoyjXP+QAj94qto6/xBkBAvdXhBniuDAf75hTjxlmeIKqdZJkZEcOiFaxW5Mu
 v2Ylxj1LD0WV3Tb8h8z8H89CojacFT+NXtD0twqQock51ILeGqPMCAdB3LQmY1iFeTkyPLCDc5i
 R3AFa3Gu6NMOSP6ddQU4C03RT64RE3VbgFMyIVTJ6Rn8Yezy/6q8Ys3j569w/wj7JpDnHQQMaQl
 5H0ketLpHVKBR6iQ11ayQT/lFkX0rF59+FgFfxoRVGHJsiIFOR9zI/cZykDAmHrO9dZn2xjW7Ar
 mEgqrewhdAvyTicguZq7KK0plk0MnXc7hFrtHR8EPeAKPnvLNm3FdAZxyEDmctdwGlLr6yS1ofc
 w4cBJs0FjYpVjCmX5dw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a45a321 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=w1qOSc81J2aSfisK2LwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nHNPlILwh_XeUeXZPbfihL-8h-pHFLMF
X-Proofpoint-GUID: nHNPlILwh_XeUeXZPbfihL-8h-pHFLMF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDI1MCBTYWx0ZWRfX/4oJPSiG/v5s
 W5xr0okkmtvuO3ClphLk51IjqFZHbR/IrWu+3NF9ia1b+RphWOOfrf2bnNxLA4a+Vbb1li9DqTw
 DpJlyNXuoFxJf9yBh4dbH63ETcxtju4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010250
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/1/26 4:48 PM, Zhuoying Cai wrote:
> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
> machine. This allows users to specify one or more certificate file paths
> or directories to be used during secure boot.
The new boot-certs option is able to handle complex certificate 
organization across multiple directories, but it seems to reject the 
most basic case of passing a single directory path.

E.g. using: -machine s390-ccw-virtio,accel=kvm,boot-certs=/root/certs

produces the error: "Invalid parameter type for 'boot-certs', expected: 
array"

I understand that this can be fixed by expanding "boot-certs" to 
"boot-certs.0.path" however this does not seem intuitive to me. Is this 
the expected behavior by design?

Regards,
Jared Rossi

> Each entry is specified using the syntax:
> 	boot-certs.<index>.path=/path/to/cert.pem
>
> Multiple paths can be specify using array properties:
> 	boot-certs.0.path=/path/to/cert.pem,
> 	boot-certs.1.path=/path/to/cert-dir,
> 	boot-certs.2.path=/path/to/another-dir...
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
>   docs/system/target-s390x.rst       |  1 +
>   hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>   include/hw/s390x/s390-virtio-ccw.h |  2 ++
>   qapi/machine-s390x.json            | 23 +++++++++++++++++++++++
>   qapi/pragma.json                   |  1 +
>   qemu-options.hx                    |  6 +++++-
>   7 files changed, 82 insertions(+), 1 deletion(-)
>   create mode 100644 docs/system/s390x/secure-ipl.rst
>
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> new file mode 100644
> index 0000000000..88df52ce2f
> --- /dev/null
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -0,0 +1,20 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Secure IPL Command Line Options
> +-------------------------------
> +
> +The s390-ccw-virtio machine type supports secure IPL. These parameters allow
> +users to provide certificates and enable secure IPL directly via the command
> +line.
> +
> +Providing Certificates
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +The certificate store can be populated by supplying a list of X.509 certificate
> +file paths or directories containing certificate files on the command-line:
> +
> +Note: certificate files must have a .pem extension.
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
> index 94c981e732..8938a13d10 100644
> --- a/docs/system/target-s390x.rst
> +++ b/docs/system/target-s390x.rst
> @@ -35,3 +35,4 @@ Architectural features
>      s390x/bootdevices
>      s390x/protvirt
>      s390x/cpu-topology
> +   s390x/secure-ipl
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 25a9fa4955..b3c96ba35b 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -44,6 +44,7 @@
>   #include "target/s390x/kvm/pv.h"
>   #include "migration/blocker.h"
>   #include "qapi/visitor.h"
> +#include "qapi/qapi-visit-machine-s390x.h"
>   #include "hw/s390x/cpu-topology.h"
>   #include "kvm/kvm_s390x.h"
>   #include "hw/virtio/virtio-md-pci.h"
> @@ -788,6 +789,30 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>       g_free(val);
>   }
>   
> +static void machine_get_boot_certs(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +    BootCertificatesList **certs = &ms->boot_certs;
> +
> +    visit_type_BootCertificatesList(v, name, certs, errp);
> +}
> +
> +static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +    BootCertificatesList *cert_list = NULL;
> +
> +    visit_type_BootCertificatesList(v, name, &cert_list, errp);
> +    if (!cert_list) {
> +        return;
> +    }
> +
> +    ms->boot_certs = cert_list;
> +}
> +
>    /*
>     * S390x-specific global compatibility properties.
>     *
> @@ -856,6 +881,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>               "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>               " to upper case) to pass to machine loader, boot manager,"
>               " and guest kernel");
> +
> +    object_class_property_add(oc, "boot-certs", "BootCertificatesList",
> +                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
> +    object_class_property_set_description(oc, "boot-certs",
> +            "provide paths to a directory and/or a certificate file for secure boot");
>   }
>   
>   static inline void s390_machine_initfn(Object *obj)
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index f1f06119d6..5ad1ea2f24 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -14,6 +14,7 @@
>   #include "hw/core/boards.h"
>   #include "qom/object.h"
>   #include "hw/s390x/sclp.h"
> +#include "qapi/qapi-types-machine-s390x.h"
>   
>   #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
>   
> @@ -31,6 +32,7 @@ struct S390CcwMachineState {
>       uint8_t loadparm[8];
>       uint64_t memory_limit;
>       uint64_t max_pagesize;
> +    BootCertificatesList *boot_certs;
>   
>       SCLPDevice *sclp;
>   };
> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index ea430e1b88..bbe3646e91 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -140,3 +140,26 @@
>   { 'event': 'SCLP_CPI_INFO_AVAILABLE',
>     'features': [ 'unstable' ]
>   }
> +
> +##
> +# @BootCertificates:
> +#
> +# Boot certificates for secure IPL.
> +#
> +# @path: path to an X.509 certificate file or a directory containing
> +#      certificate files.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'BootCertificates',
> +  'data': {'path': 'str'} }
> +
> +##
> +# @DummyBootCertificates:
> +#
> +# Not used by QMP; hack to let us use BootCertificatesList internally.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'DummyBootCertificates',
> +  'data': {'unused-boot-certs': ['BootCertificates'] } }
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 24aebbe8f5..342cedc42e 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -49,6 +49,7 @@
>           'DisplayProtocol',
>           'DriveBackupWrapper',
>           'DummyBlockCoreForceArrays',
> +        'DummyBootCertificates',
>           'DummyForceArrays',
>           'DummyVirtioForceArrays',
>           'HotKeyMod',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e44b47de68..83915bd7ef 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -46,7 +46,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>       "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>       "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
>       "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
> -    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
> +    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
> +    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
>       QEMU_ARCH_ALL)
>   SRST
>   ``-machine [type=]name[,prop=value[,...]]``
> @@ -214,6 +215,9 @@ SRST
>           ::
>   
>               -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
> +
> +    ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
> +        Provide paths to a directory and/or a certificate file on the host [s390x only].
>   ERST
>   
>   DEF("M", HAS_ARG, QEMU_OPTION_M,


