Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0AEC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIXB-0006Jt-BX; Mon, 13 Jul 2026 11:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjIX5-0006GQ-IY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:25:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjIX2-00005u-P0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:25:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8PVc1922812
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WvwvHWzeI96
 UjZGLN64TQU17neeFRMrq6IWL2n2yYl8=; b=gGWH91GXSxuZssEwxwuq7+3mFav
 bQyLy7AcAcD3mCj3UgAJcBkou31JlIjX5as/O/IPU4+5S3xKaRIWejZS/itDcdNf
 dO9s/gb8LcWwxi0LM0VFaruVAFte4HjB6HIE10CYQtp+HW3o9oHjw7mrxsjKfhpA
 KS1zYoMid6PywygMK7tVh31XR+cU8CnQkVLsSLZfXIFTfM3HOPpt0DwdU/N6GPG7
 viOVACwlpfQyl7ZliILHf4d9keW2pHMFM0kkfLe+W8+7t61fsC603DALZt6NXGUK
 s3eyvZNs3jWtDIJTLu/Q5V3j3NRtPs6jauc59Xwbx8kEgLa1iodBDkjQxEw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubssx49-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:25:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c7f385887bso80008955ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783956316; x=1784561116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WvwvHWzeI96UjZGLN64TQU17neeFRMrq6IWL2n2yYl8=;
 b=XKXod8+ro+Np5irH2GSxHFL/HD8yY+NOpcJnmVLmar4ywrJ2ksSwpTxGwdGpr3KQiS
 FmXcxsmf5FRCTG4YttwlvY6CUcXLSHuQdMOI2M1yNR/otCHvMc4BHGNry6IyYXcH+qK0
 90Wa81m+pshqyMNaDHENPR/4aIaowhJMiQN8nZycnzD64owLLZ0RHwQgzeJAPp9Yf+mG
 3kb/Tu7xr9Wwed+QSifZxHNkTeLJl0L7LYvbO0BpG3HRF0z/jbLUBaVwN2OXFiIl47+F
 svd1MmpMrt3P3M2q8kFRKEBMpjJAXlpOFfTZQvgQmL40e+OlcaP/Re/ZFg5YcAS69V5e
 K9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956316; x=1784561116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WvwvHWzeI96UjZGLN64TQU17neeFRMrq6IWL2n2yYl8=;
 b=Zg9YjFEy43KlTB4P+Z+3b8JIdy69etxhx3cGcLG0cF2ZQxX63tIJb9x9rV5Y5qdJz3
 pq0xEYstrlZEehqVPIF0WBE/qSnRqOcvwKum3bzzjbt7CJtAjzk0EdEeFrfALjFF3HZl
 AOEggEUDPvGsU9WhFgvd0dLJPla5EBJp4/Ek5LaSOvMlrH5UbJCDU4FZQVxkIhTGVg/M
 atqmskwfJ1PrNGc2Nq0N+gYCC073XW3jpSPxNIYG84J937NFR3VHYHQ1FEdT4J2reLFg
 liwHAOSGFceJcTeBkvyuxz9XgnSzwffs7v3eaH+V2Yq1k9qXDP26hf3MNSLb7vZLMQ5w
 tWRg==
X-Gm-Message-State: AOJu0YxmEbDA4JrSjLR6jnxDsiTd/uqS2Ds3GPPCElkfU16miuePxfmX
 +fac4hXkfv+Wbs3zO8Uq12RRKD5YInEkIE/DkLAWDhpnXmO7hmKg03W1uz0JxhTJCu7EjrS/iM5
 9tzNMrDlWsY8RY6TDrWthA0P0ogbaDD+ewUD4kH3aW1LEQPxxirp5QBOqsQ==
X-Gm-Gg: AfdE7ck8kH+wec7jmpZqwdgtaHm2f8TGoXDmFgS6uHBXpm4iMHI/uG17sWCZPdeZnXY
 drFjVaOslL6m3mFLVf/g9bZb37yxz4Gutnb/BZH/3fhz64TIPKjUtTxoCrrddCF0I1adPsHDElS
 g9aiKrbS2zDaqBmdF94DjIav21JZ/nxH5KRCsO9Zgwaq0rNq1e24ypcxIF2A6UNrcdlMObYPJ7R
 fVGQAyEpzriFQybdevPz+Lw3jByG/chbZWMcPTcNm49P/0uMCxP1boXi3d5TsC1WVcciMDcqaWC
 vu2GHcsmrikqOIvysaQhGqDYHv2+UZOAp8kx26h5BFaXyN2pGins3d/MS9woXl+x7C2gJDV7oS/
 MfjaWUgmJj/3FrcFL4OuB2ma2G98+fTcNGTgHbm04dPHz0Dke2LBTkuatPZXui5SPhgO/yR9fwA
 ==
