Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8868C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1VDg-0001iV-8v; Tue, 01 Sep 2026 16:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x1VDe-0001i6-Ik; Tue, 01 Sep 2026 16:36:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x1VDc-00076c-TN; Tue, 01 Sep 2026 16:36:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KX0xw2114170; Tue, 1 Sep 2026 20:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rPBS13
 v+WyEfK49FIPW3UJw0TRCbSCXoRynp95fpczc=; b=XBB/mmV8cabJhCrXXJG8BU
 XObqPtouGZNJhzpVfpVRwZug7k6wpfJnuWUJdXUrWj8IMilkFh/jwA1aJN0OEl98
 78CC1+J8jHyj44z9rYDPOJ8BE2baGI3nQOFOxUyVNCunoJ5LuMecR7eW7Z4j1sz+
 OLapw8X6tg9igjj2S+WUSO8Xx9NjTCCOlqIwXIj+AEvty76wqFhwXVJRSbVWibLg
 ZnnPSZfQE2+PmM83svshLwMr/GqfiiRDcWinvZBMWD4eRhcKYqNhWq8yFBDofpnl
 PdzQsNiLS2lyWwtGwtT1TPEEsOpX5uar/IQYAUGvFBaQw1LN2Gg0tVf4KV2Ijz8Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhtdgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 20:36:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681KQHB9017742;
 Tue, 1 Sep 2026 20:36:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hduea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 20:36:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 681KaPAh64225582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 20:36:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 974EF5804E;
 Tue,  1 Sep 2026 20:36:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 475165803F;
 Tue,  1 Sep 2026 20:36:24 +0000 (GMT)
Received: from [9.61.36.99] (unknown [9.61.36.99])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 20:36:24 +0000 (GMT)
Message-ID: <4012f184-e3d8-4b48-abf2-66b694076f97@linux.ibm.com>
Date: Tue, 1 Sep 2026 16:36:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260826145756.2324598-1-jdaley@linux.ibm.com>
 <20260826145756.2324598-4-jdaley@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260826145756.2324598-4-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dqRLFm3KbivxQdVhVmbDziNJ4Ehh2yKW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE4MCBTYWx0ZWRfX9I5LBGK9r1eZ
 Lz89zoVK3in3TL+ph7Q83anUX4L99QpeCRtyYHZUtt1LJ3IugeLDKdL71SfjQnzsbKGi2veYmMb
 Qslsw3vb/ZwgcBPwyU9vDy5esnrvxlcfDm5YBmgMiEa9bcn/Im9cDp5+fBWL9vYU4+SpeeCjxO0
 ZoQJdrBTjQuFWs2us+wBPU5vPASkonkG9BdIH+N2PxQx+8mNKzVp0vmHApof+EgKf5JJS3dQB9m
 MZwm9Ux8kQL3QdO7gS3+pwlneeo93KPm5ovc9Tl1Lf+vEHDFN9DWFaOZ0lbems/qW3PgKdKdPI4
 OxZ4ng+fO0KPZfZ1S87kHqx+HympX3FnKDfWaBB3/Qeo4Yw2ML3lFGymcpF03cnn/cpC2xWg4hv
 pSyWDWp5+AMhxvyV6HbDPTTq1eatdk91IzwlGS0ygADt/P0elJbN4xnHHOVPs5ZV3yDSBFsdIlT
 sQ/sUgeCXc4TX9aoq1A==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a97374b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=PHKx_LMpFGwbHX9PrewA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE4MCBTYWx0ZWRfXzAdqHQY8LLgd
 pFNC81B35MTTSHh+DiR9qSaQzzUUstDNrnbfPu38ISvx3f9i38RTCsCF99i9vOKcxDkbbScQEzh
 f2+MW2zMP69c9E42fMwVLkUvMXn7MZw=
X-Proofpoint-ORIG-GUID: dqRLFm3KbivxQdVhVmbDziNJ4Ehh2yKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010180
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/26/26 10:57 AM, Joshua Daley wrote:
> Split test_s390x_secure_ipl() into two subtests. Each tests with a
> different boot device: virtio-blk-ccw or virtio-blk-pci. Use class-level
> variables and a temporary shared workdir such that the time-consuming
> setup is not run multiple times.
> 
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>

Thanks, I verified that the setup is not run twice (and indeed, you can
tell that while the first test takes quite a while, the second test
finishes much faster)

One other thought below...

[...]

> @@ -109,39 +125,42 @@ def setup_s390x_secure_ipl(self):
>          temp_vm.set_machine('s390-ccw-virtio')
>  
>          asset_path = self.ASSET_F40_QCOW2.fetch()
> -        self.qcow2_path = self.scratch_file('f40.qcow2')
> +        qcow2_path = os.path.join(S390xSecureIpl._shared_workdir, 'f40.qcow2')
>          qemu_img = get_qemu_img(self)
>          check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_path,
> -                    '-F', 'qcow2', self.qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
> +                    '-F', 'qcow2', qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
> +        S390xSecureIpl._qcow2_path = qcow2_path
>  
>          temp_vm.set_console()
>          temp_vm.add_args('-nographic',
>                           '-accel', 'kvm',
>                           '-m', '1024',
>                           '-drive',
> -                         f'id=drive0,if=none,format=qcow2,file={self.qcow2_path}',
> +                         f'id=drive0,if=none,format=qcow2,file={qcow2_path}',
>                           '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
>          temp_vm.launch()
>  
>          self._require_host_secure_ipl_support(temp_vm)

If we find this fails the first time, then we are going to fail setup
and therefore the 2nd test will also enter here, create the qcow2 again,
and then fail again for the same reason.
Couldn't we also save the time spent creating the qcow2 and launching a
VM the second time if we know it didn't work the first time?  It's
checking the same host facilities.

Basically I'm wondering if we should just create another flag in
S390xSecureIpl that defaults to false and gets set to true in
_require_host_secure_ipl_support() if the support is missing.  And check
that flag in each test before checking _setup_done and skip right away
if it's true (with the same message as the one in
_require_host_secure_ipl_support().



