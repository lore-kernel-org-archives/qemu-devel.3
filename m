Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2292C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzqz0-000327-J3; Fri, 28 Aug 2026 03:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzqyy-00031t-EB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:26:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzqyw-0004Md-9y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:26:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S675CK1630597
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uvh3Kq/QLOR3H26opu5If/ZhCUKQPf4Q3+kb+LE3/fY=; b=FT9elGI0mSIAs4S3
 ey1pA0Ap0h6Er9m3g8PdWOtW8J0TesDXjIs8ef4GYD3P7C7LfhR9Zp1QzgjHfIUa
 8ueVy2JIzPIi9i9O1vzTfkL5itpYOTrshfkQ4RdalFJiJ+nakNkt4gaul39aBe8l
 F+1esiMoHu0MjWCO+yz5V7u+XtFe9MZorXW/4AOojhGU56x7iCawvBSENKJvhw6t
 PpVJgzJh/WaHepgxMmIK9xWlLI8tgI4a0wSsS07pwVFQuv+11GEURBJ4fXraSJO+
 HWYA7jAe6OIxxGFmMzOi/A8fJopUIY2uSyMBqjgZhImc2vjtZ15P8QmoB6UNCqC6
 g0JLuQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjjrkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:26:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d30035dso4018601cf.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787901990; x=1788506790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uvh3Kq/QLOR3H26opu5If/ZhCUKQPf4Q3+kb+LE3/fY=;
 b=OLMhuSf734+BXmfpUBoeiF3ouSa9iz/MjPRjtIa26mmYTIX00vfsMGb01NDyOTDn0Z
 08BZnC+wNap2lECO0FcTdjnq1DFKU3pvfSLKaa/ohEoVkls6aSYgXBx16GyNzX30gfGj
 plG2FQzgRrwoQZV+slCj+OuHKO8KMzRpvRW4/CY6Mz3ImZnmTeKJ/zq8cdiQKSWEWo/9
 vW8ylz+sS2XCvetOCMrwCkh4JWnWDyD/l4RKuUyaCfzhSZb7u5mErv1yq/8DQ0niBllv
 WcdQroOY2c4DKgsEjYs0+bCq4v17hneAbx6NNfpemefThG1iaT68I8FWWgS28NulzSqR
 Mdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901990; x=1788506790;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uvh3Kq/QLOR3H26opu5If/ZhCUKQPf4Q3+kb+LE3/fY=;
 b=Bxv/M6XvlEOKcpcAyiKmIQ/AUn5jnehNP5knokiWIUSAna3vnWSSej0GtnLBp4SXD7
 gReOX1fn29andAhHWZ22hZXt6cov6qntEAztrynqWENBYVup+8H7ey1qsxv8sGd8Na3G
 KKGrqE0fCOIqhxnuNhK2gzMB8qnOKSx6AYd7O80QGjf/CU2SrmrGEfAZU1Ll4yFtrbub
 nGdlnaA7SDFufx0MpDXRhyTENzVSNGql6AlPYfPLyVPV6ximORUX4bsVTceSn5ALMJ1E
 kgK6xkNz4q+Sq2+RLkprpwx8fcrjobN4ACifmhx+TYRMpa9iC8DmdjoOl51PPVyX4FyO
 zDYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqTSHDBZVKYLn99SJvaD/ImI+AhWJ5mG2/4FId4cB72er0ugSikoHAvmO16gA6AVQldQf6xLBjwISI@nongnu.org
X-Gm-Message-State: AFuF++l23aTY0zgvuidDx7KhXM52e7XsS5YAiqipzi/1IMo3yWZhabp3
 tc74metTeERn0iQwzCkiXHp9ACL7mlORw8C7ax0dQDN+N40UnWYeDNqM3FlRqGx9QPD0Zi2li65
 Kt8ippzSvBb9TZegoY5oWlFTu/AeAyfb+gj8JXVGr1Vj2whyrR3bARLzrYw==
X-Gm-Gg: AR+sD12pOZLJOh/3M3BZC6Q0W7nnp6vlQ3MbAoqywF2lNW1ipiN1WRN5r02gsWxD1cX
 4NJV4Uq5Jz1eFtva1HOJpIdQy/Wr5ahxuX6oer285W+6m8bZU1s2IORsolYOBH0GViTNnMlaVxz
 bR0o/26pxBTV1vvNpHaW+xnAe7YgpnahoPII5vEBIndr/aeuncbm38KGUdXlTvmYnVuXRFa3i6o
 crxmDprYjQnwFGRJUHAElrHfElxlv7ZtpT5yhHF/RUDQqGHoiLMDGmqHwis2JYV+rxi4v8CcLPX
 jjkmQps/x2DxPLnsi/2VYeWDJEztNHAsedS256moFycHy4FA0mlDDz2omdU5eDakE6722We6uHy
 Frhbu9JgOVx8aO9GZrW6Qiue6Qk/HYCvJyg==
X-Received: by 2002:a05:622a:14e:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52fb940f94emr48126881cf.9.1787901988759; 
 Fri, 28 Aug 2026 00:26:28 -0700 (PDT)
X-Received: by 2002:a05:622a:14e:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52fb940f94emr48126441cf.9.1787901988221; 
 Fri, 28 Aug 2026 00:26:28 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d1dsm26424945e9.13.2026.08.28.00.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 00:26:27 -0700 (PDT)
Message-ID: <f4426d7a-0ba0-4944-9712-c9e6dd844a91@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 09:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 105/105] MAINTAINERS: add maintainer for tcg/tests
 meson infrastructure
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-106-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260827221506.91574-106-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KsR4cxcoiDOyzAw6a7NGRqiBIM2i3TBJ
X-Proofpoint-ORIG-GUID: KsR4cxcoiDOyzAw6a7NGRqiBIM2i3TBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA2MiBTYWx0ZWRfX+Eex29/NLFYZ
 B+XRiBRQdabOSDt4IfznKrx49FTarlvEXWU12l4p4Sgw6tOrFPb67dWDx4qvg0DiHT7f2d18PGN
 8C+CFs3nqLpZCGzKn0Im+B3rSQfarxe+TDB9Snlp0+vfxdwv8JRYUbM6yOsvXsvu6E4UPA8OcwS
 f6WVZZBki4erGi5JSxk0hHnky5mOFGvWx315t7a8DkiXXNb9RSP40X1Zu/aHu7VvxEZplfieUR+
 ZE3zL3GZMBCaA8BCQ1phniYtv9tX8q09Uz/Ibvvg3Fi05fbfwdO3eAE2n6Oql6Bqy7sqU4w6Dou
 WVYyYF9VZN8lSVmPJfsXoC5KAKLZaeM7iVSNA8yhZUJiOThhpFHdFC7KGMfpC01GpKIjA8Q71LG
 TiFLpBpDfm9lDY4DPSxkZQC+meGl0hfvyENVdZymYJXfRja3/l+Pk5iIpni6RuxO296KnibpT+T
 u8r23FyKrEwmXnqVykw==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a913827 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA2MiBTYWx0ZWRfX5tL85EnWKdB9
 x3kwNilEnm+W6Csza9dpCDl2CyoGazRk72iJCOvyxWFjuRRBeYR4M1+WmzJII49eeQQqm74GK/z
 UkVzqjZkveCVECaCGcDyj4AORtQKjAQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280062
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

On 28/8/26 00:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

