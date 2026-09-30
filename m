Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942ECCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxhF-0006Zy-Pv; Wed, 30 Sep 2026 13:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxhE-0006Yp-Cd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:02:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxhC-0004zi-Rr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:02:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEvGH7273558
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yhJHIqd85X/qmG7jkOELlgDANEDVzR+sdoYHilowfp4=; b=Ob8kHNTaPs7JLVTT
 esxUdhl3avNCAAu3IQyCeztxBj+orEbSmoMJ11t7dIr5C0NjJGUsNMPKMs7ilIx/
 vVBppmiy/P6pY48W561cqaisAIHRaTgvmLEa4Lp8r7ef1zER+y5Xaac4z4m+iM+8
 uAsVVTrGhnc/dJh9m9mDHWXrw7yFmQWz7SCt0wvIjgZ22Z8VQw2+5u64kd3BsFMC
 0EG9VFEmAye8C3dPm3PYOnqAlOYzcfUARdHCAR5l8NM9Y8YQCV93IoTYcv2xvyyB
 YAhMFRi9xKzXCFt45J6yCyRQiyZ/C9DjzyzLzFLYVfJln478dQWvw+lDAnDbmYMD
 xwUE9Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20mam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:02:17 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7bf6e54f4cdso156201137.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790787737; x=1791392537; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yhJHIqd85X/qmG7jkOELlgDANEDVzR+sdoYHilowfp4=;
 b=Rb3WD8IJwPLB7sqY+52vq8qshf+D5tix3RiK5UxmbqgM9A3cC47/Nmt3hOyYNl7O5g
 PMSpp2BZnRDWiROW5Oil/twte1j4ibVLLvPEHS0gasgTKrEMBJ5LNwjhGMa76qA2Cen7
 eElncFesY4Q6xFSKgmURlAv8+yK3ZnrFhdue10ncV88gTzp9/qCubeConaFI40zPWFFa
 gLootzmfR4CBquLFe8RibmmqxwWJNzriIyURUH7lHls11uxWYanpupXuUKgLpZV5AHM0
 NI5cMWPcIsKyylg0XRUoOPzV2Je7kQMsjn5Zrj/6BVrGN9wyJMNPnsYvf9oNjEKVEKPy
 vDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787737; x=1791392537;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yhJHIqd85X/qmG7jkOELlgDANEDVzR+sdoYHilowfp4=;
 b=Y020nQghJEXaZKRlOAWos60QQm2GSWdLwIDyDcpVeadTNx66MU83poA/FhON4G+DBN
 LyFQzxTf++qAkqLDILaPXJjT++RhLTbsMZNFwxZPdmlxn6E+EMnOO8YVy4dfk6+q4pAs
 +1NldVfD/7I4map//cyPgtHKIFCQRrBaFiFP5mpZAqtJoqcGgU75kTzfcjyEVnh3Ik2q
 GQcS4ajLJfKgURQPsGaqW3ian4UyrEixlN8zsXzgRJsIeIWWbbphzA3xbkfPTEU+T3GJ
 7xVl3pF+j98f0ZIMUC5Gc5xnb+Fgs0QoUj4Jb5aBOaIizHy5aDlm9I8PQA+AJ68gy1sW
 Jpmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6kdxmfQMJ7dzbSReN2MGabTDcbmwHcAF7fherB4360oCJVavkpqwKNV4wKc1iPlmpDJGgq2MVRSeq@nongnu.org
X-Gm-Message-State: AFq9FYKr6TdA/u0DP8PkTxFkaE8Ze5kNvSfquZAopNKoBBuTZ4b/drN/
 31Zy5V0Gajp5/L/gS6ay73sQ8YNZqTXcw7SRkKW+g1AqoRM6/FeaPnp61JuqYfZHwnwczSIK2iq
 o73ioNxJT2BjnrGBLVMVorg/+ZRf5ZHUEmbicnSYsSNpCCrzJQjvIefmvWQ==
