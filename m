Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393C6C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2XC-00047e-UH; Tue, 10 Jun 2025 13:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2X9-0003vM-Ld
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:13:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2X6-00074i-7f
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:13:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ABQCQ0021947;
 Tue, 10 Jun 2025 17:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=PCqkFZUUYSa4T8nmm1yG2FvPG5GS1V
 uYmSZqWObIpWk=; b=Oe73EjxoizYFRmnAlHW72EppiDeaYCSNu6y+CQ7DZ7QuJw
 OM/v0hKZZk487PH3htVimW37hfp8RnuzbAUGmYB10+BoQKoT/hK9o95GwgGoV5bs
 RgbzxEyTDLCvuc/e4pb+Rl59xzBKaSY2cMiLioah2vV9VL03dQfdFb2pbtpl6RPK
 A9SnomHnuZB8ko2TPPkAdvFLjIQA5br49iUAy8ggmxxc5MPdk9Sy+GV27Ys0Xqk7
 QgRMXauHpsX440YLmzW5wtX+gdFIod/8oW5bpuosQCgg3dmLC0pru7gtTeHdNyic
 LAKFeLYuX3U02IowlAhHiASsTkYLYtcerFIpvcjg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bunys4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:13:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AE1d98027928;
 Tue, 10 Jun 2025 17:13:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mbdtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:13:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55AHD3xO26214902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:13:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7A3D58058;
 Tue, 10 Jun 2025 17:13:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6676A58057;
 Tue, 10 Jun 2025 17:13:03 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Jun 2025 17:13:03 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------pIpWa6j6xkq8jqcJ6U01NcJy"
Message-ID: <6f953437-d0f2-4364-a620-3d353909c8c0@linux.ibm.com>
Date: Tue, 10 Jun 2025 12:13:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
 <17a19315-c3a9-495f-ab46-8e2350b5aed6@oracle.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <17a19315-c3a9-495f-ab46-8e2350b5aed6@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=684867a1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=AgJHWHGsLzGn4J2NhEQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yPCof4ZbAAAA:8 a=ZLaJf5kWnlEcKtpGRwMA:9 a=7F8eTDmCNJxXVJqL:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNSBTYWx0ZWRfX1uIfmTV+OG/x
 1falIm+asUJ8Fd3Ps7pf71HcQEFgTHiy902kh1peUiwg1xHpaKZMehl7yI1erUj1VLbCLWC4+gp
 +PtOAxwLoT3ON7o6YuBrqtKadciyYgL6yQcuYv7gQYl6j28vsyEyI4wQe4cDqkjCMDKxIeJ6wG8
 m4OH2m9ngBdQK36PKU7Cul4iyVhqGxw2EAhGBj+smwGt4jfzoXvtzHtZzdKNOSzzCiycLNluARH
 ySAhgSLUCIqpT542YAYi0fn5+5FQTS8Ad4UCVZuCg3kCdAwHrtztvJHKrUm/tViiG1uRU1CgU3S
 tTo0UrnWWZACTIcMfIOUWwCrVFyjT9W3z08Apu5S1VEgDoJS1ucWBQk91rDh7r30qfwsz0c/FoW
 B7jh1zVsI03Jwj87LVFXZZAMa/DX/oguhzx6oTCGeA+Vc54O3I4Tn2AFRW59UUYwT9OD3nKn
