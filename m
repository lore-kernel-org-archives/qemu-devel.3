Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A89C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGW6-0001J5-Gj; Tue, 21 Jul 2026 15:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGVr-00011v-O7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:52:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGVq-0007Ve-8x
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:52:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2gx12449165
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PRWn+7whRNKmaFQEWPmx9SYN8+C2SkJLnhOH3jtOH6g=; b=oO8Ah8tatEA9+36V
 P+5MkvLH58Db58pWBcCAdg94vfD4/k7BGEQScO/Hz0XGvNgIpq2JxT8n2Ni6g1Yi
 hv6Brqj6yhLTCkZU1J3GI9QMhLJKXBuHtKZ/e0yPLHcSLxMATjt9EZmzKjy8EiFj
 iWMgu09vOKwkNREauaQVfyyaCU3vZJBuBBPRUS2lYbv8s1EuRvDoeLuUaQHqPsxK
 bf7NcFieMp6fcJDsnIIUIKjFrUq2sp/VGIfww75qZpBHEQ4n/e8mk3v8fn7VA21v
 dpdtog+2Xskda2xsZFVp06G7moLAEuuIadtF8OHxZX+dtJxP5FBrbplvmFSdKDfU
 1LWL6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6862v52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:52:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d30035dso149247611cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663536; x=1785268336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PRWn+7whRNKmaFQEWPmx9SYN8+C2SkJLnhOH3jtOH6g=;
 b=Aq2L2ciiKICwUVzShOMdb1ikQPcHykHMXvjzQx+TnwKn78F/4+402KhX9CE2zwDlwt
 3rCyxS0uY0caqhKl20QMxUzb3eA1mm82GivShan8LRbdUZo+FrzF26E3AEyBwlNXUF7P
 nrAMFkOMcu8Hxn+/YpH/K1eosf/LmPNKdAWca0gUD8Aazi5lihE5x642grN+lNfIOrPq
 R5K21pwPq7ZT4u6S6lIHiBjlL++IQCqLfb47ksHkS85BgdvAmAyDKC28cTzUXeNynSLX
 3AGvc1qBEHfobbnLnf6OeenpGVD3juBHUYi+BY8Fl/H34JRJsJgjbvslVkUmDQr0o+A0
 wLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663536; x=1785268336;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRWn+7whRNKmaFQEWPmx9SYN8+C2SkJLnhOH3jtOH6g=;
 b=oiqBJ3oC0aNiJszEYkpQ7OolyC5ueX3dJH9ejCjquRd+niyuAUXRrN2UU3ndV34rgo
 4nQqCdxomhL1qgwsjBfPybQ+BIWqwPTrkBKAC/42svxDtRgDNzOR78pQGvcWTWOrXMgv
 UOgCoyntxTEf2W3NLB9wX6y42gSfqwMlPooM7GZe2BDwxVIT5FZwAczsD10BFwsXLkv5
 PQ0WUKuEE582QMSVVoddaIdqaQaPYTvYCJpO7yAWfAoq8lN28lhNHwQ2FQvJadsrqRLx
 ZsdUoGwoF5KP0Gae939OEPSBDQMMs2V/OH+84yydeMvbRJv4g86512mlxah49gecCwk3
 cD2g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrqnj5Z24tdLuu/OgglOvn/ck7QOjwRSapVGVGGNUmu6P8olP23ELhtSyrB4XWGu/wUDt5HIK58d+x/@nongnu.org
X-Gm-Message-State: AOJu0Yy8IOt24iFNkAUiahb88Cnc2hBO8lTtYrlS9eiUYI2KPP6l0vwF
 4Ia2wXbi/KgryX1V9IbwzGF+xjQtGgNAo+DRCpSfjywSEBNWk8vcAkBNptCVczfiP3Y6bNS9LYO
 rrg8tpStirDH/sW7r9MSoSqCXRn2LQsvBwuuaQp6yFO/f+oYCEl1KMRPpsw==
