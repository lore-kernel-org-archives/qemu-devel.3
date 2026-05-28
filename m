Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C193ECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgR7-0007mx-9q; Thu, 28 May 2026 15:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgR5-0007iK-93
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:30:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgR3-000382-En
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:30:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHQ2822793652
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHnYx7RBLCZ8bxave509p7z3rUJ3TSaIHz1MpL9C2mE=; b=Xpyi7E9RV4/WN4jM
 2iKFEEq5kBbVPe+g2z3OA2HTIi5vEm9bNk2im/YI58/yWpVqOsiSAYnV2mjkgES9
 BukYZoFmM4dJb4oZ6R7ec5zoPqeeGmT3YndrlSOP1h0ls56iIRGJWuOcG23m6d5H
 VZlycyAhEGOX7IM1Ad4kOx15SGbJWxpx8jdgh2zw7urZDKbF5x8UvxpczfN9O9Lr
 dpJsLwAfy8DLjUU6AhX84BllZHQeWEjthPEFyz15rpOIvCbS5twRLEAs68misFU8
 mXZ41GRqFaBigBc3OjSVXHZjT/lQQA/v8QRGtIxAm/ZxNbmb92WDjnWQWTPYEFtm
 c1lvRg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y1vejb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:30:27 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3041ab826ddso13359020eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996626; x=1780601426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QHnYx7RBLCZ8bxave509p7z3rUJ3TSaIHz1MpL9C2mE=;
 b=Iex+1N2vxB4YsARLRoyayoBkvM+6PDLBlVIlgLkekUfFE4g1OoCcxEccCK8q4/j+pv
 npQC3MWT2+vzWW0N3Jv10n6KyfTCLwaxx+Hadzbyv9IKbCYEYvPRqB104TqBQKOsNhJ1
 G2JmM/vhQadRN1hPnBErFvosMAGNb427hWMMBGanU0A4w6yf3JcouNeuBLpQsRDQ53Hh
 sm/F+5ndrO8sQB2ctE0dbAn5ucJ9CySIDKb/8zxYX9oZNPMkjtwpitGldpPMg3OMbObL
 Q4U/tVSv3gLDqM5E5RpZwMeLHxevlr/6Z/dA4EK8mwiQ8ML2gkiPnUeNuT9fbacI++5e
 jyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996626; x=1780601426;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHnYx7RBLCZ8bxave509p7z3rUJ3TSaIHz1MpL9C2mE=;
 b=k+cuiMu7ajGD3sqbaB+O3pUDm++8ThdzvZ62MW/dsxHOT0FdVrs6XmYmzXflLEnFsI
 dt+N779GlpnGP5SUm7h+AdoW7YMxpeyRMu/xlcmoVd9nBc8Kf52F12I/3jy+deTTQwMu
 mWkhiyZji5sbAzdNma9qnv0LYYFVXo5sSQjgpsDZ07GAHjx9K06bPnCFCGYqLV3lGhTv
 aWVhMLQrPFx3LMVXrCsdoknWWaeMUa1BTO8krvJUCISGGdhSVmXOvfMvtPlY7AzQOD/x
 M7dD8mTEDTb0opt0BSqIES6BJA2AtN7JOv1zx+HdjXHNv6j1lqNGdVAsJP1dLI+l2EEo
 dIzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YKlNeT4fUk+qw0eQl23J3TfBJmtjYkf9Tyi4/5mW3XWURnKshXRfM9J2/aqgkF2xNwyp0S6ADVs0W@nongnu.org
X-Gm-Message-State: AOJu0YwGtvNGUfr5OxrEJnyy9CbY0jOgPo7eSWQUvZZrkH/XMDSPnohQ
 BaXpwFrOUebyfejvOLruGxGvRvda6KBLTWEFgjkmvVDBMPInE7K5zPJFnwF8KMgKgwGEXB9OA90
 661icNHiENaEyjnZNbomgVlD+4CHOElFc7upwIsR+4SrBgX7QZ1jHcYz/Cw==
