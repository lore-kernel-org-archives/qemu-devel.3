Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6B8C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KZu-00085c-K0; Tue, 01 Sep 2026 05:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1KZq-00084S-Rh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:14:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1KZp-0001Ij-2r
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:14:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179RdC2322004
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oPvVOG2O21eWzUxlo+QV69kWTdkOgpHI6HwmNasH4qE=; b=MEUD4lCRax/vuoC2
 1TefTVWqpQJSZpovEcf2weQ8CMwCZJKDAdajovRHRO0bf8UCb/zPvChl+Yn0vHb9
 eDJ30Ws/dXjcvhrEhChPLR24XjlmGWhcnVFtVSwO2R0/w0ABHQ5vWji8X6Ff0bj9
 A4wQJs6OiJxqqDph3gb1Kc6ckFu4r+wp7693bScnMnojK9gg7t8Plb6Vu17pssv7
 IV07BS0YBKMOWls1BhkIROO0+rCdGLRZTsW2n8PELySnXVl4cet1dzFBpn1wVZTI
 AfnKdwCxnz1NaGf43IOnK8za6zDFY/cQ9gSLN93GECfhUYN8eEgdH9iAYCpQCW4v
 G+NpOg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdfchb5eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:14:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so140040285a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788254083; x=1788858883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oPvVOG2O21eWzUxlo+QV69kWTdkOgpHI6HwmNasH4qE=;
 b=Bkh53cnXzuR7ijvpj3aXNMJthXVIET9rAcHCbVjey2ffs6nvLMPehJD7jm9V4xjua6
 fsNAdSc9StxOPLajb/18s2ZtK6A/ECDyn4hbfGjy3FH6nOE/od4v0w+EBXiKk58rea+W
 8hHrnaL1Vtr8h7id1amkAseMnnuIl3qeMimJ+g/RSDUvxXT/ts0ZGKDgvegBmiQH63Ni
 VrWePULHJo5yULocLGmkpW5F5BSROldPgiz9IP0zvFGJBTrpJHKdfbKvn0zStmvenVXE
 NH4Yiy8MDlcMxLgBQxCl1u/QFXdNRDJX9tjkJZ0URt7/aOdAsIYi9D+PNeO4RyXKItTf
 1Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788254083; x=1788858883;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oPvVOG2O21eWzUxlo+QV69kWTdkOgpHI6HwmNasH4qE=;
 b=n6F6o9YLzvM8Yx0r2wgFMiCTftVyDLbRJyYnFDmo6segdfVCPMF2yeAatUsw4GWjWk
 wEMr19/NHcTn1Abm6EK58iFeSMKTY5AlcfbzconUrThtqL+yXPRaUe29Q0IapNXj9vnK
 1nEN/StFoK73fpZpxLvMWAgEHZhufFNnhJ3f+EVHs7ofbS0cODY7lilBraKjJFPT/96p
 epPjlSLTaq5+yXRrTXoHdecR4ksSjcxpt/udkGnPCyR/R1Y8zmN2vbrIECGGon8u3r7L
 FY2ORA/ZUsjI10nqeOH0tuT36KCbA49QnQqCzcbj2mlrW8ntGG9Nw/lMSh9EFN0mz8Xo
 vzpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RprwkZIg1yT9juGSYSW2ypia7NXxXUSi/u9FwXblbwq/tuES0QDJwdVsFgNAP3SpvGINgFCbHbydbDW@nongnu.org
X-Gm-Message-State: AFuF++mIilhlPxEvdjSBkymf+2u9ti5YyyuZYOW0NX8/V4yOlfswN27o
 AG3J3EaDTmmV6bm6wZE41AtcpK9kOSldGslR90mVYfzVVX5D3jX+OTpx4N5Hlm6cEgzYJZsER8X
 kEnjTTfsBWZz4FmC2mE79X+sVunKYZHcxhWiXG1Mz4AC0Hb74X1mKCrAt/Q==
X-Gm-Gg: AR+sD11wgpZIGPmQKFYfPwSvfpvBp4d4aEV8XvohGZMxHeO8NZlK8zsH2BMDFRqUyho
 QSaAX9FuqfPXotI+EoZzLpaNPxRah1D0xzHgWRxr2+v3P/ptu8yf5NHJmsQ00J7JApAip35mrzi
 NeCtxC9RN7kNu9pZ3Uwg2vNEJ05SJAdxMVYWc58E/0hpGk6VaEVj9rCcbg5zdqSUIT8oidI51zW
 pKMduAtX6xlBWPk7SzQpHNd5Zqpzwjrd2uKL31RaZ0AdNT8waHo7GiZCcs0MyxdfMr4dffz/62g
 DW90r9PyMU47BCYFOGmqSuTJlPy6hFaODYx7ldQeSJRFCv+8OZOsTjYj86V2zb+ZqYOHqsmjZzf
 IQjqVR4MaEYWWKVjeebnmPvJLddjxD6ZZwQ==
X-Received: by 2002:a05:620a:bc5:b0:939:28b6:86dc with SMTP id
 af79cd13be357-9394bcff0f4mr388403785a.17.1788254082944; 
 Tue, 01 Sep 2026 02:14:42 -0700 (PDT)
X-Received: by 2002:a05:620a:bc5:b0:939:28b6:86dc with SMTP id
 af79cd13be357-9394bcff0f4mr388399485a.17.1788254082540; 
 Tue, 01 Sep 2026 02:14:42 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce44ea9sm50584755e9.14.2026.09.01.02.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 02:14:41 -0700 (PDT)
Message-ID: <1bed0f87-6714-4c04-8d4d-5d54d96c5008@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:14:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] hw/i386/pc.c: convert rtc-time object prop to a
 class prop
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, mtosatti@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
 <20260828150313.1883999-6-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828150313.1883999-6-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eg6e5f7qkR5131FX3PDKfhfV_poc42yA
X-Authority-Analysis: v=2.4 cv=G9Ms1dk5 c=1 sm=1 tr=0 ts=6a969783 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: eg6e5f7qkR5131FX3PDKfhfV_poc42yA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX2dB2aUVqDlZh
 fu9fsZxe2ahLd/4BumfV8AtkSE/lwV3v5cIJ/MofTEy/XZglTVXytxnJ5dzlegVrKHHVt4OX//4
 g1XCkRMJhVBTIrSxbvfpytr/DVGp3Hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX05k7nvYTTNBd
 dAu4CXLOcf37l1KtQGMU27jgjyJ76PbDDGtXMTVbB8UZuX2qq5Ysqr7jWJy1DqXJSlXNMCmPBYJ
 9GvpPkhtUSqHTE4nK57MsLA6QVebdONHo4auHRVuQl4tCVDSV/NEdvORRl7Lvs0gi+5d+RS1z55
 nYDqwjcOv8KcNxurSh6eKDYqylGncUahI1CIyZAo6ZvroD+a724wFQELzmZskaBI+xJtAoXUiq1
 03tgKzwQKtUMYswV+vbod2aQa+IO2hFMKydcKc/Okqt8y0dvTKshH4js6SdNqymcJdLyCnbaddh
 LCettImt3az0zu9PGceoCX724HjHEJDcSX8FmI4RhBTQE4lz5IVFoLsIMw3G2vmNwb5lNimpohz
 lGSthpqpUWhOR/DkvMtRKLxVBZ/rV2RWa+7x02qekzP8LEsKjifv/8VpRaZBv5xJkH1uap5NKyg
 KdPDj8TtvlF82FrIu3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010081
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

On 28/8/26 17:02, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/hw/i386/pc.h | 1 +
>   hw/i386/pc.c         | 7 +++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

