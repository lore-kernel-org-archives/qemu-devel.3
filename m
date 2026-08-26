Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF216C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHo4-0005Kg-1S; Wed, 26 Aug 2026 13:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHny-0005KG-AC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:52:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHnw-0007RQ-PP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:52:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGug4S1408692
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3ZFnouwX3FeHX981DHV20pw95vy7v0qATaY7XyJTQkg=; b=OTpVgYj2WCLRGpaw
 GI7fDWgJ222WshYki83Xv39pMP521SIbKsz1aC3RoQskgeZc3sNF5PovvvMj+RwS
 7K92QPUTgyouzRLKKXrmKcYh4gNnUVDMF548NQBKljcrdvX7OufINx47bK9EYpIy
 omhKV9/4FhE776CV0OTRHSYH19sOHxRbtmnlDL8o+huoLsM3EzcoQ7G+zGIkZLLD
 IatGdVL4zvzeVdc2NA4jFaXu96WZ5abTwzH8Rehmx7qx4P10k4fyswPtM6rhbYb/
 KtWaS7ErgnxfDwpgWxA0D2Yoa+o5MytASe3DYZSvv/oPseJXin1KixAyBCgGBmRg
 KdtKTg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9x2n1u40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:52:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ef04756caso6580441cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787766770; x=1788371570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3ZFnouwX3FeHX981DHV20pw95vy7v0qATaY7XyJTQkg=;
 b=JaKdQWCV1N2HywibHwrp3RhQrCzKUG7/jcfS26TCICSJUn60G6N2E268gjes7jSD5F
 J2ZtBFHRK59goIX/iNA+HqYf2h0KBjb6xlldQ6On0sc3hyJTdJeyLrYZZGWiZXAeW0W5
 RZpLmlBsFK5v+w8AWSGTMoz/AV1U1s/DUXeQ8sfMT4hf5tByz7JI7AxrLi3PWxyTBd2s
 XwrNL2TP8+QNBaXDT7RjrkMjd+NsxhMtVHy3y1qQFb/WT7iGBm/rrZJOKwlWfclld9aL
 e997RkgOmukquiAHpusAgUqb+lmqqNEhTo1rQa7D0N1DG8FGv7F/E45dCbwEy1igw3/3
 CQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766770; x=1788371570;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ZFnouwX3FeHX981DHV20pw95vy7v0qATaY7XyJTQkg=;
 b=Y2xyIRFRex5J9g513DY5xuSWbAZm6ZDAZzjLpm+P5+CEK8bskBg+3dv3gAr307yvgl
 4QL/FOy3HOvBzWgThkdYf63ftQbFD6Qli1M6Qcewrwt0xYECkAT1LS+4zUywg5Jm9kLg
 DTk4EgdlOespnZHAPRBqOjyLo3SFQCfNOzv7+h9T97ZINGtxwj3uuvZXELZqewY0acTw
 NB1c5KFg8FVO4BcJPeKZEIoRTKlbMwQyW0nTlQw7Ggtjv7MFTv93NfRW/LCvTQH/K+Ef
 E1ZqWxrfm5BPmSpFX2A77JWyJfZhJy90KEaxCFbZ3kSiFM82sRy9iwhPwoijZukBljkT
 C8iA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqbavgJstIbMYA1bsEWQd4czxeAMQ5fNJLkr0rgJzWsVA9yHLnm24mhNlMCrY2BfbFLQzlqNzUGqII@nongnu.org
X-Gm-Message-State: AFuF++myru0BorUSHmjDv52QzyTe9u945OXMjbTIfay0N5C3yxSNFaPV
 k1hmGveKQwujSQP71mbXk06mneQEGE7UEkKJxyDpRtaNrgOUq1DbykQoUBY2CRoSFT+bKyOzRjR
 15+QRZyk0Ek++Cnl/WCXy+1HirQEC2vuiB3p007sACn8dovn7RiwmoLuqbPy36BCvSA==
