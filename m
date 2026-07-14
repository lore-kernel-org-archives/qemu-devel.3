Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F66C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjf8y-0007uF-0G; Tue, 14 Jul 2026 11:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjf8w-0007u3-I6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:33:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjf8u-0006Sz-SB
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:33:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcREW849685
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zm4gaUhcylwbFspdlpLblORhCmqyARBDz8rXWQ3jvpk=; b=C6Ckh/9b3wV/06eo
 898Nlzft6d0TEZ+C7bd0X8CcupK4AI7RMeezeCoAjyJjlJJvp3fKZE8Sjhs7RzG8
 9UpBCuJZMqkd/Atj1ZlylFw/Fu+6X8qKUbWux9RVQKTEQfjn/o/Ce0qHe1e/UGaZ
 8Bk1/ExkCv+dC4GBOzJB9HHaNnpzbkwzR0NWcnuDtUZG3YB5Ut7p1TjttqaMU3B1
 uUKtF7CSxBAYx0E3Kw24La9cV6XBF3j2NvRZ0Qxi2IZnSPJtoKXqSvGDak4LYOtg
 ywtf0/fr30Pe0A6fW6K947qlr4MiyRWcITqMKph0sW6SLO86QrrZAFAaFWR+UGg3
 Zg88tQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdeu4je4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:33:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848544a8496so1469824b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784043233; x=1784648033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zm4gaUhcylwbFspdlpLblORhCmqyARBDz8rXWQ3jvpk=;
 b=OtMizyJzqaS7WovoOkg8tLm6iSWLcyAATVAjkvPmKDZKzAMnVq6gIiB8BgdIk6ar40
 e4uknMZfAEx/0BBbvodndijZu7h8MD72GzbTVA6CQjHGVcl/LlxctEmK20INUo3dw0VN
 gawQzMIGt25/jJiJiI+g8wJ3Qr8IcO5kSy0kOxsYUH2nPluKRlMTX1z7B+YZ188bzgJ+
 Y1PrZvfiwFFjY8GjiMe9iqhufQJgkwhUlmzBrXaLgS6Z8NpH5ZWBHJAIw6ZZVCv59m1u
 zVipHw43+up/qhcc30W0ARKcwKifXn8Fys0R4YyLnfGKd+vzbtDfUFooEq7UbfyuODLn
 jrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784043233; x=1784648033;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zm4gaUhcylwbFspdlpLblORhCmqyARBDz8rXWQ3jvpk=;
 b=UmUDwtFYX2fuPZZWNOq66ky3ZDUAxVa/wxaDSXTw8CU/1lkyyEhegUCopeNllv22gW
 h52JsoXvsECV91OdH9oITFeFJG7dnl4NmIef06gSUZN48eI+ngLAHtoZxLnBv1gGCbj2
 u7qeqokeEsAIoXUbxhisFa7DU/eKfyGJxV42nEMKo1brJ53UVp2Ia1LwCRTrvy1mnC68
 Ua8JZjvDeqns7XPRw7WnBQXoT2uzRoTiYLWaLCtKwHUsSiDteEPEGRzfzNY9FgetgFtv
 yb8c9jDXmWKZsg0K4wV59YbaaGdSm5eVyZPl16ra0l6ITK+e6318/VUfF6E5wr+hzPaE
 XDoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKBOj8b7ycdoTKegBk5GOeE06xzyLMxzLsdFf1qAHv6zncB3H/PP5oEk4cuAZ9QcW1eKblJOKT5hMu@nongnu.org
X-Gm-Message-State: AOJu0Yxw4VFtobe84ZIG7Zoog++/3if4R7kq4kKZBxp+Sn1V3BbxL/Ua
 fD2iLQZIAVPgTLBOXQhzb895yHSvUfw83zV5r5w45pvS8+6DYOFbvk5lVVNgBtrBCvXNRQeXtko
 TKJzGQNQHFL2/JIJyEWk7UVMzmh/V7NbeU6C5azSbylfvXas/tyvGXFj3SQ==
