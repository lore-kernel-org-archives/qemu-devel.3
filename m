Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3C8C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2dD-0006O2-Uv; Tue, 10 Jun 2025 13:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2dC-0006Ng-MT
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:19:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2dA-0000bT-8M
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:19:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8nXXZ011109;
 Tue, 10 Jun 2025 17:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=IWeJyOGpNSuJNHo69NfW16u02T74aY
 OGYVlTpO8NQMs=; b=Fq8m5gjSsL49bwGaIF71ur9m50BP+KprG1xoJPVb8MnqX1
 eYUKVosdFJobvYCuboNWnSQV3jgXsId+75ZMwiIqR+8hhmpf1ra+ZKKkfkJq77XM
 AzIrYTqXy1nVvcjqy1pOweoEAwNjNgQJEpGSEAgRb5oCrT5zTUs9YQHkH0tB5CUr
 bwSMYzEqqyozsji57TVFB9jlUbVgqmahRNFW9w7962e70TLz09fsYITjgKYv8imw
 8XILdy7U42f+/Peg9xwtCZRthqyMEhuIdE43cl6RTfuWCIVL8Tg9jTpj6FnTlqU6
 bed4utcXHJ0wXS9kCIcgv2SYKzq+44fgi7qco8RA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7fpau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:19:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGnhKQ021895;
 Tue, 10 Jun 2025 17:19:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yunqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:19:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55AHJJm840174062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:19:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B223058058;
 Tue, 10 Jun 2025 17:19:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 625B958057;
 Tue, 10 Jun 2025 17:19:19 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Jun 2025 17:19:19 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------riXYuVrpEfLZedwkQLMX00qe"
Message-ID: <1458c7e1-5ccb-4728-8539-91b05fadded3@linux.ibm.com>
Date: Tue, 10 Jun 2025 12:19:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, steven.sistare@oracle.com,
 peterx@redhat.com, farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
 <aEhl9S6Xf09VRnkK@redhat.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <aEhl9S6Xf09VRnkK@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xiFsC6NEfGBkv34lGYL0OzYYcuZW1mk2
X-Proofpoint-GUID: xiFsC6NEfGBkv34lGYL0OzYYcuZW1mk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNSBTYWx0ZWRfX+Ez6+k/gbxe7
 CycnMkYNrw6j6yOUgaGAS9Qrp5JGh+hToF9HRlEt776WVvENpe/30JY425lgfPbzfy5pg9mY1l1
 XCoUKYQ7C6n/OiCoBuRhgkTtxW4U97ss6qYjYG7Mhe5nNR1aZ6krpzBfRBHv+2iy/KvmW7M/Uys
 919fqo6OB5LCFZJpx/CnPjmyH1RGMoRqg5xX6zKGtJ2kFJtcotWmrD4EVlMZYSDj51WckhHNYoC
 XJnc+Es3oxfdBQKtlOEmnkThUjwJUwec+jVnifoVE3aQI8H6fh1gghlFfMLS47+v75Pagvx/ZDp
 +dptEG7u+Tp5CIFaDQd9xrwyC7htufA+YcmGikK8WfSnDm2lH/j952w6YUtVzZdEQeJ50svKTWS
 U5s2B0/zP+wzlTkKaaCw/EnhwH724od1kCRJijkCGD25lNzSjFannQZ/U1xZiGfOVSsOl2z6
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=68486919 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=ejq06jM6zyyYbz_OwcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=20KFwNOVAAAA:8 a=oYdFJlbLdbZFahtHNmMA:9 a=1gh4vnIzuLc33hIO:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100135
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
--------------riXYuVrpEfLZedwkQLMX00qe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/10/2025 12:05 PM, Daniel P. Berrangé wrote:
> On Tue, Jun 10, 2025 at 10:08:49AM -0500, Jaehoon Kim wrote:
>> When the source VM attempts to connect to the destination VM's Unix
>> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
>> occur if the socket file isn't ready. This can lead to connection
>> failures when running tests.
>>
>> This patch creates and listens on the socket in advance, and passes the
>> pre-listened FD directly. This avoids timing issues and improves the
>> reliability of CPR tests.
>>
>> Reviewed-by: Jason J. Herne<jjherne@linux.ibm.com>
>> Signed-off-by: Jaehoon Kim<jhkim@linux.ibm.com>
>>
>> ---
>> Changes since v1:
>> - In v1, the patch added a wait loop to poll the existence of the socket
>>    file (cpr_validate_socket_path()).
>>
>> - This version instead creates the socket beforehand and passes its FD
>>    to the destination QEMU, eliminating the race condition entirely.
>>
>> - Commit title and message changed accordingly.
>> ---
>>   migration/cpr-transfer.c          |  3 +-
>>   tests/qtest/migration/cpr-tests.c | 72 ++++++++++++++++++++++++++++++-
>>   2 files changed, 72 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>> index e1f140359c..7c9de70bad 100644
>> --- a/migration/cpr-transfer.c
>> +++ b/migration/cpr-transfer.c
>> @@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>>       MigrationAddress *addr = channel->addr;
>>   
>>       if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>> -        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>> +        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
>> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
>>   
>>           g_autoptr(QIOChannelSocket) sioc = NULL;
>>           SocketAddress *saddr = &addr->u.socket;
> This will likely cause a crash in tracing code that is below this diff:
>
>          trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
>
> q_unix.path is NOT valid to access with TYPE_FD.
>
>
> With regards,
> Daniel

