Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525BCC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Pan-0004AC-3A; Wed, 09 Sep 2026 17:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4Pal-0004A3-Ob
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:12:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4Pak-00014l-9v
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:12:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JIaAm2773648
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 21:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +ikhsgYHwEaVaQTUaRK+5EvMArSjAOFfXPvM6NaxUAs=; b=P3orjCrdbtces/ap
 g60jQLhMm5b+okjvVE/rrWt8KQ+A24rLLY9ZqYvcd5Moo1Ewv9Buzt/vWNy3OsMn
 ChVrO9y/DeVAkXMDi4rMVe/zcwXv4dUwjiEEPBNS5sVfRWWfzoe4GmrVWhV4DTpk
 eeHSl7EW+6Z+zv+Ja2CDYKZMJ8kT0qI7ZPk2Jn7H0QGnJc0qp1ZYw6ZckX5fQvz5
 Qhzpj5Amh118h22nbECUAzNR0MdlwwGb+kgRBrvLgIkOaryg7sdy6bO32N2kEz1C
 34ucJXamd4bU7tUT80HtawU6X2wTeimKtea0oOXhFkPnwoMuBUuxGnIA8ocVFOse
 mWD+qQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfrq5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 21:12:22 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b1b8b593a4so6326580eaf.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788988342; cv=none;
 d=google.com; s=arc-20260327;
 b=L9MKaMcfhYFLdBHy6XZPCN7ErZFNoMNTOO5wKcgd2/ZtGYrZXyp/IA7tP7qmt7bQxV
 GBoHjIaJmPb9L6dRRRy0bNQBFk4/FdWHEoawz6ONkuHmZrpyCEuVJ5NnxAHGyMJF1zFt
 tuKUifJxhTNvdWyZH42fhBStSdqnDMxyd7Rg1NfMc+piNhaQFn4wgeNYUP2aOwmJGwF+
 zFXM14cNRZMlnNmhv1KKYWOKlb3GDRzEiaVRJirLY8Y8vosdhPOrvgcI/WNOS+54Ef7T
 DpodLlYhuBqUi8CAREmcdGjCmWmcmolIfJM8OvPyUKiLI1Cm/AOTcjwHrlWLVW4euO+i
 BSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+ikhsgYHwEaVaQTUaRK+5EvMArSjAOFfXPvM6NaxUAs=;
 fh=JS/OgZbRfXQVDoN5rCEv3BGagEhB1TLJSS5HOGFUyfE=;
 b=VDIUNoizBF3sU0g+esCHFArj+H0StBDTTLfAtm8cU8Pk70K1nOmGBCkq/0OQPdEItv
 GICnrqMeNNs0q3McNiKiHggPVM1MWDb3ouxXE67Njqr5AlLIOzqnTGXxZX1iwP1RZSjk
 6bDTLgt94Wh+5FjY8WDFoxj3ogXbPGmsIFuJ8Rp0ZFdVcIy+9BdVmdKbl+cl1X5HrqT+
 Jvm9BoOaR4qKPrXwbCEoRHMlgks6sH/WEgFyOEE1JQyL5A9sr9RXf+JTxNq1rYCPWhun
 1yD6JRUOct/AZdYr3NAMgPaA1Mwo1nz/RMJ5XBvVTAeIKSXnDswRuu9bByT+/tj7omiA
 6uKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788988342; x=1789593142; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+ikhsgYHwEaVaQTUaRK+5EvMArSjAOFfXPvM6NaxUAs=;
 b=OTApw8fokC8qyDDT0zDDtJrWtMg98+bO/sb8jkBRi46y0lhxLhPMDhMdd3mmKdOyJr
 /vNn4LEHQ9dZ4ocX7d1gDlacNLrPJ9a6U8Z+VSRRGUNvxn0S6HSH892kr+rbVV/fGK1j
 Zj4+J8gnrUwR19hBZj3v88Xa5gnNrYlu+PUqZQ1fWK5np1KWuK+GBPmhfDjwSApz/27E
 RtyXgq2V115ZevXcQ2T2fBR/VNKPkZOTdvnl3riCInwmqdGUzPFb3dZUNmc7rvheXAsU
 ftUwL+VBJ+5PslXonmT0sqM+F0NJNIpLQfFbG9IXajR8cVda9RxEfYcdpmYxyN3eY2Fg
 T6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988342; x=1789593142;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+ikhsgYHwEaVaQTUaRK+5EvMArSjAOFfXPvM6NaxUAs=;
 b=PK1pZEKtDzqDQrXVYAhYC+ZIacNPOqleLvECcm0LLi5iT1JC9Br74Ws6IVklHtk5wD
 DWLyl1tjTY2CcOgKVRqL/IT7woKpG6smNM6UYEYhbmLEZEyDu4ZikQdBEDgMTYcQAHpP
 uRMGRpd5XlYJKIbvsw1YVufPJGVCrSGvpDKLb9hRd66nO/TR5ECrtDr/qNLeuVV61v/c
 rRh/PB+43vx6tOyl3L+dzbkI1j6EhtRNo+effpy3YrBxckgUWMRD94CVBdnp3C278gid
 3JIxVJjfdtY7pelXuOnn6nShgpKHC+EFgsFRG1Qo4agmroiHEATK+ERpyZ7Yx1LQjY/I
 uhTg==
