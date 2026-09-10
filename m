Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E1DC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kxI-0004tS-Tx; Thu, 10 Sep 2026 16:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4klw-0001FY-5X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:49:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4klV-0000Pz-3C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:49:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIRF6x1645515
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 19:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m5xTUQIUCyJGaGEvnDPGoGrKfm2qeU9P0xNK2504Yss=; b=BpIYMyxmlWaBCtlz
 B3PAGXSdonzPv9Hcx51UnowyfpLjX9FlC/meu290EdfROCQ2dwppvtMnWAExG5Jp
 x8J1ynZh3i3mIB4eqY+tYd7iUev72EK8DtAwfsltDs9hbCworgbydBPgmYw1nm/4
 D/o2H0HiWxMXHFXbmzeJXL21xT5Mn0whYbuwE2qNSv1A83e09QOTS70K2PEvlEZN
 WGP2btR36m3PyohQK39t9EGjli98dy8SdhLUZLxfE5h0OmbpWvujLDou7HLLRPIq
 E5PZUcK2FTAKuTi+ycWBxmFxYuKuIhvq/vMop8vEq436xMDnjncmaYT6oqWe/O+D
 4UGgyw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k28bww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 19:48:53 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4a49f09233dso114410b6e.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789069733; cv=none;
 d=google.com; s=arc-20260327;
 b=KmA0NpkP3G3uUULBkd4ldLWB9D4w0mKXIeWXGUHblrma6z/hPeM2UpuuIdX/auREpd
 HDUCa17mEBjXzB+HqZb3kHkE/b7omLqcGzUp/C2tOdSoRPLI7Lc2SaHxdfXx1sSbmiAO
 GGanutmnfEFUR2axOrwld3mldOu/9SCjy2E6m6N1BBnD6erWidZtZpl4mrG6Agb9W+kq
 rSfmHBLJif808bVUKSXogwtyqlBcgGP1mQV8+sMBEGEtGS950qj08I0Oe+8oXodILfqT
 UXLzne4OtzgxMKF6SRRhA8vESL5PexHYZZXV1EsHuc6qUgxPEoYGr9apPLUYxAZKRhBo
 SUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m5xTUQIUCyJGaGEvnDPGoGrKfm2qeU9P0xNK2504Yss=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=NCyw81WolH6pH2/gDE88opbzK2UY0HF+6G7ATS7rvlgKOk4xkQPW8hpbsJhUdKELym
 LzERWtmQCGERZbw0rQstSXddqKjcxIFyHykuX6xqAmfTEVx2sR7nMtuAHLT0XW0eK5X+
 AR088EOrkSLEG6jwajrgzd7CRYTrV1Le6AgliodZ8AI9wTU/69tggFWHONd1TVk9qvAI
 2PzAgEN8OfRGCPNPuToZe6NKJh2GQQ7bcjkHDuiSfjQfyf8VB4YRoPxd2+RNBLCfahYD
 kCqdabJ4JPs8eAxgFKtzlHlLI6y32nfT/osspWFvKXB+SsDXcSzwhTK50lTPN5V+laN1
 1X3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789069733; x=1789674533; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m5xTUQIUCyJGaGEvnDPGoGrKfm2qeU9P0xNK2504Yss=;
 b=OH4Y0ASZH2Wj7Bvuk2OZouH+M0g2H4UIslch26/lLL97ml3gbnffB6Bmd4rGNqYWvE
 5IcqIq2dXRNcF9vNi88IxSLvDEXawwsqO4MOkD5huxdfOIGHCWTwK/LI8GIeYIjEwflm
 OHb1rgL14fUSgqWfg/vXEy4wmhSKWoCV4PK4CjUrXXHeCMSIvHBL1FLS2pIWIXMddCwd
 p1lmuwOVzTyyXrRXmDCmDy1+ROQBL1yLyOkdhpj5dr4vMMzb2CH98rKMxKRUPwdWYZwE
 m0UZHY+7njlP9MeDdNGqjcw38W9Imvmceys2jgUn7St4RJLKxXcQ6ZLfBW2qilTRdizi
 8vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069733; x=1789674533;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m5xTUQIUCyJGaGEvnDPGoGrKfm2qeU9P0xNK2504Yss=;
 b=CokkhVROqXuxE+sjksGfJKeinKvKaMdpCARC8y0wJSLIhUKp5JNVUOd0RGs01Hque6
 gZ5t52u0IK9ObK+Kveev/erzYcGvBoJGnIp8OrubGKBU8XQUGodwkexx080g1EakU1BQ
 9DcsxVbPff2ZVajmmp8msRVPEWA9c1x33jAFcPci4XCd9f+lfw24e8qQ6SzDPjEVa3Bm
 +WTBmM5zKh+G1ypgySdngMCjVvJ4EqqGYqGVXNPUGQbGf9kh4XKM70WKrq45o7t++7+q
 oHKiLqYXu9VZln+STqAR1Lr+82QohR0/Gl5ELpqs5h1isxkAiV+AsS3Q4tRa/5LlLx7z
 9Kwg==
