Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86B606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XOwHJDwU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EzsV5iPE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKYhN-0004yI-BE; Sat, 24 Oct 2026 06:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKYhM-0004y2-BJ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:10:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKYhK-0005r2-GP
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:10:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8o1AL819335
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KsWjU7F1NFhVMBPhUYsfzzR2U/03SHKYUuehpvIJtLw=; b=XOwHJDwUD20068s4
 O6hjt8+518Ba43iWIz7yuU80I64Ik+41GfZMGKvjQQcDLcmTntlPG49OM8TbRqN4
 jK1ih6ZPiYCERWNmzAEI6FxyrDmPG/P2IyexE80YeJTmz0xJo7w8dWrUdg9Ie++q
 r19CKmqsXcwpQETB3jfAeuKQeGVG4vXYJybh1m2yzGgciYWW3hca015AvVc+KNzi
 xqaQcMbz4HRzbuGxlSWyGkrtztPStmoK1h9rVq0S2zwvzDKNGVRb9H8MTP+7Y93r
 JZ08blm8FFHelxjGHm8Cw+d/8sI/ORifLlrc4k+FgwcfZsXeWq94gnONpABn9ODN
 I0EdjA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0ggt0t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:09:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93dd3c3badbso419860985a.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792836596; x=1793441396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KsWjU7F1NFhVMBPhUYsfzzR2U/03SHKYUuehpvIJtLw=;
 b=EzsV5iPE8/q4HEpG8/IvbhUbDXQLubB5mDVXGCOZWEspsnQzH5UXYR1mRzAEUrJ3zd
 sRSdftRtD81n0hInZ5s128Els217aBNJPvRY/25AJMbfDfjL7b8IsLdm+fGn92JNiRdy
 33wr6ZT6vmqFYCW2pr1gbLwTvfibEYC9KTWNg/0BSY1bequklJMBwC5irfJ3UjNdkZ0I
 5P7LAERXr3hiE+E2oRiPI9F1zZZGmF9Ujv2IpAUBptD6HlRhA4/sbnNiDCUmCoS7sBlK
 EvgK192/VMw7ltLf+O9dOsNUP3YBrMQiR1KFxl+9vUiwl9dvYTaRPpKeLOdG4p2MQPju
 OjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836596; x=1793441396;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KsWjU7F1NFhVMBPhUYsfzzR2U/03SHKYUuehpvIJtLw=;
 b=dCF1nHmgTVU+yxQ6qeALL9JDpGxHOfH3EXlzCHW+MkI/GxUAq6/GD07m/akBcMy3pV
 5a3AEsSco+nzjA1Qkwygqbbg25IKVsZK1UHg61zjMG39ckescsDRkPsW1y279FZKmQqY
 NpbYo1dvxXsyieNOlcN8uJ1NNMpwLrWKp8ipG43BiKdgJ/jofhaxz0HipPUDl9V+PLVB
 ZqThWsa8RMbYRX79x0xYeT9iZnteJZksrUMTMjo9ijCegVabxz9tm8THzJDvqEmM1dGK
 Pa4rPNs4kk/2IBYFi2scBqJHOwrCETMKRUIQDWtXSRErfKwjQY0r+toeAe2rFh4J1Qhu
 a26g==
X-Forwarded-Encrypted: i=1;
 AKwUvByKJGYcsP6B2Hx2cWfLrOlAtP9hni+7smzMWe5yCp5DUX5XqbcYLrophlVs1jIRpHSncJlqoV9rnKMo@nongnu.org
X-Gm-Message-State: AFq9FYLeveLxz65I6s16iXF4pULKli3AEne6WO6uSXV+EgAhsENE6ECy
 d5EvyjBumfrHIaEaNLyoigfn0b5VaSfSv+2zrNz2952rMnpYn5g/mR3BjYeeVtBpXQ16XELA3o9
 lwKp64ksUsk293KOaPQld09TZEAnNsqlhfFgS3cMeHrv9TfZwVBmd+Q3TNQ==
