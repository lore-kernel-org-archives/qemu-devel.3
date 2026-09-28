Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C539C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8f2-0003P6-74; Mon, 28 Sep 2026 06:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xB8er-0003JR-Ax
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:32:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xB8el-0003nz-Ek
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:32:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M9FF1195740
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=G5ivyUuKV4P829UvfjJhYTlM
 0U+Vma9MKuvP6Pzhg6E=; b=SMy07vOUQNr37amSa26ud2miMJ8aa414581s9D4U
 cAEjGGyalCCSGqlud1aJq6nUkcp7Z9P90l/WFPoPRCqZsh0K9cnaoCff5vgPoclP
 BOlkFKZ5tQJrG5AD9j68SlcM+x9aBQpArrYoQ/ltMh4dowahSOqrW5RzN9cm3m7M
 JxygJLLl1jVTnXyZo+MBJ/yrxW2lRj7642BhD8Tk3qS8j/YW5THCEFmINQQSvEMK
 U/rmy+OE8pCN989hYMxH1yemlMhQTFcvQKtOaB6GrYh91Q0XjiTFQ/th53nnIcnm
 dam8J+DH6M8s1V4GMaO3P/dgz0DTJp7V04PCAtkDeg+Zwg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s13xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:32:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a05d645acso621262085a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790591539; x=1791196339; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G5ivyUuKV4P829UvfjJhYTlM0U+Vma9MKuvP6Pzhg6E=;
 b=ETOB7HSKvyFiR868aDQMmv6Uf1kbwBPW3WzJuuX/lYtysgWFp3yymxy4DvrG0f80be
 ysyzPKO7Cq2vW1LjdN6gq2yS1oxoIx+aN1Z+prxDXRys+QQDfczBt4NCz3Y5A++D9EY5
 DNK7qQ+0ZSq2Pa1eXWSodJSP/DsY5r1Pj/kTwGbsqrXO5epC5TUVTCi3iuBJ9tItMF89
 /cYuyVpuCazoaXwI37UhZKKRcLIW86X8ixiSsVRzaSjQiRbLr8tgNxqM8hO/rN/oyTnZ
 QSLVrNk2RpbZDbGyKcPLIoPA2MSZ4+Qc9na84DzUKZXwYUc29bO8/p4pdv/GpWpfDCqK
 WHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790591539; x=1791196339;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G5ivyUuKV4P829UvfjJhYTlM0U+Vma9MKuvP6Pzhg6E=;
 b=dqtYggWux0uchIyVixQQM97mgNMbkVYIaIkEsE6Q8Fcm7r2dYhbZCgwKD6vt8fn6l9
 bbpTVIrlIpfK9VzqmYuRo/ZnhXJBFXs/CX0pPITO2oiXz9qpdU/L7HjbmmK7UgRHSwkr
 WOJ/oRkV7iRQI6QKYwI9kC6UUWATYk8Rmzw5EFnK2tTfurzN0vF+lKKIWVS0WiQloilm
 Giky5NbAvn8eAOQQKpgGYfK/IAKZOU94tUPHUl+6ZoFniGS/j/K6kRjJtpqO8R+qvZyS
 KcJxKU7uXuFzA5KApOxAp8SlLxCCAKHVkKgk9lzK+qGsXHS4feV44z2St4iZCgJMAHXd
 UXrQ==
X-Gm-Message-State: AFuF++kfroowGcZokcf2T4r2gjuq6PjPWwajzTvuwZhOCm+8gfRPv2u0
 mvjO7aDTWcMY4pC4HK7WR5uL3GpzT28pcjMjmgMT56o9R7M3l7e+0Ah+/EbSa0FBkZeahG99YrH
 fFrrbUXeuTOKs6YT7hEvMvHBorTqbsQzMTl60UFEFZoSLJShQIhhaEc6aBw==
