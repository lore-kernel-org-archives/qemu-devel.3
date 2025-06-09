Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3612C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdt9-0002cw-Tx; Mon, 09 Jun 2025 10:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOdt8-0002cm-3F
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:54:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOdt2-0001Hp-PT
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:54:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559DF68g029062;
 Mon, 9 Jun 2025 14:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=UuVyOK/rdWWmfxjpGTPYY2Ls8f71d+
 7vttuayoQHvEM=; b=eGXMBpZnqt4KrsaebPpzB3vCmkxFnlzRuS0Eej5BmPAQz1
 fnZ8SR++IvrmQwrQpnjwOzDzTDIeydfQ+Dp1R7QWVVCiOKKs9DtSC8WbJU7lNxOr
 FvOCosvXLTGmGRLenCCMQQx6p2MZZkdaoGYEP9n40pj1Q6R6nOD1laieXUkJW6jh
 8yOut5OCHIRaAtunpkZM3pcWIWxLscX0oT/XQQcPjg1mNsQHnvch31gOT3KbxQ00
 pCsGORxxz68he9Bkut6sUeCmQTLkNDLdep4XdBoiS393IATStShxx0u7putUWgS5
 lDFaZu4yYJyoK3yf9KEKgHxmyQ/8EwsMJCGdUjlg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxj199b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 14:54:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559DLZZa015191;
 Mon, 9 Jun 2025 14:54:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrt6d0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 14:54:05 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559Es42S19267932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 14:54:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6096758067;
 Mon,  9 Jun 2025 14:54:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A86AF58052;
 Mon,  9 Jun 2025 14:54:03 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 14:54:03 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------Ka5T9qEUR6voDjSgeMI5B4Qg"
Message-ID: <45458e9f-ef59-43e3-abd6-5d923575afa4@linux.ibm.com>
Date: Mon, 9 Jun 2025 09:54:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
 <aEaWC_Lc6c1g821f@redhat.com>
 <f46393bb-115a-489f-aa8d-08348e89d25e@oracle.com>
 <aEbfuM681MJh2S-b@redhat.com>
 <881cb07a-95c7-4f3b-8012-352873e88d64@oracle.com>
 <aEbmvQXyCLMKSy_8@redhat.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <aEbmvQXyCLMKSy_8@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7wOsiTE4QaGhI4Tp4U4YMecvRwM2_HFI
X-Proofpoint-GUID: 7wOsiTE4QaGhI4Tp4U4YMecvRwM2_HFI
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=6846f58e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=dqTSvHTbF_JwFlo1G-AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=20KFwNOVAAAA:8
 a=c258J1mwZ68sw83ccFIA:9 a=mRI2mt6nTbyK08zs:21 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEwNSBTYWx0ZWRfX0WaiX2SIed4P
 0EqPl0RtAVI9y6ZYR5c95syeiY2ykMXvQsL9worI2XEVaVaOLFvkf4swLXWIA9JkohTIBOAn4QC
 FtwwwL4IB+blV73CdCgp5bmGK1Mcqc5jnc3R2J8gfaaVvexsTpwkpoYRf8ABI+6WvMQl7eGHOWi
 eLBFSbRrBaRtmgYqtV2XT8eBemWHVd+KpoZoWXx/PZPTH1W8TXMQM+GY7igRIBYWXJzyEA5KoVN
 E3GTodTw3gSYbvAXIMMBQtCcYfKbF7j3LCYVH72fSBhD9fARdqmg6WfkGLjLbcnTyIUbpuGY2Vu
 4f3XLlNatvmXkvSUrTiL0GDvb531QJKrgz5bCioA7z2ccwByUN1s5PfkNep3Hw7X/yvhNCC8sB+
 kI5Ouf9QoB4V+0qaeUB7N7QiqBb+U4rioJC8T1bDftEMx8wLkzbow9IWceXlXXi5Nc6jH5/+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------Ka5T9qEUR6voDjSgeMI5B4Qg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/9/2025 8:50 AM, Daniel P. Berrangé wrote:
