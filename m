Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB65C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lvy-0004as-J6; Wed, 02 Sep 2026 10:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x1lvv-0004a2-RP; Wed, 02 Sep 2026 10:27:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x1lvu-0008P6-1u; Wed, 02 Sep 2026 10:27:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CVkYk2312056; Wed, 2 Sep 2026 14:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nLzQR2
 zTysjrNqc9+fAwQ2dKh7A5VC5BQvXV68cDIDs=; b=PhfFVOpXvldL62DencdDX0
 IbcUSfXDEzZEKpSQNC7an7kBoe/+ZwhKPHM1oc8LehF0gOkmZ9QeJ35bnELx2nbb
 MK8erU+O22xjgFe4Ms/Pg/DzeFvWmbTuThxJbVENLd9I4jtrjgh5a7WOVjTanOPI
 RwEI8tz1oe5wyKRTAKKOzxOP9hxiH9BcRkgyoIlkkRFyfGoMNfEYOH/ZF/MjuZaj
 K+bElR6a+Y2u9/4xvYByZJfsfem7sw9OgRG9ci8E0U4/4CqHo4tLTzvyUyTfqaSS
 sQA9Y6ZqCUPdSWwf0mA3b33e4dwWhygvj9ksnHrfOXhlLZAHYqAFmJKmImOUeVZg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rf5h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 14:27:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EQFHl030321;
 Wed, 2 Sep 2026 14:27:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqjf7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 14:27:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682EQXUV22807174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 14:26:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6F0D58052;
 Wed,  2 Sep 2026 14:27:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E002D5805D;
 Wed,  2 Sep 2026 14:27:12 +0000 (GMT)
Received: from [9.61.249.201] (unknown [9.61.249.201])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 14:27:12 +0000 (GMT)
Message-ID: <0eb91d88-dcf6-45a2-b18b-ca79b09e3748@linux.ibm.com>
Date: Wed, 2 Sep 2026 10:27:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260826145756.2324598-1-jdaley@linux.ibm.com>
 <20260826145756.2324598-4-jdaley@linux.ibm.com>
 <4012f184-e3d8-4b48-abf2-66b694076f97@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <4012f184-e3d8-4b48-abf2-66b694076f97@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a983244 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=C4-LNCLPQWV5QtP9yxMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX7oS4labRXWI/
 oFixUi6YKfpXrky2PF2Od8rSdRTvQ2wBdSXyMUjzApbCTDmZjVCidVU9uopFL4vXkndU9vJluev
 Qr2yP8SHXVKcurIKOi+bcawkCLly3DIda2ulns5Cs+UHT+8dcx2lHf91Z9XG4w5w2npr6RutNUQ
 AIMQ021ZcPVqgKPX9IU6R2r10UGwDZSHYF4i25u13tTPevUWgEJTcpqk/6cvOdyKjNtaiUt6jK5
 HAabbZ37gV1HAmxG+luvGxMMndk2mUHREVRZ13l+ejhwdVr7pXMpRPurQBGIQ1RvTMQwhjYSiwe
 XvwZacRyowJgxDghN3o+kkrDwbgG80mqEUVOwgAvQvX4cIaU/z8mGp/5bUweyui9gb2JMRC8EKI
 Cfdqb+tx/pG74mNuyfbMeAUAhou2hOLiLR05yv+r6ug2oe3o3JLSEBW3b7fVio3YhWIDNszC8Jc
 LVyeS6gMPiK2ZLBvNxQ==
X-Proofpoint-GUID: JVYjnpnOg90puMx6wa071usJi3YadmaZ
X-Proofpoint-ORIG-GUID: JVYjnpnOg90puMx6wa071usJi3YadmaZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX/OU4IZ4Xte0h
 HcwUzn2WNeKylRLL5SNuTF2yEyq9RmZwKTz7xtKvbkywqF8e8OmDwQPk/vbwcjO/qDJ7Kp3nF8P
 WNd8F0zc6TUoDpeM/00VL1oGhPzwVaE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020124
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
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

On 9/1/2026 4:36 PM, Matthew Rosato wrote:
> On 8/26/26 10:57 AM, Joshua Daley wrote:
>> Split test_s390x_secure_ipl() into two subtests. Each tests with a
>> different boot device: virtio-blk-ccw or virtio-blk-pci. Use class-level
>> variables and a temporary shared workdir such that the time-consuming
>> setup is not run multiple times.
>>
>> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> 
> Thanks, I verified that the setup is not run twice (and indeed, you can
> tell that while the first test takes quite a while, the second test
> finishes much faster)
> 
> One other thought below...
> 
> [...]
> 
>> @@ -109,39 +125,42 @@ def setup_s390x_secure_ipl(self):
>>           temp_vm.set_machine('s390-ccw-virtio')
>>   
>>           asset_path = self.ASSET_F40_QCOW2.fetch()
>> -        self.qcow2_path = self.scratch_file('f40.qcow2')
>> +        qcow2_path = os.path.join(S390xSecureIpl._shared_workdir, 'f40.qcow2')
>>           qemu_img = get_qemu_img(self)
>>           check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_path,
>> -                    '-F', 'qcow2', self.qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
>> +                    '-F', 'qcow2', qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
>> +        S390xSecureIpl._qcow2_path = qcow2_path
>>   
>>           temp_vm.set_console()
>>           temp_vm.add_args('-nographic',
>>                            '-accel', 'kvm',
>>                            '-m', '1024',
>>                            '-drive',
>> -                         f'id=drive0,if=none,format=qcow2,file={self.qcow2_path}',
>> +                         f'id=drive0,if=none,format=qcow2,file={qcow2_path}',
>>                            '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
>>           temp_vm.launch()
>>   
>>           self._require_host_secure_ipl_support(temp_vm)
> 
> If we find this fails the first time, then we are going to fail setup
> and therefore the 2nd test will also enter here, create the qcow2 again,
> and then fail again for the same reason.
> Couldn't we also save the time spent creating the qcow2 and launching a
> VM the second time if we know it didn't work the first time?  It's
> checking the same host facilities.
> 
> Basically I'm wondering if we should just create another flag in
> S390xSecureIpl that defaults to false and gets set to true in
> _require_host_secure_ipl_support() if the support is missing.  And check
> that flag in each test before checking _setup_done and skip right away
> if it's true (with the same message as the one in
> _require_host_secure_ipl_support().
> 
> 
I think that's a good idea. I'll add it. Thanks for reviewing.

