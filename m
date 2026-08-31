Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29FBC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x13LG-0005ab-1U; Mon, 31 Aug 2026 10:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x13LC-0005aF-9H
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:50:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x13L8-0004kQ-JT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:50:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VETHoH2719776
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5WgZrp/tLCKyJiUMHJPHwDkM7clxLFGICHZjWPcGR2g=; b=muGFw2moC3ca0ecM
 HXLZIe60RPI01teHfdgG+oOpQ+MKfwREeL3VRZwH2+fBNR3WqcDmfl/FhmvBZ0x7
 WONKMlDYaWSbW/2FxJc3OVe20Dj1henTlZvZzxK91wk8d5kaWXQY6a8s8o1L4YkP
 FN/j52Ilep7y/H8H4FosDILyh4nPJQSOFMYqaQXfbA4YdejX87DOA0DfUxroM0d6
 v8Sw5YXxYW5C6b6UhYdesrhyz264rXOGaGbrFYTancuoKBZLPk44T43TZDO6Dkyf
 VQoSDpnD1DGYFa7PnErrP1+Zrwo/3EiueXYKsCvOvrySsPHcMh0dL/QeyEM7GWi8
 Z9afRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vaharc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:50:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e62e3459fso450926085a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788187823; x=1788792623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5WgZrp/tLCKyJiUMHJPHwDkM7clxLFGICHZjWPcGR2g=;
 b=MJKLjpkLMqGKBQVIFQNsD4sbTxP7tgl4L5zioCTWHffE5NN1fkQ1DutNmaLFoCCT6k
 NA5teHtbaYPhH5BTMY3IF8EZWzfm7sg35mF4P58qDr9EDFbjZ1h0+71IS7m1D2CDOvI3
 oxTGzNkQwlW0wfVgg635TmOS32cWgToMA0EL+8mDhG1gy7b9R2abDv7lCNQo0uShfEJl
 eNvVbndYEmjSQjQ46TOSczQx0KNxfXmAclfWxjJjf7pFXukRfCUexlmWqEhyMrWed616
 p2EYXigJ8rbkrBlK1HDTOJawRflSocFnIYDxkYwkAOiN1IEvcpcTGTvxVQFPMBi08Ocf
 qxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788187823; x=1788792623;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5WgZrp/tLCKyJiUMHJPHwDkM7clxLFGICHZjWPcGR2g=;
 b=N+PASAdP9Gii6xIWGKHYv58HSoag9JJJ+CmmvHNG7yRwXb1lltwGRSvRZFdnvI1nNT
 bU4HHzHaNedloIcAXZfyPWOul0cOTwCgru2TySrzc+/tPlOK4f9ksl89NAVzVjxhhB0Q
 68xrRH9GGN3wd3kDQHV1FRstrkvbNw9YosTAkKdLgsx2jbRtNLQ21uvZ2huaVpP9q+aU
 fSIZsQ2d8wDEKFy6HqGvLTB99xXimBqgf7DVA15anoWDl/gyhb/mx7WWAQ8V8lKf2iyX
 5JCGHu2aCpnl7w5WOY3kV0wKba9/DDzYLHoyD9L15VNuNVciCuasDW9UKp2Xr500Fy/N
 qHzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSLb+z/W2mdzqzqnosBQFP56vgNbX/QPUuIIjKwA9BGzGtC+GyKvRZN7PGCufhS5R1wiiMdBY6pzgW@nongnu.org
X-Gm-Message-State: AFuF++kX2ddR9imWiiVRjp1XnA8dex49AOD2js3xlOewJo9UetTGfZwJ
 pmiWCewmr2VeAzX6PJdwuInAJbufeQ7ttFVoxdhHAiplPWOeprxER5fbCuhAI4TD7UPttIJtGlT
 dNr0HYsjSbwH/TVbx8w3wZ8bUH8j3/OO3g9aZudhFMwe6uL790pc4cfgDvw==
