Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71F6C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2iw-0000uN-NL; Tue, 10 Jun 2025 13:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2iu-0000u3-SE
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:25:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP2in-0002VJ-Ur
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:25:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AB2Ldk021238;
 Tue, 10 Jun 2025 17:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=qtKRYMrYcoGV62lrdiVvD2KIlNhwz8
 pIChqIqay/mJ8=; b=a4TumfqcM6eCz0qUQ12ZxpMW/BLBuSiHhdnNDzl7bqRzep
 bwe84QclWtXebZ4yisz7aRiUy8ujyScHcU6Da5oaVMZpLi6THuk2JNkjIuO6BEo/
 zYAkIuhv2xSDjqwKyFwOKr8PZKpu1LWuhtwU/dakQgc1NwK8n9ea1RYH4p9uCbct
 t7Rhnf10ybO/iYSUdLM018mDBn34f8lETFjjfSn12mZSOzCfhl18bEvLjfla0z7e
 xiBEkoiG7e1BoVa40Pk0u2BdYyqJBthrHVKlt0s8iItORtB9KZsZ7L+bwtlGsyEX
 Xs44CDHTIJberEK70YbqBjY70VcANMaR31HQsK4Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m4xjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:25:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AE1dCm027928;
 Tue, 10 Jun 2025 17:25:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mbfdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 17:25:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55AHPAWY27460248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:25:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 871FD58058;
 Tue, 10 Jun 2025 17:25:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B0B058061;
 Tue, 10 Jun 2025 17:25:10 +0000 (GMT)
Received: from [9.61.254.209] (unknown [9.61.254.209])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Jun 2025 17:25:10 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------YvdFGZkgW075Kr3wd6izVZx0"
Message-ID: <06cf8296-a20f-4e53-a8d2-6c4430ce4d4e@linux.ibm.com>
Date: Tue, 10 Jun 2025 12:25:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, steven.sistare@oracle.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
 <aEhXMCuztHlUEhqb@x1.local>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <aEhXMCuztHlUEhqb@x1.local>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=68486a78 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=yDl1ueJn3xGpUa3d9hEA:9 a=QEXdDO2ut3YA:10
 a=UCWIu4ZectcTot8mGPwA:9 a=33orzeVKE-T94gIA:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: Bdm5tRnBqoORfy-U1DUdWE94wc30DQrT
X-Proofpoint-ORIG-GUID: Bdm5tRnBqoORfy-U1DUdWE94wc30DQrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE0MCBTYWx0ZWRfX1f9woLS/Kgs+
 dMaeMcHfPITZMpqn7DNGPiOAsl1/8Bw9ReaFfmEuBtKXP8OvL54QUlJA+P7DWAIYGaQpN1PwCkm
 yC4E7PJO7KZASI79RlOVD42N6cjsMC7MW9YO1Nc6n02Bgg3vir2cn9LfIP/5o+hznHF0Gre63gI
 98SpOtYTL2s16bMhL45bVwmdGqvpxpjuEYjAfkPDtrziSrTZRWk8IiCqqgfqZdaPmv3ZLYoopeR
 MawFdmMRcxv/bJb64RmuQ9qktshL0gFz6HPmPLm2zS9cqE4MC8QqD6ABoba/aLkoCfWlMzc3KZ6
 N8Dk/WGxwbFCcmP/uNGoqBMh8awjLBugyTV3f6c+zuSOjMBgYRedn1zURSKxLbD5ET+Q+oZv50G
 SOBG8LxI3ovz+FegW2seoUzif61KncDOoibGt4hia4fk8+RLGUVAfH0lm9YOUFjcH2WsQyEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--------------YvdFGZkgW075Kr3wd6izVZx0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/10/2025 11:02 AM, Peter Xu wrote:
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
> One quick comment while we can wait for others to look at the details: when
> it involves both qemu and tests changes, please consider splitting that
> into two patches. The test patch can be prefixed with "tests/migration:".
>
> Thanks,

Thank you for your suggestion. I'll split the patch into two separate 
patches and submit an updated v3 version

- Jaehoon Kim

--------------YvdFGZkgW075Kr3wd6izVZx0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/10/2025 11:02 AM, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aEhXMCuztHlUEhqb@x1.local">
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
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
One quick comment while we can wait for others to look at the details: when
it involves both qemu and tests changes, please consider splitting that
into two patches. The test patch can be prefixed with "tests/migration:".

Thanks,
</pre>
    </blockquote>
    <pre><span style="white-space: pre-wrap">Thank you for your suggestion.
I'll split the patch into two separate patches and submit an updated v3 version</span></pre>
    <pre><span style="white-space: pre-wrap">- Jaehoon Kim
</span></pre>
  </body>
</html>

--------------YvdFGZkgW075Kr3wd6izVZx0--


