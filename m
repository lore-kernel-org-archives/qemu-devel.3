Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B488FC0344
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvYY-00088l-3O; Thu, 23 Apr 2026 11:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvXw-00086n-Kp; Thu, 23 Apr 2026 11:01:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvXm-0004RF-Qy; Thu, 23 Apr 2026 11:00:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N72hJ13514991; Thu, 23 Apr 2026 15:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KR94lT
 C/Koskza0LJAUVpLCcBTajERJYFJ/aH2w0MSw=; b=Ju5XU/BGjZ1SG9Z+LggoaV
 +4awub7sSB9HeeJyDwujYSCfJ+jO+SmQuDtbv/MxVa8TAO99sobauvjYXBj/SeQh
 k4n2uda5ADVqt5Yz5KPoDy1rkhqsM0lOtAiF89mK9TECsrh4a0zIQ0yjVsbiSGc6
 OuXBYsJ+7Tak2vPgUpV/GZo0UGcKWCz48wuo6EY3u3eRs+f2qCuVkUP5JrKhqzXz
 u5aZKFw/o0yuUx5GpvioAuoV9X6a9Gk5P1ffPKfcqEENGfoppIIAHayxw4fDoir+
 dDDhhSbWO6J23UvpqYHQbOATR7cTcJMANDeWUfZTRC8NOslaACSDYvJGvYiugmVg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu299ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:00:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEoR2j020911;
 Thu, 23 Apr 2026 15:00:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky72vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:00:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NF0Vpc46137834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:00:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 117722004D;
 Thu, 23 Apr 2026 15:00:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 888172004B;
 Thu, 23 Apr 2026 15:00:30 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:00:30 +0000 (GMT)
Message-ID: <e9c97b5c-d86d-4be2-a75f-d74d565f24f4@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/s390x: Do not compile KVM stubs for linux-user
 binary
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
 <20260423135035.50126-3-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OCBTYWx0ZWRfX4BZRaeiEDbLg
 7zOScYhvfJml0OA3yoowjB0M9XzjncQQdsVEG488hZyBgWdWF+D0On3TJXIagw5T8NBvFIuCb7x
 0j8UuhzbX35MYXZnyFo6J4qxEcmRDPG43ss6GO/bL7dU7b03L3t/m0ps5FvcGb7ZYS7Hi3yg8MS
 hUvcVyePFRMi0Gel74cqJlBK/XJLN0bu6R71DPdgrV11VlpYSOxUtIUNI8Rp7ZxSWWhKkoaSWzI
 dYXbFjzkR/A6i1+Btd64npDExze93YxxjSUXfdoNGabUoKVc5zQMGglHsq93vHI8DbAjRHpVHIL
 sxv83qQce8/V15DIk8Jws32HvQjDtVa66NXEydCL6jPDVBOGvlVXYszsZsylj5kD2zO1dkHOKOw
 lj+aO0TaIFEQE0A0Nq9ivS011yUUnxfMvcrCz5d9U3C79NQFGe+CeO7z3H4r7BMtuLq7eqkiQRq
 20zyLy2YD2xBDtXU5iQ==
X-Proofpoint-ORIG-GUID: xfhPki2I8ahlm-SfFs58xHzblDYsNl-U
X-Proofpoint-GUID: xfhPki2I8ahlm-SfFs58xHzblDYsNl-U
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea3414 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=ZqYJWV8N6uGsjW3S3mQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> None of these KVM symbols should be used in the qemu-s390x
> linux-user binary. Do not build the stub there, prefer a
> real linker failure.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/kvm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

