Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B641C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 20:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2yYh-0007Fa-EL; Thu, 10 Apr 2025 16:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u2yYf-0007FE-QG; Thu, 10 Apr 2025 16:31:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u2yYd-0006Q2-KH; Thu, 10 Apr 2025 16:31:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AEEDu0003370;
 Thu, 10 Apr 2025 20:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=W6uXh/5kSV+xK5ODIKr3pQ/1xYvca3
 +v7RTjxYM3G3k=; b=h96PWFwEaJFBkMQh34hkkFAzgTyeRt+cUpJZnt7BlRCQl5
 E+6AFyt9mcUSb2UFXArvmZhGuaTwdufBbFME/sIyrpD1pzvzRRZzRj0bGkGqV5EY
 w5yDGZMO0pRycwqQ2tw02/uYffSRtlYsPmBS/kHYK+3t+Ug36gcUooGi/1sw5LbL
 JHODOAGuDsnfq0izQrsnmy0jwysx+jjMHt/0MIruy0Typ7CuAFQyCXJKl7Ltqcst
 l/Hzarj5LFG9Q6Hl17oyW9J20AoyERewKlz2B5qNr6i816yMuYApJYeKUiwJaTvM
 ljOlm3e+ZUYU5NMEN67hy/B4kcAGOMd3iCkaLvsQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0407334-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 20:31:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AK9EK5011069;
 Thu, 10 Apr 2025 20:31:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf8001gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 20:31:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53AKVQ066750896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 20:31:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C2F05803F;
 Thu, 10 Apr 2025 20:31:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38F455804E;
 Thu, 10 Apr 2025 20:31:25 +0000 (GMT)
Received: from [9.61.248.229] (unknown [9.61.248.229])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Apr 2025 20:31:25 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------JNdcodw6pjRf0fENWKuGkZug"
Message-ID: <ed45e437-5534-4ace-8a7e-196860b43cde@linux.ibm.com>
Date: Thu, 10 Apr 2025 16:31:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rorie Reyes <rreyes@linux.ibm.com>
Subject: Re: [RFC PATCH v4 5/5] s390: implementing CHSC SEI for AP config
 change
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
 <20250311151616.98244-6-rreyes@linux.ibm.com>
 <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
