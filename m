Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C012C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlixe-000180-OY; Mon, 20 Jul 2026 04:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlixa-00017T-0D
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:02:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlixX-0007Wn-RH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:02:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RgRE1774812
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fYFJbVC56wtm9QpaFmE7CANMo1dENcAM3SfUOhyvOfE=; b=mEE7dIvhkdINXFm+
 E92wkKRIeQNPRE9TR1k5yK7Bz8Gg5oZ7JP+ZPUYfBa7DKBzrdC7Qg/ftBiH2abtm
 7Irxcyz6o3033EfY+hHbA5ag2jWqOWRdEZMT1bch4ZulNJAv21jEnItf70ccyatt
 rEh55Wonz8b/khSPaJR0sY98exRQFO/BBFwRQYkosSPSdpnfTQMB37OxMDnWACXb
 gwOBCyLlfxeJxx7MiwE9fez4F7vqKcvzEQLBt4GzkcHVyyqVfaDcz7wcggMQk+XB
 O9G5Bt6F3rCZFX5nmGwpUXgsnh4RFsrEJnGga6N3KM/my75qxyUrYILHlCSklBlS
 p/LTbQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af5316-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:02:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0199faafso143480021cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784534561; x=1785139361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fYFJbVC56wtm9QpaFmE7CANMo1dENcAM3SfUOhyvOfE=;
 b=ME5HldSch7oKoURKqhFLkdiO/CecHgt5wC4/Cz0nu9k7pjAWfi1FzmjW01Hql5ANXJ
 ges2x55FTe4IZzBmQGbjguX7aLV6bHj08DNbEFplrJy2yAvNL0R+mr6enLPqc8XrgISi
 NOCp2Zjm8Y6eutjUyTgSNlT/uoWiJUCWl6SsfE62Vvz1tTpHbvM3uKUbkBQEY8JfC/Mz
 l159S/c6o76dJW9RfovmCbxMPmVe+Z3zu45AKnnwkpH3zWnuyr6dOLy5NnKW+TgEzlmu
 dz/MAjz7M9/P4bxJeWZX/KTFz4AW8G//23QGZ9k3kM7erE2XG8dViUkJ23mjc7/IbWDX
 0/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534561; x=1785139361;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYFJbVC56wtm9QpaFmE7CANMo1dENcAM3SfUOhyvOfE=;
 b=OWp4m5bnqov3ZV/b2mt2wt7NvvzsEqnq7jfGHw02ahQOojAOApYc1d2D+Q5xPfa+aT
 RKwpQIM7yepnVwy6cXzIc3e6B4PJAIN0zQlEMTmLprTcAgzvlpkOjLp+nv8Gam7A3Zb5
 h+a1aZ51BZB7T6Xj1N/whmg+H0EblRavyIf0AW2/QEhJf6FZzISQs9s64MnkBBcyKz7U
 EkGpnFvbDQRdgs7/nC/qeRzoB/prIi9GmqkQ4nit2KGO4RN7iPfb+AOVMqT4uGSjP7xr
 6HFeK/Le+urpS9+hUKePfaOSiMO6eoUEl9lgUdDBlo3xIfAjqM9KXnAgL17G4rL+aDzX
 Bcaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqG8M1E6aRqepU2mHr+Lr+Y7InKTKr5p6KKuCHpZWCIXbtGotntLXaj0tNuw/vJ6OaP2bTq2cINRaDj@nongnu.org
X-Gm-Message-State: AOJu0YygFFRs3RaWcznoArHDPY5QZMtsHwBiTIvb30icxU+S/l5QkkTH
 K7x+p64ENc+nb/rrXOnC5KWZ8YtInIhW3ehePKOApMOyrSKovKhd+Pg518yYyBJ4y7uNYrklACm
 UXP5xq3uDM4Kf3lupcyqtjCbwXppZWACdeTPb6oaCk7tYwNpLrfLWGR3cZA==
X-Gm-Gg: AfdE7cn6Cjwuc3ZQ2oUn6OSDoR3OIQOTQ/lmnF2EDwWeALFYz7msUVovspAlcUns7Cp
 3GKWobcY1YQOeMHFzDSVoQXDUro8UGQWY9NblYMl14NUs5CFuwXQUeqUGaRQkTCZTf1cyq9iJTT
 CRSj7Lbz7Xtr0Op2wcUiO8mjnO1fCT5sJmNLClK26YMEInq+ZihV11LBfR/Vhf8DeVrANmKEbT4
 NK7VpFPUvnyzCklZykh0bFPGrrSdKLZOmSNRpyXPDL+7qUVGiwvCksR5V5NhwQmhaE0Lh54bUte
 CFUFULoElK77ZXAT//gl2lKO8Q4gzJbU76JaTNrCEUyb1GjNMhx1g+ePknPAuRYjOqf+7qqu9Kd
 RmGUgmhu6AvICQv5AHd5AcT22hcmPEarwS+0vYapk7vuLZ+GT46o=
X-Received: by 2002:ac8:5705:0:b0:51c:24c:59de with SMTP id
 d75a77b69052e-5213ed774a2mr113575291cf.72.1784534561396; 
 Mon, 20 Jul 2026 01:02:41 -0700 (PDT)
X-Received: by 2002:ac8:5705:0:b0:51c:24c:59de with SMTP id
 d75a77b69052e-5213ed774a2mr113575121cf.72.1784534560900; 
 Mon, 20 Jul 2026 01:02:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a36312sm282527975e9.2.2026.07.20.01.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:02:39 -0700 (PDT)
Message-ID: <8f9335dc-86b5-4c12-a608-9e89b0828fc6@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/misc/applesmc: populate Apple SMC key table
Content-Language: en-US
To: Matthew Jackson <matthew@pq.io>, qemu-devel@nongnu.org
Cc: philmd@mailo.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, thuth@redhat.com
References: <20260507152030.48753-1-matthew@pq.io>
 <20260601152847.26916-1-matthew@pq.io> <20260601152847.26916-3-matthew@pq.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260601152847.26916-3-matthew@pq.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXzVTgKMqE3jFu
 dPhXAZR/uPchUMmLLGUlIylNmeSxfnYkAICZLAsEmVBoqbZc66+PmyxRrZ11OjTwdzM2qzVL8SV
 Xh2VxVybqO5HXvQkEO5ih+pQFrjBRxc=
X-Proofpoint-GUID: hqJgBpJf6HgkWcIOFTybUU3CUdc4ohuB
X-Proofpoint-ORIG-GUID: hqJgBpJf6HgkWcIOFTybUU3CUdc4ohuB
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5dd622 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=xVuscgmnAAAA:8 a=oakljCaMmmysf0hPbkIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=vnkFwwgN4siT8HrQ9gDI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXxB2I9zfSfO5q
 out2BuWzI216F6+KJtks3jlwiDX++E7TyfgQsuJa9Q9jAMJDawXfdRKRDzjZoe+7zslUpnAYKGD
 Cx3roULFAbY90EEBLkUoZH1u5laLjx/H3dMXxRGvm9S50UO/U2qO7qAeHWYQ0zZDSopcR30RVa3
 LuNRI5l0WqRihjyCoc10NTjUwZm6OFjyMnp1hNktwAZefTM2XBw02DNq/jp3O0axE4+e8D+v2CY
 AUB3PQOPF8sNJie8dnSalnP4ykJeBoOt3ee7u0aF+z4v+A0gzbE105JXwsTazuDTc7Z9wWxyiT2
 QrgEQJ06VxN+cOQGw2ML7GodgnErjZ10j1FmcaKoJDR5nI/EmCuFeZhqjSg+QbmkEZiYS7SxaPq
 sFXAh/GfTDP9/7aiohfLeGtQHXOLq2d3XVqPR2L0WcCHLlqAkdG6iBYV1RQ+z8lTZIRkFCZvtM5
 AGMoi5mSajq0eA8sESQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088
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

