Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2EFC88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5zA9-0007RH-Ht; Mon, 14 Sep 2026 01:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z9T-0007HE-U3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:22:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z9S-0001Eq-4c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:22:47 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E2ePBA403530
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YsUM3jIPagpoQ7eCNleSj+sOjpY6SiZ1h1bTWVRwHEE=; b=SujO44c+lMUxa4jx
 yZEBeeYBNPg4XO0By2/aNmnFdkmMwf0Rn6OsoF4BEuNxu1o6M8SjDKBG0zCAGuZh
 WH55TP6DBtQRgckZxApNVXnqL6orzsuEA2keyi2GVXn112E4QPxOgodq6YXNtIRZ
 IaNFNeivetEq5D3ECfU0emJy6okJ9bxR9rwwZt2JSD/yag4xeXk8gmXuB7CEsvb0
 8TH1W8EPEsOCfrnEaZOGmotmEpcpwqtLKxyNMGNrLpgUr4wF75mv+0k/pVQBWU9v
 NUYSjCZ7bQX2wryuDnU9c3zixluIyw2DE9JnrJKYc7iMZCoGHZ6PWGDAd+ul9D6H
 LIjgdw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cn46v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:22:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db3b126c9fso35726625ad.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789363363; x=1789968163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YsUM3jIPagpoQ7eCNleSj+sOjpY6SiZ1h1bTWVRwHEE=;
 b=CYnm6wuvumotYlmwNeoD08xc/6+aYuvarvr2qCfYl9MOqBwpCWr7ryC3UUuIhkUIdm
 /14MXb675p/zgX4NFozFPDyvwnDFiNfz2IX1Ef6RhEt8JrEM2BksKERU9cV2KgC0zbNI
 SGdFDWRW5v2rwlOzVsy/HmvQj0iwuy4NMzGUrcPD9vUFKUIw5/5PFGQ/I5l1K/3la3M2
 Soj709M80UwRevqSfAlwrfoTztZPXdgNnR36keMj4K8UGfpy/squkehnnsnbC5cbchRJ
 bgu/dmrzl9+8iJEsaf4XMlkaV7u40JbQpfOeerVR52D+7TXbNa4Vm188iBiOIdEz+w6i
 tL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789363363; x=1789968163;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YsUM3jIPagpoQ7eCNleSj+sOjpY6SiZ1h1bTWVRwHEE=;
 b=jI/tA6ecDHMohYmZrAomvMhY1j39h2rLw6Fp0FK1rY1T3zwHvTc46ZKwwO/tg2JBSA
 GmurNNbuNCasqPZ+IyjBPLcs6u1bVsv3RmU2oz6LKecqeIsNUAD5t6bAk2PZboSD2WB1
 UNZGFq+T5ntXTrgV/bdAKafWDSLJdwG+9XPilgHWPFKDdWxQo4HMLF8+kVskAi2CdIOk
 vsG4p8QPf55pXuxt+8b2ZEZkAaGeTbxrCGQNpwAtfbOBXjOgevKcRaL0hcBoKFz35rIP
 6FDXPU3Hlsi2vdwK+5gMYORY0qjk4KE20wtNklY/ZosXH2Ffn6TT7EOtjtnBjAdMKAQr
 wvqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8Kr1TVBasonYX/kpQWKBKF9rzQ9IuXlCh9wf8w82DvHKcIkp3AOmsfD5kORqvitI8sqb0nJ2j6FVY@nongnu.org
X-Gm-Message-State: AFuF++nNhh8ZRjvZHl4TafiCNqgkcMdvcz9jpYFMaaEyLUrMAsTVA7rx
 6CckYjYR+ngC1vLiGTMxgftGP+lznTxovDaubB/wNSUQkUBgNHydDWBCl3NJb/oW+y5uKNKmV3b
 Md+U8PRIJTRH1v+9YiJoPlXp32+muNPtxq4eDOAjiijvaSf+pxqrPADkzcA==
