Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEE0C88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H3P-0000Wq-9g; Mon, 14 Sep 2026 20:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H3M-0000WX-1l
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:29:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H3J-0001VT-Vp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:29:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxpNw1439831
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gSgLNRFiC5ifC6QqvNAVyoHEASs9ffsOa+qu/XX8RXo=; b=WHU9NycH1XUGsO6L
 H8CFQ4ahvmbqGrtMs7XTEssXl8Vrf0+tf6xpZH3VPiQ9O8VOhtqDvYY26DPbaDFY
 4OgSy6WWUmpT3EX/w0gwmY/gvL5WDsdapDLm/oPCsnzPKxrAenGXpfP11UcmSLtU
 oisOEkHwO3YnmJP57Uysj46oPeYLDbaSBME5ezh28pU6fn17kkbVLHRp/zUxBOjN
 RA1DO5mIznnI2Jl+UhF8xIGzyO1BwrtyhVO8lCoSelkfCAVzr9kcXT7v2IIxSfhf
 BdGbO6FsSOgilvgh8232iS8UMCCFBomSTjdxyi+idclqBd3hHuxm4G/pi4Mpk38B
 R37I8w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuqb623-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:29:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so596794a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432174; x=1790036974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gSgLNRFiC5ifC6QqvNAVyoHEASs9ffsOa+qu/XX8RXo=;
 b=IawsX0SP4Z3OYJEm9zP2tcIIRgwINYviN0sfKiGw1+9cFXAtRT1QRefIS0wcyOrp1/
 umV/88IH5BbXNaTqEGrYwNepzN+FepcDnbdTcRVPsrwgi3JqMd+y0q5lsz5uS7Ewurh3
 l/kZ8qjOOgIE863WOa5KeWgF03gKx5TUmfObWo/6XSZ+uKC0noxf8WTL6fdF/Y9p1rdY
 Hco25VzaA6BSVpn/pp4v7s+3DHL9iSzl8ExY3dOB59VQG8PXf4urW0P7Dy2LH26pWCeF
 amMXg3ncUXXGu3Ql7Zd2jFQH983gxT9lQSTKLd0WvmsdhYSjz+UR44fIWot+XbyQpsv2
 Kx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432174; x=1790036974;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gSgLNRFiC5ifC6QqvNAVyoHEASs9ffsOa+qu/XX8RXo=;
 b=oB990nolJeOSzHPMgm58z2foF0j+nmdLISIZ6YInePI8cM+ASgMjgSnEolPqgOyA+t
 enXeIN9/bp4U+JVroTfzixiM9bXIZhLOVXyzP8lHFLljO+iRbNOmSXO3lOnanB1mzY1z
 0UtDszcJjKCn5FCv/lZEEQS4iqAGxkbVqQo51njuchFJOTGGVl1xJzEU3tGnJgIDphaZ
 njWjLQ7TS3KIl3xYLJXvtqGjrc+6dLHvIVGY0YE5kFxlLBdvICpyGbvvhOAzyri7uqr5
 I/56/OnKPxGKGnSWZNB5dJkhZmm4mq8IESZtTSobxfU1gvgyMmisoo/Ffu2AOBk7W/wQ
 YipA==
X-Forwarded-Encrypted: i=1;
 AKwUvByT1IGj+N/qVOQakZGCW4r/lAGjgSdMwM5ODmI63RhbcskMobEEHbS1lyq2jKlyF99zipKh+xFGzR9m@nongnu.org
X-Gm-Message-State: AFuF++mfsUHYLsM10cQq7OqtSHyrY4SnZ84FZV7ZWUf6pEKNtOcntOOU
 mvIdmJTF4QqY6uwpdKiEMgiDbT2cZuEXlq1cUHdUIQc8J24zdAK0Ya5bQ2f96t0GqmGsBO5kyUP
 UHWgPUutq7KFaO4s45ncfrmCNyNywzHhtDtva3OR5Yeu1c3Jb2qAOG/5adQ==
X-Gm-Gg: AYBFou3y4fpgcYTzLHoanL8KQSuwD/SELA1pGqcfXI5C/DYT/ckwHbge+aBQMUVgYVd
 K3LpVis5MkurAFHh8me77mwsTpB35scjV0K0ODiF4n4/k4os9Da4tWICUgtRapsjIU0STaNOTXx
 iGcO9VwgaEN6sF6PEm4nRjjFBuKVkGvxRfH3YdSp2FEv2SDeRLirGAYj4CBBcL5HScuyE7KGP7a
 yQSzc9nlLwn9NQW27l+ecI1AjP8WmyiFG5R0ntsSrPXclL0cjUwzPqC5nrHaaE8fLYNSk6CdliO
 k5A1wWzsf760D/AX1p85joNs26VOZ+HHwdt8hMiVG14ghqqaandQ0wvkHdrIXyObnc3CLy5wY1O
 rchVERB46bnGRZGth3Ag5XRxIEAK49VAbQI0OhpCcXcno+Y/28g7lDZZh8HgDwT4yn00O