On 1/6/26 17:28, Matthew Jackson wrote:
> With APPLESMC_GET_KEY_BY_INDEX_CMD now functional (previous
> patch), the modern macOS AppleSMC kext walks the device's key
> table at boot to discover what's available. The current key
> set (REV/OSK0/OSK1/NATJ/MSSP/MSSD) is sparse enough that
> several macOS subsystems retry-poll keys they expect to find,
> contributing to the same kSMCSpuriousData traffic the previous
> patch addresses.
> 
> This patch fills the key table out to a complete iMac20,1
> profile (94 additional keys plus the canonical #KEY count).
> Sensor values match a real iMac20,1 idle probe published at:
> 
>    https://linux-hardware.org/?probe=999fc708a4&log=sensors
> 
> Categories:
> 
>    * 28 temperature sensors in sp78 format with idle readings
>      from the probe: CPU 40 C (TC0P) / 45 C (TC0F) / 51 C
>      (TCXc), GPU 36 C (TG0P) / 42 C (TG0F/TG1F/TGDD), HDD
>      41 C (TH0P/TH1C/TH1F), LCD 28-29 C (TL0V/TL1V), memory
>      34-36 C (TM0V/TM0P), ambient 24 C (TA0V), PSU 33 C
>      (Tp00/Tp2F), generic sensors 33 C (Ts*S, TS0V), VRM
>      50 C (TVMD/TVmS/TVSL/TVSR; not in the probe, conservative
>      estimate). Battery sensors (TB0T/TB1T/TB2T) are
>      present-with-zero because iMacs have no battery; macOS's
>      "absent vs broken" distinction relies on the key being
>      registered even with a zero reading.
> 
>    * 4 fan keys (FNum/F0Ac/F0Mn/F0Mx) describing iMac20,1's
>      single chassis fan: 1 fan, current 1200 RPM (= F0Mn,
>      matching the probe-reported idle), min 1200, max 3600.
>      fpe2 encoding (raw = RPM * 4, big-endian).
> 
>    * 12 power-rail keys (PC0R/PCPC/PCPG/PCPT/PfCP/PfCT/PfGT/
>      PfHT/PfM0/PfST/PSTR/PHDC) for telemetry; present-with-
>      zero satisfies macOS without claiming a specific value.
> 
>    * 6 DIMM keys (DM0P/DM0S/DM1P/DM1S/MD1R/MD1W); same
>      rationale.
> 
>    * 11 SMC-internal bookkeeping keys (CLKH/DICT/RPlt/SBFL/
>      VRTC/WKTP plus 5 lower-case Apple-private bookkeeping
>      keys cePn/cmDU/maNN/mxT1/zEPD); same rationale.
> 
>    * 13 motion-sensor / wireless keys (MSAc/MSAf/MSAg/MSAi/
>      MSGA/MSHP/MSPA/MTLV/QCLV/QENA/WIr0/WIw0/WIz0). Present-
>      with-zero is the correct desktop-class answer.
> 
>    * 3 write targets that must also be readable: HE0N (iGPU
>      power; AGPM driver writes 1 on start), MSDW, NTOK.
> 
>    * 2 power-management gates required by AGPM and the
>      watchdog probe: HE2N (dGPU power enable), WDTC.
> 
>    * 8 platform-identity / probe keys (MPRO/MPRD/LGPB/BSLN/
>      EPCI/BEMB/$Adr/RGEN/DPLM/MSSW/OSWD): VirtualSMC-style
>      identity plus the early boot-time SMC probe keys.
> 
>    * 2 GPU temperature sensors (TGDD/TG0P) and #KEY (the
>      Apple-canonical total-keys count, computed by walking
>      the data_def list at realize time).
> 
>    * 1 VirtualSMC-compatible $Num key (some drivers prefer it
>      over #KEY).
> 
> After this patch, with the protocol fix from the previous
> patch in place, a Sequoia 15.7.5 guest boots without the SMC
> retry storm:
> 
>     Metric           | Before   | After
>     -----------------|---------:|------:
>     SMC errors / 5s  |   9,225  |     2
>     kernel_task CPU  |    70 %  |  ~2 %
>     WindowServer CPU |   509 %  |  ~6 %
> 
> Legacy macOS guests (10.11-10.13) that do not iterate the
> key space see no behavioural change beyond the corrected
> MSSD value (now 0x03 as on real iMac20,1 hardware) and the
> fact that READ on a previously-unknown key returns zeros
> instead of NOEXIST.
> 
> Signed-off-by: Matthew Jackson <matthew@pq.io>
> ---
>   hw/misc/applesmc.c | 169 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 263b2251b0..38062a07b5 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -32,7 +32,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/isa/isa.h"
> -#include "hw/core/qdev-properties.h"
> +#include "hw/qdev-properties.h"

Invalid change?


