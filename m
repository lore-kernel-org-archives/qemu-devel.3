Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E9EC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5z2Q-0005Lm-Ji; Mon, 14 Sep 2026 01:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z2H-0005L8-NZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:15:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z2D-00081q-MB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:15:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E2eZNr3671370
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dNkk3tQAfDfj4nTzI5OvmqgqCT0Kjr+UKCtPL2FlYaI=; b=X+1aXmVSQrSjyvGH
 utOVeYqhA62o5H8PT0gyesGKMhtP+pp3D9IpEYCJ4yHDHITX/cqLz2n5XGq4mBOL
 de8qH8ryHcc8lCf6xCrw2CaCEwVygUbZwlzVRkcSEMJ1x8SRJ9tpDW801NU6oo+2
 5fhg+At0bC+pBsTp2QJMQsrLzP02Pcc5jgfLNOFWfpL5EZWA9NGgUTmgbO/k137o
 JlGYthFoe1u5PIqDqGx30kGDorD3oSF97kQzkWzoEuFG1lv+tNVyS/jTGnjBoqDJ
 ECNWVbnN9BxHqvMDm830k38HkhnMIQBb3Qq/73qGSum6uYUEWkR2ttuT29o8lnXK
 dRW+SA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsrxkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:15:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so4152747a12.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789362914; x=1789967714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dNkk3tQAfDfj4nTzI5OvmqgqCT0Kjr+UKCtPL2FlYaI=;
 b=DKH08GrydvzXoBZz5NFaYKqzGJpefn3PubqgDf+Qkfs6TN/OuoA+yiNfVrB2p7rKlQ
 tMSjjx8YzuwQXRzV8WSUtTXxjOK+l0L0bjxLpSlDCV5aWkHnyGlxK0x3tSsy88ZeIR2r
 C+uJLKCNSvcY50Cui5HefXsRws2q+uWhbClULRMwe7eklTmXWi/UpUqCZYXYnrtei7+9
 Wxf8Krl87SWkG58v0Q2hQlI4DnJwv/jMvmEQbB2Dk8eZpA294T0pJ1OUlB5cnO85DcXG
 D313l/KY40yieiwOkA4wyWBl86P3AMYKzw5oVy57y8s1e0qNyNWSSTfKZUsfy0WdAi9C
 y2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789362914; x=1789967714;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dNkk3tQAfDfj4nTzI5OvmqgqCT0Kjr+UKCtPL2FlYaI=;
 b=ABgJNxCW/ws0EHOlMdRDnSQiOOgqrOXF3wBVO1n7lIIGn6Ra4gptxP5vpfIpWDTAfu
 b7RuTQURWwrLqnNmLSKEcmVueBzA5Gk85ZDRfWipa1ftbW5r7qoICAWruXZVhg7+dntY
 i6Pc88TnB4jF2BFnOq4fV+SZiM9N0Z5hfBjIzMIepmBwFIqVYpbAMstyLS/u39p78I7u
 Mom9j7O8akdy8mQaAAygm8Ig3Ub1D3L3XaRxN/jC4LsBj1gKacbkOo80zYzpWOZFMjuL
 pas0Y7+3jZIIunanvMUlLaVW5KHxvUEkUigvLcvIkN/Fku2faAPMeCM/0DOrfMzqODe1
 NfGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4U9pSVtosdQr6QcbFJvyXOta0b9ZFs+J+i6/IbHZJ76S8hFYrW138qcnZD7vqZI3qa6MiNmpvC88a@nongnu.org
X-Gm-Message-State: AFuF++nv4D0Mg8OkP0PLCtDAFQd+iSvBhTFkOGzCGXxJVY5cC5WwztLR
 2xHrygh+8d8pBtNSTcFQ9fbP51Zj/urk+Vp5isRKaD/4mSujMC9vMxQoxqegmfZupkIKn4QE3G5
 vEzvCueXldSPI41SRzUMMp0Wq92Bu+QFt799AwItCy6jyz00ltTUyRrv32g==
