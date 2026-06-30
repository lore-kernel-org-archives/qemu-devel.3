Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2361DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQEP-0006ud-Nd; Tue, 30 Jun 2026 00:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weQEN-0006uE-VM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:37:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weQEL-0004tc-Mz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:37:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U1JOBS450716
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jn03h8OjSFkSH7XXByU6iqMyeTm3XzlnfbmXs9fK2iY=; b=VGljpjweWXzJuFFe
 j9HlcwknFASSS94t52DDDTFJgEPufCizjK6ESK60W7ZowQOIaWqDnsNsxNL0VJJR
 7c1IJ3nUnqwXbAlOuxhNZnjm9EL6U4FgAtokAvDFcKJiw0ihjDZE0S6lkd0hMUT9
 PxtAv4AEy5Ia5vlppkwyrHQ2V5Os+2hvhJW3jC+Gn+laQSCgLTs4IoA6IOPi/r83
 ajLp9IsuiGAImhiWbSlzOoYDbSuEZ6pMUpibxjjwi88ZgjM+0WPrB/ZzAzEmGtSv
 T2PU/z9ITadPTZ385QnU4SWc8xtY/iAz66igHMDG2/56IjRbTR7qy/e+GRGl5dZ+
 Keck4A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1csu4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:37:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92158791d14so542532385a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 21:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782794271; x=1783399071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jn03h8OjSFkSH7XXByU6iqMyeTm3XzlnfbmXs9fK2iY=;
 b=BlmfhhWX2HYpi2yQyovWQsR5mt0+O1fv1cdipa7gdv3c8b6tMrevWKV0SJovhzyJ/c
 08xdSzZ3igzRMeMGKu6OiRWWzLMrl02f9vB/ziNM1kkDNu5kRriYaMfEo1uqxMeVXDxM
 de4/WqQ7B4/liTu2PV4CNboCB9K4ixxUC9r4/y/vvN5YVNErMVUzpavUxeSpl/bxylbc
 GeA+Q5CO8iNlYgaRnMA1kILHRuP5BnUEXEUtw6mAZbujxiJfMniEKXPEYmsCsBB4l505
 CH+eLXY/lIAoyO37sDiVYThzBQuZycqiVn/j5UXmCPglICoADHS0KhUApyWBTFqYJoEB
 e1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782794271; x=1783399071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jn03h8OjSFkSH7XXByU6iqMyeTm3XzlnfbmXs9fK2iY=;
 b=ClfaavHvNKErGeLF5cGXXCoAvqOORabWKTGpkjBDHKsqn2D6Jq5nxlBpU/JESJ2P8n
 KjsO5bAW73U0kiwYn2uDs3mQ+jpy7E6Ne8eihAiaFqBlfCjv3XaoRP9QKq+f0g5wsGl9
 dwzW4C/5fm+l5Om2Z+aykGxb2xRrnZKWaKjpQXMGkCe5Z59BuI1YBtrmM5mnv7YUhTEE
 ggYeTNWTWWoj55S2BdVuMSJlX3PBRLf0Ckq62Kro4PyKflb8nbCsNWXMdjeJpvqWZKwZ
 wT6LC36UjsS2G3Ugq8qp4gJG3CKABK6mpg8O/yUyjugeuMtq2xfd3Yqt0Fymv5tAicW2
 HBAw==
X-Gm-Message-State: AOJu0YyoLZWCVdAaDDUrRtVtsdf/tEpVf4gyoXEllcb4LKQh1XYmOd2Y
 qowqVWXN6GYufbnN+qcAy3ewYTGhgpTvTvm9xDEAMX457Gy6WEjXlCmHxjs9OlmYqSnZgToQTdI
 9KAU2gnKqjzYjakX1h+pXxsRlIj+7u5v/iU5JGtWqprj4TvwZYFM7Kvmz6A==
X-Gm-Gg: AfdE7cmcwMyqOTsnrjFuZwTxBs2k999HaTXfEa7Bbtk/IvFzxdGV6wMQRWix+nrzp03
 uXRHZNfpYw8E6mgxA/CknHcmwdRbLpyqiwCq4qGWIvPk57hZs2i1mlEr9CEOWj+XS8/9mewjeV0
 kvmlJKKnlM3eS1a7GuqS2eXiOsvlHUJ1GLyBC8fL5WNhmThAFkM7KC1a4FEysdmZJl9lVNxWrMq
 1yeSZAw9bqrMJOrXvnMEXxfZOIDsBmi8EaiSjyGjx6gBI5+iRcLhOz3+h+XOXdt3dBlrMGTLVh0
 O0pT/uPTCcYMChT9y+PBN301EpyBiFS1VLEpXs+FBH0eNP3/z3rhiUAKOeWGf2L1g/M0Qd6M4Ul
 4Im+zRhaQ8DAZ0o2vWHR2aEVZBexdXE6sKJRfGmURzJiegXN9ND2TsuhUwitFMQ==
X-Received: by 2002:a05:620a:4553:b0:92e:48a2:5330 with SMTP id
 af79cd13be357-92e62465424mr372401385a.13.1782794270787; 
 Mon, 29 Jun 2026 21:37:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4553:b0:92e:48a2:5330 with SMTP id
 af79cd13be357-92e62465424mr372398385a.13.1782794270300; 
 Mon, 29 Jun 2026 21:37:50 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47567979eafsm3866096f8f.34.2026.06.29.21.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 21:37:49 -0700 (PDT)
Message-ID: <74202722-3e9a-4013-9155-da969412e541@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 06:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v5 00/77] hex queue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
 <20260629182818.GA383234@fedora>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629182818.GA383234@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAzOSBTYWx0ZWRfX9xYzlyknb3Cl
 e2whGAx5PXnbUTnx0FNhLBw7MjD9d5E/ASuXgXeQ/0n0bH9pBd0j8BwzwRMAsOHfmrMjULYdH8e
 p91u46Qpub1NdTxHvKrkhRA4pH+cJqmY3aKjSKZRfq1uQIxid07NNB+oBYoCyi/jZEjuhFM3/o7
 qSMiwKEcnxNTk7RR69P6AkbqAR2SRqRWkcb8o0452aB6MrZifOcMn+t0EM2hha7rVw8vqNpWe0X
 dbUwmNAyBGn0PbShrFefqO/Q9PAo5RKJcqepTL0PV8dSiH11IkZARn33Wjo35/WLAaMsoD1qNk4
 os5M26d06Zk8M4zltV30cyuPQRk3Q4R6k5u4ayjyxqF3IqEMY6s5/c9I+j9gWuf//0Ek4XnxuG/
 2oEW8iJNvg5a1Rwha7LD43bJqlVAelPZfVEgF3TL2dsAaO68FUBZjF7sOkfM/rkEmvz46J9gAZf
 rj3UHAiEOprwI006w5A==
X-Proofpoint-ORIG-GUID: InVRtvWaQdG8liCimTtO3ZOfA2-95NiT
X-Proofpoint-GUID: InVRtvWaQdG8liCimTtO3ZOfA2-95NiT
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43481f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=x-v3Gd4F-_EukbkMXOkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAzOSBTYWx0ZWRfXzyWyYfc6Vc+G
 32IO2OXE/xMlHzr+cTczzONs/M3cAcq1faZ0Dyd9N1uJoT5Bp0PaKt6gS2ChbAWxQX2yRDFliT9
 Xi4+UryXKTO0WW+jJwpoNNsnV9Y8ADA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300039
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

On 29/6/26 20:28, Stefan Hajnoczi wrote:
> Applied, thanks.

🥳 🎉

