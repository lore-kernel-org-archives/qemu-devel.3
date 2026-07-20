Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC9C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlizE-0001Zw-8O; Mon, 20 Jul 2026 04:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlizB-0001Z8-HG
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:04:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wliz7-0007cX-TD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:04:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6Ro8V1263202
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xkqXMSJlI9CkZwZCjy9nC4vIhQiBa2+Yu5nI0eqsvVs=; b=ZbvH7yVHt7BYuwox
 f13OZVevBxVZpiGN4VkSUPXyv39l9gPdwtUFP1VgLIb75A1GlJBtO7PtUswGzGy/
 zZL/Y0ydggbSAjr9sHeCjQNAQxDi5lJXKT88jSVIHLBFTEqOAoQJx1syyYHOQ00x
 Yf7zBXVjVzuUGfWAIxcHYGO3xquDWoo9U2E4HmS4qdiYVwdnbOQlZCRrd8XYDO4w
 FnMHX/vy5tQqw9ang2RH+o3WiqAsFMgl4/YtyP9jGgHhAvaXR35lxGjLugSwyEYU
 OdgIkrBPp6v8UiUPMMD9ZW3u6bivQIx5+Cvi/XnEtmLllZrfpJ6HdAE9l+OPkX1y
 +FalGQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhn2mx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:04:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so261958651cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784534659; x=1785139459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xkqXMSJlI9CkZwZCjy9nC4vIhQiBa2+Yu5nI0eqsvVs=;
 b=PdByVUD7mQpXsjoGmRsfv15QqL80gm1oBo4IoihS2kk0gth6qYGBenv6IHS+wFeERg
 JPi2rMCebY/dop7k3FHTXtm0D+H/iAbhZc8GmVUpQJh7vz0NxIsERpcT5cpugs9+9vlW
 lJJJf1KbqKjF5TAJdY37dIYEgS9RJs++uUPZt0P8pMavWcyL7I7/hJ3TicVOQd3aMnUD
 jBGj41nF8klIalnbJAHRaIIUisN1XvWyF8+MQnlsPyhOOVt6dqJji2XlIgMEiGq0CACT
 guBmuZgGUq0ZlEnD0GkZmYmkOg2kw3uL2uU0jnN6fh9zwvkLdzhKa2CA7HFfx9eyR6xV
 PL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534659; x=1785139459;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xkqXMSJlI9CkZwZCjy9nC4vIhQiBa2+Yu5nI0eqsvVs=;
 b=gjXltuJufZfKv88G+VLuOvGNcZAwhw9MFYkhGyumZrV8GiJ1+jGa6kjkwAIcjrP8zL
 J5RIz7t6ZaGTCSZR+WQtpRARMGiNVkUucJ+DfXqkRiNx3slmmEyeTkpKl8lh2zIVNDaJ
 9/pBbIrV58L/NrJaPt8zO8tOacl/uqLCsaOr0ooW9JRtOv+9zPQVhAySkgskUmilp/zO
 LAtPM1OQDBI9PoDZAN5+NaMKQHb8UIlOTZnu/capQKsegyD7VTgMBvlAZdRzsrkqyQOu
 Wm6ISaDMtP/b/HFmfR1tvKdhMAQBOJ7hbzGIv5D66DTsQFnRECity5cHWlyjod3oB1Wz
 yQ7A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rom/X70EdSWCdK+/t6LTgoEH1uIQn6qV83z6p7z8PohGhRYmVpVc2bP01DxXnWMW1ob70D0BIGGivEq@nongnu.org
X-Gm-Message-State: AOJu0Yych85jPV0rn/C9o+4PFayO6XZNAAa9zt/6xVS/4hot3qx6s4qq
 lkE75DSYtrA23hBM8LvXWS7pt/bdphSha2ecJDPA38c3jLz5X0/CYBr6peDcO4SH/6Dhc3oXwe9
 BwhuePBDtn2B79+U28KnFlwqZKAFgRcYkYTL8y/rADFHg+1lA/AF8SgRLqQ==
