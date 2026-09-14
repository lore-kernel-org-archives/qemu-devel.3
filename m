Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABE1C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CWs-0002s6-A1; Mon, 14 Sep 2026 15:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CWq-0002rl-T9
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:39:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CWo-0005NV-4t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:39:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYVQd771802
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pHy5zOF52s+D7c+O2NYDAY3FUJNmywmPqSEwAp1+5YY=; b=Y678mNNRvHS1g5Dw
 KTKY40+wdRJBxNT6SqdzxZIK59FKBedD6gDNYMopNTp9VYIPlIizn3OR4xFKNRBk
 U55mtO7RP0wuHbxpLGuAXh2zisDgYcEK4JydSUvjGLMNdQaXpgrgiIkoPlul3sLj
 jVOmdrgGGOvao4VkpClRJcm5MqGkgUMr5TzeVjazkQYBKQ5ETVwaW0MJ2fFT5tyT
 3cFHWahhffbz8mOo9rYl5MkqXw5DuNqV0K1BwCevWVq0t+c+2Pmn28D2inAK8oGB
 cabHtncC8EajwXk3FRIIPepOCi1hXpXCyyw8bKNuuhinlJ77fSRL/TDz2b2e65SX
 2T6FKQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg2ugd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:39:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso2861572a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789414784; x=1790019584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pHy5zOF52s+D7c+O2NYDAY3FUJNmywmPqSEwAp1+5YY=;
 b=I11N+9BV3ckY2mcRjWY+wHhhHFLzQ9YS7FdOzi0xP+P0JOLEvlxWOpw+u6OU8wBHCf
 zj1u4fqxcePdG/rl5PJ1pHiubk10egZtePrbDhd7+HOmrCM93PYttRQ/cNlXoygruRvO
 /4NfzynownHKa4oMYUm2SHCL5HrUnxkIrzn95pe5KXUEKKrtlwNL+PNR8HJehIZU5uXh
 I78fklhAPJcAWh4la7JL0XwGDGdBh+kwNv9Es4tTcGZyl87/IClBG8aYu7/opoDU7HV+
 9Ia9XWEjKepsoqL9+UX+TaMFDQoIXt9/idPmNnflvEEfI2xIJmBW5Y3f28+kogoCgCvA
 ctsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414784; x=1790019584;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pHy5zOF52s+D7c+O2NYDAY3FUJNmywmPqSEwAp1+5YY=;
 b=FqLijiH4tco9612f7LJV+YsvOm/G3TMkGMMepPoYooXGz8M44SawLAinjfINCKYJQa
 QKo+bT5sVw03UAEvnvy3TRPsJQuXfCXq2h36YYKPGHvxeo4ayjMwCHMHskBiVhxOFllC
 5xC6pHXKI+DMzvqSU8lBHKecJwSFb0zz/krxg4uL4Ufkj8rr+zJo2tI5Io0KUnyXsS4P
 48dKcnnWDqodNmKCC4YJskggdzEixPSfeppvzfgrFSW0jo+dzXrdmDxVleTIEWbePamx
 4zxr0bSHlzzUI3BgE4i1uAy7mvt5MTv2bzEEp261XyE8cHFkfNLwPUlwEjli/yKj/zZn
 3JZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKnhcLj2c8EoSnPAwEuHws+WiIh9k/z5uFgZRo2sYa1y07eGomYdXCRxnTVB+Kivv3fdKtdUe+KhMs@nongnu.org
X-Gm-Message-State: AFuF++mCULPGK0Xm2qhP9HE6MtiwnIBSrxG3r4uAH6kGVoyU6lxn5MIl
 7s6ea2UYSEJ7hZF7plzKbMhHA/CcTrjDhJT5QSaXYQsoTCIOylvokOC8XrnTfwYhmYMHMc6ad0I
 z4aByvMVHByu4ZKrG46kMxxAcjyXaR9A/YzZ4CaPkNn+73Sdc5kR8Y/dIgg==
