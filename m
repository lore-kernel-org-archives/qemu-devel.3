Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AAFC982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8aXw-00030k-7H; Mon, 21 Sep 2026 05:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8aXs-00030T-5J
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:42:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8aXq-00063I-Mx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:42:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7AjdB371688
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 joCxKLhbfImVD5xFaSIhN6JMuInHJ+YQpH0yMU5wSHA=; b=F67YXVxdKuJYK7Pv
 14JuCnQZbOsUqy2DtPCueaKUqXYez4ZqJapvwLnaqIHj2LJhWcDHoIA0WuPKvsMQ
 UfauNNTTVFuX8Yu0IR84IZc6r3xu3uEKiXKqG+3Lapxv1jh+J+brMhNRvxb9aMYl
 gPV93C8hQ1pIpHojxQMK2/SLnOdMO9y+/ZMe4EVigE4hUecXU8uLekZcD0dXZEA/
 aVPHe30IclMcvMAy2pxuoYUq+eAAFzMruWLpLnjn6I8OQpYir8EZDIrUI43vC10/
 NFlRtMD9syVMYTMdqRJEWxe+Y6KEp2p0ibtuWfJ6WjJ0s0+PZzUUITeihIM4pszO
 FuSR6A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5h5un-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:42:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9393ac4961fso383214785a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789983758; x=1790588558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=joCxKLhbfImVD5xFaSIhN6JMuInHJ+YQpH0yMU5wSHA=;
 b=if0OTV1xT/m5ec0V27quzOUJkEIiDqsVmnNqEHb3DUp7VC0kYeNQTjDUBH/mGCYpzp
 f3QeSDxoI4g2E+eJrqTju3ePfOM/19r8K7LNN6qgqchEyIyiDx7hwRyGKWKSAVITrbBX
 8oLGg7wPq2aOJzLvLX9JnnXROuhARHYMj9eCaxljpBlXSpFT5KcrPLW9PT+ym4u2889F
 YvLEYirkXhE3/gS+NOXUwjTxt6ZYQHUTD88vWx1zOz3SWX9py9X5WrSlu7OmWAE0ANsr
 6elcFPfOprMn87wsmUZtOIBVSIOFeo/HCZnkP5+q4UBh7NIXE+VlLDeCjft8svIWmRPP
 lTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789983758; x=1790588558;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=joCxKLhbfImVD5xFaSIhN6JMuInHJ+YQpH0yMU5wSHA=;
 b=Zcozkriw2oUDsnQ6uxZn0sasUv2RGuKxhmr+MwdOWAA4g6xYeDHvhDqseOjEOVlggZ
 jJi4y4mMqQSeEQ2ecng2wN55ys8K1QcBkntvf5jcrjfPn21MbzVnMsjq0FZQKXq3bzZ1
 Y/GmMMGdPmXRWV7yfQWEc6dRRxdni5INHchtuzProz3oUzItLc4lOdK/k8yTzlXW+4Dr
 HZX4ZSiQpeOBu7+2ZV7xDWnAiXTylwgg+BlBYrU8Mdv5ia+IUKp/jftqq9X3OvpcxbOs
 3YvkG0nLLnW3tlT4lPImQL/T0DCXwxumpCfzyZXi3ofpS/eKU+OKxhxkp5H4UWqpE9Jl
 NuCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMEm8zgopjOoygKF4xQZk+2n7x65f1Y6WbVXXbWjkkgavVkm8XTAkTGNkEIwicZ1EOxeqkTFz2RWZr@nongnu.org
X-Gm-Message-State: AFuF++m3gIuuQPx8zjNqqBOai6YN2SC0b4wYgNdne3pvN/wG8yzaaXhM
 jk2ahYJT9gUj4AwZ0zio2SkLmTK5BYlMVRtkpI2Q0Qsr8X0zIFAgrwxqJ7ngRRts2gbPLMsyJvm
 d4Pj/tmiaZSt4RIr8zze17D1jDInbkiqnmvLqyF0gVcvK1rq/lp8bw8FIQ45pOZmq+w==
