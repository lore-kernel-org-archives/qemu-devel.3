Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A09C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x15WZ-0003dB-3b; Mon, 31 Aug 2026 13:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15WW-0003ci-SR; Mon, 31 Aug 2026 13:10:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15WU-0003Fl-Q7; Mon, 31 Aug 2026 13:10:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VG1RnB2743348; Mon, 31 Aug 2026 17:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=TsuXR+pJBnP/Ao4QZWHI9wa+TOK9q2
 L8AUEPclHR+ng=; b=lLbh10PZQ3x/tHiM2MN0L6mv4IuSqxJ8JE9Dv2NLIFvCHN
 M+9VKOu6OeNR+XTXzShzucUJwU4z+OSpTlzbTCG3DpwQH8kqYZdcwEelqK1mOO/Z
 I+7H0GKglOWmO3v/QjkoYT6OlxfXsO2/RHl0D6ZUMF6aitqOL2XdInfR58oFlf+N
 t5auckD9d/VoPLGz5h/9ljfNHNdlQT7tABCBonPdYL6a4sjH1grBWkI2SDw5ktSS
 bMiJzOQdCpP5tcnaSgPlNvW7TSwsBGxFttogGUqCZfaGVhWz+kkOxuIawAAJq46T
 pqR+CMbNLPMBoY01rp6KukIxwJdMEgyoXgRQo/7A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54jrqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:10:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VGuGYr028676;
 Mon, 31 Aug 2026 17:10:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq79jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:10:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VHA4uE5964398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 17:10:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4E1A58065;
 Mon, 31 Aug 2026 17:10:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44CE358056;
 Mon, 31 Aug 2026 17:09:58 +0000 (GMT)
Received: from [9.43.79.120] (unknown [9.43.79.120])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 17:09:57 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------G3KcogNSrEs0XibCUnUwgHJD"
Message-ID: <4fd7316d-9a70-4074-bf12-3d89d1575470@linux.vnet.ibm.com>
Date: Mon, 31 Aug 2026 22:39:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] pnv/phb5: Implement write-clear and return 1's on
 unimplemented reg read
To: Aditya Gupta <adityag@linux.ibm.com>, Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-6-saif.abrar@linux.ibm.com>
 <aljQz3yux9eLr68H@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <aljQz3yux9eLr68H@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX6puy31CDyoTi
 vatW9VVvCKIwWCb/AwhaOGpMaPfOJwHLearB38WO34WC2e5aw58AIZFE3C+/Z6mPU9SbCLhYTbp
 1NnLaatUgAATyy4WHb3upCXb7DSLC2Vt9Zz+TCVKB8DxOCm/ZXsTm4TXeNIy1wLGMQWBhCyq1vX
 Xs0x3FsmFJfTBe5WA64IAmRhPT6MIx1jYYb1zEmaB8RFGjaDgb7ropckIgkSzjdxSflOna3LHkN
 GhHSThycZKM6SaeHit2y3MH+p1dGOdWyGB7/tw/T5dmHbwLUYPB/qrkZ38SoSePkqNHV7hnoXmF
 OKnGLR4NwzVk6Aewlp5XlyNGbgGFXLvsx5rWzKCCUy4fm2YWdg/RfRyNj2mTzdcgTAx8Cbwmyns
 qL2AhoYbYyrAlwtVRcJv9Uxnl801SbUHjAgY1kzzNND8k8eLZ2IxcX9E5Hthaf4c1FjQKK1bZaF
 Dhg8U0WvOvi41EN3lHg==
