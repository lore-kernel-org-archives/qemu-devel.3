Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BF5C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 19:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whBVP-0006AH-01; Tue, 07 Jul 2026 15:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1whBVM-00069g-LR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 15:30:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1whBVI-00043B-LN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 15:30:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5MBU341632
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 19:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 klAyfYSzAU+Nui0Zqsaq8hLHo1DFg3XdSqk8Z2fi/VE=; b=UGjRLpi2bxF15gfl
 DEsuK1Rwuyv+y/OH17EjCdDoyfBcg7/TrhxtwlJQ4W3+nIR5C8YVuQyhUCzR5pFv
 uu/PSMknhUhS3t3E3O4MwX79K8Rv2rNEaeeUooovzmmVSJlJVn1QG+Le/QKZsVkM
 aVU0doCBsFswkCo4pvnmAfVxnBcGjYTtGHms0f2B7cKx9tqgkzJr3//71FvCmzLh
 ZztTGMizEqpC9f1CDkyKme8czCeVRcdlpIgWZ/ckUCiQ2bEPQk16MW2lMDtiWVAh
 KrjVcle/Lt2W3iJ47SFmxOjpLN8icIrUC1Kebdd2Cvib3piKCrUt2maKmJPJVTnE
 fTu6cg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2ub535-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 19:30:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso333995a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 12:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783452644; cv=none;
 d=google.com; s=arc-20260327;
 b=flxijGUyNkKyc17dNJL8ftedAizJxWH9cQ9glFRsnW+kL5nTfRhrgKOGD0kNiGuFqs
 aybJjeKqb9uH6Sp1GNE6tdebhY8YTVWh326zNnAm+Kln9D4sl4YPMrsNfqfkJ3/kQWOJ
 4SK5Q0w8ZLeAJ778hD2PgGo5SfsN/LmXfknoesQ3hDfdblpodx4FMXz0z9kdoeksFEzF
 1UVgngtT4HCAj2aj1ZkdmYhpZSQT4e3lse9BG/nWZxFHLe8HaXvkzRY2sk1IrQQkDbGS
 khr6r5OKLA3zR8nY8G8ST5o59o9cXWULl44WlXlKa4zhDhWln/pJR7z20KxbbWr06Uyb
 RJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=klAyfYSzAU+Nui0Zqsaq8hLHo1DFg3XdSqk8Z2fi/VE=;
 fh=stLY6jImN8vGMgXu4que8Kfh71KoqXq63lTiEVf95qI=;
 b=rgccBtGfeRJG2ipa6v5ai6/obsBhzXcGeIhctD340gI0btNKTCbfl+Qyn2IagWxPSA
 AX1k8ZMDAiPYIvnCpomHET2MUBiacaMJ46P62Nfbdf6EEMp6my4ye9wgecyMPKgmw2TB
 TgwB/UrwVZGg1J7HVg9ZhJs5A5C+368lG1PTSDIOZUGrPrLB0QzwED/oG0kPUAeQeXod
 N1CTBSNu1c4YlT9sn+i7RFKow5AikZ5cjB0+N8w71tSHCogFqeXch6S8P8TDAnUGDDK0
 dxyBO1X1y3F1cfqQ4oMEEOXFNfl0dnn4flzmrL9Nv/jW1Qq+yzQDHBXdqQXes/h9qcEd
 6kFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783452644; x=1784057444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=klAyfYSzAU+Nui0Zqsaq8hLHo1DFg3XdSqk8Z2fi/VE=;
 b=EPApmXRkuLzX2gi6QXk9YnZhQUGHuUU7jxfTX98A72hc86L6rh3tyOnb3conjigmXm
 9dIF0cm5Z6osi1uT81r6pUbVHuvjHzNREkAfnRDT+yqBaEhfC+K6A0CVHeTW0W5DdV1t
 Gy3Mpy1elxLe7NwsG1etR/okr8f2Ou6N24B6J8+0mfy/1+NfqyAgMBpqEG6EjBDaW3Ev
 rb5m843qBrENPmO1UWG+qFlPK1Y9He8DH1vHoBvRyVpHDNJRJBheizsce/QA9UQ0Tnnl
 474lW+fo09jSemkeak38oWAc9VQGvzqXo5laSoT6G2vBUh11r37VXc01MdAufFrqT28/
 IsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783452644; x=1784057444;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=klAyfYSzAU+Nui0Zqsaq8hLHo1DFg3XdSqk8Z2fi/VE=;
 b=fvTtCkg8KslSLq1N74NqB+4LB0KGjjSdMagyD92uGJV6ZbgP6eD58T1pzpLAkTaxDH
 Pa20kMrhNB5tY/RCBEXoffgCwT/lfBNjqcu+rX7Eih4jfnsAVMw9WlT+96ibAeE59go1
 MM+8gg8sxZk9SehKx+gAFX/d6C5Cq+bJzdfYcZizhXfj9zknzabRR0mHq9IRAWnQX3In
 IhufNlvOJv6qyzz8NiVWX0vGKgT3ObRL98SejkiH9pYKdQuxCVOCciGoHljA0pIcvbos
 VPFurk5fSacyl/oItZQpoim0yEhyGSPJwbLSo03wC+p/htwZTr4hSMLiAUVNJZNY07sd
 PlVw==