X-Gm-Gg: AYBFou24qLJfVtjuZSBz3z59E8lK261i7SPORLk/rajN0gYBxYU87fq8Wfx1Xwecwyo
 o+yVdmjuJDtQt7rqt01CLsIlbLkQiBixIcaOnzSWB+mNm7j0+kKMc8aT60LY3f2ptn+LvLWke6t
 62e2j7Gx7fOR5y3rk8ocNqLgX/dckx5/lU2p9rRUYrkAYwa5Dsjtu7Zlnb6wI4Yz9N2TZfVanbD
 Q/ktNxEZGWEE8ZJANlqwZEsB32kpPAemK7jTdp/Hoj8xjmUwBMeC6vCJ6HhMvOviNYvdA5T6UO0
 /h4JjtQkiMt5c3NxmMim/zUK6iaYwMzOWdaNsYkW7DRGEiV8KTIRT7UW5J2OfxfKvN3UdmhB2l2
 c+DkORB+aZGciZsmoca4TVsPs6NFjzx4H1uOwmA==
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cef with SMTP id
 af79cd13be357-93c6450c33bmr1043236385a.57.1790591538841; 
 Mon, 28 Sep 2026 03:32:18 -0700 (PDT)
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cef with SMTP id
 af79cd13be357-93c6450c33bmr1043232385a.57.1790591538365; 
 Mon, 28 Sep 2026 03:32:18 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b1dfsm27651233f8f.4.2026.09.28.03.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:32:17 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:32:16 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v12 2/5] target/riscv: add riscv-server-ref CPU
Message-ID: <jd3sbg3cdtl4y6ogu2oyhitpd45jbrm6ir55f4bwbebvilkd3v@nwqxtslxlc2c>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
 <20260917174405.3471736-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917174405.3471736-3-daniel.barboza@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX/FY+iCds9uvL
 4djWLfSiARCKtlFFS7exMwnvIn5ES3/EcLbYDu9QDADi0PDkDTjjP9Jw45OSke5dGpMxj+v1afN
 Atd73M2lL9HP87azzIiBFBYVjQYSxsGQGNPDxn9obVYiVDHv8wLTCfLy4THBXxlOg+wSAtQLR4D
 hduRoHQflsZGoRkJNW+hgB1FowthHi7cTVtx71Xxskyy9dk8zbV24OS4brzJbWCqdKxbJYwdzm1
 ed9PCRtGTp1sSl/mg6rcWfI2+57zd8p3cd5BavDHa47YiBofQgL1Cx+XNx1zhrocqIgJBJolgyh
 SheelgUpuGWETOqWRvs1YMbWUXSqCUvFukEBQaJJqMGplquu+MulacduccSK+giEcbDcHGAOhZe
 zrhLYh33kZ/wnfnYWNqlQjhNpMmOQszF9Ful2aOrmGGVDxLe93uDArz/y2lKxEKs9hiQCcoeGqA
 S3YkhP+plQpmyMUBZGA==
X-Proofpoint-ORIG-GUID: Po9DjTuUveAfrwaMVjjXh6goKH3v-JSB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX/Dds+t3MvhsR
 GPMtoh6Fv4toQ48hOz30bnUdjtj7SbZkL4kl6CczIjlySlrZfV6VJwdnX+1PCmqShElAPaRfLMB
 dWQpl10DyIKBcd3CpIcK04tiJJlCK1U=
X-Proofpoint-GUID: Po9DjTuUveAfrwaMVjjXh6goKH3v-JSB
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba4233 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8
 a=FRSEYCzRAAAA:8 a=j2afkqJCyIVXg8yJ22EA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22 a=1qLaeP4TCVy2vqIEy19U:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, Sep 17, 2026 at 02:44:01PM -0300, Daniel Henrique Barboza wrote:
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
> 
> We're going for a profile-based implementation, instead of a regular CPU
> that can inherit RVA23, to allow future CPUs to use it internally as a
> starting base for their own extension sets.  There's also a new
> 'rvserver-ref-1.0' flag that can be used to set the extensions in the
> command line for other CPUs, which can be used for testing/debugging
> purposes.
> 
> Note that for all intents and purposes "riscv-server-ref" is a regular
> CPU and no, we're not trying to set a precedent of calling the riscv
> server platform spec a profile.
> 
> [1] defines in rule SEE_020 that we must support at least 11 debug
> triggers (4 for insn address, 4 for insn load/store, 1 for icount,
> one for int, one for excp).  We're going for the minimum.  If more
> triggers are needed users can set any trigger amount (N <= 1024)
> with:
> 
> -cpu riscv-server-ref,num-triggers=N
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Suggested-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

