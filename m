Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C078C55ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrMsV-0005KS-54; Tue, 04 Aug 2026 17:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrMsR-0005K4-Uq
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:40:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrMsP-0007Wg-TW
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:40:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674Jlknb428808
 for <qemu-devel@nongnu.org>; Tue, 4 Aug 2026 21:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uQuzRHNwD3D4uHU0eyun631305SeCTS+alxufxyLkFA=; b=PUXOpIdwqeJqA3Tu
 vBUNkbwRV1tIYWhwqqdUDs/SmmmGFszpFDdu/gS9Zt5vG9KI0UODY0JwglUe5AXX
 awhI9t2I7j0V8MfXvbziermGQwr4Bd+IS2Kf45Z4p04X/YlP8MpEr6WTLz5m+WSr
 y5KvXWUPIeg5wfBF8vDuXr4FE4z31IJmlPJWQkj01PIKqMVYeZwZsx0RMDEqPxDZ
 0Gzu9CcFufxRhMKy35bQqr2j8DcHUnXEMfI/HIzqJ7ROwg/oYHUxQa0MmQCydkFX
 btjmhQpzgT7GSNHeF2zerwos3p63/yipbhQGBnl7S3vyKSMJhxYw1tIVLbdi//rz
 hI0ztg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmgjdmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 21:40:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so1112283a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785879643; x=1786484443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uQuzRHNwD3D4uHU0eyun631305SeCTS+alxufxyLkFA=;
 b=PCnzwxz5xLb8ILjsTxDzKMHWVWhoKUCsl6Fon8af3WdQyPrHZWTGb2yHvwpjkHanJk
 6JgN9cwGqPnnbnRVmgkxLY/k6+xAnv/Akg6Nt34w1NOfBQiD8oL3AN7DPbCk9ejvAdpi
 Vjf+qCDuav4k7JrsSQ0hL7BeTIzNnNGWCLXkLgxx6XtpQqCs8IrtLF6qSlDoekB+hVV+
 TSBAsy+Y/MGp9aKbkgT3t+yOSmwqj9kNdLx9e8Y9ITPjh4SlfI9sIsdV6GQOKcuLfiuN
 ZpUAzVaaFkYBoRRkrJsgZseJGfiRSJ1ddR3zz/kcFth6bqI1a/SJcc/llrREStczt+eu
 u2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785879643; x=1786484443;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uQuzRHNwD3D4uHU0eyun631305SeCTS+alxufxyLkFA=;
 b=m7ltb+rIQMzfsCtsMTuhm8go6zikjTm3zFtmRk9aID1w49Kvo7frOGKGgpcWy31vA+
 lUDSnoy9J8VFRD+njrIxYuuaA7IGAWk22wRzdV7UfPBBdYYPAqdvV0KKgQ5dqFTNjlwt
 O4PfOhsETltg0K3wpm/CRcG3Sk61vOuRp5vPJZkNQhJy53H9bX0R49088hQPGLco+KCF
 zr5fsUihcRozLYHX3utUoTqPR3PMZoNXTigoyzJH5rftSbLYUJl6xGi3owrYR256i5WM
 ItIzmJRs3Wrtc9XudfczI4lcwJ0bKjo1cMvKrHLQ1+Eqq4G1iwJ+0CzDK3nWbp0MtPOp
 kXdA==
X-Gm-Message-State: AOJu0YyvrqcFWtXCyUJslaSuuid5GVeDVjzRjzqzH9GHosfVG65yeri+
 kuma1E1pqCMhX3jKkHTUoQFQdW6fii+5yElW8isKqUGcAmQ0LBgHIVednHtBF3qjgYB5IKujT1y
 fRC1PZXJlKH0STtR5ES9TtHTTG59tOnq2+FD3QCUxAo2F37AKOn0TBY8zDSniKxh8ew==
X-Gm-Gg: AR+sD13kq857TDXfN2YnA4GcsPuaDWfADrNnlgl7v1iXSILDslTN0G8qxNnEv/6IZVf
 u0RpxqJ7YRYRTbvf5mOBNXCSLz4sRFcn1Q1IRXeyk6/hl0jYMORUMrTM1iJRMUqFBSjIKh7FUPN
 Nt3dscnGMi+MEcb4G6egunaUl88ppaH72ZThIJ3KOKwO7UKn4YYAzoaKvvWsn9AoUqgVjKRAgnm
 vuBt/J837nSlAijNrc0w+vHfUAThqwMDK08jyOjbyHxxlG6z1+beoHf4kagoHH2mSpK+f5DtBq+
 hdsHQTduFjZPQVYOQzPiWb5kOtgrqnlJXN9dgN2gVP6zYOtg4R6FcpsXwW+KWm3M+BryIAb//b+
 kgoiz1me9OyV/MeptetcWIGhd3o13bwvuJa3dLvVAatdnlu2ysCSaXJPSxZumGpmPYZtZ
X-Received: by 2002:a17:90b:3b52:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38febfa00d4mr4963974a91.5.1785879643058; 
 Tue, 04 Aug 2026 14:40:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3b52:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38febfa00d4mr4963941a91.5.1785879642485; 
 Tue, 04 Aug 2026 14:40:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315867bc261sm8025387eec.28.2026.08.04.14.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 14:40:41 -0700 (PDT)
Message-ID: <9e71b8cd-e739-455d-9b0d-e665f821351c@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 14:40:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NSBTYWx0ZWRfXzzTQSdoz+bCK
 7beE9ZmzMs1PX2V72OJG1OV3sxfO3MYRoRkou6ax8wDCQEi0Py0jHFG6QaUTkn85Eu+eNsc3Ech
 pRYWu6LW/r48KkdiV00o6lHLo/4en4dg9nysfYuSpyVtRKx5/fgiJ/rbHFp5ry1Lmgje7yleM4t
 3uumQYvkrHU5CGWAIp4hvFjNK+PkD8dsLCIXno9a7Dc9nYRH5e2+8Niq8ukG/0ANiJ08HomJYt2
 O0ODdNHqBd+YNNLZl0W2Ml4oG0bEamINjAIvoX4JHnPhsh2D3+FG9qWyrrDCXK0T01IVC/iW67K
 9+MQfX6kkCdIoUomDjkUntgW3YR9Bi6PmICz91/xy+9hzbJ2p8sIAIpIg8/uBTrJcuk/z6+jEzs
 zXZBqDG08exVJRwBIpLCRc13hsvZuBXT2DWaso2Bjwi4KGPvLpPg0fAT5z18Tk9r76FAhWjD00G
 m+ls3XN+EtTq46o0N7A==
X-Proofpoint-GUID: n2pxncufwYQyACaAtgRHBM1GmivJthzk
X-Proofpoint-ORIG-GUID: n2pxncufwYQyACaAtgRHBM1GmivJthzk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NSBTYWx0ZWRfX2QLa5x078gMD
 YG8Jd65S7cqnb7JCOIcRdq/mRo9CuvtOuPlEmNZ364gZmvW6VSyKy01n00eXW2RD0clxO41UAXu
 D544C06Jkr93x/63jnfrp8k27SEhmXY=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a725c5b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=BTZusD-m3GuFiM6ODzUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040175
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

On 7/27/2026 9:41 PM, Pierrick Bouvier wrote:

Gentle ping after a week.

@Alex: the changes you requested on v5 are implemented in patches 96-103.

Regards,
Pierrick

