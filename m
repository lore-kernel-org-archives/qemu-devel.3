Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45398C5ACD9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 17:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtUT1-0008Mw-Us; Fri, 20 Feb 2026 12:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vtUSt-0008L3-Rn
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 12:38:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vtUSs-0000iC-5C
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 12:38:55 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61KFssmt2552662
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 17:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QYzDN2GkLwKyiZPt9pahe8SN/H7fSPwDtNzLUoDL3jc=; b=lWYw+gIq3FJ0Zy3Q
 TgWjJ3b2jHkFaCc+8tkaocHuqfKN8CnFfeu/aXP3LdDHwl+gre8ZuFivy5jfgH1Q
 IpXAA3EQVhPCRA7VhBc6u4g/UMkykMbs+HYW2FYxgCFYzqVNegPbl/Il8cS6HhXH
 bvkpIrW0nAdk6YQDyZoWmic1YJEafzN/+HVSmNYfKxIRMD4Zv72SD2GhAzWObL0t
 2OG0SO4HPr2BHa5JTehdu0/G0pYj6NhFgvXKYaYFEyNid89zd9rtFOyt0y61LD3a
 y8qnkRibhAepXRhxqY2Paxn6a6Y5sLGinyvMC+t6KlF1q2jzL1wMyQM11B5uqEjz
 0TGQyw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh7t1ukr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 17:38:51 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64afebfc45eso3783749d50.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 09:38:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609130; cv=none;
 d=google.com; s=arc-20240605;
 b=IztN4sWfIW0iNCFtM9QZJTL1gTDZWsPRVsAEUwhloyvNfb6rAgJC6roC3PN5UR5w6Q
 FLVfZzonMsvK31R83JHpl3TrY/4pI6rSS5oA0GYIwlpMCbT18hK54sHzyKx/CxRr/T6O
 DQn1V2d9FpO0dorSKD5kOrh9ebz5C7FdenxHpMrK16yyeXj++631aQMGgEprLAfCrP/V
 weo+BcFffCNg55/NwSifDAWxm50tCOkEpOT1aguYUxVSRanRB71R5URjqdfeHW2FcPH2
 KyTjwCnJekiCeXh5Derj/UlO9CJdvD4Kz5qGFGQEg6F/jw+rIiyR0Kid1dyjF98jnUFs
 YrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QYzDN2GkLwKyiZPt9pahe8SN/H7fSPwDtNzLUoDL3jc=;
 fh=DT6jN/t3DrKew3S27E96uTaQMNUYxa7Yk/DmXRd2iyY=;
 b=gT4ar+7X4StAzPx20Pb/okUDdHPsWIGJSsgtx3FrPb172eFOfqu/pATc5HcQXIbEwH
 98vyaVHGO+nV/e4WvfPqA6coqWRBif/08mThysVezc2+idjdsro/I2nfIhiuSaFgnaRT
 0crGNnD8b3Gp+9M0nsH2fsT+5qoJjgGgdovNhN7B0RG0PvBlL+pkawUZOdF9i+skMQ3C
 wgIaU+sPP+ENYUHOzjyS//9LauHu42tkLFP67UXL2mBeGO8ehexbXvs6b0PxCuSgX5V3
 w+TeIxyru9vSYxkk3kG/uiNtSpBxDcNIOTAY6gLNnA8ByP/5Ao1hpioZkxUgqPdQV0AA
 osRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771609130; x=1772213930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYzDN2GkLwKyiZPt9pahe8SN/H7fSPwDtNzLUoDL3jc=;
 b=b+076D8gORn/HSR5UAG+sUNN51irBXhogjbaekraMpGHSgAW+Hb/P6qXHbs6wUEV4M
 KKpFwrjSYbhRWf/9ypy46bzI7jvLoxkuTsg76FIv947HEQytUiTm6YPmYfpfqZLTtfYw
 i6RCwrJo3a237j4o/Mlv+EcRAwD90+hcvpS/6MtBi+9bI238I9RzSHMKSR7itpgnTssg
 YUFk07XHrZZ5w+Jow2Yo9QxAAJnEWXKL/sEcELeU7XcETrYbKLobPD51hrela2CK1MnZ
 SZrPfcL6XJulPuu8QgIyboAdsdhC1Fm9dPozsfnN1ZEApXo+AwV1wHP9vGoVyVvoQyR0
 Jzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771609130; x=1772213930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QYzDN2GkLwKyiZPt9pahe8SN/H7fSPwDtNzLUoDL3jc=;
 b=ktkDPbQS/hK1YjYdUK5NOhkPKVtbvyChAnGsGt+/OalpDQV7S5e4cPbP6hQhM67iHX
 opdNg8VhCDlip61V/mADba4DmvAnkxmdZmhkM4ljsmRzktTCiMmrQ+YJizyKLh/Uhxa2
 tYuHqWcIDNZdSUqyqxhVwuyLoQ4eoD8/+f0C1WIOsD5xgfSLyzjy3AU5oCaVIyZe8Mdi
 vzU78SSbX1auiQx3an+47zzWMM1950R1mGCySa5Z0Zg6+bIK+co4m1y+DXTBVFKOXCq7
 uHBglFkfquykFloKaH7XUTMFL3Eez6CmWOOmAOXlngXbabeoHeJHdtcfLaZGRRTQC0JQ
 FteA==
