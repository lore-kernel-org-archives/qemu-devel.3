Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71712C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6shS-000547-Ci; Wed, 16 Sep 2026 12:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6shP-00053b-QG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:41:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6shO-00088c-83
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:41:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeRIi2432184
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6qPigUD9fIsyQC74evRL8+c2D6v/j8LAmrNKWPC7+Ac=; b=NjKCLxAzW4Z2us9G
 lAts3Q/uv2nHuWXsvSnQi96apX2fPrm18pi/unNJ8cs8e1WzunRA/ARCamsufbiv
 ux7Q7RPx/ApuQ6qM+6YrKTDpt5n2srO4b7ve/w83+cwJuMpKWUwEizSe3cjjrncJ
 /79QeS+gXirSSpEr7HHUv1MPgMrjUyBkERe8ptxhh5dh3n18F/hfIxc23jDG31wG
 5lzMzhtnj4pcYoTkd3Xiwooo0ej+DAxwPaRHbF82DfuDV+TPijwbsv3aF8LXqsZC
 +cetyA9PJe7LUL10W/HlAxKgjV7UAiEUoXEytzQI3A0OaaXlq2w80g4S+d4hIZdd
 6y0gMQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqthnsb86-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:41:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so4811537a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789576887; x=1790181687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6qPigUD9fIsyQC74evRL8+c2D6v/j8LAmrNKWPC7+Ac=;
 b=ha8HQzV+czh1d6hGTyWoTWTP4ixNaUk1Wlq6bgjt3nGz322lyrwtI+a3+98NMs1e0Y
 ETSnfLFskSqq4By7fA1Uz1vix7OnmcuZWOt2Ba8SuE5lZXjNoqY8xIh3ELJEesKZXX/e
 vUddYkkiA9Gb4X+e+L4EeMtvefrH4fInf4chY9Yya3HyT8myifITvjyaspmLKNT962Cu
 XO/WNWWKX9whHMFTX47GsG/Pa6ubUt+oU21KxxZIHxfBsMgOJ+12uDchGpsy0kMb5XQi
 DfKmDtRKKC0Bkt2x44rirkiVIHV/W1L6bYUi2DOI/aOnky9XG8KPOxf7v4RFofY289EV
 1P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576887; x=1790181687;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6qPigUD9fIsyQC74evRL8+c2D6v/j8LAmrNKWPC7+Ac=;
 b=EwINpy6vgXj0RwJpVQtuVckhMqlNZxN53gPfEKF+yMqdkQkM5aLr63yJ8KaaD9dUnG
 ogtvAK8mpFzZ7aPJsX/Nk+8U+4SoDpSoud8E0pOFY61FZKxhqAfgBr0twjZBfGdr3IG6
 y7uh6L8pj17mbwUeUgfCGr442QZtfk5bWsHRSO1RmTfRAwhE6a0iwmxKO2v+snV6KSAh
 l+Rwj+DlolOL+XNZx9OxLID1atZTTrSTdDthY8VchcwYKokjBsDUCvirseCHsploSfnU
 UdjpHWcCvvYFyrmEK4khR9Ksbd0mP2MkObLMRjuxEzLBp3TcGcdlx4HuOy3WK4VbwgHK
 bedA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxLfO3RF3U5jUbCGdA74G+K/xJiBYrxGsfGN1HvbQL4njItG3HFK3BmnCogqRmDv/bSXYCCiws3wOc@nongnu.org
X-Gm-Message-State: AFuF++m+Anf7cqTIIP2wd14TWIf8XyhMvlQHpjc4NOAGVaPt9CddqNY9
 FgCGsIK79V1003PjrMAN2vFTTTPqUUp52/LYlexuYHdXufxXDuQmq068mpnM2F4TgzMUjrCsux6
 SQhaIv8ckMoWW0K2Uh1ne3qat8aZebQW/Gnv/83njNXPgDaYMxvCkE/sUep5ar5JI4g==
