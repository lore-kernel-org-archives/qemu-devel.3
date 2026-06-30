Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85ADC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ3H-0005KS-3B; Tue, 30 Jun 2026 00:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1weQ3D-0005KF-QV; Tue, 30 Jun 2026 00:26:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1weQ3A-0001KV-8h; Tue, 30 Jun 2026 00:26:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U1J65O604846; Tue, 30 Jun 2026 04:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=FakphDSzLgYkKFuGdJq8skkiu5c+8g
 un8fUMLLtQzK0=; b=AcRX3cGnxjk2xHYEecDdhAPY6M4O41RIZ8JrlaoQlldaZm
 jxWl5wAR8XQ5XmKvGDeSyake7UNiQ45skrlHAzCut+b3/h2j6VVbNd9lXILz8WtD
 Mcl8j6YLz0mx4tqQGu+qkb0iHPrkIQJOWEe0iSJBDmpqVvBwDW8MLQqzYH16P4Rw
 PP2/1m12f9ApwWMwxwJFJX6KzTQNESH8M0E80q6lyReyHaxlz9ZclgnNJZ858/qR
 doAn866s2+9qtwzpUZbB5sXpqR+Nxzy6uXPCtPjjuoZSO+ANZ1rnh3Wnz9xbhIWg
 7sUkT7E/WsdSTQzhpm/pzsGdywycaoFeEd4Jm9dg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5mr2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 04:26:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U4Jeog029998;
 Tue, 30 Jun 2026 04:26:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g8abn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 04:26:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65U4Q9u615073596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 04:26:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E461F20043;
 Tue, 30 Jun 2026 04:26:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E26D720040;
 Tue, 30 Jun 2026 04:25:59 +0000 (GMT)
Received: from [9.67.21.171] (unknown [9.67.21.171])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 04:25:59 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------RKryjiUf0ognZy9qac2UQ30q"
Message-ID: <db95d79a-a6bd-40a1-bc08-f572cebe1641@linux.ibm.com>
Date: Tue, 30 Jun 2026 09:55:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
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
 <20260623141933.577981-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260623141933.577981-3-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAzNiBTYWx0ZWRfXyKSTf57wFht5
 ZF+oQAeJOwyQ/nKR96fYruQOChvMBPegAewkI8f4K+0hv51SYgijHpObN76j7+qIXCXL5PBWcto
 n9/i88stlghdcL8q/6KIABUltu1o0GHwrObnp0MFTay57efP19/+J7Od/EI4a9ayCFRDuttQF6g
 l1krUDzLqNb36U8NNluw4Mta2mUhOVDdHo1L2FXywmqInIjIC3wZDJlW5qhAnOtjwYLyE6GuwSa
 S4Y3d6Wm+9oi6JfjIeIQO1w8SG2fTJ9AC2Nn2rZI+sJipR9z/fQxGsn0TJZv0f8Yfyy4BXPHYwg
 dILA5Z/I6Rz87rdamD4Xmu7ZWcqenl6P8hwJAsWBHitanz2W2nmYFgdaXbynXfsMrLkRKhfLuVa
 dr3rOCz0ZMXOSyaI2I7tac98KH+AqxfO1OCsiXdjXeAW40HpRAHv8eyGDm+YlcvAecRql5dOEgE
 Eht0tWNdWsRezE7jGKA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a434566 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=aoyFOt1ON7wp1aZLvn8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=VnNF1IyMAAAA:8 a=vncCG-wuJ0h8r5VEWvEA:9
 a=neNuPc0-2ygLVHzk:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: c4a8Mzc6K1xZrd1VwS2bMH3iN66sSWU3
X-Proofpoint-GUID: Wbf778p86hwyVjaZu6NLwvbyKRDRH0kF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAzNiBTYWx0ZWRfXwBGyOiHow5ts
 xeRwY07wmgFUmgO5fp8dh6Kjuj7h1k7GAJ4t3E+A4DajyPaTE6YE0/jSMoK3Yaza61Dv4gYfHVD
 G3pr5ef3vjAQ+mmWcsJ5jhq283a6ZhQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
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
--------------RKryjiUf0ognZy9qac2UQ30q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aditya,

One comment below.

On 23/06/26 19:49, Aditya Gupta wrote:
> @@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
>       const PnvChip *chip = data;
>       QTestState *qts = NULL;
>       g_autofree char *tmp_path = NULL;
> +    const char *machine = "powernv10";
>       
Would it make sense to introduce `pnv_get_machine_type()` in patch 2
instead of patch 3? That would avoid hardcoding `"powernv10"` here and
allow this patch to use the helper directly.

Otherwise, the patch looks good to me.

Thanks,
Nikhil
--------------RKryjiUf0ognZy9qac2UQ30q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span>Hi Aditya,</span><br>
      <br>
      <span>One comment below.</span></p>
    <div class="moz-cite-prefix">On 23/06/26 19:49, Aditya Gupta wrote:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:20260623141933.577981-3-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">@@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
     const PnvChip *chip = data;
     QTestState *qts = NULL;
     g_autofree char *tmp_path = NULL;
+    const char *machine = "powernv10";
     </pre>
    </blockquote>
    <span>Would it make sense to introduce `pnv_get_machine_type()` in
      patch 2</span><br>
    <span>instead of patch 3? That would avoid hardcoding `"powernv10"`
      here and</span><br>
    <span>allow this patch to use the helper directly.</span><br>
    <br>
    <span>Otherwise, the patch looks good to me.</span><br>
    <br>
    <span>Thanks,</span><br>
    <span>Nikhil</span>
  </body>
</html>

--------------RKryjiUf0ognZy9qac2UQ30q--


