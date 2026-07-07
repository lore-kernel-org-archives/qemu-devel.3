Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB18FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzDG-00077r-Vv; Tue, 07 Jul 2026 02:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzDF-00077g-4D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:23:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgzDD-0003QM-JN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:23:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6676Ka7Z2922690
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fko8LfwN0eSac10rbxrtRtjc9E1t9+RN95L12wEc5Xg=; b=FAZNWm0WfyRJYXhI
 rnod+HPoCOZ/0aAXvu9sqZ08qfsCJ9qy0lSvuMzvo12/g/vVojAYtGAA1d6Jr3p2
 eqlo/nfcWSzyufFdP+etFJ6rH+EmuP+4SJF1whh8aJu1b6RBQ9dXArcYmlFAkoAJ
 h92evtql1doqwjNAwvQY0qqw5hwkEA2QqZnOic/Zu/Wk3rNJ20mPDf8a2ZioMCM7
 kisXzliozqf8XfJIkzkU4b40Z7ljsn6w+U97G9OXhTTEyMS5Nvx6t4SbQt5yTnY/
 VVMh/BH4bQIzIlr64SOAybRPaHZc6QBOYqfOeH9ps0tMpUnoS9bZt1EyAXKlDeFq
 lgCcng==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t80ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:23:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c12e43b98so47158941cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405397; x=1784010197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fko8LfwN0eSac10rbxrtRtjc9E1t9+RN95L12wEc5Xg=;
 b=Z3dA3TXE0Zk99uMvTblRZ4vtDym1TTVZxtbiCjmvWQp1B338HoOM8AfcJhiV+mGygu
 yMxse7dqIMt9Fq9vuxjevZ+CLvb66HoqoM5LuBfquCAzEZ6GTmP7uJUZSZqgzpzX0LCT
 vRhHwcgaeKBjEux4EAoA2xEe1Q/frNfBK8MbipoKspNEQyN9l8Qv0ydWHzdFWABFY0Su
 Z0r90xHyYDMdO8+WX3PJ+BMk2M8d3eccvQZ5dscXLmxdEj4hkGbHjFJWZTOafZVOEafw
 LVqJ5kDlFvPpEbJzoom8NRg8Z7opb9AgrMp6MVa5bJZMDSQyUK/X5muK9D42u0SWNeSV
 ChMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405397; x=1784010197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fko8LfwN0eSac10rbxrtRtjc9E1t9+RN95L12wEc5Xg=;
 b=iR2jjHeNyO1cZcZt27WoEr/bvXfl66l617B2tY2+6wYpW/fRdWehd0s3ENdGntBZRx
 JX4+9ry/GrEIwXgz90eAD37yGLmpjEHKMqRlr3uRPgMa6WY+KD1DjoxON0Pd5UTQ5iAL
 cvZK84GUwXGi237FF7ez8zkSSzisxppCMscsXEd77wbvRxE8nnql7mtxAjbPoYji0C9Q
 u2M/MC6gT3wl0BtQe4CaYFHuscBMSFliqWfYOjFR7FXkpUHeeS+ZPUyjKd52MY1BLrqn
 IOMLKjPbiXDMqQqbYKHhzOMD9B2JXYvEfPmCI4Tbm8wxKkT0ymGZJYVP5sUZofvBfVpB
 s8JQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGRWBCUCsKhHUwMCIy9TOHNMFbo9qlx8fgSyKEHcEEfgxgkKj70xl+1n/pXWrH02npTCK+wCXPx7V2@nongnu.org
X-Gm-Message-State: AOJu0YyLoQwvI9Vja7L6qfCdG3AewJxgR6mYBl/sA0mnxaiVMr6591lm
 xCQDpHpbAQolWxFu9SVqDeR1TgJDqigoV4LYvjEoxKxu61UBrOrZ+0B0zldlh+LOCJsZ2bji6q9
 WZPPyMFv/NqqVJ3BJDS0Gbfz14URcLsK2DP4R0snvWC++5oMbKvGTY6cieQ==