X-Gm-Gg: AYBFou2lNNju85/QtBiw41RyvADhpwQgTgmhAK68iXtLtpGTDFfqzF+g64DT6FtnPHN
 ZaVrTczG3+NzMu8NEuXYTxHCeG20dqpsOmpoi9itUKZZol+83DmEP0m2KF7QhFpkomDp2lJ7ega
 J9bZ+4u1LA+2lh+FkAXumvbWQijoM4TY4cbUHEXK4+WRYeh10rywc5nWFgHf2fA/TkxrEOpCBSV
 7b+9WSL7zYbImIDum/CFK33RdXcT4/QC4f4LN4H10E4BOj+xr5cK2DT8vA0osXOXl4cX1QGGvIB
 LkXxJkxy3280z8KHMwX4BcD6W5oR4R6/MkOVJOIjLeYWtaVAkyy/QM3k3EK2IxosMWY2bKkbkoP
 C4lPv6HxOudZusBtGJfdcJCFM0QVIxL1eiNhzN+k9bZyX1JFFMl8lf/t7n2Y0j+9k0oKV
X-Received: by 2002:a05:6a20:94ca:b0:3d3:b00b:26e8 with SMTP id
 adf61e73a8af0-3dd5f8123f7mr8115301637.28.1789576887183; 
 Wed, 16 Sep 2026 09:41:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:94ca:b0:3d3:b00b:26e8 with SMTP id
 adf61e73a8af0-3dd5f8123f7mr8115243637.28.1789576886759; 
 Wed, 16 Sep 2026 09:41:26 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm9327051eec.16.2026.09.16.09.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:41:26 -0700 (PDT)
Message-ID: <85491ee1-f04f-4716-8e0d-3bb6580392e9@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:41:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/19] tests/docker: add container registry to
 configure and use
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-11-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -qiQoU8XdJLboU6zeTbPJT2da6YSuEMJ
X-Authority-Analysis: v=2.4 cv=IsKL47/g c=1 sm=1 tr=0 ts=6aaac6b8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=AVDwjEnD-0tbelgwmW0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyOCBTYWx0ZWRfX+bI03Ez4tPk4
 RMvIvgIGinHBklw+ixbAY00lqANMtzGtY9TmGpNZYdMA6hKZzTLsPr/eJRP+y74HwuN2uhpj/Nm
 T7uR7Fl5RsviLn5JTabUPE5qeTpJkrH2G2hx4CQtaXT6qSVygmkuovMfdaB8MBLxIayIkBHCXXr
 Zoqe7IRkcV/OA35cz8sGriVq9xwbOuKykiddu4GcOhVg53z1noyoxTIzi4kmSmEw7p4pQikvljm
 ZTz+yytI84ueYIYYfcBrIfsSG7cNEQb/vxx0XFCdn/RiNLvDdL+4yDzum3qDyqDLCOa4l8RBXcP
 OqUd5ZwTkmXlc6LtKZAQOu13ueMS3La3b+9ykMjDFrXfbDQSaBJkWpKoH6vaHRaF+RxKWT+Ok86
 9lbA01hCK8wgyOlqlT0Kw0A8eWnzSL1J9RKmQGnMIyrYyH/GfpYLMMsGW90H+e5BrcwZW97u3GM
 WLoOzZgo6wWiEuLSIkA==
X-Proofpoint-GUID: -qiQoU8XdJLboU6zeTbPJT2da6YSuEMJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyOCBTYWx0ZWRfXxw2K/z4OPLPb
 7Swm5byg3VeJen2Xu4qKniTZvX5/epEJmi++uJkTZ8or3fh8yQhXc+BZh+/QZmnlrqk2Bt+h1Pc
 aVOmNboDrGab2GZkMHFGssUHE4/2rTI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160228
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

On 9/16/2026 8:30 AM, Alex Bennée wrote:
> Previously we had the default baked into Makefile.include but as the
> meson container logic will also benefit from it we update the configure
> machinery.
> 
> For now we allow direct make invocations to override but for the
> normal case it is in one place now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - fixed conflicts from the revert.
> v3
>   - regen meson-buildoptions.sh
> v4
>   - merge conflicts
> ---
>  configure                     | 8 ++++++++
>  scripts/meson-buildoptions.sh | 3 +++
>  tests/docker/Makefile.include | 4 +---
>  tests/tcg/meson.build         | 6 ++++++
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

