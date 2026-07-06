Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6F7C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqYF-0006YI-4o; Mon, 06 Jul 2026 17:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgqYE-0006YA-DH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:08:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgqYC-0003e0-Hb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:08:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEAV91428975
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 21:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V5Lo/ePSesS59Rc8p/91Hx20co7cw6hvI521xfA7INE=; b=cGhJl2jLAOgiFbby
 qWrwWbdFJ4yJq6xQ7iirC3wgyNfNmnyb6szuSKYXvyfHVtKTPNAzZ4jpmBHtRIRI
 O+npSesLpGw5bBw5/t0bhwIblevR6BQUW/303FvzBjAH1ccVqUBgGP6q8HlarY9w
 sbbWngSvA7BW5VvaX+m+PdJjyIG4KHkcegXPzxUCrjEZ6R3WKO3CBCqBn7qocK4Y
 Jz794yIhLt+cPw+RvyxB70WeFyIXtgNrO3y/etCnOucF6/ovWfahXcHddo3X2k5J
 /eG7IsJmahE0Sb7NFPvV06y6iaue8CVuJ4tLYGSfta9wiYD4GRgm7p9JFgCdDYGd
 GaFTTw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxuhp6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 21:08:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9667280edeso4180951a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783372100; x=1783976900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V5Lo/ePSesS59Rc8p/91Hx20co7cw6hvI521xfA7INE=;
 b=ZbQzo/NnkPCXeh/KceHmhg2UVlmc0UIMwtIEJcVyivaFu6JFHHfvzYkyTPO/6ceTKm
 qacPzIaU0/bbpjBFznv37D7OzutfBYkfpuWhFkpZugrA+ZcQHYc4jZ1szTuWq78cjMvm
 +Kxhxy/zXyNfXHNuax19R9oOFVVQ9I5jfW+7V1TToJJmVpCPhmTpPmAPC82DUM29W1eJ
 L61OGYzC3A6+ujMcwfAwfxmJjcws7bhQzIQWgngwX4OSyShyEwDLuMtmv+bicBkF52hv
 +mBlOcdW23jofmr61hzwLkCH8fRo7YZpbv2rW3Tdudx1iz2ZcQz0arbMdV0Y+lagmCab
 Ckeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783372100; x=1783976900;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5Lo/ePSesS59Rc8p/91Hx20co7cw6hvI521xfA7INE=;
 b=VEoAqI6pTWdMCCAx6eUqCaqDJFr+mvFNFjoN8CQ/OSNLf5ceayn+vQ/RSFnNQxWijy
 AvDMJjONQBvTsOCtaaqcqIKMEkQYMnLPhqtzTEFz16GdZdNnRuPcWzEC+IBmkGG3nSmT
 WChqkpmdjtijY5MX1TLlXllNxGp7vZwNK6pWEk2rXt2gonRvyAsKUIsnGNsXL41CkMJK
 SDPWoVrQP4TCiw6uLK10hVjvbH8qoen3yYdnc0curF9q6wmfvrK6o04OuSZWL3ukb2Zy
 bJPkb4IpLGdYrszW3jImrrLqe17oZOvHwEgBHWF3LhFZCijKQNVjbFLdCDjAcmrUU30O
 q6Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrasbg3txvmHDeOMFGvx4knOtzpJ4OUrlgSmegi8ts2GZe3dgOFUXtNAYyxcasjxqK0wf0f6eVX15nU@nongnu.org
X-Gm-Message-State: AOJu0YyjnrrkJEZVNmB/u71Sl+GkXtT595I7oc69+MEUWshSEQVIHgCA
 EsB+n1rUdB70ZXMI9GxuGfNCl8Z8I/VPolIvGxaJc05TV8Z1o0pKtyS7uIMoHwsLmT+4z30h6jB
 ri9aODe0/mdkqXm0H3MUxSDBVoKa0P1HbR++yTcX+XXdASg+xw3R7PRTUwA==
