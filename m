Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA3606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MMAK2lXV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7wr-0000nU-Ph; Tue, 20 Oct 2026 07:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJ7wa-0000dz-Hx; Tue, 20 Oct 2026 07:23:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJ7wY-0003PN-Up; Tue, 20 Oct 2026 07:23:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K1EL8P3641898; Tue, 20 Oct 2026 11:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ILOg7N
 QbKNhWw/YdXmn5pAK2Dn6EJeYJzwwRJKuM2Yo=; b=MMAK2lXV+KZC5WCeaEg3Rj
 Yj0jGfc5ZE9MQOBhiRHGaeLIqEF0gJNw3+awsuNtIXK4ZjkmoeupKbFaY/dKj/VW
 N1ynZCLGzayHQ9rU2BvalN4EA9JVbckMZHrOoY4/erzOQI4G1XHlsUSs1z7DRAiH
 Bq+ap0lcPJ5wUnNGXINKllEYa+F5k9/jS7ATjsweOFBzr5YXIvDsRFcOUjKhjJrF
 N3RmWob8vn2scJ/QhDuivZKHKYVoY90gRT3zJfon0P2ED0oTfAqpUUvjBcL0XUg3
 /TtjCsDpKGY1+uyCnZs6UxiB4OwqkDvSAxqJ8/xyS24D7P1JcH9ftUAJnvUz4JwQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bagv3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 11:23:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K6ttLF3754440; Tue, 20 Oct 2026 11:23:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjh1nt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 11:23:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69KBNS0f17564012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2026 11:23:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DD062004D;
 Tue, 20 Oct 2026 11:23:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47E5020043;
 Tue, 20 Oct 2026 11:23:27 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.149.137])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Oct 2026 11:23:27 +0000 (GMT)
Message-ID: <6f937ee2-8c5f-456c-917d-651ee2d014d9@linux.ibm.com>
Date: Tue, 20 Oct 2026 13:23:27 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/19] tests/guest-debug: add --kargs option to run-test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-11-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261019192704.3220373-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bjbnuzxGtdKxIeGibMPoGR9Z_hkwNlTk
X-Proofpoint-ORIG-GUID: bjbnuzxGtdKxIeGibMPoGR9Z_hkwNlTk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0NCBTYWx0ZWRfX9BzY9QB8GHMV
 TQkkjk4E6aIdR9CqTxQ+uvIIWkMYlZRaiEQYvmYM967AzWoqaYGWrrERs45kFhkRwhUhufYNGVh
 2G3ckHAXd571+ujXPK8DHTaGi5doOmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0NCBTYWx0ZWRfX3tP4YtdrLLFh
 vEMDbscTQZ0sd8n3RlpD3OKAAKxtpjBWHUhH4DbBKRFt5vyIczMj0kkXCGIMJHaZMgkpO2SxQ8D
 EwujLWHGlr2i4OxHzlgGejajgD1x7bswFETFVU+v3AYM40LDvcJU8RlDJ3nfoK3WiCMZ3oEtvoL
 cWhrQcr2Bq4FbpxljdinVlAJkj7Q9/5xmx0aNpg2gUklGsqI4YNCmRkqAA77eodrjPQ+iZis/eQ
 kYNvGJ92qf/YG050wZWoySEY00X9zIcjbHLfWDZPAc62Syb1VHHVyNQEpK+ICUZTXjPYiS6ePJ9
 AMocqUtp8BwafTY0KjrPzxQGdJ6uPj9NvAWWUYdBSgMZtatZIB72JJh7hl+nM5d32Fza0Z8DCrs
 6UP9fvpdhCP7ewETFxuSJ5hXWA1V7m4EWxMonvsU2tBKACEeCSqSYJ5ZvLu9MfiA6xIMltQ4gtf
 1bi1HS37Sdma2rjRKWQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad74f35 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=1xz8IY7WNuHezO3DfiQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200044
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 21:26, Alex Bennée wrote:
> When passing kernel arguments to QEMU with --append we need to take
> care that things are properly escaped. It's easier if we get the run
> script to do it for us that constructed the nested escaped --qargs.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260930164649.433573-11-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - fix merge with array
> ---
>   tests/guest-debug/run-test.py | 8 ++++++++
>   1 file changed, 8 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


