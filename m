Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57486FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58Jq-0002qI-6C; Tue, 24 Mar 2026 16:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w58Jo-0002p0-Gy
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:25:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w58Jm-0000Sf-T3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:25:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCfh1989023
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rfxn9+gF7BO8MRYW1PcEqaEGBMjnj9/muwmL3Q7QEAE=; b=fxcKFRM5d4qgReOm
 4TTHHE9Kqu+lCTpstEf1x478MwYlG57mYWBCxmc3ny8/hg5c5q2qh2bknHVP94im
 CGd03hxmArK5UNhfHaBCOQEjPVVLIb2pps0tmG6y644VTLhd51Y9dwk0EL2V9s5l
 AuORX0GIkBKLKyvI8Er8xe8y4KVChvKFNx1fUMyYicsn90cNF+K5TiEKqACzA+Dx
 H6eoyGuUrtTSW938KlKtQbQODXIOwxsHtkKKgOYMR8xW6mOklTfTmcjccY19O6yD
 KQ5wtv+RFuDU02m8NH5AlYovB3+pKW1vwuVaaAlZnI23MBDpwCRfEfQp1M/EVwp0
 qi2wYg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m1s3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:25:35 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-40ed781f705so47985985fac.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 13:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774383935; cv=none;
 d=google.com; s=arc-20240605;
 b=KO1Mmls5TiCSnL7cOgiZn7Doeb/HlNIDvhiitwiRikfksYvpyughSa51YeuN7qYVFZ
 XQKF4dKYpKrNCFxoPsvndBnoPAjSJ2rqzzbr7hZ//L2NvTJrCSi2nq40v6jcimlyabqO
 Ko1sQ+o7xCqWPA7YO6s5b+RsD3nrRr6sntmSij29W0kL+Fod/JvPlbPYzw5w/93fk6Fp
 s8pUO+j89QfKqx0GUQX/izwVEhDr5UKU6yOg+CNbqkiV1XDWpQAF/4e45sWIwEgG/6id
 CkqkbyPGE5jfC94tVRzTYOJUb+P5kYoi8DTJV1VJjeQbArdkxVpMGwbJvEy5E5XdR2P+
 JmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rfxn9+gF7BO8MRYW1PcEqaEGBMjnj9/muwmL3Q7QEAE=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=eRETFrzbKxD4AJul4WUdfYPpuS+tybY7RU9gwBLnKfv2l3WDDVjooclqb+LvYIeiQn
 OcwRBDJ/ReOwreOMKpJBtj8aBrdXfU6WbS3lZaWx+4Pe0nPQ0Ahk6BXY9o9bqXTmStdo
 w8YdzbWWstcSysBcK7tio+qpi5OQ0jUq4dZsWWqA0FaouguwASqCssxNliAR0ht0P4iu
 SOqJvDnSl3yTK8iqiNEHxkBvF/nOfAZc+Oa0ILgspBSXgWU/z/FHaHseEP6l4rWpa9kV
 7VGE4xA/fJdbsWU5T9usDpCvBdhMoFgP4GcFgT+MtYXI8j71es2PbeHyp3oYtKhgMMq4
 +wSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774383935; x=1774988735; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rfxn9+gF7BO8MRYW1PcEqaEGBMjnj9/muwmL3Q7QEAE=;
 b=BuYnhQntns9hXFIeR5SftQALbxEKXlyssWtZxidcfNThyLCWIr2fOqz9Z6UfbtaKFp
 W5GQYtrB9S/it3SCl1OB3CQhbUZSjyYBWLDwkSi4YTkpiZW4pRM+8Gf0RbSFMPYdjuDU
 mLj1MyMZWnfPuHNors79o1/I4KOuwv7K3IKNCLxm/w5zC2aNvxoUAe7tl6cmk6Dxk62C
 Ra9ZnJt/u7/VmdrbW1lLIryhIpIi8d0mTo5YEgcaP/jNNumIar77rQVBoAWAPnRrr/lH
 F9PaMIQnAALkQ2ORj0jT5hmprorJOem/xGCJm/glFOF7d7c6Z5JEPI2p6ccNFYkKk0kB
 kkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774383935; x=1774988735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rfxn9+gF7BO8MRYW1PcEqaEGBMjnj9/muwmL3Q7QEAE=;
 b=HwNBPMSObw1wcxXPq8RLv2fE1bvrkGupLj6FdyCaqj8gT00r486IZ4U5RalVQSGyUy
 ApBbcY2bxl8TBufgtBfKD9JYVsclomC7dM9IQeoPwtWzP8+kcwp5zBO0TMYMbxvvTAU8
 ZFpIiwK3zleOO2SqTQQyrpYSZDjKFWRmtDcRdfX2n9oexEUv46FRUA+FxGofxB3C3MIH
 0+6R8/0nyCn2IH1NHwK64mhyT4VP1AM0iktmgd8zxUgCvbuXxQNMLlL4LlwtokLhb9+U
 1bJcSKua/b8QzXmg18dAZIB4nzlA1QBPUeJv12peneASNqOgl6bQW/S4dVdtk46N6sZf
 /7ZQ==
