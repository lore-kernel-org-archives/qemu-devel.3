Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6ABC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtG68-0001xP-CH; Sun, 09 Aug 2026 22:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG66-0001wY-Ca
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:50:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG63-0004IE-S0
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:50:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L9kLo3783556
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C6xF23wMtECyPlsnD3UlBE4sXpoxGuyNvv6jP8X2eaQ=; b=kfxh7UD0GeHHHWje
 3YgfOuBVBuvLOjtL9MobY0IAJxz3bK39REvvxva3N4cQOajZDZoVboZGu1UxHOhY
 SztBQzaAWfF/EQ9/fXuu3Zd8tx08ejBjA/PDg6k7/+mlM0DRGKxuyVzFZhvLwuLp
 rh0OXGlbuDTXLqoU6vqZ8ftN+U0VFHUxPCxcfg8uycBIVrQCdc/RQ+JRJOisOVLi
 PZexp/dJO22ViEQu+Zj9AGlyarm0V4UWxbUCaWR/LeoFb+8EJeDJxVw9H9Ghm8qn
 Psk1GLMAqIhbwhLZ4PQEquR0Q25ScjL4FsZUUZ2eW2JlZMbGnVzHrtQ7kQmPA7eO
 VStTEA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvhvc2pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:50:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so31204721cf.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330237; x=1786935037; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C6xF23wMtECyPlsnD3UlBE4sXpoxGuyNvv6jP8X2eaQ=;
 b=f2p2Lhhwe4K0Us3Z7VMKxh90AHDHLoAoKXQ4dcQkRoj1GmoRCJ3ufKDrbKdt5jfMMM
 KApGr+SSii7/p+8HKcK3+4Mdd0aZH0C1MbCL3KNY+5fMNxg16MGzbObzIFSaMyeGWGqs
 TpCitOIlElWUDkl48mKPIbQlwM4Oja8Jwn8JtO2TZCrvO0sU1oJMA/+HH8b68W32tx2G
 dLdp1K7CIbfu//DZom3TElcASzI/ovqsF1CVcxzhHynfM4G1UNXogIn0NmJEduclhUwv
 miQtfpXzPa+zdTLE8elUbZihwxB80d+PKt9y3BduT2E2D2wwEay1e4r6e3dd9oNdVcR+
 salQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330237; x=1786935037;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C6xF23wMtECyPlsnD3UlBE4sXpoxGuyNvv6jP8X2eaQ=;
 b=a9B0g04w8tIEQcTIL6xUQboowIw0bNzEXBA830fs67eoQxJcjbf5rlQELbtmq5siB/
 iSv/RQ8HMtDdoH687+yqqy6CmwHrdwx50BiqOZ5Rv9mtNYzbC+/MsrpWfBHdQysGjtFG
 k2NQZ/12M/fpjreRRyn9zbwp7V4R/dw0diX57kBS5mjqv7sZhGEqCYUQ5EIFbaGKuGTy
 c4qSEhiq5RwVdCjvrsaQ+Av4i2O0H/rYNc4j6qfyCvn0xnO12yIS1kau9UcAQ6A57f1k
 eUuZySHuZdG0XDDqjNks+k4Cj3g7cHNBu5f5VulUVHruWjdIwwUTyv+vIkyAGUDCLSuZ
 g5Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOi1bH54Y/BSmI1HyDlZfcZGfSEdnvcukZF/HASzyC2sfpn48fiMhGr5+hswDP/Wn7e/QVrHhfGbHd@nongnu.org
X-Gm-Message-State: AOJu0Yz5xrRznFC5T/jXEyQqfeSJAu68vcmJkkH1fiKfdBaMvAkwgX5e
 WMOFgu40IX46Y7eLKP2FEtZJ0idfdacC/j8Np2hsmH20IOCBEe/8erfrUTP/76nSBOVwvnXLkcf
 GR8LmddZgMrBKaYG9CMaLqX7vuoJYMciajct1FZsDLN4gqyzsQLOeD2thaQ==
