Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A555ACA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKgM-0005EH-V7; Thu, 01 Oct 2026 13:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCKgL-0005Dk-Ay
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:34:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCKgJ-0008HI-Lb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:34:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsc2p3114855
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FKF7qfA1DINCQheOCOuMlvcT+0C3AU6vm864qpbE9Q0=; b=fpEgl3ZDk/je7V71
 K80oLlpVLhDplzE11kqlrDUpJ6ukINH8Mo9rA5eW/7wyE2t/s88Gs0nRFaIY5lhz
 WSo/g2bpyY2vhVLUWIJrfLehF8cGmjWIdqgZLPeM9o4EWh9PXRaLFbTUnL8dcyPz
 k93BKdE34oeGG6Vo+RPsyNvQavbAfQoHhAiQufEyIGWJhXTic/xkU5Bv5F471tJe
 FWoo2ZLyUFSdr4rlayKMW0bLx8tKh76lxEGT2Rk0UeAMoOgZxuJdI+oyHNSF8gZm
 KvBIOyOY+KylXD3bPoga64YY79iss8bmMrcDi/i3VTVuRsEfTiuhR28xNO7OTcwQ
 kgnx8w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5c9y9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:34:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb98809caso170887385a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790876092; x=1791480892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FKF7qfA1DINCQheOCOuMlvcT+0C3AU6vm864qpbE9Q0=;
 b=IBFb7PPxv3HGwWZWb2ruDAfbRHNXfPju8wXvaJg+9fll0s/cvz0HCu75ogm5U9bO+P
 PjO32psbDFdS7JQl7eUUYz37FM+KnQOR7CkEHqR0SC83pOjwrz2xMv85LYTEEfV/bkSP
 Sb3o9NYotb1yM4i/IOj6Oc/3NB8Y8sdXiExEFqL1CuHeRdB3v1WdX6ay1AHN5nV6hQ0E
 IVH8bQ6tvdFK3ka/LZv6RqDy9s+1h3GENcRCT7o0aahqS1Sgq3CmcxIahaqJTJxmoghe
 sfw8b1P+dR2AtruCdqcZTxT+6W/LKYcnCV5Q7J20zzZ87Va5NCKb5fGoNsF0R5E5GrrL
 UvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790876092; x=1791480892;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FKF7qfA1DINCQheOCOuMlvcT+0C3AU6vm864qpbE9Q0=;
 b=07E2Zz9BWxEkHWNWjXPXX5KpGoL2tck9Vz2d1UwAmgfqo2TzjGfmR1lSkqYViRxlZ1
 kuuP72dbhso+0dqj3RNyu7NqYpKf/f4BdvtafavKd3d6rcvvqr9gvd45IskaX35JWo7P
 ENRJAI359P7FsQOeQ6debHdLUR0AZLiXWx3qdpUZ7Pev46sTiBM2MUp8TByxp/61N4ll
 mr6yrvZneqJxkoUSM7isjtmLlP0Bg15zdFDPKvac6jgWGLZUvUOJEE7v8BJkATl/1bKJ
 mUYmbDozVKJcqPQFR5FogHvXcNOZHTaYLdBc0ZP8MkzZpfg4AZFBltlRWjp/VlHflpTB
 qtRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5iOT5+/gBdvANcQWBTSaWXghaoFcOIfUvlnitOo7C6OupHf+4d1AvjJ4RIB/y18WL1F3Rwib+J9hL@nongnu.org
X-Gm-Message-State: AFuF++ndbVF3vacAfoaGG2STqWc09h3IFR33QenbO22a7h6J7V4y53DS
 8P4jg7xUDbw5gMxwDr/YklsmZzlyAJH8YU4PZzZYuoDtYMOjrqe5bWYjbCCH9hXlBv0bgU02f8/
 Gpu9DZ3+O1tYJzB4zJzGhhoQZEnNwHiEDrXSGb86fq8ks4J4/Sy2CBbCsug==
