Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8FFC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk4P-0001Pc-Do; Mon, 20 Jul 2026 05:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlk4I-0001Oi-TF
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:13:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlk4E-0006sC-Cw
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:13:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K776GD1896515
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H45EdT7PJAzojmZrGn7V0dGBEfvxtgTh28DMSwfNTQA=; b=fv6Lep/+4v2hE3RZ
 R6Nhsh10tJuAg2OLAtKUJdv0QL/kv1/UZMQD0i1vcyrfEC5szpew+BchLoSLOX/M
 BmcWsRX8KF3GniVg27JD/5/FCkzkoV4E8STmTOWEcw3h+fLtW5TrAgKtPZeNZOfw
 TjgfRpALTP3C20c+e6wurJFHowsTkBOCJLolG+Vnv9F3e3SxTTm3Q3L6yvD09rkT
 braoteZPh3XgMJhH5xPFvHynmvtecsKqFNi1Ah2WV2m1xKrCWs+Yem5YkUuydjnU
 7lNQ8CUVAHpWWx9aGfdtFxtzboERyXkQ2fLfZiug8RGpWhYKAxyZ1NXP/HGl7kiT
 77RWdg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0krkfg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:13:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bf321d786so83635521cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784538820; x=1785143620; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H45EdT7PJAzojmZrGn7V0dGBEfvxtgTh28DMSwfNTQA=;
 b=RjkgQlS9YVX6XT0/m4wPtbj7vo43BDDA1oyEghrpqTSt0eBC3czqxM95EDy6/UcQ4/
 4zg20Sh9ISGHrUNIvUFhSQfmqhV6Dvj4QDWYGXL6+muHZSJaUJX69b2im9ISDm7x/JN+
 J6mRNCXikFgBQa5orObiie9+1pnguDTalcOpl0XgoMhZIk5I6lfRI9XG7Kok9sdtDenv
 XhRNOVwNL5hd9Js/Ac8hO3SEVAi5GVy8gk7mmxbN6+EtMlWQbe9B5dDx2x7IF7irLEHR
 0NmNf9GVPiXRfblVH/IwHBRGV0mxyvayd/n4Fxzgaul+xrgbYlkqKBl7tlIt+AI6utF8
 9nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784538820; x=1785143620;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H45EdT7PJAzojmZrGn7V0dGBEfvxtgTh28DMSwfNTQA=;
 b=EUU2tgHEwbkmiUVTPX8uEn+Q1R38dzb+n9pKokbvK2T0GF6mxOAK94YofARbn+J1x5
 rHv00nGQlGsmH96+V9+q895oFtyRs8HYsfc3gXsVoSwZmdEpLWY6azKX793ML+1wCxA0
 6uc1vstc7DuzXyj21HW8BnRVLgP2RVC+7DXreSR9Xj/9ESScaqBUzpDXzEssdpd3yATD
 foMJEsXd/LX1H600jYN0ps1gAYOYfHsGSXyIsoMY2KdOPQe+RWqN48uPmajMXEyC9pTP
 1oTg52aCrG/4Vr7rAIA0SOi/YaNXloYQpTU2Sv9LoMZrwJj4LMtlRpIkGO5CeZ78nLZT
 Darw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCfiCxVDIqu/wNQH+++NtT0sVTQ7v2fvwv1Z6GU6I0/kj42+/EWJ458nIqEDVyZGzI/wTKY2tu2YBl@nongnu.org
X-Gm-Message-State: AOJu0Yxx8tRk0waXNbNgVFnK/uQLaOQaWUl8frCEMtPRga3F4aIRmewL
 99BgeN4NiOTnAMVudeU5oStiFrfa9S+exNImti2FH6VoHJMoNyh/REja5oIhaXfuMFjtXjIpFRb
 2tJKW2mX37nvwVLHZ6ewIwVii7/oDWWzS5vcJjZVVIM/0k7dB86OEPJ3FqQU12Hkd9Q==
