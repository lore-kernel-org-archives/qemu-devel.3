Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1861C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8YMX-0003Nx-8w; Mon, 21 Sep 2026 03:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8YMU-0003NE-Kh; Mon, 21 Sep 2026 03:22:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8YMS-00041y-GR; Mon, 21 Sep 2026 03:22:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3aefX311561; Mon, 21 Sep 2026 07:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Lxdtdc
 Wt0dNFQ0kcR4FfQEho3zYbdF/1kalSUvjkGAY=; b=ia23jxIDm7B+EWk3rASXyX
 I7Hh0SwwAwxdH2YmXAXknUoOOjwFvaMm4BzCwuQ8YjC9w99c8eAKFIlKrg3BMnIC
 WxUy2sMLSDoKagDhdHdwRIyTda6v3sg7S8mxzvjHariqirR0/JXBOZdQxNogu619
 z02PHbNpHxr/tLZsiokiVDrrgq+gmc6jIk9eMM1opou0BD6ZDpViyqbjVOK4veyV
 5FtV9IQgSicNhoeZoyzgBTiy5QlGEKU/Ytye7iDK8F9qvXhRyGkDfa6X36aSydq3
 LCP7c2OU/vqv5YqC4+/fgwyyDEeda5xzjFKj0hd/okHnVgmu9+r10bDE3mn2ccTA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduy4h4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 07:22:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7Hm9X887480; Mon, 21 Sep 2026 07:22:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gm6th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 07:22:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68L7M1WQ21430790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 07:22:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ED7958043;
 Mon, 21 Sep 2026 07:22:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5EA158053;
 Mon, 21 Sep 2026 07:22:39 +0000 (GMT)
Received: from [9.39.18.112] (unknown [9.39.18.112])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 07:22:39 +0000 (GMT)
Message-ID: <d16495fa-b67d-406f-9173-b8b89e97197c@linux.ibm.com>
Date: Mon, 21 Sep 2026 12:52:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/functional/ppc64: extend pseries migration
 tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-2-asahu1x@linux.ibm.com>
 <20260918235644.a26929da-e7-amachhiw@linux.ibm.com>
 <5fd2c8fd-e4d7-4e4c-a6e4-95494c633951@linux.ibm.com>
 <6b96c87b-a1c5-4a84-818c-a56e847faaec@redhat.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <6b96c87b-a1c5-4a84-818c-a56e847faaec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QpjnNV8L4ZLzvQqyx8VqvAujvjfZWLED
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX2lkJv3Xum3la
 Z0ubVd4k1LJhLaCS2lZbGFklDxan62fWNb48RBqK9iED+1ITOyEzoejx0UvhIsRCLZ2ViqfHNN4
 BjZYvUwpmI0wiiIB3KiERx8eHcS08aA=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0db46 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Wh-1zc9cI8rVBDtN4YIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: fxQ6F44uOcvNlx9mUCtgQ3VLm6jUrqak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX0OHeqpbBt+zZ
 pCyM8D2Mdum3oABNAqmMZKudZQ1Y6xdUVxI+AcHpeCLiAmQqCoT8Jp/4WB57Gr+08mh+PIY3HJn
 Rn+ZeuMclXY+OWwlGjMA8eLNsuWWOT5n99XynhgYZySR0dVqeNrhLvNoYf+PvfSb+8XJvClV2VR
 Tly7SeyRKe5n5Vb+nCJB3ncIiiGfWxjdEwGaXRqwea4nIQcSg4NyqcDNA8cUc9nbngx+g7gIUmW
 O8Vpn81z+yq5PzVCoqSVtjhkfsrobCVIeuvYjG9u2wFj1l2iOnFaBNw0Ao6oLw0WYb6ilhHDI14
 sArLJsLxJ/n0m4vpoLPSNuoruKdFZnivqmqiG4vlCqyn6MPOrjWdejkPpRkkxbs172eY7j7C7F+
 gN8oSD1QTX39OJE4ltN/B7D75C16ph7aiJUi8WbeaLN3B8na+NPy9a1b1jktbtCfETmigr2y+YW
 O+Gh4KrzO8MHjl9gcVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210100
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


