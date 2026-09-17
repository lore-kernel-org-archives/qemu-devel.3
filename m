Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B93C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KMq-0004tO-Ud; Thu, 17 Sep 2026 18:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KMl-0004sv-H7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:14:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KMj-00079P-3Y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:14:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLG4fB2955462
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3TyzcUYyeyW34xSerpbdL7SQrBgiceMJZuu2otGUeJc=; b=UVK6b6jPgx862SFF
 YF5XRPlFnGbvGkPicoNMoeu69Qj9JoyLVsrSl6LN5J07TKdjwcol0RGDAB0FcZBD
 KivdMzD9jQ96MJLa6siMf7MNtBZpW7xrij/JMA2vgLR5r9fbIu4cF5mCD7u9JEXe
 OVJhAgC+ztkAbL/spJZTs8RMTm9+5CeVk++qY5Z7R6G1yX0mtbxN/tDM5lUBGKgx
 dPpu2TBoE+12DdPi2OH8kmDzf7mYIm/QnChrNJ/OINbNpbsqwdnZFh2SliW+moPA
 c/ZYQ1PAv9BuQ+RoYsJRzOkMNTIN+LQQ/6kK6XV+mdqKQdumPDXBKx27HLJBupox
 +iC17g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grgu5jexg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:13:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2dd753a52bbso2591415ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789683238; x=1790288038; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3TyzcUYyeyW34xSerpbdL7SQrBgiceMJZuu2otGUeJc=;
 b=dWXebd1xan2eGdhZBGJmhl4flMoL0kJ976iIjAfuMWxVOXQ9A7FA7JztmyKtJpa9Ve
 68Rr1EPgECF6L+2ZmzjHTe3L1mOV9T3PA6Ca9qTNeXWT27VOtGrUzZJlmp6XUF8oXuPw
 lotM+EsZngSyaUuKubTA46Vosivo6swBYytWy2zyhXModlb631ZXXqv1NmmFPufp1Z/N
 ig4kU95LvBd11lfmSRbgcURAwGJeHQ8TBPsZQou9h6gPX7ZVVrfR19EQmsoH+iiRR4nZ
 7YO8dChKgINvUwgbRHsRlChkZzgDtvizx0zePxjU9BWuutBpzFGjc/bXcksbrZAvs8qZ
 KP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683238; x=1790288038;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3TyzcUYyeyW34xSerpbdL7SQrBgiceMJZuu2otGUeJc=;
 b=F66B2rcums0RRN7lgeCMBfM8GwjV5kGNLOAySGcOdkwhX+3PblHnIj81yTJc2SzRC2
 cTBt7zgdNZZ9DOU9mwbgR6WF7EXkfK1XCXbeFWBxLw8I06HXlZ9LefljCrxiRdHg9iGu
 0WNxxsfgg1anLSAN2cV0Ft+FZ7w9AlushGxMj2MjdrQMGJqEQQWIxdrhCFUcbV5HO8jO
 5O1Tdik+t1VbAHHpa0HE00Rrxi1F6RYWsdkM1QiHUTepVrN4w023GSCQbQ+WA4f6s9fc
 st2tZO/DuiV+oXrAYkKG973MDMFvj12Z52SWiXLsNxo8Fe/uoJD50QHpJyuk8E7wES23
 jlhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHmb1jXA6aVhXlQDN3HEFriD7odAaf0Ziw/1efMXV055R9OX/NnU/Q7munUkZSGz/UARwZK0RG6o70@nongnu.org
X-Gm-Message-State: AFuF++lGHV3mrQbb3VUhgqfmPxHYiJjj8uzj4994OKdQJe+kwwRb42wH
 llmiUE/1IaNWX88h9GO4+sqgakA1FVvVTLpNlgme7N+R48v/Fe5iB4gtjNMGzgtPvBveQzJY9qo
 10xtMILsrwSxpUOJpeYGecC6O2KleqJk2CnJbC//vC9xEMc3VT9O5pxaHsw==
