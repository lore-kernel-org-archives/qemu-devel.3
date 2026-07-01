Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41537C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weo7I-0003Yz-BC; Wed, 01 Jul 2026 02:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weo72-0003Wl-5Y
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:07:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weo70-0003O5-3d
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:07:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lZJS154282
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 03lbUfOFapRoQ+YjVsqrc99sXymsQRv34vNlqajj9Qc=; b=AbNepSImJA41tR2q
 xJ9mH0EGKnP6uW+ft1EevosFQiKFcAiLuOROdRZ5YEtyem71I03J5V6NWdyTZcVG
 O6ZU6cUnmNbbFv+eg7gHo+NshNR7y9orUP357X05I0lgFJSKaTM+U1dJEUVkoN/8
 Lekgl77xokRZ4ITcoI+pTj2DqzsFRQFj8UhgqUJFrNa4FoSj83A8W5pLtt3oMNPC
 6YA+7J1v1x+N3IwO16tQsZ/uo3dOelwlEhhoe53RIID5zx2uAg/dhsN20K1y/rcB
 ze371mJdZvsO/0e0VvbDUM7OjgNoS9aKTHMRVBrsGMIUtYq5mB7socNUUI6Cb2A4
 JZ+AXw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j912nrx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:07:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e55f0613cso30313885a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782886071; x=1783490871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=03lbUfOFapRoQ+YjVsqrc99sXymsQRv34vNlqajj9Qc=;
 b=MRr+KQsXUQDP0KZWmaKsm6uSyLjhO+gUYXb4lgpQDkN2XSFAY+WBHMwdkSv3hG99vl
 taytvwKlQfsxSIa+34jU0iRozY6COqLuIjhteoq3IVv79MQ5csn6d+iieo4KdKCtzPOK
 S8pgPnzCTSMxB6coy3Y/eRljD0/EK7FgbsiT3hWgqoi7p5NhPK7SyZnCYpyCv2bQViLF
 mWDOHwIOi+1NmjhICG4viN0p39suq2SrsWTLfmpUv8uZ5wFmvt/A7ip67F0P7dJmyH7q
 +3aGr8D9K1o8RAF4TWvPqONfkKFqUURdFg4JUqBk/Xah8RdP4fnd8r7lpsga2dORQESH
 nLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782886071; x=1783490871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03lbUfOFapRoQ+YjVsqrc99sXymsQRv34vNlqajj9Qc=;
 b=seZE+dbeWLpnLFmYwUClKuV/qm5+ezv1OZdqQjtrF4DwEIGQNuKPQmreNBWBvnvdLA
 aCWPZsaE/bAxcawWCVFIzmtRp+3n8S6IhF4u7WbOCruustzPU3vRjXZ59pQAZRJTnwO9
 xGoCWF0ZWytnJ9aHhiQCr5JsGShtgW2krn24I/qby0Z5HyYIz/LNO7a4H0WjOdCEIZE2
 NNU4cLP8DQRTo8kBCdhTg5jYjqF/PAI7Wx6HX7diG3BwXe1ZB8x5Cbxe/4U3Gn37vUYw
 hu50AFdw61MRFsfyUtbB4M2EitbjqBTvHg3oiNgorCZyiU+Iy8dyhj2MoQ5/5Ah/wjCA
 fMvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XkWbR/Rd6BO0U9zhYXuV15sCg2UsL+SX76KoMskLckqw98C8P9gKP60OX5TqF48mwgLwcOos2E6DR@nongnu.org
X-Gm-Message-State: AOJu0YzX4iEHSuonmyvPbnq4sBqR+iJzhF4D5+sDvq1onyUAxXfOChHe
 Xpipx+jxL5siwNH+YFITu08T87JFRP8JF92V8FMJZdOf7YolhNvwZs3ffs9pGfaPaWB0FvkJFYH
 0Zk8Ee9KzDd1cPFvicYhG0zIBWnLcNRoZNzhgxJdFy0Xu7LI3Y4VNeGj2Ww==
