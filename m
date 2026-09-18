Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A8DC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7f5b-0008Qm-9G; Fri, 18 Sep 2026 16:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7f5U-0008QT-R9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:21:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7f5J-0001EI-VF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:21:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IKF5qT1794052
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 20:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GskNPIkAY/+MrmVbdRPcVM7cRa3BiwETPlll8q90f9E=; b=Ljgj+zxhzbCNvN9f
 4ODBZFKcVUf9ivfyyy2KEV6SmL+qgB2GCAR9w7WqlNTU1+J8e35CWVYcg6+XkMFl
 4ns+nSD1ciUJTCP5pO3K+uCy+HiFIbgX6GRh2Sn54KeZpi1RMNx6iLLd/hpY+ga+
 UOp0cIsgt2QLGVdREyzbGoFKuQLm28OMb/PjzVRSfI8u5E0HiJP0d7dDExRAzo1b
 Iic/xMTNFcpG3WDzXz6e1mzQdJ6PtL9rx6zgeaicFAhmLHZvhEk3lWPPvxi1VNO8
 GeqJctjkuGcLC+SlJdyCGyKShuiU2/O7TuSRlftU9M0yd91QRMR8l8McS/0yMhvL
 tDVv4Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs72u1f86-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 20:21:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db87f759c5so22671725ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762882; x=1790367682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GskNPIkAY/+MrmVbdRPcVM7cRa3BiwETPlll8q90f9E=;
 b=Z+0PBzkiEWFwPg+jcJISVUtIZhrYKbhqgpdBFqiZ81sdhjkqCnk7FvRd6W4Dj72PiN
 fhyqge8UVCTA46/9RKWAMuykcNSc6Lpj2W7P8SQGJaM07d3DmimTcjdQl2XH1sZIuBS1
 yWoZGbhS/vq+AQ6gbK2lj4BdCU0HxY8Hi/8zPO+4mbK+yxiM0k3ZPTJpkxQJ5tw+8fQc
 +aVBag4JDL/ndkcQVczfimhUjq6pPONKE84K57pqQGrO0XDVwx0WJ3ZHV5GCTCLk9CTG
 fczMTi73YPzEj/qgbQb3J7YmJwbbAdJOuW8K2oI2nM+IufKaex1ijmZNko5LarXvb6s3
 dAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762882; x=1790367682;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GskNPIkAY/+MrmVbdRPcVM7cRa3BiwETPlll8q90f9E=;
 b=z+UoNU+5PQaaZ7goyRhrqIxmUpGrdc5mGWoFMTenFFfU2fDxS9LDceBhK5YsD5ORxA
 ScFM3lmiw9D70QTILNNd/KT+Q4XQipsQY636eS7oBS912Z+LTzm7D3wKlKNglLKjxkb4
 bUBVCIt/fUrQQS5Sk28QtsHfy3xfFvQIXZUXe4fm4iEQJJcRYoyzQUHVz6rk3ViZTrP+
 h5xTjgBOzR5oV826U6Q35JwEviDbwkmIk+E3VEF116Yy7YkdDWupbGMYEMzPb7vDAQdL
 BZWrL/XXKBk2X7OCBRDA4SY5mwpAwjMBqkhRYQOM4MA2mnxsmjCPInqvIkJrljySQVuP
 BTPQ==
X-Gm-Message-State: AFuF++kM0F4wS7TjGFsaM5L/AY4JCJSwE2wFKa+XxDRlXZj+I4CU0q2e
 76/XoAvHraB64ICRsxrB8lAwTMQlzpUCLMYPejNp8FI9MhupYOx6yqyTifLC09loS2iIBVFD4Py
 SDnXyOWEKB/HgLdspxvy1QGHXcPaoF2u1r/2QWElpwTCAthFr6EoxPSTzdQ==
X-Gm-Gg: AYBFou2BCtm+S6q+WAs4heD1bFnxcQqwCiue10fwwa+e52/v3gHeI7F7aC7GF0Fd9Y1
 WbAIpfEL9xNJ41cjQ27Qtw9xFCXLwY+Ll1EaZU83ihVGYxAETG6bq06XlRSBoWY8SDjTk2tB5r8
 S12jDGq54chznJ2Q9UWUrQSAEB3vmZK4+iPUeoMd/WFts3jP6YQkKz+S7gkGleK35UxG+hme4vv
 2/2bomXW2nUG6Ml0KcajaWOV3RbG9gH8G6/D1VsHl6Qh+VvQuANbBacwzFt49x0PiwJ8SgwsHmh
 wQbNi0G0Utf+RLCuUykJ+2DqQnYKgYnYk/AqG6HykFVMoxl7X35yoAXsR38t3hsw1OPPJtQR/UM
 kEHCbV1CbQjp8W43H/NIBLBXG1uXPs7BaXUcU62TBdTgrruQewkiXVn44attw9zHa1a3I
