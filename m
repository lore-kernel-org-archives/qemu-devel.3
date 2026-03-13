Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090F5107BCD9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 20:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w199q-0001hl-Up; Fri, 13 Mar 2026 16:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w199n-0001gD-Lu
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 16:30:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w199l-0000Vu-DR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 16:30:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DInlTI2206058; Fri, 13 Mar 2026 20:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mHmRTN
 Ykd7b3ooJH0mIM82Pbm5PuDDaaMcKLRvAq4bY=; b=iQIg5iRaiuIs/MBRfOpFYM
 ku8SQgVfD8mcVMr3vsxe++PwPOFMOwvAHbyE+hLeo36TJMF8PB3UXVvJAmkf8EIt
 RsGloQQ6eo8q+uw5VxkOZNPVAUcz3yGhuQv1ptecMOV2pUEUZ+B79JddOIG3fwEz
 8nIU+pz0E24TaMGMLQJB5Og4kI185A6baoq7pZ5E6hhYeT0mFiuAXhutLIcFUauk
 aUssUFv3SbUdoD4jIHlzOcH7E9wydQ7da1IKxIvKdJ39j4YNjI2mmDRf2HP2ktcu
 ypqqco03Ya2BlQykjnMdyHxdFyWLtEssVAp+X32Bui7bPTkPi7vo/qiiDtnMJu6w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98ha2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 20:30:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DIiosn014667;
 Fri, 13 Mar 2026 20:30:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8g79t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 20:30:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DKUkw54653694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 20:30:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28CB258062;
 Fri, 13 Mar 2026 20:30:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 631DA58052;
 Fri, 13 Mar 2026 20:30:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 20:30:45 +0000 (GMT)
Message-ID: <c761d6f8-6136-4435-871f-a1b54f948269@linux.ibm.com>
Date: Fri, 13 Mar 2026 16:30:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] test/qtest: Add test for tpm crb chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
 <20260312041650.181411-6-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260312041650.181411-6-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b473f7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=QQGx1ECa-4m9F8ZMxx8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UYjJG6Z7SCF3v8dn8I_Fai6SfZ1uh9Ys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1OSBTYWx0ZWRfX/DVPOMjDtH0z
 wmDxcdpwn1jbyuL89dXZRBAHJ1RfMsAw3juM4akx1/GpCYCdn7uebpYLmYgrMMzoda8ZouCoG9K
 ezcWPDu3Y9P0TjAVSxJG1yZkWXknfjrpD9ZwhB0BNzXa410rAMMO+nzIhRjchy4qOm2NsIYjAZS
 nsbDIa1as4rwhshO/D6d2y1KEm2Xrq+p0y13spPBBVJZtndfMu+mH7mJyWNKgVJrKlwe0qGquAO
 ln7HmhdVf1jAVmIv5udsro5UgJCRl2/oLlCyh1SXONv2Z9HGJyEYYbq1Pvb3CJ97aqgChrH6K1c
 mUYzzX3xMOANOakhUlznRb/GsXSmosPa3et4NIdmCjahmQT0reihOe0+ItDBaf2aRUBAf5W8aLU
 Ei+XgN0mVnYu5PPnWWOSoODFxfkvnzfBEVp0VldFGPXdtx0EcqQkro2BVvuvbmsXijU+zKOOvdb
 g+PWeO4YVV10eo5nwGw==
X-Proofpoint-ORIG-GUID: UYjJG6Z7SCF3v8dn8I_Fai6SfZ1uh9Ys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/12/26 12:16 AM, Arun Menon wrote:
> - New test case added to the swtpm test. Data is written and read from
>    the buffer in chunks.
> - The chunk size is dynamically calculated by reading the
>    CRB_CTRL_CMD_SIZE address. This can be changed manually to test.
> - Add a helper function tpm_wait_till_bit_clear()
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   tests/qtest/tpm-crb-swtpm-test.c |  10 +++
>   tests/qtest/tpm-util.c           | 106 ++++++++++++++++++++++++++-----
>   tests/qtest/tpm-util.h           |   5 ++
>   3 files changed, 106 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
> index ffeb1c396b..050c7b0c1f 100644
> --- a/tests/qtest/tpm-crb-swtpm-test.c
> +++ b/tests/qtest/tpm-crb-swtpm-test.c
> @@ -33,6 +33,14 @@ static void tpm_crb_swtpm_test(const void *data)
>                           "tpm-crb", NULL);
>   }
>   
> +static void tpm_crb_chunk_swtpm_test(const void *data)
> +{
> +    const TestState *ts = data;
> +
> +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_chunk_transfer,
> +                        "tpm-crb", NULL);

This test would not exercise the chunk functionality unless one modifies 
CRB_CTRL_CMD_SIZE and rebuilds. And for this particular test case its 
value would have to be rather small since only rather small commands are 
sent, which in turn could affect other test cases that do not do chunked 
transfers.

Future versions of swtpm will return 8192 when queried for the buffer 
size (tpm_ioctl.h PTM_SET_BUFFERSIZE with buffersize=0) and we could 
have a better test case then, like creating an ML-DSA-87 key and loading 
it back into the TPM. Hashing of large inputs unfortunately does not 
work... only up to 1kb.