X-Gm-Gg: AYBFou2W2VXTYZhE3LTnHLqobx8T/yU6fmgZx0U20S6Jr8/6/T2ztxH0x3bGxHptbiY
 hSxfFrSFOnNg4zRynP7eA39/BzGk572Fp9yZ0dVHgMGLOFJ4kCscQJbUe9VD+0CxwM107y4/5w1
 iRs06gqsWAhH2mr4mnIGrTXilIR+ftzucyFL0DR2S2xNkWLeyRFToeNfAU2UmCZyorxfiTrSiyy
 Y7cPitcW3UWVAxjWqFlqFKNOXmlhBGi20npgKFIXPh9U93aRNY1S47XRT56pL7lWdHju0Ysmi/B
 Tk95X6wy+3MhZ5vnMC7KnUGFXpbQynYsLHs9dYeMJsbBjhTXEpRt5v5d9uRIQaKIwoVkfFazFPu
 /0dYsr8wI7ZZg1FU5rbkXbHfXsSnq2+QPPA==
X-Received: by 2002:a05:620a:4016:b0:93b:d8bc:a864 with SMTP id
 af79cd13be357-93ca98e32fdmr1002410285a.65.1790876091714; 
 Thu, 01 Oct 2026 10:34:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4016:b0:93b:d8bc:a864 with SMTP id
 af79cd13be357-93ca98e32fdmr1002405685a.65.1790876091253; 
 Thu, 01 Oct 2026 10:34:51 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027f2a4cfsm1383905e9.1.2026.10.01.10.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 10:34:50 -0700 (PDT)
Message-ID: <b004fc9b-8fe5-47db-8d9a-0c9f6898129a@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 19:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/tcg: add missing tests after meson transition
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Dominic P
 <gcc@gcc.dp11.uk>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xe1MqXE1yHHhvC0xtvKr0YPsxmK1bvfc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MCBTYWx0ZWRfXysaHfACCnGVo
 JWbGm3qMUTV9U1bL4EYf14OUOPcX15Img2kyqXHcXR1KW4qoQZn4tQiIlClpUSmTQlFOFBiCMLi
 CFQ8OTLgNjATbNIMzwVfqu9ADiPHvco=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MCBTYWx0ZWRfX2Abxs34ARiI4
 Cw0Zk8awSbA6bry45w49wkLXIIIDSOrYTImh2T2KwfTrF+1fd+bqmeCGy8v0IH12zLg/4lhJdGt
 WJ+/6uIFeZlMX5VU33adPuTrrYpqHjuSpyCUpazRbaI3JboqcVGDUi0tpVQGFlsDwPX0g1S1XOP
 nSRupjdiJy1LivKI0ZqshRkG/H8kXvosTAl0Y+5M0gnZASnutpU7ltNBf1tAwpqaDogTp98aHl+
 mxEtoUELYjNc/72ky1jkdouoktLKxd38CdjeUPIEQGOF840MhT+ilTF9rhUxqtzX8k71JtXfkEG
 028Dcp6+RwwvPoOOws//8p0TakyQy4IlVkKLV9r4aGscz0YAwAz86r4gEPkT2YKD6A1z5qp+Gbf
 CXbvA+1jfkVj6p3z/GBvVQNcLbiKZohdq9SlYYWHezC1ar5gWl8/oJ90YAkkeCsPDIeNX7xj+Ez
 07NYAqT57yolarTxSfQ==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe99bc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jCAIzVjNE0Qz3Hgo_VwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Xe1MqXE1yHHhvC0xtvKr0YPsxmK1bvfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 1/10/26 18:37, Pierrick Bouvier wrote:
> Those tests were (wrongly) skipped when we moved from Makefiles to meson, add
> them back.
> 
> Dominic P (1):
>    tests/tcg/i386: Build test-i386-opt-shr
> 
> Pierrick Bouvier (2):
>    tests/tcg/multiarch: add missing vma-pthread test
>    tests/tcg/multiarch: add missing test_pnew_jump_loads.c test
> 
>   tests/tcg/hexagon/meson.build   | 1 +
>   tests/tcg/i386/meson.build      | 1 +
>   tests/tcg/multiarch/meson.build | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