X-Proofpoint-GUID: A--31-qzyuRLmxBmu5A0MJaxy2FS__mv
X-Proofpoint-ORIG-GUID: A--31-qzyuRLmxBmu5A0MJaxy2FS__mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100135
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
--------------pIpWa6j6xkq8jqcJ6U01NcJy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/10/2025 11:57 AM, Steven Sistare wrote:
> On 6/10/2025 11:08 AM, Jaehoon Kim wrote:
>> When the source VM attempts to connect to the destination VM's Unix
>> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
>> occur if the socket file isn't ready. This can lead to connection
>> failures when running tests.
>>
>> This patch creates and listens on the socket in advance, and passes the
>> pre-listened FD directly. This avoids timing issues and improves the
>> reliability of CPR tests.
>>
>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>>
>> ---
>> Changes since v1:
>> - In v1, the patch added a wait loop to poll the existence of the socket
>>    file (cpr_validate_socket_path()).
>>
>> - This version instead creates the socket beforehand and passes its FD
>>    to the destination QEMU, eliminating the race condition entirely.
>>
>> - Commit title and message changed accordingly.
>> ---
>>   migration/cpr-transfer.c          |  3 +-
>>   tests/qtest/migration/cpr-tests.c | 72 ++++++++++++++++++++++++++++++-
>>   2 files changed, 72 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>> index e1f140359c..7c9de70bad 100644
>> --- a/migration/cpr-transfer.c
>> +++ b/migration/cpr-transfer.c
>> @@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel 
>> *channel, Error **errp)
>>       MigrationAddress *addr = channel->addr;
>>         if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>> -        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>> +        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
>> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
>
> Nice, I did not realize this would be so simple!
>
>>           g_autoptr(QIOChannelSocket) sioc = NULL;
>>           SocketAddress *saddr = &addr->u.socket;
>> diff --git a/tests/qtest/migration/cpr-tests.c 
>> b/tests/qtest/migration/cpr-tests.c
>> index 5536e14610..6f90160e21 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -50,6 +50,51 @@ static void *test_mode_transfer_start(QTestState 
>> *from, QTestState *to)
>>       return NULL;
>>   }
>>   +/*
>> + * Create a pre-listened UNIX domain socket at the specified path.
>> + *
>> + * This is used to eliminate a race condition that can occur
>> + * intermittently in qtest during CPR tests. By pre-creating and
>> + * listening on the socket, we avoid timing-related issues.
>> + */
>> +static int setup_socket_listener(const char *path)
>> +{
>> +    struct sockaddr_un un;
>> +    size_t pathlen;
>> +    int sock_fd;
>> +
>> +    sock_fd = socket(PF_UNIX, SOCK_STREAM, 0);
>> +    if (sock_fd < 0) {
>> +        g_test_message("Failed to create Unix socket");
>> +        return -1;
>> +    }
>> +
>> +    pathlen = strlen(path);
>> +    if (pathlen >= sizeof(un.sun_path)) {
>> +        g_test_message("UNIX socket path '%s' is too long", path);
>> +        close(sock_fd);
>> +        return -1;
>> +    }
>> +
>> +    memset(&un, 0, sizeof(un));
>> +    un.sun_family = AF_UNIX;
>> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
>> +
>> +    if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
>> +        g_test_message("Failed to bind socket to %s", path);
>> +        close(sock_fd);
>> +        return -1;
>> +    }
>> +
>> +    if (listen(sock_fd, 1) < 0) {
>> +        g_test_message("Failed to listen on socket %s", path);
>> +        close(sock_fd);
>> +        return -1;
>> +    }
>> +
>> +    return sock_fd;
>> +}
>> +
>
> Very nice code, but you can just use libqtest.c:qtest_socket_server().
> That does not check for errors as nicely as you do, but none of its
> actions should ever fail, unless the system is very starved for 
> resources.
>
Yes, as you suggested, using qtest_socket_server() makes the code simpler.
Thank you very much!