X-Gm-Gg: AR+sD11y1bLQoEm/ZFK4c0c9l8TOUNWj61d/7qblpjMgrr93LWDJFCEokv0lpp3ThN2
 aCd9w9cqYdfDTm1ELmWMD9FIN9Ug3EczlFFUXIazwWkbcUhSR/CW4K2oTWBxBnCminUqjGTQxZN
 yTg7dkUc1nk4mqDjyowiPE1YFlQT7Oso4nTdajhn0o81PfDDhc7u7OKeNSWKsLgd6DDWzqrfQUN
 gZ862ykYkBrwxbHzWhESy51B+clbBpmveyr7+g6H13ca22z9moflzOtQ+g71PtOOnHeaHrIHLWM
 NlWDo/OC6vvXrTtqKckn+m44Aqd8dsTFY+I+a9Cf35KN0IKWaMhnbr2mKfKQU5dLUEcZ6aIvrh6
 NqU9J/eWpDfYEtI/hS6Caw4ZX4du3ITsbzA==
X-Received: by 2002:a05:620a:3949:b0:936:623e:2603 with SMTP id
 af79cd13be357-9391379a38cmr2741458585a.17.1788187823281; 
 Mon, 31 Aug 2026 07:50:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3949:b0:936:623e:2603 with SMTP id
 af79cd13be357-9391379a38cmr2741453185a.17.1788187822675; 
 Mon, 31 Aug 2026 07:50:22 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48436e2af45sm14642125f8f.9.2026.08.31.07.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 07:50:21 -0700 (PDT)
Message-ID: <ffcbfe1c-7f1f-44f8-87f6-8611815dcb26@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/47] meson: build single binary for arm+aarch64 targets
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-36-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-36-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNyBTYWx0ZWRfX5DQD4510Giom
 ThgHWYELAkSeSq6nltpohtmSMa4tt9sO4kPWpto9heuDXZU5J+dzi7KM7zTJW67qxI0wNPGxoUQ
 1aO1vUOyeskL747+C/+QD0ERteFL6zwLM7zDHeCBOBi4aGUn1JN+jd3NMTYw0KFpvy1YVQJfDAo
 RFVdnqVTmv09Y7TeIG4oYRf7HtCyCmcScJvxr3GGo96Qg7sr2vHIkQxoRPvebSOWOE4bob82KeL
 Hne3XxoN0PlgLr6XyTPk5xRZ98HOq2catCldmD4wXfkoUFgQ53a4xvGMOPINS0k4ptSNCsiZLU0
 DfozPwZYwPrVghFd7BULCHV+3AbHlmnzIigxeRShApzYEjh1WfGt0U4QwM3XSMRqcBayfm9ql4c
 lmEghxLEVpc+47h8PWwNdUNnPmM0HJitvmlg5MQyjdOUTRvBg3mK5pdfi4FjB1w8dpy+j9te1UM
 sXK5lGISJTk8HiZZ/2w==
X-Authority-Analysis: v=2.4 cv=YYmNIQRf c=1 sm=1 tr=0 ts=6a9594b0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=xt-mzBTFr2Kth5l1m7AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNyBTYWx0ZWRfX2j8II5GRfc6s
 MefgiWNzZWTOfxYuF7Qt+f5DFdi9yGImKp5ayZE/a0/wFAU5wOFSV1pW+e/izQju4ib3HORiO4O
 U6BvF5zdnZ0eNF6/ozwcrRZRws0IOio=
X-Proofpoint-GUID: ODS5m3Oi72LhkEOPgfCWg9wnZtH7qDdu
X-Proofpoint-ORIG-GUID: ODS5m3Oi72LhkEOPgfCWg9wnZtH7qDdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310127
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> Build with: ninja -C build qemu-system
> This is not built by default.
> 
> All available *-softmmu targets are aggregated, ./configure
> --target-list can be used to restrict which targets are included.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson.build | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

