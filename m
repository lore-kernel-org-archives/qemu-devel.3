Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28F2C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9FKx-000513-II; Wed, 23 Sep 2026 01:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9FKq-00050p-TP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:16:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9FKo-0003sx-RN
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:16:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N3iiAd1425413
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OpaCr4OBI5RwuQTBuQoZt/8+AzV59IUQY8ZsZgqPrxk=; b=TT+4qze/sKoi4uw4
 nOY1lskazpaRCni0T8t9AOk60OLKIYUS8TUfGLU+RZ+XxUlmylNnOZeI4LSfzECU
 +V5uDvb6yk2H2ZFxRsL8zVa3vHio7aaZvknD/JGVSg0HHQV7zS0CXmtiyOixMySZ
 3GhGBrkEft79sKwqmtm8Zp/sWljuaOA8hGfxVki8DdUSJpYhthDAtk+lDrTIGjxI
 VfIycFcKoe4SPvWs53X6p8UFJjYFltNz30ZuP4T/PHrPDe2KmQlHbtGy+6sVp21r
 XIinMjX5XnYchq7m56OKwZMiCDMBCaXDwiduo55rupd1hfIxFt+GWnt8FqbD1Iup
 NDlXZw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c29tf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:15:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bfb2da664so155074885a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 22:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790140556; x=1790745356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OpaCr4OBI5RwuQTBuQoZt/8+AzV59IUQY8ZsZgqPrxk=;
 b=K0dmpBUbvU3Z4sGdVEwntXFu/XpeXRcuwyQdussOCW3RhooXixEnzEsv4cyAPx3ka0
 CmrQfvqOAwWcjM4/Vl2JfZTCJTAs+hbldurjw5GAImG8wvMtY//oLED+JFfz7LXju02E
 37inrTdq0tprRmvRpni0kd7pFXEjYncA9Ima3iKHCzhuJW21IPuXcJV3vBKKb3To27Gj
 8meAOa6JWwUE9OOO5LyQlRE2CrKVjZHLJzO9QaI6bs4xwzbowIRxnVIYAob8SaoaYIaf
 LYF1FoVs50+qsmLdgps1wt4wAqD3wGGBX5fut4A8zwWxhpsaqT8ilR7wrcnKR7aa4BMY
 3XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790140556; x=1790745356;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OpaCr4OBI5RwuQTBuQoZt/8+AzV59IUQY8ZsZgqPrxk=;
 b=tW1v75/fQ4x7Ve+fFPJH6YXWVnElyDqUGqtJDCeGZEGrbxpbTK4z4Gg9m0FY4prK3N
 AUwNDvgNX8KZN+mXW7gI8jzxpXxczU2rOmuTmzCl74IX7y36r/MGI7e2pgIFoS38jokm
 UIe9ZMN2hrDr/u/1O6UJItlUuOakuEX7ADep1gh0QdDUQHBYH/3wvJo2Mrxa9mWXMwde
 5lAra9SC9vXpTCe9KD9U50GZb94Ojib6aArTwefxIWAV8M4nd3Dkt5CvhPQ4LZtMo82f
 yOMKECEWiY4lJ18afUOhQwKEBr0VmVTNfIeGHXbs4i0gwEMpqW4tFMshNt9092ssctMN
 FFzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+X44sENp31VYMm3TUooWA2VkOdU1aNYgi/pCOc4xdKc9OSw6VL70tJS35pckTFl0jdPxgQgkHAOvU@nongnu.org
X-Gm-Message-State: AFuF++nyehv7Q0fI9R/Sr9UaZP52lYHxgoSBVJuY4dPTbHh8v//eNVcP
 145GS0EJ0n3zL3kfI6Nw8oFrU8m51BbDy8XuhfGPOcBJWAAyxo3hkfuDykRVW7aFSxlFo83NCZh
 7WWSWY0UXDkXWK/4cbXv/FoFJ8gPJTMo8ufF2lRfRcrsnxi/WVZaJ+RsWqg==
X-Gm-Gg: AYBFou0kXp+rcuP/VjkQIdN+B5Cj9AatHo4Cll5LGzsGRoyO0/GcM1IThVl76V624ro
 foNIsvPpv3gjSfP9Bt7x1sbV/nP+d1mIRCsqBLQ2FLvAYhTFH/5B/NNXlrnUEDvekBiKlikrX/C
 E8A/yX1VxXmRQsCvom8/xOHOUkoJi+HGsl/3h90yH38G1Nau9udTGvW7onwQ1t75C1hpQaoP/i7
 h6KeDOewcafw6H73I2YKXuiMgjrOM0o82GvshqvYv+8FDpiui6RYiyGq+GBcAQbDkpo6f1xcz6B
 /Qe5kjBPA8TFrCgU/+1mnAyW24FwTqRJu9xB5HWAj0cggvCMZ2EPZV/5nngJXL5hCUfREhgpxBm
 6blEy/bpTXJ4D8eKyR4dFui9bBaE61DtF6Q==