X-Gm-Message-State: AFuF++mlKvCjPo2G/VmXwlvepQwGikkw2tphvwIrMz5p9IgbtXqfUVaA
 JPTpE0iZExi/mMkZhNIOTA33AiUuGPpiV0QWw57/xguNR24T5cKQJexdiWFwKCWUD1ckJ3kWwdi
 nL9glKUNNSVrXlbvfi5Qo4rkbt7ktZeQk0erm0rg5Ah13vhJMjjfJsN6dVBaeXtJgnWYvDLLsSU
 chzI68Ejk5/L/sfw9RDf2fFCvtbyEtQN/e
X-Gm-Gg: AYBFou3jhT6voLiJYuylXmdR+1f/ryXxtZqTSuAvEJE/R/lOb1CwSetTT/X6SM9bvV+
 0DUBzC3bhWmionDZgnbP4rZfNckR6xjKtV7BFuuvx9Wm08c872wSa0vSfazdDRfseHO3m5SSrGj
 Tu6uFVkf85nx0iw9aNeU5ICbAKPBVqK1vxsTSnCsph050OLvABl2EbFNJW0sw=
X-Received: by 2002:a05:6820:c2cf:10b0:6be:8d8f:120a with SMTP id
 006d021491bc7-6c0bdb715fdmr263293eaf.62.1789069733051; 
 Thu, 10 Sep 2026 12:48:53 -0700 (PDT)
X-Received: by 2002:a05:6820:c2cf:10b0:6be:8d8f:120a with SMTP id
 006d021491bc7-6c0bdb715fdmr263281eaf.62.1789069732545; Thu, 10 Sep 2026
 12:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-4-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 14:48:41 -0500
X-Gm-Features: AcwNN1VE-S5ZnGEHFzY-ZvkfRAcS0QCaLucWhn5amV_wIWrHim_Ce5LvhFFqic8
Message-ID: <CAJ+KCYPuNok5XPMhe6eH0QFDbDABgLZtVU01PkpTwJYaAMuCcg@mail.gmail.com>
Subject: Re: [PATCH 3/9] tcg: split out _var forms of gvec
 saturating/mul/shift-immediate ops
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa309a5 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=zmdBOCVzGIwtIUWvI24A:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: 1RHN5JwjDMWEeSRPSGzKUGoDS67aG6uX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI0NiBTYWx0ZWRfXyCUZI7zeky3K
 mJ0N/G7uk6g18mo2hbTAxR6X8TNJazu8M/fSr9BqQd5rWBoxFPCcXhSmu38HoIO3lStF6Nmj5ss
 96/0SFaoFWY+6AQ70/tJoEoVYHE2mRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI0NiBTYWx0ZWRfX/YomgIoOvQok
 3OT7u8H0KlYJ0mD9g0b2ZmFzgS4lz5RN058psIm7U2uhv+voB6NgNH/HGHfQ1CDikQV/bkUKM+i
 uygTba68xxFVu+4XqXeuvz4G//wVyPyy/ay6XhblQeNjalwXc8n2mkYspYNgkzKjw6FchJGBoTX
 dlp6Lhj5CP2lXLojTDzzp4pXmZxL4hXKGcG77wL6ZbOvKTSZS0DWiTR2bWWMMWBY7sZvNCdx8VX
 AYkjURzFjgyBHgCvL9dt1xJO6fxr7V2GeQJabombspCduCa0bBmuP3nR28dHPJW74KrLYmGOAL1
 eHcaIQThgz1uQdey7CJfAqcio+Pv84XAyfDryVabOShSdHR8hJMq34/qbOzTIq9URpH8Ff0h9C/
 c90DZMKeF25Tg+q4yYl/MlTXQLFgzJr+SPxZmGqI1/PHq4ZFHuWv2nDUVcPDBKs44UFRrCwgiOQ
 mgtV3rBusNSpKSwSLOQ==
X-Proofpoint-ORIG-GUID: 1RHN5JwjDMWEeSRPSGzKUGoDS67aG6uX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_06,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100246
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

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> target/hexagon is about to address its HVX register file through a
> runtime base pointer rather than a constant offset from env, in order to
> share one register file between several vCPUs.  Split the other
> gvec op families it needs like tcg_gen_gvec_{add,sub,mov,and,etc}.
>
> Add tcg_gen_gvec_{ssadd,sssub,usadd,ussub,mul}_var and
> tcg_gen_gvec_{shri,sari}_var, plus the tcg_gen_gvec_2i_var plumbing the
> immediate-shift forms are built on.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/tcg/tcg-op-gvec-common.h |  31 ++++++
>  tcg/tcg-op-gvec.c                | 177 ++++++++++++++++++++++---------
>  2 files changed, 160 insertions(+), 48 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

