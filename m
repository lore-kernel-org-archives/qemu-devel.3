Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFB9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFYr-00065D-Na; Wed, 12 Aug 2026 16:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuFYq-00064M-5v
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:28:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuFYn-000875-Uh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:28:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2LAF1743335
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 20:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L4twhbuOYE+OQiSG5nk2uhYLdr39f2xERddcL38MXLs=; b=MR5OPwS8nDht2VPO
 rXPivY832Dz29NrYFuci/5rjTz7+Ij7C1O4eNpn/zw57MwVMAiFTWrHIzWfTPwFq
 gXUQ+HZv0vQl1rxMYGsf9hc0mCkCi6AegyMC8ivtcSBsUJzF/UWbxWvo163zd9e0
 JCcH3UPseeWNR9VfRhDuR/6mmsiNx+UaxUPN/zgGK8Ko0+hg1gKAdSBUuA152GYi
 Im6ZTUYMNVGIhITectR+ksNmZQwolKabCDJ2/jm4EUa44l/UmubPtwFVGy+LPUzm
 YO4yFijZC98ZwHV9GGvUWdpLuFk7oMLpfTZ10tyZgHdVq0HXNPuzuGqc8hX4bZAd
 nNYLNA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nutb1ng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 20:28:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so3889201cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786566503; x=1787171303; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L4twhbuOYE+OQiSG5nk2uhYLdr39f2xERddcL38MXLs=;
 b=AsEDfvst7rxnsf9LsKsOtq2zFvsOdDpWuO4JmaOtIA+n1uoTzBCEMzHG82WGVojYTN
 Cwe4lh0eTrpJvELIvX85xd8qsAIge1uvYg8k2UcOEY0Ix8+Q4C0GPYnlReO97HbSuDyi
 he7swu3g6bsI54MSg5yb8z33J8ZWl41f0zLJ4/vsESWUu8HtxrKPJ+F77+C05Zlk1xpV
 6igH06Tj5GbrxP2yybasbUF7gE3UToxA96mrkhMKeRA0jXBfM/SRtvnIAFoQin+uiE3R
 KpG7lr/+wtWrmjGvkDndlCDXqVM8qct0T1ODSywzhFKJUmzdf8ozHom1Wv7cGq6GIDZV
 hPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786566503; x=1787171303;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L4twhbuOYE+OQiSG5nk2uhYLdr39f2xERddcL38MXLs=;
 b=gaoV3wyvtPPo3BFdjoBKlk3YTqK16ShR8j7Mo1HRsFj+aECkSsrzHiW0BbUAfzAYM9
 MeFDAIlXCBir0uYOrP7JFXHR+gxZ+mZvdN5pWWxDtZyHN/yMQV6nyX+GSAKBHxu9bMLt
 mB1L/Idcl6s8yN+vtxW5iFR3+cbnWc4xF40a4reh6jF7NlW/kbilqO5lIWsmcOPM5cEb
 MPY295ZeTNoYpaiGPb+Y0MfOKz8OljwXKj0nJKPaxdgTnWIlsR8pPQXKHX6dSSNj151B
 8cGJt7/X3ji10/biim5/ExvRFVM8YcJuY5aM0K/e4utmH6HIH66EbI3GI8Pv+xrHwzV6
 a1QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdJHjSSr1w4INqV/MUfEr+DLdgsFvIWNfixMziiDtnt5ACOGFOpRwKOPO9RXh8vwKvtxxtSWajUfcr@nongnu.org
X-Gm-Message-State: AOJu0YyvTwU50WLEiNX7b7/4ysNWHbYwVQzpnHnyX7Fu/qIs+vtavUQG
 I/6Mwfw6+CJoDOvKTlNpZCPXeTdZcjE8QtmMKJN7kHEyJfmZt9V7ZkmqyfS4sqRXuV2aYHDHNXj
 XmXgUiq5/CTONYCFngww6LGSdSLtwaawPnxNm/rBKTK4JIS1qFgVDFNX5zw==