X-Gm-Gg: AfdE7cnEIadjBDig38oLF829VI6Pt7ceWZpNGqJJP5gAQXXGy9AdWkOp3QTcD5+mbKP
 H1Yg0v+5kBKJLFGak1/sdd+Y9HvSZ8tpESpQSlcA1HT4e1K7TUUehK+/CI7k5VjeOAE3sV6RMlX
 QuJnCStAmcyVtmNcv1Yu87Hfdej26g9zGANHyiBC5R/Zk19F/j0gl/r9oa7dKVbl8TtHXxkg/TU
 We/gF3cbxj8NlV+PhAw1qZ8Oz5D/fgqGoJQBR5FdCgceRXt1w/3wxVQIC7DrtpDzrOPi5d3YCX+
 QEGrPNB/LqieUAJbB/O1UvUaQzfFcryelLStT0svsxNeciyx4FSUEFpT8ZwPDCWDbVP+PmJn6w9
 R80bKfWv81kevEXz45VzMf0IYtAepYLvnAiTDq6UZF0rLZhGBA7g=
X-Received: by 2002:a05:622a:1b88:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-5213c8dfaa2mr118198571cf.27.1784538820354; 
 Mon, 20 Jul 2026 02:13:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1b88:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-5213c8dfaa2mr118198331cf.27.1784538819878; 
 Mon, 20 Jul 2026 02:13:39 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6980582csm21043349f8f.13.2026.07.20.02.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 02:13:38 -0700 (PDT)
Message-ID: <7f933602-deed-48fb-b8a5-6a29672fc9c3@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] qom/object.c: introduce
 DEFINE_OBJECT_PROPERTY_SCALAR_METHODS() macro
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
 <20260717135254.508701-4-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717135254.508701-4-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5iGtHULpBrfXrErJ4v-eCwEK5MCg5OdD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMiBTYWx0ZWRfX692iTWOBOU/l
 BWf+ToDL35NXgYOREPXcgpTdMQE4J8EB3RJLcMa5+2aqGJ2NLqjveNsv6A0A5a7490U/jci1ph3
 AV0WVG8sbaCyZcFN7JlyJTP6vQc/f9o=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5de6c4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMiBTYWx0ZWRfX6ksCmSajw6Hg
 J5GyewfPW9AHXpXaQSrn4ZqHpwdUT4bRs//5bQM8McImv4Qy2a4SsJj1zar8rlWYZ0bbDONYAns
 xjV26+M1bhjIAwmuEFapFt0mDowKIwPPpbuy8hIxZDVacgAQHDOcz82AvfXy70RhJnBN90frOJh
 5rkuSV4VQWySnL86okcBsrwRsNekdxX42Q7WElPGf1FhB05aHdx8Dj8JvWJFOJw50KveHw1E+qx
 hZfj+eEGxzeKJ9WViWb8RKgStzIrZV8o/BOfcuNI7zZkX8pdJMeY3S3B9ivRstUPwdxBldn1yZR
 42lavGFUiEJdFfiG7KpGSoMEgKaJZJfwn2OPENe1zxywnq9IIHvVMMXUD/Z2EbqCxuRU5dv9RnN
 hOhgxTycRqsMi6A5fzFjek7o5musU7rnOc6qbV24ghwYMpsXeKcbMmKGDZpT6SDYOncwWvikw1S
 Bt94mbBHRVHEEHN8XKg==
X-Proofpoint-GUID: 5iGtHULpBrfXrErJ4v-eCwEK5MCg5OdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200102
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

On 17/7/26 15:51, Mark Cave-Ayland wrote:
> This macro defines both the QOM get and set functions for the given scaler
> type. Replace the combined use of OBJECT_PROPERTY_SCALAR_GETTER() and
> OBJECT_PROPERTY_SCALAR_SETTER() with the new macro.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qom/object.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

