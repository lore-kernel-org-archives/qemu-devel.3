Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178F2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6kR-0007Sk-Ak; Wed, 01 Jul 2026 22:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6kJ-0007RU-UG; Wed, 01 Jul 2026 22:01:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6kH-00019h-Qg; Wed, 01 Jul 2026 22:01:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KHi52450310; Thu, 2 Jul 2026 02:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L4p3TW
 VAxxZMWY3mtUmxYFb/Fz1rh2UM3yk2Za0elVw=; b=NOuqiHmNCCMIsN+ohNvn2b
 +SPh61WvrLZD4a0awoCFFfle+5OyfRhlPEUTCDkLaac+kE5iaY6TzLP83wEN24ly
 iccgGpyWFt2s2QgYsFz3esufJjPgCv47Nh3+W787pEnz03tCVc0zeYY5+Jx7ZLXy
 E2eyrJWhlqZfECj6caA+n2kmbOkPSnaKgzybjZXi+s8hdW+s5DE+akBvgEXdF3BO
 XgzUePEwWcG7lt1sYDTm7jRu4UIslL6wjKbwvbY/W2VTLv7s9D/dIknMtda6Plbo
 tnuogwSGLyoYyB0SfRj8YjYWfLqxgxacehsKam03O5pLnhhT3lmyeeFt2cJW3SUw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5ymca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:01:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621ngng012924;
 Thu, 2 Jul 2026 02:01:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wa2u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:01:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66221ZQE20382398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:01:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DA2D58062;
 Thu,  2 Jul 2026 02:01:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB03758059;
 Thu,  2 Jul 2026 02:01:33 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 02:01:33 +0000 (GMT)
Message-ID: <8af94524-dba8-4e2d-aa27-323ede3481dc@linux.ibm.com>
Date: Wed, 1 Jul 2026 22:01:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 22/35] pc-bios/s390-ccw: Introduce ZiplBootMode enum
 for IPL mode selection
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-23-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-23-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfXyDCUQ+Z/Un7j
 /tfZMMhSw16V2K5kjgXRDoYGnOLokzIBzek1ivNsuk9sLgyOchCXE3Gb+DwkRqUoLCFqXfhh3Ny
 70/dwTL0vxNcBT08kuoXCYv/5SctswbczuJvmByHdflowKg9TpD12zeJnw/JI7n7wWabOBZQgwV
 peorrL/5UTzVcf+p9C37Q2Abw+a4BES+29VAcGU26fS++6Gbz+DNqHffle7JfwXxMTRT99tqdYx
 6DVeXetO69jxEyYFprN2mAe3bFLh91YdzfObVX3l+1h0XlFqN5qqMZRG8DlMO57pTPh2qxQgGfV
 TJUNv6h3hYHuImz/zJGypChuk+yS0wMOAqRzv21thYhJm8ZyPvh3myXRjUhfRW68uEw/gfw5GP/
 NEB1qnUlzZzW3Gf0jvI1TKBiFWYK7ps+m5nW86eyoV1LqrCII0mEIJXuK/AIMBsjbb9ElkR8Vrq
 xCHcFNbPby73/G0WKQw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a45c681 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=mMgoN3YEOOTdy_fJs10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uiMfuKAfv7ACIvvLQ54WOvuLVWES3d92
