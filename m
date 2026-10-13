Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AD2CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGi3e-0000Y0-6j; Tue, 13 Oct 2026 15:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGi3b-0000Wu-U2; Tue, 13 Oct 2026 15:21:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGi3a-0007Vf-Bw; Tue, 13 Oct 2026 15:21:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DEOOX51931645; Tue, 13 Oct 2026 19:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r/1ku8
 C2kTJMF7H4/IuND2uljZcSftOYXN/kgDV/A3E=; b=fn+H25+G9ynRuiQ9OIcKH1
 t9BBZ5c2D5O2vW+6grnsWIvcgXo+cXXnnez0Ap8twJFwUs8i2TG9zDvv5elA+rPw
 Y5o0OYsDGoDiUVLc3dOOj7J4qw67+nxGZ7ddd6ecqymxumO7Xi/qxGd6iJAQLFbH
 uUKnDT1Y9Pdf8CRzhoNJwmV04BXaxl53fIy62WtSkOjAJkcrIHjmnmBL4WzgJRoc
 KhD/Ei5Vvj9z0xczy3Adr2I3JMMRcKUZcrJBkfC+zl6i6MOTH9zv/bAL9rEE+pd4
 xnFa5OMrct8xJ0Kgjqjersz6dMtlyvem0Pc9Y5JnPcDHcf8gCOhat5loAwkoJx+A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w7x6d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:20:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHEuDl3149877; Tue, 13 Oct 2026 19:20:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3hj4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:20:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DJKW9c50266564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 19:20:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CCF620040;
 Tue, 13 Oct 2026 19:20:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 147422004D;
 Tue, 13 Oct 2026 19:20:31 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 19:20:31 +0000 (GMT)
Message-ID: <eb13bc7f-3b46-4bb1-9086-0883fe399a23@linux.ibm.com>
Date: Tue, 13 Oct 2026 21:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] tests/guest-debug: add --kargs option to run-test
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
 <20261012170330.1144446-8-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfX+0A28ee14y3w
 vVE+I3/LPnCbeX/nhw2MELjAbdRnBTM598uCxi2T+GkVqLc06mTlOfROKGhohkDgoeRljn/uPGZ
 F38J8H8SzIdTWmincKBjLE+/7f9XZmI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfX4XbJqLsmrXwt
 8MWjSrxJZs9xmdGp8xQI/ziDlkqP/2NWfzh7CWgY2papS8kmEWwDN9DNWdJj4eiVrrcdMvAGMg0
 4lj0PQR3x+cQcM+hRdAzEjo4SM6Jev/9p305ybJenBkry+QHLP7J9M3hwywAw0Obq8V2g86Ddy1
 4UKh6bYEtQ3UqB7Z9uvmOdaj6SYZJeM20xkcz1Tvz14cCji02X4a/LCiRJ2UUlWNIH8QzJ3J4MA
 9SmtY+kb6vKNx8jFczdGtTS9t8+DGbhWRqomOHyGNXM5fQ1mh/1EJuINIdmxp6adSXq1V3eaw03
 xCRJgyyURxzVKj2p9KB4GpWUUIHwo51Vo5DbEfrB7OmQEtccprRdPLSUOWIMMoXTd6DqAFoll9g
 ELgRpR5zN7La8N1XKvGfku/WkpDVToBHzq+nay+rURduFH4G/nCD8iCIeQBbvpaf35lg+PP4SND
 6NMRM6nwRVYNl/qvTng==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace8485 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=KKAkSRfTAAAA:8 a=o8hnVzG6iWh3YCwp_IsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6TnOInvl4RYbVU_O7zsJXY5UHTWbQPkN
X-Proofpoint-GUID: 6TnOInvl4RYbVU_O7zsJXY5UHTWbQPkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> When passing kernel arguments to QEMU with --append we need to take
> care that things are properly escaped. It's easier if we get the run
> script to do it for us that constructed the nested escaped --qargs.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260930164649.433573-11-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index 838c1c26971..4aa24939b7d 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -25,6 +25,7 @@ def get_args():
>                           required=True)
>       parser.add_argument("--qargs", help="Qemu arguments for test")
>       parser.add_argument("--pargs", help="Program arguments for test")
> +    parser.add_argument("--kargs", help="Kernel args to --append")
>       parser.add_argument("--binary", help="Binary to debug",
>                           required=True)
>       parser.add_argument("--test", help="GDB test script")
> @@ -82,6 +83,8 @@ def log(output, msg):
>               suspend = ' -S'
>           cmd = f'{args.qemu} {args.qargs} {args.binary}' \
>               f'{suspend} -gdb unix:path={socket_name},server=on'
> +        if args.kargs:
> +            cmd += f" --append '{args.kargs}'"

Wouldn't it be better to use shlex.quote()?
It would handle kargs containing single quotes correctly.