X-Gm-Gg: AfdE7cnQF6Xc0Kz6uMJlj4BKUAC8KBgCMeKNhvrjywpnv6qWspeWs5E8qfUho1MH//l
 5Kh6RA018tmnlt/z3CKdeEM2BN4+/IejD8+M5w9D3Upyjm1xzjz82DfduqoWsBTsjxrOMI2Cn2G
 Lm7jjGU8t8Sq/XE29+CTs+F60iAThqE3FHoJ8LqlzFeNej1xFzgoO8QHTP7CEmJDHlBEqspccZv
 jNXxnlqUM23eMYpiXH0olRveB4bVkjuDOuhNwKqcBdiDFawAK6mq1/L8pvzG7P7lX8eYL33daWF
 EFA4ACNsD3BZFNgytUMFFD/aGzoJzJuswcafHjAO+XZN7h3oStx7JViISRCL62TZivcX2f0oSv+
 AnhUy9ouS6gmnfv+1iCgx9B6wYmAA3TZdEmc1NI1iMf12AgWVROndqsCwVGgAfQ==
X-Received: by 2002:a05:622a:11cc:b0:51c:504:2ef7 with SMTP id
 d75a77b69052e-51c748df0bamr42189481cf.67.1783405397308; 
 Mon, 06 Jul 2026 23:23:17 -0700 (PDT)
X-Received: by 2002:a05:622a:11cc:b0:51c:504:2ef7 with SMTP id
 d75a77b69052e-51c748df0bamr42189231cf.67.1783405396804; 
 Mon, 06 Jul 2026 23:23:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm36166920f8f.17.2026.07.06.23.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:23:16 -0700 (PDT)
Message-ID: <92481686-c1c8-45bf-862d-381b3bcc4341@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 62/91]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-63-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-63-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OJdmJLOyDauNOG0tDNmvEAtS5MiAiiZ_
X-Proofpoint-ORIG-GUID: OJdmJLOyDauNOG0tDNmvEAtS5MiAiiZ_
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4c9b55 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QCpfR-XgargAb6klsF4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX1xYxKcbz1uHr
 57kIQcuQv/NF0WlrK0X+wZiEt63i55bnayDH2X96RxU85529UgjqX9d0VTNZfWe602sm3THdWtU
 0AZq3u/Q2Z7sy9ThIdiRSsIthVliuefxQGyUcjjD8TTx5GmcCmTvRUZc65A7qjLtVQ+69lRzZ3F
 sSLP5VxduMh7Z1tDAlK3OYVz9TC2owMUbpxib+P2R1mjdU/I1WvCrHEgIUaAvZIiWd0bXLIzazl
 gCZ6krDAA3umnDAOueUTCYjm/WDMiAjybv8ANYFi8YVxBi9DKmhkWJnUY9maHx6mV8VVmJqzqmA
 fPGO8rvCwplnmA7dICyj1NeqieQtHMx8OSGoTEUFGthb+Tq/P4ZZddW62W7lXJnv0dBjm85cXiy
 itdxN59lUfufnjGonPnvvDLOZyZAz9BQU1Ba70kFYdHuexrYU5yQaXZkVZZ34ZSfP0oHvOTXYTh
 1+lKu7xL+jAgH1300oQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX1Z/vDGyi6e+E
 0hDZTzHBKfAf2Zg+0pNAbdUWZ3WGqXAkQ871dFaU4a0DG71VEkSFD+NPCYMLPGMyKm3EC0DbSw6
 9a6dcKiycqZjYkNblUVhacTYyuRs2gs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058
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

On 7/7/26 00:33, Pierrick Bouvier wrote:
> To avoid escape hell in tests/lcitool/refresh, just use a raw
> multiline string instead of a list of strings.

Could we have 1 patch for raw multiline conversion and another
adding the or1k toolchain?

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   .../dockerfiles/debian-all-test-cross.docker  |  16 ++-
>   tests/lcitool/refresh                         | 107 ++++++++++--------
>   2 files changed, 75 insertions(+), 48 deletions(-)


