Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40281C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ioy-0003Ig-Jr; Mon, 21 Sep 2026 14:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8iot-0003IM-SN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 14:32:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8ior-0003u7-Fe
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 14:32:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFAdZ2884771
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 18:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bme5wrihOp8r892mRa1QakDryE54s/0SyugYvKhjqvo=; b=eme7JgvEOIIzS5hu
 kCULAMqT/v3Q4oDjZJamvyTf0gMwlx38qLRyXSpJsjYaGwNk29RGbUrd68ut/yk/
 8ZIc41PL4Aytw5FeVD/brprpkAlHNVIDJTZa/AmRwD1Gr+RsilXFktZf0IOG67wJ
 gCcByuN6phklEZEbCLKsmYFQmGZlYhKFH8XFHpHS2gn08GX+fWSSS3zUGeCucgEt
 1cwFb25PmytBO2LaYYm+ghtRcBn+bsw30L+HsD7cKgRuhaarSz39kvKmm4w7dNas
 mL31fy6B09TMu/ZJYgj+anTD3rOIUqWWykRyzH4Vg3mIPfEB3yj4gBslXoEn+iOL
 yJlizQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj2mbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 18:32:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so3808680a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790015564; x=1790620364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bme5wrihOp8r892mRa1QakDryE54s/0SyugYvKhjqvo=;
 b=f5pWbofIz/nBzfT0Bky0FzqFPzvhOIFGzlQjajA4ocixYll47SiI/CSoZYlO5yiSxL
 CidKGPeMj1mDnDy8cAbEPiv03NO/lwsFb6m4HNfmAaOp3iQEFujLtu6Y5A+gzh0uoVOG
 E62gse/Tayc73FISoE+40ESBs8ud3RTaXpI6VouuU+tH+MuWNBZfMSpyxsxhb7o4Zzi3
 rvANc8t3gr7409Ef0VlkAT0l8IciUZX3tnVeDroo/1y3w710kzvYdL6M6MwW95jfiD5E
 BXYKnfeYruaIW2VuD2PRpRotd7bC/tuLEpyILTpTW1BwiKvX9A49DPUxWLBBCrqiB0rw
 pXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790015564; x=1790620364;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bme5wrihOp8r892mRa1QakDryE54s/0SyugYvKhjqvo=;
 b=MNsOwk9H4SnKgdz4f5y8x3iLaWVWnOZGuV7uyXX8H1yOZpNM8MiATCApeWiU3Cf/y0
 KJgE5DZQCAdFmAUAmq9ZBzATFSkLUxAOBL+UAV41FDzGyF7De0oAtFw387Avhe/Htaa+
 jP6cEbAPrpa4l6alQD5Q9gQ13Ce61F/4UzPnGrpF6QNqLC2Nag+0yPUU9Is0TyuYW8eX
 FVdoBgNz+wn3ypdvcWzxhqLe9va52y+07Z9Y2Jzr+ytN7nHZIrX1RxSb4SbLj3K2NiPF
 1UFW8qxxlTjcckyh2XCjkKvR784qA3cyKPXuE6OFvOEnmHB0ovYkTAqYcT/K287R3DC7
 vsCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFaI8lkP071M29CAXSFMt+DJ0UY2QYyCfrh48J7mj6PfiZ+YoccYBU4kuBx4SjC/rugnQaxErdWnWM@nongnu.org
X-Gm-Message-State: AFuF++ngqzcS7foF/E7HOhsgeGoUW+Ouc3rFuUf12WfLXkNCejcSMPfK
 yTix8ohDTab+fBt/2kEenc+EQSyeQHyR6pd43f04qaAQSDrju9D4Iner33EC1ZZt0rmMZfHxUX/
 Li81RM1IbQgQzoajORz2bJ3hSPvyeT3SP1igETm56tZ8H2eAQlrGyNLzBWg==
X-Gm-Gg: AYBFou0PpQCJ81BWqZxlM27hc6iW+pxbyw8FU/bnA91P+Q6uSD1Ck0MyfhQVsRrVRt5
 Mie3Okt3FC+G5ACEIVMVqBKoUbnPisWZCRHDHBxDP4xXyfQIGQNZI3vibnE+mP0cGePPDfzsfIm
 p9M2+0WK3ns5nXGyLK9GOtzzHsys5yBVl6DyV3XGK2z8Uh1SudhL5UVHCNtx/zMIZYnqL3ydW09
 hy3IOSpRCM2e3fNBM0Nuk4N6HJBTwMwBJZUdpgbUWNIfu8jaKyGCGS9akErBNGeCiXz2UbHor7x
 kEsEBWZ8iVxirZu7LI7w6QvBMvyqguFGGDCenXq+7w2PpRKQHv/18e8j7woWRfXxB59/5rXxhTN
 QQFTmbcIW50P3uhRWBPU6SGjFZjTRSnEEFWMFhArzNJQMWdcLqbCHqbQk41M4ivALoxbV
X-Received: by 2002:a17:90b:35d0:b0:39e:4c81:6c65 with SMTP id
 98e67ed59e1d1-39e54dc0ce3mr17430904a91.32.1790015563683; 
 Mon, 21 Sep 2026 11:32:43 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:39e:4c81:6c65 with SMTP id
 98e67ed59e1d1-39e54dc0ce3mr17430871a91.32.1790015563197; 
 Mon, 21 Sep 2026 11:32:43 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144e857fc1esm5821632c88.12.2026.09.21.11.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 11:32:42 -0700 (PDT)
Message-ID: <efdb7d44-3b64-4141-a178-eb1730c73d4b@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:32:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] bsd-user: #ifdef sockopt that aren't in 14
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-12-ebfa61049bd7@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-12-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MCBTYWx0ZWRfX4C3e5SMi5oEc
 6GvIETj/o7pECFGZ8tUXe8AeN9zvCHutwg/mMddiHdI3LBiP7d4F+RuzDldLsgeOsqiI+GjsyvC
 WLiazJWZYMUOwtsjtjCg7ZQQvkHPk9M=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab1784c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=4aCh7fsK0aaGiEomRCIA:9 a=QEXdDO2ut3YA:10
 a=uoHBvs8nGJYA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: qHQSgB_W7AlccxrnZrAxsEiKSerxoPJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MCBTYWx0ZWRfX6Y++8tI0sfIb
 S4QLczn8PsQMgnTXEWFzuHJggWB+7EsUfhh8kAg70MFINEH8y0jBETTGhAuBzTwQtKSxx33Vg4w
 STzzJ8sPXySw+1CJcHGGVe/FUm3hJ5bfpQetGQSFeeecCOLo+trvr3ldT47UOTEo0p1SH1IbYHE
 ircLNXGHugG7cz2GwQtZ6H6JadEC7eYbU9olIicEnokpRnpIASuT4dUdwsXtgVdNY74odyIG1/x
 ALo7oxVlakM8yreUR206YSYNFtuaG8e2OEiHLfSjRqg7Gvq4fMnsjA9Ncc2V4NZSvKUcjIwDm9Q
 8XABS1MKFA2T24QghgdhNfELcSt3rW4zt9Lz/WgwpRDdnFD7d+soN2WvYiGElKwVfBBsoRkVxLe
 k9fEhi7FOGBF19X1u/RDYnbk9TA6pXK/GuLKTUA/0uF7ojqW15ghL+GJ9biVEAkOGEv2DuyRFVC
 h83Z6Lrlt1uzRphS0LQ==
X-Proofpoint-ORIG-GUID: qHQSgB_W7AlccxrnZrAxsEiKSerxoPJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210270
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/19/2026 10:20 PM, Warner Losh wrote:
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-sockopt.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

