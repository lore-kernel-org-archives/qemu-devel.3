Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17FAC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjLF-0005fA-Uc; Sun, 27 Sep 2026 03:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjKj-0005Kx-2u
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:30:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjKg-0005tV-V4
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:30:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R0UOh22352219
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g21CMGMQYon1MnxNWkDMC2ijemIwzgaYkcd/tJ/Tan4=; b=fcctqHfNPEQd8UxX
 IzkpHXgZ0sRRnXzHQqOslGVyxhgIxcRgYTPA9YnE0vVc1sPudhIdHHz9LV3BsjXf
 j16HfculFUWazbl+lmYpUW7zDWfbQDATOIZ7mU4joBJ5z0p/uwAFbxQkhBBLnPK8
 OgiXqY0cxkEElv0nlZbfXjzkXtaED9WFnrCv6qu2F6Irl1bpxIJZk/8uJeXzjW1x
 736j0Bk5VVFMH250G6OQhugAr0PaYHEFVSS5ZG9OHmuu05OBdkxdTRt0bRgySK8t
 vbSDAaXT/2FXqn60f8TEAw7xKy5usRNTJW8s2/Ceq7iIwqxB9DE/CFiEU/pyQCoH
 n/ZysA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rftt8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:29:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a05d645acso453560785a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494196; x=1791098996; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g21CMGMQYon1MnxNWkDMC2ijemIwzgaYkcd/tJ/Tan4=;
 b=hZfsDtw4qKk3LQKFCH1SRuYYANZIMBRXpKHTFEOgnhrZ7A7dC/aHVZ5Q5fSVgLlFKd
 fjbveUYpsGYzsnQz5SbvzBwUvTYE+GzuJckdKsRaAyDj/Lzx4aqgVvG3hiw2qqsPhj4X
 vMRW/5F1zfpT95taNg3Ma8/JXXoFN/eRIZHwgUOeXT89hVFmEBoRpg+fZwc/dDbx3vPE
 D7r+Tmkr9Nxq2QyForNF4zLA6/uOfetnmQcDiE6DzWKjn4UujhS59g2p/bXuZ0sNrpKf
 zkx00YSDc0bQkNpVjVcHD5Lvcr2Gk9yFkyvu2WUWCJXb+4jRZSGKp7PEXWdNqFOD412m
 dr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494196; x=1791098996;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g21CMGMQYon1MnxNWkDMC2ijemIwzgaYkcd/tJ/Tan4=;
 b=tKn1OYQjd2iBGndku+9CGynGs4HKM4neYIPaMFuCJzlXeUJIdYpRKemxFCD2byR3bW
 9gTwKEeKVC4L4Yr5B5wQMB/hBYjOpmsQzXcngUEJy+piS2sv8iV61ih6Uh+38pdWjbOB
 0/Cdm9+2T4Gl94U4Tl3//hOc2z1SG6KnbDju435pQw74rwfslUl5oLRRxdoewvwzhTGS
 HHL/hchz0bIS/8R89gcBIQOhve0LYNW1w4vv7MrchhKAAgbYyIC4TvR+LKFyhQoQRUdO
 Bfa6Ql1xm17dzkHlFmJdXSCSJfR7n+dRJKCQb3NsRuzkZ0V/l8hhUOa3ycQsauZzDO3s
 ctHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR7hkdy9KOJ+dfxOSU3XWdwxyMyB2hMw/RpW/+gRQ1taGMjcEEpBosqauQ67Bl/lUEsOwloS4N8/sC@nongnu.org
X-Gm-Message-State: AFuF++m4OwH4idiL/qIDet0M5mcchZ92ZSUVhV+2UAPzFawBXdnEH5dB
 UsdGidHgf86UO2ZvUX+s+xrXtk/s9aB8oafp1itnrNzmmalCg6w3vM0XLa5rWNQMegmOQdVXory
 Gk68Q1UTeDapCjzfp56NN2l2HHLN+HoWzBYdgGDl1WfZGR8I+/zVHtqo6yQ==