X-Gm-Message-State: AFuF++mgCEeZYS49+qv/ucLLGMAUjTRwuXpvIJYVUfs7FSMfX5fE4Mf5
 APdClPUrT2SV7O0geV6JmIFmBE7GAlbxvLmqFq7kibu4VzqwlpYb1Gh79CTlLEKMFgrdnr5WIX7
 IDfV//O9rLV0AW+id35QdDg56ro2BnZZyXZcxuHPxt+mXQx31pMeP23PGM5tFWt+4A1FlFDhmtQ
 716xzXoY26JAosUJqDClhZqP++KCG+CUj4
X-Gm-Gg: AYBFou3XMJHBGq6ZLLEpV4TBX8w37uvys0rz/rthQYTlVFtsqATkyTh5yIrpFbDYtQJ
 nS5pAvk6FmaepCyP09kcAkkCx2LVwhM1nXUgImhQD5ZDgzxSisr6rk4160ScA2Szkvii8svjTcn
 KTnFeoy7SQi6giSS9qJtT7eaVAep8Eb1P+L7UyP0SzKMgUTUoIfkwsQIoQNQ==
X-Received: by 2002:a05:6820:60b:b0:6b7:83d6:2928 with SMTP id
 006d021491bc7-6b783d62f1dmr18609023eaf.43.1788988341676; 
 Wed, 09 Sep 2026 14:12:21 -0700 (PDT)
X-Received: by 2002:a05:6820:60b:b0:6b7:83d6:2928 with SMTP id
 006d021491bc7-6b783d62f1dmr18609007eaf.43.1788988341224; Wed, 09 Sep 2026
 14:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
 <20260909040137.3414132-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260909040137.3414132-9-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 16:12:10 -0500
X-Gm-Features: AcwNN1W6fGuuuMX_-wqrFRvaRDHfmUXrNn-nRyiuqY5-VgJ-_69nJ7pexONWErw
Message-ID: <CAJ+KCYN8iFd-oUw+tt_F11WoOg3zsiyOOqH36SbEGVMkaxj_eQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] target/hexagon: add v81 interrupt registers
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Tg-EKcj1In3YP8x-JKenHRYtlDJuvCtM
X-Authority-Analysis: v=2.4 cv=GNqdgeNK c=1 sm=1 tr=0 ts=6aa1cbb6 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: Tg-EKcj1In3YP8x-JKenHRYtlDJuvCtM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzOCBTYWx0ZWRfX1NhE1aDFsUcb
 hx8Yet4GjZ+1fnKdz+aYmyVC/9cFchKb1IXTsza6UOjmcyjMNPIjXcniBr6W4rwJJflOfdwy5yW
 sot5UdXgSpnk0qAFrYzcm97fcVwAomgp9reKqw0vnfUfWsmiT+TLyjg7Rewm6S0EBIL5vilFlz1
 Hk7BfXEkESUvOAknhoWokzslEQjudxYYzMV7OU0pXQSWHsbFn09WtA/3+vgr8YxaHUd5IZERe3T
 C6yWHRnVupytSrqIgUuoePgs230gn/zGd+kh0Ai307RvZblylXhsoRTR+RG+etMihuCyvk8wQq6
 kDR7PRqraMEvAewEmLEyr+M1x9iKEX+s1Wu1x52KkRLh813ktlDf+Fw7m/HTJy5gV2fibAbba7b
 4QYnERECBF7Qc7+Alxpmh6JOX8UQoXyoqJJ7F+K/1Bn8bdoEHOk1cWdR3YMZiqrLNm61JXQwgUO
 CbwX8226Y1m2za4EylQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzOCBTYWx0ZWRfXz2axvgTJ1iNV
 NoqqRycIpVT57CNjHg+hxOZoqR8G5E4tOPZl59VqHFtGV+OPuj+jK0YcTRjjV6Pcc+sFchdxqCp
 Hc/8dcXVnJYz4qwyrieLBAESA5Iyhrw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090238
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Tue, Sep 8, 2026 at 11:01=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h                |   2 +-
>  target/hexagon/hex_regs.h           |  42 +++++++++
>  target/hexagon/sys_macros.h         |   8 +-
>  target/hexagon/reg_fields_def.h.inc |   1 +
>  hw/hexagon/hexagon_globalreg.c      |  10 ++
>  target/hexagon/cpu.c                |  11 ++-
>  target/hexagon/cpu_helper.c         |  15 ++-
>  target/hexagon/hex_interrupts.c     | 141 +++++++++++++++++++---------
>  target/hexagon/op_helper.c          |  58 ++++++++----
>  target/hexagon/translate.c          |   8 +-
>  10 files changed, 224 insertions(+), 72 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