> On Mon, Jun 09, 2025 at 09:39:48AM -0400, Steven Sistare wrote:
>> On 6/9/2025 9:20 AM, Daniel P. Berrangé wrote:
>>> On Mon, Jun 09, 2025 at 09:12:27AM -0400, Steven Sistare wrote:
>>>> On 6/9/2025 4:06 AM, Daniel P. Berrangé wrote:
>>>>> On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
>>>>>> The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
>>>>>> with this addition from Daniel:
>>>>>>
>>>>>>      "With the busy wait you risk looping forever if the child (target) QEMU
>>>>>>      already exited for some reason without ever creating the socket. You
>>>>>>      can mitigate this by using 'kill($PID, 0)' in the loop and looking
>>>>>>      for -ERSCH, but this only works if you know the pid involved."
>>>>>>
>>>>>> Daniel also suggested:
>>>>>>      "For the tests, passing a pre-opened UNIX socket FD could work"
>>>>>>
>>>>>> Note we can not use any of the standard chardev options to specify such a socket,
>>>>>> because the cpr socket is created before chardevs are created.
>>>>>>
>>>>>> Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
>>>>>> { 'union': 'MigrationAddress',
>>>>>>      'base': { 'transport' : 'MigrationAddressType'},
>>>>>>      'discriminator': 'transport',
>>>>>>      'data': {
>>>>>>        'socket': 'SocketAddress',
>>>>>>        'exec': 'MigrationExecCommand',
>>>>>>        'rdma': 'InetSocketAddress',
>>>>>>        'file': 'FileMigrationArgs',
>>>>>>        'fd':   'FdMigrationArgs' } }           <-- add this
>>>>>>
>>>>>> That would be useful for all clients, but this is asking a lot from you,
>>>>>> when you are just trying to fix the tests.
>>>>> Note, 'SocketAddress' already has an option for declaring a FD that
>>>>> represents a socket.
>>>> Yes, but if I understand, you proposed passing an fd that represents a
>>>> pre-listened socket, which requires target qemu to accept() first.  The
>>>> existing FdSocketAddress is ready to read.  We could add a boolean to enable
>>>> the new behavior.
>>> It can do both actually - it depends on what APIs the QEMU uses the
>>> SocketAddress with.
>>>
>>> If it is used with qio_channel_socket_connect* the FD must be an
>>> active peer connection.
>>>
>>> If it is used with qio_channel_socket_listen*/qio_net_listener* the
>>> FD must be listener socket.
>> Fair enough.  cpr currently listens here, and we could add a case for the FD:
>>
>>    QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>>    {
>>      MigrationAddress *addr = channel->addr;
>>
>>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>>          addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>>          ...
>>          g_autoptr(QIONetListener) listener = qio_net_listener_new();
>>
>> Or to use my socketpair() suggestion, that function would also need changes,
>> calling qio_channel_socket_connect.
>>
>> Which do you think is better for clients -- socketpair or pre-listened?
> Please just use the existing SocketAddress functionality, as that's used
> throughout QEMU - a special case with socketpair for migration is not
> desirable.
>
> The SocketAddress stuff is what libvirt's used for many years now to
> address the race condition with QMP listeners.
>
> With regards,
> Daniel

Dear Daniel and Steve,

Thank you both for your valuable insights.

To clarify regarding the socket handling approach:
If I do not use socketpair() and instead pass a pre-listened FD to the target, which then calls accept(),
it seems this could mitigate some race condition. However, isn't there still a risk that the old QEMU might try to
connect before the target QEMU calls accept(), thereby resulting in the same race condition?

If I only consider the qtest environment, it seems to me that waiting for the target to create cpr.sock inside qtest framework
- along with checking the process status {kill(pid,0)} - might be the most efficient way to handle this.

I checked and found that the QTestState structure already has a "pid_t qemu_pid" field,
so it should be straightforward to check the target's PID.

 From your experience,
which approach do you consider the most effective to solve the current race condition issue?

I would appreciate your thoughts.

- Jaehoon Kim

--------------Ka5T9qEUR6voDjSgeMI5B4Qg
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
    <div class="moz-cite-prefix">On 6/9/2025 8:50 AM, Daniel P. Berrangé
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aEbmvQXyCLMKSy_8@redhat.com">
      <pre wrap="" class="moz-quote-pre">On Mon, Jun 09, 2025 at 09:39:48AM -0400, Steven Sistare wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 6/9/2025 9:20 AM, Daniel P. Berrangé wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Mon, Jun 09, 2025 at 09:12:27AM -0400, Steven Sistare wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 6/9/2025 4:06 AM, Daniel P. Berrangé wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">
The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
with this addition from Daniel:

    "With the busy wait you risk looping forever if the child (target) QEMU
    already exited for some reason without ever creating the socket. You
    can mitigate this by using 'kill($PID, 0)' in the loop and looking
    for -ERSCH, but this only works if you know the pid involved."

Daniel also suggested:
    "For the tests, passing a pre-opened UNIX socket FD could work"

Note we can not use any of the standard chardev options to specify such a socket,
because the cpr socket is created before chardevs are created.

Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
{ 'union': 'MigrationAddress',
    'base': { 'transport' : 'MigrationAddressType'},
    'discriminator': 'transport',
    'data': {
      'socket': 'SocketAddress',
      'exec': 'MigrationExecCommand',
      'rdma': 'InetSocketAddress',
      'file': 'FileMigrationArgs',
      'fd':   'FdMigrationArgs' } }           &lt;-- add this

That would be useful for all clients, but this is asking a lot from you,
when you are just trying to fix the tests.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">
Note, 'SocketAddress' already has an option for declaring a FD that
represents a socket.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">
Yes, but if I understand, you proposed passing an fd that represents a
pre-listened socket, which requires target qemu to accept() first.  The
existing FdSocketAddress is ready to read.  We could add a boolean to enable
the new behavior.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
It can do both actually - it depends on what APIs the QEMU uses the
SocketAddress with.

If it is used with qio_channel_socket_connect* the FD must be an
active peer connection.

If it is used with qio_channel_socket_listen*/qio_net_listener* the
FD must be listener socket.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Fair enough.  cpr currently listens here, and we could add a case for the FD:

  QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
  {
    MigrationAddress *addr = channel-&gt;addr;

    if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET &amp;&amp;
        addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
        ...
        g_autoptr(QIONetListener) listener = qio_net_listener_new();

Or to use my socketpair() suggestion, that function would also need changes,
calling qio_channel_socket_connect.

Which do you think is better for clients -- socketpair or pre-listened?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please just use the existing SocketAddress functionality, as that's used
throughout QEMU - a special case with socketpair for migration is not
desirable.

The SocketAddress stuff is what libvirt's used for many years now to
address the race condition with QMP listeners.

With regards,
Daniel</pre>
    </blockquote>
    <pre>Dear Daniel and Steve,

Thank you both for your valuable insights.

To clarify regarding the socket handling approach:
If I do not use socketpair() and instead pass a pre-listened FD to the target, which then calls accept(),
it seems this could mitigate some race condition. However, isn't there still a risk that the old QEMU might try to
connect before the target QEMU calls accept(), thereby resulting in the same race condition?

If I only consider the qtest environment, it seems to me that waiting for the target to create cpr.sock inside qtest framework
- along with checking the process status {kill(pid,0)} - might be the most efficient way to handle this.

I checked and found that the QTestState structure already has a "pid_t qemu_pid" field,
so it should be straightforward to check the target's PID.

From your experience,
which approach do you consider the most effective to solve the current race condition issue?

I would appreciate your thoughts.

- Jaehoon Kim
</pre>
    <blockquote type="cite" cite="mid:aEbmvQXyCLMKSy_8@redhat.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------Ka5T9qEUR6voDjSgeMI5B4Qg--