X-Gm-Gg: AYBFou2ktkNw0DPnXjO8QSL5/o40/T8sRKblopfI7X7ev/H1U+zbFRrBgWvdU/kFjER
 +yiXDYHVP8yX8it2xovS00/RgpwSzpEHC5CjBWo1y/19RDqENOo3sDvEo/RjNqp7c4lUhzhrC+N
 hf5Qs3KK4c+p//wxhcP26h+mS53Ddd9FkPKwznUcCke1hz01jBZcEhvg7qTquSNbCJS4ft00QBq
 mfEEXx5xr1tZ/yxAGCtzSqhyC3qBgOhse6Maaucd3a8xWZB1nLw6zfLUViiO/W3ph8o6N/Asa1Y
 W4Tiu8HJ6j4RJ4bk9dPaGjugOpOxs2gkS99xcw4x/xWbusvxcRp/fEok1l5UdLHtYst12clC44/
 CCZ6EAsINd3nHHNbsDT42GKYWRrkd101GpA==
X-Received: by 2002:a05:620a:1a02:b0:93a:1fa7:1afb with SMTP id
 af79cd13be357-93bf5722923mr880629385a.42.1789983757980; 
 Mon, 21 Sep 2026 02:42:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1a02:b0:93a:1fa7:1afb with SMTP id
 af79cd13be357-93bf5722923mr880628185a.42.1789983757496; 
 Mon, 21 Sep 2026 02:42:37 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd0f7e05sm228704425e9.4.2026.09.21.02.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:42:36 -0700 (PDT)
Message-ID: <1418f843-a350-4e63-9886-38be7c8234e4@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/sphinx/dbus: register build dependency
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260907114858.207809-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907114858.207809-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab0fc0e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: B9Cxtdbnwn29BpuYyfc7buhv68ODtdna
X-Proofpoint-ORIG-GUID: B9Cxtdbnwn29BpuYyfc7buhv68ODtdna
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzOSBTYWx0ZWRfXxsg8fdBKgTN/
 /zbtnxNPfLrc8Lb5lxMD3Gp1ua6j94NdNgywyaqBN3QhlvKSmcpPtLhzdZM8UZXPXGbxWFqKVHY
 x3/RTW9fNzOstlLe0ZFVfaBDp91vyX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzOSBTYWx0ZWRfX51x4+zo2useM
 jZ7pb+rXCnf0S48MI8mphJSzL2fIJUvNmhB0/xSP6m7YsuWhcTKIXqlsUpzKZFj4jeN9cU9em65
 tXwtk8i4mEVoRBfiEguq10kf0ASeSyQTKjWT3hYYlySbrJPald5QivhyhmLwKySHijV2h8/TqUW
 8zBrRRDsSXnB9jesl2dMXAfYer/DdUXD97BuCF87g6othq7RHd21XcTFdF4fDlHCUu/71jeWpYG
 cTFtdrq5Do7TB7SJwmpCGC0TMSQdZMNVSSY7Gkaf6TfgMdJOQiUEJ5xEDKCXL7WCZ0zGkqai/Ul
 fZpfGUG5qxaGJeBT8OqMeKOdKZ7b41GOl6YCMWMRBriEkcuVkFmyS8Py7Owm2n8LH2zpmRys+df
 D35Lb9Sc8zEJ9sAiDu2PFXslRtYDrWaL5n+GgwV5sEfnO8UAGc1W1NO67aBuRSrFE+lgfVU41P/
 oTkBVlNep7WFyCAqM1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210139
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

On 7/9/26 13:48, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Touching dbus xml file wasn't enough to trigger a new build because
> the file wasn't registered to the dependency system.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   docs/sphinx/dbusdoc.py | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