X-Received: by 2002:a05:620a:448a:b0:939:6de8:43d8 with SMTP id
 af79cd13be357-93c251e0894mr243493985a.44.1790140556492; 
 Tue, 22 Sep 2026 22:15:56 -0700 (PDT)
X-Received: by 2002:a05:620a:448a:b0:939:6de8:43d8 with SMTP id
 af79cd13be357-93c251e0894mr243492585a.44.1790140556018; 
 Tue, 22 Sep 2026 22:15:56 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488688893a0sm4042052f8f.32.2026.09.22.22.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 22:15:55 -0700 (PDT)
Message-ID: <45c6701d-9143-4ced-9845-d4b79c0f6946@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 07:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v3] blog post: some notes on the bugpocolypse
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: yodel.eldar@yodel.dev, pbonzini@redhat.com, thuth@redhat.com
References: <20260921075850.1322075-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921075850.1322075-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BfHbCks8Hut3qzi1f2W68wXtTAwqWdAu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyMCBTYWx0ZWRfX4RmZIASwbIM3
 Xu+39B2MYdXEY779237gO7nN7EDbr5FN6eJjBX6lXohzgAqZO9/geUGhe/FSCme8Z+CWtjQSxT8
 /TGZxYYFLCa1BpHpGKs+JWTH0VUJrjk=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab3608d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EdUXZc3TycE9_4aLRlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BfHbCks8Hut3qzi1f2W68wXtTAwqWdAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyMCBTYWx0ZWRfX6SOfWZa+NSPY
 Vp+QAeFhRbTiT9kTCBQaR/kKTW1vlFrsOvB8sDyM0Bl1MlCgV98q3L3VvL15ydn1/IxKZw9e7l3
 +Cm2UHx6Uq9Ju7dvH0adAUFLWXVctUGZBkEgWpu+YsclfqWxCoEl63xveVAXVbN6+fSKFNp7alZ
 9YX+6t2trZ1JnZFVXD5pqe7UuBBOO4rphud6WJrH5yGnP8ZgjiuW9yJBGYPCmeaYugB7ZWqZPIo
 TrVodz+qTC7hOZw3CzKPCJ8c8+mioE5LwWKqYSuWP6XKYXvTdSLXnZaIbc5mC6ha1IhhgliIeTm
 8C6o5opCp6S4Kx5ZEk2jR4bp1gNotHKhanhZArkvfd9Kn0UOzPQS+H9thNshRFTPO/HQDmxjiuZ
 iL0rAqP1Y5bzO3RfL4gTXBJW9c4OH9UPD6q55vg0wFeSZclqNHFm7NNAh1JSrKqDhhSsaEEOCVn
 FjSXgKN+YW0pq+J2QOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230020
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

Typo "bugpocalypse" in Subject.

On 21/9/26 09:58, Alex BennÃ©e wrote:
> As we've been going through the growing pains of AI bug bots I thought
> it might be worth addressing in a blog post. I'm mainly just trying to
> outline the challenges and maybe dissuade people from spam bombing the
> bug tracker with lots of low value bugs in the more dusty corners of
> the codebase.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - went through Yodel's review comments
>    - /throw/through/
>    - consistent use of codebase
>    - bunch of commas and tweaks to long run-on sentences
>    - reword drive-by sentence to avoid double-feature
> 
> v2
>    - shorter lead in, use quote instead of literary allusion
>    - move history of code to after discussion of bug tracker state
>    - rewrite section on slop attacks
>    - include example bug analysis
>    - trim last few paragraphs from code history discussion
>    - actively mention how many confidential issues are unmaintained
>    - nod to the largeness of the wave while summing up
> ---
>   _posts/2026-09-17-bugs.md           |  206 ++
>   screenshots/2026-09-culm-issues.svg | 3210 +++++++++++++++++++++++++++
>   screenshots/qemu-maint-chart-26.svg |    1 +
>   3 files changed, 3417 insertions(+)
>   create mode 100644 _posts/2026-09-17-bugs.md
>   create mode 100644 screenshots/2026-09-culm-issues.svg
>   create mode 100644 screenshots/qemu-maint-chart-26.svg


