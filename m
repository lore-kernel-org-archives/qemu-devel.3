Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5037FCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoUB-0006Ti-RX; Wed, 30 Sep 2026 03:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoUA-0006T1-7a
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:12:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoU8-0008T0-G1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:12:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6pUY23380901
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0eHc0WQhPIiXuPEs8897qOZT6LIWSIxBTPg3AUmC02c=; b=mThlm1fFGDJmXI7h
 Svqvk0hCzDBc8OAq9raxpOvpU0+kYT2eXdbXNppFhZb7f6JD9Gt5V+wVgMddyJWX
 XbXZJWrj5lS0tzBI3FKfksZ80HF6zAcrp01rl1mClrtxtEQ3Ev7JZQYYnpE9g1H0
 /NRazPyeKBlNc4LQiSkyELHUoWz7nFc5mApAUToplOT3TTOuETdFK6LZYXE8Ar8U
 gS6EP/v1lXvRMTSL9wm2UGLuEldF4IqpbB2/gdR+Wpr+L0dw8dbbX8sbhauW00dp
 uQfxnWBEXZROaA7FCRh4ubIH8arsp2xYaHeGluspg+7auJdh2l8hmK7hKg08/MBC
 A9q/gw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97tvwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:12:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so780423785a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790752331; x=1791357131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0eHc0WQhPIiXuPEs8897qOZT6LIWSIxBTPg3AUmC02c=;
 b=I+6g5bCsjocMY+g4sYZVGD6TS9ixdE7LCn+Ticq3s7ZYgZyx61exBuQTUcrcJ0sUW1
 J1HteDmow+utVjAGy9/o9gb17ZUHNtC7zkjJhykPqy4MNiBKgTipiw3dRHQHo4k5f0/v
 DIytF32SYjnqkmBpyhiE8ARu0NngW88L6HsuK8Tv+5v7orTuISHuq+/ZbZsj5K85J6no
 lHrbs/yLDoFqB/TccZmnOOS2R3PppYsT+5mL/dXFpioMEyelOFxZNUw5RUz0m5aeYsfV
 WKCqcWzWr4oeA92GSCoXJ+fQGrHqFC0f+NXMCiwitlbmxhWM9WkVME2Ui8BbnVhySiIw
 xPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752331; x=1791357131;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0eHc0WQhPIiXuPEs8897qOZT6LIWSIxBTPg3AUmC02c=;
 b=YBnZo7S8UsGSa9Pm92Er6yAqrCmxhfaNRtOQ2Atm+LBcJQLfK9N2Q8u3CiF960+6UM
 mwCyU/WWzV3OwJJux4E7v81+7P0gjUwG8q+8X2Kck4qN3se3VMgFqXDshwW/0PFHoOY6
 IRELNtvisaN+vvmZ92Wyu326eJbJH9ADpWMQGput9fo4kINVX+rNZ4LBoh/h6lkPtIN9
 cPDyp/zeEanTHHptmGWfQBIyef9vIlxZiKwkggNSo/xt6BSWJVAjEmk5w0VQzxdV43mA
 U5gyNdBWrLghPjvhtb+nZF2Q8BmWWKGylgLT0eayaMZcQl2BeeRqPgryiK2JTcNTaLv6
 AxsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7T6aWeyur5+z7ZjvgCVDYwl5DwG6yJfOiofQvNDsN6sIEa5TyqQggmR4ZQHoN5LlGxHRRSfWwMSJv@nongnu.org
X-Gm-Message-State: AFuF++ml2MdJVScX89CuYJLWcpLGR04IX6/zcRLsej18UBuv1Dy1XwUc
 qifqqfBDHjY1Upfq84Njov/55q2Fgl37OOZcMkTgYqWW9HC3b46osIEt0twqN6OFkGAXaISzQFt
 QqSvanJfcxTczTAaTOLDLNgbNJIQdJewkFKIMMEaIX1RltbTJrPggNegjKA==
X-Gm-Gg: AYBFou3u1RuKWMrR1aoHlPMuX8s7ZPxilDbgNZLn3m/svUyj1+6S2Vgqp4qejs6Oa10
 vfPRPlw7OQd6lu0SE5BSUcED19f2foF2E9rG40rEtBhjW+JQzoOv2RfLlFi9yHgd69zPEML5SFl
 BdTjyYv99Wmyiu1K59l03T+vdSDHTcCNHbILCln1epI5GN24x+rfzj8q4sohXjd1K3tYOT6vMrU
 y+ldF/de2yx4ehnunNU99186OtWeLnfGdMRydsmKxDvxUvl3QQuJk05vRwQ37FpFbbMJykiL5VU
 y7PM+vw01ra31yx4GAonhEZBxlG4/NHvdh3yQ8657fNRhs0tdorf/a6J33iUrq170wCSPKtuSHO
 ANjlBgbaKHsU+b6PELLKXtb9el7cRtho06w==
X-Received: by 2002:a05:620a:4045:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93cac0bcae6mr24618085a.16.1790752330676; 
 Wed, 30 Sep 2026 00:12:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4045:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93cac0bcae6mr24615285a.16.1790752330220; 
 Wed, 30 Sep 2026 00:12:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029be71csm1339601f8f.9.2026.09.30.00.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:12:09 -0700 (PDT)
Message-ID: <1553649c-0a0e-4fcf-8252-d3f24757c274@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] tests/tcg/mips64/mips64r6: add msa tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929212439.110454-22-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929212439.110454-22-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h19JlNwfUo-4voYpHMAjNktA6VZT_FkI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX/Qkpudg3xN1/
 Epq5rmFczcC+wiHCdGFt6UHn33C44WWRXzKwybFo8UwGZm5QmtENMS5hBd/1WJk0PSbBx/JzLye
 4j2yJEPtg0KBy8dcEugM5cb0n7tc+SJgNyy+8+bBvlp3y555PdS7qKiy0Qz4E/azwfCWGI9S7i8
 8lwON3jAdXAmt02DUiCdxb7cY822A8ayACkNNCSteughLebaCcp08X+PjlftsxvYhZ/jGuC/KSq
 UczIjHf1fvD5u5+gzyq2QeP2OPrVfEolQvxgRHuHqiKROuWSeTQXPXqFPLvLO5/GhCydl7Fr9gO
 WQYfPzpLaAVdHEUiVIKO1uiSg6JJjJxpWKyt/W4OjrO4CFGZFLLaNt8aogyoqcKRwCfG9dVkU2o
 CVemAq/yjYIfugpKPLFqPymJG/1WaMVlipzD7zTnAqzepVJPPhEF7+8Dpsxxouu3yzHNbu1zqq5
 EOfYhlszwo3rWTx03Xw==
X-Proofpoint-ORIG-GUID: h19JlNwfUo-4voYpHMAjNktA6VZT_FkI
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abcb64b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VxAk22fqlfwA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX63C7CV2smgyI
 j5ncwDrk0+oL5IZke2qTBsFBm2GGkx5WGcqkODO83Ul79ML8stBboyx4sNAZBps4To1jYtL+cmI
 QeeUQR6fJZ9KDwbSESH7oND9UJpVjXA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300028
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

On 29/9/26 23:24, Pierrick Bouvier wrote:
> Those tests are added to mips64r6 and mips64r6el test suites.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mips64/meson.build | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

