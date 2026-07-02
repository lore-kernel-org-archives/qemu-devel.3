Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537ADC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJUx-0000sh-KT; Thu, 02 Jul 2026 11:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfJUr-0000rT-2n; Thu, 02 Jul 2026 11:38:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfJUn-00081i-HT; Thu, 02 Jul 2026 11:38:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EIQA6075422; Thu, 2 Jul 2026 15:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0Gan+P
 K3BJ3Md8MrBgRt7HirveuR1jwcFfrRe4eLSAI=; b=FSvx5Peg/6dmRxMT2p98Sr
 wVueScGaofB/KE7aHULCnMlHNlYn9PQ/AlxUJqREDFqzf9VvtUzIbgJaeCWXm4Pk
 33GwUhyauu/ZiEPxVsHxgny92zRCGdjnphx6L3KWVPBN1Fq7/1h3byIHQ9M+uJFx
 Doy55LIkkQyhvTtDvrksoQUV+eI0GghDmloxaOeXM8WV93IQ4p0l2Udy5SMiFgsA
 14eBiZhXhoMLR0PFruTKrfBr1FJuSw7PXiwE8P7E95S47ZCWAjsgXMsaJo9vWYiv
 t8dpgkaoZXTx/vVeSyGd70e2XCJNmQJFh30jJcRBmKlP0TOX1n0kF7z+w+ZNwraQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgapvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 15:38:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FYbJ6019794;
 Thu, 2 Jul 2026 15:38:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukcmd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 15:38:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662FcMTw60883358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 15:38:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 933F158056;
 Thu,  2 Jul 2026 15:38:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2A1D58052;
 Thu,  2 Jul 2026 15:38:20 +0000 (GMT)
Received: from [9.61.151.121] (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 15:38:20 +0000 (GMT)
Message-ID: <f0a13552-a825-429a-be79-a75cea4ae75f@linux.ibm.com>
Date: Thu, 2 Jul 2026 11:38:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 33/35] tests/functional/s390x: Add secure IPL
 functional test
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-34-zycai@linux.ibm.com>
 <c9a6b8a6-edbd-482d-9f01-7aa09073c934@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <c9a6b8a6-edbd-482d-9f01-7aa09073c934@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4685f1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZQpt4IiGet2WhmSSfTQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfXynw7YeyX8bPb
 4tyQ5abUYGNiFAwDEljbTudS/66n92w+jXVeGZfTm15DsXDAPi7353TaD9eRF+nwKrLnCOh5UCS
 D0rz3Jmt9D1d60HNS3rEIYQkEm3IiQI=
X-Proofpoint-GUID: ZUPUqXz0TNBv034pbccXk8lyZ5K8D4t1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX0UhN6EzaRQRE
 KJmg+B+/9w6IEmWQSNPRCZExknTE0Z+908L9S96jhGg6i62Y4CUNwQ//EF69rktcrbXvPdP5LsK
 +MH7hrS7fuOCBwMIZH+peLGCsP0BuwIkVtiHeqrqtGBbKRD7iaxglKeDNR6VBNc5pEi5mxQMNCf
 sWMI1aX4k0G8dowJSs4SlEf0qSzyHDPjTQjpDPbCZbirfEbnbYvVo5rz6sV8foClTpJimwjKpAs
 EO/v7Y/uDGy3GcnBLEhGlhDwAA6v5WFktGYXi4+X1oBpeOEMjDtrjlUpKrKF3Dzi5MyhmePYAAF
 gy8m42Fj3cO08mIFIrs0Gw23G1du7MI8FWyxWX7KUj5gNm8SeW1KikqB65fBq3xixmnkNRiThcd
 +t2szLR+WaQ1QR6xvOdPX8tXLxAVVnc16kAHLdXJqINnn1uip13lLnI7UJxzzzgdA8mEcmD5kG8
 /NyvhR+thSdiU35YtAA==
X-Proofpoint-ORIG-GUID: ZUPUqXz0TNBv034pbccXk8lyZ5K8D4t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

On 7/1/26 9:48 PM, Matthew Rosato wrote:
> On 7/1/26 4:49 PM, Zhuoying Cai wrote:
>> Add functional test for secure IPL.
> 
> Thanks for writing a test!  I (accidentally) verified that it fails
> without a s390-ccw.img that includes your changes + passes once your
> changes are built.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>

Thanks for the review!

> But one question below, possibly a future enhancement...
> 
> [...]
> 
>> +    @skipBigDataTest()
>> +    def test_s390x_secure_ipl(self):
>> +        """
>> +        Verify secure boot validation during s390x guest boot.
>> +
>> +        Expects two "Verified component" messages and confirms
>> +        /sys/firmware/ipl/secure reports secure boot is active.
>> +        """
>> +        self.require_accelerator('kvm')
> 
> I thought this would work for tcg too?  If so it would be nice to be
> able to enable this test also for cross-platform testing w/ tcg..
> 

Yes, it works with tcg as well. I ran the test with tcg last night and
again this morning, and it passed both times. The main issue is that it
took about 3060 seconds to complete due to the relatively slow nature of
tcg and the amount of setup performed by the test.

We could enable the test for tcg and use tcg whenever kvm is not
available, but we would need to significantly increase the timeout
compared to the kvm case. I think something around 5000 seconds would be
reasonable to avoid unexpected timeout failures. If that sounds
acceptable, I can enable it in the next version.

(Interestingly, when I tried running this test with tcg a while ago, it
did not work because account initialization failed during setup and the
guest dropped into emergency mode
<https://lore.kernel.org/qemu-devel/7582a154-7f9f-4161-bf39-8d20930a1d27@linux.ibm.com/>.

It looks like something has changed since then, as the test now
completes successfully.)

> Thanks,
> Matt
> 


