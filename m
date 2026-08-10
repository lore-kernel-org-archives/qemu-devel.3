Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA7C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtYG3-0005xj-7w; Mon, 10 Aug 2026 18:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtYG1-0005xb-SV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:14:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtYG0-0004Yo-37
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:14:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXBRS2883100
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ijdH0he7rhLsJyqIh9n+XbQ5pzCFm3Ijw87Wiwboyso=; b=Q/XQQZFpukdn0DVg
 geQrXdIc695B23GugyGk1HfKPnLDoJVOtBJ5OoTrgRfJNWuRHGjCk0WUmH06Ux4N
 s/sFURLSlF5uN1qcnIFK2UDWcmE2PKyB4W2zf44wF1b+miR1DsxH5QXcnYHpsMQP
 MPtXFVZHR0Bd0YJme5OKedLZIOfdpwPsCcoqggG6GSuNp8UWMSoGUNtCskvYA8A1
 BIRMwacYOrVCf8wPvuA2Y8qfE1zvJjUTVhzQKXBCUJjUZz9HLmlkT+5PyJKM7jns
 aPSZajf8C4HG+kw/Qft1d/CNY1cDfUBcd8LkkveaFRgOk9qcoMU7Uk29lLWDYyNK
 31S7og==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk21akk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:14:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso46300991cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786400037; x=1787004837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ijdH0he7rhLsJyqIh9n+XbQ5pzCFm3Ijw87Wiwboyso=;
 b=PWHFWeGPWb/KwufX6EAkm9+tks0gfNjeaxPFq/CZntIMlNOiE1yOhFMtee0r4TExN4
 iPs4Pcew7zHbvDsc79aaOPEgQtU57RqRU7rka2Z4uKWJ4FQrksIE5g2i6k0in1Qv6Xs+
 nqhihCIp5A+tgW/9Afa32bYG1CV9zVFXkaU0hpcFrJInBRtalrAt64Ix8NSfhbokl8sb
 IEe9wd9eMJ4sYcX5i+UZSYys8TZUzOi+QsOthrhddOnalZogSG/ovRFnXV6CLtG9ruer
 nQvvDYwMU9npWxTh4QKXti9pQ8BchOJN/6FKxifVR0oIPAVVWv6rlM1Y3l2l2j7U4ggo
 7XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786400037; x=1787004837;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijdH0he7rhLsJyqIh9n+XbQ5pzCFm3Ijw87Wiwboyso=;
 b=C4dSb4XNLBm5h5QxqAsfF4kGPylDtiYF+hUMtpboDc/s0pODkEAI1usGrnzo5SrBvl
 wZ2maEgNZxuhGl6wH9qUh1dhxCeJkLhGM+n6RMp9LhmoZSJTzMcUUL0oq04NPsqgjg1n
 e8o/rVEiO4VEXY1xyYbRx9ESy0VQtgIwf9IQ4dVu7HBWV20dRPB+4Jz8YUYBgig59Q8h
 ROao2gvQO4lngWZTUMboAXfks//lRtbq9tZHrevLsTMsZAYQaZbVjB+PeJEeDpKd69ZZ
 tASZdPeG5DBUnraSJU7tPYxfcPvsajaBCZKf7ElA0wi2ZBXTD51EljykxfxRRFgMBaKF
 KZ7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEKWpis0tcMceXOHul05jz4CmD+uaSwxBO9G9xgUQfN2OKJ+HKbpPX2kjXAGjWImIG7JrAZy6nrvWY@nongnu.org
X-Gm-Message-State: AOJu0YzYSro1BzpZvAw4jxLa55ZPKtmohAP8YctoD15v8A2T4QLe70/L
 ZBZCAZh5c+/M3LFY2Q/YF6i1QCudtE+MLlgZOSk5SlcXJRkNzgZ9PmFpJQOx38JO6SiduJZakrE
 G10SdqECa7ZgZJJosWxsWqVydPfO91DMsYT5RgNuSBtOSGvSy8aBbyLCyeg==
