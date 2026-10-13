Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E228CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGi6a-0001By-0F; Tue, 13 Oct 2026 15:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGi6R-0001B3-0y; Tue, 13 Oct 2026 15:23:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGi6N-0007lA-1O; Tue, 13 Oct 2026 15:23:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DDpIFE148960; Tue, 13 Oct 2026 19:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GkxCNh
 En8gXzPv23GujUcJkGK/QsDw9hXy2Kab3DUEQ=; b=PJG6o7apgWK2c6aiGeWIny
 2IAKqZjkZgSzeYjTlK8z8oH3yKeIa6v8UrrT+XfMYOz/mcxaHliYYFqy/KWlSdU8
 dNH/FrguFbiSSj4fkqo8y6qSOzLzUpZ6n/Rju6zLvHZIivPgil2OQuj1yP75jN6Q
 CeU7Oz1zUgD7apWXo6gmHrPmR0MOeyYA9Tg7uUFnO5ocimNaX20/i++7WBWzA0mR
 UZyCP/WQXKDOEY9uqCaWvMwDXtHSCOST1m4FwsJ3WNHQXxnYYDbcAsPDMicqqO6k
 V/jS6shrnJuc5iwjXvNru7xNYxnNJGYVUOTuBWKgkjRtgi167N85BsWsGn2X5LIQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhgecw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:23:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DILfKf2709317; Tue, 13 Oct 2026 19:23:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h3t7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:23:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DJNUFF51511612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 19:23:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2DB22004E;
 Tue, 13 Oct 2026 19:23:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C42620040;
 Tue, 13 Oct 2026 19:23:29 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 19:23:29 +0000 (GMT)
Message-ID: <d5f4c9d6-a28f-43f2-a0bc-da9c2aca39bf@linux.ibm.com>
Date: Tue, 13 Oct 2026 21:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] tests/guest-debug: add --symbols option to
 run-test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfX03w37hi+6Q/Y
 MlIddqPO+9KWL+CDr8PEGa7+zOGiND57iF2QK8JH+Yppq622Z5P7/QAF2LxZKFpcLdaC8iW0hJb
 kFU9W31JVr2J/xaoQP0D4CESmOV3H8M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfXz+M4qY6uikHt
 2IO7mAvX0xqiWd74m238YwbE3UhxwQSgd4oi/dtuHGe641GS1ajQG2i7f1thxV0qzAJSXeY8UUJ
 JoIkYz0R/syB+S5tflOmpRES04f7KAW95ZnyXdu5ozcJ3eYd3jGIDYf9FgLXdh7WERxjZkrium+
 XAZkrzDhYf5lD/lBb+RRxlKLsLKxk4oeSjNVEvqqO417A2OamQvIcxx5D59qMfwN2v0itkRrgkU
 IXeeBRVbiF9YqHJQlMvdR10qYqqykH5sGkQPOTRVhBw2U3iO7Q6PfCLRIS7jxsA9zNx/q+ciooo
 DfMh89J+OrIJnIzrEcE8KpCvFp8mP8K9SnbABIF+AH7YAzHLfTI9CBVogbGKGGOTn8bNBqUT85O
 XxzAa2c193uRfE07Ewwe/YeHUOl503BMW3g7s1quMKgNA3Nnyf26dNo2sej3HFlJHwK4mh9NfRe
 LmKzMIZOwHyYA1qMFWw==
X-Proofpoint-GUID: 40_CXUF0SPAYz7Gr-GnTp4QLyGxgzkvL
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace8538 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=KKAkSRfTAAAA:8 a=q9pDxlUirlqk2-u2i64A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 40_CXUF0SPAYz7Gr-GnTp4QLyGxgzkvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130076
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/12/26 19:03, Alex Bennée wrote:
> Sometimes the debug symbols are not in the kernel binary image but in
> a separate elf blob. Provide --symbols to facilitate using them.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260930164649.433573-12-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index 4aa24939b7d..0c7cbd137ef 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -28,6 +28,7 @@ def get_args():
>       parser.add_argument("--kargs", help="Kernel args to --append")
>       parser.add_argument("--binary", help="Binary to debug",
>                           required=True)
> +    parser.add_argument("--symbols", help="Symbol file for binary to debug")
>       parser.add_argument("--test", help="GDB test script")
>       parser.add_argument('test_args', nargs='*',
>                           help="Additional args for GDB test script. "
> @@ -114,6 +115,10 @@ def log(output, msg):
>       gdb_cmd += " -ex 'set confirm off'"
>       # connect to remote
>       gdb_cmd += " -ex 'target remote %s'" % (socket_name)
> +
> +    if args.symbols:
> +        gdb_cmd += " -ex 'symbol-file %s'" % args.symbols
> +

I would consider shlex.quote() here too. Or maybe make gdb_cmd an
array and use subprocess.call(shell=False)?

Also, while it's probably a matter of existing code style and
personal preferences, I would use an f-string instead of %.

>       # finally the test script itself
>       if args.test:
>           if args.test_args:


