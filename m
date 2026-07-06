Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E765FC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjKj-0008KX-QC; Mon, 06 Jul 2026 09:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjKi-0008KO-6z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:26:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjKg-0000Wj-H3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:25:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxV74219072
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i2H1BWjECxL+ndRpM0G8dO55TgrT9WVFV5Uqt7ArYKg=; b=ot6c+ZTBhAU1gwyV
 WmpNJooRA0PqRAFpX4tag0OSg3WMKl05b7iroJe5LNDpwAik5AomzJnHLm0aicqC
 gaQcegw0d91UCF41xa6y8v9xp4BsLV7QizTQ9relyABy2JJsoObP05z8uY+TgPKp
 rG5jY3kZahlSaZFpVsBLBYLdm0mVaMu52FghSohrcW39Tf9vapuMmxUTCslB3hAD
 XqG8IwQgLieS2jF4tY/8QwUauEDC057bHCMMD4CIK2v0Qfumg6gM5uTJ27x+dCyP
 KaowG49f8P2/C4t6vlzQ3QTwUMGqzzYmAGnqYa6+UdpXOXQi7jJTNKSPPSQpuwYC
 m8pNew==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs98u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:25:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e623b0e95so250022985a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783344356; x=1783949156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2H1BWjECxL+ndRpM0G8dO55TgrT9WVFV5Uqt7ArYKg=;
 b=BV5BYktLamBFEAkpVAK5ccL8Ht8u+4wZO/JPYeP9rn8M7tQXCTv81eQOYv2962VQ9u
 7q5sLkbXEqvMgsD+6XgDYRTnQFog0ck7buh22J90p7tDcSW+0lUaZHZDUY+18OyMfEG1
 KiD+HcFIM6t3aA8k5IJbmB2D9zDgZmOrD7GQmbF4JvJjWNGDTJK/rZ7BDKhlrh/TAVEA
 L4cL4CNxohrG2Ss9fGgczBCkomvH/A/1Z9KUYPnNx2a23qCI6g0VqLAjfTZ54DKaPLBU
 /8JoNfc+9JXzLFBllOtDdooauEcHHKyMwx+nrWG3UgmMvu/8+vCJiOHbo1hnouyMObvc
 izHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344356; x=1783949156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i2H1BWjECxL+ndRpM0G8dO55TgrT9WVFV5Uqt7ArYKg=;
 b=pvbBdbxPHb4MiWXQ7vuuN8cIEaBSaaCsstIFXrCengvxNYN2xM+d+3zvUt740ErzuW
 /YtDzjxbw2Gz42QTKTO9r4hOFMvTzm8EkPxs/4wSPHdVkmyFv5BeTXB2aW0811Zsa8q9
 93hBOIQnMAsLqrBVJ7o0oa2NHdeT1YPssDLDmJs74NMXpEAL3tE/6Tgi0VY6xmkZs/zk
 T2yqciM5t/vNoeMXy3FFqKhrZyfP/hEkzipUoX0WjZru8kVi/V7YUELII3VIS6JkFf2W
 4+hyb6m312RdcFKpMGE5c5r0+gm+UYboCF+6c5+JaqvudDCwZD901UkJqSwYOi6pUoVm
 nrpw==
X-Gm-Message-State: AOJu0YwyUVRokwDZ2APe1ZG5m+UCik86EzhZ05PURwPth3QPowH3aRxL
 f8PbmQ2eRrzrLzQi9q9yfalMC5rfyPQvgFKZuIYnCJH//xHrzh3HOzLTQcD2jE4mgIdj/B4Lw23
 U4of5JzbMT8ftEkIEoJuQefWUHyh5tSduQiikxgk5RTPGIFT++/8rg4RWa34f6KUtuA==
X-Gm-Gg: AfdE7ckjNN86sZzRGtf1gkcY/rVevxmkVlyqRz9JY4xb764m5kCqNjBNcd1b/+wsZ2P
 dcvGGD3tsc1/h31nkAFIe7eBe3syXn5TCyRQeZY9kr4QJY9CxriMQY+vV2RevjlT49ejUqfvAXo
 sz7ETCMVaqiKzv+VCVqZWTJ0HJ3XUgRm9/cXvz7b9u6bkm6UbPy5oG2KS5CsWJxJrkXBL1RURyQ
 sPqg2F9LvFAjGDUHeZTTYfHf3O/iNHa/ZI9xRId4jaVwZsEE2CyfAY5f6znHFo1wOwF3sEwiQl9
 yrmSTfESYF8601Q1XZaSGLyudT/Owz9gxlL3xTa87dNFh+PyNfobwC95lTri8atn7/nT9mW9Ecu
 hHfOkvkEjX1GM1SrJaSEiXvW0JLl9Ys82QYO5DHeKbADcBDkP6A==
X-Received: by 2002:a05:620a:1d01:b0:915:a953:4b9c with SMTP id
 af79cd13be357-92ebb528be9mr79813685a.3.1783344356341; 
 Mon, 06 Jul 2026 06:25:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1d01:b0:915:a953:4b9c with SMTP id
 af79cd13be357-92ebb528be9mr79808985a.3.1783344355882; 
 Mon, 06 Jul 2026 06:25:55 -0700 (PDT)
Received: from [10.237.61.207] (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ea60sm328489755e9.3.2026.07.06.06.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 06:25:55 -0700 (PDT)
Message-ID: <519f6e43-5273-4426-b673-71cff44daffa@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] hw/arm/fsl-imx8mp: Add inital FlexCAN support
Content-Language: en-US
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20260702184038.178196-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702184038.178196-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DuaxY61UlAaQqkKoHQ_zr7Ai_D5wJcmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX/X1z3YhPVgHG
 8TDiQ4xMEzVYXolC8JdKPIfZRjPK/8Wl3ylNUw03Vn3CrzGe06CBxaGF0ZClW8nnjBIE3yM4XoZ
 sMUuUVLvhfDCIxgu6Q8O6mAkD0Dyx3h2XOo/i6YWG7wD4sa1LTvvMmVSUWvDg/mVtT/znFGXl1g
 1dCEpGWijep0an7yReulKYo+7p0gM2hhjWgP4EBL4rNSyXCfW+3nszKbAY6xvD6e4E/gXfPlq/m
 JMnTyTwC61sRjtDXLysZZdezuEKL7GSjEVwwI4XIbkgIle3RVIRBes/lXUk+o3sioUj/aF3w8rk
 RK56H/SDEOev+F+KDlutoSUsamhvHg/9hPkz8RHivwcKlHQPRep+n024qLSQ9JJKPIv4TcpAFDL
 Lqy+lYgchLik2k/0z95fSvEtFmwR650aiPouXLTLzDP/qzKJIMy6TELOWJTyQdwT/nHks7hqSn1
 1BNl/4z1KHP35yhLkUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX6+i151gaS+oR
 twSPUScmjm+qpAROKLpioUweTkGOpm/tMJ9oSq/P5WB8AlrqbdkfyHNIqc28Y8VoRpnY1OYhuwH
 qbZ3nKQnb8M4m4ZK1cfmq+jWEnoqai0=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bace4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W8GxKYvp-U_uN4L4a4oA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: DuaxY61UlAaQqkKoHQ_zr7Ai_D5wJcmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060137
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

On 2/7/26 20:40, Bernhard Beschow wrote:
> Now that FlexCAN emulation has landed in master, let's add it to imx8mp-evk as
> well. While the real i.MX8M Plus supports CAN FD which isn't emulated yet, the
> non-FD mode works well under Linux: It is possible to use `cangen` and `candump`
> either way on the host and on the guest, as described in
> docs/system/devices/can.rst.
> 
> This series consists of five patches where the first four are preparations.
> The last patch integrates FlexCAN into the i.MX8M Plus SoC and EVK board. The
> first preparation addresses the review comment from [1], and could be applied
> independently.
> 
> It would be nice if this series could make it into 11.1.
> 
> Testing done:
> * Start imx8mp-evk and run `cangen can0` there. Observe on the host that
> `candump vcan0` prints the traffic.
> * `make check`
> 
> v2:
> Thanks for the very helpful and super quick review, Phil! Here we go:
> * Add patch "hw/net/can/flexcan: Wire clock control module via link property"
> * Have separate MemoryRegionOps for 32 and 64 bit
> 
> [1] https://lore.kernel.org/qemu-devel/77d5891c-de12-467e-8746-02fe43121e3e@oss.qualcomm.com/
> ---
> base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799
> 
> Bernhard Beschow (5):
>    hw/net/can/flexcan: Wire clock control module via link property
>    hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
>    hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
>    hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
>    hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk

Peter, you just sent your (IIUC) last target-arm PR. I'm about
to post my hw-misc one, do you mind if you take this series which
is fully reviewed/tested?

Regards,

Phil.