X-Gm-Gg: AR+sD13he2dKzbjZbhFvbYqduTsrQCXyTE/QvlU9B3t92h0DuD4GV4OvprtY1EMSovI
 Xbck+3NKYAp2ms9ETOl5pSfjwSo/lhhYtUOAVKTslB2afydN6pya8SrzgPVMy/uCQr3TOWGSg4Q
 YUEnNjTZBLqFiwZBZMzFlygKlP0oVIuCpkInHUFFgIAUPIO3sIxUjWvJ1M1+eotScCvJKsaV5ei
 8KWePpn3SlEFp79XR68AcWoR1WaUqRq1mvOnF6WAq5UrabUqwF7DAzjUV/oFz/QlNSIU6atNKGh
 KzYu7q2beEnvAgw8ajmfV8SnkKzmMXvYFO9GsNtxMB6/u6VYqoiSumvu/n53+5X1KNA05GgyZxI
 DEaz/to0k8syEmjFQvuDXjOcxIzFxbCX4gAWXHAsG
X-Received: by 2002:ac8:598e:0:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-52d4bba4135mr60914511cf.13.1786400037042; 
 Mon, 10 Aug 2026 15:13:57 -0700 (PDT)
X-Received: by 2002:ac8:598e:0:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-52d4bba4135mr60914061cf.13.1786400036607; 
 Mon, 10 Aug 2026 15:13:56 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f8b9bsm44382638f8f.25.2026.08.10.15.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 15:13:55 -0700 (PDT)
Message-ID: <6e2e8dcb-92d9-4d95-90b8-5be9fa085fa6@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 00:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/tricore: add tc39x CPU model
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-3-1c39053e5e95@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-3-1c39053e5e95@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4OCBTYWx0ZWRfXwLm07IEqzuvs
 ajrp/0erkOr3yZyT+qiuBgbIvNnIzlaCtWDN/SlixRCAx6HBr3OiBT9b33yN1Y2feLkWR+FY+qZ
 DUBi2QSznq/zQ1KsQOP9WUo0CPJzGUo=
X-Proofpoint-GUID: 1Kd1S7FVQYTVuCvJZ0buLHuT9HPY1tHY
X-Proofpoint-ORIG-GUID: 1Kd1S7FVQYTVuCvJZ0buLHuT9HPY1tHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4OCBTYWx0ZWRfX8OsfU2PCIZ7t
 uG3AZv/f7M8hy4hSMtAwWunB+E0NgHb0MT+MpL+4eGJ/VtHLEfVFlW3KiLFdH8ow0nD2jQNJgmd
 LBe339aSTvLWQG3jfgrWG2Z7phsA3pUTivROXDdSGlUeSjWZL/h02h6S8BjTD2lbUsw4PCZUSYk
 rSYGEcSSQN1z7Y/rPl0lhzmamIawz0UuAHnjJg/uGUlN7cP6OpPN4nxvmVyzn/cDj8QIhjc/dGK
 hxsE3Ai2+dIEUn9q9LLLSGBMlB7YsC1gsUasVG+tmIEXEOJ4/5fse2UvELypFKvfEXuPphSmvGd
 To2FOV151yANCH5hdTprL+Vpm0SOpTEz86apIpqQj1wgiZfO2JozpzpLPIKWnJIJYpz14bnCvWt
 GEnymh9ZY1ytCQuB6Al02oLEEWwMGLpB8WqHMAmjplz9vK78SJveR8g4OUpc53oWz3BKKQcf8VR
 eTJRTfzbjTuSysyvMBw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7a4d2a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=vU9dKmh3AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100188
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

On 31/5/26 11:30, Parthiban Nallathambi wrote:
> Add tc39x with TRICORE_FEATURE_162.  Same ISA as tc37x but a
> different chip family (6-core AURIX 2nd gen).
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   target/tricore/cpu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

