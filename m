Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3355CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWmq-0000y2-Aq; Tue, 29 Sep 2026 08:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWmo-0000xH-W3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:18:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWmn-00031A-B8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:18:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCE6XI931794
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LvKM/QyFtp1Ft8C+tGxPBpb190hTI/twWC24joPLB5c=; b=b9WX6/W6nvq03j66
 RetUVuUKXyhxPz/sf+fod0NCJ8vUdyZ4vYNgLZZIRSVpC9FBZ2gQwWwJbZGSj0Uc
 lkneJCkyJFpuG6OXU9A41e8pXbjiapKgnphYBael8jP5+xY76w5TVoDbgYDBLrsb
 gis4eTJXzCzTOlKoxbTkqfNAX8Lw+en49zh+9kohMHjghDnLybUZF05wRVYTtA9n
 NCxeI9lArjSSQtKX+fq+uVZ1i7NWJeEHcsSAXdGytvp8cqV0CNfjyKo47miceWBl
 yijgLO11b7zYvWy9en5PuVCad1iBackTjSD2ymIWWrfwxuFb0vGNTWW2S6dAym96
 oWjHEQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxhw8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:18:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936708f129aso839166885a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684296; x=1791289096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LvKM/QyFtp1Ft8C+tGxPBpb190hTI/twWC24joPLB5c=;
 b=OnmIhHu9rUP/KUQ2ol3IxuEC0gZJNB1NUEuveiKQi09DofxAKFAuQBqJK0FkKTdUXM
 sL552J9gQE0piNI701TF4PUseAeOZ2ogTu6GDif0nXUf7w2Y+uphzWwt5uhnqGlDGNPO
 WPRmbE++kBo2hWbujWZvgNiWEfY+/k9Bjp2b/+b5YAU/6v5QrMqvne/LMLrunqB5OcUd
 3gmUGK27/bcDwsmMiVfJAP9+utnAdT2cd8K08PYqnaSFjGJ1SSQwTCCx8UzAIGP/DPoS
 /ufoHdlhQnS+vKj0JJlyDwy6VrnkDi4sKoOY8A1vTEMa/rYo1nN75oMay3PVk5oYxYtn
 W3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684296; x=1791289096;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LvKM/QyFtp1Ft8C+tGxPBpb190hTI/twWC24joPLB5c=;
 b=VjgXxgE6AouGG9UCVpwuiQp1Tar0FaVd4SEFFRWc2XJjZHYMZCesouRzl/QHoWhwLV
 gQzEuwH306pyeTAEx7Cl8oadROuhmfcZGUhRe8yGLsELAzVpD80YErF62UFDzVaKDBZm
 ehPn+eXTNnixnwaiVK3m0+bj1SpwRovhSMqQfs/1y7q+dJ11AxTkIbPVPboeLp25Su+H
 zCvHEfL+em50jD0Z3Codrkep6Ie3CWxO7pGPBymadTocVgEOIqb/AKlCdZgqMIL5+kg0
 efrfOts60PLnHlE7y3XO3iLiEpNut1Bz9nzzT8KV9ouiSSyLl6QrP1kCSvyAFpMCU37x
 5GVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL9J66RIcR0h6ngvzuGaZD2M/qxaBg5J5cMVhKouYeezvHSCddGuWgqZxGfZBhXctUVoyqAzFTiBlI@nongnu.org
X-Gm-Message-State: AFuF++lOA2w8rfGlzOot1GbRYSrnyy4k2cFg1D9huPV2KPSYE/ij3npX
 kGN1VKq1kZARkZs9u7uH2H7K9H458EFj1a8CFw3f9u8hdRvOL8yll9SAo973UtWV9ldXN4AzuOs
 D8N4ZQHWtNZx1oo9J/BCO9Hb5jImcn9AtGNqyHAeY1B6RSNfXv0ensT+aHQ==
