Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EFAC61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytw1-0001bu-Ec; Tue, 25 Aug 2026 12:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1wytw0-0001be-F1; Tue, 25 Aug 2026 12:23:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1wytvy-0008I9-IW; Tue, 25 Aug 2026 12:23:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEYcBD010036; Tue, 25 Aug 2026 16:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=e1vS4PHzi9RcUOAFUAF0EEPBJ5bHZJ
 PrNNnuy7fpJ+A=; b=A2cG5VXGwqKTBdoizrMFz8UOfAJk2XbEypsXirHOI0G5fm
 ODaruiAghlA1kxriZfGkOWJdg+3fE8gA6dcZO8SSSWPhKEbuRM/E9AKCgFeSnG7q
 RmX/gh4ki5VdH9C/jciC9Z1JK9D4MsuJI2zZOaAF3ETzSxk3S+35NcBluOIx0Knl
 ksiVxhZ9rwzqCJnmHBPfGWbWo/AgVhmYaMaLU+iWw21NRd5g2xQpqEo11tV3lz3R
 xlHwlU/R936MjdEbHkydECusbdGm5rmBFybch/JA5vJsHAY6oWdEsYWH7ctP5yNS
 HKcYVOH3ecXipgwjGNULKlTWvPkSeHD93WhXh+ew==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eh8hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 16:23:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PGBIHr016590;
 Tue, 25 Aug 2026 16:23:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q5b3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 16:23:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67PGNLnc44040534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 16:23:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F1A958053;
 Tue, 25 Aug 2026 16:23:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBE275805D;
 Tue, 25 Aug 2026 16:23:20 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 16:23:20 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------KqZgUygnldzEy1wu4Ae322et"
Message-ID: <332f765f-a988-4a41-85aa-9cdd92d97e92@linux.ibm.com>
Date: Tue, 25 Aug 2026 11:23:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/xive: Trigger the pending interrupt for a guest after
 migration
To: milesg@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>, clg@kaod.org,
 harshpb@linux.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20260824070353.40016-1-gautam@linux.ibm.com>
 <7a5a04d4524d64a0768ed57486da20cec62cafc4.camel@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <7a5a04d4524d64a0768ed57486da20cec62cafc4.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8dc17b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=fjbThTX60DlU4Y5F95YA:9 a=QEXdDO2ut3YA:10 a=PE73ikAbuXiEWt2sRg8A:9
 a=2QLYeOQBcrQJzgmM:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzNiBTYWx0ZWRfXwuPWU28c2jbt
 3YviwYL4KEjnT0gIIVa4ZBV+YZ6r+803xxnSmq/PhBZ0hajDob+KjCOfWxOfV2/KGnN3jcWihyS
 dyFBEjjcuJi/2Zc+saqL7XjjPCwTR+U=
X-Proofpoint-GUID: gXNPPa6QNLhuWJsOF9zBnghWBB42TfLF
X-Proofpoint-ORIG-GUID: gXNPPa6QNLhuWJsOF9zBnghWBB42TfLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzNiBTYWx0ZWRfX0GfbNHK6rVlX
 DSh1RvV7o2d//FXxbUTpFa8lLQMsuW8vsvK3KUYQMVc9v7DH4NHRIDjroGWGKeHCQDejX8rDuhZ
 azASJemy+//1O+SlFuBpDiZkQgkMbCkAQp4af+p9dYGt5WN5YiIz+kdyyv4AnGffzq2d132gKzz
 pFozbLR5vTzBQ4pCYwCMVyx3S64ZVI2qkCJqTz7JsrXiv0g/7CWk4Or5clp/xepjYFF9oXO/TdU
 fHRG+Kda13/MyNOluLHvj+K5w39BoQYz2Kq/f3SZ6+h8ocI9cx6U+iCgw5d3MberlqktRjwzWrn
 pNqARDG6xQCdZZACCigGORseUVCN43p7U5s849mcypvWpTj2yUuiKJSLOZTqZhLVE1Jh1BxhF4k
 QEdDVbT14PEWiTEu3te7Aqjms1AKKFYZ14cKAJv3r0Kzz8XjIz/s15mXdjv5RotE+ccKHN1+fbw
 ai6rnkJe7C3TnydgTPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250136
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--------------KqZgUygnldzEy1wu4Ae322et
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/2026 9:42 AM, Miles Glenn wrote:
> Mike Kowal, can you please review this?
>
> Thanks,
>
> Glenn
>
> On Mon, 2026-08-24 at 12:33 +0530, Gautam Menghani wrote:
>> When a KVM guest is migrated to another LPAR while a stress-ng workload
>> is running, lockups are seen when the guest resumes on the destination
>> LPAR. This root cause is that if there was a pending interrupt for a cpu
>> on the source machine but it was not presented yet when the migration
>> started, the interrupt is not retriggered on the destination LPAR. This
>> is evident when running 'info pic' on the destination LPAR:
>>
>> $ virsh qemu-monitor-command --hmp migrate 'info pic' | grep -e OS -e MSI
>> CPU[0000]:   OS    00   ff  00    ff   ff  00  ff   ff  80000400
>> CPU[0001]:   OS    00   ff  00    ff   ff  00  ff   ff  80000401
>> CPU[0002]:   OS    00   ff  00    ff   ff  00  ff   ff  80000402
>> CPU[0003]:   OS    00   ff  00    ff   ff  00  ff   ff  80000403
>> CPU[0004]:   OS    00   ff  00    ff   ff  00  ff   ff  80000404
>> CPU[0005]:   OS    00   ff  00    ff   ff  00  ff   ff  80000405
>> CPU[0006]:   OS    80   ff  02    ff   ff  00  ff   06  80000406
>> CPU[0007]:   OS    00   ff  00    ff   ff  00  ff   ff  80000407
>>    00000000 MSI --    00000010   0/6   3071/16384 @3710000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>>    00000001 MSI --    00000010   1/6   1852/16384 @3980000 ^1 [ 80000010 80000033 80000033 80000033 80000033 ^00000000 ]
>>    00000002 MSI --    00000010   2/6   4424/16384 @40c0000 ^1 [ 80000020 80000020 80000020 80000010 80000010 ^00000000 ]
>>    00000003 MSI --    00000010   3/6   1913/16384 @4220000 ^1 [ 80000010 80000032 80000010 80000010 80000010 ^00000000 ]
>>    00000004 MSI --    00000010   4/6   2946/16384 @4360000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>>    00000005 MSI --    00000010   5/6   2313/16384 @44a0000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
>>    00000006 MSI P-    00000010   6/6   5825/16384 @45f0000 ^1 [ 80000024 80000024 80000024 80000010 80000016 ^00000000 ]
>>    00000007 MSI --    00000010   7/6   2346/16384 @4760000 ^1 [ 80000032 80000032 80000010 80000032 80000032 ^00000000 ]
>>
>> Fix this by calling xive_tctx_pipr_set() in
>> vmstate_xive_tctx_post_load(), which ends up calling qemu_irq_raise() to
>> present the interrupt.
>>
>> Signed-off-by: Gautam Menghani<gautam@linux.ibm.com>
>> ---
>>   hw/intc/xive.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index f473e6ac77..712498d4af 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1080,6 +1080,9 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
>>               error_report_err(local_err);
>>               return ret;
>>           }
>> +    } else {
>> +        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
>> +        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
>>       }
>>   
>>       return 0;

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>