X-Gm-Gg: AYBFou0I8lFMLKiRT1jDVhbnlD0eYLrFQYBw54/d5lNAQY+u/cT/9PDkttTk3PLdrBZ
 Q+JMOH9eLmtt46egtTdlInctEnyCJY1AePfly6P9cWdnSUA/4shxInVhNx08mis6xYeOO4s25f9
 u9LL8a09ee8YmYqQou5taNBoZTnG0xUnkcI9QaLHRVrWPok6rV50so4xF3fCMTTkNCmOpDNnyvB
 Wh5degWASp4fEUQWJw6UqhsG2CcYGgceu0ZEnnPaASMSVoUZgnBzY8j8BsasM53j/GeDkt5jIhp
 FmzyBnbgoNZD/S2SSdqYmnfYGaXbfzWvsB/nyhUoaC+iJXCfpkFM1sw+rWLsg4JVfJrfFOHgUrL
 emR2BMArCBZO8qEF7stqvE0M+7/EcbvBLyd4tt9AR912pgAbxkTv4JmIeejEsxB23eSQB
X-Received: by 2002:a17:903:2f0f:b0:2dd:88b4:6920 with SMTP id
 d9443c01a7336-2ddb1b9818dmr10987785ad.22.1789683238453; 
 Thu, 17 Sep 2026 15:13:58 -0700 (PDT)
X-Received: by 2002:a17:903:2f0f:b0:2dd:88b4:6920 with SMTP id
 d9443c01a7336-2ddb1b9818dmr10987605ad.22.1789683238105; 
 Thu, 17 Sep 2026 15:13:58 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af6593sm17388659eec.25.2026.09.17.15.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 15:13:57 -0700 (PDT)
Message-ID: <792f28b5-57c1-4947-bed2-0216517b0989@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:13:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] testing: various docker clean-ups post meson tcg
 conversion (pre-PR)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Matthew Rosato
 <mjrosato@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Kyle Evans <kevans@freebsd.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMyMCBTYWx0ZWRfX/mGj0AUO65Yh
 7qLTpN6GrHBIYjwTr4FbafJBIjCET30EJmBJfiFZgT7+O9B196HKyySB6a6NXKz4av5AhxbPDMQ
 HTnmqHFrSGT4BuspTukrCFURRIt3lD0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMyMCBTYWx0ZWRfX09z5wCGPEljK
 qyY7/MgVbC6DV6eFHZOhZIaFfBcf7jvXshfklQy6wN+tRk852OpsCFCVimTVLJFu08+iUT74jTe
 IExkCoM9I4vKZ1qRgGGg+GFkqrUeugbeE3keEVefrhzhLUcurj8lg+fEsvaKHX2Dj92RKugMavL
 ryiwqayZQ4lNUtgLQEk38G0L6vAyrlpUQgckBzOtjILy1byPgn2Eidf1ItoAajwwkm2N5WPTkt7
 qkw92oZZe55UeAuusNdN+pQxhFhwRFpgGhvvrN1GjceKnjOtolPDRwg5iF6Kbf9ndbSHWPuqNXk
 UL00BpekrAcpadBFV5JL/+tTFcz7ZelXSLl5DtRfvnuDG8PBd7reTLFF8C+O2bnVDNWzn0CyAS3
 JHlMhGYtQfVWOrz5g8SNo0i+9HWJQ1dNOeCen1NgbNYLszFzm6cScpOdReg9ZD5WAdIlCnnkCCE
 SMfyN7fDBrAScKNt7fQ==
X-Proofpoint-GUID: ly-i2K5ITxzcNSnn9QysUVdNMNSCnlyN
X-Authority-Analysis: v=2.4 cv=GvbXaU1C c=1 sm=1 tr=0 ts=6aac6627 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Jza3IugBXPv0DvMHRPAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: ly-i2K5ITxzcNSnn9QysUVdNMNSCnlyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170320
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/17/2026 9:55 AM, Alex Bennée wrote:
> This cleans up a few bits and pieces although doesn't totally solve
> the issue of an apparent stall while meson builds the docker image.
> However with these changes there should be no difference between the
> meson build and the equivalent "make docker-image-foo" invocation.
> 
> We also finally get rid of the ill-advised magic caching support in
> docker.py.
> 

In addition to current series, please find here additional fixes,
notably for John's issue on Fedora:
https://lore.kernel.org/qemu-devel/20260917221117.274619-2-pierrick.bouvier@oss.qualcomm.com/T/#

It can be directly applied on top of current series.

Regards,
Pierrick