X-Gm-Gg: AYBFou3sl3MYJkBhCXi4PO/O3BL2iQ2Ysod6NGTMFzXnfvopjQzAp2HY2E1S+cuZxSF
 becVXLrM2iZJFW/pgt/aYaeupZLZljvUGVMMbIDeottK0dEOt+5q6A/Pmwask89JuCKYUfaUzBE
 BbM/LV0t/3IDmWuRf0K+HSaep+dRWYFxIgGWeZje7WvdiqQqFbpehXU/1XNW/pr91zFuhK46Wyv
 Y+WtsenkJt5q3Oglu/jQTb58ZaFX117Tm5Pp9gCEIsjI9mtxlrdu19IW0Sl+/jEFHKwXjHzGrsv
 nHRwBsgx7sHjNTFEbveftjdvgfedQTqh8vS1Z3vj2TeoWii1BLOu2d7U5ZZNPU1CfQoQWCOVd0S
 sszl+q7QIKzIsLCfghKpOdAuFegx4LqFCig==
X-Received: by 2002:a05:620a:44d1:b0:93c:5d68:113 with SMTP id
 af79cd13be357-93c5d6838bbmr1919607585a.14.1790684295502; 
 Tue, 29 Sep 2026 05:18:15 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:93c:5d68:113 with SMTP id
 af79cd13be357-93c5d6838bbmr1919601085a.14.1790684294991; 
 Tue, 29 Sep 2026 05:18:14 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d0f66cfsm85998035e9.14.2026.09.29.05.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:18:14 -0700 (PDT)
Message-ID: <573edec1-1554-46c1-bdcc-cf70da590f15@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/42] hw/timer/imx_gpt: Wire clock control module via
 link property
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-17-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-17-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXzpXj2/0rvGZ+
 EAxVPn5DuzHHUh0FWxlD6eLJqL5NXP9T149Z/f9abQctFaB/5MM+fCZcw9jfP38frJpYjYe3biN
 jDXltn8dpgRD2L4xfTvvgEOS3LERbGU=
X-Proofpoint-GUID: XVAROTmfli15qA3ZqItgfr1HHhBE1iKp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX27rOgha1bMob
 Yw/ZNBeDgEbuYMjsQ4riodQMPyy5AVlqPAGnpdqG0ctnXNmhwFrM+6OrJIzHOKEZpjwWdhT7vj1
 DF8PCdwKIDSgLw/vC6vOttuPgQ/LBMpadyiW7kYSFeTlWQMex6ck5Rp49pchcEVzVvGlRfhniTG
 sBKB0b/AFU0FNrw2irlKmNwNRzHs0X999Z7HT+HRcnbqPxteRKPWYKV5aKGrJJ99/0769AfKyeq
 qBfMJriuGk+gnv5tAGW5p+/PTuiHpydjDwEW5QU5jq31Dk3jkN8O+nqqOkgFaqR22B4PzvL+YMJ
 DsYQckaYqF4/25qGVazbDFGVUF1iD+kjw/VRpbZhVSAqvcHKuqb27AoKy9d6T/nIC3Vn6Q9z+pN
 bEKJFpE9/qNSQXk9+JatyWWsU9puxZF6zKJ2E2b99dm/phXHLFK6mxhW78nZ5qtcROTWIjAW94H
 r19Eyf1ZPh7OMevkxYA==
X-Proofpoint-ORIG-GUID: XVAROTmfli15qA3ZqItgfr1HHhBE1iKp
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abbac88 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=3vsBvid6nmlQ9tsTqnQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> When wiring struct IMXGPTState to the clock control module, it is
> currently necessary to reach into its private data. Moreover, when
> forgetting to wire the clock control module, QEMU will crash after the
> guest has already started. Fix both by letting struct IMXGPTState
> expose a link property which is checked at realize time.
> 
> Inspired-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/fsl-imx25.c  |  3 ++-
>   hw/arm/fsl-imx31.c  |  3 ++-
>   hw/arm/fsl-imx6.c   |  3 ++-
>   hw/arm/fsl-imx6ul.c |  3 ++-
>   hw/arm/fsl-imx7.c   |  3 ++-
>   hw/arm/fsl-imx8mm.c |  3 ++-
>   hw/arm/fsl-imx8mp.c |  3 ++-
>   hw/timer/imx_gpt.c  | 14 ++++++++++++++
>   8 files changed, 28 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