X-Gm-Gg: AfdE7cnp8Z03DFmXRsnZ/esWwlSEFkv2ScLT4/ZdMOGIqLea2aD6K+GtHlm9djvz7Wx
 AMKNtygdlasqQc11AptBAjN7wznXdnOlQGDE58wM9DN2glYb/Db5mJ4zNpMsWK5c+Dv0xSShFLM
 OVg6VASF2TTt/U3+AkprMMMaZJBPYJ4XMWTjyqzq+UAQoK4nD5t7mjoLEmpa+2xpbFzOcprH+W/
 q69PgZVwHDNjtiUR8vEtS1rCVa5ko53wCF0BIa1xl8d1Zllk6lJwDJcAe2SeWoXRhb2utoIYlTT
 pV9uaKI3LSGZxF73o87g97InAtn1+oYXJwmZY2rri5DpyL66IMbGgGA7wGWwv56QRcxR1j5o6qh
 OBF70OVXzO0DF3bVO4kH2Aj2Ip5SoZd6NYzuwy45vlpIsgd5maCslmtK77kCV/Q==
X-Received: by 2002:a05:620a:19a2:b0:92e:64af:3e59 with SMTP id
 af79cd13be357-92e78530f8amr39810085a.67.1782886070835; 
 Tue, 30 Jun 2026 23:07:50 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:92e:64af:3e59 with SMTP id
 af79cd13be357-92e78530f8amr39807985a.67.1782886070320; 
 Tue, 30 Jun 2026 23:07:50 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636d2cfsm15673942f8f.17.2026.06.30.23.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:07:49 -0700 (PDT)
Message-ID: <fe48530f-244f-4f12-b04d-f6c3c5022e3b@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] cpu: Move cpu_breakpoint_test out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701030443.1382447-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SLKlpFm2MNztPJY9D71DRDIj4oxljtLk
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a44aeb8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SLKlpFm2MNztPJY9D71DRDIj4oxljtLk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2MSBTYWx0ZWRfX4Qua/HsTu6pD
 z/G9uvCwBs0HoYME6Vh/6EqjWcwyKwdpZlo9wjX0jrM+KstWTQbAFXKpV6bGJs3/57Ky8RoF0Ba
 QOVR9M1Vq69Mom1TtbEl9RsoMZLqdYVIKytpa90rGJMqzVfb7G7W4yPMjnsGXBAeo+NS6dd0GL4
 RI+VywBkP9Ba2NYL+V8jZsFG3NQVMXLFXAJtr5mSIb4q/gDQ7ETl8H1tfwUnJmmozJXVBSmqzb/
 sMed4hcgnGdkyuSA6MjeHSKoTglJ9EI4GELee8KKuKOTnRfIFf8Ng3hYW+Zj3tb1pIFM5OnidG1
 9LPnZKeGqU1nR1KXAt1Yp3pgY23MNbv+IYJqO9Gximjy2o959MbmfODiFy5mcgJh+KyQ4EAE7Zt
 iuhgOSQHZSeOpgFYAUlE823KJcCuBFKhZEWp+e/3JXFab5c7ezDjVT8NfcjFkaTn8h1UVPk4rBu
 wqF4mgJRQS3FT57WpYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2MSBTYWx0ZWRfX0qACShkq1eDy
 5n+P482+/iZswoKtoujvdrKVeduh/KW0vRw4Mdr8AtGG6e/Jc2g4ohdmNvlkLEfVevoXgCe7VzJ
 Ld9HI+NkaeDDv7y2HWjcJ5CHuEjCCyQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010061
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 1/7/26 05:04, Richard Henderson wrote:
> Move the function to cpu-common.c, with the other
> breakpoint functions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 16 +---------------
>   cpu-common.c          | 15 +++++++++++++++
>   2 files changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

