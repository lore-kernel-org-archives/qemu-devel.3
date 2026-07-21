Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BA5C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGZK-0005fR-GV; Tue, 21 Jul 2026 15:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGZH-0005cs-TE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:55:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGZF-0000Qk-93
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:55:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHPHUs2114898
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M7wmDpeN1c7WbBNahjL5IQZ+5RdERD6NgfEXoxMh1HE=; b=BbWr2/56nY+ecxOf
 FWWVzqrsdPyv0Uc9MdVNQwCUFWkS8zAyjH6yROUPQu+QJqMQQw+SscHRiOhNg7rK
 yOXjZPezQ11QreBLLJjDZMZa6hW5LRIQScZFI4Yx8SmbJIQCESL/THP08xPPgQq8
 7r16IqXo358LHKhA4ghw3G0m3tDymHd8+RqFzUAlVmQX1zGf+MS4vdoZqgz7gOE6
 RnViHbSZIlaC/wqUdAKwYWqSUPPJm9gkPFDIeSHSXSctoQ8UP7iwgTBRVDDozB9o
 CW5FJI9zJfT9f9AP4nzhhmMivM9Xp6Flm/8yakqww+vlGfsBTrfZ91nwaC6Z7Vnc
 7meNOA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e0n31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:55:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d30035dso149286261cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663751; x=1785268551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M7wmDpeN1c7WbBNahjL5IQZ+5RdERD6NgfEXoxMh1HE=;
 b=fWpR1CvLgU/VDDKEPnetm20k+mE8EURdSJ29zi4Rdu+mY/Ti3ITvsfTl3iL2BMYCoK
 Zc/i3Y6cz+wapOttEOIPshkhnWYDybuHjBkhCey/af9qbq8X7z3srmzppR++Uuh9igcO
 W1ZF7xf0/qJKtXoRl/MdMxVQu8wNIzlFCR6LBUcJM29e6AMunDVx/JDg4HDFG1CoNYk3
 SAcyai4UJnRaivSBFYdcaOkeWzxNYwLPcI0ylxcKphcBuofRxIGEcqsOrjMR33pxzfVK
 qcbqZ7ZVuPi4+Mc0xM0QifwsmIwcocOzeNQLBiconglBRpeh8t0hV6Y2IR0ytM4n6b5K
 ClCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663751; x=1785268551;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M7wmDpeN1c7WbBNahjL5IQZ+5RdERD6NgfEXoxMh1HE=;
 b=TDqBhpazZMLvOVo2aelzddPnp4M8rKs8dIUgtKV3TCOsxy1oru7thN9JoMAgZWWMLx
 98262on8uIJ0eEIg3lJ2je1sLp6ByBBVrBfR5Ro0vwTnH6W3Jmxc2dOFNzuWR5bPp5TK
 FpFIS8qoOkSjOHdD7aaKr3Y1kn1jAS6gYrL4uXTQL9Zxddf8BY3A6gJVt348hgp61MPr
 b9uK8HunInw+L6VmFbQPPWH1ef+A0NT61PLfZNZGRboqLHGfWeysoyrAX/sAyt3yivc6
 D5Sg2bhhcalvncgD1Genk7nHoQ/xCTN8l8/yKwE4pww/aWsptNaBA4Q6Qt74+YTLk0AT
 9WlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCjZ9epDPXmhm60uo02TOOxw/i3VvRC3S42bCVPt8BI3vtYfKsJqo2xiI84g56fseURGiuNOpvyjYz@nongnu.org
X-Gm-Message-State: AOJu0Yxtx2qdsrh3irVFtU0ANss/ko1sxc0SIB/txGNmRIHmHEdJzpPZ
 SRGq0IBhfFZkhO+wYeI/gZZA3nEDGt6WSaW9mczyjUu5nr/AdVW7EE1zq/j0wH15VWNoduqB2aJ
 /BLPboOaiaU1zAWQj6RcB6ytXSUwdgI0onREiSLnfOlW1/R4KmSPGq3mQoQ==