>>   /*
>>    * cpr-transfer mode cannot use the target monitor prior to 
>> starting the
>>    * migration, and cannot connect synchronously to the monitor, so 
>> defer
>> @@ -60,13 +105,13 @@ static void test_mode_transfer_common(bool 
>> incoming_defer)
>>       g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>>       g_autofree char *mig_path = g_strdup_printf("%s/migsocket", 
>> tmpfs);
>>       g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
>> +    g_autofree char *addr_type, *addr_key, *addr_value;
>> +    g_autofree char *opts_target;
>>         const char *opts = "-machine aux-ram-share=on -nodefaults";
>>       g_autofree const char *cpr_channel = g_strdup_printf(
>> "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
>>           cpr_path);
>> -    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
>> -                                                   cpr_channel, opts);
>>         g_autofree char *connect_channels = g_strdup_printf(
>>           "[ { 'channel-type': 'main',"
>> @@ -75,6 +120,29 @@ static void test_mode_transfer_common(bool 
>> incoming_defer)
>>           "              'path': '%s' } } ]",
>>           mig_path);
>>   +    /*
>> +     * Determine socket address type and value.
>> +     * If socket creation fails, provide the socket path to the target,
>> +     * so it can create the Unix domain socket itself.
>> +     * Otherwise, use the pre-listened socket file descriptor directly.
>> +     */
>> +    int cpr_sockfd = setup_socket_listener(cpr_path);
>
> unlink(cpr_path) after the listen socket is created.
>
> g_assert(cpr_sockfd >= 0), then you can simplify the next block of code.
> qtest_socket_server() will only fail if something is very wrong, in which
> case trying to proceed with more tests is probably doomed.
>
> - Steve
>
Actually, I had considered exiting the process if socket creation failed, but ended up implementing it this way instead.
I'll revise the patch to follow your suggestion and make it terminate on failure.

- Jaehoon Kim