X-Gm-Gg: AYBFou0LIFCsa5BtEeDEYv4dnnPvdgtAQEBW8s619Q9X7UbRam5/PBH6GRSd2z6NfgG
 dybTbVL8APt7nzIHf7/AlR/oog9zdRgjnTS+uQlCru3KdjatO8IqDS39LN7Cg45thzVLpRYr8GX
 cGv1KwdJu6D7zUWjRbTCF/w6sfgeRy28JbIUGxmKCN7Oa6gHc1D3FrW3ZCGal8NBuOHQn65ypeN
 oGmJTJYisMEktrXE2eYl4tChORrEBYeb4bqf9lFqieuNdfQ+/VCxbHvkJkiZ0Lvgwwei+zkl8gF
 ffuKitS9Iua98aXef0i9Vyq0sYzlFcq1L239UlYrp4hYCdCb/hdspYgbXC1Krnj1iKMcafc61+7
 h8myAgzakZIp7C+iZtlgZbd6cssfMpgPBEhCeWvN24fSMhvh6NSWjHjg=
X-Received: by 2002:a17:903:37c7:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2dd6c6e30abmr22712605ad.11.1789363363205; 
 Sun, 13 Sep 2026 22:22:43 -0700 (PDT)
X-Received: by 2002:a17:903:37c7:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2dd6c6e30abmr22712085ad.11.1789363362786; 
 Sun, 13 Sep 2026 22:22:42 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd6f8ebbdfsm1440085ad.38.2026.09.13.22.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:22:42 -0700 (PDT)
Message-ID: <efb00c1f-f4c1-4fa1-a74a-5b0ed5f19cdf@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:22:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] tests/docker: add specific command to parser
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
 <20260910181504.1010916-9-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260910181504.1010916-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfX1Fl29Zhnm9X+
 LBlC0bdcF1u5diHanavcdaKJ9lyHF3zWniYUMz5sO7jZU6JLWPJNqRCX2Eaa6JRRw+iItjvA1aa
 ovSZc++SDOgfJfwaOzELsn3u26jVNlHG9MYkRV3uWgBace1x9vIotQTffRMlMTn0h/0XOZWjfOu
 OeJwGj5MQbAiiXj+cnZ8p2PnIVgqzRERhsjGbqeFJXHF2Ke354CeR8uu1G5eqianV7ov4Cxw3+9
 wudW10KkzvjYOn6g7a2FRKorcwWoksfC+9WWOFOFgCt6CSmnwk5lheti19dRhfO1w7CRpkrO8MX
 WyMY6V3W/ZiRPNb4mW7jTXpTjwgXkJvfj2oL4je5IUDn1Jizn877MVhJvs0Jng+aKQk5PxXbElz
 92iPAIq7QGlEDNk3dJABENNgSjTm1j02lOAhDN3qAmEWa1Z9vgk4fxSvTkDgB4yyLcMCu+CGS5I
 N1nhwYP5DKHLUFdnn8Q==
X-Authority-Analysis: v=2.4 cv=EMyTQFZC c=1 sm=1 tr=0 ts=6aa784a3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-4-smrTCfF06wBUSPjMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfXxIlC88cvkQZ0
 jFHlEEHZbzFpSeDixX8upjsI69F+iyVqoLP6opeorsjsAjSLPhR8od35aGp0bIU7/u1qRPLSWgW
 TnwJPpep5CHgX3QapatIqHf5e3U935s=
X-Proofpoint-GUID: 2dxQ8_dwf6mMM75ITPXUh7lCPZr6HUDw
X-Proofpoint-ORIG-GUID: 2dxQ8_dwf6mMM75ITPXUh7lCPZr6HUDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140073
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

On 9/10/26 11:15 AM, Alex Bennée wrote:
> A future change will want to use additional flags which clash with
> docker/podman command lines. Currently they would get snarfed up by
> argparser. Make the pass-through commands explicit to avoid this.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/coverity-scan/run-coverity-scan | 2 +-
>   tests/docker/docker.py                  | 5 ++++-
>   tests/tcg/meson.build                   | 2 +-
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

