Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A73ACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5u5-0008NJ-MW; Mon, 15 Jun 2026 07:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5u4-0008Jv-Hh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:54:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5u3-0007Nd-3c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:54:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoKco3972218
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F9xyfeJZi/F+sQMWR3d6d3d2zzj9lZVmXmtWeKDn/ac=; b=Lvj4iNFe/+DUy/BU
 pHanCTRODtdQFXaYsGGdsSU87/ad4on6UPyDUdOaqoYZwFVjgbd4J5kOfWfq5hlm
 coKr+EhChePIPcFXsA+X0bJTmOwQtIfeCeNrl+G3G2oUMWCz67ffT5ypL+jxweSd
 oI9tbJtKi51k2TEWomwfuhmZiVHdMzuK1f4A+Vh1kEtHWo20VN3y9KRb7mKvNgmT
 6oNByLQq6RR1PXHUqYFy5R+z4cTUbO0Y9tIh+NXYZGV7sublviDoQCgq5FfT7R7f
 OExI3XYtholihZHBEw3lYji/jUWLHxzdgiGmPWVv0zVjfsYc1lw1Oh/D7jhVGgnW
 iKKbJQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteyd8fy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:54:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915f7bd027eso892847985a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781524493; x=1782129293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9xyfeJZi/F+sQMWR3d6d3d2zzj9lZVmXmtWeKDn/ac=;
 b=CLppAplk1LksLViQaKb0GBmyE/Yoa1+pvgJeS6Xorlff3miVzKiqFhQykoYusRSkaZ
 zUksrmZP2Qg3nhLEkGNq1T/2HOB/YfqBjCsIS1CbcJvMdI3Q+IGI0sFTmuFGOaSXIA+o
 2zurGKCzyzV84/XIes/BGNVGnr2A8YArdmUtv+2Vgzcstnt1F7vdfAgK15Mu4zJBnIWZ
 DzcU2KKJSz0AjSTaqd41qIq+5LrqYcnIHxcePwJ/HDkJNoDuRU50om98t3qoHP+MKRdz
 Pt6CIdJQ3tpH6aUH70po6J7NBmarvbCAn4C7/xGtXoiy3FEVj8YKI37JPzvDI1ddZuGt
 eJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524493; x=1782129293;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9xyfeJZi/F+sQMWR3d6d3d2zzj9lZVmXmtWeKDn/ac=;
 b=m077YVEp0bqS1Db/hLEIBiu+DDPhnFbWiRuclczBv52V+WP0aiC/0tW4dyhMdAQ2kU
 3Z1IqCpPXtK3dUcaButCnGA8uTXhFkon7pWc/poiEh7O+gFSlv3lTnx3SLs06gjGODw9
 R3U+d+lxiUwsd0ndSpwrvcW5LgLC/QokhWbYoHoMJmzeUx4JolUK9+YFqlv2pQRPF5N1
 dqOaNt7edGyXvuii1j9NGo/nd7tYeh3lKOWhwSHGfBEV2qhpM+UcBPf5SmwaumFH/2YB
 uR+42PUZWwenRKKYoPD4D66nLIPMr78fd+d5BWq+r6IO5ZNyXDd4EqhPrcEqWh4sTuya
 qIYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WCmGocSBDKATWAwttRED8zvfRQZYSYI911m2N7egKn0ZgyPB2YL4H86aJOK1Qk7VXKlVbqLUr5Aq1@nongnu.org
X-Gm-Message-State: AOJu0Yx2tj2OUF2hcC4ZxoavFYkhU3irlEHMaFqmFDn/S8Jo8Jvujwdu
 oSoUoDaYsAsXuXd6xmKZgIC6gT0tYrlVHWAiMERu9OoY0NKmesp4/tRkP1FPOutYS4ggSiaPdH1
 ESTizfHd1NlW3sU8WRHfC7xCbtdCy4RTWb0lpibiobowYq2672sNKgpwY0Q==
