Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553EFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJni-0001MP-62; Fri, 10 Jul 2026 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJnh-0001M7-0b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:34:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJnf-0002pN-LJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:34:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Uce1752832
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+KFtiJ5kCGArun/cO1WHVxP/HlBuE4WN0ev5ZB275A=; b=EnEUUUFqjKgVnKV/
 qz4dTHHVfR21YQ3V8SRXfmh37oLvgmlveP4ZgDda/T8HZ9RLmNBUW6eX1bNw4s8x
 z/0K74mCXGSlP7Hnh+SKK3sCLuVHxatpAhULf3wUOJFpAOhORTilnbGsHWbRGztb
 22AmyxZ6MhzEvf3ELbJWVNKoGV6gKKsfOHX8AbOZMTCaMCkuGjLPOKF5tSJVcwQP
 vCxRKUTclcOAcHZ3vMOxZk065AI83E4fLtFQIWoEbGyuz7rJeg4sFWQAuuaniSby
 50ll0BupThKOkyVob9xdmwTy/4AP6IMGfPly0SnH60qmiBtZGPNbZPsyqDqUkFZc
 Y9lkKQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9mrm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:34:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8fdace20927so14844986d6.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722866; x=1784327666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4+KFtiJ5kCGArun/cO1WHVxP/HlBuE4WN0ev5ZB275A=;
 b=K1be8TxCIW6RCr6sQesdeJmgyxq7P++XFbHtLWTQ2wLIqow3pqHgbZraSjrR1RAwtg
 nXAPzn54NrP65a0yTbS4awASLpL0FpwB04JxpkVnSSmSeTXRBtgW3gmiW9FIiXyH/ymw
 S1SkT1Yv11w2VB7Oi6d2ngVrWqhxd5VSYLTgb6R4CeJdK46u9EKKQB1PEoHaUi/2uLCC
 qrzy/SvjbaRCt95o+EFXszTRgawuwaEygn9O5qQc3uvENgWzfvOdqvXjRHKmxrlgyTxB
 VeCpC9d4inMEJYAiME/xIlUvTGuE3iwNx9iU2iKGWbZnjCBd4/x33sqyZaNJBKFkiHKB
 fe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722866; x=1784327666;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4+KFtiJ5kCGArun/cO1WHVxP/HlBuE4WN0ev5ZB275A=;
 b=cfEA4GeN1QLGg2CSM0z1PKLfooX6lpI4njatpVipsieasAPaMGIBoFekHjaMNaRr4n
 tnhyjGwj0cBpuDQaGoowNs2wpWcOxFi7K9RJ213TQKeZj4puKs4gcGDPoZCwX2KzooMD
 HBN5BiWTH48/V2oYq0dV4R6oFOjTIdSe2uivG5b5FkJLlavDx6hNr58jZZdrixyiYgXq
 YnbrKNc6aSl5+gIqS+URq8ZZNQpF00ixNDShq4nS7ro78yqsXGkI1i54AdYMQC5mMXUY
 +WfMUNCMJ3QwbLPwVxUpWka9wDME2uGpf9xCpB86oxmSIRm040IGwQ+AlBGhed8UOz0i
 r1lQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmKy1Opp8YhVvNmx6OZO0oZZ8ntEbUNphNeGTFpo2jGimKkThmqtPdW9uzza6kubggAcgSM2D8GYvq@nongnu.org
X-Gm-Message-State: AOJu0YxzS9uHu8PpckQpx5aQWNax9ZtvJ7EJ+Oz3vmyQX/dFjFUJ9M9x
 5rdWUwwxbHW00n6tmxU4Q6oM3TBXB7O7TOQFS/CkHkIZPUsMBwdFng+30BzMY0z6UFXDeeN4nfe
 ydV+SU4hoTihrmLQLQcmgYIbcEUQJ+Ofu8MpQU67ArvrsFrosyU3jbZUYBA==
