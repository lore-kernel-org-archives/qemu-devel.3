Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB789C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8X1F-0004zr-P0; Mon, 21 Sep 2026 01:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8X17-0004z6-KV; Mon, 21 Sep 2026 01:56:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8X15-0004Kd-Le; Mon, 21 Sep 2026 01:56:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3aMc13306760; Mon, 21 Sep 2026 05:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6dYT6h
 Up2Bk93iU86LFjOrnd3zV02sVsZi7zrI/kj9o=; b=ALpbMrC5N/i6QNBuuUxQTo
 Lr4TzFRHip8jHHqrN1pjLo2rMV5npy5eJr+B3YvAPoSrP2eFbBcssb95wiivvqM6
 lILGkyWvV/Z020Af3Tgtel9Tu7TOKRFWaMl5Tq30xG7CaCfD1vuccdhmpGtu6U7c
 O9fBIIPHe5+wpup7GOzABuX8wuRhIgythCSUKlbb+NDVlwaxZ2gn5asj5z66DR0f
 cMduIJX5/lSgE/MpTTVqnULrZlwxQgPBh5ZjhoSxOKcTl8VJ9Y3y7py542pl6cV2
 kcSxw8mdh9ZxqJOiEdIBuaMPWeHsyD7UPHvFmjQTqftYZ902OVl+LIaO0wsmbyGA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq6t7u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 05:56:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3XdYi689779; Mon, 21 Sep 2026 05:56:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt6xgbtee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 05:56:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68L5uXo6852538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 05:56:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 837A05805F;
 Mon, 21 Sep 2026 05:56:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E7F758059;
 Mon, 21 Sep 2026 05:56:29 +0000 (GMT)
Received: from [9.39.18.112] (unknown [9.39.18.112])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 05:56:28 +0000 (GMT)
Message-ID: <5fd2c8fd-e4d7-4e4c-a6e4-95494c633951@linux.ibm.com>
Date: Mon, 21 Sep 2026 11:26:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/functional/ppc64: extend pseries migration
 tests
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 rathc@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-2-asahu1x@linux.ibm.com>
 <20260918235644.a26929da-e7-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <20260918235644.a26929da-e7-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0c714 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=fjCNo8wLE_3PgtiQQ7sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfX/7nFOzVtThJz
 HqZDc1Cxcq1yjkgpAxGByzegcG4XxQnptBeFovTbGHmVItPFSPOy3YK/JulB/fzS3RadYAa+IxC
 sBKm5g5NwJgFFVaRg8w2nUj8R5Z83kapwh1oBpUjSb9rE/fjCt4sX6R6hIT9o5Glw4Av5RSHvKs
 eadRgI2bvhyo04tMjXfhrcbyog0R/VLMz6IdFx+lhuKlom3HlvEToSzDd68+a+08b8eIrH6m0CV
 D/U6CP9fcXugJxESG5MkvxhF0gzUJox1PFk8wm4JomhOGAOxt1dL6hrPaCHSXHaq6vWMGf+yFZ9
 48FgCgh1VHxjlrGg+SNWK2/WOMt2jPXvwXfQNBIrFTzd/WZjiOVstch9UbFacBQPvd66UqzQOZ5
 rRP0BYkWJj89r8/jlNEQUJkhVYBnYO8t4FQ1NQVEW3c5PX7KXTmzerYPzoRsiqBAimMs+dAIAcp
 fGkFvwuUa2jboc0EX8w==
X-Proofpoint-ORIG-GUID: mWBRGkuJBKVvJZwpeeWyZNzCo1RAO0Lk
X-Proofpoint-GUID: FTFmJCnd9Pxg0qIZI6wzQ9A-r5QuAjdQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfX8xfgdJNuRKeT
 0Jylncssx6sEcCJcM6/F9LCI1t44/Hc1lY+8DlwlDT9CHMq7pJTZ6ALYu6uyYnYy7j9+nizKliU
 MKmk5oCFNaU3sNNiwJY8mDtQUFvkdmE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210078
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