X-Gm-Message-State: AOJu0YxM6IwOKkxQ0LR4ABSsAqk3abpxw0TivK0EUkYelb8/AuTJnpuT
 XsRIN5KB3hiabop3Gl/mRHFcjuA2apXelEv7z4LhidFM7gaIC/xMRAN3nZ6HSbOJwNP/wLfXFvw
 E9sPlGHeln8MWzTkvJKZOI2penG5ef1STGH0rhPRcKLiPQcEV/lsjl/7PwZOTTkhudW8GozFHR1
 osiQRNMZ7JhmVA0XpTsPAY3WuAV+C/s/M3
X-Gm-Gg: AZuq6aKpCFNhyiUq4cjUQyGWmrY2vQMGBBIzL8a3yy29fYSEyBmDFGGXD7nusxhJjw2
 HNN9YMdmQdretqsymHiiDhCyfgs+Sd3nouZTkyJU6zkZyyQ3j0mjiJ0mZWK637xFUnjrwWCaEYD
 PFTeRj7WJT9UHPgvjpO+kNR0hGsghBj08O1d8Qs7DUVuQq8Ikx0QH0BpwUFJvNmzlorOnRYHB7K
 UURqXM=
X-Received: by 2002:a53:e02f:0:b0:64a:d720:f259 with SMTP id
 956f58d0204a3-64c790a5e38mr341271d50.85.1771609130198; 
 Fri, 20 Feb 2026 09:38:50 -0800 (PST)
X-Received: by 2002:a53:e02f:0:b0:64a:d720:f259 with SMTP id
 956f58d0204a3-64c790a5e38mr341244d50.85.1771609129734; Fri, 20 Feb 2026
 09:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-34-philmd@linaro.org>
In-Reply-To: <20260219191955.83815-34-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 11:38:33 -0600
X-Gm-Features: AZwV_QgvZu-r-qJbYFhver20fzfnX42ZMnmM93RXm_lVlNbPyVdu-YTUyzYMjxo
Message-ID: <CAEqNhNbN5HnPyCuLNTM5HbYHKPQbq9TTpXaXVWoBJvurMYM7nA@mail.gmail.com>
Subject: Re: [PATCH v2 33/50] target/hexagon: Expand gdb_get_regl() ->
 gdb_get_reg32()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: oKHv7eU_O3nqLZfPSdLrEvh_NQsbk80J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX8QTbMZLFEHyU
 hQ9bNIdggcJ1TUNScFSqyFfZMBxlakLUMFsTvQcQ8Pn5RkKmYfCRJgtLEQkD62a+tcYLFNYckmY
 T9PJpiy0Bj95YDXPHbrSHb2G0m0Vcn7oSWAS9cP7Z4u7E+fd8nATV6i2/eD67WNfFDCQQPHGFnF
 cZLax5eUIDrW+2yMEs5IqrhGNSoXT3nfhGAo8ro3xESHWet0yKG/eMlwE+YcH6fh5XdZrBox8nI
 A8Z2JcUWbMBWCLTzX2lep3/2KBgKsI+zFYxEbz4PqUmE+9P11rFOoW5MvyIVaJ5HwvMLp1q1FJN
 thRsXrpb+znJq0NLPMuDJVlbWFu79nrAYx34u46UPujaL3UQp98wYnlxjIXF+YUOZul7xEKf076
 uwglsHguFiBC9aeAsiLzS9i4ZBOxf7OeG5pkfD1kwtU7KyE58gFifSemBNNKRmTSSm/8U+J7G+c
 TFFkkSnt3kZ8M3HJHSw==