On 21/09/26 12:11 PM, Thomas Huth wrote:
> On 21/09/2026 07.56, Aniket Sahu wrote:
>>
>> On 19/09/26 12:15 AM, Amit Machhiwal wrote:
>>> Hi Aniket,
>>>
>>> Thanks for the patches.  Please find my comments inline below.
>>>
>>> On 2026/09/16 04:06 PM, Aniket Sahu wrote:
>>>> Made a few changes to test_pseries.py to extend the migration
>>>> tests to validate exec (socat) and UNIX paths.
>>>>
>>>> - Refactored test_ppc64_linux_migration to a private method
>>>> _do_linux_migration(dst_uri, src_uri=None).
>>>> - It is then called by three separate methods which exercise the
>>>> TCP, UNIX and exec paths via the migrate_vms method from
>>>> MigrationTest.
>>>> ---
>>>>   tests/functional/ppc64/test_pseries.py | 41 
>>>> ++++++++++++++++++++++----
>>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tests/functional/ppc64/test_pseries.py 
>>>> b/tests/functional/ ppc64/test_pseries.py
>>>> index cb6d25dc81..19f31141b1 100755
>>>> --- a/tests/functional/ppc64/test_pseries.py
>>>> +++ b/tests/functional/ppc64/test_pseries.py
>>>> @@ -8,8 +8,9 @@
>>>>   # later.  See the COPYING file in the top-level directory.
>>>>   from qemu_test import Asset
>>>> -from qemu_test import wait_for_console_pattern
>>>> +from qemu_test import wait_for_console_pattern, which
>>>>   from migration import MigrationTest
>>>> +from qemu_test.ports import Ports
>>>>   class PseriesMachine(MigrationTest):
>>>> @@ -88,12 +89,20 @@ def test_ppc64_linux_big_boot(self):
>>>>           wait_for_console_pattern(self, console_pattern, 
>>>> self.panic_message)
>>>>           wait_for_console_pattern(self, self.good_message, 
>>>> self.panic_message)
>>>> -    def test_ppc64_linux_migration(self):
>>>> +    def _do_linux_migration(self, dst_uri, src_uri=None):
>>>> +        """
>>>> +        Boot a pseries kernel on a source VM, wait until Linux is 
>>>> up, then
>>>> +        migrate to a destination VM over the given URI(s) and 
>>>> verify the boot
>>>> +        continues on the destination.
>>>> +        """
>>>>           self.set_machine('pseries')
>>>>           kernel_path = self.ASSET_KERNEL.fetch()
>>>>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>>>> +        if src_uri is None:
>>>> +            src_uri = dst_uri
>>> The default behavior of src_uri=None is non-obvious from the 
>>> docstring.  Could
>>> you mention that it defaults to dst_uri, and that callers using 
>>> transports with
>>> different source and destination URIs (such as the exec: case below) 
>>> need to
>>> provide src_uri explicitly?
>>>
>>>> +
>>>>           dest_vm = self.get_vm(name="dest-qemu")
>>>>           dest_vm.add_args('-incoming', 'defer')
>>>>           dest_vm.add_args('-smp', '4')
>>>> @@ -111,16 +120,38 @@ def test_ppc64_linux_migration(self):
>>>>           source_vm.set_console()
>>>>           source_vm.launch()
>>>> -        # ensure the boot has reached Linux
>>>> +        # ensure the boot has reached Linux before migrating
>>>>           console_pattern = 'smp: Brought up 1 node, 4 CPUs'
>>>>           wait_for_console_pattern(self, console_pattern, 
>>>> self.panic_message,
>>>>                                    vm=source_vm)
>>>> -        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
>>>> +        self.migrate_vms(dst_uri, src_uri, dest_vm, source_vm)
>>>> -        # ensure the boot proceeds after migration
>>>> +        # ensure the boot continues on the destination after 
>>>> migration
>>>>           wait_for_console_pattern(self, self.good_message, 
>>>> self.panic_message,
>>>>                                    vm=dest_vm)
>>>> +    def test_ppc64_linux_migration(self):
>>>> +        with Ports() as ports:
>>>> +            port = ports.find_free_port()
>>>> +            if port is None:
>>>> +                self.skipTest('Failed to find a free port')
>>>> +            self._do_linux_migration('tcp:localhost:%u' % port)
>>>> +
>>>> +    def test_ppc64_linux_migration_unix(self):
>>>> +        self._do_linux_migration(
>>>> +            'unix:%s/migration.sock' % self.socket_dir().name)
>>>> +
>>>> +    def test_ppc64_linux_migration_exec(self):
>>>> +        if not which('socat'):
>>>> +            self.skipTest('socat is not available')
>>>> +        with Ports() as ports:
>>>> +            port = ports.find_free_port()
>>>> +            if port is None:
>>>> +                self.skipTest('Failed to find a free port')
>>>> +            self._do_linux_migration(
>>>> +                'exec:socat TCP-LISTEN:%u -' % port,
>>>> +                'exec:socat - TCP:localhost:%u,forever' % port)
>>> I share Thomas's concern about CI cost.  With this patch, Linux is 
>>> fully booted
>>> three times — once per transport variant — which significantly 
>>> increases the
>>> wall-clock time of the pseries migration test slot.
>>>
>>> The UNIX and exec transport paths are already covered on ppc64 in
>>> tests/functional/ppc64/test_migration.py, though against mac99 
>>> rather than
>>> pseries.  If the intent is specifically to validate these transports 
>>> on the
>>> pseries machine, that is a reasonable goal — but does it require a 
>>> full Linux
>>> boot?  The transport layer is independent of what the guest is 
>>> running.  A
>>> firmware-only pseries migration (as was done in v1) would cover the
>>> pseries-specific migration path with substantially lower CI cost.
>>>
>>> Please clarify in the commit message why a full Linux boot is needed 
>>> here, or
>>> consider using a firmware-only guest for the two new tests.\
>>
>> Hi Amit, Thomas,
>>
>> I do agree that full boot test cases might be unnecessary, however it 
>> was suggested by Harsh during offline discussions that if a full boot 
>> test already exists for TCP, so perhaps the best course of action 
>> here is to revert back to the firmware-only test cases from v1. I do 
>> need suggestions on if we should extend test_migration.py or make a 
>> new file for the ppc machines.
> I think I'd just turn "mac99" in test_migration_with_unix() and 
> test_migration_with_exec() in test_migration.py into "pseries", and 
> keep the "mac99" in the tcp test there. That should give enough test 
> coverage for both machines in quick test mode.
>
Ack. Writing a follow-up patch with only the following change for 
covering the alternate path tests for pseries.

--- a/tests/functional/ppc64/test_migration.py
+++ b/tests/functional/ppc64/test_migration.py
@@ -15,11 +15,11 @@ def test_migration_with_tcp_localhost(self):
          self.migration_with_tcp_localhost()

      def test_migration_with_unix(self):
-        self.set_machine('mac99')
+        self.set_machine('pseries')
          self.migration_with_unix()

      def test_migration_with_exec(self):
-        self.set_machine('mac99')
+        self.set_machine('pseries')
          self.migration_with_exec()

Regards,
Aniket.