X-Gm-Gg: AR+sD11I4IZko6e1duV/BTbhNzZca/dNZ3mjIH2VI7u09jhw/OEBZUhrrH96ruGYAUX
 2Ir27C4CESBDeoXPOeDx+Sh6uiLlKKT4Vn9jepmgrfcQ0PQCWay+iH9VMbDRXsrlVD2MZ44wuNE
 bKsCqqjkeVt/A4eDnfyTslbdHm0TmVMbeKEtJugtZh5maf3dsHurx2Gnm3pQ7YRe2igflXi42tj
 Z4VALkOG6R7USx5SmrOuu35dJxohD8vZ5bqZd0pzEDTGIVakbE0oHsYIifik6tjCk+MjsMhf/Z5
 pEwDGjadx5JfUa2mTbhJGG4O3VThgqBTrgVC5JdBp94yVuN67g3IiVvw/A/dPdpzGnDdbUGWb2R
 ZgzyQFqrCWQ5G6bObnus68oQ2GXOg7ufvkn4=
X-Received: by 2002:a05:622a:6815:10b0:52d:2e0a:8ca0 with SMTP id
 d75a77b69052e-52d2e0a8d4cmr76268551cf.36.1786330237317; 
 Sun, 09 Aug 2026 19:50:37 -0700 (PDT)
X-Received: by 2002:a05:622a:6815:10b0:52d:2e0a:8ca0 with SMTP id
 d75a77b69052e-52d2e0a8d4cmr76268421cf.36.1786330236968; 
 Sun, 09 Aug 2026 19:50:36 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c69c8ffsm197214915e9.2.2026.08.09.19.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:50:35 -0700 (PDT)
Message-ID: <ea434114-130b-4412-90fd-2e199e8d8d76@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/loongarch: Enable disassembly via capstone
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqbvCIpX c=1 sm=1 tr=0 ts=6a793c7d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HMCxKvAKVCqm4pXRaRNdTXN2vHK9_yW0
X-Proofpoint-GUID: HMCxKvAKVCqm4pXRaRNdTXN2vHK9_yW0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMiBTYWx0ZWRfX592M8BpZzm9L
 DYNHgS9Y02WkucIbXBsIzv6A9Bt456UasRrAMKwx6CRa45h3/xcg7lJB6KCZZaI/TNZqZpSEBbl
 ebKvAh2oVw5ZKcJI3Z841G3a3ZBZDlVceRelji1eBicMq5w1Sj48bqu2+FYtv/xwze+HGr3DdZc
 Iwl6giNeeGHtxO5KWLk9izHHWGLkxFfviJIigin1xkKXJBh4zjtDQRryOU0lIHPDYUegdi0kfp4
 hP+A38Muo0tQbgVNjB20ds4DhuZFu9dzVFd1c++sYX28oALQ3t7NyU29x26W+Yuv5vaUY7UKfud
 3Y/PNCxGjb8le+WY7Ar9KseYEjTXclz5ucu0TEFf0EhfBez8nRBfpdg+q6I0iFJpknBZiydZQuu
 Zh/jRrxz62gUwzjjkxXg2NkD3/v7itJNcJGFFR+xfr29tDD9pIyzE7cNO1OdIJ50dtT4Uvosqun
 fh3KzcsSyTGaQsaAGEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMiBTYWx0ZWRfXzGSh7nb56epX
 cWxn5Pfxz6sIRuSnrOWK0n7FQvfPbce0MupqZS+Sc15fUdOZ25U+EnR+E0I1zhv6Wix6XbfZoNF
 qK1CRHlDnBqjRrClUgLWGbMZgnRL050=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100022
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/8/26 03:33, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 6 ++++++
>   target/loongarch/cpu.c   | 8 ++++++++
>   2 files changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

