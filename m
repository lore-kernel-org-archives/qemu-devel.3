Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9CCC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdH9-0007FM-Nd; Mon, 06 Jul 2026 02:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdH0-0007Cx-53
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:57:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdGy-0001vR-AM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:57:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641SBK3585281
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 06:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nOV4q9ZaoixTeG9978cntttUHEqrnlAB5Zrb8miy7q8=; b=WjZJSB0lfb1QBNdY
 eCDpuxt4QE+ru+dcHhiidAENcZhS7NXzMk7AcwVIie8NbRjz5JHBUvjyoGX4SWPn
 D5uPtfq90krFuu+//jqXcX78qVGpZacKtqmZJS0m7PQeH+SLsztocA3EwdReIxYD
 Txst2yLZq9OwkwGbltoV5EHf/jKmgGUFx6Q+L/Ioa0ajmaiAzgFwlvQhAPoAhXws
 Q1nramaLB77twFKJr1Dn5mj/i7a+c0NVG2AUj4ShPZ1qMKElZyBIrU3MS4XtC9zd
 m6dnjo9Qmve5qsmeCK2hP7DapkfAq8rADPj4fGxQV4HTwlJ9Oih8CKzZWrpwhQEg
 XfvDkQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8umxw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:57:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91ed0e140c5so491147685a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783321062; x=1783925862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nOV4q9ZaoixTeG9978cntttUHEqrnlAB5Zrb8miy7q8=;
 b=kVhgT+awPNudBrNCNm6cVCJNPMs4YnQsm2vPjaTOiFBnct/9DLltXX8EI6B8pAVfIW
 eTAVLbngaIhU4BFGu5NKSBe5UEFjvSu5eBZPVdWlHX5Z0uXLHIpCWVekJmbCrvKXgbPT
 zU9iCYxbRM6v/va+Gi52M393YknxPtbCoooWdCFFNvF5cvzKPPSSeY70V3wNnGsful6R
 EtDcUKCg7/ZvTOtiRXFq34TtXMQmBdOy/Fo2/oBwXmvdx+C6rZr7zj0dEY4gNEepDmY7
 6823/LZyxTpOZk0wfY4sxPLY/0JPTHWIqz4c0NbJk+qzwK5GbcMG1gXYLYftPILB4C2a
 HGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783321062; x=1783925862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOV4q9ZaoixTeG9978cntttUHEqrnlAB5Zrb8miy7q8=;
 b=cCWUOCzP18HMHN2dyhScF2w1eajbVz06iwj7sGd2/nzzvaTnya6LpekgrkwIlV1HL6
 b9NTsDZZUfN+xgEsLIcrX7DkTLhzxxrb5GU1KAVE1CiAOqyyFSRSpQ2EraBOyLhgy7f5
 ELwKAE9/8t1mzhco5MlW35RTT7BsxKUSp1pxhb4C4ISVokLp5mwhXI9fG6HS/z9N7UrZ
 z0wu8VnmbJRUPeBeOQ2OTvATQVfamwUkK1PoLsSsDq3L9WTaPSN6HwmyH9k4z4BF730G
 wodAsFgbcZeasdVo11HPxHp8nOXHNTOkwj39JX+cKRDOP4BSjNPDoUphFj2FQiI/qNsT
 t1IA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTenN+qsWV6fjAw1n+M+yaxvMQfzqhUq6/Ll5N6RgxlDp9K94uGmasBhAXJGs/STDvd9PgrRg7lAVZ@nongnu.org
X-Gm-Message-State: AOJu0YwPAoKbd91x46EsozX7cTo/IWmfpE2v7nyTtT276qX1b62cQ4iu
 OD4o8gFQBkGyyx0FaD6WBhWEi6PZul1/ReSFRLaidaQBvGPafgGcOm+COYaeejCPpu/6dzRazvx
 af0HCeEp9gg7CqxYihReyW+ZgQ3fADT6JD7/U4dUBWmCLeM886rAtjG8o8Q==
