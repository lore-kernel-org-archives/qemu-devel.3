Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EE606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mTW0M9X+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VJh2YP6R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlnH-00053P-SJ; Tue, 27 Oct 2026 14:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLll5-00049Y-QD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:19:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlkz-00042q-3L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:18:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHnAk4035960
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CWKa3ZkUD+tYqrklVLTLSYFrglsK1nEv+R+oyJkLZn0=; b=mTW0M9X+AjV7Z2a8
 +4lKNK1ZcnOu2zqI9eWu6ItEYKi/S9H9rOXT3zAYinrn+KO/Bgr7lAidlCeljkkl
 GgpA/bwn9j9srNkGwuhMYruKkhKTS1GkR32Vu3eKcQd/d3bh0mBoAelJYXGOvFra
 xSVqGuOMrOFqnp/jsoq4A0hfwzjKx18OJINwnLkK7iwsybMyb6UOdD/pu9Hv827+
 AAle+1hpzpMwtM/ppivlBJHGIGlC+ST1kuoauF0XIMdQx9do/AoZy3qw/M6zlDTF
 uJKznnFFI3pwyU/bGXg3zPyauTQpIU9ef+yGtsEVIoIUgzF17z7ywwVKJCpuWj70
 g7GoKg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjprfgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:18:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b8c60c550so5384886d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793125123; x=1793729923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWKa3ZkUD+tYqrklVLTLSYFrglsK1nEv+R+oyJkLZn0=;
 b=VJh2YP6RsBCXgCp9szchy8afBwomlqrRZfHX6WItAq2tMiPcv8QJXkV5KUtpb7jzND
 UI73BxsODiuMvsKDd1L2ib3tHW3UAqWxy+73KwLFXU0HJhw/mkPrqjYby4Jr+2NtFxqQ
 qoQlSfr2g8V88FRWdzO9ultxOUagEWhCzVuf8HYR+W/rnV/MTLKU4ogzzi87bhSjRWue
 deiAUpXLHCRV5qsTUwchB5w2QClwZIPjlWFGX0IC2V8c2TpbwPAOoT7WHSSAKF37LW0o
 mg58YNy3XieX1FDBaDYUP7f4W22rkP19FQKr/jASLy7cYOTSdOyqTy/5skIqHbholwYc
 cYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125123; x=1793729923;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWKa3ZkUD+tYqrklVLTLSYFrglsK1nEv+R+oyJkLZn0=;
 b=t0ZfURhnKm/xatkqDDjrcihiGRIZmzjWEGCG+KXFJmJ+sM+m9Yc1h1StI/Gmult3KP
 3ouLWr0lKr1u+zqGerOkNGxUavlFhvn6ASVN15RQxKKvQMGMKgN4slka7i9QSNV+XUh2
 b2zTCw9wNZMswRG9suDir7y3z7p65dkS2vbxKPek4G+yPtqTjCUTq22XIFa7OSwcnC2O
 qhNPXiyRn40Ia0a2wzhk3ukFLMKMD1N7HzKmeR5z16D4bLSTUhqyeHp/HXUOaupa7i19
 QaLqBi550Va7QyDgWUYhs/gxbJ6D+olPz0zr7pp2zWwh/yNTW13NZKNKiEFc7UuEfkK6
 K0DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeUKwD9HLFBuu/nBJQImmcRKzB9IV7uwm4yoUbEOO+FCiRn7OY8iDjcHnGfHRMSpr3ND5tYtXqh7zl@nongnu.org
X-Gm-Message-State: AFq9FYIhJMPkF/7YBHCP2dYkGYLz7L7KWpcDAto+WrS/hU1lGhiQqyfa
 Dvtw4TyPOPApyxjXsXs4XnpLfWLASVWuwXcryTWbfC+vtIpjTOM37tePtWfF373jA/brgN/5Tob
 V4/lCfsddj441lMn8QicLcP4ghFR5Y00XKw3g4llUgKq2WudIMzmGksvfUQ==