X-Gm-Gg: AYBFou3G9fxWuWSv5BVCOtBVfKD1HGLUj2yhKb6SJh5uVRD4ghc/Rv4x2bFAC7ImQGF
 HbUGy5WXb7B2eGas2NpDJU5TzcHAgz5TywqYeFaqBWkndFLCZWzdTniXFp1kMAt2kIgD7qnGNxC
 WyfnCJmhLX8a/1QjpvFpQkz2jTXlUZ3clsCqN2Y7u27SIPUrCF8fuapeOIEB+L0cq6phuK5vy5W
 RQ9KkNnUmCHm9Xjvd4k5xFRqdgBQmtVwN5iUmMEZRFVi/CaNOxU+UKmf2FRoQ1wga8VvYpxXUTh
 pUhSIriMGG343syZVrzOzN8C4boZjGh2nusFwR5aHqEEbp8Vleoa606BCKkruW0IFqRErlL+SOW
 KxHGF8qidRjbuGnzLh9Iv3UiSIrWg2el1WrZKE0r4IOZltrB9oqSyu38=
X-Received: by 2002:a17:90b:3e4f:b0:39d:84af:a0a8 with SMTP id
 98e67ed59e1d1-39dec0f7cadmr2517440a91.25.1789362914006; 
 Sun, 13 Sep 2026 22:15:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3e4f:b0:39d:84af:a0a8 with SMTP id
 98e67ed59e1d1-39dec0f7cadmr2517386a91.25.1789362913616; 
 Sun, 13 Sep 2026 22:15:13 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d994d8af1sm19815095a91.11.2026.09.13.22.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:15:12 -0700 (PDT)
Message-ID: <78b4bda8-02cc-40b3-b9aa-137069a54811@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:15:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] tests/tcg: use --add-current-user when building
 containers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260910181504.1010916-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA3MSBTYWx0ZWRfX94F8vXQWZ/Dt
 zfV9b93wynJNi37csxQgwxYKhTfTFSSszFBRGh6+Rbcss8zZ846nicFlbtb0e/URMXu0FgkP4hI
 YFDXK7dJUIn9dRcV0Oj6d2fgMqi4k5chDkqx1OIk4PSxBBxkkgTOWfy2Hp+jWZzsnvkQbrykhZq
 Krn2WPCXyqUO6NYdzMWrm6IzLgy/8oCD8XExXpnjQFWqxcSTO7HyK5i1X7TNG6FQ5vyoknpL2IQ
 eE/BHAsLmiOt216EirHZ5xEhh20sboDxjji+LfkeUHQhAetjbaiUd020Y0jBQFwGsWZz7GKT+gk
 vee0SX5hPUxAm52DABCDM8ri3X1QmBHVXb2Jr01jSOhOUpN0E1CcW80F07S2RC1YcoFwHW4Qo32
 tUwBUyy8wADFHk/yYiuLpf8rz8w76XMzcLbbQB+iCqr+m6v/SnGBMOiCV/tvG7NGV6n5PEPc+3f
 Cz3TPbYgby2VyYjUfBQ==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa782e2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=6MO-9ogwpX_7n3OspGEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OL64u8cZXIuYZNCxgD0o7PULVA4jewF1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA3MSBTYWx0ZWRfX08CyMPwYW8pP
 +GrYfaZTTk83nUq0//uJBJ48+qmQ8zc4xUFxaj6PXPoEHlK6b2Ol78T1d0vVc/GwQQTo5zmMNW5
 hN/IOjOXFzvJe1hGnwFYRZNQcrYnON8=
X-Proofpoint-ORIG-GUID: OL64u8cZXIuYZNCxgD0o7PULVA4jewF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/10/26 11:14 AM, Alex Bennée wrote:
> As the meson tcg build routes the container builds through docker.py
> we can also clean up its hack which involved appending a RUN line to
> the dockerfile. All the dockerfiles that care will work with the
> --build-arg.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/docker.py | 13 ++++++-------
>   tests/tcg/meson.build  |  3 ++-
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 

I'm not sure why this was added in the first place.
Technically, running the container with a specific uid (whether or not a 
user is declared for it) is enough. The only errors you can have is if 
some specific commands ran expect to check if user exist on the machine, 
like sudo for instance.
For our need (cross compilation), it's not needed, as a compiler will 
never check who is $USER. Files written will still have the correct uid 
on host fs anyway.

Do you have more info on this?

Regards,
Pierrick