X-Received: by 2002:a05:6a21:d82:b0:3bf:6c08:fb98 with SMTP id
 adf61e73a8af0-3c110a1b5d2mr10762987637.58.1783956316096; 
 Mon, 13 Jul 2026 08:25:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:d82:b0:3bf:6c08:fb98 with SMTP id
 adf61e73a8af0-3c110a1b5d2mr10762956637.58.1783956315644; 
 Mon, 13 Jul 2026 08:25:15 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31198cb2b99sm47607270eec.26.2026.07.13.08.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:25:15 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, alex.bennee@linaro.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: Re: [PATCH v3 1/1] tests/docker: hexagon fix podman untar, 22.1.8
Date: Mon, 13 Jul 2026 08:25:13 -0700
Message-Id: <20260713152513.4039197-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260711185433.2021691-2-brian.cain@oss.qualcomm.com>
References: <20260711185433.2021691-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a55035d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Twlkf-z8AAAA:8 a=COk6AnOGAAAA:8 a=RSCZe5YiV2fdLCBOu88A:9
 a=324X-CrmTo6CU4MGRt3R:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zYmJrXkJlpbC7UrPCvoZ_Odtw5Sr6ton
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfX7PIZ6HfV90zj
 RPAsVyKz/knahBkV3U+u/RNa+fYW0AGRw7FdzaSWZyWw+nGJaIIB7vBJBVpjUH+rgERQPShtZo2
 XSbRuYu3gh6hhNH1PumPPgjapnACsdI=
X-Proofpoint-GUID: zYmJrXkJlpbC7UrPCvoZ_Odtw5Sr6ton
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfX2XXKpA/0UarF
 kcEm0RyAPIlpNSb1DlGiFzUaEtQUf4H0F0ud6P0yE5qzgaaStzm3l9mHzp+kBsQh4xpPrQjIIzN
 PkqxzhE7znpyVSSaNGhQVH3cQW+vpBTpmX+yvSi1lK4gIt/FGe2DHn1Q5rFwFTojZkROc0/epqK
 7TVLqR/Q/wrBuDdS8D0TpaPzwDQPLQQeuie5jtfLHhY5iCKboCJe9FDH1163dF/LEeXzMGslmQS
 WWkVt3SO/q1wkv0St+yEKGes8dIp33D8Leh/Jv2Dtc4wAVaCaH0oH7Tz3D913GtO/ZX6OLHVGIV
 nMkl49axt271brg98L+/LQ8y7AIBHaC8jz7l/3KqLNfS6OlrBc6NNeIAJo891GlYvAKi+L5hCbt
 W94elMKNk68NkUHG9j4bRosNiRhlobEgppaxA9R+5O/3JncUvp6WjqgTVr/hrc0RPTXZWlriKw2
 JiMVKzXIf53dEBbOVUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130160
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Sat, 11 Jul 2026 11:54:33 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The debian-hexagon-cross image previously unpacked the codelinaro
> clang+llvm hexagon toolchain by piping a .tar.zst archive straight
> into "tar --zstd -xC". GNU tar restores the archive's stored file
> modes on extraction, including lchmod() on symlinks. Under rootless
> podman, where the build runs in a user namespace on overlay storage,
> those chmod()/lchmod() calls are rejected with EPERM:
> 
>   tar: .../libclang_rt.builtins.a: Cannot change mode to rwxrwxrwx: \
>        Operation not permitted
>   tar: .../x86_64-linux-gnu: Cannot change mode to rwxr-xr-x: \
>        Operation not permitted
>   tar: Exiting with failure status due to previous errors
> 
> tar then exits non-zero and aborts the build, so debian-hexagon-cross
> only builds reliably under docker, not rootless podman.
> 
> So instead we can switch to a different packaging.  clang, lld
> come from LLVM Debian builds from apt.llvm.org, instead of custom ones for
> hexagon.  And only the hexagon linux sysroot is required, avoiding the
> tar issues.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---

Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

