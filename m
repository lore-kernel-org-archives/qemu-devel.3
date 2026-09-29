Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D9CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBca2-0005dy-VE; Tue, 29 Sep 2026 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xBcZw-0005dj-B5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:29:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xBcZt-0000WE-9D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:29:24 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THhYbE3936567
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I4P+D+x80ZjKKWE0VdtQ3ZnQ83KV4jWXlCAa8DR5nB8=; b=FfS3hKmIebGYu1h7
 p8j8WyNn+8Mhuj/tZ7nZUe5vt71MAjZmxgIwRXuhFJyQ/DlXdwvFUV5MGIW6IH8z
 X3/D0YkxKTQIYJ5qz8T4U3FWnuTmF6bAA/UqrUkVc1BQFcwd4iJK/eQ2ZHR19JSm
 aResidBbKsJBjCSXuYmDsDObrtwo565a+DdktLyct4vS07fMBkaomU+XQnF0eIlD
 GhHpz5jFVsmCtHOHsI6me50wcrgeHC8Os0QdX0QlSxWH8haJkdBn50BNMW8gBAvL
 x/ZymAakflp2NAaNNH77mfipAxQM/Lu+WCf3Mr70+0bYFN3qqjfrmy/JE2t0qQXa
 2ppmEw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1j4y9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:29:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936708f129aso906139885a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790706557; x=1791311357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I4P+D+x80ZjKKWE0VdtQ3ZnQ83KV4jWXlCAa8DR5nB8=;
 b=BRvHIk2+vPku1nX/UuXA6qlMCM2yy/ODpcVud+ZR56nExo85AM7P6VU1/3UjBeaKw+
 +Qhz7mkxDjole0qQuuXbqILOhpYKTyFsDj1VpLWPyyRMt4hY4bLiKbmZyZmOX6TwXmPd
 rYoZn0xtdCAvjzSa0AWzQM8drDFsF/Ai9UPA6/S9k1AIzXmofpgszMJIjIOmH3OPooTs
 TxU8DyjA4fuPGlELkiaUOhr9ALgmLgUtr4+9TFT68pmk0E/nD8Oi2Pg7aifNyfDQxiJq
 QuvHcepSxIMTGFDbyjaAz3MRsesK/zt24FUh78IKsK2g+5ZuXQxg9mM7KW2AbzXEVqON
 +wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790706557; x=1791311357;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I4P+D+x80ZjKKWE0VdtQ3ZnQ83KV4jWXlCAa8DR5nB8=;
 b=THtT0Sp66dkv6zxViufBIXSJ7+1Wj0+AtZVJJgezeG6pvFEudZpIjrM0KajcXNJ2WZ
 cb5UQkEKqPAHjO4d+M08olpA7raRqgpJC0GbvE0U0Q4Ctjs4lGVcuNX+Fv0t3WjeJZRf
 AyRCWvnA/OEDSJpIH5uTL9xR3hGU49IaOE7nEk1kRyGkWRcRF020P7i/7Rx5iOcWvlSy
 SzRi4iLMeKNIphSpyewaIGg98LOq79Z3OpPix3JpMBvgKd7MeTFhw86q2qQnQsPGhsTb
 eqTob2gTijSZ51gk4vDT0FHtYLYTIHW/exbWQKnthvQboc3jEYy9uI4AeQRRYU/M/Rlk
 FFZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+1kL/6WpkjsNU083qtB5JTc9dLZYt5BkVo/vkb3bSK38QIgzSIzdOwtG4wjbTsA+CugEC/mywXClg@nongnu.org
X-Gm-Message-State: AFuF++kOxUc9x3jfAVIrDCHgV6mBDr+E0O4vN5pBqLGnrXHFnRq3heB4
 FanXHcR4LVDsghAK8lZiSa3ksGdx1vzP+RaBduuKAqGNclJYuuSsD1z9swEMaEOdG8EG4w4NH9W
 Qh/Fz1Ms6kdLQvHJ7jOxzzWmVSNojyU76+buJLOQsVkorP6IhhNAH518P0Q==