X-Gm-Gg: AfdE7cnKx0qT8TnwAnF3J5y7ogPh9tj9VFgTkqfdb2NrlFfFJ+x8Al7IszOgxj991A2
 hFb0l7R7vbPQCggXj7Pc0M3x5IDAkTcAzDA+c84RSMdmHUiyk7ImYhImY1s4GQgCLtLI+7V6OoU
 K1AEfrXvvN41zhrG5RRjGVVapOsTMwSAx/UMkBjprr6hkEVFoPWn6p2FpR1gnBT30yHsz/ilGSL
 gXAwC4QnOvuO2hLGXd/39BxN2kan82z3p2ITooggr+jJnL/1Xsp4L6aipBTFi+EhsHaqicL/tXP
 /RcKBJMA+zxvgfW9y1NGnBLdaGH9FGgpFh1+C09/+NYYPK69baTkevwx2Au8Iuu6INg6Xif3wwK
 +DUhJZeToo/24KRGW97MMde477XzwVjDBhyW+g18Y1qaL8eEILZ+OpeeG9pVloTvi85To9tBru7
 qB3oU=
X-Received: by 2002:a05:6a20:4307:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3c08eecb8b6mr2845076637.35.1783372100075; 
 Mon, 06 Jul 2026 14:08:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:4307:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3c08eecb8b6mr2844946637.35.1783372098300; 
 Mon, 06 Jul 2026 14:08:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c76dsm407043c88.3.2026.07.06.14.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 14:08:17 -0700 (PDT)
Message-ID: <30d89c41-c290-4eee-8e38-df1924e26281@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 14:08:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Remove job building OpenSBI firmware binaries
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260706161716.29488-1-bin.meng@processmission.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706161716.29488-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Evr3V_TrDv9r2vpO-2yfc_e3JUFLvc3D
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c1944 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FRSEYCzRAAAA:8 a=t44b9nHd2Y7akxxOOc0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfX3g/xa+eAEzAe
 MWhGzhXnCgcASD7oHDAFwPZQnLEN4+aO1Urh8aBq8xiVGGRxw/XEm0rsjw3KN7WYwB712E7qg3P
 cvzRT2kpcy0fZLcVpVAxoE7czmeMJLI=
X-Proofpoint-GUID: Evr3V_TrDv9r2vpO-2yfc_e3JUFLvc3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfX+Dez0+FhPxfv
 IO41pvs/8NAWG9dhv8lECIxEixRm+CC2XiXV7DAXrcMJPUl83ghmHPSBJm5h/xrWL8LtoWuKlF0
 jFlKOaTN/venHshZ0fz1iMcz7Ir92ooayjlYl88nfai62lu1mPogj93PcrZ5xxyG3eHp+Bw1SeB
 zvX6OeQN6EYdxle0OwEbYABs67JdA4iuIzzgRF/Tuv5PGz7/6O5xN/sMcffE+kvm/cacPNRii0q
 x+vch4KLbsurpmOs+6eaxsCCLYE7KTu14EuDNp9MqWJnZBaC6gNslIKhx8uhXdwKal1snmlcvv6
 kMCuXI0P8TQcu5lvqVCZUq55pjcqYx9ymyo2ra29VK5xLeQwHqzZkHaZ2S3eUI6LRmzcxsfzi/c
 mj5xX2CLWmc5skUDMgjgMBYNW1oxjfgy8aAEuouYkWdrkKaLzLKavyQakamdw+WDHwCxGgkS4NG
 3HBDm9CqdmrRcSB/73g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060214
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

On 7/6/2026 9:17 AM, Bin Meng wrote:
> The OpenSBI firmware build job follows the same pattern as the EDK2 job
> [1] that was removed earlier [2]: it exists to produce firmware binaries
> from CI artifacts, but those outputs are not consumed by the tree.
> 
> Remove the job definition and its project include to avoid maintaining
> bitrotting container and firmware build logic.
> 
> [1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries")
> [2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binaries")
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
>  MAINTAINERS                     |  2 -
>  .gitlab-ci.d/opensbi.yml        | 88 ---------------------------------
>  .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
>  .gitlab-ci.d/qemu-project.yml   |  1 -
>  4 files changed, 125 deletions(-)
>  delete mode 100644 .gitlab-ci.d/opensbi.yml
>  delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile
> 

All good on my side, but let's check with official maintainer and
reviewer for this file to make sure it's ok.

@Alistair, @Daniel, are you ok with this removal?

Regards,
Pierrick