X-Gm-Gg: AYBFou3YoLjncuYPm+21xc+Felwy5ig8waAltJPRA5cvSS026ItTn6K8MEhn5YvA/cs
 kPkb+JAdG+G+mY3ia3Fjnli8cqxle50HKsiNlS6kVS2cj+32vSLKefenUmU3omVJlecpqWzp7fg
 CKWTwqI27VOXHNviqxrgyQ0mrwIz2+NqeR/we5rTrfZ41HVBbzfsfCMbIrq7OFugGXDiA1Ln9Xi
 OozypkgKK0NF44RE0EpkIEeqzZfkhmN2lz19ZOzaQh8d5ONgi1Q762qBE1JD/xjgGKvApnkFUwR
 iLGanOMCNA6f4gt2/sp0LIeo6eW+G9WwGoJLKoJ+dJbtmcuWNonhHFM0zxvGOwOJLC+dOQDZU87
 RrHC4RsuH1/VGqCuOQXgocfgzCVdrf5BTk667TC9xzIxx1I/kKcv9XGPcQxVHF0qEdhzI
X-Received: by 2002:a05:6a21:9f07:b0:3d3:b02a:61a5 with SMTP id
 adf61e73a8af0-3db406dc613mr9605097637.28.1789414783795; 
 Mon, 14 Sep 2026 12:39:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:9f07:b0:3d3:b02a:61a5 with SMTP id
 adf61e73a8af0-3db406dc613mr9605034637.28.1789414783381; 
 Mon, 14 Sep 2026 12:39:43 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f06423sm32309196eec.20.2026.09.14.12.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:39:42 -0700 (PDT)
Message-ID: <14e628ff-61cb-4816-8291-3b5cdd178c45@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:39:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] tests/tcg/hexagon: add vgather/vscatter
 region-length tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
 <20260905195955.2001304-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905195955.2001304-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa84d80 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=q-r6SJLbOQhasUAek_IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: C--apj0TsyJbe2U0O2wxAXfmB-C4VhbV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX49cSqi9lG9+h
 ui0d8aoIJuATnJp03K1gg1UfZH1Cxm33LCTEBu5VKwvbh1aK3QS+WAr11rlZ0ask0eNlhCt2vLv
 PaOyPucfAE95Upc7DXMk7sAfuT4HKfs=
X-Proofpoint-GUID: C--apj0TsyJbe2U0O2wxAXfmB-C4VhbV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX7753yUNpqJ4B
 ppCg4lFeuu1Cxw77+n+LmRnLeqDdBbIthKdaSq0WdpAe9JeISbOrGwh+1yltE+U6YwcAHsefkIX
 QXrTgfoWin9Jvk3XWTlexRGXQ9K9c+fojpY6+4GeuJdEGzN8ssLl3dkibHeAp9my6vRAc08xnIY
 6vaO9xjklQ+fKjSE+PViOys9zAGJsYHqObnKiD77ANuj3jl6Syj2TIUxQdYv8A73RhqviuY1RM4
 306Q1w2hgRsgB1aM74NDE2Yc7Rl2jKe3ppWAMS/5FvPB6NygkqA/c3BtXjB/tU2KWEsPDPV9Zdy
 9x0h9gGUp08KpHUks+UtRxAr1y2aPRffblyfdgR/DmjPNXRVFzByVYBfKKUM5PhBvlqLgFuYxSX
 sDGlI+hbcXAw6lPz5s+WXWvV0uud4CdlvtIJBQDOueP1VtXZ/lzlJx9z3L2g+sCUPKdwAwQXO4x
 e3TZ8syIOXLf7RQ53ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140280
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

On 9/5/2026 12:59 PM, Brian Cain wrote:
> Cover the case where an offset lies beyond the region length: it
> must be dropped rather than read/written.
> 
> Place one dropped gather offset on a PROT_NONE page to verify that
> the instruction does not access memory for that lane.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/scatter_gather.c | 137 ++++++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