X-Gm-Gg: AfdE7ckLjVZivd0GB1JnGFdaLXgIJ/ft0ahRa+dEPZ49xTz9uV/QDcuaYEChgudV2FU
 9l0WN30w1pnAvbFKqQOIAhq53149b1WK3uU33+HMnu8jJwoFRe9qojg1D0q6TsgLQS1s3eG2VWL
 mkNzmnokCbOgp1RIkQqH19t4h1Xm6kNT4dRrbkyHiUwI/5Xo0obEuKYC7IZO6Tmq8kb9Rd4mqjC
 KxVzI7/NhVG049aL6qBNm2INd2AivhuzAo4SKzoasrrqPjtfULD/AoDLfJdloZPX1tJM7aN5moF
 Ibge5gZQs7ziMPBqJ1tfsAKgqQp7iIbXKVOJf0cZ+FqJURq9fKYq6oq5usWk220t0TpzIW89qz+
 qPkkG+xxXLi9pBDMUx2nqA+q0ZlrzSjV/eO2l0NnBOibnBmayj3E=
X-Received: by 2002:a05:622a:909:b0:51a:8c97:938b with SMTP id
 d75a77b69052e-5213e190f97mr192806861cf.66.1784663750702; 
 Tue, 21 Jul 2026 12:55:50 -0700 (PDT)
X-Received: by 2002:a05:622a:909:b0:51a:8c97:938b with SMTP id
 d75a77b69052e-5213e190f97mr192806421cf.66.1784663750159; 
 Tue, 21 Jul 2026 12:55:50 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm46939457f8f.11.2026.07.21.12.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:55:49 -0700 (PDT)
Message-ID: <9c17c94f-1b10-4be5-8916-aa650179e684@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 10/15] hw/virtio/virtio-mem: Use
 qdev_is_realized()
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
 <20260721-qdev-v3-10-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-10-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8NRL90qTESUe5n5xdP973t-HLIzT80ix
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a5fcec7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 8NRL90qTESUe5n5xdP973t-HLIzT80ix
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX+OWCdJE2g97m
 v5YhnrMB1f9fZyeHwLDVMp9hiTNzr4p/vOvNv1Nfg1MZjFARCdL1c0755In7ZsETPhuB6rVTicZ
 QXI+gONWzOLevwJT2uOlpaJ2mlPjiZ1HfJ6ibchfwJzwn/IQ+iwfrUnWzAPjH3nOYRgQQ0XCfun
 XlCM6uzNLU9rGTW7PzMdNRwh/qJIJIBt0eWxfyul+vb6Myi7WryDJan4sWjgP9oaeCsoAf7j9tE
 DXbI8s7xN+LQOIVnjz6niBXbktF5CdM0ycT3vbGkI0qakN5c4+jlbPA9Ao+R6sKM9qRk0t3g+Mb
 SApUxypD3rAnUp/g6zMOJ0rQDzxSX6pzKLea7/L7Qkif+tveKDS7XAb+uIsJyOVF/afhba3xidV
 YFTbXhd0xAa7BfXNpvQYEV+74dsYm2Yb/ZrHooV9pTVrfx4E7VV14NgpJv6yPqWRhv9buZNukGv
 lcz4pgoqs3JuCJailiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX8DF2O9OwcwYI
 eVdWWxXMTOOqOX7MhSFhHnpSHudmEXG/Kps0K+oQxh1GJ49soD+5UTBPxxi1sZOcVLfPsGIAur/
 4rzX/cE5WxJMnLHrEFG33WDh0gDr1wM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210206
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

On 21/7/26 10:17, Akihiko Odaki wrote:
> DeviceState fields should be accessed through qdev helpers rather than
> directly. Use qdev_is_realized() instead of reading
> DeviceState::realized directly.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/virtio/virtio-mem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