X-Gm-Gg: AR+sD12+DZMk4rb0U2/5dU6ZPrkju8Z/VfCfVrm15iO4QWc2X09atuh0ZevMKjghMpi
 +G44RkWB8I8WKeXvQcY43feDqpTHTkn4LmUW52oJzi4tR52ISpV2+LU9M+JVI2YUjaxg/3qNLFt
 9Z3Tjc4GKFHEtU4n16vZjVM7YQ9eEVFrs6rlQyJev9rXXcZcIh+43cjhGqAQ+OimtFFBM7rpKpN
 EqROCzSRkVVy2OWRZZpz8c7BIJvLxI+6Ni6kxCH5cebz/Gt4f+ebx1jtjwJXgfD7T7CZyFGr2E2
 DYKGz5Im/r8PI7sJx/7tivVCNouD1xGzzzFZ2Ox5TixDq3FDAjaxo8Sck8Y+ou1o0ZlIXNxN72l
 WeqyKmVa79xkyaWhfYnN7GaCbZY0rob6a4v0=
X-Received: by 2002:a05:622a:2cd:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-52d74b9a259mr2816201cf.19.1786566502732; 
 Wed, 12 Aug 2026 13:28:22 -0700 (PDT)
X-Received: by 2002:a05:622a:2cd:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-52d74b9a259mr2815681cf.19.1786566502254; 
 Wed, 12 Aug 2026 13:28:22 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569c2bsm328204f8f.12.2026.08.12.13.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 13:28:21 -0700 (PDT)
Message-ID: <c776950f-0c86-47fb-a584-ac82e82d87d1@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 22:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc: Fix arm kvm gicv3 selection
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260812200308.289238-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812200308.289238-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2NCBTYWx0ZWRfX8nU29W7MW5UU
 tgLHB4E3WLuEt1jhDKaZA+bulsXwSb2qSDCe65f/giLE3+58lyTIkjm9EBtL2sCJQL0s+8PKF+/
 oimHONUjWJ3Tpzzp7vLHs0RGozVHRwY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2NCBTYWx0ZWRfXz+MQfjfVxVMP
 k0Na19TEtJP8wAwVDtYF7xwK6Wuelcjzia+kXRWWelovD578sPvqOFmO2dnCeo8dEPhx25ZkhYs
 h2WoYcB/QAAyMovxtlYuc5ONTKPKddL1I5Ydqd6ha7EU8NEt/emlMESqT/WwUonNX8DIjKMpMJT
 U3PK5QDenWR4F2gMwVRwtXMSSKuvA0ut3f6XkMkKD8bLgKn+hfCC6oGP0aww2dWoAdlDIQl4YgD
 3astmWxCNFKMmnQUvb2BYGuwVrqXMNhpplK+XbXBh5tjUDYbthvN0CNaf3dnK6ru6SbwGWz87np
 ZUOGv0T/mLNfRrMpjDgFkmMgGxtAX5nyzvR4MCfv4y05DIuKNnlYa4JiPt2SgPflKrqHbDCBDu0
 7mOOyQw+pL1dw4eBiiOGT967D+/GEQZQpFCASHDt9cadcVuMD8q+QJecwXEoPmbKICSNs6/0iVd
 K9jl7T8wEs+0qaCaINQ==
X-Proofpoint-ORIG-GUID: lNjvc1FXPjICj2j2a_WbcwehqXkynmXc
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7cd767 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=GLgtxZkTpiWVOBUrDW0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lNjvc1FXPjICj2j2a_WbcwehqXkynmXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120164
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

On 12/8/26 22:03, Richard Henderson wrote:
> While 39a8c3941e may have fixed WHPX, it certainly didn't help KVM:
> 
>    $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-cpu-features
>    ...
>    qemu-system-aarch64: unknown type 'kvm-arm-gicv3'
> 
> That patch did remove a test for TARGET_AARCH64, which is fine because
> it has been a long time since we supported KVM for AArch32.
> 
> Fixes: 39a8c3941e ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/intc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index a1401cb521..faf63a0145 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -48,7 +48,7 @@ specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
>   specific_ss.add(when: ['CONFIG_WHPX', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_whpx.c'))
>   specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
>   stub_ss.add(files('arm_gicv3_hvf_stub.c'))
> -specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
> +specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
>   specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
>   specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))

Yeah sorry.

The other fix I mentioned but never posted is:

-- >8 --
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 636d00b7e88..1fec78f3bf1 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,7 +23,7 @@ config APIC

  config ARM_GIC
      bool
-    select ARM_GICV3 if TCG
+    select ARM_GICV3 if TCG || HVF || WHPX
      select ARM_GIC_KVM if KVM
      select MSI_NONBROKEN

---

