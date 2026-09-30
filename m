Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE11CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxR6-0000Jd-60; Wed, 30 Sep 2026 12:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxR1-0000JN-1f
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:45:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxQz-0002z1-DQ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:45:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxqYw612329
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QW07VhhHoSKTrTSihMHeFFjAXuxAE1ILkgE/Kf/i6Bg=; b=huxxRm01soeMFDFN
 nmAopCGeA6YzoE5nRJ6wdxKcT1b3VrK4T2arlOZTRx0tDF1bq0EjAJye1b1/x2NN
 o/KqZOH0QXsr8gaYphCXt+Nc3Fs5fStac/XJbOIItCK4HAc5CqYOvJHdfDH4l9KF
 7pxDJtAdzw6oGbvpJulG8F9sTZoWvY/fmOX184eNj/j9DJa+GoSUC6bBHw4tVcmw
 W2y2L3qKLkk4kZSAxfTpbXcK5ldVynCblvKC5F/pqpXGKrOFK1MqVMjqznIqlX9r
 dFxuRjHCgR08q2xZbXm7VMJE4aCn0oVxsY7ueauwNYZU+my1SwcQXJVX2yzCo1V+
 Ixvdaw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh81yc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:45:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939f3426a7cso1235702785a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786731; x=1791391531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QW07VhhHoSKTrTSihMHeFFjAXuxAE1ILkgE/Kf/i6Bg=;
 b=VI/QwmjzO9o8fp46yvwclHktSCtP2aUrwDRXwaJCuH7hmvEk/3ZK43PhiYH1iX4r61
 8Trd2/wI+FmN00mAFbv3qkceLGCDY4nHUtGmf8wuewfg2rvQJK68wedO2VZAPH6YlN75
 M1LwPAoTVWLRvaBhi4YLD45yrt3kANmqwomJ4Ua6+QIXPq/G9su9UXUh3EeXNLoY/5zr
 F4v4R+xhETx3Df0VmeKdpp1p9rzbVD+3iQXmwbFXJdJCDhuI+5J9SJoIAgiv3Qne0G90
 F2mhqZrIrk0Y63F4X0KcsLEK3x8SnPPBDU9a/EQ+OT0pE8qibyVg9BZnpl0sgZoLpvRJ
 KjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786731; x=1791391531;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QW07VhhHoSKTrTSihMHeFFjAXuxAE1ILkgE/Kf/i6Bg=;
 b=lIGN7z9G+F9jYruvPmmDh5QDnM1X0xE7QbDrNALAP1R8ooBhmzv20ZWG0ulIqPb7iC
 Kop/I9fVkQC8O2e7aum88cXQllOJA5IQv+ldkC4/5sGIggM/bhiIdGEtIJyhwFxrT4gJ
 ymGQgQDDf+1vjDRy/5Xk62rfNsWFb5rbwx0h5SnX2xrGzSAuoCfIo2M3WbjidVJcMAS7
 ctxEnPnsVxk6UwXAOwEdoz1OsAc68SMq2j59jLewnH3TLjsUTmjCd+jVtcmVoqTJRk4w
 8RLA9gEEjejy/qVMUpDS0qRIlRHsXeuKc3szQ+ijkSXTpzo3PPF24cpdgWI+Y+o1BN7y
 S2pA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmgYsJ6Q8tniMm5QqCxBaL81EIs9+g8Dctsjnuws6zWEAy2NIDm73fumnl8BiNfofq0dldCQkfpYRC@nongnu.org
X-Gm-Message-State: AFuF++n8fRN8IOFezh1/XeFv3+VMJy54KMlRZbikzGehrbLeicqSBnzW
 8+1+BjbgAJ5hmEuc0GteGMrKsQM+HbcBc9hHyTpx0VrVmnACugsdCxC3r2zhV787AhQ7tazWNfS
 wd1/35rPx9v4ACC6RfZCOxYgZycnXybX24lpJHU7GcybLNmfrLiOuhNvZ8o4AmD+l9A==
X-Gm-Gg: AYBFou2ovA++GuwQCkI+cCRX29xLbh3S+DUwu6A4hJhZoDwybOxocrOM7jAjQLz/O57
 cuLjz38qQQBMsBcohkr4b9GxtL6tO7UtuLJdSE0q7HREoX7EclZa0KdCsmtlTqIWO/P6tUHPuXw
 UtgvBdyzBVd1hNYX3ulMWEtoRq92Rj+WKkJC+Oqp24e4abCYYXqGrKvWQoKJTbG5OufnoSnMdDi
 /JOzBfRpISkJ8l6ek59CPDiTWjeB1dgTdk1Yl5MguZ9u66EWxW5v6aLj+qecnv+IL7yGur9/VJZ
 OO0L8mkVEth03iofH8PdFCBbRwvMqji/mJfCTPhbEbO5i6pyLNjcQkx7nRHQ/1xPbz1Fc2TIvQu
 6qcj73TC5cbHCqVnbRTk=
X-Received: by 2002:a05:620a:8906:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93ca96b71f9mr362679785a.29.1790786730894; 
 Wed, 30 Sep 2026 09:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:8906:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93ca96b71f9mr362671685a.29.1790786730302; 
 Wed, 30 Sep 2026 09:45:30 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b06a360c2sm180025f8f.36.2026.09.30.09.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:45:29 -0700 (PDT)
Message-ID: <eb9fe07c-14da-49d6-9d52-bf0596755091@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/27] hw/usb/dev-smartcard-reader: reject commands for
 invalid slots
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-19-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-19-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX1XaFv7q03iDn
 GYhj+2xOQIIN5gU1QqsZQatZMlpRplBMnyv76vOogbAnJDFivfpaAcwVRBVFN25ttkj51KrqGMN
 7GIW1vRyt/RO5+90waEMh2fAjbpwWqtwxBKjZ/8/Inj1F5/iEhSohuZ/b+6SKBnrE8D1xZPCO+z
 z81pIIZQDLsjzqkjHL9LIzq8ziApoy+B1FYNa6zMkQHr8bp2T2YtN4WCNXXxD8UuZjoGNHBBV5N
 hNYAxYXupa/e8/tTV8MpMz2uNCXnSBJ2dnAUiiR5nN9lAbVjkZhDwsJgJcnT4SbIUkJ2rXmE7w3
 B3D2G5wQWcYtqPL018U+04Jm9AIfIwFcJ4wNButOljc2wWQ7vz1dFrRoOxKPikmFgoRQGy+ve9+
 JmRr5HDHLcfF6Ps1rJEIcp7Hjsn86rnEgy85h2RDeayvDU8UC+t9uIRam79XaVL2GeAu8zZ4jxz
 FqB7F1upA6es3LHFrmg==
X-Proofpoint-ORIG-GUID: RQ_oXJ9sWl267Nsr7RT_vA94ikiq6Hq9
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abd3cab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: RQ_oXJ9sWl267Nsr7RT_vA94ikiq6Hq9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX0qJb/+W+AXxH
 hUZ6U9mW2/jdqCUS0vvOOl3lxQn3iEKuZYF+0wDsgwC3X0s3xb6angrDvvbvSFmRv+O8JKjeqnG
 GQ2LurLRzwMci6vMGTJQgRmMPpCVNiY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300066
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> The descriptor advertises bMaxSlotIndex = 0 (single slot), but
> ccid_handle_bulk_out() never validated bSlot. Commands addressed to
> non-existent slots were silently processed against slot 0 state.
> 
> Reject them with bError = 5 (slot does not exist) per CCID Rev 1.1
> section 6.2.7.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

