Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9CCC79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qNj-0004nI-Hm; Tue, 08 Sep 2026 03:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qNg-0004mZ-Do
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:36:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qNe-0000NQ-MW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:36:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LrEc2502501
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 07:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=kbCriSpLgERKkHaU+yFAALyqSYyuhbB5huelH1UtSX0=; b=DD
 h0vegffNPjypr1mnIVLL7nBoO5fyjibYZoDBITmjjjKUOTvOpT0X2doAiRsr9JS9
 1I0MYzsh9SdV23etSKUe53NRn77kDxWm+VK73z/iScCfYW2keyeR103o40LBZ8ke
 MgFb7C/06/DWdFtfbN01jAxpl9xZXYpEFX1nm31bAbDjxttHgm+xor3VSOr3XSSJ
 cSmhzYnstOnrlUwRFtJGCJf97as7IgGfYqntoM92EKLlWcleik9JhGxGBgXRL0w5
 pfs4fQkO3WZvR9EB1pNLtISAqBZ7ExabTWskJ7FcwqHbaTd+FjRUmtLgnrNBLypg
 dvZaVrH14anRJKQQZr1g==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcv7gbyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:36:32 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66fb71198e9so1748920d50.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 00:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788852992; cv=none;
 d=google.com; s=arc-20260327;
 b=rBfsIDJB/Q/VHo3sBL/aM5HOitGC81ahhfYj1sX9trxV1kyG+bNeLMVBNY7mqfWlni
 0lcl1qJpgwo3K3fIfbi75IHIwiSI21J/tE2T+OtvwdoUwmX71vOvEa9rbJZgNA3klPD0
 OQdnR6PF6mnUeyvwXNxRa08OYmVhkITfY+9XCr2S+hrwc5S0nmUhGkNIXEC/dcrvz8fU
 BY7aTRA39wNIktv9xzTtgAquNOyQ/oPjhqfkX1jGrd14V3deZ/ZvQT5pLDWUXzK1IJm8
 JaqBM3WplgDLgMFmgOxmPXmAY89Sv7ud94cVypkuDM44GConRTmRKS9ZP6YweT/TDwLc
 NENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=kbCriSpLgERKkHaU+yFAALyqSYyuhbB5huelH1UtSX0=;
 fh=XedGbJeEWtob3UBtxKSdy6f0PeC7Kio6o+l0fceLOvk=;
 b=Ek1g7JR+lyT1WsG3ucu8dqh0BFQEWS441Rqyyzb8Ti2LPpteLebbW0+DLXRt589S2D
 vE7cBsMPQO0LgGzH1u82UthOyjVbOStu0t01r+g+nl93pyQabgydO1XebARv6DfKoon5
 bezRmQLz+HeWosKTq8PE67/fSDnrtSmw0YFoLdi0BDHkefJwQAZMC7F4LSEC2F+ieFrW
 WwtdhHMzAK2u1nHqRXy9ci79cy/ioqOivjz4N9sXQAVhvtTHHSVjdE+Y2kLnr1LmcKy4
 MzD1JVmOFadl3wast8nNTans7qThLxTXjurZzHBeHWp+RhXv3Np7cYjyr7jfTsgiGH+9
 TwjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788852992; x=1789457792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kbCriSpLgERKkHaU+yFAALyqSYyuhbB5huelH1UtSX0=;
 b=U5fVKaN/k2h/NPNBngYh8AdAnRxyCVa7EjMoqmem2emR+8VYSQlhyONy0mXH2eVu6J
 eU9vlxS1RJICTqiKDXNb41XDumPPcyqoC+YwEON2ki/zTxyhutnh+1a+aCp+0zLv1FCN
 mTU2baPqEHlBpjsEu+Ir+tkLqUXiY4aSbYM42pZMwkhc1oGGwHykXdo3uY2Em+zPFh76
 i4WCSgbxkg7IgKxTfCOZrUEp7Bf2KW5bX/ArC/ZgbtD7oPWsOmPEQnOuiJDxVEKtVMi4
 9fgUfWuGxm48rd53TWNAFx/6sOi3TEtzyUsCsmvfzZcp2Ld4wmvUvMjEViCDDV0E9Mbq
 h5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852992; x=1789457792;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kbCriSpLgERKkHaU+yFAALyqSYyuhbB5huelH1UtSX0=;
 b=fiwC65wnsqFaeHGsBVZMk95jq3PIgfPx1lRpVarBXlDHRvwlFMVK5ZF/GWcEP/Jo2s
 491oRq977PnEZU/KHFTl/mZHapZXuzDqSLrcnSU8HblhudtjNN0uQPYvqf75byV+qtw7
 hE7RAS0UfjExEUakNZvbbSmwHsAcS55jM2MFzthekbgO//nA+nKIG0pmNXj46x5h2Q/g
 HzP5pG/T0NJLoiiu0ZKKI8x0Q3i3DTCKyQOeEFctqzN9vqp4RkKt0XzM3vM6+vs/kHo0
 hVAo5kLgXYSeZ5omFq3r6Kxy//Kfi/qV5hX7alIyhrZ8OtQEFTW2gGepIumDbKf4U9pe
 ff5A==