X-Received: by 2002:a17:90b:2d8e:b0:398:cb8f:c308 with SMTP id
 98e67ed59e1d1-39dfdce1f86mr2228515a91.0.1789432174356; 
 Mon, 14 Sep 2026 17:29:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8e:b0:398:cb8f:c308 with SMTP id
 98e67ed59e1d1-39dfdce1f86mr2228484a91.0.1789432173936; 
 Mon, 14 Sep 2026 17:29:33 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b345a4sm26872570c88.5.2026.09.14.17.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:29:33 -0700 (PDT)
Message-ID: <61e8abbb-2d2d-49c2-8b51-70dcd329f325@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:29:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNSBTYWx0ZWRfXy/4yJ9jsFoqy
 efsyNBNCZKQY7Ln8j4YUv+abPwPh0PFqqh5mO6hgzmtOh2ylOCGBr8AbgUXPOVcpL84Ocu7QLI9
 gB+JBNu5ZKvBsn615O87WfLwgrdYAkxZUvggJPkTAzVCTIWJKGdOnoFFpnJpz0Fblpi5irbDQLX
 POc4CblpngL8Z0Os5xUulRlhC0ASzPELkr2H84DvOvhyM+gEc7EM2c9+R2+x+5WJSS9Eb8sIt0C
 3+IzZ2TVWfDfwqZiFlqPU+53lY5h9P4Vs+p479o+vHthAzYqQ7t/2/+41KLcXBvV/FBLrdX2BZ2
 aNg6sO0hZbP1w0PS+2Gh01MATl3vyODoNfJAZ8QOKLBvf5ICF1dsrQMJt3nxNwOT+oHXXfFBvvw
 fri77HtBFBz3q8CpxC3eyYYnjRPocDsINiG/JlgliSmuptsn5NfRC2xayBC/tjojbJ5aZy72DhG
 4OaUey0A4f2lmKdnVdA==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa8916f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vRTFBDFgU1gNVzd_rxgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: picjiqLheBPdDyHqVSHrqQ0PYwkXMr9F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNSBTYWx0ZWRfX3XaogGSc4ftR
 gx4kl16sJSSwWKHCBF7BoeNsR8sklAYLdOLvs5lMRId5f500ptZCSQOY7G8PnOJLxKwrgBWfI9h
 UuP61ffTX5b2bEUZf8WDPtZ6Q1LHvyU=
X-Proofpoint-GUID: picjiqLheBPdDyHqVSHrqQ0PYwkXMr9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/14/2026 9:57 AM, Paolo Bonzini wrote:
> On Mon, Sep 14, 2026 at 6:13 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> There might be some confusion with what the series introduced. To make
>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>
>> Each tests/tcg/arch declares which container it depends on, and we have
>> tests/tcg/meson.build that automatically builds it if needed for tests.
>> Reverting that will not be very easy to be honest, as it's a core part
>> of the new logic.
> 
> If it is core, why is it patches 102...105?
> 
>>  > IMHO it would be nice to replace tests/docker/Makefile.include with
>>> a meson.build too. Yes, that would make it rely on a configured
>>> build tree, but IMHO that's an acceptable tradeoff to get more
>>> stuff into meson natively.
>>
>> That's easy, and would allow us to get rid of
>> tests/docker/Makefile.include completely, by adding matching targets
>> make container-image-debian-*. Also, we can have a top target
>> 'container-images'. With this, people can build them with ninja or make.
>>
>> As Daniel mentioned, the trade off is to run configure first, and I feel
>> it's quite acceptable. What do you think Paolo?
> 
> The problem is that right now firmware builds are broken, because all
> the supporting code in configure was removed. I'll review anything
> that fixes it, even moving firmware builds to meson custom_targets
> even though it seems quite intrusive.
>

Moved remaining pc-bios sources to roms, and adapted their Makefile to
make them standalone.

See series here:
https://lore.kernel.org/qemu-devel/20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com/T/#

This should fix the current issue Eric had.
Also, if this works fine for you, I'll send another series to fix
linux-user vdso build.

> Paolo
> 

Regards,
Pierrick

