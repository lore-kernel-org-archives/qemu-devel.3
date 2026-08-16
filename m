Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B44DC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcUE-0001iV-5s; Sun, 16 Aug 2026 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcU8-0001hz-2c
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:09:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcU6-0003zr-3Z
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:09:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkmZK2760396
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 15:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jb0UemLD4VBI160vsDqlAn7wGpxKJ+kZdQfp3oLDiH8=; b=NhoBJ7dJDf5ycTCf
 xwGJG9E1XuLz+mg9u9zmFO7OLjEV8o8nvMfkJ/zsDrSJk4aAVho6/j19YEQksxSq
 gk0QJ7SQwIqSB51OovTmaaTW7Grj41G+YeTIHosM/7EGj2snSJV3bJjWp13raFyW
 IVyqwys7mMMa0Z14cO/p0WJA6dVyjCDEleIqZrD/cmVjSuKeFu8cJxaCc7DaioAq
 XKyYz00R7bWS4+31MviJz/9fOwrGVLDp9V+OcnOUVYCQzfCe7JxSWjEZCKlRtNAE
 2RrcJ1Gh4af6Wba2kFZ+5+B1opSCV/PcKCXwvj3Ioy1buNn0B+4GZ+lb+VI43/jU
 Aq4I4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkjau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 15:09:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a236220so25156351cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892951; x=1787497751; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jb0UemLD4VBI160vsDqlAn7wGpxKJ+kZdQfp3oLDiH8=;
 b=S7HTh9TpppK5fsN2d2ttZcKiWhO7qnpr0Les3gmtNPFOGS1NXrQAdo+uVCgJQ1MPdg
 PEJzt2NFyJt3/dIsc29s+vKR/zn70K3vOHyk8dBDnWPum9GXFQu1KVMbgBr68aPCIBz7
 1KDVSicemkC/vQKS8o5YTRrYvYJmskSmaX9sbNCsQz49krga0al4KbcEwJBZlZQHtNbg
 kPKgMjWhrDgBqOEnCZxye/AN04cBTrI6dZFVivrtsIrj1wsCrKNi+rfyIxx8t2Kf0zvo
 jaCX5jumPbyyZZp9x30NGpvW6oARoJiAB9Y1I0GWMQR5Vp+Y1aIN13dE1fG3RLadGKYz
 8bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892951; x=1787497751;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jb0UemLD4VBI160vsDqlAn7wGpxKJ+kZdQfp3oLDiH8=;
 b=AoTf4b/vXe7JhKYmbTGF7Y78275TvFm87ZIrXwdNYHJmehHy95mj7ByBTPOlzM+bVN
 XdE0n/GCTRacqXkOuhTdxuw5NpsjTmVAuCWHqHSmRPSUzhu/S/KzptELPhCtkIrw0/BJ
 dtE5TZn4vT/mjmlWldky/3NHP1UXjWCrxE6FlFmel6DquEpPhbE/kQN/4B6kxnYu2wJL
 Zh4IKz13gKlPkuTvjRbkM6nBVt8tUXVFVUgew0Jkzhc5r1DaK+om9z+k3JbBJZ7uycC2
 xCx5ZczCnuJy5zzgX/NACUhkF7VWGoe7QHT6QHnujH9VlouyU84qZtdxQn/imn5OYP6i
 U9Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+RolnFDrw/jN/N7/tsbptB4DbLr6rwBy3dDjqhP8l9nmSpS2jGE0Z1Nvt6IDkif8P8sAFhNXUDrHmbKA@nongnu.org
X-Gm-Message-State: AOJu0YwZe5QsR7TApHljFW0sWZvjJ1FIrmaIglzoTaPDll5W0bWCXvO+
 V/6xHzqgYfZM5WEt1paZaNsntCsiwl+XgzRDpCPXOgnhccY16eqedQUj+TzfbAWCsCB7mvf4GY3
 iayZ1rW98ZDA5cls3bi3PJq+xbifheFd+qoKnkkYO+CWwDoer5TOGezwl1g==
X-Gm-Gg: AR+sD13EBhpWRKi5GgjVYNst+72Buhn60cPU7cwu4LOWnjQyZv+hu284RmNd+Y1MN8I
 YYg5tkGG9X0C2w8p45Zxl0vHJZuWsP+IAF5zF/8YxNzcSY0A7q6cQof/AlSwfXfMoCdY092Xhvp
 0EpVdBjHAK8SZF7yI731yrZGURDFa0N0jJnvGgOMKZPWX4c7jNWsOdsYXYkyYMYluyLjwjJ9KQH
 bV+0R8rfTrtlWMJp00fcTFRsR1x7mGWWSCncf2eIjMj/bXFJJ/J6O2iZwMI/aofPQ5xUeI/wpCL
 ksb4o2gwKxnE0LJOdJutPVXcgJR9qHdw4FLBS7KaU8QtZ+xDpax/u7MiyWBBUciVacPWl20LIaa
 pvYh/Nq3ATLcuEb3lyQRqwVfJtFucr32GuCg=
X-Received: by 2002:ac8:6f09:0:b0:52d:7b2a:938 with SMTP id
 d75a77b69052e-52d85382d28mr222701261cf.6.1786892951231; 
 Sun, 16 Aug 2026 08:09:11 -0700 (PDT)
X-Received: by 2002:ac8:6f09:0:b0:52d:7b2a:938 with SMTP id
 d75a77b69052e-52d85382d28mr222700391cf.6.1786892950763; 
 Sun, 16 Aug 2026 08:09:10 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610e381sm74432945e9.9.2026.08.16.08.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 08:09:10 -0700 (PDT)
Message-ID: <9ab471ab-db11-4da0-ac68-bedfe5a7012b@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 17:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/18] target/riscv: Return bool from pmp_is_in_range
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5H8N6IvAcshRlPetl88AhSmA0XOFdBIu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDEyMSBTYWx0ZWRfXy2dRnBQou9aB
 LdQz1Mcl8bNlUeFR8VMrObWG1W8YClXHnlSlgUKGt6eWU1rxBhhNPoN9h8t766K0HNoOnrgxe4G
 v4NoGylPaCHOjniQFuTpiLhRfJSrBaI=
X-Proofpoint-GUID: 5H8N6IvAcshRlPetl88AhSmA0XOFdBIu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDEyMSBTYWx0ZWRfXyqlABNZ1w0hv
 K/4eEuOSusnrfWipmsAOrje2Bn9TOgg+JZltW8a6UnqgfmNGQ31LmNyWSMaPsvBPDHtn22e61JD
 OPX3eRZIXKRRUpcvI6/sWTt+0iw3F3VfhnT1HZ1CwXnNp9kXJJ/SKHYeTkBhocTJvkHKXfLQyOI
 YoWK6nxDHKGihq9uoaWg8KMf4dAeJ2Ht1nD8YrYlW+xfrqF42GFNMi6E7UjL77cfPTPjaY/IJT5
 GThLkhxUlG+EuHV3uH/gpHHcP3Mf94Qfqt7GkPT9DQaiZLKm5OntvfXxbbNc6Eel+9rIXzTP6BE
 yv7+p7NYNINZjhVxevVnLKFmU4MBnmYop2voQL/sfPyO/UCuuQOhHM1sKOoa8coL/xNrrNI4/f7
 Zf0W3LjqY2BQf+NxsDpZf2SmiEt5fPdTg2b47YZqcfXBkXAJn5z0m3R1YSCyiOe37mHw4aV4zRs
 WaYl4RjXc3aq64M4MuQ==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81d298 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160121
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

On 15/8/26 22:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/tcg/pmp.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