X-Proofpoint-ORIG-GUID: zUzqYFr4gG_KVYFHCoyQP1GOQYfNercm
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95b570 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=xIFDG7mMh4kwqAeel0kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8 a=ZFQ4W_TumASF_08ED1YA:9
 a=_gr1ixP96QugBaqV:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: UTYNyT2H32cXZRjuQbYpW5rjGToiG5BR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX3F3elNY/CXIO
 4q+mr08q2xFLvAc+2svTxWPOJhM1q8g4iG6uz1YQuD5/6C6DgLtWHrx3je94NFEQIQ0anHDOU4E
 0soV9zHcxrNjM+bHjcB6PWZEcvCo0LI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310147
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------G3KcogNSrEs0XibCUnUwgHJD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 16-07-2026 18:19, Aditya Gupta wrote:
> On 26/06/17 04:50AM, Saif Abrar wrote:
>> <...snip...>
>>
>> @@ -724,6 +762,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>>               pnv_phb4_update_all_msi_regions(phb);
>>           }
>>           break;
>> +
>>       case PHB_M32_START_ADDR:
>>       case PHB_M64_UPPER_BITS:
>>           if (changed) {
>> @@ -771,27 +810,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>>           break;
>>   
>>       /* Silent simple writes */
>> -    case PHB_ASN_CMPM:
>> -    case PHB_CONFIG_ADDRESS:
>> -    case PHB_IODA_ADDR:
>> -    case PHB_TCE_KILL:
>> -    case PHB_TCE_SPEC_CTL:
>> -    case PHB_PEST_BAR:
>> -    case PHB_PELTV_BAR:
> Few of these are not handled in new code, like ASN_CMPM.
>
> As you said in v4 that these are removed in PHB5 spec. The ASN_CMPM in
> particular was anyways a silent skip, and now it will turn up as
> unimplemented.
>
> With separation of phb5, i will let you remove them or keep them as
> silent skip for phb4.
>
> Can you also check if there are any other such regs which may have been
> skipped ?


Separate methods for PHB4 and PHB5 read/write are now handling such issues.

e.g.

Read/write to registers that are present in PHB4 and removed from PHB5 are

read/written as usual in PHB4 but flag an error in PHB5. ASN_CMPM is 
also added back to PHB4.

Registers that are new in PHB5 are read/written within PHB5 accordingly.

>
>> --- a/tests/qtest/pnv-phb-test.c
>> +++ b/tests/qtest/pnv-phb-test.c
>> @@ -88,11 +88,10 @@ static void phb5_sticky_rst_test(QTestState *qts)
>>       g_assert_cmpuint(val, ==, (PPC_BITMASK(24, 27) | PPC_BITMASK(36, 37) |
>>                        PPC_BITMASK(39, 45) | PPC_BITMASK(47, 48) |
>>                        PPC_BITMASK(52, 54)));
>> -
>>   }
>>   
>>   /* Check that write-only bits/regs return 0 when read */
>> -static void phb4_writeonly_read_test(QTestState *qts)
>> +static void phb5_writeonly_read_test(QTestState *qts)
>>   {
>>       uint64_t val;
>>   
>> @@ -143,6 +142,12 @@ static void phb4_writeonly_read_test(QTestState *qts)
>>       g_assert_cmpuint(val, ==, 0x0);
>>   }
>>   
>> +/* Check that reading an unimplemented address 0x0 returns -1 */
>> +static void phb5_unimplemented_read_test(QTestState *qts)
>> +{
>> +    g_assert_cmpint(PHB5_XSCOM_READ(0x0), ==, -1);
>> +}
>> +
>>   static void phb5_tests(void)
>>   {
>>       QTestState *qts = NULL;
>> @@ -156,7 +161,10 @@ static void phb5_tests(void)
>>       phb5_sticky_rst_test(qts);
>>   
>>       /* Check write-only logic */
>> -    phb4_writeonly_read_test(qts);
>> +    phb5_writeonly_read_test(qts);
> With PHB5 separated out from PHB4, let's keep phb4_writeonly_read_test
> also.
>
> Thanks,
> - Aditya G
--------------G3KcogNSrEs0XibCUnUwgHJD
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
    <div class="moz-cite-prefix">On 16-07-2026 18:19, Aditya Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:aljQz3yux9eLr68H@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">On 26/06/17 04:50AM, Saif Abrar wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&lt;...snip...&gt;

@@ -724,6 +762,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
             pnv_phb4_update_all_msi_regions(phb);
         }
         break;
+
     case PHB_M32_START_ADDR:
     case PHB_M64_UPPER_BITS:
         if (changed) {
@@ -771,27 +810,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         break;
 
     /* Silent simple writes */
-    case PHB_ASN_CMPM:
-    case PHB_CONFIG_ADDRESS:
-    case PHB_IODA_ADDR:
-    case PHB_TCE_KILL:
-    case PHB_TCE_SPEC_CTL:
-    case PHB_PEST_BAR:
-    case PHB_PELTV_BAR:
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Few of these are not handled in new code, like ASN_CMPM.

As you said in v4 that these are removed in PHB5 spec. The ASN_CMPM in
particular was anyways a silent skip, and now it will turn up as
unimplemented.

With separation of phb5, i will let you remove them or keep them as
silent skip for phb4.

Can you also check if there are any other such regs which may have been
skipped ?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Separate methods for PHB4 and PHB5 read/write are now handling
      such issues.</p>
    <p>e.g.</p>
    <p>Read/write to registers that are present in PHB4 and removed from
      PHB5 are </p>
    <p>read/written as usual in PHB4 but flag an error in PHB5. <span
      style="white-space: pre-wrap">ASN_CMPM is also added back to PHB4.</span></p>
    <p>Registers that are new in PHB5 are read/written within PHB5
      accordingly.</p>
    <pre wrap="" class="moz-quote-pre">
</pre>
    <blockquote type="cite"
cite="mid:aljQz3yux9eLr68H@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">--- a/tests/qtest/pnv-phb-test.c
+++ b/tests/qtest/pnv-phb-test.c
@@ -88,11 +88,10 @@ static void phb5_sticky_rst_test(QTestState *qts)
     g_assert_cmpuint(val, ==, (PPC_BITMASK(24, 27) | PPC_BITMASK(36, 37) |
                      PPC_BITMASK(39, 45) | PPC_BITMASK(47, 48) |
                      PPC_BITMASK(52, 54)));
-
 }
 
 /* Check that write-only bits/regs return 0 when read */
-static void phb4_writeonly_read_test(QTestState *qts)
+static void phb5_writeonly_read_test(QTestState *qts)
 {
     uint64_t val;
 
@@ -143,6 +142,12 @@ static void phb4_writeonly_read_test(QTestState *qts)
     g_assert_cmpuint(val, ==, 0x0);
 }
 
+/* Check that reading an unimplemented address 0x0 returns -1 */
+static void phb5_unimplemented_read_test(QTestState *qts)
+{
+    g_assert_cmpint(PHB5_XSCOM_READ(0x0), ==, -1);
+}
+
 static void phb5_tests(void)
 {
     QTestState *qts = NULL;
@@ -156,7 +161,10 @@ static void phb5_tests(void)
     phb5_sticky_rst_test(qts);
 
     /* Check write-only logic */
-    phb4_writeonly_read_test(qts);
+    phb5_writeonly_read_test(qts);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
With PHB5 separated out from PHB4, let's keep phb4_writeonly_read_test
also.

Thanks,
- Aditya G
</pre>
    </blockquote>
  </body>
</html>

--------------G3KcogNSrEs0XibCUnUwgHJD--