X-Gm-Gg: AYBFou1On+7brOhqSPMg2YiBwswdKE3lQuY9vOeY2yA/WdOLEmmZE/0DC2wPwfuk3gg
 X03wfi1pRqnEEYf667VjaXEsx4YQ6NSNE3W4AB2qtKcY+F51dB6cnssmKwVfEOmK7tzWNb80YkX
 sAAu9ltOGIWjvohzliPa8y5slvbEFnXQnnV4M73gB1g8v8S0BC6WPlAj6WSzxV6X40ywmeb1eye
 Fv3L32XEdxL+tgpXwJUoKpTwYmUjaPo6qkN8FWhnrf1gABxYGvpjXuxri67ERbBegv+EIFxBbNI
 qXSqfcJ7+Vw7WbkrzBrEQ3h9xa5ZV9CrDG5YumlK6IJxOeWD/28fyWUj7NAuX+QE12WhDqtr1+c
 yZYsPe7RtA8jYlzQGbpDp14dNCqiR1fp/SMJA5gOS8JZRkbVMUA==
X-Received: by 2002:a05:620a:1991:b0:93f:5717:e7bf with SMTP id
 af79cd13be357-940ef95718fmr1690435985a.46.1793125122571; 
 Tue, 27 Oct 2026 11:18:42 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:93f:5717:e7bf with SMTP id
 af79cd13be357-940ef95718fmr1690432285a.46.1793125122036; 
 Tue, 27 Oct 2026 11:18:42 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39a8sm25253857f8f.11.2026.10.27.11.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:18:41 -0700 (PDT)
Message-ID: <55d79d30-cd7b-4673-8fda-434fd701313e@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:18:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
To: Tommaso Califano <tcalifano@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20261012140839.93559-1-tcalifano@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261012140839.93559-1-tcalifano@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX7A1EN+hx2WN5
 7KE0DnWFqme/ehkSCKb8TeTXHEwWARf+5EuCKFcC3TtPAc9+3B0y1Xgc+yZnkxiqI5Aa9OcFfV0
 IV62orz0LtPETYfdpvoQrGhkslMVm2T0IvAFcSmkrKGyCl2nPw6AtCTESv/IQuoeZnBqy9kSvi4
 eip3IJJ4haUcuAYcA6cpfmxybr/o5E/HlUWDvjtj0Bb8f9Yiu8TksroVJ5JN8eyQsIVYv+bxJJj
 MMFlvhz0uA4uy7QmLNbI1FGrkSGaAulGzPHrDIBgzDZ12EN+bCydZiP04NhCPCPd15NSxL61ROo
 zPId22VbTzvwBgakGOuW7mn/n81DKJ62zZdWHBEzlbwUtPx1wYvcVheHQMXySaY9c0jYDPE6VYK
 HxUDbW36SiLHxqXkvIFYJHdqEMGZ4g045B//m9nldTQKrhKh4keRldKHN5AV45D2bjQFhGPpKb9
 AphDfNg8slHz+qrOg9A==
X-Proofpoint-ORIG-GUID: EupQpBivF6AgxzcZ4yAU1WvaR9BBR61R
X-Proofpoint-GUID: EupQpBivF6AgxzcZ4yAU1WvaR9BBR61R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX8HL2Bm5Sth4P
 lkHeTcnzUsD9CDm5+H11Vqway6mkrB2tEs1f8Da+lXhUFqoAnI9A92yxSCn1Oqh0cH/uP7pvh1a
 FxRKfBR/YMVjXRQRXPx3dNxXBXUchFQ=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae0eb03 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=xEUmHDAGrVqNh_63vmcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 12/10/26 16:08, Tommaso Califano wrote:
> The EP_DATA_IN result path serializes the queued response as a 12
> byte MTP container header followed by one 4 byte word per result
> argument (12 + 4 * argc bytes).  The entry check at the top of the
> function only verifies that the guest-provided transfer buffer holds
> at least the 12 byte header.
> 
> If the queued result carries arguments, e.g. RES_SESSION_ALREADY_OPEN
> which returns the existing session ID, the second usb_packet_copy()
> writes past the end of the guest-declared buffer and trips the
> p->actual_length + bytes <= iov->size assertion, aborting QEMU.  A
> guest can control the transfer size freely, e.g. TBYTES in the qTD
> of an EHCI BULK IN.
> 
> A device must not send more data than the initiator signaled it would
> accept. Stall the transfer instead, and keep the result queued so that
> a subsequent BULK IN with a sufficient buffer size delivers the full
> response.
> 
> Fixes: 840a178c94db ("usb: mtp filesharing")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3386
> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
> ---
>   hw/usb/dev-mtp.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Committed as b17205f23a9a8661394d30148b2c995ffa932019.