X-Gm-Gg: AfdE7cmX9pw4a4timVFSlebRfI8gKSlY2V+xPXNAAC75Vw5+RBTVrfnNXOYU6TKY6ZE
 ZDvvRcrt5SYB/ly7A3wozDudsjTVUSePZFGdxYdA+dcKBXnCBvzUe05bjJmGzgEWJVKWwataK/d
 qFkY0mMeMReFpdRkE8UwvDSrzTng65gXDNu9l1B5//ocyiIzPWWAYmhfKjq5N0qd0ENQCroqnQm
 ePtLqBl5GvpuwDzYqNB5LWDTz2VhDg92e/Go97ISZzbqLjiaSedCv/JLuse7y0QMcLZtaU6Z4ux
 mMxGNaduCMBh8USmcq7kOHVOAeC6+8Pd1U+miy4VELz47wQ+KGwrkXR8WPLLzgIU/KIJ4EoXx9/
 5XntyOY5MBDeEbJYRPByyhWY/igPb3+K+w/mu2pkEAEYPHKMIrTY=
X-Received: by 2002:ac8:7f56:0:b0:51c:f04:4aa9 with SMTP id
 d75a77b69052e-5213ced03f9mr126994211cf.32.1784534658910; 
 Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
X-Received: by 2002:ac8:7f56:0:b0:51c:f04:4aa9 with SMTP id
 d75a77b69052e-5213ced03f9mr126993961cf.32.1784534658433; 
 Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2edda2sm246448545e9.13.2026.07.20.01.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:04:17 -0700 (PDT)
Message-ID: <6807fbd7-542c-4e94-a3c7-e29e957655c9@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/misc/applesmc: populate Apple SMC key table
Content-Language: en-US
To: Matthew Jackson <matthew@pq.io>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, peter.maydell@linaro.org
References: <20260507040153.14565-1-matthew@pq.io>
 <20260719152343.69536-3-matthew@pq.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260719152343.69536-3-matthew@pq.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5dd684 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=xVuscgmnAAAA:8 a=oakljCaMmmysf0hPbkIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=vnkFwwgN4siT8HrQ9gDI:22
X-Proofpoint-GUID: nwCcr4doXc_ylN3CjoBJWGG6teEJ53YI
X-Proofpoint-ORIG-GUID: nwCcr4doXc_ylN3CjoBJWGG6teEJ53YI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX8OV30mzTn1Zb
 tvwOnQNJDSdz2ZK7ohSC9Z5l5Apy9FghlCg6HA5g7geN9gT5x9/2Q0M6yxzPzalbT+vt5VpCDnX
 sRTBMgKZu0QznKnp2sgBPK/YeU7USYxrE/qmwVFzY+A3IoTpOe37d89v7u1VgNiLn5tB/vgO8/6
 icDwjevwAKoR0j6iSLcAT1Uu3WdrIQReIq+j1UQ8RlbEkOHEUya6VowXo/WNzKCy01BrjsLAcvQ
 mVDnqF67AgZFxY8wuakJSPFIMIglFtgcVsCycu/VyroiqYRzzKyZieFtyuk0UfWJnK6Y6vsyeHV
 snUswL4JtmgW6oMY14gZ/p/UfFNdqzLOzLMIqJ5+pm9miulp5pjxVIgAfQ3cytNLmTs7FNlpb5N
 TKJeoTckwclL/kqpvJP+M2EtO7rQIqXf/0byKsPihCeWUZZDrYc74NHA+vHaltRDASe8i5AEPld
 /ypn6w/j9dEVpagO1fA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX48rVJrljOTQi
 7jvzKiQ+W9UAegwC45Y8HH93H4YnHOgKlBYWI5SeGZrJUCX/HmU6UVI8duyMw9kBvn9XPEZjbR0
 J2OpS2I/mn/xOdLU6mkE2TdbUXxPWC4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 19/7/26 17:23, Matthew Jackson wrote:
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
> index 2b5ef3c..d11fb32 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -32,7 +32,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/isa/isa.h"
> -#include "hw/core/qdev-properties.h"
> +#include "hw/qdev-properties.h"

Something seems wrong in your tree.