You're right, I should split trace_cpr_transfer_input() call based on addr->u.socket.type,
since q_unix.path is not valid when the type is TYPE_FD.

- Jaehoon Kim.

--------------riXYuVrpEfLZedwkQLMX00qe
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
    <div class="moz-cite-prefix">On 6/10/2025 12:05 PM, Daniel P.
      Berrangé wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aEhl9S6Xf09VRnkK@redhat.com">
      <pre wrap="" class="moz-quote-pre">On Tue, Jun 10, 2025 at 10:08:49AM -0500, Jaehoon Kim wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">When the source VM attempts to connect to the destination VM's Unix
domain socket (cpr.sock) during a cpr-transfer test, race conditions can
occur if the socket file isn't ready. This can lead to connection
failures when running tests.

This patch creates and listens on the socket in advance, and passes the
pre-listened FD directly. This avoids timing issues and improves the
reliability of CPR tests.

Reviewed-by: Jason J. Herne <a class="moz-txt-link-rfc2396E" href="mailto:jjherne@linux.ibm.com">&lt;jjherne@linux.ibm.com&gt;</a>
Signed-off-by: Jaehoon Kim <a class="moz-txt-link-rfc2396E" href="mailto:jhkim@linux.ibm.com">&lt;jhkim@linux.ibm.com&gt;</a>

---
Changes since v1:
- In v1, the patch added a wait loop to poll the existence of the socket
  file (cpr_validate_socket_path()).

- This version instead creates the socket beforehand and passes its FD
  to the destination QEMU, eliminating the race condition entirely.

- Commit title and message changed accordingly.
---
 migration/cpr-transfer.c          |  3 +-
 tests/qtest/migration/cpr-tests.c | 72 ++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index e1f140359c..7c9de70bad 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
     MigrationAddress *addr = channel-&gt;addr;
 
     if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET &amp;&amp;
-        addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+        (addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
+            addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
 
         g_autoptr(QIOChannelSocket) sioc = NULL;
         SocketAddress *saddr = &amp;addr-&gt;u.socket;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This will likely cause a crash in tracing code that is below this diff:

        trace_cpr_transfer_input(addr-&gt;u.socket.u.q_unix.path);

q_unix.path is NOT valid to access with TYPE_FD.


With regards,
Daniel</pre>
    </blockquote>
    <pre>You're right, I should split trace_cpr_transfer_input() call based on addr-&gt;u.socket.type,
since q_unix.path is not valid when the type is TYPE_FD.</pre>
    <pre>- Jaehoon Kim.
</pre>
  </body>
</html>

--------------riXYuVrpEfLZedwkQLMX00qe--