X-Gm-Gg: AYBFou2Hn6fKz9Ff1KoZ7f/Ladm/O+ao3PQp4fPfW6ThalBnYICsrz2tlYCXinCFPFy
 4oyAIdz4a1jORC6sAXZ7/h7XKotZUqZ6dRb7ALuWfkCzqQA7If2/GFC1+DfRoLBHwRAebLoa73L
 WlDC9gdS3hZZpwzYwZgGarQwtIuk24yj+IdJfWhWCwC6+RPrM16bs8lFpndEuOd47SupnGwERDE
 wZpKCVtBXLUQTnF2Dw/AjyMnjH/OF4z3dSU2E0kasBvI1K+2mxLG1MoEneYat3vY/1aRh91IuS4
 BaVVizQXI8vmIdr7MsQKpRX2u8hVdEjFCPVEAIjwe08XAWzsyC+RrlIlZ3sx0m7MS7TijdgWfOo
 EGpmn25OZQdK7bcMMQUwTeRxggAKPT8gLXeBywVDAsZU3SjJmRwr/L+DY24GYACiE+vd35PfPl+
 V5mMH+XhJ/3CS0eZ0jU7r0N4E=
X-Received: by 2002:a05:620a:2805:b0:93c:9edd:7e6b with SMTP id
 af79cd13be357-93c9f86af50mr82109185a.29.1790706556620; 
 Tue, 29 Sep 2026 11:29:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2805:b0:93c:9edd:7e6b with SMTP id
 af79cd13be357-93c9f86af50mr82104985a.29.1790706556180; 
 Tue, 29 Sep 2026 11:29:16 -0700 (PDT)
Received: from [10.222.168.145] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f2dd7b7sm35156885a.1.2026.09.29.11.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 11:29:15 -0700 (PDT)
Message-ID: <4ac8ef97-6a26-41eb-a3bd-988aff563011@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 13:29:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] target/hexagon: fix V6_vcmov reserved-bit encoding
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-5-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MyBTYWx0ZWRfX4uQpRsrKL4Ex
 rs0WKGd3Hp1fhIJkW0VwjJXVEJ2Xw6Tmv75NtowyYNhpX6mitAHlyMWBdeYM2KYmzWKeeXjjhKC
 aJWNBwbU9yorK6j3hA+4LzPm2/ZrIlw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MyBTYWx0ZWRfX6M/CShI4YiSz
 6ZZ36I/T76K56NfwkhCpuuueOo0eyLISgIenju2xId9+4JO5ZnBrsm4A7zHObZMZ5YLJHOcKfSD
 xeExB+o57eWj1jqaOqReH/+bDbXkwWgcLEUsj5XMJe4glkMe9D1W26T5/1LDFR06ZIKg4Ye1HHi
 OyK8wV0HM6BXMRXYnQ0jq2sKtqsI3Gzk6BMZURESsQsCyUFZ3MHo9Lta/eDoKnHwoVcy765Ed3Z
 Nm4QaTKQLR8hAfPUY7RsHgPn2J6wU9nDeskPH9AVUsTpanS37p10lpR8r0oA1hkTmzoJdyBBxUP
 3SkvI8eibhP9Fxvo/WNUUDiRXg7cGiEJaBai0AF7VPT8S19CuMYKsg4bFy0lcTheH0arRP/fQRr
 cc0sDF3pZMuhOw05gxR5Em8VYN/AQrRN/s4oFiEVOe9EloDY4gHxiO0yrUevgxkGMEcnFmLpZ+n
 YLZjld6g1auDUHTbkAg==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abc037d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=10vC_91aB5RVZ0RXlukA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: X4wsoiMQqBw5mMkZhciWEF7Jz7SEAPV6
X-Proofpoint-GUID: X4wsoiMQqBw5mMkZhciWEF7Jz7SEAPV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 26.09.2026 14:23, Brian Cain wrote:
> The architecture defines this encoding bit as zero.  Leaving it
> unconstrained accepts reserved encodings as V6_vcmov.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/imported/mmvec/encode_ext.def | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>


