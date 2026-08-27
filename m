Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373B7C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzd7V-0006vu-Pw; Thu, 27 Aug 2026 12:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzd7N-0006t7-Jy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:38:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzd7L-0005GW-LW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:38:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RFbuQl3921344
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KLct+LVkmc4dQFhgbNJuVze9hSwNoskV2Ss0U0j5+pg=; b=OmOMsBBNsFyFNshQ
 31l+ppnjj+3BMk0zcqY0GY6O3y0aM1tC8D3PfsKW6wGnckXu9qw6pRQ2Id3NSOlb
 yPRY3zDkZsDh45SYYGIbPPcHYcRbsWIb3SlXAk9bHbZT5rLEBjqHGnEF0DuL6zvC
 kOeS8eL0/2AZ66XWYo6lXSHRncIgSasfGX29XM6rvaKhjNDLkJ0LlJ8RlW9s8HS0
 pivb+IgEqS1g3t/EORejS7+j0AtmQl6xVvz4XM6fEouPq2o10D9XjgIfP4qtbxEE
 pMJyvg/xsQlKmh7ygh9N8/3gEN/WKa+QWkK8A51QyaklY+3tdLs9sjplE0q+XcDR
 GHldTQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw0nh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:38:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so438575ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787848698; x=1788453498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLct+LVkmc4dQFhgbNJuVze9hSwNoskV2Ss0U0j5+pg=;
 b=ktUElEPmuSVC6CR8mlb4RZOH1ANhdTQBoUX3EhVHseYgNifMeZfuKyH2NH4xSlwIqC
 +NcFzxwfC3UErqkkkNF6OTii5qFO63s04Tx7ATsCnFGkP2N7HA8/VHN8XQ9xP/c6a0Iv
 8wz3DWPjjcXiUZpYOYjiJ0YZmcsPWaycbHor/W+0x9rWkWRsclZvTIrikdSlCvFik0t9
 bg9UIbDiTFYvmwsURzxXDdV/dSOEALuTbmvLoCowASVkeqXK3aML4PcVk3N+/OUn8XzT
 kx9ES2E1fnq6E1+0l6tuy1Rg91xn8UCmSqSqSaaDqn6cemDRpicbWfQhCL3yyEUeHALi
 97AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787848698; x=1788453498;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLct+LVkmc4dQFhgbNJuVze9hSwNoskV2Ss0U0j5+pg=;
 b=SPlNBiBqB2qZgxBZF2mpsz8pQ7a0isN/47TezU7yCrrceH+apqVYwCc8JWXUH8MLH6
 fbcECt0DwjAOn8St3p0LISLbp1+UR8sKV1uQkoCsDSMnoixXS91W8qKowp2jUZA0IcvR
 cEzaK1wqcDIgUxbhrOl28CIYibhPF8KaRlCnRq+GAts/8vA0euaML3aPe2WSaKx+OfTh
 Kb7To4uQ3GI6yCN8377f0mA9C92qIkbgHWtXfJw3o8Wd5j1Jcium2C42g+HpEIbqDzFO
 iR3O2V7VFrMWj3W2zKkPc2Hld755mt5H6xai3AoiMzCzYTnwvCug+5EqNjXvtTIKo10H
 5E7A==
X-Gm-Message-State: AFuF++kbojtLTuayiqgivw8txI+b9JiKwDN8G9YA5GfYpJFuU9BxW9aQ
 4YB9pdsUpeFkyTd0nGz/hWePjHH9oAjvPbJH/8inEdQQuxw0oI0Mwyry8VpwuWifWT7ngnsKHNw
 Tv9hg172bmqRzAJu85xOOAZ1ao+dJoOigyCKdgJV1Tfg4ZSCFlQd2/PVKXw==
