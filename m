Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74869C5516E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpUz6-00020c-As; Thu, 30 Jul 2026 13:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wpUz5-00020M-7e; Thu, 30 Jul 2026 13:55:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wpUz3-0004rf-J9; Thu, 30 Jul 2026 13:55:55 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UGlwJs3612736; Thu, 30 Jul 2026 17:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FIez5/
 vXENXQokqM17EHXzJXNpDenT9j5NZEj5oRbZQ=; b=gMaGxZJWryw2lASiDwLp4t
 I8zEV4lsXe5N5dW8m2PEPUsHfscCvoD3QIrW6wTTx3U6opB1NUuRMkzYBtv2676A
 h0oOsCNxC8G+wD7PlnNDrxdUHbvdCxKkaSvZlMq9B4smdbrgRZunf4JkMyAVtBXv
 jDzWR6ZamTDeygcXxqTBGvCy9OiVUKNU1/jZgsER/4RqtVMFkaW7b4z1ru/PSpbZ
 lHJitqRKhz96qJGnfBCZy7oFjSCqKWUZoKjOnWq7PCLgzWfjIIE4K8X5JYRytHy5
 w9DuiHjp+h2ccmlqPO2lohGKmRWAra2XKx+HMVOorr2p3XJGqYJam71F6BxgJ8IQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd889w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 17:55:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UHfLZD003576;
 Thu, 30 Jul 2026 17:55:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yc643-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 17:55:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UHtnvY64291090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 17:55:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1938358068;
 Thu, 30 Jul 2026 17:55:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF8A58055;
 Thu, 30 Jul 2026 17:55:48 +0000 (GMT)
Received: from [9.61.160.189] (unknown [9.61.160.189])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 17:55:47 +0000 (GMT)
Message-ID: <ff0cd092-fc3a-460a-b248-cac4f4462b5a@linux.ibm.com>
Date: Thu, 30 Jul 2026 13:55:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu] pc-bios/s390-ccw: Fix off-by-one errors with
 loadparm and boot entries
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 jdaley@linux.ibm.com, qemu-stable@nongnu.org
References: <20260728223013.4047042-1-jrossi@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260728223013.4047042-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FbkNVosUNVMYhBFgYA_hrL6P6UwWb3HM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEzMiBTYWx0ZWRfXyVSNsw5vsXDf
 PbqdvmbmZl59nvihnAefB65UijyEG4G2hvEUKHGU1D2tc2tlH9parGWZyIbYkuCf/cyCRmWTQbc
 4kq7m78/M93/BLqZ/Q0VpQIglyTOA7Y=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b9027 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=jI0MlVVz9VgUAqM4pM4A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEzMiBTYWx0ZWRfXzXnqytaTSgJD
 N9bQe7Rox2Ev7wK1GeOYvxYSHH9E87K+FxpFIrLzxVSVXt4gGvpCSD0CCUjXuPCStRUrNfdnyX2
 W9Ky+yIJYSWcfLxKvR96rGdxu5cKUBM5wbDmE3cu6C82xks/svbiCHSWVQBzfRJ57f/9+87C4WX
 Fy5M9m8FKCUwxLtpI3eyzid4dG3G1VhlSF6prCJ/p3LLtRxEVI4Rk2lJaMAIckzkSX070yXA9Ri
 7XtcE8rkRnk2PYXERJ7eDs7q8rdZ77537zOc/WRax+VynzU68l9VnIXcHf+iOrBpJJevHFNAOGc
 XCIWdo76mjLhVd7B1ydMR/gfuEj91+ed1YfQfNMGrMNriU/vCsFtKjxgQ83L7g9WzwuWNxUEsR5
 d0z3/shT+q3IW3Yw5iQW2IQj42tKPDc8vvOawoQrKNcPb5bjjTKGkpWG50YdCnqI664snGLyXTp
 8hfBtrukrTg3w4p+Ysg==
X-Proofpoint-GUID: FbkNVosUNVMYhBFgYA_hrL6P6UwWb3HM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300132
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 7/28/26 6:30 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The loadparm may optionally be used to select a boot entry, with the
> intended range being 0 through 31 inclusive, for a total of 32 entries.
> Previously, MAX_BOOT_ENTRIES was defined as 31, indicating that it was
> intended to correspond to the index of the boot entry rather than the
> count; however, some guards also used MAX_BOOT_ENTRIES as a count of the
> maximum allowed entries, which resulted in a mismatch between the intended
> and actual range such that index 31 could never be used in practice.
> 
> Move the definition of MAX_BOOT_ENTRIES to qipl.h so it is shared and
> change the value to 32, representing a count of the maximum number of
> allowed boot entries and allowing the loadparm to accept values 0 through
> 31 as intended.  Update some instances in the netboot code where
> MAX_BOOT_ENTRIES was used as the max index so that all guards treat
> MAX_BOOT_ENTRIES as a count across all boot methods.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 806315279d5c ("pc-bios/s390-ccw: Remove panics from ECKD IPL path")
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

Applied for 11.2; thank you!

> ---
>   include/hw/s390x/ipl/qipl.h |  2 ++
>   pc-bios/s390-ccw/netmain.c  | 11 +++++++----
>   pc-bios/s390-ccw/s390-ccw.h |  2 --
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 8d3c83a80b..b390f2f112 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -20,6 +20,8 @@
>   #define LOADPARM_LEN    8
>   #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>   
> +#define MAX_BOOT_ENTRIES  32
> +
>   enum S390IplType {
>       S390_IPL_TYPE_FCP = 0x00,
>       S390_IPL_TYPE_CCW = 0x02,
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 651cedf6ef..791854fce0 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -40,6 +40,9 @@
>   #define DEFAULT_BOOT_RETRIES 10
>   #define DEFAULT_TFTP_RETRIES 20
>   
> +/* Index 0 is reserved for default alias, start PXE cfg indices at 1 */
> +#define PXECFG_MAX              (MAX_BOOT_ENTRIES - 1)
> +
>   extern char _start[];
>   
>   #define KERNEL_ADDR             ((void *)0L)
> @@ -381,13 +384,13 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
>   
>   static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
>   {
> -    struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
> +    struct pl_cfg_entry entries[PXECFG_MAX];
>       int num_ent, def_ent = 0;
>   
>       num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
>                                         DEFAULT_TFTP_RETRIES,
>                                         cfgbuf, sizeof(cfgbuf),
> -                                      entries, MAX_BOOT_ENTRIES, &def_ent);
> +                                      entries, PXECFG_MAX, &def_ent);
>   
>       return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
>   }
> @@ -470,11 +473,11 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>            * a magic comment string.
>            */
>           if (!strncasecmp("# pxelinux", cfgbuf, 10)) {
> -            struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
> +            struct pl_cfg_entry entries[PXECFG_MAX];
>               int num_ent, def_ent = 0;
>   
>               num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
> -                                         MAX_BOOT_ENTRIES, &def_ent);
> +                                         PXECFG_MAX, &def_ent);
>               return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
>                                                 entries);
>           }
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 1e1f71775e..d0498e2944 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -82,8 +82,6 @@ int menu_get_enum_boot_index(bool *valid_entries);
>   bool menu_is_enabled_enum(void);
>   int menu_get_boot_index(bool *valid_entries);
>   
> -#define MAX_BOOT_ENTRIES  31
> -
>   __attribute__ ((__noreturn__))
>   static inline void panic(const char *string)
>   {