X-Gm-Gg: Acq92OFnP4JA4eNwSbdhvGOP+H2TSKtMgarVxhqLifsOnb7HCpcCUu1Cru/M67g+mZY
 t7/Fi2lBk8ENEHHJhCMnWvb6C8CS+DtXwL6HdP6rXTec89mi+frFOdJ6rgQH0r9oilUtnFBPEaY
 o/eeHUZrDvJ6OmbkPu4b5c5LoTBbSRAw1/QKgO/Djga6IcE3iBrS8a4QFdiHgbBdFD7jeEvlI9c
 BzH0mosHVkW9KmfCcVCMEwjrPHrM7aU853DESkW3+OnwmGvJcO5sJnQiKdZTutto0vs67GkXiAX
 1rSuqsj03Tg1W0exWLbbOt3tm1h3A4y9+5lezam+x4zsZfQ7qO98Ssiaw44D/G5BmDX5M1sYyZg
 T2/sAL4/5hawhA1q5d/NkkvqnteLHdZT5d5ZNJ+GSA5zry19RJsp3625WA3frELUWTnNJJjYQ
X-Received: by 2002:a05:620a:2992:b0:915:86a4:6691 with SMTP id
 af79cd13be357-917efbbd2d6mr1736813385a.4.1781524491422; 
 Mon, 15 Jun 2026 04:54:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2992:b0:915:86a4:6691 with SMTP id
 af79cd13be357-917efbbd2d6mr1736807985a.4.1781524490891; 
 Mon, 15 Jun 2026 04:54:50 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4b2276fsm458767266b.17.2026.06.15.04.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 04:54:50 -0700 (PDT)
Message-ID: <6ebb4c3b-553e-4de8-af85-c7128330dcf4@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm/gicv5: Add URL to GICv5 specification
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
 <20260615105029.2898872-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615105029.2898872-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eD_uOC7pLNhcKr6ndoDGLctpTe7eYgJy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX3L1YpZeSs6ig
 GHjLyaLwhBpkqAHoy5Tm1kVFpkzzV6CrIeQCWYg6ul7rZDEjGjEv7msAZQvWk3LkFsHYa7Q1KXQ
 XvbOLrH952yNaFjMlDIxd5lbjIWcXnI=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a2fe80d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0qh-XUmV_KFcohtNKhIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eD_uOC7pLNhcKr6ndoDGLctpTe7eYgJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX3r1zxF0BWZKV
 ugI3XxfP94SaV4LsRuxJcwdGTWyQ2lCdNWkv5JIoxe5hCewOMXBVgBCpMm5Ksa5sa1h9XeRg/HV
 YA47/ws6N987BQqIBjMMakDDeJYbUsL6rgDYzG7uATwszZYPMbyhwnB/TrY6mV2Li3FoPnD3Ys2
 NYLeeoPbddQJ92WakvWMSe0TE2aaOX93RZNTdpKvx1Zj2jO2MILnDxxCQ/Pb+P6WwmFSirXUdvK
 04RvwWBLMYWFssy95pXjD2cdHIND1K+uXo536mJ1IT0uDfiHGaEtsVpw/XoVle2pn0X0emF+tsY
 mvaoASMSZSMVTq6mXlbNQaMs25O9HC8gtzRNJUlRzvaTm0s4kXcwFmZ6eNxYS+PwzcsKFsnV+RW
 9RsydSLm10U1e4TK76RFG8zSVGx6MmoqDTU5rj0C8tCJyU9YCwVkPhL/AYmERl+eft49jNCYWhH
 WLjPdVQ6XXO+7boOgcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150126
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

On 15/6/26 12:50, Peter Maydell wrote:
> The GICv5 specification has now been assigned its final document ID
> for a rev A.a spec version.  This seems like a good point to add a
> pointer to the spec to the main source files.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c          | 5 +++++
>   target/arm/tcg/gicv5-cpuif.c | 5 +++++
>   2 files changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

