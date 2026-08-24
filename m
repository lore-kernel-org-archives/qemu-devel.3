Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6BDC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOvH-0005yT-JM; Mon, 24 Aug 2026 03:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOvD-0005uz-FB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:16:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOvB-0007wV-JQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:16:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O6ScYd1982475
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZgujBBk4LgqF/aObOtdX4IZa/LmzB0JiAL5u5XwG5DY=; b=FvLwGpoHPFA/TcUd
 uxW2GkjH5vHqwFwl/34CtQ9OkK1VlhtSk0N7nLN/O2rkTLLMj6o8pa0wu79n42yD
 TC9VvCk4cI84A/N5t8i/ahR+qiSldjIY+DnaUuc46sAm4VP6/AgmEDE8rqHmpqpr
 mDpoXVL8tp6InNd+lSuzaPI8nvU5cgloq2cKi7ufrU95kZ54bTUGN2Ydsul0n5i9
 6Q+l8JIUebOLiENGEDzZ2IhIWYPYe5iyWCBr0VNrOG1rMwvkagQu+7HlbLEhxp34
 +dSsY//P7xqv+x4rFNUFpBUx2DXxrLLpS3bWtfyAp2J1ovQcPNoSwhSlmTtDphKd
 xy2GNw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn880q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:16:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso59818501cf.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787555800; x=1788160600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZgujBBk4LgqF/aObOtdX4IZa/LmzB0JiAL5u5XwG5DY=;
 b=kEo7a5IjbtKAeeF6N60IKuKYj6D3xI9/wsEBpyek7AviiWREx+muVBjamosScYZdiX
 JhMKKW+xs186G5VP3P67NetIGvPVDEBXYbUHFiZPpdjJZmOzBigHLUmEGKxF+I6ovL86
 lDYRVNL9VYd4XKGm/hKFB969/7cQMY159xExE0eXBLpQnZmwPNMr0XdyYGQHzopxQ7GD
 AgwExyjAoZ8/gFBZu7yMSmzniLNR0FUTCwexu3WOmF5HimyWRM13AL1+S4094Oe7Qy8p
 iu8VZTYfjQTLIHii3lwkLyxRa3urAqfpTd6Q9m3Az560ciC/gQtApweJQQt09eKaxekb
 aoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787555800; x=1788160600;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZgujBBk4LgqF/aObOtdX4IZa/LmzB0JiAL5u5XwG5DY=;
 b=W2j6LqZVcNsnvK/NNScjuwh/bEP6yaSRGF9dJBK6rvldyCuj3vlrCjctoZHPA/+/nU
 AXzdR7csjh3HRCUsbj3sg+0O4ju09DJ3OSXlniat+yb6BMbhJG4mJTQAMk1wvq2vCWS6
 5CDyGU/svQuLAjhj+cANuoGv9t0j4rloGEoGcfXWhv7rxUwch/8/9kuRjYGcUzpM/ctQ
 MzbxIoZL1en8s7kqAXwrJZPJhxE6m8wSv2nLRCM2hjol8Ee0au9+HK30W8BfUAOLXi4h
 dbZdH+qx8qziezMhl6FGxiYMlEMD+smouH9T2k6OaWRRDlSj96Qc963S11rT9pnJuuNG
 K67Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rra7FJOqsRGsY9Hwba3Vi5cAAfv/szFsSFkiL/mozqVXzpJTZMQ5i3TFQ7NSeItoNcbP3Xtr5CByAgC@nongnu.org
X-Gm-Message-State: AFuF++nzUt1MVnrASi4hZQDU8JN1JI6cJV2E0mxxRx1zFJu2W6OKxtiX
 l5CcYWt4k1YjpBpzUgIUDbr+wvGQd5bktZyIkLh2ZVo0hK6UAaLuE5dp+cKY4qLK3f6oTuZcoAj
 q99WyDOaBl45lH8S6D3sCDRTb3WbmuoWcmzrNFFPHI1zWbwd2yx3kXPRxvQ==
X-Gm-Gg: AR+sD13h4kKleNRSFvJLR+P0YIx+WiUTnN8+koAPGGtLHCOq4N389JHfY+WY1MS0jeD
 qVFqPC+HaVHTPBx0bzFqjmuZYHNitENGU5pWVRpBvldQeqhN85T4krCCDMnC+hwas8EpRa3On7V
 /6MFFu9/rchzG2+0yOy8WyVeq3MjbIHl9Pw3BZrLmrU0MmTGyyPGfl/yT9nisNHRLv+yu9KtshD
 2lk12sZqvGZbIIXI1W7HcWVp11NJuQFwu0/km2S7Y6RqD+89wnz/sFBqnOLRlF5jxX5UYK38Hio
 XsZzDMHMoe6zK34dJOA32Xm+f+I9MdoJip8tXi6Jo3Jv+BlhbXMArDrZBItmaIinWsguPRJQo27
 pTQ4hA5uyU0YvcFHnLlZcbVahz+e1IF8AwRZ4sbR4EjdP