X-Gm-Gg: AR+sD101l4M2NyUl4CJYFBLm0xMSgyhg1sODOl0yTaQa8/jzN1U7KjRzeMWxpa6AOnv
 hWiZvV9HjRQeyANBm50N6xWlYFWYK28SV8k5bkbEmmM4Q6TUG/lUwSVNV1jHjf5htoH9mQX7ZIc
 Ozkn+VoUI0RzvOCV7NpFQntHtowKzuFk7rvwhNxv8tiQT+4plFEYnosMHTe5Z4wTZGF1EhmqHjM
 eHuFWzFc7srdig+xk0/7A3lUyZWl+6YqWScvQ//u4bNas4sQ9abUWRanIIvoZ1xV/t01/6ONCBU
 t4+lq/t2sKsJXlZg86tERQBXyC8cDMJj3kFp55tlPGB7uxW3Q5v8PIC/NCOqfCC5ts1umlqfDTf
 /7cCTtgFKj3USlTpD4O3zpNjqHUEO+kHpY4tn7df4+Plh
X-Received: by 2002:a05:622a:ab05:20b0:52f:a042:d77 with SMTP id
 d75a77b69052e-52fa0420f96mr16405191cf.35.1787766770519; 
 Wed, 26 Aug 2026 10:52:50 -0700 (PDT)
X-Received: by 2002:a05:622a:ab05:20b0:52f:a042:d77 with SMTP id
 d75a77b69052e-52fa0420f96mr16404691cf.35.1787766769923; 
 Wed, 26 Aug 2026 10:52:49 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b3cf9sm457721766b.50.2026.08.26.10.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:52:48 -0700 (PDT)
Message-ID: <4a7e8220-0ba6-43cc-9305-b276c66e08d0@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 47/49] monitor: move HMP-specific to
 monitor-hmp-internal.h
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-47-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-47-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TtYmVWPrL2zi_nkgHv6Weo9H0n15wbsm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX1RujPNr8F6o7
 x/yOLx7tHG2lO0IzDNx35LcVTSLyouTAMaRS9QP5saySEw92ila1rxK1fHocH19IOgLwrBsu+4f
 2ipLpMXVKkoYYaQ2VsbIeD5nnHYeG6E=
X-Proofpoint-GUID: TtYmVWPrL2zi_nkgHv6Weo9H0n15wbsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX6re+mDBXMx3g
 BLNMhxkfEr7ADJpJUy3FNCdCAl/1RqOsp1ikJP/E9QEfOFwHv5IDHM6qcfw4UHu9OPgwMvkylYe
 Hf6s6L/0Yo3AR4q6jtDGYDJ6yErH88mtTqIi/To/XBg/tgAFeCb2kembOqqV8MzpH9QtmheZLTV
 PQAbULmX6eKt9FKo3XOsggwQwzadHxrj17IpJijaatIIoD/94T46CT0FA22tcwLdgqQVyWO31Kh
 Ytoe6Ut15QNEtxvhOIofVWNviw/1q/TQs9FCKIH/F6bFrErFZT3XuAuwnWdVqMei7VChgZRmrAN
 Hq7gOUciMqUmIv5iM/xB92slbCA6PujEkD1DwTDCCYVMz+dZyATPmMj95Necfi4Rq74EjsiED4F
 vMlaco4urAsi+CIm2BcgYounbixZC3zyFDc010AQ0odPHC56xQI5bdm8nBAhasWIvEGvW0c7MGk
 oMFGOZ9yQvWui9Jin4w==
X-Authority-Analysis: v=2.4 cv=PPQ/P/qC c=1 sm=1 tr=0 ts=6a8f27f3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=3WJfbomfAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260149
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Move HMP-specific declarations to its own CONFIG_HMP guarded header.
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/monitor/hmp.h          |   8 +++-
>   migration/migration-hmp-cmds.c |   1 +
>   monitor/hmp-cmds.c             |   1 +
>   monitor/hmp.c                  |   1 +
>   monitor/monitor-hmp-internal.h | 106 +++++++++++++++++++++++++++++++++++++++++
>   monitor/monitor-internal.h     |  99 --------------------------------------
>   monitor/monitor.c              |   1 +
>   monitor/qmp-cmds.c             |   1 +
>   stubs/monitor-core.c           |   2 +
>   stubs/monitor-internal.c       |   2 +
>   tests/unit/test-util-sockets.c |   2 -
>   tools/qemu-vnc/stubs.c         |   6 ---
>   12 files changed, 121 insertions(+), 109 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