Content-Language: en-US
In-Reply-To: <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NJy3tkLEhA3w5K0et3C8njw7cXyIj1ed
X-Proofpoint-GUID: NJy3tkLEhA3w5K0et3C8njw7cXyIj1ed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------JNdcodw6pjRf0fENWKuGkZug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/17/25 9:41 AM, Thomas Huth wrote:
> On 11/03/2025 16.16, Rorie Reyes wrote:
>> Handle interception of the CHSC SEI instruction for requests
>> indicating the guest's AP configuration has changed.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   target/s390x/ioinst.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>> index a944f16c25..f061c6db14 100644
>> --- a/target/s390x/ioinst.c
>> +++ b/target/s390x/ioinst.c
>> @@ -17,6 +17,7 @@
>>   #include "trace.h"
>>   #include "hw/s390x/s390-pci-bus.h"
>>   #include "target/s390x/kvm/pv.h"
>> +#include "hw/s390x/ap-bridge.h"
>>     /* All I/O instructions but chsc use the s format */
>>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t 
>> ipb,
>> @@ -573,13 +574,19 @@ out:
>>     static int chsc_sei_nt0_get_event(void *res)
>>   {
>> -    /* no events yet */
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        return ap_chsc_sei_nt0_get_event(res);
>> +    }
>> +
>>       return 1;
>>   }
>>     static int chsc_sei_nt0_have_event(void)
>>   {
>> -    /* no events yet */
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        return ap_chsc_sei_nt0_have_event();
>> +    }
>> +
>>       return 0;
>>   }
>
>  Hi!
>
> This unfortunately fails to link when configuring QEMU with the 
> "--without-default-devices" configure switch:
>
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_ioinst.c.o: in 
> function `ioinst_handle_chsc':
> /tmp/qemu-mini/target/s390x/ioinst.c:587:(.text+0x1ce1): undefined 
> reference to `ap_chsc_sei_nt0_have_event'
> /usr/bin/ld: /tmp/qemu-mini/target/s390x/ioinst.c:578:(.text+0x1d1c): 
> undefined reference to `ap_chsc_sei_nt0_get_event'
> collect2: error: ld returned 1 exit status
>
> I guess you have to rather use some callback mechanism, stubs or 
> #ifdefs here instead.
>
>  Thomas
>
Hey Thomas,

Sorry for the delay. I was trying out some ways to resolve this issue 
but I'm not sure what I would use for the macro name if I were to

go the #ifdef route. I had something roughly like this but it wasn't 
working. Would you have any recommendations?

static int chsc_sei_nt0_get_event(void *res) { #ifdef 
HW_S390X_AP_BRIDGE_H if (s390_has_feat(S390_FEAT_AP)) { return 
ap_chsc_sei_nt0_get_event(res); } #endif return 1; } static int 
chsc_sei_nt0_have_event(void) { #ifdef HW_S390X_AP_BRIDGE_H if 
(s390_has_feat(S390_FEAT_AP)) { return ap_chsc_sei_nt0_have_event(); } 
#endif return 0; }

--------------JNdcodw6pjRf0fENWKuGkZug
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/17/25 9:41 AM, Thomas Huth wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com">On
      11/03/2025 16.16, Rorie Reyes wrote: <br>
      <blockquote type="cite">Handle interception of the CHSC SEI
        instruction for requests <br>
        indicating the guest's AP configuration has changed. <br>
        <br>
        Signed-off-by: Rorie Reyes <a class="moz-txt-link-rfc2396E"
          href="mailto:rreyes@linux.ibm.com">&lt;rreyes@linux.ibm.com&gt;</a>
        <br>
        Reviewed-by: Anthony Krowiak <a class="moz-txt-link-rfc2396E"
          href="mailto:akrowiak@linux.ibm.com">&lt;akrowiak@linux.ibm.com&gt;</a>
        <br>
        Tested-by: Anthony Krowiak <a class="moz-txt-link-rfc2396E"
          href="mailto:akrowiak@linux.ibm.com">&lt;akrowiak@linux.ibm.com&gt;</a>
        <br>
        --- <br>
          target/s390x/ioinst.c | 11 +++++++++-- <br>
          1 file changed, 9 insertions(+), 2 deletions(-) <br>
        <br>
        diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c <br>
        index a944f16c25..f061c6db14 100644 <br>
        --- a/target/s390x/ioinst.c <br>
        +++ b/target/s390x/ioinst.c <br>
        @@ -17,6 +17,7 @@ <br>
          #include "trace.h" <br>
          #include "hw/s390x/s390-pci-bus.h" <br>
          #include "target/s390x/kvm/pv.h" <br>
        +#include "hw/s390x/ap-bridge.h" <br>
            /* All I/O instructions but chsc use the s format */ <br>
          static uint64_t get_address_from_regs(CPUS390XState *env,
        uint32_t ipb, <br>
        @@ -573,13 +574,19 @@ out: <br>
            static int chsc_sei_nt0_get_event(void *res) <br>
          { <br>
        -    /* no events yet */ <br>
        +    if (s390_has_feat(S390_FEAT_AP)) { <br>
        +        return ap_chsc_sei_nt0_get_event(res); <br>
        +    } <br>
        + <br>
              return 1; <br>
          } <br>
            static int chsc_sei_nt0_have_event(void) <br>
          { <br>
        -    /* no events yet */ <br>
        +    if (s390_has_feat(S390_FEAT_AP)) { <br>
        +        return ap_chsc_sei_nt0_have_event(); <br>
        +    } <br>
        + <br>
              return 0; <br>
          } <br>
      </blockquote>
      <br>
       Hi! <br>
      <br>
      This unfortunately fails to link when configuring QEMU with the
      "--without-default-devices" configure switch: <br>
      <br>
      /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_ioinst.c.o: in
      function `ioinst_handle_chsc': <br>
      /tmp/qemu-mini/target/s390x/ioinst.c:587:(.text+0x1ce1): undefined
      reference to `ap_chsc_sei_nt0_have_event' <br>
      /usr/bin/ld:
      /tmp/qemu-mini/target/s390x/ioinst.c:578:(.text+0x1d1c): undefined
      reference to `ap_chsc_sei_nt0_get_event' <br>
      collect2: error: ld returned 1 exit status <br>
      <br>
      I guess you have to rather use some callback mechanism, stubs or
      #ifdefs here instead. <br>
      <br>
       Thomas <br>
      <br>
    </blockquote>
    <p>Hey Thomas,</p>
    <p>Sorry for the delay. I was trying out some ways to resolve this
      issue but I'm not sure what I would use for the macro name if I
      were to</p>
    <p>go the #ifdef route. I had something roughly like this but it
      wasn't working. Would you have any recommendations?<br>
      <br>
      <span
style="color: rgb(29, 28, 29); font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(29, 28, 29, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">static int chsc_sei_nt0_get_event(void *res)
{
#ifdef HW_S390X_AP_BRIDGE_H
    if (s390_has_feat(S390_FEAT_AP)) {
        return ap_chsc_sei_nt0_get_event(res);
    }
#endif
    return 1;
}

static int chsc_sei_nt0_have_event(void)
{
#ifdef HW_S390X_AP_BRIDGE_H
    if (s390_has_feat(S390_FEAT_AP)) {
        return ap_chsc_sei_nt0_have_event();
    }
#endif
    return 0;
}</span> </p>
  </body>
</html>

--------------JNdcodw6pjRf0fENWKuGkZug--