X-Received: by 2002:a17:902:d54c:b0:2dd:c100:b2d1 with SMTP id
 d9443c01a7336-2ddc100b3d4mr9879315ad.60.1789762882141; 
 Fri, 18 Sep 2026 13:21:22 -0700 (PDT)
X-Received: by 2002:a17:902:d54c:b0:2dd:c100:b2d1 with SMTP id
 d9443c01a7336-2ddc100b3d4mr9879055ad.60.1789762881680; 
 Fri, 18 Sep 2026 13:21:21 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331870a8sm969779eec.17.2026.09.18.13.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 13:21:20 -0700 (PDT)
Message-ID: <909087d5-be2a-421d-b1a4-f9237705ed79@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 13:21:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
 <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
 <87y0cy6ace.fsf@draig.linaro.org>
 <7393baca-7746-4211-94cd-e0400cb864b2@oss.qualcomm.com>
 <5bc81802-f243-4faf-822a-04adb5717563@linaro.org>
 <8c2c4869-d31a-4551-bcea-49f4f45a8fe0@oss.qualcomm.com>
 <6752efa2-799a-4c9d-aa4a-ee96bbe1810c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6752efa2-799a-4c9d-aa4a-ee96bbe1810c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 09etbZdDWdwiatoGCAOIwVx9P7v40OVD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MyBTYWx0ZWRfXwV5tUGUgSO1E
 L65VNo5BNyqZK0pX96fVUbPqRJHR2Jz86NHWUO3rzxTifiFFNI2fbJlDBsbQTOhSCtOM/rY4d0C
 sqMskkvVhnYc5efSRlkS4Bb4J5lsFaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MyBTYWx0ZWRfXzc0OG4k+YOhG
 BUeWTNpH4UYOw2cXBYBtP2BhAdSCFS/KksBXLBX7RH925e2CnEA3eS1d+wl4iYV7oOo9WUR3SZk
 pXj67iVc5UMKKKcagCl8fKwMPD/I2UAiR2ux07IRuF/2uW+efUfjz8eGw7Daf40EVdovE38/rod
 6yktwAQlXaUTz2RRgKu474uYl9mY99a0qWK5agPqqoCTCTqxYqMgBeFRqutO3QDH/vpuPa69qvG
 8mj4WT1ZeUfeq/j66wA6CGKO3rMN6hVhWiOp8I/NS4KRPQU6fQOYBfZJuH/Xygyu0DI/u+HZpEX
 /Vd0x640HpvPQT4KBk8faIF+lF4SqHKKNhD0l8NzHIM4q6gc2E1mUkDKwVrI1/F0/7oyEbIeZy+
 Kuu1hbR93Ea6jEXEbYFpEyXJhY7jzrKnKkqSuvI4H/YEIrOl3igVCC0CKDRWGTaO8stYkQiUTZe
 DemTXhXEstpnueGRMlw==
X-Proofpoint-GUID: 09etbZdDWdwiatoGCAOIwVx9P7v40OVD
X-Authority-Analysis: v=2.4 cv=DO8acCNb c=1 sm=1 tr=0 ts=6aad9d42 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=9mJ8AKUfxYxnYunStJkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_06,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180293
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/18/2026 12:53 PM, Richard Henderson wrote:
> On 9/18/26 09:22, Pierrick Bouvier wrote:
>> On 9/18/2026 10:58 AM, Richard Henderson wrote:
>>> On 9/18/26 07:07, Pierrick Bouvier wrote:
>>>>     # finally create a top level target to rebuild all tests
>>>>     alias_target('tcg-tests', exe_targets)
>>>
>>> FWIW, that used to be called build-tcg.
>>>
>>
>> Would you prefer to change name to that?
>>
>> I don't mind personally, and if some people were used to it, it makes
>> sense to provide the same.
> If we're going to provide a fake target at all, we might as well keep it
> the same.
>

We can have both, it's free.
I'll send a patch to reintroduce this name along tcg-tests (definitely
bikeshedding territory, but I feel tcg-tests is a bit better than
build-tcg).

> Though being able to run individual tests from the make/meson command-
> line is probably the biggest new feature, plausibly obviating most uses
> of "just build all the tests so I can run the one I want manually".
>

True, I even hesitated to introduce this extra target, but for
development its pretty convenient, and people are used to have it.

> 
> r~