--------------KqZgUygnldzEy1wu4Ae322et
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/25/2026 9:42 AM, Miles Glenn
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:7a5a04d4524d64a0768ed57486da20cec62cafc4.camel@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Mike Kowal, can you please review this?

Thanks,

Glenn

On Mon, 2026-08-24 at 12:33 +0530, Gautam Menghani wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">When a KVM guest is migrated to another LPAR while a stress-ng workload
is running, lockups are seen when the guest resumes on the destination
LPAR. This root cause is that if there was a pending interrupt for a cpu
on the source machine but it was not presented yet when the migration
started, the interrupt is not retriggered on the destination LPAR. This
is evident when running 'info pic' on the destination LPAR:

$ virsh qemu-monitor-command --hmp migrate 'info pic' | grep -e OS -e MSI
CPU[0000]:   OS    00   ff  00    ff   ff  00  ff   ff  80000400
CPU[0001]:   OS    00   ff  00    ff   ff  00  ff   ff  80000401
CPU[0002]:   OS    00   ff  00    ff   ff  00  ff   ff  80000402
CPU[0003]:   OS    00   ff  00    ff   ff  00  ff   ff  80000403
CPU[0004]:   OS    00   ff  00    ff   ff  00  ff   ff  80000404
CPU[0005]:   OS    00   ff  00    ff   ff  00  ff   ff  80000405
CPU[0006]:   OS    80   ff  02    ff   ff  00  ff   06  80000406
CPU[0007]:   OS    00   ff  00    ff   ff  00  ff   ff  80000407
  00000000 MSI --    00000010   0/6   3071/16384 @3710000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000001 MSI --    00000010   1/6   1852/16384 @3980000 ^1 [ 80000010 80000033 80000033 80000033 80000033 ^00000000 ]
  00000002 MSI --    00000010   2/6   4424/16384 @40c0000 ^1 [ 80000020 80000020 80000020 80000010 80000010 ^00000000 ]
  00000003 MSI --    00000010   3/6   1913/16384 @4220000 ^1 [ 80000010 80000032 80000010 80000010 80000010 ^00000000 ]
  00000004 MSI --    00000010   4/6   2946/16384 @4360000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000005 MSI --    00000010   5/6   2313/16384 @44a0000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000006 MSI P-    00000010   6/6   5825/16384 @45f0000 ^1 [ 80000024 80000024 80000024 80000010 80000016 ^00000000 ]
  00000007 MSI --    00000010   7/6   2346/16384 @4760000 ^1 [ 80000032 80000032 80000010 80000032 80000032 ^00000000 ]

Fix this by calling xive_tctx_pipr_set() in
vmstate_xive_tctx_post_load(), which ends up calling qemu_irq_raise() to
present the interrupt.

Signed-off-by: Gautam Menghani <a class="moz-txt-link-rfc2396E" href="mailto:gautam@linux.ibm.com">&lt;gautam@linux.ibm.com&gt;</a>
---
 hw/intc/xive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f473e6ac77..712498d4af 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1080,6 +1080,9 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
             error_report_err(local_err);
             return ret;
         }
+    } else {
+        uint8_t pipr = tctx-&gt;regs[TM_QW1_OS + TM_PIPR];
+        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
     }
 
     return 0;
</pre>
      </blockquote>
    </blockquote>
    <p>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>
</pre>
    </div>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:7a5a04d4524d64a0768ed57486da20cec62cafc4.camel@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------KqZgUygnldzEy1wu4Ae322et--


