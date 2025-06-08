Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C64C5B552
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 22:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOO5M-0005gW-V6; Sun, 08 Jun 2025 18:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOO5K-0005g6-Nb
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:01:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOO5G-0006LY-Hs
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:01:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558LHioU020816;
 Sun, 8 Jun 2025 22:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=esMIRd
 v/dQOMEilpq6pVjGfI95MFVXJzXEtUKGud7zU=; b=q7zgMOlMQdsV5qORGTLyGV
 yPFoiYsCaPZ5EQ8Nyb3BsaIcRwdlyqGsu7uJb1TgH6MRjR8INd8eZFbyRyEyCreS
 dQWzMckWT3aaxLhFXqoHbfuCze+4ELK+2ZUHfkaLAaUHjCqKML8WPGxovWZ9JkXY
 Quy3AVrnqYX96NWj0XhWcGv7ZQrpSK6z8LAgBMxr460x8NBbVnvX9B9NISCITNAP
 crolPZJZFwsJUo8ha5S4cFKOBMMn0C7sUVO5cj5sjnQbEL82LH9kWcPvvMp2x2E7
 +YULPyVvA1EZ35FVcdShNbsN+hANoRkc0TRH8R6tTExqjtJdyWClfbXScnWVR+BA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bunnwba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 22:01:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 558JM3U4003405;
 Sun, 8 Jun 2025 22:01:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykb0w6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 22:01:37 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 558M1aqr25952986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 8 Jun 2025 22:01:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9211158065;
 Sun,  8 Jun 2025 22:01:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FEF85805D;
 Sun,  8 Jun 2025 22:01:36 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  8 Jun 2025 22:01:36 +0000 (GMT)
Message-ID: <e05bab3e-1b2f-417b-a2f3-275911ea9725@linux.ibm.com>
Date: Sun, 8 Jun 2025 17:01:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: Steven Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
 <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68460842 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=vBUJGRUMAu4ITCuFGfoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDE3NyBTYWx0ZWRfX/0hyiqHaN6ls
 kSJKz3W1i5H5tTxzQaJvEHcuSEwD1n1slOHaSmT2J3eRTEVpiSf5EomXrJVJcecHU2VzX6++9Xb
 gQl04X9cA0fmqw3s7Y/6vlQQsthBZtPR5XCUCrGrCXtx6heG6c0AEirxAtj7yLQoRq7F0Rrzd5D
 dALHhBJkdE4cuRDKSzSjx/fqIruj788GncJERXNXlZzSECDdEFUkSfgdikeQnLCgcJt/PI544+m
 4h+Ed+5mLLyx3FOg4i+BF2c0rWRT2JxH/hzauKH9In2k1e/y3EdweJD4+Byrf0iElEXZRKVme7O
 9DYVYQek9CFCACGb4Xolr8YqjNwvl16eBrOKBkibmPhOMu1Nc2aBDMJLF8PO9km1PPV2yrwzqLD
 qhnUX8KfXS/qhCU3qdCuBWMp2SIhwOxgsJucmflOeB2mtxtgn6jhFfoOldQzZD2hxyXMm5E/
