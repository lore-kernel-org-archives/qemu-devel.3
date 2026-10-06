Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C9CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEM17-0001Gn-K9; Wed, 07 Oct 2026 03:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEGUr-0004BE-L7
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:31:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEGUZ-0007Fo-K1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:30:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966e0qa094679
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 49cVrfGDUVWaq11Mcwd+Ez2kORiWWyIln2OfkCT6pzY=; b=oP7WTqxiC35zXZAy
 RtmxVvwmzYkZYnqfS73jtAxcJGqLCwC8WuNNsi74UCN2RNCX9o/LdzvyEwfPiUhX
 TG4luKy0X3m+y0nEYLdNe1QlwnOje42rw/kV+CjMtdl87AiYCOlLqhM95GhQ7106
 KkNfQCQFuskfkKBInWuH5dUYXtn7aTZzNWEB4WlXH8Q2oT/2+eDZrA9LT8YoyHBl
 WGptAyjOfnYM4WIHkz+R/GEi0L6rrWjD9zto5tO3Q5ZWQVNLSpa/XNUYSXuhFJYF
 4EfMK6zz1+Dku18FofYae9a+iK/qL9W87pyTyAAhRIPfMeoMMGpDu4sqvzE32lzK
 dqRa6g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3jxn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:27:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb71b1443so495184285a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278873; x=1791883673; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=49cVrfGDUVWaq11Mcwd+Ez2kORiWWyIln2OfkCT6pzY=;
 b=fCpdIzoTemLX4ibYeQuWKcNV6lNl1tYNeX2AC9goKiS2Z5F/7EMQuaa7hfulL1FHct
 WQCdUgGcBrRTeeUzl+hvpUA5W4UCchFwp6J/iHzSzE3DH0eFjZClok0yjE6IcPW3slIj
 rmwtZYsBjSOf/6BzmQKOBiviysXdILA5X9iomoccIxepRaxZKml5vL21ySkYMHdUqwYJ
 njW0CDmDXJTFxiYtdrT9puGgfdHczKxQfAZ1Y/hoT0sLt11w3X8HwdNxbTOGkc/YvlUp
 fcqwhzEWVla0JFrWHW50z6z3k53Qt/J0rlhHZJRH6DoKfzM9LhM09vUFX2BZc6aqeVuB
 g6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278873; x=1791883673;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=49cVrfGDUVWaq11Mcwd+Ez2kORiWWyIln2OfkCT6pzY=;
 b=kdiU7bdjHG18mfYHPUc7i+5bQ1udTd2D2YgvblQpj8yltPUT52XBZmpM+xheQHPv9V
 x41Y+HxKpy09wQU+kYQKDt2AwkQH2o7nx/iBTvn3BEoRNbTVm7YhdSHUJ37u1GSpYaf0
 jvgnCXnxKQgO3ZbyFPdTxk4yjvLN98tZRY16cjB1D1EYGir4QoqmMcgK4wopQlo9aS9z
 yjxxSD1VQ7XZWgC3WO5mNDDFiJw7k/CaqRIdebpCoWiex81QF1BYPHA8oI9WvnheO0Tf
 Pzo1/ZnpcTDpyTe94VCbe2+pZfWwzsdjWOZXYliSU2ylh4DPJHwA1t0U1WyXXBjO6Iui
 sQGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxv09VbK3LCRziFfpjJcsVWQgEqSqOLnN8tJ1XYallYC+dlYcTexBtKT27lkOImYtQQkHUj1acHFFjg@nongnu.org
X-Gm-Message-State: AFuF++lQmJAauwIHz6ZXMSebLrSvexuF7SJ08bzh3C7sOdQ0ABTmdZJL
 u/PrXMEyYTG07O3fEwx0drFm0V91sDzr2ZJJiQYMjS9drQMc1NyLDWqdKbuGT0QTrK0slzgf2SF
 BcJS8bGwvbjKpjk4tPSzI/kxN98jDxIjn3jbEm2JplTg0bA5pg1leLAojlg==
X-Gm-Gg: AYBFou0xtsF57tGY95ra7UGTVzqghpgS4SfaEshpWcXQ2TeRYJVUOOjmrrRSFRdab42
 RKguVXvgCOcqwGvZhDaW1WBVA4EVH6P7KoFOyZPXDu8yW8+ppaSuLAcUiaUiZRMk3aUMJrzDLB5
 iOU26Uwu/uhkA5j1Mhqkz2HJ0mHGrfjo73j/STnYK2gMwJ/9HqmrGuNewBzZ8Byjet+cIxL2jsE
 nErMxqhWv3VKj/FLdhFtNOgkw98cXBW4cUW7QAui0UHpFXy8J3LNub56kvDNxj494IP4lHYYf7Q
 ruhHNJ+yhk2UT2WyZMV/3ovh80mW7iW3W2Q8V5R4z9pyYArof8A2TQ5CpsuTh7OdmDPFsXAuZCp
 uHqO/hbHfEoHA4HPgFMb0kMC3lvpmq1ipKQ==
X-Received: by 2002:a05:620a:2a08:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93e8eb5df92mr146147785a.0.1791278873374; 
 Tue, 06 Oct 2026 02:27:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2a08:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93e8eb5df92mr146143085a.0.1791278872701; 
 Tue, 06 Oct 2026 02:27:52 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff20831sm259724515e9.4.2026.10.06.02.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:27:51 -0700 (PDT)
Message-ID: <6b638f43-cd99-4d79-85ad-141450349759@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/31] Kconfig: Extract config FSL_IMX7_GPR from config
 IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-22-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-22-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mEna1hOz6YKcdiwABqnv-u7FanUE2pkw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX+dX/v6/Vo/ji
 OMkfXZgTKYFrhIV4XSKKfoqSkGJE5vp+EhVLu85qrIVqjoLwFU34qrtY5cADcynckGZQ8/uI0Fc
 VvLG5idiYzQptOIqDq1lv2JlOKkhFac=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4bf1a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sRGqw_Zo-bWQZ-GCd54A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfXysRANz4xmdvt
 mhH73qei/OHMxMz5C3Bm9BWW9Jvh1Rnwr5KTf/ePq/VK0bTf/D7pWD70kN+nBdGabG+O3eaiWab
 d9ST2uaUQ9H5sQSPUKBswk0vq1aFS8w89JoOH2hwArtuiJt7V84fz/qTuI0ccOZogOeLAbGqbyB
 WCkuqKylK+qoJUsabmPUwDw+2RAt2/3kSwfsU2s+ZuVRbzt29ZuabWhvMIsvaeHG0SZ4ifJqofJ
 9WekJ+qQqlFAjEpjlDjwWFjZa4BYAMd59HVVb9x/4ndaQ2ArGj4UQKnTuu1sp8UXpOn8We9XMNU
 xbzb8Tthni37E3UVGFzUcbh2igrQ87OIxF3FIIebqRyGtSH9VLzGIgNPJtRNETGo1Au2I20tkQg
 6duY/WFQ8VHGVFkEoguvDsqow5YdZBZKC2HU1EqWCKfTbRQ+JXspQwnHxuvtpZMsI1KJzCs5Fk4
 1FEl6KdgXxvHYuultSQ==
X-Proofpoint-GUID: mEna1hOz6YKcdiwABqnv-u7FanUE2pkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/10/26 10:34, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config FSL_IMX7_GPR to eventually eliminate config IMX.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig      | 1 +
>   hw/misc/Kconfig     | 3 +++
>   hw/misc/meson.build | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

