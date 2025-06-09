Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C9AC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcrM-0003R3-26; Mon, 09 Jun 2025 09:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOcr9-0003O0-UO
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:48:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uOcr7-00027o-8e
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:48:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5598Cdmv000881;
 Mon, 9 Jun 2025 13:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=egnBR2v3iAyIKy9EADPKHfmmitoNVZ
 NINirD3vii79Y=; b=PWJGnyOPMJ1FV6iZSu6CGMllPBN6kkx0ZSWWustf9N3cW1
 6r7u9CtMWwsQY994gxYBbsGNo+WqBZBoRjilwhYuTuNWM1aq+wm0ICO543AwsKWB
 6SKPUlEJIc7MJJKf7xBLSzahRh19Wl2OiqcvQSdXGgJD2KqWkDD9250QZCKCBgYu
 zh9/937nVLu1QbkC/eeyVETW3HQIfl3uKS+De//5qV9xj2+gZlZaQSPYuXoLFWfv
 oVDP13DcUh+c5NM0Zpiuqz7J2bCrj0gXIRZZv4e1M+yd+q5YOuaif4ljjTwcA65k
 5HP66qZ2UwrY1ZcC9dA/Q5CL04+Sq4262yfkQ2FA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bunryng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 13:48:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559BG0lS003367;
 Mon, 9 Jun 2025 13:48:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykdr0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 13:48:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559Dm2Rh27525770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 13:48:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3450C58056;
 Mon,  9 Jun 2025 13:48:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0F9758067;
 Mon,  9 Jun 2025 13:48:01 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 13:48:01 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------eZCj4Qq9BGkfzn5k7NVRTOYt"
Message-ID: <6c8e35dd-2a87-4980-9a83-711d7947609a@linux.ibm.com>
Date: Mon, 9 Jun 2025 08:48:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: Steven Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
 <aEaWC_Lc6c1g821f@redhat.com>
 <f46393bb-115a-489f-aa8d-08348e89d25e@oracle.com>
 <aEbfuM681MJh2S-b@redhat.com>
 <881cb07a-95c7-4f3b-8012-352873e88d64@oracle.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <881cb07a-95c7-4f3b-8012-352873e88d64@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=6846e613 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=PHrygekz7vWw2RJQRsUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=yPCof4ZbAAAA:8
 a=8cglXzAvHvU0axtY0iQA:9 a=Uf1EBCFfG8HTk5Rj:21 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEwMSBTYWx0ZWRfX/ZMtLCN8wSsn
 wXjZu9RaPCrinWsZRUKfh/bFiZVLHuOxamdkzB6L66FjT8wDFU75KxWFRt/uFoHqTAH76F7hBZ8
 3zUav/V1z9giXHBzQxOG2yByRlmo3+h1j3Z+zZhiOMXUwch6zrng13WnZlDK4NZN7y9yQqKbdew
 uHYzc6rkBslVQmc4ka0iUJr2ZNN7KSxj6WcPVLm8BVhUPAaNBF1V9wzXMeFULspS20XrG9HzDhG
 CoFMhJgZJ6+RhoSaNFQcSv9FYkQ0GikSkyVdtlT0ET+gBb5YVIQD2fDr6l+il9T27525GrUV/re
 lzscSq126OjpUgB75+lI1PO9ipviGTnCuSo+jk8xDM/D0C4EdDN9nXG4SxEFZpeMJWBHFBc5y/j
 STS4NbAD7RTECGrTT+1ni05Q7+WGlXCls9Qyv8zwOgcXiZNixO1Np1Mz9zD7IKsQoWTkdkeg