X-Gm-Gg: AfdE7cllzlDH2u6LqKHF+y7BesQDdFui/CsubMl6k4ZNRhTlgkMwvfJf0kmdMukBNhE
 ahc+H3cpEwEOJJKQeq/7YxzHa4/qSfcbL72+fjw4DoQ0kOT3pVkLhQhpUYPb2/tuYpncKAgvDmJ
 3/0qShKFmamgdyKNNnH6ki2WzG/U+piPm61a2VrnsOEPfmCS7yC5bY1GYNRNEXzNd2bcjdIFwiT
 7Bg+7BYFaYYkWwkSDJFnyiLNfqgygm3av8b+GDfD5+UU83VXURNhbIzAZ+y09yQWi8LjiaanSpH
 AfLpfT8mF1ugiv+loBKeNu2t1MO+qjHJegkMDy0ipx+mCzAtuJt3Q/rjkCOF9tGTOHu+dyxf3M7
 xHYPLYGgiPxreUC2aqSAjoCs1igVAv/qAeQrII4JsyCLBbBFiu/g=
X-Received: by 2002:a05:622a:259a:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-5213daa0bc2mr188915221cf.52.1784663535929; 
 Tue, 21 Jul 2026 12:52:15 -0700 (PDT)
X-Received: by 2002:a05:622a:259a:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-5213daa0bc2mr188914721cf.52.1784663535501; 
 Tue, 21 Jul 2026 12:52:15 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm86034125e9.5.2026.07.21.12.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:52:14 -0700 (PDT)
Message-ID: <bd927862-3679-4e4e-a1b5-47a8de2f4afa@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 12/15] target/i386/cpu: Use qdev_is_realized()
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
 <20260721-qdev-v3-12-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-12-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX0agYvrevW4oo
 4H841ju3+kzCRjGBsNgVcl1D4wV3dNZvx4uWMOLqQZ4Z1Ez0FmJxi57kPDQmGphup4K8excbf0F
 osr7hnHTu11q790ujgjx6R75PMRFoLI=
X-Proofpoint-ORIG-GUID: jKl1UyMa1e9JCloAAZN-EbCaGds_soFK
X-Proofpoint-GUID: jKl1UyMa1e9JCloAAZN-EbCaGds_soFK
X-Authority-Analysis: v=2.4 cv=X75i7mTe c=1 sm=1 tr=0 ts=6a5fcdf0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX43ITQT1lkGgT
 YMFMBqvHCQ5Mavt6Iix4nhlLU+OtJB+2sfjzbQQe3yK5T0o/uNSWBQU5yhbFYZqObECqU2IDofH
 0wvYlTQWNWoPOHThm+Qy2Azjck1QadyAXMBP353cD0r/37XJ3lXZLIyFwpgZ7Fav7cSdQY3hlWv
 R19Ynd0YxGnHgKTg08uWN9PLipkbCGnFJquCZZsExRkilTyc0w5viRBWndlO5Lk2B3pDbvfJDeJ
 WdW9dXhVcdWa+iVcz0C2bf+/vSpdo6malcLthkVxJ9mjXTNp3UAfz1s0Yci9DGX6LEes2ncutOU
 N0naSMVXhp7alYXIxeBfZeAnVjk21Inlkwme1y4SwTgHclbHerucOXJ+b25ev3CqZ1cW4bLagCa
 uFJPWGZXbZxplYSm6HewfRGKe9Mh57YTw8KyDSpT8Ha+AJ5zOvwETeHwfNJwDbeaBuLWHtro+NY
 tRvcV/jbsPhZlsdjuOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210206
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

On 21/7/26 10:17, Akihiko Odaki wrote:
> DeviceState fields should be accessed through qdev helpers rather than
> directly. Use qdev_is_realized() instead of reading
> DeviceState::realized directly.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

