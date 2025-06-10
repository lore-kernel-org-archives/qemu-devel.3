Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDAEC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2hS-0008PP-53; Tue, 10 Jun 2025 13:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2hN-0008OU-GD
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:23:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2hC-0001wU-3l
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:23:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ABp75g031572;
 Tue, 10 Jun 2025 17:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TCHlXV
 EK3nMgx343GlctgGQoCWz6Xc37eq9Rf8ILfq4=; b=X2ZQiRiGeiEq98nAx4lAAj
 vEVj8elrg7RBjvaNO3SclkEHrxz81i9Le6Rsl+Mkf1KHfuRBtZSk0mBy5WjzUuBH
 toWwF+EHQzC2s4sKPv5XYXIW4LesGwRdCD9dHEay2vPyj6gQm3h+KX2AsVc9CB35
 nrscgZag5BnKi9sBgegz5qzwCrZ0pnqg9MPKT70cTiAQ6544rNIPCOB3YwmgCkiA
 huRMV6KOwrUZyH6tR37l3N6LcEChhAguqpHHCQlj4qCgmzHV9UR9lap6Cj6oq5wt
 QDcwo463sPmoXaw5OcGRO2p9GZcHwVqyABvmot9O7V8Hn1rRCAIzp7mjgmdSBRMw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hguewj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:23:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AG3VIh015186;
 Tue, 10 Jun 2025 17:23:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtbtku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:23:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55AHNQcK18612968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:23:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BF675805D;
 Tue, 10 Jun 2025 17:23:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 546A058058;
 Tue, 10 Jun 2025 17:23:30 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Jun 2025 17:23:30 +0000 (GMT)
Message-ID: <5f65de9f-d2dc-4874-91e9-60ea5270237c@linux.ibm.com>
Date: Tue, 10 Jun 2025 12:23:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, steven.sistare@oracle.com,
 peterx@redhat.com, farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
 <aEhmsFsmsoFpwWSf@redhat.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <aEhmsFsmsoFpwWSf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=68486a14 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=qggL0avbuHaNOse2Y20A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -QVTJSkarlq-I2nhsM4xjKni9_TLnnTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE0MCBTYWx0ZWRfX6S7Y5J9g8rRR
 5lq/ZyrwGWNercBp2mPoAdCX3Z+NmHmT9PmDN9xX+34LVF3IrkvpIkSx1ZfJR//hqN0LV8o20oi
 U4YtD9DB5KbE7VrehQGdUHiI7UZR+vy9fq+vYW1ZKxIeZcm6QTsLSP0BuCHl2zUxdmFs+gGIWtZ
 AdVT9Z7xmkjvLK1qc45GvSC3+XL7ES4b0qkv71wuCah/weQsB/RlntT9nIL4ApQe+tGctpv3Lvz
 zSF3nhXim/4bNsyP3ZIRpY/XO1Vs0TPhKoZQzdOo92iJ/aYe361O2kM/RqZjXXtO0gTT74vz3Vj
 yVbjpnAQ7esX+XWWP2BtS2GlnussHG6Ox1pIqIOevWSL/tuyENPjvo797GM36tWLfQFYeXLXQWx
 CumQ7BYMxlaRGsqDntKeBsewOo6A6PQCbxg4TDO+clPolzjzeqZmclHZAEHY8n1gUwDCIG8E
X-Proofpoint-ORIG-GUID: -QVTJSkarlq-I2nhsM4xjKni9_TLnnTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 6/10/2025 12:09 PM, Daniel P. Berrangé wrote:
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
>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
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
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 5536e14610..6f90160e21 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -50,6 +50,51 @@ static void *test_mode_transfer_start(QTestState *from, QTestState *to)
>>       return NULL;
>>   }
>>   
>> +/*
>> + * Create a pre-listened UNIX domain socket at the specified path.
>> + *
>> + * This is used to eliminate a race condition that can occur
>> + * intermittently in qtest during CPR tests. By pre-creating and
>> + * listening on the socket, we avoid timing-related issues.
>> + */
>> +static int setup_socket_listener(const char *path)
>> +{
>> +    struct sockaddr_un un;
>> +    size_t pathlen;
>> +    int sock_fd;
>> +
>> +    sock_fd = socket(PF_UNIX, SOCK_STREAM, 0);
>> +    if (sock_fd < 0) {
>> +        g_test_message("Failed to create Unix socket");
>> +        return -1;
>> +    }
>> +
>> +    pathlen = strlen(path);
>> +    if (pathlen >= sizeof(un.sun_path)) {
>> +        g_test_message("UNIX socket path '%s' is too long", path);
>> +        close(sock_fd);
>> +        return -1;
>> +    }
>> +
>> +    memset(&un, 0, sizeof(un));
>> +    un.sun_family = AF_UNIX;
>> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
>> +
>> +    if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
>> +        g_test_message("Failed to bind socket to %s", path);
>> +        close(sock_fd);
>> +        return -1;
>> +    }
>> +
>> +    if (listen(sock_fd, 1) < 0) {
>> +        g_test_message("Failed to listen on socket %s", path);
>> +        close(sock_fd);
>> +        return -1;
>> +    }
>> +
>> +    return sock_fd;
>> +}
> This is effectively re-implementing 'unix_listen', so just use
> that function.
I'll revise the patch to use the already defined function instead of 
re-implementing it.
Thanks for pointing it out.
>> @@ -75,6 +120,29 @@ static void test_mode_transfer_common(bool incoming_defer)
>>           "              'path': '%s' } } ]",
>>           mig_path);
>>   
>> +    /*
>> +     * Determine socket address type and value.
>> +     * If socket creation fails, provide the socket path to the target,
>> +     * so it can create the Unix domain socket itself.
>> +     * Otherwise, use the pre-listened socket file descriptor directly.
>> +     */
>> +    int cpr_sockfd = setup_socket_listener(cpr_path);
>> +
>> +    if (cpr_sockfd < 0) {
> A failure of this function (or in future 'unix_listen') shouldn't
> trigger any fallback logic - we should report it and fail thue
> test.
I was considering both options, but I agree with you.
It's better to fail the test and report the error rather than trigger 
fallback logic.
I'll update the patch accordingly.

- Jaehoon Kim.
>> +        addr_type = g_strdup("unix");
>> +        addr_key = g_strdup("path");
>> +        addr_value = g_strdup(cpr_path);
>> +    } else {
>> +        addr_type = g_strdup("fd");
>> +        addr_key = g_strdup("str");
>> +        addr_value = g_strdup_printf("%d", cpr_sockfd);
>> +    }
>> +
>> +    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
>> +                                  "addr.type=%s,addr.%s=%s %s",
>> +                                  addr_type, addr_key, addr_value, opts);
>> +
>> +
>>       MigrateCommon args = {
>>           .start.opts_source = opts,
>>           .start.opts_target = opts_target,
>> -- 
>> 2.49.0
>>
>>
> With regards,
> Daniel

