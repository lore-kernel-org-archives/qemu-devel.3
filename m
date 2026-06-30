Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA15FC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQFS-0007JU-FL; Tue, 30 Jun 2026 00:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1weQFQ-0007JC-Hf; Tue, 30 Jun 2026 00:39:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1weQFO-00055D-PE; Tue, 30 Jun 2026 00:39:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U1Iosl603765; Tue, 30 Jun 2026 04:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=cqoCGsKIjz+5BPPH+gseIy3LSJEwIL
 uYWQ0nMSj0e7g=; b=Ris4vMp1TO9YGwA41h8TvDfSb/5VtPhF83i8BXbd+4iCk2
 /26zxniwBgXWvbYenEtgvW+AWW6Vb3/r7GVimOlq1ZoGuB64EZtRV8qhMcoSCvdJ
 pNH/N3fkwWEyIPeHuWHtnRDWsm894NrEON9VJ4cvtOrKpzv/tZEZiY6Fo0Rb02NG
 Ek2QXMJ/9QD0Vep0d6czhXrEpdbev09SHsgoTdy4wd7HlgOhMavz6HGAAtDHt9NX
 ehcv19ZLpOLw2JZPPnEyFwiCxC8Ur/UdRqUj4U7MHZYWILjZJEUH6pLiX25qeraD
 tGIZB7bbWRxwj4Am8k9MwOHWz6F3oxcRjDpZJzmA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5msb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 04:38:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U4YhPr019294;
 Tue, 30 Jun 2026 04:38:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w0kwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 04:38:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65U4cnhh40173900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 04:38:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65F620043;
 Tue, 30 Jun 2026 04:38:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8C3820040;
 Tue, 30 Jun 2026 04:38:40 +0000 (GMT)
Received: from [9.67.21.171] (unknown [9.67.21.171])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 04:38:40 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------rUDQSYmzhcKNgGkhHHm6maod"
Message-ID: <2870a679-dc81-45d1-a686-c1b0aaee98f2@linux.ibm.com>
Date: Tue, 30 Jun 2026 10:08:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260623141933.577981-4-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAzNiBTYWx0ZWRfX5KvTjrDp3S+m
 1OR1YHQFdGmwzdK8C2gWR1MHf6FfYxVvfA3nytzxxmFhsaQ5RLEP7r2B/cB7yoysEsHakT7fER1
 dh5gxwpMchqh5z02yVBIsD5I9favCgWiRG/YIytTU+5l2mmqNgJh1JxfVz7knb9q+2ZLaV9xZcR
 98SatTGx8o+ntevlnJfLyaR9dxFyX4zMDFmjbUsYBaG0ydg1Tm647qWiAi98LEkyjBU9qNF2pZj
 O8poQW4kFhcFLGpE336oy9bTXjujwM3Gxn586aAdVknV/fMQNCIQHQaEqxWi7XZX+NDrGOpI+W/
 qEg7Sp9g9m2E8rErl/XY5SmshIGgidbhOqk2W2JeVuJ+Wn/1yvpKE6zXlq89nQKpwUJfhn+zK7q
 u+q3lVX5apbd9Aw+WFpfZqzs+QXM1sj4ls+onPeWagHJG95qOiEkRe96JHsWxBcBIzyyBHVcjl3
 1stdP+0nHPzVJWNqAcw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43485f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=NpJpABYSGHa0oKR1yFEA:9
 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8 a=H9eHa7u8yahsiJ6wVDkA:9
 a=3d3lXJbJH2nHs_qd:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: riYaHHECfbYgB_f7UTMR8OQ5hUfNOHRg
X-Proofpoint-GUID: qdXsEAkLtOderXA1nFyApAj7n0aCEfTf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAzNiBTYWx0ZWRfXwbY7eqi6WzwQ
 h9zAcokgbyKm1chtDl5tVTsmDUYI4kZPy1PTlpjQmJ3B7uYhykbPzBtUt/0vOtXXNE5UUaDKsG/
 3hshvTyrOBpaGQTPtf8IZ+bljniXQ2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300036
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
--------------rUDQSYmzhcKNgGkhHHm6maod
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aditya,

One comment below regarding test coverage.

On 23/06/26 19:49, Aditya Gupta wrote:
> @@ -548,7 +548,7 @@ static void test_xive(void)
>   {
>       QTestState *qts;
>   
> -    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
> +    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
>                         "-nodefaults -serial mon:stdio -S "
>                         "-d guest_errors -trace '*xive*'",
>                         SMT, SMT);
By replacing the hardcoded machine type here instead of testing both,
QEMU will no longer exercise the XIVE2 path on Power10.

If a future change breaks the Power10 machine initialization while
Power11 continues to work, this test would still pass.

Would it make sense to run this test for both `powernv10` and
`powernv11`, similar to how the SPI qtest iterates over the supported
machines?

Thanks,
Nikhil
--------------rUDQSYmzhcKNgGkhHHm6maod
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p data-pm-slice="1 1 []">Hi Aditya,</p>
    <p>One comment below regarding test coverage.</p>
    <div class="moz-cite-prefix">On 23/06/26 19:49, Aditya Gupta wrote:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:20260623141933.577981-4-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">@@ -548,7 +548,7 @@ static void test_xive(void)
 {
     QTestState *qts;
 
-    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
+    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
                       "-nodefaults -serial mon:stdio -S "
                       "-d guest_errors -trace '*xive*'",
                       SMT, SMT);
</pre>
    </blockquote>
    <span>By replacing the hardcoded machine type here instead of
      testing both,</span><br>
    <span>QEMU will no longer exercise the XIVE2 path on Power10.</span><br>
    <br>
    <span>If a future change breaks the Power10 machine initialization
      while</span><br>
    <span>Power11 continues to work, this test would still pass.</span><br>
    <br>
    <span>Would it make sense to run this test for both `powernv10` and</span><br>
    <span>`powernv11`, similar to how the SPI qtest iterates over the
      supported</span><br>
    <span>machines?</span><br>
    <br>
    <span>Thanks,</span><br>
    <span>Nikhil</span>
  </body>
</html>

--------------rUDQSYmzhcKNgGkhHHm6maod--