X-Gm-Gg: AfdE7cnHqm0jkZ9FDI2Xilk3Qyo+39aGsRVdO9r+tNJP6PH9OhqbybaR9vaXlbQ+RUe
 wMwaRKPQopLDThKqDFGVidG6jDoygybnJ0+LLvkczxNt4+SVAlJ/4nVz97tKuEk3BgWUKDJxGqK
 TGZo6i3cxBotl6KUL8HkneVl98o84yGfcub7Zi2Yo6YxIDfOlm8WU+oVP384XcT4p0iBsejJhwq
 YJB1DmLVsMdgeRkv21TZ930IY0/NbLMdGJhtEDK1YbW8+gmc+TVf128GocMrBkEg97iXaCP7/BQ
 aGUa3PP+fuCluxOctpIhqOgxPCfO+eIFXh4SyijzWbIm6rR3SB+NQUNpEjBCFBHkZ8/309r4Dbw
 kouW/O/g7jYzl6W18TBqFrAK/Duj+AV/lbLh46UylA8OOk8dEX3Ucjze0BO+8+oFODDm8lQDAqs
 kG9ew=
X-Received: by 2002:a05:6a21:6e91:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3c110b263e8mr14750363637.39.1784043232909; 
 Tue, 14 Jul 2026 08:33:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e91:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3c110b263e8mr14750330637.39.1784043232478; 
 Tue, 14 Jul 2026 08:33:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm52573931eec.5.2026.07.14.08.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 08:33:51 -0700 (PDT)
Message-ID: <0864e61f-742c-4c63-acc2-4ade31dc479f@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 08:33:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 84/98] tests/tcg/s390x: system tests
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-85-pierrick.bouvier@oss.qualcomm.com>
 <982adc65-5439-489e-9214-417b6fe64d96@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <982adc65-5439-489e-9214-417b6fe64d96@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0wkprNGITSAXtlWuw0ExIMyCko5_GJK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2MiBTYWx0ZWRfX/yKhf7F9PIa9
 sgtk930NKUAVm1q1kVPirMlI6FaVHz2fSUVCTAtouwe4y3W/GaqiELyESUMJR/WVj8sBxIPi9T8
 bQ2N43to7tKF6LvAqR8/oAsRQUOnoT6NQ8zCeATtxwIlQrD7jrFyEUcD+3BIdA8mXH7jCfBtNnS
 4Nuz/CMjq0+vJ3g5Ug07eN02o/vSbJE8c1M8FceEp1Ac3XFwVQOtMFi8m4LjCkbSWTuLo6mip/w
 vSWbdD821hG86q4Er8S0qsJt/XCZ2O8JgkpiqnWSvKXv4refl+GX3viLmRVn2jyxAOYTO09GAVS
 igMzFYmVPIhQuAVKdL89YHGLajEgwXys7znsKIHI0dQ1OzGbp3+6pZlHjGTAfNgjCkwjRIn2ZFm
 kPjjtNfiPp8yrdILNmOVeSfZdTdPkPW64jjg/ma8sTF4sp8IR4Nnm9sJCXRdANO8EcWsO6+6Ybm
 Uu3utpMrEEux9ZVzLFQ==
X-Proofpoint-GUID: 0wkprNGITSAXtlWuw0ExIMyCko5_GJK2
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a5656e2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Z86Wyh5pZSQCeOZBASkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2MiBTYWx0ZWRfXzdiDeq6AR3Wg
 a4CV8v7DmEqrdvpSFSX3UWuslSGbiToq5epx7+s2/Scpv98CDZ6Zc0wxPRFDxM4dudfKxxwAfGL
 p5GD9hvNshFX44BTvxwn6wzuJWbd43s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140162
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

On 7/14/2026 3:55 AM, Ilya Leoshkevich wrote:
> 
> 
> On 7/10/26 23:43, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/s390x/Makefile.softmmu-target | 57 ----------------
>>   tests/tcg/s390x/meson.build             |  2 +
>>   tests/tcg/s390x/system/meson.build      | 90 +++++++++++++++++++++++++
>>   3 files changed, 92 insertions(+), 57 deletions(-)
>>   delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>>   create mode 100644 tests/tcg/s390x/system/meson.build
> 
> Can we delete pgm-specification.mak now that both linux-user and softmmu
> users are gone? With that:
>

Good idea.

> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