X-Gm-Gg: AfdE7cnxVVID4ie4OTj4WvjP0Sk0lZ60CKk0hpJFHUVv4hUxn+Jj97XAARcND+H9oQr
 yMe23SbxsHWaJXhs+7I0JV4lBq05kuE8icteRCpoPxF/PgVCYl4dKuxJmHNuoaE9RJeYuhu6qIs
 6auam57rpcNjhFLiNaQcQZNgFgtHiB0c71ck0W1iR/Qed87hXudqWMfll1V+u8FAW1YB3wcVgGJ
 vKkMYFnbPlihMoP1shkOVc+fpbxg9Vs2RjVh7qyuP/8iRQtTrTSrqFTusZ3BknAacT+leG4drGO
 VBvhL24bsi3uIeY+MJ/iWcBNP7hgr7cEulhaWtVRYuaLv6VDNhpf3FIYORJsm7uH56x/l9rg7fF
 Coq21x/KpOp8UVzQ35lvGRngezQRDwuQS8fcZEtttspF4veh1cYdhB+IpexEgZw==
X-Received: by 2002:ac8:58c7:0:b0:51c:1c00:e46 with SMTP id
 d75a77b69052e-51cbf0df168mr9677371cf.25.1783722865610; 
 Fri, 10 Jul 2026 15:34:25 -0700 (PDT)
X-Received: by 2002:ac8:58c7:0:b0:51c:1c00:e46 with SMTP id
 d75a77b69052e-51cbf0df168mr9677131cf.25.1783722865166; 
 Fri, 10 Jul 2026 15:34:25 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d5055sm168182305e9.5.2026.07.10.15.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:34:23 -0700 (PDT)
Message-ID: <f5ffe96a-7cb6-4ce1-96f1-8357207d0bae@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 86/98] tests/tcg/sh4: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-87-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-87-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX5m1xqT6Kwnrq
 4mlXAcwpVUALlcjz12GeSiFucfvgGbyTakrJz61SfXbNe/MGHf2D17+WYZ1jwfIjjLMzHT0MTgG
 KUBjx0cYOnXqhYg+Ob/A2vCVzCMstAW3NlGAIwwIIIUBitz337J9uWoz5U9hauk3RgKTRkT0OgU
 U8KJsgw41XnKSYRCjlW+KCKkoA+/S3FmafMAtK1z+k99AsGX8WW1PcWczKPyC76VqbIua8ipBH8
 2+Tus9KZNwgtZcClV1Yxh7K0EvnIxPuhCc8xqO+TAlHtkIximJmdW+dL1dU0WfF595X24H6ETwV
 NWCfmXDP4K5/jtDo+np7HjAt3e+stDZ9kzZl+hT3/Pjf9lEiGkTN8i63uUeoVdAVFIDM4NUMJEz
 yV2VJvZ/1D2NQesueNEBvpl53sD2xaLjO/KfK8giy39WuLroUcL+TteE4DrFZOxCdWeMLRggHTf
 GgK5kppVM2i1D3qA7VA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX2MNf9fdE63mI
 ET0RVOIa9I2/vU+7CqKU6QUQaLd3ZDAQTFrPnAdaRP9Rvwv4DhMFBMIMkwkC1ejGQ7ZIPh6AgZ/
 +HKpx0/G/IP0dXRoYDIB/v3gp50r83E=
X-Proofpoint-ORIG-GUID: VkrVLa7joM5RU94VrzZyIVOjppHzY1K-
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a517372 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: VkrVLa7joM5RU94VrzZyIVOjppHzY1K-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100226
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

On 10/7/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build         |  1 +
>   tests/tcg/sh4/Makefile.target | 18 ------------------
>   tests/tcg/sh4/meson.build     | 25 +++++++++++++++++++++++++
>   3 files changed, 26 insertions(+), 18 deletions(-)
>   delete mode 100644 tests/tcg/sh4/Makefile.target
>   create mode 100644 tests/tcg/sh4/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