On 19/09/26 12:15 AM, Amit Machhiwal wrote:
> Hi Aniket,
>
> Thanks for the patches.  Please find my comments inline below.
>
> On 2026/09/16 04:06 PM, Aniket Sahu wrote:
>> Made a few changes to test_pseries.py to extend the migration
>> tests to validate exec (socat) and UNIX paths.
>>
>> - Refactored test_ppc64_linux_migration to a private method
>> _do_linux_migration(dst_uri, src_uri=None).
>> - It is then called by three separate methods which exercise the
>> TCP, UNIX and exec paths via the migrate_vms method from
>> MigrationTest.
>> ---
>>   tests/functional/ppc64/test_pseries.py | 41 ++++++++++++++++++++++----
>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
>> index cb6d25dc81..19f31141b1 100755
>> --- a/tests/functional/ppc64/test_pseries.py
>> +++ b/tests/functional/ppc64/test_pseries.py
>> @@ -8,8 +8,9 @@
>>   # later.  See the COPYING file in the top-level directory.
>>   
>>   from qemu_test import Asset
>> -from qemu_test import wait_for_console_pattern
>> +from qemu_test import wait_for_console_pattern, which
>>   from migration import MigrationTest
>> +from qemu_test.ports import Ports
>>   
>>   class PseriesMachine(MigrationTest):
>>   
>> @@ -88,12 +89,20 @@ def test_ppc64_linux_big_boot(self):
>>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>>   
>> -    def test_ppc64_linux_migration(self):
>> +    def _do_linux_migration(self, dst_uri, src_uri=None):
>> +        """
>> +        Boot a pseries kernel on a source VM, wait until Linux is up, then
>> +        migrate to a destination VM over the given URI(s) and verify the boot
>> +        continues on the destination.
>> +        """
>>           self.set_machine('pseries')
>>   
>>           kernel_path = self.ASSET_KERNEL.fetch()
>>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>>   
>> +        if src_uri is None:
>> +            src_uri = dst_uri
> The default behavior of src_uri=None is non-obvious from the docstring.  Could
> you mention that it defaults to dst_uri, and that callers using transports with
> different source and destination URIs (such as the exec: case below) need to
> provide src_uri explicitly?
>
>> +
>>           dest_vm = self.get_vm(name="dest-qemu")
>>           dest_vm.add_args('-incoming', 'defer')
>>           dest_vm.add_args('-smp', '4')
>> @@ -111,16 +120,38 @@ def test_ppc64_linux_migration(self):
>>           source_vm.set_console()
>>           source_vm.launch()
>>   
>> -        # ensure the boot has reached Linux
>> +        # ensure the boot has reached Linux before migrating
>>           console_pattern = 'smp: Brought up 1 node, 4 CPUs'
>>           wait_for_console_pattern(self, console_pattern, self.panic_message,
>>                                    vm=source_vm)
>>   
>> -        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
>> +        self.migrate_vms(dst_uri, src_uri, dest_vm, source_vm)
>>   
>> -        # ensure the boot proceeds after migration
>> +        # ensure the boot continues on the destination after migration
>>           wait_for_console_pattern(self, self.good_message, self.panic_message,
>>                                    vm=dest_vm)
>>   
>> +    def test_ppc64_linux_migration(self):
>> +        with Ports() as ports:
>> +            port = ports.find_free_port()
>> +            if port is None:
>> +                self.skipTest('Failed to find a free port')
>> +            self._do_linux_migration('tcp:localhost:%u' % port)
>> +
>> +    def test_ppc64_linux_migration_unix(self):
>> +        self._do_linux_migration(
>> +            'unix:%s/migration.sock' % self.socket_dir().name)
>> +
>> +    def test_ppc64_linux_migration_exec(self):
>> +        if not which('socat'):
>> +            self.skipTest('socat is not available')
>> +        with Ports() as ports:
>> +            port = ports.find_free_port()
>> +            if port is None:
>> +                self.skipTest('Failed to find a free port')
>> +            self._do_linux_migration(
>> +                'exec:socat TCP-LISTEN:%u -' % port,
>> +                'exec:socat - TCP:localhost:%u,forever' % port)
> I share Thomas's concern about CI cost.  With this patch, Linux is fully booted
> three times — once per transport variant — which significantly increases the
> wall-clock time of the pseries migration test slot.
>
> The UNIX and exec transport paths are already covered on ppc64 in
> tests/functional/ppc64/test_migration.py, though against mac99 rather than
> pseries.  If the intent is specifically to validate these transports on the
> pseries machine, that is a reasonable goal — but does it require a full Linux
> boot?  The transport layer is independent of what the guest is running.  A
> firmware-only pseries migration (as was done in v1) would cover the
> pseries-specific migration path with substantially lower CI cost.
>
> Please clarify in the commit message why a full Linux boot is needed here, or
> consider using a firmware-only guest for the two new tests.\

Hi Amit, Thomas,

I do agree that full boot test cases might be unnecessary, however it 
was suggested by Harsh during offline discussions that if a full boot 
test already exists for TCP, so perhaps the best course of action here 
is to revert back to the firmware-only test cases from v1. I do need 
suggestions on if we should extend test_migration.py or make a new file 
for the ppc machines.

Thanks and Regards,
Aniket.


