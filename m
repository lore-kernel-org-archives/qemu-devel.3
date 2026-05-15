Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C94CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw8U-0005dQ-Do; Fri, 15 May 2026 13:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw7v-0005MA-KW
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:15:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw7s-0005fn-1O
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:15:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBWFjG3513372
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AWQa9PYZcA22WBJsRTPM8//wP/1FG2LBXPYiOz0NCj0=; b=nJwM5pqZlR93SMRM
 oZlW7H4GZIWg0drJ36L7vkrTj165GowUetLfRYvBgCWiBIR+pSrW+GKOmJZYZLY+
 HceoDluk/lrpnOKZtAAbLHh5aCiOsBnPtHT/Ws+YxLnGun5t9dLrdBtDBMLUvTck
 0YjqSVQTyZ0Qar6Fhc84BTBIlqXXE/sjfJeS36xPw00GAYHj1dBmjfUuy01nwq6g
 aqp7t1P7Stk76MGXr03Yay4nQFx9tNtg4kmt3S9TwBEyFWZ2basl5QGqD2e2NQqa
 d2vjOgDB9H8TfTakN89LupDDJLAsOu6RwcC/Mac+Vii9MV8gH65ZzLovGHORvWGR
 LXvlcg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vc6p9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:15:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee34588671so64398eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865301; x=1779470101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWQa9PYZcA22WBJsRTPM8//wP/1FG2LBXPYiOz0NCj0=;
 b=G8BW1WSQ2XwYeNuUkWCczu0k6r8XB36wTdcLV+U+RCJ/IYAIjXs209dFqURA8Be8q3
 ffAcFX1CGx7WU+BYWXSTbDUtlDeU8NyITc3HuL9JtG15igOas/omi9eYxR71lexJbUJi
 MiuXsL8l6u7U4vVaRooopkuK7asW4JzdI+DEduqn1rywlitvKhc27PhNRdrtJ/QH5SIc
 4/1RQ0u/eV5Ij5en0ZBU/SQeAvv4zhCvY68H37A5uXVu7GpnhyeoshfLUdzcsfGT4wO9
 BnLwPgVs5RMnSGL2rTkkCQZ4l+5+PHadRA8h3FaLJ5BJ+IkNjT2NGv38XbgyKMIFavmM
 W3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865301; x=1779470101;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AWQa9PYZcA22WBJsRTPM8//wP/1FG2LBXPYiOz0NCj0=;
 b=Y+igsWGLklD2sLHAMgeRZNSBcqClMNLldDjwTayuW09c9/xqARaO0tbwuix5q3IRmm
 ydInuq1Di1nMq2bHP3BZzRxCQTXlvs3SqD++RGasnfo/zo9KI/QffD+avgF4LW5osl0e
 K1U6Cnu69qhoskaZeSth01qql5QlvXSnS1cV7zXob/hl/NqL0DcEzBfEuX1vf1eE71Sn
 mRIE4pZYOvPmgMFFFlwNkhsdt1LxD8Zfe1VUK3k7q822IQRVfUyfHLv2blT0UuMHLPfs
 mTHnB5+kA+7Qk2WeSD9TvJEniCckOKx0XKNfBFJ2tu7RSzzZnnZ5wx7HeoV6+YstkSR7
 XgHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4KQuY48GW0yqO0P5Lkh2ERZEgQU9RAGTY8LOhVMKP36BgA2nkO8HefQ/SGP/hQB48r1mtbjwpYInd@nongnu.org
X-Gm-Message-State: AOJu0YzDfGISPpkM2q6mdbAjBjf35HNEpvhMlO0iGgiefsqh9H7Oyodn
 Ra0hmGt2GjdgPejodCIFZwe0NRzfozyDsk1kbOJGFk5QgsJ5Km9eAiH0psqc8ga0deutXGcqNqy
 jfne4NfwgVQBawZ7KqlBfDhzb63lGmvftKF4K7JJZDr/PXyESyvGaczd5bA==
X-Gm-Gg: Acq92OH4MzrlXTubAnaojoEOFRj9IkwB58iRK1nRyGaE3JsmSsBP1MCGhzIVY02o3J6
 B+JlgoDvTPX9f9FFPPfaAjPg628+w2PQTFtcIT7GZ57EAZRubVNEOlFoUSxdy8osIw0oe23CUis
 iHyOzlVz5r+1Y3KoYG4Zzqa8g7IEZVje7E2EWpOrKRt6Le8bUmuKlYk9lypd9MuTsit3Dp/pO/g
 C3L2tlwn/fpgil/5eMplFjxKHsK46ZvP+XoDUs1CqwkPWijSprWUa0QKZq9MdBLXqXGa02TrBnN
 i5hii+8b/1YYjHk05+/ISn0r1rXs+k0Q6uLl+CpV+n0I0dKr24XwHVw+q0KJ3gYstSe71edP+ms
 h5p6vqqpu8DWiBRoIcu2rekvm05W+rFlMlgH5YIctzHKczfn+L6zvL0UnY4cPJbKlE8+YNQOa9S
 J7Opth1GGrypRliw==
X-Received: by 2002:a05:7301:6449:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-3039818e82amr2518712eec.6.1778865301116; 
 Fri, 15 May 2026 10:15:01 -0700 (PDT)
X-Received: by 2002:a05:7301:6449:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-3039818e82amr2518694eec.6.1778865300592; 
 Fri, 15 May 2026 10:15:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30294500726sm7213655eec.10.2026.05.15.10.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:15:00 -0700 (PDT)
Message-ID: <4b833434-9e3d-45a1-b4e9-97ceeec205bb@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:14:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/20] target/arm: Build cpu32-system.o as common object
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-20-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfXxyYKJJb36HHj
 AflAh93f9TuDUugFPHjAWjOk26QqQFh9WIRvKgg4Ixmh+3Bx4xlk1PyKWiPNRIunar6y1k9I089
 /90v9EQTFZjea+Gpejj9b3/ppS1p8hXMhGmo0Gpid3VjmuwDE822sW3okKoXJ1iogeU8Bka8xms
 u018SBmvOb3xDpzhcuiJBB5/1ypA/B5WFRUcbCQ62SCBk3fe7ukhQnXtykB0+ppQJ0A5MVn+Iig
 Y58TCpl5bcq7mEFrDx9zYvjvceat8a/+dsiKSxTpmgR0OsIKou2wbrNQp/oVuay75Mq6Jeww1I2
 xZC8GyTn0jnQa/51Dfmi5QCtJU3tFLyQ5poPagyMZHRuy7FNd2strNGJTOZbWNwlF91aCwsUYQP
 acbq8d/2u+Qmy2dyMYayK3GkFJnGPLeQcV2Z31U1+20GTU4zpJ21L6zKhoTV1lmdbKqhCs2n2T/
 pRcfpfm/IGcQgWsxIQQ==
X-Proofpoint-GUID: Gcgn9EjRqAub5P306cV-rjL9kvMxn_6k
X-Proofpoint-ORIG-GUID: Gcgn9EjRqAub5P306cV-rjL9kvMxn_6k
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a075496 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LAUfPzkrTfg_cwmdbVAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> cpu32.c only contains CPU types used in 32-bit system emulation:
> rename it as cpu32-system.c; always compile the file but only
> register the QOM types for the 32-bit binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/tcg/{cpu32.c => cpu32-system.c} | 19 ++++++-------------
>  target/arm/tcg/meson.build                 |  5 +----
>  2 files changed, 7 insertions(+), 17 deletions(-)
>  rename target/arm/tcg/{cpu32.c => cpu32-system.c} (98%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

