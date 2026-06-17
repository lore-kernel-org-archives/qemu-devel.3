Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B2CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjlo-0006TD-NZ; Wed, 17 Jun 2026 02:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjlW-0006Q4-Cb; Wed, 17 Jun 2026 02:28:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjlU-0005Hd-N2; Wed, 17 Jun 2026 02:28:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmmgC2895014; Wed, 17 Jun 2026 06:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5m7mYXYiHE/LN5DsdQfuCyvCaJXJ9U
 bAvFxzeqGGqKE=; b=HWc/swmK/9hVVbBDjdfyGojs2s2GgID23p1myeRqQe2ZH7
 xaWW1u1ndEkVcwRySAY6wgBT+CS1Osf21uCXRAXGaQD3P8D07eOQCF8bnA5hJA7O
 L1lhlLfjTwUrvz7hwk8tM/pkkNZ5mL//CPonuR9/lf4Akf/2XLK/adgV6WwiT29u
 TUSQEY+1GpgrUEIPNA1xpMyHzXXFECX+NyP2pVw2rhWcluYDeP9ZRyqQoOx6L1Fb
 2861SDKZL5QLSC2Xm31VeaNEaA0JPsASzddIg+J0S5vHb+YFyz9mknhv3fAmKg3j
 Ob/SmVnJGSp6KKoLjHIALjTE99cTe2GlbmYRur1g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ1hbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:28:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JdXa031661;
 Wed, 17 Jun 2026 06:28:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvahu2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:28:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6SVOj9503252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:28:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED2C858060;
 Wed, 17 Jun 2026 06:28:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4912F5803F;
 Wed, 17 Jun 2026 06:28:26 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:28:25 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------XpwAOxoP4z0co4zLpUA06N8u"
Message-ID: <97c48adb-4ad7-488a-bacc-fdb5efa148fe@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:58:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] pnv/phb4: Implement write-clear and return 1's on
 unimplemented reg read
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-6-saif.abrar@linux.vnet.ibm.com>
 <af9KzhspN6Suvb_Z@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9KzhspN6Suvb_Z@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX0JdBk/LyzK77
 2p40o5jArOiAIUua/VofYgssJR94x8Agh5mrG7k+A2w+47sEVWQR1Uwgf5iYbQnRqIoFtE1mo3G
 pDQNr/bfUD4R2hf1WmOGgCAZMv+TxjA=
X-Proofpoint-ORIG-GUID: kQbcy761qY5O8Kjk2FhfeLEaj4x_2doY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX0Zyo7DJG7oov
 hkmqEvBGOssSKpyhY/5g6ZkWwPRnCY4TrAW5r9eYH1U8iOgUhH5NPdJlXiV1Lu78d2XAxVFNf7u
 i2oruCeHgAErgVQMkCF9myV3gyTxcJQV5GlIN3fTmckGcs1QRNSg+Ttw0nkWP/dgeYpUoArJa+Q
 pCWxp3o+GelGtrIeCiOSAJklHyLXzU9Zb0YwjDy1W5qZxRSTeXbqiD3KrK8GgYaZW2KYTND1BMf
 HgGMz1MME3/odhDWFZqOCYeH6TrpPl9DL3gqxq4wClXF64PMNzHu+IW3ivGvQTArd70RMGB5L1t
 bbnJwO59k+EPkv2J+2Mj+JQ2CwZr1Sm8LFFIfBmwcPqDhTz1H8E0uPVFoprjBVuPGvVn3Z98ijN
 cYDvVPCjvJkJDKU4AsffHDLzssmHY8/+WICVg8qljYNRIRegMm+T1KqmGnML9uthpKAJSz+6v0f
 PLBoqxPrtSzmT+7xuOg==
X-Proofpoint-GUID: L438freVscOlyKNRKXX5dQHp9wORHdmR
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a323e92 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=r6VA_vbsRYX1LWrO37kA:9
 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8 a=ibA4FMNa6AhiHH36WvcA:9
 a=RaFPAEqoOyGFxtXa:21 a=_W_S_7VecoQA:10 a=3ZKOabzyN94A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
--------------XpwAOxoP4z0co4zLpUA06N8u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 09-05-2026 20:26, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> <...snip...>
>> @@ -773,27 +812,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>>           break;
>>   
>>       /* Silent simple writes */
>> -    case PHB_ASN_CMPM:
> few registers removed from the switch never got added back, eg.
> ASN_CMPM, is it expected ?


Few registers are covered in the switch-case range, e.g. case 
PHB_CONFIG_DATA ... PHB_LOCK1:

Few registers are removed from the PHB5 spec.


>
> - Aditya G

Thanks,

Saif


--------------XpwAOxoP4z0co4zLpUA06N8u
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
    <div class="moz-cite-prefix">On 09-05-2026 20:26, Aditya Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:af9KzhspN6Suvb_Z@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">On 26/03/05 12:09AM, Saif Abrar wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&lt;...snip...&gt;
@@ -773,27 +812,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         break;
 
     /* Silent simple writes */
-    case PHB_ASN_CMPM:
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
few registers removed from the switch never got added back, eg.
ASN_CMPM, is it expected ?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Few registers are covered in the switch-case range, e.g. <span
      style="white-space: pre-wrap">case PHB_CONFIG_DATA ... PHB_LOCK1:</span></p>
    <p>Few registers are removed from the PHB5 spec.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:af9KzhspN6Suvb_Z@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

- Aditya G
</pre>
    </blockquote>
    <p>Thanks,</p>
    <p>Saif</p>
    <p><br>
    </p>
  </body>
</html>

--------------XpwAOxoP4z0co4zLpUA06N8u--