X-Authority-Analysis: v=2.4 cv=PcTyRyhd c=1 sm=1 tr=0 ts=69989c2b cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=HJcjkJS7MnFaXD0oR00A:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oKHv7eU_O3nqLZfPSdLrEvh_NQsbk80J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 19, 2026 at 1:23=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The Hexagon target is only built as 32-bit:
>
>   $ git grep TARGET_LONG_BITS configs/targets/hexagon*
>   configs/targets/hexagon-linux-user.mak:5:TARGET_LONG_BITS=3D32
>
> Mechanically replace:
>
>   gdb_get_regl() -> gdb_get_reg32()
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/hexagon/gdbstub.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Brian Cain <Brian.Cain@oss.qualcomm.com>

> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index 12d6b3bbcbb..b9856cfc978 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -29,11 +29,11 @@ int hexagon_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>          for (int i =3D 0; i < NUM_PREGS; i++) {
>              p3_0 =3D deposit32(p3_0, i * 8, 8, env->pred[i]);
>          }
> -        return gdb_get_regl(mem_buf, p3_0);
> +        return gdb_get_reg32(mem_buf, p3_0);
>      }
>
>      if (n < TOTAL_PER_THREAD_REGS) {
> -        return gdb_get_regl(mem_buf, env->gpr[n]);
> +        return gdb_get_reg32(mem_buf, env->gpr[n]);
>      }
>
>      n -=3D TOTAL_PER_THREAD_REGS;
> @@ -56,12 +56,12 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t =
*mem_buf, int n)
>          for (int i =3D 0; i < NUM_PREGS; i++) {
>              env->pred[i] =3D extract32(p3_0, i * 8, 8);
>          }
> -        return sizeof(target_ulong);
> +        return 4;
>      }
>
>      if (n < TOTAL_PER_THREAD_REGS) {
>          env->gpr[n] =3D ldl_le_p(mem_buf);
> -        return sizeof(target_ulong);
> +        return 4;
>      }
>
>      n -=3D TOTAL_PER_THREAD_REGS;
> @@ -81,7 +81,7 @@ static int gdb_get_vreg(CPUHexagonState *env, GByteArra=
y *mem_buf, int n)
>      int total =3D 0;
>      int i;
>      for (i =3D 0; i < ARRAY_SIZE(env->VRegs[n].uw); i++) {
> -        total +=3D gdb_get_regl(mem_buf, env->VRegs[n].uw[i]);
> +        total +=3D gdb_get_reg32(mem_buf, env->VRegs[n].uw[i]);
>      }
>      return total;
>  }
> @@ -91,7 +91,7 @@ static int gdb_get_qreg(CPUHexagonState *env, GByteArra=
y *mem_buf, int n)
>      int total =3D 0;
>      int i;
>      for (i =3D 0; i < ARRAY_SIZE(env->QRegs[n].uw); i++) {
> -        total +=3D gdb_get_regl(mem_buf, env->QRegs[n].uw[i]);
> +        total +=3D gdb_get_reg32(mem_buf, env->QRegs[n].uw[i]);
>      }
>      return total;
>  }
> --
> 2.52.0
>