> +}
> +
>   static void tpm_crb_swtpm_migration_test(const void *data)
>   {
>       const TestState *ts = data;
> @@ -54,6 +62,8 @@ int main(int argc, char **argv)
>       g_test_init(&argc, &argv, NULL);
>   
>       qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
> +    qtest_add_data_func("/tpm/crb-chunk-swtpm/test", &ts,
> +                        tpm_crb_chunk_swtpm_test);
>       qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
>                           tpm_crb_swtpm_migration_test);
>       ret = g_test_run();
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 2cb2dd4796..0a861a9e69 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -14,16 +14,42 @@
>   
>   #include "qemu/osdep.h"
>   #include <glib/gstdio.h>
> +#include "system/memory.h"
>   
>   #include "hw/acpi/tpm.h"
>   #include "libqtest.h"
>   #include "tpm-util.h"
>   #include "qobject/qdict.h"
>   
> +#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
> +#define CRB_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
> +#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)
> +
> +#define BIT_START_INVOKE  (1 << 0)
> +#define BIT_RETRY_RESPONSE (1 << 1)
> +#define BIT_NEXT_CHUNK (1 << 2)
> +
> +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask)
> +{
> +    uint32_t sts;
> +    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> +
> +    while (true) {
> +        sts = qtest_readl(s, addr);
> +        if ((sts & mask) == 0) {
> +            break;
> +        }
> +        if (g_get_monotonic_time() >= end_time) {
> +            break;
> +        }
> +    }
> +}
> +
>   void tpm_util_crb_transfer(QTestState *s,
>                              const unsigned char *req, size_t req_size,
>                              unsigned char *rsp, size_t rsp_size)
>   {
> +    uint32_t tpmSts;
>       uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
>       uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
>   
> @@ -31,24 +57,74 @@ void tpm_util_crb_transfer(QTestState *s,
>   
>       qtest_memwrite(s, caddr, req, req_size);
>   
> -    uint32_t sts, start = 1;
> -    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> -    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
> -    while (true) {
> -        start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -        if ((start & 1) == 0) {
> -            break;
> +    qtest_writel(s, CRB_ADDR_START, BIT_START_INVOKE);
> +    tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_START_INVOKE);
> +
> +    tpmSts = qtest_readl(s, CRB_CTRL_STS);
> +    g_assert_cmpint(tpmSts & 1, ==, 0);
> +
> +    qtest_memread(s, raddr, rsp, rsp_size);
> +}
> +
> +void tpm_util_crb_chunk_transfer(QTestState *s,
> +                                 const unsigned char *req, size_t req_size,
> +                                 unsigned char *rsp, size_t rsp_size)
> +{
> +    uint32_t tpmSts;
> +
> +    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
> +    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
> +    uint32_t crb_ctrl_cmd_size = qtest_readl(s, CRB_CTRL_CMD_SIZE);
> +
> +    size_t chunk_size = crb_ctrl_cmd_size;
> +
> +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> +
> +    for (size_t i = 0 ; i < req_size; i += chunk_size) {
> +        bool last_chunk = false;
> +        size_t current_chunk_size = chunk_size ;
> +
> +        if (i + chunk_size > req_size) {
> +            last_chunk = true;
> +            current_chunk_size = req_size - i;
>           }
> -        if (g_get_monotonic_time() >= end_time) {
> -            break;
> +
> +        qtest_memwrite(s, caddr, req + i, current_chunk_size);
> +
> +        if (last_chunk) {
> +            qtest_writel(s, CRB_ADDR_START , BIT_START_INVOKE);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_START_INVOKE);
> +        } else {
> +            qtest_writel(s, CRB_ADDR_START , BIT_NEXT_CHUNK);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_NEXT_CHUNK);
>           }
> -    };
> -    start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -    g_assert_cmpint(start & 1, ==, 0);
> -    sts = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -    g_assert_cmpint(sts & 1, ==, 0);
> +    }
> +    tpmSts = qtest_readl(s, CRB_CTRL_STS);
> +    g_assert_cmpint(tpmSts & 1, ==, 0);
>   
> -    qtest_memread(s, raddr, rsp, rsp_size);
> +    /*
> +     * Read response in chunks
> +     */
> +
> +    unsigned char header[10];
> +    qtest_memread(s, raddr, header, sizeof(header));
> +
> +    uint32_t actual_response_size = ldl_be_p(&header[2]);
> +
> +    if (actual_response_size > rsp_size) {
> +        actual_response_size = rsp_size;
> +    }
> +
> +    for (size_t i = 0; i < actual_response_size; i += chunk_size) {
> +        size_t to_read = i + chunk_size > actual_response_size
> +                       ? (actual_response_size - i)

you can remove '(' and ')'

> +                       : chunk_size;
> +        if (i > 0) {
> +            qtest_writel(s, CRB_ADDR_START, BIT_NEXT_CHUNK);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_NEXT_CHUNK);
> +        }
> +        qtest_memread(s, raddr, rsp + i, to_read);
> +    }
>   }
>   
>   void tpm_util_startup(QTestState *s, tx_func *tx)
> diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
> index 0cb28dd6e5..681544e7d8 100644
> --- a/tests/qtest/tpm-util.h
> +++ b/tests/qtest/tpm-util.h
> @@ -24,10 +24,15 @@ typedef void (tx_func)(QTestState *s,
>                          const unsigned char *req, size_t req_size,
>                          unsigned char *rsp, size_t rsp_size);
>   
> +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask);
>   void tpm_util_crb_transfer(QTestState *s,
>                              const unsigned char *req, size_t req_size,
>                              unsigned char *rsp, size_t rsp_size);
>   
> +void tpm_util_crb_chunk_transfer(QTestState *s,
> +                                 const unsigned char *req, size_t req_size,
> +                                 unsigned char *rsp, size_t rsp_size);
> +
>   void tpm_util_startup(QTestState *s, tx_func *tx);
>   void tpm_util_pcrextend(QTestState *s, tx_func *tx);
>   void tpm_util_pcrread(QTestState *s, tx_func *tx,