X-Gm-Message-State: AFuF++lt4nfc1bSnYrgTCIvl7TRZWkT489t0A+sfhn4RtPlGypJL570S
 VVlUfpXLf+LmLvI9t/SfUg1z8Y6Xonx8Jlbpq0zn5fzEwmFEX4XMFX+i/7kbZZYafDWcKmULwmF
 znk1V9FMyDrrnKOYOekV5oIvje5JaemEaiIUmdsR+HJhlqyv7xMlr/IuxB0RiUJELzlvWmABnRE
 dVmVJ/1nOMTynsvUgCgHjUnItN6iBACeeW
X-Gm-Gg: AYBFou2+qbDnKOPJWAxwld+tasmNVdS+8AHUb9V1BhzJParzReVC9Kq+R2sGJlnKufN
 kofPP365ibFAdO0iW1rgoG6EN2Swnn6ec90Y4P6ZVOAA1FL+HjzRtgYjkUX8cNjozb9qMu8UIJz
 8/YMU+ObdaWf1FglfgWfHux4PwE1tTlIcpLSChLz1PXy5e5rdV1Z4RQup9gfA=
X-Received: by 2002:a05:690e:1306:b0:66f:8a2b:b693 with SMTP id
 956f58d0204a3-670f493e1ebmr946449d50.17.1788852992503; 
 Tue, 08 Sep 2026 00:36:32 -0700 (PDT)
X-Received: by 2002:a05:690e:1306:b0:66f:8a2b:b693 with SMTP id
 956f58d0204a3-670f493e1ebmr946443d50.17.1788852992150; Tue, 08 Sep 2026
 00:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260828112803.86636-2-subrahmanya.lingappa@oss.qualcomm.com>
In-Reply-To: <20260828112803.86636-2-subrahmanya.lingappa@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 13:06:20 +0530
X-Gm-Features: AcwNN1XKZbNARl6HP-wKvI-4_Cmb74eIeZa_mNiJTxROv49L27PAf4OYpDXrYeU
Message-ID: <CAB19ukFa3mUc7LuWMuJHFwTYs+7o-bp5Jdpk2gjQVBa1VDKGNQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/10] build: add optional librpmi dependency
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a9fbb00 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=8rMF-3-UOXLQO1KvhcIA:9
 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX4I0wgocsGnvU
 FKVy2LFPxafaoK6SV4eO38C52WkpG1QekAQl2IgQLiQSu7WX9tlQZlOz+8RFUIZSaS1XqOPgxX7
 1vodTBCRfpFf+jtTEXXboOG7TfMtWv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX9PkKrBtLj3lT
 iqGfoAy1HHaxdD315EUps1nJ4tJCgDPaU4zpCtwwWZvRIJGY6guXQsyFTzJHNQndmt3IWPZHgDQ
 fRLupf5mYPxDM8qAk0lu5Q6AQEnu1uF0x2iYaL677BmbFZadPsHJW+3CeJayvFr3mE25ORN1v1u
 sOdil969xXL1zthD2grPfaqMrdgayMb3dRieoFItOQ6ZpTsff5NVAaHGvpFZQst3WJQ1zek5lWF
 J4CJbq8B/y1kPtXBrgCJOlg2+TveOAq3xl3Etm8yOVRq93Kngz3rz+KTm550oVMn2LsexTGzxgd
 h1Ol9dTSvgZuX6WBLOWxM8zcT7sSeaD1LkQVdcOOsYokZLqOZZR0AoWjLDXxwwV0QahbV7fMiab
 wNVgRAeB17la4dUpEledXVOFIAcnj+V2Pj9lQ1t/ZCyHbBHaCRnVnFPTxM1q6T/HhCVpzet9YLf
 AAPOIzoyqyGmXPZgX9w==
X-Proofpoint-ORIG-GUID: HnOVUTx5p0D_CCBE5qyYhtmJPZJtBZrm
X-Proofpoint-GUID: HnOVUTx5p0D_CCBE5qyYhtmJPZJtBZrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 28, 2026 at 4:59=E2=80=AFPM Subrahmanya Lingappa
<subrahmanya.lingappa@oss.qualcomm.com> wrote:
>
> Add a meson option and config probe for librpmi so RISC-V machines can
> opt into RPMI support when the library is available. Keep the dependency
> optional so default builds without librpmi continue to work.
>
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.co=
m>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  Kconfig.host                  |  3 +++
>  meson.build                   | 14 ++++++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  4 files changed, 22 insertions(+)
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