X-Proofpoint-GUID: uiMfuKAfv7ACIvvLQ54WOvuLVWES3d92
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfXzPWyRJ/wwnRQ
 LUD+19zdIoT2xozox7IE2VeIvnGVzCd6NDsjd8xc6hAlEQHio3Z0gwNYmoLf/rLV2AoiiMTbvJ6
 uAVk9aOqoHspTeunLBMn+CsA0Ly2W6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020016
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Add ZiplBootMode enumeration to support multiple IPL boot configurations.
> Boot modes differentiate between normal boot and secure IPL operations,
> enabled based on boot certificates specified via the boot-certs option.
>
> Normal Mode: IPL when no certificates are provided. No signature
> verification is performed.
>
> This prepares for future secure IPL modes requiring signature
> verification.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst | 21 +++++++++++++++++++++
>   pc-bios/s390-ccw/bootmap.c       | 16 +++++++++++++++-
>   pc-bios/s390-ccw/main.c          |  6 ++++++
>   pc-bios/s390-ccw/s390-ccw.h      |  6 ++++++
>   4 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 88df52ce2f..9d7d33f5ed 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -18,3 +18,24 @@ Note: certificate files must have a .pem extension.
>   .. code-block:: shell
>   
>       qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> +
> +
> +IPL Modes
> +---------
> +
> +Multiple IPL modes are available to differentiate between the various IPL
> +configurations. These modes are mutually exclusive and enabled based on the
> +``boot-certs`` option on the QEMU command line.
> +
> +Normal Mode
> +^^^^^^^^^^^
> +
> +The absence of certificates will attempt to IPL a guest without secure IPL
> +operations. No checks are performed, and no warnings/errors are reported.
> +This is the default mode.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio ...
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index b19981feb1..667a69f80d 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -733,7 +733,14 @@ static int zipl_run(ScsiBlockPtr *pte)
>       /* Load image(s) into RAM */
>       entry = (ComponentEntry *)(&header[1]);
>   
> -    rc = zipl_run_normal(&entry, tmp_sec);
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_NORMAL:
> +        rc = zipl_run_normal(&entry, tmp_sec);
> +        break;
> +    default:
> +        panic("Unknown boot mode");
> +    }
> +
>       if (rc) {
>           return rc;
>       }
> @@ -1105,12 +1112,16 @@ void zipl_load(void)
>       VDev *vdev = virtio_get_device();
>   
>       if (vdev->is_cdrom) {
> +        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                   "Secure boot from ISO image is not supported!");
>           ipl_iso_el_torito();
>           puts("Failed to IPL this ISO image!");
>           return;
>       }
>   
>       if (virtio_get_device_type() == VIRTIO_ID_NET) {
> +        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                    "Virtio net boot device does not support secure boot!");
>           netmain();
>           puts("Failed to IPL from this network!");
>           return;
> @@ -1121,6 +1132,9 @@ void zipl_load(void)
>           return;
>       }
>   
> +    IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                "Secure boot with the ECKD scheme is not supported!");
> +
>       switch (virtio_get_device_type()) {
>       case VIRTIO_ID_BLOCK:
>           zipl_load_vblk();
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index b8f836c682..cd3d0776b0 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -30,6 +30,7 @@ IplParameterBlock *iplb;
>   bool have_iplb;
>   static uint16_t cutype;
>   LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
> +ZiplBootMode boot_mode;
>   
>   #define LOADPARM_PROMPT "PROMPT  "
>   #define LOADPARM_EMPTY  "        "
> @@ -303,6 +304,9 @@ static void ipl_ccw_device(void)
>       switch (cutype) {
>       case CU_TYPE_DASD_3990:
>       case CU_TYPE_DASD_2107:
> +        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
> +                    "Passthrough (vfio) CCW device does not support secure boot!");
> +
>           dasd_ipl(blk_schid, cutype);
>           break;
>       case CU_TYPE_VIRTIO:
> @@ -390,6 +394,8 @@ void main(void)
>           probe_boot_device();
>       }
>   
> +    boot_mode = ZIPL_BOOT_MODE_NORMAL;
> +
>       while (have_iplb) {
>           boot_setup();
>           if (have_iplb && find_boot_device()) {
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 1e1f71775e..5420443ad2 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -69,6 +69,12 @@ int sclp_read(char *str, size_t count);
>   /* bootmap.c */
>   void zipl_load(void);
>   
> +typedef enum ZiplBootMode {
> +    ZIPL_BOOT_MODE_NORMAL = 0,
> +} ZiplBootMode;
> +
> +extern ZiplBootMode boot_mode;
> +
>   /* jump2ipl.c */
>   void write_reset_psw(uint64_t psw);
>   int jump_to_IPL_code(uint64_t address);

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

