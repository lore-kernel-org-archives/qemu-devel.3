Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E954C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQ1A-0001m5-L5; Tue, 18 Aug 2026 16:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwQ0x-0001lY-K8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:02:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwQ0v-0006e7-81
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:02:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJZZjb3304215
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Phj7GTs5fv6R9k8bv3UPCw6oqcoCW0rNFzH14n5Q+lA=; b=Fpbh4KR80l4/IzJQ
 f6KFmFhdcH0kL6HrlCNy4k005V3t1XQ5amB32WxqC+7CFypC31B+xWYB8oPSac0y
 NCqbEa4jwpObqn5MXnyY1YwHt1eYjXrYj6MW1WcUB1T1u4hF97bKdPYwtUYSOy7y
 OZ8FVdxifBsSxlALUH+1jhYTdoLkJOI5jz/d2pV+2ChlsTxSm8j1CYQudBDyD1ZA
 munl0Nf1pvmmuV3qCeNKfG2dJ/GXv964Qij8F1LPx7A/hrbL3rmvsLA6vTSPAYCL
 PPpcQUcyDbZ1YbXG01/9kH39b0/AS1QllAA+NCpCDq++DMHiFB8XzwwMecJP12hB
 S2nI8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv80d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:02:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso339984a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787083327; x=1787688127; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Phj7GTs5fv6R9k8bv3UPCw6oqcoCW0rNFzH14n5Q+lA=;
 b=dCdRYAMvuuFEXCtg2X72AHotKNLyLM0QOjNiYPhLyaE+Zz7TQdFYwlfc8lJdc1ST3f
 LmIY8dUGYYjkBQy9eLXs/nv7RyP5UOVdum1hou4hm4H6pkzTVLfOGu5dTn0p0CK2K13W
 bcuUHPhOplOJ8RYvwjg+662m3k6G0mBQgG4Om0UuYSAIKk9OvmRP9hYZ28KYCjRM7kxw
 9surZPxv3/Qpp4FGkEjllpNFOPMBqz9Ig3XbrG4Q/gwJBpp1815X/31QcQya3MtHXGhp
 sKU7ACQj7My21i+Z0ctD7j9pPZ45es+C+IpmlwAqK3A4AbuS93YCKsKpBh6cYBxbHBX1
 YMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787083327; x=1787688127;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Phj7GTs5fv6R9k8bv3UPCw6oqcoCW0rNFzH14n5Q+lA=;
 b=JzxXKf4QkmxhKTK/G531g9hwFU+ILPWQtQr3Kaj5+b4uFjekMuB1c/XrW5+ZRubIeI
 OCbHoN6kw/s0JaGX12tZG8fI5Ap5jyUjL623GKqtCwzHJPW4jtfJ3Svlq2qc7Pwo4ku+
 VAMRiVjDmrXl4en1HrGA+WUEMLSaaFv6QxEae970N5/mOa9hl3T13oL257nOxRGnBLCA
 aBRHgxMA50QKcoB2r//hAgf9y/6qHyGR5fAP7m1oiHToZeQcMLIyLz1yc3mG8INOW1g+
 pFhg50f+kzR3wv+qrtLxMfMTb+v1gSRLMn49Qqlf6yg0vowM695btchokyCluaU99Bws
 L3LQ==
X-Gm-Message-State: AOJu0YwSU6w5JmXD7uAPrWR8yhYUw1mQeFjWBJ9XL7TRN2vhbxQtf8od
 g0Xdqk7TeggdeZdjp2HTb/ecPccxcmwg8/wO4rN6s5qHVnEX+zE2HMU4Duz7gtOS/7N1WKnUVsy
 9VA0LqVay1Jnhetd8PNTjMHUD+zRl9cdIkBXv38QsjCbyv6YqUhy8CBnhMOmzNhbrFw==
X-Gm-Gg: AR+sD13AcH6nT7+UCY2MRztJMYiDAHKum4cgs99T57eM9a72FlTfCFN6EXMhDX2bPdT
 kiWm4p3dmCVT6AtkbVF5wnHE7ZOUsyAsCuKUdkALyxyjxipYFSVAiwSTL7ygdn2ZOWR3t4MMy/X
 7we6hek5LK2FMLZ8cHp4B4NYMdzHujDXX2Q07j1Wusd6ekKsGtcB/vAm9Kxe4ETDmSdW5ANko2a
 GqvMurF6QeaRQKbrpTPrcZlg1fBnyfcnOT+whXbppLEMmISprYQnZ0sdG6ZKodjAgXopti3Wr2z
 G7TKWyILUgT412nCR75tHcAObuhpG813z6jPGx1K5iJ3roTTpi7SF/9aZEMl75Ko/qYkWOD6RzY
 8DdPVF81m0RQyXbBlV5bWMYhrR/IAD3Nb/WA1m24FeqeuJPKgNx8KirqArncDc/pFimMk
X-Received: by 2002:a17:90b:1f8d:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3957b35832emr322091a91.10.1787083327297; 
 Tue, 18 Aug 2026 13:02:07 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8d:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3957b35832emr321938a91.10.1787083326726; 
 Tue, 18 Aug 2026 13:02:06 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32678dd22f7sm32059422eec.1.2026.08.18.13.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 13:02:06 -0700 (PDT)
Message-ID: <a84c3b48-3591-454a-90f6-922696a20a8e@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:02:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 000/104] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfX5aXX0WA6PQXY
 zdU9C+VfJulXuYDS6ejlh7Od2MagV1Z+gctacBNvpSLkgJiXIfGtApv7WSf1HCP831aNiRAsb2v
 +qhQLDkKFD7Dkq7alvwBeGjMRYYuAxPNOjF3bgPa1PNLZyJNlyALj2cTtCloNyl4u8ITEM6/XkG
 72kn+/lnukoo8vQMqj+ZXg9S7R5fiaD+HAood7ibVYYASei2FpuJQCZ7hNjwGGcLQmPkJbCmJ2g
 dr6aA/L/+5FooZp81qbd2wA/L9xvx4E5HwA9NmqMtIlzB2lIXCJ42k5Q3/xV+S5RKofATbCh5Dk
 y0gOgjbHKDF/yPhiingYPUafGrUHRGJ7xH7DgKNkRv38BmRqw5GvZ661O+JPpSUBa0aoKOdsFLN
 2x0FTrEKEddiLEH70ixF86etj0v+vMHhmpC9ykLWQMgDTtHXfp3QYpwz6dLj/lXF1bwYBct3Why
 D1EnhkXmMcnJD3wpZtg==
X-Proofpoint-GUID: Z7Pwm-qbQoJyCkDe0dLwid8AXTASMqZm
X-Proofpoint-ORIG-GUID: Z7Pwm-qbQoJyCkDe0dLwid8AXTASMqZm
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84ba46 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=BSwQ0xwLzVEdrp9KYH4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfXyrsuYbJofL/R
 GO+S10SbquQ+xmV/SnFlid5UtmekbPCtwxj0QLYTdYyhWFnpCOgk0bkfM/2r+v+W34z/0Zr2uSF
 JfQGNxsCLI1rNHdqgw9foTt80DGbaMY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180147
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

Commits missing reviews:

- 4
- 31
- 33-38
- 101-102
- Most of target patches

Regards,
Pierrick