X-Gm-Message-State: AOJu0YzXho5u0H099v6axoLp4681qq5VwfxxMnjHZZcjezVxMegjQElY
 9pD2nt/35AkXNat2vDTI+Bt5FufJUcHg8bDSvXUGqmNQkCUoY8iAGI1YVFM5OehoQMmou97rVEn
 5zhYAsF1hHehuMj7KxhlQXXtjvBJOpOIvA2tU9GPlKWWYquL+aazC7+HjlI8Zzy4uUQ3viTf17O
 a/fI/lVWHINbVw7Xk76now8MKJggsB72/P
X-Gm-Gg: ATEYQzxwU5SGzS5hUNiNZUa9Zdmc0i8mXsFY6JBtg6WwRkQGKyqGo3fnLt07sT7HKJS
 yM1vhWhuGdBvw1dIIKjcgIoFEtSVqrjcCxn9SC86ty9vQF/HGwrTFANpyvVnsIp01gl097/zzpf
 1TIhVETuXxJRUp5Uiv8ZaAsRH5BdBHA1jloxEPONbmXeS41juaLr1wo3xjbNkfBzYy0efDr5C9g
 W+P2Ks=
X-Received: by 2002:a05:6820:a0c:b0:67b:c368:1369 with SMTP id
 006d021491bc7-67dff5a0440mr640347eaf.67.1774383935034; 
 Tue, 24 Mar 2026 13:25:35 -0700 (PDT)
X-Received: by 2002:a05:6820:a0c:b0:67b:c368:1369 with SMTP id
 006d021491bc7-67dff5a0440mr640330eaf.67.1774383934715; Tue, 24 Mar 2026
 13:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <c47bfbfbd95829c8493be298a9fb1f49a6584308.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NpxMXer5jUD=kpf7aYK8QXRMcxjhzdZXDvPtix=UYK1HA@mail.gmail.com>
In-Reply-To: <CAATN3NpxMXer5jUD=kpf7aYK8QXRMcxjhzdZXDvPtix=UYK1HA@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 17:25:23 -0300
X-Gm-Features: AQROBzBdN4SGlLtpP1V9RUqoG7MC1vX1pYDrSJxzj93b49nIC4BpOLGyIuHanhE
Message-ID: <CABrGZ+E58Vv5L_fdrFD5QRZT0=6-2ZXSpNT-tLV6=CnKAF1kbQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] target/hexagon: add v68 HVX IEEE float misc insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c2f33f cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=YspN8EcahtHjA50IrUsA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: U_AzbAM7y43-nPyyt5Bzqrr2UJhAh5Z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1OCBTYWx0ZWRfX1klGvRCRtuga
 i7YjD6P+M6HPwbR4XE+pNU6Gop2o/and8sKpnP6v/j1H/1L10lSy1aDUZ6JgYoZTQM2Xp6AFzKZ
 5XS2JK1V+xMmnx4tEgnz6RbpK/GMxbw4t4Gick+pOJUoIvrOQznD9H6DeyXjU8U8W3ZK2Oe8V1p
 zpIv0YPYmNJFVlcV7YdC8AReZAdIPJuFPOvLyg8xwd6CcbJVmG2ccavrceYrrBDKRVDGpGuUf6D
 6mtU6Scb/3sYMv1NpAXLtYjvxC+qWqFm/1XNwTXvWc9M59C5l2LJANEiPglmfLBfzTCjjogjeCa
 uywMXcKeTmWl4N8up3PaPW1V4dglweEui02GWaDfzM+R9nH0Jqrl/EBtufHyTRAla8QTtQ5DR4f
 PEHyjWLDaDNj+jqHbC7rgHcHQECxTuqrZegp3B8X3cJ1Srd/qoriglnT1Uq6fuW7yEaznRujWYL
 jOVfFQzZGiLurJ0I2tQ==
X-Proofpoint-GUID: U_AzbAM7y43-nPyyt5Bzqrr2UJhAh5Z0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240158
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 23, 2026 at 6:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> Add HVX IEEE floating-point miscellaneous instructions:
>> - vassign_fp (vfmv): vector move
>> - vfneg_hf, vfneg_sf: vector floating-point negate
>> - vabs_hf, vabs_sf: vector absolute value
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>  target/hexagon/mmvec/kvx_ieee.h              |  3 +++
>>  target/hexagon/imported/mmvec/encode_ext.def |  7 +++++++
>>  target/hexagon/imported/mmvec/ext.idef       | 14 ++++++++++++++
>>  3 files changed, 24 insertions(+)
>>
>> diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_=
ieee.h
>> index 78f546eb8e..263feb7e94 100644
>> --- a/target/hexagon/mmvec/kvx_ieee.h
>> +++ b/target/hexagon/mmvec/kvx_ieee.h
>> @@ -13,6 +13,9 @@
>>  #define FP32_DEF_NAN      0x7FFFFFFF
>>  #define FP16_DEF_NAN      0x7FFF
>>
>> +#define signF32UI(a) ((bool)((uint32_t)(a) >> 31))
>> +#define signF16UI(a) ((bool)((uint16_t)(a) >> 15))
>
>
> Use softfloat routines here
>     !float32_is_neg
>     !float16_is_neg
>
> Actually, these aren't needed.  See below.

Ah, good idea, thanks!