X-Gm-Gg: AYBFou0jX2vGOxo8o11W2wwd46mYIzZzvoK+xNokhPtQIyKqRfMgi07lUrBuZ4uoROB
 cjhU1Kql+5kYuPWDKt2XGXZ6LIlNFE9zsg9UDLquwrsM+1d4isH1d9+GpbZSQsjxNUI1Dh9eAxy
 HJf0STLu4ROVBP/w7HeS8WSNrV0VOFjTQcqOCm5J/JMBloeETCiS/VJALdNe3fAVBRv1nmyZ+td
 p0hBx35gWcswoLo1oyLRN7da02rw8TaB7PxuvnvrYC+BuPm/wMUeSbM5mh3WSt9+HtJFFKIA+Kp
 mU1WLLD+Yv3NlvVy36raJVUhDdxdeaqK6socNGSC9SUvNk1K8rKntHxkFy/notfbk6Rr6GoqIWe
 Z/vYblp8DN3zRJdFR3gQZax87/Rt7Cc25hg==
X-Received: by 2002:a05:620a:3715:b0:93e:ee21:70ec with SMTP id
 af79cd13be357-940ef9e6f89mr209858785a.80.1792836596007; 
 Sat, 24 Oct 2026 03:09:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3715:b0:93e:ee21:70ec with SMTP id
 af79cd13be357-940ef9e6f89mr209856585a.80.1792836595551; 
 Sat, 24 Oct 2026 03:09:55 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm83302625e9.0.2026.10.24.03.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 03:09:54 -0700 (PDT)
Message-ID: <b5c44bcc-6642-4f64-8e76-bea11f05bdec@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 12:09:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/cadence_gem: Check guest-provided queue numbers in
 screening registers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowangio@gmail.com>
References: <20261023153106.1710228-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261023153106.1710228-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _tFPmj16ppV9XAwkeqy0ME4to5MJlIWA
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adc83f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=QGRAimw5JShAxdOTMG4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _tFPmj16ppV9XAwkeqy0ME4to5MJlIWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MCBTYWx0ZWRfX9rADfiZFuSnp
 SFTqTCRyNILHXfOFrf7EOubfexCkG8YwQuTG51/kxtqvHQgSPgUE5ILfxi+jfC4ftMBv4yJ70Jq
 HiiHJ4x7bknLqqYf9lLzdViTlZPxA5NkhoH9FPphMl3MJ7z2Q3WIP/kojwjxgpb871rTqUcHdQY
 d3RpGq/6QRLpNscAUEN9uz08RamreXTcSXBz0XDbo8kvJNiXSiHKX5xFaI1d7EFMMVMKlo1P75D
 SRYlrZqfWsMTJiQCJjOF9O55bGd9FpeQyBV9SvWgNZFYRltesn/WQf+0j2V44P76xkCB+kh6TBn
 tVhXrymBq8NWBdgnvXZ+jkIl968Mod6w4mosvndiAVdVm5SXE3ryTZqW6E5XfDkwMs9gZ2VmsUz
 DEERh6VdfoS70RDtrCM8wKhBLe7Fb+SOUk76pfJgzsYgzahmOS1WUI3gip6CiuFn6vbB+8Hue9R
 /aaAXz3C6dxQWg3QUgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MCBTYWx0ZWRfX7JZUszujSfSv
 uDIQ9j90F9h5NGkPE9m03g9Ej+QZQIasKiZvUt2P9CaylZWb2xeI/Bjbmql6kvFKihMRoMx+f2I
 scy1/s9aVxKmFDtIMs6psyL6ydpv6VM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240040
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 17:31, Peter Maydell wrote:
> The Cadence GEM allows the guest to program "screening registers"
> which control which queue received network data should be sent to.
> The field for the queue number in these registers is 4 bits, but the
> device might not actually have that many queues.  We weren't checking
> this, which meant the guest could program a value that caused us to
> index off the end of various arrays.
> 
> Check against num_priority_queues, and treat out-of-range values
> as if the screen didn't match (i.e. go to queue 0). (This is a
> best guess at reasonable behaviour since I don't have access to
> a datasheet for this device.)
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e8e4994313b7 ("cadence_gem: Add support for screening")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4363
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/cadence_gem.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

