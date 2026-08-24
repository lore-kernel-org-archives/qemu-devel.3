Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92555C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXh0-0006JU-G7; Mon, 24 Aug 2026 12:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wyXgv-0006IX-PI; Mon, 24 Aug 2026 12:38:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wyXgt-0007cN-TY; Mon, 24 Aug 2026 12:38:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OG1rqi2418921; Mon, 24 Aug 2026 16:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sogK1j
 61WUoOjoc/7lPGUa4pXPv92z2j7u86RaAOa/4=; b=AwzTrxv4MzGKACZ56N3+hA
 d4L2Yi1B9Icf737XMPdnPvd0nsMxEAR4addNO97X3TBqV7nhSKKQfyDTLDv7hgFs
 yO5A1vIYBz+pd7xyVAoIQ2Ts66Y7Meun491LH4ArNPeeeTXEe3Vk/yeikJp5LO4a
 chC/j8kPXRW1KU26/0sMHd0x1s8gdYUtRYI+8br8Iyu49DfmKJLyTkTui2etONdL
 ypA9dlCcBC38VvsjeBtNQzIphqWBNJ9WRLJmFLewbrG/VeqHvFD838PPGz4BwKad
 GBmKY8R7k8VPkOIqehpzQ18GwV/xIpnNUZccuylDW9SvQhXf/q0pxpj8rE7VGokQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx2hjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 16:38:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGQKZ8028231;
 Mon, 24 Aug 2026 16:38:26 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgy39a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 16:38:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OGcPd023593712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 16:38:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0935E58056;
 Mon, 24 Aug 2026 16:38:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 138F058067;
 Mon, 24 Aug 2026 16:38:24 +0000 (GMT)
Received: from [9.61.255.87] (unknown [9.61.255.87])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 16:38:23 +0000 (GMT)
Message-ID: <2c98040b-f6c7-43cf-a768-5089258e723e@linux.ibm.com>
Date: Mon, 24 Aug 2026 12:38:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-4-jdaley@linux.ibm.com>
 <f2f3b5de-e1de-4e8c-82c8-2379b78e9ff9@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <f2f3b5de-e1de-4e8c-82c8-2379b78e9ff9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfX1Mwggb1rG9Fj
 o2w4finfA785+z+DTBW01Cr98AcyoQUkYdL4WjCxciXHrnyGagt61K6Af92YFcLnwOhPhNNYfP5
 ZDSJUIDyVHOvPfzqdgPJG1jzvvtzPyE=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c7382 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KSry-lojsPDvogKMvdsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Cu1fgYyEzEHoxsaYFhJhmpSEHu8WxE2E
X-Proofpoint-GUID: Cu1fgYyEzEHoxsaYFhJhmpSEHu8WxE2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfX8XWDvdLu5oSw
 zNCar/W88pUxH5r3Mgza1CegJz+1eJ7zY2QEZuObMrVxrNAEIAA7FXNuBdrG3Uum7ZpOpJ7jN49
 7fVABVordcGnV6H29dco5UvW0SjO1uVlGD9GN3+pDgx/8zb6ViSQ9I7arrut28j8Ywl2mrGe1/O
 MoGo5pFwqKia2nvvQP2fXT8RTow1GKSPUcvw09MviBqtiTwuO7NNTiqzGuxTdf0lCZKhVAGyaAZ
 oAhsAVBZ/7ii2eEBPgDWCoIR2GY1I3CXXi/i9dTPEhBeyhsGYtgCDoCTMbc3EnqyI0iaLTXx4YK
 iGZEEkmcWfK8sEKEYYeqlop1P/nXHNwhCdkoB2SlHB2Z80tYdDHoKV61h1f6XulSRH6QPcVJAU8
 yaixuu4yc1hLm3ieqLus7e7fl35TKBAXyqIWaokaiQirTTH8OrJ2B+GLZQ4h1UnETMMBO3m1l9w
 BXVXxjyKKETqs6K4lEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

On 8/24/2026 10:55 AM, Matthew Rosato wrote:
> On 8/12/26 11:21 AM, Joshua Daley wrote:
>> Split test_s390x_secure_ipl() into two subtests. Each tests with a
>> different boot device: virtio-blk-ccw or virtio-blk-pci. Use a state var
>> such that the setup is run only once.
> 
> [...]
> 
>> +
>> +    @skipBigDataTest()
>> +    def test_s390x_secure_ipl_ccw(self):
>> +        """Test secure IPL with a virtio-blk-ccw boot device."""
>> +        self.require_accelerator('kvm')
>> +        if not self.setup_done:
>> +            self.setup_s390x_secure_ipl()
> 
> AFAICT this setup_done check won't do anything.
> 
> If I run this file I will enter setup twice, once for
> test_secure_ipl.S390xSecureIpl.test_s390x_secure_ipl_ccw
> and again for
> test_secure_ipl.S390xSecureIpl.test_s390x_secure_ipl_pci
> 
> I think it's because each test will run with it's own instance of the class.
> 
You're correct, good catch.

>> +        self.verify_s390x_secure_ipl('ccw')
>> +
>> +    @skipBigDataTest()
>> +    def test_s390x_secure_ipl_pci(self):
>> +        """Test secure IPL with a virtio-blk-pci boot device."""
>> +        self.require_accelerator('kvm')
>> +        if not self.setup_done:
>> +            self.setup_s390x_secure_ipl()
> 
> Same
> 
> Unless this is really time consuming, I think the simple answer is to
> just let the setup run twice and don't try to share between the 2 instances?
> 
> Thanks,
> Matt
> 
The setup is time consuming compared to the verification step. On my machine, the entire test takes about 120s, and about 90% of that is setup.

A simple solution is to scrap the subtest idea and just have:

@skipBigDataTest()
def test_s390x_secure_ipl(self):
     self.require_accelerator('kvm')
     self.setup_s390x_secure_ipl()
     self.verify_s390x_secure_ipl('ccw')
     self.verify_s390x_secure_ipl('pci')

But if we value separating the ccw and pci cases into separate subtests, I have a solution using setUpClass() and class-level vars to run the setup only once. It just makes the code a bit uglier. I'll proceed with it for v2, unless other opinions arise.

Thanks.

