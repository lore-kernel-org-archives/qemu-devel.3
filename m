Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6481DC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGWk-0001ya-95; Tue, 21 Jul 2026 15:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWX-0001hp-Te
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:53:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWT-0007fP-JL
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:53:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2S8M3439733
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DkLncRROIxYuPFxLbZ394vVmGJ5/KNcqOD7OwB7qsN8=; b=HEEM0X+q51qmNm3e
 TjQ+DC8s8cIiDf86+w+gsI+6FS57mbFKWslT0iiGG7+ZVZ1F0rdvuEiZBeRWyFqb
 fPu29IPqXFQ1wcviuGDLarbHVl2p0AweZnSyAOPsVU3v3OzomlqY2QMF0mqN5dQ4
 Wd2xuwG8wKssodrS5EcjYrGsyma4ewaVgMO4dsUCPgPGyFKsPvq46vq6GMoKxFyP
 nTonSQc5UqNAb/LEtszNc0TDFh80835GB7XGZ7spupna0/x68gjQWcLHE3vt3o7c
 Sv2v3wb9By4pG2sys0507nzWPH+sjJ+9S+6B43RdWellYqMUvMGpKJZuWbEHQaQG
 frBg+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nstt77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:52:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so202599591cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663579; x=1785268379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DkLncRROIxYuPFxLbZ394vVmGJ5/KNcqOD7OwB7qsN8=;
 b=W8QHyoahE1tpPFNWuUWtqJkqAzZH8pCl1SoDxAWvkFXNc1car3z5lUW4+I7zmE3Yt7
 i8TqbnkdTg03pyxHawAXYbxKhuvOvBM5qMKn881a7CFqtkMG5SQ1hAMfHy8OX4NBL0A2
 eSl/+7QpS6+/E+coJ5BnKkV/DX7rfKIjXR5SIx9rBt5ue28RY7RaB2onWtjgKDXjiGip
 Os8tBqN9cud8yAPTsFOMXjPIcpoy4AQ+vNqithVsnhlXp8pRZWF+orM12dho/UVpjQ47
 VmUFvfEqqB6xSVB/FFrG0V/QKZyM0IiYuGjPKPnsjEZBrHRj9n43cW97igiu2xHVWO+A
 Ettw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663579; x=1785268379;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DkLncRROIxYuPFxLbZ394vVmGJ5/KNcqOD7OwB7qsN8=;
 b=UwTqlXoJz6MfNxp6BqFJYL1eS5cYqXMc83oroGaO+nw3g2IqV+xneAwXhzMH9tIHBF
 5CgiLrH2p64WH4YXOG42jOnA6wpw3u2ILh/+3YYNhgyfU/QK6h2utFg/j2Cx9007BhPN
 R+A5aGjr7B2jFMIG61mIvjS73KAcb8AoIxTwYZm12LHIIzhCEYHTusyOzAj76mzIjMLj
 dShV9zx808ikzBCRIbHSBMK7zn/6EYwkjXgVJc6gWLiZnXgsgCZaXYtJPD8RCAOcLntk
 3IZv+k9wS3OyQX7ZzLCrayBa09p7/nH/pacO6PH1uR62EPCupThwNaYC8rPCFrdD1vjv
 0BPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVF5vy6XhhqcKtIshEz2JI4HWJr0waQXlt04VERyhGnAB19dFu2qnGivBD8Hf9rNT+HeSGxcgwIcgi@nongnu.org
X-Gm-Message-State: AOJu0YzXcaFcx4pZOCR1qooqbDJTMy4FJHDKzjLBx5R4oVtTxt7lsa+O
 Ax8jIW/FC1rw53fn3Ew/qcP2mFP03FPuODsE4XQOzFSFtAYfb4/UMf1ROEog2c5x7XH4x1jkV8k
 ysVFuP9YItdUI1awr5bYZYavKUwWdl2K1pxVUoRAlivo+U2FrSPJjc2TY0w==
X-Gm-Gg: AfdE7clXCg/UwaKwZgRkPYEHfHMs/j/+j5giG+riu3fM47/+Kx0O0XbTUip09ZZEHcj
 rJSoEDLNFRmXt7y1LkZ4mFF5lNPCVAjdM0c3vngNaMSLfIys8UnejOoyZfm8E5fWAo1Mkuyxd1O
 5eu73pynJzP9fzEZq3v/V422QFrfhMt9YZCO4sg4EuNhL31gsw7CUeYXI7xaab/54kITlt+9rzC
 awDMg7rQQpzzpaZ/zWb35OW8FWUqepLd2DmxdK+oHXrfFSKhnj3uJ0ZujST/0mnsIrwFRHA0h0z
 U5SOQ0Nd1zVLBgbvpkof8j1RsLXSQM0omSvEO9sisuckOkgBkga35ULqixZ0UbBssf+k2nNRJWM
 Wv77xiIV9bjeqFX9+XZ7dq3612WXZCjss40kg8Vfr1dOfHJfx4tw=
X-Received: by 2002:a05:622a:28f:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-5213cec68d5mr189054771cf.19.1784663578902; 
 Tue, 21 Jul 2026 12:52:58 -0700 (PDT)
X-Received: by 2002:a05:622a:28f:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-5213cec68d5mr189054301cf.19.1784663578339; 
 Tue, 21 Jul 2026 12:52:58 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfed7sm101473155e9.11.2026.07.21.12.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:52:57 -0700 (PDT)
Message-ID: <3fc2e1f0-b8b8-418b-93e4-b430c1fe7a56@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 06/15] hw/mem/pc-dimm: Use qdev_is_realized()
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-6-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-6-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LpIeCsPWaqLviQeXTnQ3J9oFy0AG_7aZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX1WEx0DdL8GZG
 J0D59pS66Ot29bn4Ga45HbXCIKExObmaa8qd5CjxQdtcmdy9up7ebM3F1BlUbZSoYAub4RbFyd2
 jDQLsREAoNUrWGbEtdYyvvrxXhHQVPo=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5fce1b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: LpIeCsPWaqLviQeXTnQ3J9oFy0AG_7aZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX3JeJO5xGig7b
 rHctD4Wopw9bdX+qt0rXIwZ+6zH1REinBmfwyoEH/nOBkeMs2gX32klmZfDTRp3k9xr2OflI0IM
 pqQVBSB+f6TQZAQOiCJEG+YLSIjHKFsuW+RM3Wy4FGQLO57c5leC7sHM1y28ecvGBpHVxC3UD5t
 PRORKKL4Eg1Cto7POw28b+CaY1Rw+5xnHSefATmVG9NJemQgDoCtU2s61cX/XiTJFBNHobLRUcs
 lEkTBcJRmmLXFaNxStjQUmf7ZlQsqPNS3eG1NiWbgnKegwctOcsWzJKiqAiYB9NfFerELFk195r
 vlECtE2CXMRtJ7KC8t3Go+u91ZDTYJJURUQWoePtBr4DZ8TVUEw3x3F77txqvtiTqMBjdhv3VKI
 Xu9NyvP5ASZHvrCy6uC5Kew9G4SJRFALYOylbxCyD3ce3MnHl5sWkm50vT3eLbxsSxuA+3FC4w/
 mq5ec/yBFl2CPbTfrtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210206
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

On 21/7/26 10:16, Akihiko Odaki wrote:
> DeviceState fields should be accessed through qdev helpers rather than
> directly. Use qdev_is_realized() instead of reading
> DeviceState::realized directly.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/mem/pc-dimm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