X-Gm-Gg: AfdE7ckGyKg3iUWdXNMordu6IfNEoVegVoDbD1pJI2esQuXFdz1EDP1LwHDbC5N0fEQ
 1JFcuq9E5NlNf5AX1rYbQOojN7hZ3IAKYIq4xgdselWQKuf06susZgXbqG9y4RSfXHCgdP1Lqop
 hyUPSVrFbQ9fLcljaR/g5aL/FwsNSudQ3fTQ2Keo6FD+YrfCTbiDjl5wtFpp70xVbC7U79AQwSL
 gUp/87/u6CYdRKP4BFIf2OY9saa2SpsHsN7tRhDgRJck7WHjRDa7N71cRbauJQErEetlcodo7/U
 ObZpCfGEJd7wtGG4x0NYWrH/T0CsDabMuqSW7mZAVzaD8Nc2ADz4auXPzxDJUM5lQkKVTlgrnVU
 ng1bIZdkcUOxlX5aOdLh9CRGNUfR1mGBHiRdQeEq1CDIn2gs3TzHKVaf1D6uAhQ==
X-Received: by 2002:a05:620a:4398:b0:92b:7370:2ddb with SMTP id
 af79cd13be357-92e9a48b91cmr1135173785a.38.1783321061773; 
 Sun, 05 Jul 2026 23:57:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4398:b0:92b:7370:2ddb with SMTP id
 af79cd13be357-92e9a48b91cmr1135170185a.38.1783321060762; 
 Sun, 05 Jul 2026 23:57:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm22134736f8f.2.2026.07.05.23.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 23:57:40 -0700 (PDT)
Message-ID: <8e7e2fce-778a-4434-a1a4-ccc464730768@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 08:57:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/9p: prevent potential error in
 do_local_xattr_limit()
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CJQpmMpFgG5ituA8lAKE95QhMmoXVKif
X-Proofpoint-GUID: CJQpmMpFgG5ituA8lAKE95QhMmoXVKif
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2NyBTYWx0ZWRfX8oN266wAGwAj
 xWRh+f6yCKD1zOlDOVwTgIO1qHJj1BbRLOy3YBBQcSTHK9IoAZvtHrjL1CsyzsXo2c2PYbN9+yB
 csQA/zLecH09ZlfI0/HIBoZJH7UxYis=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4b51e6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=K92WTf5yAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=X9ok8FpLfHEzVMsE4qxm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2NyBTYWx0ZWRfX59asyHP9YTKQ
 z1W+UREHTP2jsvmGCaojcEdB33LziY4OT3LCuBOizJjH00QKxBkRgu6aeIKgtSk4RjGP4QvPqn7
 DCJHTcgxfcfYtKHxrYDG7vAQ5piishCcaLeZ2Mnquwix4GKcRTUyVTcOocn/ofDtOuKQybknvRn
 UDJNnJBUa3/YszTKV+Ob1G7ShJOWphRadPRVnfRLZwp7qd6JVZ49Hy87T7QcHUjxvhE52v6x0n7
 cWhEdWugFBtf5e8cYGmbjZ8d589MT5Pr8UzpVCOptC2g/DHl0zgp6qlpxsgMOGNFxG4ZScv7u19
 Z/ZFMsFcE7PDjiYTO8LGWdvqiO7FdF31O+1ycwqYe3xMjK7fKYrEwJx8lZA+gs+hb9lzYQFwa5R
 FKGW3LkC5qhZnEV6pBEfw1D8j+UmmaM0E4r7jfKerZvDe1tNHo9BijJEBiemBaxrCuTwqo5esUj
 zXEdqkEwC+iUK3LUk9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 3/7/26 17:38, Christian Schoenebeck wrote:
> The local fs backend driver tests require that a dummy file is
> created on the host side before running the xattr limit tests,
> otherwise the test will fail because the file is expected to exist.
> 
> The original call of g_file_set_contents() didn't check its
> return value, which might cause subsequent test checks to fail,
> making it harder to identify the root cause.
> 
> Fix this by simply wrapping the call into a g_assert().
> 
> Fixes: 04a62cdfe873 ("tests/9p: add 3 xattr FID limit test cases (local fs driver)")
> CID: 1660926
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   tests/qtest/virtio-9p-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