X-Gm-Gg: AYBFou2ZAdmXkqxGjfS+kIQULQBk9eC1MS324VuBJvnKyJirqG7Q7sd+dkxgUPtSgGs
 6yP7EJiSa3dvj9FV7w94mq/5f8onEUmYUVnfWNrjipDjUJMBlooxgcfP8egGcj1jIPb/8OLH4lG
 kOgDq7tq8ld1KVYIpakVgmDxb7GdgObC7LkKfKeaCr8Rf/Kv2UEwS0y7lgsSoS2ZZQrNYUp/Oob
 xuhVKnR9kQ6CrAMKZUiww1P1gZzrXjLTQbaupLTQIj/0Io4IGw7Pc6broZFOiOOwFHyQVCUi/Vk
 AjW1KaVHfXQLGBobUKgVUXYOu/6BooSCcRumGXHAoZeWWpK+64IjnZZBm8InVHL4pdxwpbFGpCX
 +Xzb2PdQH1mV28j028FQ/0+BAFOpMFI1R8A==
X-Received: by 2002:a05:620a:8810:b0:939:c303:c54a with SMTP id
 af79cd13be357-93c43c9db58mr1435862985a.31.1790494196511; 
 Sun, 27 Sep 2026 00:29:56 -0700 (PDT)
X-Received: by 2002:a05:620a:8810:b0:939:c303:c54a with SMTP id
 af79cd13be357-93c43c9db58mr1435861085a.31.1790494196099; 
 Sun, 27 Sep 2026 00:29:56 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm17387846f8f.5.2026.09.27.00.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 00:29:55 -0700 (PDT)
Message-ID: <d5d4bdc6-7b91-496c-bcf5-43ba95901851@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 09:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Anisa Su as a reviewer for CXL
Content-Language: en-US
To: Anisa Su <anisa.su887@gmail.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jic23@kernel.org, mst@redhat.com, junjie.cao@intel.com, dave@stgolabs.net, 
 Anisa Su <anisa.su@samsung.com>
References: <20260916002143.777233-1-anisa.su@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260916002143.777233-1-anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX2KXec7HC1/2O
 tpv/Hn+hP4sTXlcwYELp7qEakTGwk6eJy0FK4xOUCDJTkbSuhFaX11y06m50bjHyKVkMnNbFdeV
 d23qDdracWDKPuIchLzzml2F2Ykt1EM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX7m0qSRMpjubv
 Gqu8LdzL+9wJqDOwZ2JHDxstpxV5xte8cs+SlhGDJda6UM2yKMqWSSsKBR3wxMA2+sXd1E5/27i
 Rrz7PxyqAm0Tc8UdaFGTYq3dZa3kSOyDpQiCdraSIYKVO3MiGC/vl1tsDV120Uyov+gcHpHIZ4C
 1qRVtqF6/HB/o8soYxIsVkNcVe4ZszfFOeJaebpbsdy/836t8gps5jHdIp/q4wl8wdX+x/EfA3x
 MJ2y1hhJpUzBbjZ0eYFrMUBSHYgfDpmPp7bcr6wlv9KtTZMEh8AsXgCnKIUAUKyN3P9rdKu7i98
 7sS/pXHltYSp4sTurgwh1pEcdWN9NMEK8DY5hMousBTgxGVDtclhvwguziI+g3hpcDtMAJeTyDz
 3hSNE5uYCnckncWChitTZJctM0ygdezSMd6TiAnkN6hsby26l3hF2wCTkXGsa09kb8zsgqabD1s
 0bs7gdEfXF2+11XivXw==
X-Proofpoint-GUID: uxkeYAox2yjsI9elh_5cdWXGow5WfRYn
X-Proofpoint-ORIG-GUID: uxkeYAox2yjsI9elh_5cdWXGow5WfRYn
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab8c5f5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=R4ayLD03AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=TBQXfmAMVPWdF26Y8UUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=qJlm0-shE6CLU_iKUWNr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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

On 16/9/26 02:21, Anisa Su wrote:
> I contributed the FMAPI DCD mailbox command support in hw/cxl and also
> work on the Linux driver side, which is developed and tested against QEMU's
> CXL emulation, so I would like to be Cc'd on incoming CXL changes to help
> with review.
> 
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued, thanks!

