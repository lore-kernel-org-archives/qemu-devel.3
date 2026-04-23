Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4C8FC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvje-0003lh-Lf; Thu, 23 Apr 2026 11:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvjZ-0003ko-R5; Thu, 23 Apr 2026 11:12:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvjV-0004cs-1R; Thu, 23 Apr 2026 11:12:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N867n13657864; Thu, 23 Apr 2026 15:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TCKdW2
 F/WSliYay21PGe37XImHHvT4uFCJImU1GkNxQ=; b=k3Az/Fdh9RRchUvNBQxmkx
 zUa9SactaQwgHqjsIKAvIUwqsvsW01WTOoEagCqAxvZiwN9w1YEusskSmNPwZQFx
 SKrFOgL/i7frmDQThYnJiOB+4w+lqSpjFcpfON0EOODWJL/wL48atHaIszQ7QrHf
 GzkKX4oI7uyJgCmnOXSoNTWdT+Rb8DjQ7kNMJfQfokeze8RfHhbhPfhuECC2fkR2
 nNpanlEAGACW9myDF73uMr4gvW+DYBmVS2QNWl1cMj0Z3GAkEbNKAgMNkqLkTqOK
 BUzjcMaVtwLBRAgM86lk+KFTfQfms/60bCosMQdgGM8RWL7XPS35CEqfmGMFcwfg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7rrfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:12:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NF5UjJ017204;
 Thu, 23 Apr 2026 15:12:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxy3pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:12:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NFCelH51315036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:12:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5EF920043;
 Thu, 23 Apr 2026 15:12:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D69720040;
 Thu, 23 Apr 2026 15:12:40 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:12:40 +0000 (GMT)
Message-ID: <1b8c7129-4d20-44c2-b747-5802e73814d2@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/s390x: Compile few files as common unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-5-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gQFXqIJdLsSYOynZjzzRboXHhhiLFR8b
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ea36ed cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=d1JbcvhS9oBlRhTQQA0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gQFXqIJdLsSYOynZjzzRboXHhhiLFR8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OCBTYWx0ZWRfX7bJgbRZzhy/V
 KjQOP0oS1kVunx591+ChTWpaHo5BfWgcFDFha83Mkyo1K7ChNqyzGmISnCh6YpEkgiG1dlvSZgm
 7cC7wj9c12nKIZRWIS+CPk4EtvGeuXGCq5nEIoypInFv/Mt/h4Siw2lwmGbBPk8Q59XDiWxEikX
 uuS9Vy/daWc3u08dFDdVTcpC4uxnpMmXjiczQw5oNfQk5ZpzBnBs1MMECw0qwV27qoqJEHb+bw2
 3Nx/coXNm5Yzd6ZVcxLuZuUQzp0/Wwdwc7JfEiqvkYkG3FdUoYrMgqvJSZ+iaVcJsWV3GCYoKKn
 /hHAEUVvoMASDlXZSrnN7CyO0xYloLIv3bxricizWpX2lfBEAH2xl0Nq6y4icqp0a4ohZJ8HNkh
 vqGFMvUm0Fl4UAAcrfKpl++4df8giDSttCm9VrE/3pcKRSnQg63qslU0NsiUbDIwa3eChChxI3D
 dfOCw81uGhiEvhMXNtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/26 14:50, Philippe Mathieu-Daudé wrote:
> Nothing in these files prevents it to be built as common unit:
>
>   - cc_helper.c
>   - excp_helper.c
>   - fpu_helper.c
>   - vec_fpu_helper.c
>   - vec_int_helper.c
>   - vec_string_helper.c
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/meson.build | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