X-Gm-Message-State: AOJu0YyLUucllJgU8g7aR9/PqNYLD3j1uvHmgmeUleDkmC0qpQoXvTIU
 /gsUGBJqKd9lMWkub8iSUE3PtnYIsuCJjfQAHiQ9OnjCgNao1LblF6OFVuEsWOrD2xlU36LyK90
 ZnognVD4pKUvMMmaNWvBtjgTlIWcfZUYrZnHuwBbnUeA3qJjcEyq/50yKtV1CbalJUaam4Eprqa
 ltJBia5MRUEReCUiG7XB1/4LuRpn6sMGXJ
X-Gm-Gg: AfdE7ckcc5jWD3BYg5WWRAX0xRumQWW+GTGXlYKABZApEZA15N3DaL/AAWDGZo4kID9
 YZXQUcCA1ny47wzbWsQuIV9E0QBhx1APOzVl5c54SZCqTqYBun6MpTTaq3vAV2ePD1O7q8ssGNK
 k5cxkWeagPTWbV/UZlQ2cJMit5dJd1cGxqWlTAqAljtXnWX+1REQc5nDoSg7tmyS1GN7IWE2+XK
 hCsemBlx2LD8qzAovQ7eifCUfCIde9PnEuiYqTcwIMeiWmoV+44P+W2b6jw2xwgrdSUH7Da+uwL
 2GEr0jaUUhHh
X-Received: by 2002:a05:6a21:4613:b0:3c0:9c19:65ba with SMTP id
 adf61e73a8af0-3c09c19685cmr4652462637.66.1783452643800; 
 Tue, 07 Jul 2026 12:30:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:4613:b0:3c0:9c19:65ba with SMTP id
 adf61e73a8af0-3c09c19685cmr4652434637.66.1783452643221; Tue, 07 Jul 2026
 12:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260707153003.58914-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260707153003.58914-1-philmd@oss.qualcomm.com>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 20:30:31 +0100
X-Gm-Features: AVVi8CexB02_fBzgWHQ5jDgwXYujM7LzW7N1W46eQxGibIphFKDVdgCwwUpXUwk
Message-ID: <CAD=n3R18efHRZ9Lt3t4xBS6OWrC-WTAf5GioWeyiYFTQ32LtBg@mail.gmail.com>
Subject: Re: [PATCH] contrib/gitdm: Update Qualcomm entries
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Marco Liebel <quic_mliebel@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE5MSBTYWx0ZWRfXzfzSm9YspCWe
 x8xmGme6kZL/G9lq+Xjlvlo1fJ7eD4NWsT/kTsjQZ4Rxcrm7iBzfVreI8+Uj0g1oowRd33jQbFD
 qtpjai8JelOmn/GRo69f/dF7Jj2IMmU=
X-Proofpoint-GUID: 5hsXSn6MxmaoUE8pzOIIajr8ypUoWvW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE5MSBTYWx0ZWRfX7PSqaqcV+2Y/
 10zfemfcy67vDNCcuh2RXPC1M6fQvBuoqtfYZASmOGIgryL9iXgEzzhFrQMJAlqiXOYE65n0WQY
 mIozxJPrIu/U/rvojksiNGkuVmh4O1Mo2d5kaUhRYq682WXobhqX7MY1sJeACkaPPg/BkD/4tUZ
 F1IX2JCyoBSUEkrvPQ+TXDtiNJ+HlgTVpJfMJXFCZ5zCPOdupZY8fiJnxtaqsXjGUSVvF0kzKcq
 XWopI5Yl0MRWtYPAYc9mnYbSMLZXe4DTzoPHUhS3wfFoOHfsJGqC66XyeuI54d40i9jYkgrGjKs
 C/ffLFEWxK6d9XMjIR2yh/Vok+AXRvGDT29lksL3QQLmxRdiFG0wS8zLP+4XdLOeCYXZaN3uarR
 X4rl7upR38b7QiyhjXT73D3nsh7PgywhRvKrWapzlOAsmxolf7TrJg6wiUHX1UHgub5WNAepjE+
 lpnau+Lw7WfLGVVGs8A==
X-Proofpoint-ORIG-GUID: 5hsXSn6MxmaoUE8pzOIIajr8ypUoWvW8
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d53e4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=j8RhgVXbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=Qm8iP6mkAAAA:8 a=20KFwNOVAAAA:8
 a=h0uksLzaAAAA:8 a=VDpOrwSoWZpY9h630gQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22 a=3SzYsRL22XtqO3ZTpi69:22
 a=kDhhxE42lZnxL3pOKqYK:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070191
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Tue, 7 Jul 2026 at 16:30, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Add an entry for Qualcomm Technologies, Inc.,
> include previous quicinc.com contributions.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

> ---
> Cc: Marco Liebel <quic_mliebel@quicinc.com>
> Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Cc: Sid Manning <sidneym@quicinc.com>
> Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
> Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Cc: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  contrib/gitdm/domain-map | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index c07dffc51bd..aef20c4949c 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -40,7 +40,8 @@ nuviainc.com    NUVIA
>  nvidia.com      NVIDIA
>  oracle.com      Oracle
>  proxmox.com     Proxmox
> -quicinc.com     Qualcomm Innovation Center
> +oss.qualcomm.com Qualcomm Technologies, Inc.
> +quicinc.com     Qualcomm Technologies, Inc.
>  redhat.com      Red Hat
>  rev.ng          rev.ng Labs
>  rivosinc.com    Rivos Inc
> --
> 2.53.0
>

