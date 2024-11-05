Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A262CD31765
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 17:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MxJ-0002gB-Lc; Tue, 05 Nov 2024 12:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8MxH-0002fL-QK; Tue, 05 Nov 2024 12:02:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t8MxF-0005v2-UJ; Tue, 05 Nov 2024 12:02:59 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5GeMmh017989;
 Tue, 5 Nov 2024 17:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0G8rQh
 32is91C3M1CMRGfNPAYsQASDlPrceKxCGihus=; b=VAoYBHZK2BZXqzbxDdbFKo
 ygdTxjpsAFifCfocg7XZvhahuw601DS8zwe+zpaFZExIOryLaVFpwyArpXlCIKLP
 qvGBum7aV7LpEQro8jHnfYWlzdIfwEwo5DbTNZ8JeG2TRGGt+fzWGu3A748qTlnC
 UuJ4bTQVT3EYg9G7rI6x9nrZW54XZcJUD2Gq6qkpQeQIoMEiA9/w85sxduNDmlIp
 vB9a3mlW7HDJTOyAEyCKmBjElC8K5Icyz6dN6Dd1HyFankYRVR7fx2s4Hmq1AQGr
 22SDIi1PIk6CPWr07CDEBjH16RvDBLgw+mYP/jNHp6LNTZ5S7OxxMQJ6oM2jfmNg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qq338321-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 17:02:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A572Wfs032050;
 Tue, 5 Nov 2024 16:35:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmmftk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 16:35:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5GZkDp35389742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 16:35:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADA615805E;
 Tue,  5 Nov 2024 16:35:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5964058052;
 Tue,  5 Nov 2024 16:35:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2024 16:35:46 +0000 (GMT)
Message-ID: <91c2ac92-66b2-45c8-b4fe-e8f8587b0e9c@linux.ibm.com>
Date: Tue, 5 Nov 2024 11:35:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <20241024063507.1585765-1-clg@redhat.com>
 <20241024063507.1585765-11-clg@redhat.com>
 <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rx-I2AlFrS8dg34q4sO6rlJt85e6h0gq
X-Proofpoint-GUID: Rx-I2AlFrS8dg34q4sO6rlJt85e6h0gq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050128
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/5/24 11:14 AM, Peter Maydell wrote:
> On Thu, 24 Oct 2024 at 07:39, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> This is a simple conversion of the tests with some cleanups and
>> adjustments to match the new test framework. Replace the zephyr image
>> MD5 hashes with SHA256 hashes while at it.
> 
> (ccing Stefan Berger for possible insight into swtpm)
> 
> Hi; I find that this swtpm-using test fails for me on my
> local system due to an apparmor/swtpm problem...
> 
>> +    @skipUnless(*has_cmd('swtpm'))
>> +    def test_arm_ast2600_evb_buildroot_tpm(self):
>> +        self.set_machine('ast2600-evb')
>> +
>> +        image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
>> +
>> +        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
>> +        socket = os.path.join(socket_dir.name, 'swtpm-socket')
>> +
>> +        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
>> +                        '--tpmstate', f'dir={self.vm.temp_dir}',
>> +                        '--ctrl', f'type=unixio,path={socket}'])
>> +
>> +        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
>> +        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
>> +        self.vm.add_args('-device',
>> +                         'tpm-tis-i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
>> +        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
>> +
>> +        exec_command_and_wait_for_pattern(self,
>> +            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
>> +            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
>> +        exec_command_and_wait_for_pattern(self,
>> +            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
>> +            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
>> +
>> +        self.do_test_arm_aspeed_buildroot_poweroff()
> 
> The test fails like this:
> 
> qemu-system-arm: tpm-emulator: TPM result for CMD_INIT: 0x9 operation failed
> 
> Adding extra logging to swtpm (--log file=/tmp/swtpm.log,level=20)
> reveals:
> 
> SWTPM_NVRAM_Lock_Lockfile: Could not open lockfile: Permission denied
> Error: Could not initialize libtpms.
> Error: Could not initialize the TPM
> 
> Checking the system logs, this is because apparmor has denied it:
> 
> Nov  5 16:01:14 e104462 kernel: [946406.489088] audit: type=1400
> audit(1730822474.384:446): apparmor="DENIED" operation="mknod"
> profile="swtpm"
> name="/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/tests/functional/arm/test_arm_aspeed.AST2x00Machine.test_arm_ast2600_evb_buildroot_tpm/qemu-machine-hhuvwytc/.lock"
> pid=2820156 comm="swtpm" requested_mask="c" denied_mask="c" fsuid=1000
> ouid=1000
> 
> 
> 
> Q1: why is apparmor forbidding swtpm from doing something that
> it needs to do to work?

What distro and version is this?

The profile may be too strict and not reflecting all the paths needed 
for running the test cases. Ubuntu for example would have to update 
their profile in such a case.

> 
> Q2: is there a way to run swtpm such that it is not
> confined by apparmor, for purposes of running it in a test case?

Try either one:
- sudo aa-complain /usr/bin/swtpm
- sudo aa-disable /usr/bin/swtpm

> 
> Q3: if not, is there a way to at least detect that swtpm is
> broken on this system so we can skip the test case?

It's not swtpm that is broken but the AppArmor profile is too strict. 
Above command lines should work.

> 
> (I note that there is a thing in the apparmor config
> "owner @{HOME}/** rwk" which I think means you only run into
> this if you happen to be building/testing QEMU somewhere other
> than your own home directory -- but that's hardly an
> unreasonable configuration...)
> 
> thanks
> -- PMM