X-Proofpoint-GUID: hpagaQuh1aR4c6NJbjU1cfid97RyEQb3
X-Proofpoint-ORIG-GUID: hpagaQuh1aR4c6NJbjU1cfid97RyEQb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
--------------eZCj4Qq9BGkfzn5k7NVRTOYt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/9/2025 8:39 AM, Steven Sistare wrote:
> On 6/9/2025 9:20 AM, Daniel P. Berrangé wrote:
>> On Mon, Jun 09, 2025 at 09:12:27AM -0400, Steven Sistare wrote:
>>> On 6/9/2025 4:06 AM, Daniel P. Berrangé wrote:
>>>> On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
>>>>>
>>>>> The easiest solution, with no interface changes, is adding 
>>>>> wait_for_socket() in qtest,
>>>>> with this addition from Daniel:
>>>>>
>>>>>     "With the busy wait you risk looping forever if the child 
>>>>> (target) QEMU
>>>>>     already exited for some reason without ever creating the 
>>>>> socket. You
>>>>>     can mitigate this by using 'kill($PID, 0)' in the loop and 
>>>>> looking
>>>>>     for -ERSCH, but this only works if you know the pid involved."
>>>>>
>>>>> Daniel also suggested:
>>>>>     "For the tests, passing a pre-opened UNIX socket FD could work"
>>>>>
>>>>> Note we can not use any of the standard chardev options to specify 
>>>>> such a socket,
>>>>> because the cpr socket is created before chardevs are created.
>>>>>
>>>>> Perhaps we could specify the fd in an extension of the 
>>>>> MigrationChannel MigrationAddress.
>>>>> { 'union': 'MigrationAddress',
>>>>>     'base': { 'transport' : 'MigrationAddressType'},
>>>>>     'discriminator': 'transport',
>>>>>     'data': {
>>>>>       'socket': 'SocketAddress',
>>>>>       'exec': 'MigrationExecCommand',
>>>>>       'rdma': 'InetSocketAddress',
>>>>>       'file': 'FileMigrationArgs',
>>>>>       'fd':   'FdMigrationArgs' } }           <-- add this
>>>>>
>>>>> That would be useful for all clients, but this is asking a lot 
>>>>> from you,
>>>>> when you are just trying to fix the tests.
>>>>
>>>> Note, 'SocketAddress' already has an option for declaring a FD that
>>>> represents a socket.
>>>
>>> Yes, but if I understand, you proposed passing an fd that represents a
>>> pre-listened socket, which requires target qemu to accept() first.  The
>>> existing FdSocketAddress is ready to read.  We could add a boolean 
>>> to enable
>>> the new behavior.
>>
>> It can do both actually - it depends on what APIs the QEMU uses the
>> SocketAddress with.
>>
>> If it is used with qio_channel_socket_connect* the FD must be an
>> active peer connection.
>>
>> If it is used with qio_channel_socket_listen*/qio_net_listener* the
>> FD must be listener socket.
>
> Fair enough.  cpr currently listens here, and we could add a case for 
> the FD:
>
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>   {
>     MigrationAddress *addr = channel->addr;
>
>     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>         addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>         ...
>         g_autoptr(QIONetListener) listener = qio_net_listener_new();
>
> Or to use my socketpair() suggestion, that function would also need 
> changes,
> calling qio_channel_socket_connect.
>
> Which do you think is better for clients -- socketpair or pre-listened?
>
> - Steve
>
>
Using a socketpair() to create two descriptors and passing them to the 
old QEMU and the target QEMU, instead of relying on cpr.sock, seems like 
a more efficient approach overall.
However, adopting this method would require changes to the logic in 
cpr_transfer_xxx as Steve mentioned.

Based on your suggestions, it seems that I may need to adjust the 
direction of my next patch.
Initially, I was simply planning to add logic that waits for the 
creation of |cpr.sock| and the target QEMU process state.
However, considering your input, it might be better to reconsider the 
approach.

- Jaehoo Kim

--------------eZCj4Qq9BGkfzn5k7NVRTOYt
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
    <div class="moz-cite-prefix">On 6/9/2025 8:39 AM, Steven Sistare
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:881cb07a-95c7-4f3b-8012-352873e88d64@oracle.com">On
      6/9/2025 9:20 AM, Daniel P. Berrangé wrote:
      <br>
      <blockquote type="cite">On Mon, Jun 09, 2025 at 09:12:27AM -0400,
        Steven Sistare wrote:
        <br>
        <blockquote type="cite">On 6/9/2025 4:06 AM, Daniel P. Berrangé
          wrote:
          <br>
          <blockquote type="cite">On Fri, Jun 06, 2025 at 03:37:56PM
            -0400, Steven Sistare wrote:
            <br>
            <blockquote type="cite">
              <br>
              The easiest solution, with no interface changes, is adding
              wait_for_socket() in qtest,
              <br>
              with this addition from Daniel:
              <br>
              <br>
                  "With the busy wait you risk looping forever if the
              child (target) QEMU
              <br>
                  already exited for some reason without ever creating
              the socket. You
              <br>
                  can mitigate this by using 'kill($PID, 0)' in the loop
              and looking
              <br>
                  for -ERSCH, but this only works if you know the pid
              involved."
              <br>
              <br>
              Daniel also suggested:
              <br>
                  "For the tests, passing a pre-opened UNIX socket FD
              could work"
              <br>
              <br>
              Note we can not use any of the standard chardev options to
              specify such a socket,
              <br>
              because the cpr socket is created before chardevs are
              created.
              <br>
              <br>
              Perhaps we could specify the fd in an extension of the
              MigrationChannel MigrationAddress.
              <br>
              { 'union': 'MigrationAddress',
              <br>
                  'base': { 'transport' : 'MigrationAddressType'},
              <br>
                  'discriminator': 'transport',
              <br>
                  'data': {
              <br>
                    'socket': 'SocketAddress',
              <br>
                    'exec': 'MigrationExecCommand',
              <br>
                    'rdma': 'InetSocketAddress',
              <br>
                    'file': 'FileMigrationArgs',
              <br>
                    'fd':   'FdMigrationArgs' } }           &lt;-- add
              this
              <br>
              <br>
              That would be useful for all clients, but this is asking a
              lot from you,
              <br>
              when you are just trying to fix the tests.
              <br>
            </blockquote>
            <br>
            Note, 'SocketAddress' already has an option for declaring a
            FD that
            <br>
            represents a socket.
            <br>
          </blockquote>
          <br>
          Yes, but if I understand, you proposed passing an fd that
          represents a
          <br>
          pre-listened socket, which requires target qemu to accept()
          first.  The
          <br>
          existing FdSocketAddress is ready to read.  We could add a
          boolean to enable
          <br>
          the new behavior.
          <br>
        </blockquote>
        <br>
        It can do both actually - it depends on what APIs the QEMU uses
        the
        <br>
        SocketAddress with.
        <br>
        <br>
        If it is used with qio_channel_socket_connect* the FD must be an
        <br>
        active peer connection.
        <br>
        <br>
        If it is used with qio_channel_socket_listen*/qio_net_listener*
        the
        <br>
        FD must be listener socket.
        <br>
      </blockquote>
      <br>
      Fair enough.  cpr currently listens here, and we could add a case
      for the FD:
      <br>
      <br>
        QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error
      **errp)
      <br>
        {
      <br>
          MigrationAddress *addr = channel-&gt;addr;
      <br>
      <br>
          if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET
      &amp;&amp;
      <br>
              addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
      <br>
              ...
      <br>
              g_autoptr(QIONetListener) listener =
      qio_net_listener_new();
      <br>
      <br>
      Or to use my socketpair() suggestion, that function would also
      need changes,
      <br>
      calling qio_channel_socket_connect.
      <br>
      <br>
      Which do you think is better for clients -- socketpair or
      pre-listened?
      <br>
      <br>
      - Steve
      <br>
      <br>
      <br>
    </blockquote>
    Using a socketpair() to create two descriptors and passing them to
    the old QEMU and the target QEMU, instead of relying on cpr.sock,
    seems like a more efficient approach overall.<br>
    However, adopting this method would require changes to the logic in
    cpr_transfer_xxx as Steve mentioned.<br>
    <br>
    Based on your suggestions, it seems that I may need to adjust the
    direction of my next patch.<br data-start="149" data-end="152">
    Initially, I was simply planning to add logic that waits for the
    creation of <code data-start="231" data-end="241">cpr.sock</code>
    and the target QEMU process state.<br data-start="276"
      data-end="279">
    However, considering your input, it might be better to reconsider
    the approach.<br>
    <br>
    - Jaehoo Kim<br>
    <br>
  </body>
</html>

--------------eZCj4Qq9BGkfzn5k7NVRTOYt--