X-Received: by 2002:a05:622a:2b47:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52df56346dfmr255085821cf.4.1787555799864; 
 Mon, 24 Aug 2026 00:16:39 -0700 (PDT)
X-Received: by 2002:a05:622a:2b47:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52df56346dfmr255085151cf.4.1787555799239; 
 Mon, 24 Aug 2026 00:16:39 -0700 (PDT)
Received: from [10.254.188.74] (132.170.88.92.rev.sfr.net. [92.88.170.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f9c9fsm1076381466b.39.2026.08.24.00.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 00:16:38 -0700 (PDT)
Message-ID: <c4ccfefc-e837-40a7-93d5-14b12dd5a3ce@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:16:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] tests: re-add opencv2 and numpy dependencies
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth
 <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824052859.880475-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfX2xObAAiEE+Xl
 k8UlPW4E4ePhLkmkMNi5iyLNWmBjp0IhKESIbFura5NEIaY9oi5c8W/QLTR1SAKpUn+EhAJVJyn
 2H/Q2hQv4Y7KphQnFARc3Ouklb19yz4=
X-Proofpoint-GUID: TQ3L_eTIa4g7WueDZS_--3ut-1IZbOMn
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8befd8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=k3i2zbviP8V9/5wfVjyM+Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfX8veUnyGlAnjn
 8pSzT/0pWFaSc/EjDbZDvJ9jV8c/GpGWBvHN0halnzu3OBuri9pzcJCHK3HsZ4Ar4Y70cKHCbxj
 nzXLihEHSlD1KKsqiZwnd3vvG67/bHuvIrU9SUqMeTrPORbWumqG9VHddGqShLuDcnA2jKKv8Ia
 ztvAaLRZP+jbp5/oQ+zhZ+UoGroWEPGa+GO8zazEduwyMD/8Wf0Pv2WFr6zXfTfKM40rplrDZwv
 1dmdXn26vuPlr+0qJcZIsAf7AmysCKaU9OW4pqtnGH8LjIRdICdROnw5mYtSkuRdlSbAtk7nce1
 mLIkzveFU7For+xrlYdhLOXwJjFVZ44sKJXZjCl5zmk110Iz36bq24a7w18dTr3iLlj5JwocPyd
 vE1zUKXNCq73ABiE9k9LXPLKnA178lXP4URE/9++K2dBZx5vXmuOXY9uQpPKI9g/A9oLSRH6s84
 E12bZCliHEwaO/tUmBA==
X-Proofpoint-ORIG-GUID: TQ3L_eTIa4g7WueDZS_--3ut-1IZbOMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240063
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

On 24/8/26 07:28, John Snow wrote:
> Fixes: 2a428c8541ec5e9be54aad5f0a446ec8172226c9
> 
> Some of the dependencies identified as avocado dependencies were in
> fact still being used, and should be re-added to our lcitool
> configuration to ensure that these tests are being executed in the CI
> environment.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/docker/dockerfiles/alpine.docker               |  1 +
>   tests/docker/dockerfiles/centos9.docker              |  2 ++
>   tests/docker/dockerfiles/debian-amd64-cross.docker   |  2 ++
>   tests/docker/dockerfiles/debian-arm64-cross.docker   |  2 ++
>   tests/docker/dockerfiles/debian-armhf-cross.docker   |  2 ++
>   tests/docker/dockerfiles/debian-i686-cross.docker    |  2 ++
>   tests/docker/dockerfiles/debian-ppc64el-cross.docker |  2 ++
>   tests/docker/dockerfiles/debian-riscv64-cross.docker |  2 ++
>   tests/docker/dockerfiles/debian-s390x-cross.docker   |  2 ++
>   tests/docker/dockerfiles/debian.docker               |  2 ++
>   tests/docker/dockerfiles/fedora-rust-nightly.docker  |  2 ++
>   tests/docker/dockerfiles/fedora-win64-cross.docker   |  2 ++
>   tests/docker/dockerfiles/fedora.docker               |  2 ++
>   tests/docker/dockerfiles/opensuse-leap.docker        |  2 ++
>   tests/docker/dockerfiles/ubuntu2404.docker           |  2 ++
>   .gitlab-ci.d/macos-14.vars                           |  2 +-
>   scripts/ci/setup/debian/debian-13-ppc64le.yaml       |  2 ++
>   scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml     |  2 ++
>   scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml       |  2 ++
>   tests/lcitool/mappings.yml                           | 12 ++++++++++++
>   tests/lcitool/projects/qemu.yml                      |  2 ++
>   tests/vm/generated/freebsd.json                      |  2 ++
>   22 files changed, 52 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