X-Gm-Gg: AR+sD108Je1ll2caceDeYjaIMBzfBS5aQxpOqTKrbDcxtXaEAp0WmqkLalyjffv3Kkb
 84dYkzN0gok3YA3iWSuQSKwcxDrZ2c0ogLVN5/BmJcNn/SOoZOB5hVzFEXaFAJdEqUdXJ8LjZ+0
 G/zNN7gj8FomhlonwyzzFK+d6g8Q1rfg6c0URd/Lg/QHxgoqVE8J7mz7eHGMtCGaYY3qakvJmtX
 xEr9EqLaJJsxhdey9Yy8ZpF7s8OcXpvxskOZ+WM4Q1V1qevZG4ROfZsYNRQ/1zpacF7g/1a9T8p
 q1OkohVLE+kAOZ9SLYOAN1zGyk9w6W2A1nzmwgVgJA4XM5+v4YI6MTC+pIicMhPEdznxj45y5ez
 BgMaknhkQRhMQ6wsUVJYuOKXPCsKwL7PPJtUM/+j12xK+zSkpiQKBQIfSmgZP7/e+VD1D
X-Received: by 2002:a17:90b:2dc5:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-396d0e83c28mr987454a91.5.1787848697733; 
 Thu, 27 Aug 2026 09:38:17 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc5:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-396d0e83c28mr987357a91.5.1787848697253; 
 Thu, 27 Aug 2026 09:38:17 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60d25esm23502147eec.4.2026.08.27.09.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:38:16 -0700 (PDT)
Message-ID: <e596141e-a02e-4fec-a1c0-9d517c66e9d7@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:38:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg/cpu32: make compilation unit common
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, qemu-arm@nongnu.org
References: <20260821213536.433273-1-pierrick.bouvier@oss.qualcomm.com>
 <CAFEAcA-gqJb-1k3viJng4V3uKFs+j4L5-_x=6Cgz_GP4crpzPA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-gqJb-1k3viJng4V3uKFs+j4L5-_x=6Cgz_GP4crpzPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CKiLQzrZn8G5s4xp2rCo5wmwoo6OG6TI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX/Vyo1kRoRJMs
 sqGl4hP4s64Oi63Y1j2H3iVl7WMa/Aage+kPqTH1/jbDzyOZcUwValat0+I3DmJ773xa8lEJvEA
 QTXXXeWyf1KkzRU1RDtYET+pPFN/DHI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX0ly9H00M9DOf
 ZnR0eL4WKLZ13IENPifNtQSSJyzrLTLzcbGgLnM8MLVJDgWNkBlbQgcLMABaAivue5Gk0kShIbN
 0ZVQRUbWoIEsVIihUcVk6xiT1sA9r+p/Iuwa2wMTl9EVkHudUX0x1qiKlmPiGF6L3pKQ89FzSfS
 DuKSFCJWX0ODbHObINswhPUeO3BALN4HJ3/O3aakHd6rHluUgvmpCL0xMFVieBByrJny4/z63Ul
 mNB1iq/W7L+VyAPAplUEbgkpzg6uE2wr0XETQYfevNeNPBbcmXQC3l9NaXuna/qW7nExUvUcLNQ
 GwRv6iU/tA6pj5jqVCCXbHsVqsD4RKKsOj5wkDAAWMISTi2GfwO7KBrkV35sRF8q1BbX9oD82hp
 Wp12TxKiB/slJmvqMz2RiNQBaT90u8QSyNMe6yUlZ9Gsy4TS7HLRiwcqc0Yb1l48e/Lbv708CMs
 s9sETMwyhUeLuzjcW6g==
X-Proofpoint-ORIG-GUID: CKiLQzrZn8G5s4xp2rCo5wmwoo6OG6TI
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a9067fa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=GaQpPoNlAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PaJ_WkIlcEXtLoyfFkQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=xF5q_uoM5gZT5J3czcBi:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140
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

On 8/27/2026 7:20 AM, Peter Maydell wrote:
> On Fri, 21 Aug 2026 at 22:35, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> We just need to remove TARGET_AARCH64. Simply expose all the code and
>> conditionnally register types.
>> This fixes single-binary with arm + aarch64 targets.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> RTH has proposed an alternative in
> https://patchew.org/QEMU/20260827041557.775080-1-richard.henderson@linaro.org/20260827041557.775080-3-richard.henderson@linaro.org/
>  -- are you OK with that approach instead, or do you prefer this patch?
>

Yes it works for me!

> thanks
> -- PMM

Regards,
Pierrick