X-Gm-Gg: AYBFou1goy6jOMpslejzwvkLujxyun6h8LGWY+DcUaTi5zmAU9pYOaJSE7byvDwuKjM
 cqNNTTXXs6LmW5os3QrzlzVo7QDc7Xs3b4V+FLCttBDhiU79y/nKtaiF7LySHeAC/4WRD2Aele4
 xNi57u7pqtqkzQuPeEVJbA9v81uDsDh8xdZCfMQcDlVDD96rvYn6XDbFIcoBPUXwvfncfkKVOIx
 /fofpCN+qqigyLvgYj6EftIgK8nXTKfJBm/w6/aq7OrnhZK917AIxSm2v5qv3ddYIkHW2YQpkR4
 kOdbzs5FhUrEvAcR5WMFmJC4p4sRP2XIlAMiDCAVR5jXlebPY9T9a8Ge4v3cufK7GFYHWqHi+Nc
 EgCrQ/XHpj0g1Dr6BERM=
X-Received: by 2002:a05:6102:3594:b0:7bb:a70:4708 with SMTP id
 ada2fe7eead31-7be73596295mr534687137.17.1790787736709; 
 Wed, 30 Sep 2026 10:02:16 -0700 (PDT)
X-Received: by 2002:a05:6102:3594:b0:7bb:a70:4708 with SMTP id
 ada2fe7eead31-7be73596295mr534671137.17.1790787736172; 
 Wed, 30 Sep 2026 10:02:16 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ebadf30sm3197255e9.13.2026.09.30.10.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 10:02:15 -0700 (PDT)
Message-ID: <0bf78ecd-7e12-45b6-87e1-4a5ed36e95df@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 19:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/char/dw8250: Fix leak when creating child device
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 portias@oss.tenstorrent.com, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
 <20260929031644.1016354-2-portias@oss.tenstorrent.com>
 <238b1bf5-c7a4-4103-9e70-c5bf9efc3691@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <238b1bf5-c7a4-4103-9e70-c5bf9efc3691@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd4099 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=2V5rpjPJ7MWuj2PC8TgA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfX0WbrzSrfYFl6
 4AXt3Ug0kt4oMznwrJQp3mKnSxzEK/wStDW8IsSNBgRB8khFJOxUW0hU0KKiO3cswpomNDE2t6T
 +jzDTlGNaK0rvEgpYGjsY+zBk+da8pA=
X-Proofpoint-GUID: emXcFalZ-b3m4TwbXc3qIwUnbKBahijg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfXzwVArRXoL+ly
 RF4+rY7uW9N3VeSC1/cyJjih8Tu0JiL/ZaKESccRdS4GJh2WKH58TpETgzQX5Ar84a9BlmOeV9R
 zfpNG2/TaPsYmkenYFb2Ch0EBBwMMx+3/LEaLcrLOsnO98lXgT28X1ew7pzO/0rVif6I26uwHRF
 b2KK9LkJgPHVWPx61/OBw0x7+5s/o0ZUsl937qtiZ9eoBrMnmz5YUVGr4/MQSz5M4e9DEkJbzFB
 6MyfZpuTSBmfNLK3LvmXdw73DNjtzgzwTwLzW+2Tmjz/Fm/iJVxEFVX6LFbnClD15aqQFHCH+K7
 2Ei2zm2ZGeH02RjbWUgb/YVSHfkT8sTzLZrhu01SZc9JbWNkBtsy1UmoGFm9YD51AMnK4SDFUei
 m5zKMfrFUoewdQHAC+pqFW1W7IZjtWvojHgGEaFomPnIucEImXIkfVAu+4Q1HzqtaM1GR2Tb50f
 nJkDnQUsoCGZGNtRfkg==
X-Proofpoint-ORIG-GUID: emXcFalZ-b3m4TwbXc3qIwUnbKBahijg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 30/9/26 15:28, Daniel Henrique Barboza wrote:
> Hi Portia,
> 
> I believe this fix should be made by the original patch that introduces 
> the device,
> which isn't upstreamed yet:
> 
> [PATCH v5 1/7] hw/char: Add dw8250 UART
> https://lore.kernel.org/qemu-devel/20260927201326.650943-2- 
> visitorckw@gmail.com/

Oh I missed that, good point.