>> +
>> +    if (cpr_sockfd < 0) {
>> +        addr_type = g_strdup("unix");
>> +        addr_key = g_strdup("path");
>> +        addr_value = g_strdup(cpr_path);
>> +    } else {
>> +        addr_type = g_strdup("fd");
>> +        addr_key = g_strdup("str");
>> +        addr_value = g_strdup_printf("%d", cpr_sockfd);
>> +    }
>> +
>> +    opts_target = g_strdup_printf("-incoming 
>> cpr,addr.transport=socket,"
>> +                                  "addr.type=%s,addr.%s=%s %s",
>> +                                  addr_type, addr_key, addr_value, 
>> opts);
>> +
>> +
>>       MigrateCommon args = {
>>           .start.opts_source = opts,
>>           .start.opts_target = opts_target,
>
>
--------------pIpWa6j6xkq8jqcJ6U01NcJy
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
    <div class="moz-cite-prefix">On 6/10/2025 11:57 AM, Steven Sistare
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:17a19315-c3a9-495f-ab46-8e2350b5aed6@oracle.com">On
      6/10/2025 11:08 AM, Jaehoon Kim wrote:
      <br>
      <blockquote type="cite">When the source VM attempts to connect to
        the destination VM's Unix
        <br>
        domain socket (cpr.sock) during a cpr-transfer test, race
        conditions can
        <br>
        occur if the socket file isn't ready. This can lead to
        connection
        <br>
        failures when running tests.
        <br>
        <br>
        This patch creates and listens on the socket in advance, and
        passes the
        <br>
        pre-listened FD directly. This avoids timing issues and improves
        the
        <br>
        reliability of CPR tests.
        <br>
        <br>
        Reviewed-by: Jason J. Herne <a class="moz-txt-link-rfc2396E" href="mailto:jjherne@linux.ibm.com">&lt;jjherne@linux.ibm.com&gt;</a>
        <br>
        Signed-off-by: Jaehoon Kim <a class="moz-txt-link-rfc2396E" href="mailto:jhkim@linux.ibm.com">&lt;jhkim@linux.ibm.com&gt;</a>
        <br>
        <br>
        ---
        <br>
        Changes since v1:
        <br>
        - In v1, the patch added a wait loop to poll the existence of
        the socket
        <br>
           file (cpr_validate_socket_path()).
        <br>
        <br>
        - This version instead creates the socket beforehand and passes
        its FD
        <br>
           to the destination QEMU, eliminating the race condition
        entirely.
        <br>
        <br>
        - Commit title and message changed accordingly.
        <br>
        ---
        <br>
          migration/cpr-transfer.c          |  3 +-
        <br>
          tests/qtest/migration/cpr-tests.c | 72
        ++++++++++++++++++++++++++++++-
        <br>
          2 files changed, 72 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
        <br>
        index e1f140359c..7c9de70bad 100644
        <br>
        --- a/migration/cpr-transfer.c
        <br>
        +++ b/migration/cpr-transfer.c
        <br>
        @@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel
        *channel, Error **errp)
        <br>
              MigrationAddress *addr = channel-&gt;addr;
        <br>
                if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET
        &amp;&amp;
        <br>
        -        addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
        <br>
        +        (addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
        <br>
        +            addr-&gt;u.socket.type == SOCKET_ADDRESS_TYPE_FD))
        {
        <br>
      </blockquote>
      <br>
      Nice, I did not realize this would be so simple!
      <br>
      <br>
      <blockquote type="cite">          g_autoptr(QIOChannelSocket) sioc
        = NULL;
        <br>
                  SocketAddress *saddr = &amp;addr-&gt;u.socket;
        <br>
        diff --git a/tests/qtest/migration/cpr-tests.c
        b/tests/qtest/migration/cpr-tests.c
        <br>
        index 5536e14610..6f90160e21 100644
        <br>
        --- a/tests/qtest/migration/cpr-tests.c
        <br>
        +++ b/tests/qtest/migration/cpr-tests.c
        <br>
        @@ -50,6 +50,51 @@ static void
        *test_mode_transfer_start(QTestState *from, QTestState *to)
        <br>
              return NULL;
        <br>
          }
        <br>
          +/*
        <br>
        + * Create a pre-listened UNIX domain socket at the specified
        path.
        <br>
        + *
        <br>
        + * This is used to eliminate a race condition that can occur
        <br>
        + * intermittently in qtest during CPR tests. By pre-creating
        and
        <br>
        + * listening on the socket, we avoid timing-related issues.
        <br>
        + */
        <br>
        +static int setup_socket_listener(const char *path)
        <br>
        +{
        <br>
        +    struct sockaddr_un un;
        <br>
        +    size_t pathlen;
        <br>
        +    int sock_fd;
        <br>
        +
        <br>
        +    sock_fd = socket(PF_UNIX, SOCK_STREAM, 0);
        <br>
        +    if (sock_fd &lt; 0) {
        <br>
        +        g_test_message("Failed to create Unix socket");
        <br>
        +        return -1;
        <br>
        +    }
        <br>
        +
        <br>
        +    pathlen = strlen(path);
        <br>
        +    if (pathlen &gt;= sizeof(un.sun_path)) {
        <br>
        +        g_test_message("UNIX socket path '%s' is too long",
        path);
        <br>
        +        close(sock_fd);
        <br>
        +        return -1;
        <br>
        +    }
        <br>
        +
        <br>
        +    memset(&amp;un, 0, sizeof(un));
        <br>
        +    un.sun_family = AF_UNIX;
        <br>
        +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
        <br>
        +
        <br>
        +    if (bind(sock_fd, (struct sockaddr *)&amp;un, sizeof(un))
        &lt; 0) {
        <br>
        +        g_test_message("Failed to bind socket to %s", path);
        <br>
        +        close(sock_fd);
        <br>
        +        return -1;
        <br>
        +    }
        <br>
        +
        <br>
        +    if (listen(sock_fd, 1) &lt; 0) {
        <br>
        +        g_test_message("Failed to listen on socket %s", path);
        <br>
        +        close(sock_fd);
        <br>
        +        return -1;
        <br>
        +    }
        <br>
        +
        <br>
        +    return sock_fd;
        <br>
        +}
        <br>
        +
        <br>
      </blockquote>
      <br>
      Very nice code, but you can just use
      libqtest.c:qtest_socket_server().
      <br>
      That does not check for errors as nicely as you do, but none of
      its
      <br>
      actions should ever fail, unless the system is very starved for
      resources.
      <br>
      <br>
    </blockquote>
    <pre>Yes, as you suggested, using qtest_socket_server() makes the code simpler.