X-Proofpoint-GUID: jOOVdksciQtp5oTXYBmMj9kzh06seg9R
X-Proofpoint-ORIG-GUID: jOOVdksciQtp5oTXYBmMj9kzh06seg9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506080177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 6/6/2025 2:37 PM, Steven Sistare wrote:
> On 6/6/2025 2:06 PM, JAEHOON KIM wrote:
>> On 6/6/2025 12:04 PM, Steven Sistare wrote:
>>> On 6/6/2025 12:06 PM, Daniel P. Berrangé wrote:
>>>> On Fri, Jun 06, 2025 at 11:50:10AM -0400, Steven Sistare wrote:
>>>>> On 6/6/2025 11:43 AM, Daniel P. Berrangé wrote:
>>>>>> On Fri, Jun 06, 2025 at 10:37:28AM -0500, JAEHOON KIM wrote:
>>>>>>> On 6/6/2025 10:12 AM, Steven Sistare wrote:
>>>>>>>> On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
>>>>>>>>> On 6/6/2025 9:14 AM, Steven Sistare wrote:
>>>>>>>>>> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>>>>>>>>>>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>>>>>>>>>>> When the source VM attempts to connect to the destination 
>>>>>>>>>>>> VM's Unix
>>>>>>>>>>>> domain socket(cpr.sock) during CPR transfer, the socket
>>>>>>>>>>>> file might not
>>>>>>>>>>>> yet be exist if the destination side hasn't completed the bind
>>>>>>>>>>>> operation. This can lead to connection failures when
>>>>>>>>>>>> running tests with
>>>>>>>>>>>> the qtest framework.
>>>>>>>>>>>
>>>>>>>>>>> This sounds like a flawed test impl to me - whatever is 
>>>>>>>>>>> initiating
>>>>>>>>>>> the cpr operation on the source has done so prematurely - it 
>>>>>>>>>>> should
>>>>>>>>>>> ensure the dest is ready before starting the operation.
>>>>>>>>>>>
>>>>>>>>>>>> To address this, add cpr_validate_socket_path(), which wait 
>>>>>>>>>>>> for the
>>>>>>>>>>>> socket file to appear. This avoids intermittent qtest
>>>>>>>>>>>> failures caused by
>>>>>>>>>>>> early connection attempts.
>>>>>>>>>>>
>>>>>>>>>>> IMHO it is dubious to special case cpr in this way.
>>>>>>>>>>
>>>>>>>>>> I agree with Daniel, and unfortunately it is not just a test 
>>>>>>>>>> issue;
>>>>>>>>>> every management framework that supports cpr-transfer must 
>>>>>>>>>> add logic to
>>>>>>>>>> wait for the cpr socket to appear in the target before 
>>>>>>>>>> proceeding.
>>>>>>>>>>
>>>>>>>>>> This is analogous to waiting for the monitor socket to appear 
>>>>>>>>>> before
>>>>>>>>>> connecting to it.
>>>>>>>>>>
>>>>>>>>>> - Steve
>>>>>>>>>
>>>>>>>>> Thank you very much for your valuable review and feedback.
>>>>>>>>>
>>>>>>>>> Just to clarify, the added cpr_validate_socket_path() function is
>>>>>>>>> not limited to the test framework.
>>>>>>>>> It is part of the actual CPR implementation and is intended to
>>>>>>>>> ensure correct behavior in all cases, including outside of tests.
>>>>>>>>>
>>>>>>>>> I mentioned the qtest failure simply as an example where this 
>>>>>>>>> issue
>>>>>>>>> became apparent.
>>>>>>>>
>>>>>>>> Yes, I understand that you understand :)
>>>>>>>> Are you willing to move your fix to the qtest?
>>>>>>>>
>>>>>>>> - Steve
>>>>>>>
>>>>>>> Thank you for your question and feedback.
>>>>>>>
>>>>>>> I agree that the issue could be addressed within the qtest 
>>>>>>> framework to
>>>>>>> improve stability.
>>>>>>>
>>>>>>> However, this socket readiness check is a fundamental part of 
>>>>>>> CPR transfer
>>>>>>> process,
>>>>>>> and I believe that incorporating cpr_validate_socket_path() 
>>>>>>> directly into
>>>>>>> the CPR implementation helps ensure more reliable behavior
>>>>>>> across all environments - not only during testing.
>>>>>>>
>>>>>>> Just from my perspective, adding this logic to the CPR code does 
>>>>>>> not
>>>>>>> introduce significant overhead or side effects.
>>>>>>> I would appreciate if you could share more details about your 
>>>>>>> concerns, so I
>>>>>>> can better address them.
>>>>>>
>>>>>> Requiring a busy wait like this is a sign of a design problem.
>>>>>>
>>>>>> There needs to be a way to setup the incoming socket listener
>>>>>> without resorting to busy waiting - that's showing a lack of
>>>>>> synchronization.
>>>>>
>>>>> How is this a design problem?  If I start a program that creates a 
>>>>> listening unix
>>>>> domain socket, I cannot attempt to connect to it until the socket 
>>>>> is created and
>>>>> listening. Clients face the same issue when starting qemu and 
>>>>> connecting to the
>>>>> monitor socket.
>>>>
>>>> Yes, the monitor has the same conceptual problem, and this caused 
>>>> problems
>>>> for libvirt starting QEMU for many years.
>>>>
>>>> With the busy wait you risk looping forever if the child (target) QEMU
>>>> already exited for some reason without ever creating the socket. You
>>>> can mitigate this by using 'kill($PID, 0)' in the loop and looking
>>>> for -ERSCH, but this only works if you know the pid involved.
>>>>
>>>> One option is to use 'daemonize' such that when the parent sees the 
>>>> initial
>>>> QEMU process leader exit, the parent has a guarantee that the 
>>>> daemonized
>>>> QEMU already has the UNIX listener open, and any failure indicates 
>>>> QEMU
>>>> already quit.
>>>>
>>>> The other option is to use FD passing such that QEMU is not 
>>>> responsible
>>>> for opening the listener socket - it gets passed a pre-opened listener
>>>> FD, so the parent has a guarantee it can successfull connect 
>>>> immediately
>>>> and any failure indicates QEMU already quit.
>>>>
>>>> For the tests, passing a pre-opened UNIX socket FD could work, but I'm
>>>> still curious why this is only a problem for the CPR tests, and not
>>>> the other migration tests which don't use 'defer'. What has made CPR
>>>> special to expose a race ?
>>>
>>> For normal migration, target qemu listens on the migration socket, 
>>> then listens
>>> on the monitor.  After the client connects to the monitor (waiting 
>>> for it to appear
>>> as needed), them the migration socket already exists.
>>>
>>> For cpr, target qemu creates the cpr socket and listens before the 
>>> monitor is
>>> started, which is necessary because cpr state is needed before 
>>> backends or
>>> devices are created.
>>>
>>> A few months back I sent a series to start the monitor first (I 
>>> think I called
>>> it the precreate phase), but it was derailed over discussions about 
>>> allowing
>>> qemu to start with no arguments and be configured exclusively via 
>>> the monitor.
>>>
>>> - Steve
>>
>> Thank you for sharing your thoughts.
>>
>> I agree that busy waiting is not ideal.
>> However, considering the timing of when target QEMU creates and 
>> begins listening on the socket,
>> I think there is currently no reliable way for the host to check the 
>> socket's listening state.
>> This also implies that FD passing is not a viable option in this case.
>>
>> As for the 'defer' option in qtest,
>> it doesn't cause race-condition issues because the target enters the 
>> listening state during the option processing.
>>
>> Of course, to address this issue,
>> I could create a wait_for_socket() function similar to 
>> wait_for_serial() in qtest framework.
>> Since the socket might already be created, I cannot simply wait for 
>> the file to appear using file system notification APIs like inotify,
>> so busy-waiting would still be necessary.
>>
>> I would appreciate hearing any further thoughts you might have on this.
>
> The easiest solution, with no interface changes, is adding 
> wait_for_socket() in qtest,
> with this addition from Daniel:
>
>   "With the busy wait you risk looping forever if the child (target) QEMU
>   already exited for some reason without ever creating the socket. You
>   can mitigate this by using 'kill($PID, 0)' in the loop and looking
>   for -ERSCH, but this only works if you know the pid involved."
>
> Daniel also suggested:
>   "For the tests, passing a pre-opened UNIX socket FD could work"
>
> Note we can not use any of the standard chardev options to specify 
> such a socket,
> because the cpr socket is created before chardevs are created.
>
> Perhaps we could specify the fd in an extension of the 
> MigrationChannel MigrationAddress.
> { 'union': 'MigrationAddress',
>   'base': { 'transport' : 'MigrationAddressType'},
>   'discriminator': 'transport',
>   'data': {
>     'socket': 'SocketAddress',
>     'exec': 'MigrationExecCommand',
>     'rdma': 'InetSocketAddress',
>     'file': 'FileMigrationArgs',
>     'fd':   'FdMigrationArgs' } }           <-- add this
>
> That would be useful for all clients, but this is asking a lot from you,
> when you are just trying to fix the tests.
>
> - Steve
>
>
Thanks for the feedback and suggestions.

I'll update the patch to v2 accordingly.

- Jaehoon Kim