X-Gm-Gg: Acq92OHKp1lAfDxu0FsVPRvWQ1Ypkb7cxLYXkFMw2qcqYfJE0yutISy6PFNw1r//AJc
 9AmMYyLvlg5AoM/mjXk7BoKBiWoNZ/BFXsNadosshJdf/38bEmiZAHSwAhPnbX+yeaENSvjd0o8
 BEvq0WAsoYzaXqUl1c90OZJfUQlKJlaybv733ZMlo5Eih08pxGFIyzB/5HGAcSAW0H570ZZa1Ai
 T35OA71U50tOLybUJ4KhDc6gVXIa3NkMU/LkjfTdBxIvNmKcjbdwGDMTne/b4SJg9M3HxLF9Xxx
 ylG4tv2jzBNH9/Mje1X4NQXZlZW/TWGdOpHJRrPuY9kyLBosLep2Np3qIIv/gcNc151KzkkL0Gc
 9mRuoWPbwIVJ9qp8L8qCHfMON+7TowGP1ppSB4yldu/aqQ2C1aXJfx8qBnCvec+Hn36vxZYw2Iv
 /Veqc2fXR2gu0Wl8B6EO9GnSKQ
X-Received: by 2002:a05:7300:724f:b0:304:13f3:e461 with SMTP id
 5a478bee46e88-304e8af003cmr222921eec.3.1779996626267; 
 Thu, 28 May 2026 12:30:26 -0700 (PDT)
X-Received: by 2002:a05:7300:724f:b0:304:13f3:e461 with SMTP id
 5a478bee46e88-304e8af003cmr222881eec.3.1779996625575; 
 Thu, 28 May 2026 12:30:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e99788fcsm107920eec.27.2026.05.28.12.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:30:25 -0700 (PDT)
Message-ID: <e7825459-289f-46cb-8a94-141622984355@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:30:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] target/riscv: Add big-endian CPU configuration
 field and reset logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DsNmPm/+ c=1 sm=1 tr=0 ts=6a1897d3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ALku5c8DAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dGBZsZF6k0oMOTNdbjoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=Skunnq644UPbuD6fT1yj:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XLsDLklhPjyBqApwL8zRckLQJ54nCE-g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NiBTYWx0ZWRfX6LHdQgDfYpWF
 sT9XSsziBd1PmoZC5tvqgVXC1aY/yO8bayTMIl03x+YvIYwW+BiWtMhoJng22o6TeAR0YRvaOUR
 Mg0xpkVkLGFc6nqcXh8khP1zIXOs4zLIF+V2Dsuwgjsi8b28mIlivJSKmev6OWxPSfRAtVal01p
 JB2/YL3hiD4uWki0rtOQbn3+w5ahqzKEtr67CYXGfhFHPFRIhrEzqLz/Y2umD8DBakElhc1tx9g
 vOBmwnb6nRwPNybXrG2cdtX5rcIro6lqXrJKaJ39I1bmfo4VRZEOcMI9PZxrMKH/Vx3Lh75FB4D
 Vjs1PjUWUpq9awLS5CTkTydNIElPjIKCM+ICV5/FsGavzrAGeY7LOs/9eiIvrWIaS+TJLZ3Bs39
 0s6XAL2BwatpGtOtA2syjX49Kxger/M3R6mgm7pnvk9nq+ENmJcWsmuLla6Wk9Wh28VTm9xo4Iz
 W6XYEBpSEa3s6b2T99g==
X-Proofpoint-GUID: XLsDLklhPjyBqApwL8zRckLQJ54nCE-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280196
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> 
> Add a big_endian field to RISCVCPUConfig and wire it into the CPU
> reset path. When cfg.big_endian is set, riscv_cpu_reset_hold()
> writes 1 into the MSTATUS MBE/SBE/UBE fields using set_field();
> otherwise it writes 0. This makes the reset value deterministic on
> both cold and warm reset.
> 
> This models fixed-endian harts, not mixed-endian implementations where
> the guest can toggle MBE/SBE/UBE at runtime. The MBE/SBE/UBE bits are
> not included in the writable mask of any mstatus/mstatush/sstatus CSR
> write path (unchanged by this series), so the value chosen at reset is
> effectively hardwired per section 3.1.6.5 of the RISC-V Privileged
> Specification.
> 
> The user-facing property and documentation are added in a later patch,
> once the full endianness support is in place.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/cpu.c                | 7 +++++++
>  2 files changed, 8 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