Thank you very much!
</pre>
    <blockquote type="cite"
      cite="mid:17a19315-c3a9-495f-ab46-8e2350b5aed6@oracle.com">
      <blockquote type="cite">  /*
        <br>
           * cpr-transfer mode cannot use the target monitor prior to
        starting the
        <br>
           * migration, and cannot connect synchronously to the monitor,
        so defer
        <br>
        @@ -60,13 +105,13 @@ static void test_mode_transfer_common(bool
        incoming_defer)
        <br>
              g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock",
        tmpfs);
        <br>
              g_autofree char *mig_path =
        g_strdup_printf("%s/migsocket", tmpfs);
        <br>
              g_autofree char *uri = g_strdup_printf("unix:%s",
        mig_path);
        <br>
        +    g_autofree char *addr_type, *addr_key, *addr_value;
        <br>
        +    g_autofree char *opts_target;
        <br>
                const char *opts = "-machine aux-ram-share=on
        -nodefaults";
        <br>
              g_autofree const char *cpr_channel = g_strdup_printf(
        <br>
                 
        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
        <br>
                  cpr_path);
        <br>
        -    g_autofree char *opts_target = g_strdup_printf("-incoming
        %s %s",
        <br>
        -                                                   cpr_channel,
        opts);
        <br>
                g_autofree char *connect_channels = g_strdup_printf(
        <br>
                  "[ { 'channel-type': 'main',"
        <br>
        @@ -75,6 +120,29 @@ static void test_mode_transfer_common(bool
        incoming_defer)
        <br>
                  "              'path': '%s' } } ]",
        <br>
                  mig_path);
        <br>
          +    /*
        <br>
        +     * Determine socket address type and value.
        <br>
        +     * If socket creation fails, provide the socket path to the
        target,
        <br>
        +     * so it can create the Unix domain socket itself.
        <br>
        +     * Otherwise, use the pre-listened socket file descriptor
        directly.
        <br>
        +     */
        <br>
        +    int cpr_sockfd = setup_socket_listener(cpr_path);
        <br>
      </blockquote>
      <br>
      unlink(cpr_path) after the listen socket is created.
      <br>
      <br>
      g_assert(cpr_sockfd &gt;= 0), then you can simplify the next block
      of code.
      <br>
      qtest_socket_server() will only fail if something is very wrong,
      in which
      <br>
      case trying to proceed with more tests is probably doomed.
      <br>
      <br>
      - Steve
      <br>
      <br>
    </blockquote>
    <pre>Actually, I had considered exiting the process if socket creation failed, but ended up implementing it this way instead.
I'll revise the patch to follow your suggestion and make it terminate on failure.</pre>
    <p>- Jaehoon Kim<br>
    </p>
    <blockquote type="cite"
      cite="mid:17a19315-c3a9-495f-ab46-8e2350b5aed6@oracle.com">
      <blockquote type="cite">+
        <br>
        +    if (cpr_sockfd &lt; 0) {
        <br>
        +        addr_type = g_strdup("unix");
        <br>
        +        addr_key = g_strdup("path");
        <br>
        +        addr_value = g_strdup(cpr_path);
        <br>
        +    } else {
        <br>
        +        addr_type = g_strdup("fd");
        <br>
        +        addr_key = g_strdup("str");
        <br>
        +        addr_value = g_strdup_printf("%d", cpr_sockfd);
        <br>
        +    }
        <br>
        +
        <br>
        +    opts_target = g_strdup_printf("-incoming
        cpr,addr.transport=socket,"
        <br>
        +                                  "addr.type=%s,addr.%s=%s %s",
        <br>
        +                                  addr_type, addr_key,
        addr_value, opts);
        <br>
        +
        <br>
        +
        <br>
              MigrateCommon args = {
        <br>
                  .start.opts_source = opts,
        <br>
                  .start.opts_target = opts_target,
        <br>
      </blockquote>
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------pIpWa6j6xkq8jqcJ6U01NcJy--


