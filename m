Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88791C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX4g-0004zm-3f; Sun, 02 Aug 2026 10:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX4e-0004yz-IS
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:21:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX4d-00078c-3K
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:21:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B89fV1509609
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HR1dT2z5cG2orqC1kCvm+Xe8oMd9y85a+OjihJoDYWM=; b=DYnkmJV3zB1Jcb53
 Ms4tybH7GPk+Sb4qSaMMwz2vBBSkMXxPXs7A1LEXipZGMm4BBaUZIDZN59vytB9G
 K078FJITBJH6bJdVkgjnQhoK3ZyxZa33f1QCg9zePqUKjSkaVveDvrprEN6QsdjZ
 ItNFTx1Esql9Ov5sv7GXmibBJC+8L7KA+1I4ZaBzL8oMjH7ifv+xgurmswUQUVOZ
 UZH7wvFrQO0zaAbFhLEb93stpPi2cQURlUgglPgiRMuFhBxath6aG8kXBVwCC+sY
 UiAFsvIgXgzE+2okO7zY6+0CEeIH0WYea6Pa/q5RLsHLCH6fywuskAE6B6qqBMeC
 g7DjjQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8u9aycp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:21:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so24902141cf.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680513; x=1786285313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HR1dT2z5cG2orqC1kCvm+Xe8oMd9y85a+OjihJoDYWM=;
 b=h85iP5Wnm/GEKKQZhQTuKPetYvuxaUHYgTJHGpfbZ34sDsalS7ez/1B7lqeWc8S57U
 owp0JaO4pE068Ys9k5BpgkJ+kpXz/P49Xi1hfHYZwapnvv+jgDSbbP+jsFnefHwRlWlM
 GWIJhKrvtlZFnqdF3kJAoCC3ITQq21o+0Xr6oCnAPTCA8Anl2kibxUUA6Lo9g6obUyZe
 icgal+QCA0fl1PppX0p3p3ynOfqpFoVtNwj77tcS1uO/sO1aeCAqYrXel22YaW3LbOoH
 nib4i0Xsi0j5zNOfZze3hPvedHlkUrDsUGukMkldzb6ZHl1vg7GrogAvYKuIvvJzv3qs
 1pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680513; x=1786285313;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HR1dT2z5cG2orqC1kCvm+Xe8oMd9y85a+OjihJoDYWM=;
 b=NVNGsJDtB10vJKPB9xNJx4xfGhXc2cC2cGeq69zRVB61sB+m5rIRAJa/5VYpfmSOB5
 ZGZIw5BaWVOF/xBPMiJcYvqD3kgvcbamXm8qF5EWzg/yhSQJiOlmabU/XlxS6nvlWKZ1
 Lf1XXHJLORkCn6Kb7IkWpw8uih1u7xHbkRYP15oPgmo1yTVcn/6QOc4J8fQx/7xys5LI
 uV5IIZlu9k+a2nc0kkiZZ0WXc10zyL9KKyQITWNYALHmbXoYH1C6QV/saPbgukm1Jplz
 7yVmxlCkMlWSliQRua3up7gq/30k3C67CO1KhWup/duR7w/aMM8eI2GZyjaPINAOVaPQ
 NFUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RobfxzokflMXLspL6m7ThL2m0PlybJjdy5McQMg2tBOynDQE7Xoj2Qf26Kk126L3ORTDNOsoH7cFpCi@nongnu.org
X-Gm-Message-State: AOJu0YxjVXUWGAnD9KvSpPg4fEXeL1YxJ4FK1Iqys5lypFzc4y6t6ZM8
 bP7Bt+StWDYF3j2z5aeefP2tVlcR9F/c+trd1HccQIOJ177VygSVehEDk/mZGgeZFfeRPdN4qA+
 bAM4tJ5yCG6K2InF4rdUyxIhIgQPg18MsF+ibexRdP+Zr+MFx4btG/p2VF4tjAhMEbw==
X-Gm-Gg: AR+sD10mo5xtVYL11fLWdUjJaBnDScI3SxOzo2k1RQfoIVxxxrWk7o+enEyWrje13fu
 /yCFtA90VmL/DWnG9kBOUcxlMgfJLef8DrIj+lvSfPVfdn/sGwRSyuOkfHi3Tz00XLzpXL0xDCC
 Wjjk0ne7KeyEEqkMjiqtJtpeA2ujC3CEaNtAmG0WSyJp9szLI4AOPkI9BS/bBlPD4hBKkwL0dSe
 LD+cQ7QFZ+WZGEdj1H56pKoYkiJNBRj5rtrpSJApPJHgctext0iu0+Vhzjt3p1/JeQekc5SZhXt
 8g1lxWZ0MopVKdv5Wc0pY4dtFFJGOZZYup5w7HUorY9l/xITfsJ7SeFYtQxDOS6YiPsvWZLv2FU
 eE9yFAQHptTBIVIcw12GzMPdkqZVwUrQClo4rjCOCrYtPVLzyJjs=
X-Received: by 2002:a05:622a:5811:b0:51c:b900:513f with SMTP id
 d75a77b69052e-52b566b14f8mr136794911cf.10.1785680513315; 
 Sun, 02 Aug 2026 07:21:53 -0700 (PDT)
X-Received: by 2002:a05:622a:5811:b0:51c:b900:513f with SMTP id
 d75a77b69052e-52b566b14f8mr136794501cf.10.1785680512898; 
 Sun, 02 Aug 2026 07:21:52 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980819a030sm147569925e9.6.2026.08.02.07.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:21:52 -0700 (PDT)
Message-ID: <023874cb-50e5-41cb-aae5-2a42b85cad8f@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] target/s390x: Use op_st for STORE REVERSED
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sDOVY43GYqSAOJm4PBaK_S-kUI60jIYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyOCBTYWx0ZWRfX85zx0C3n7YlW
 bxLvQjy4Qe5Pt5W872DmHnzR/wemLtCalhD9H/MF3H97Pvw+Jo979E8z0dm21Szm5/s1gu1iJ1/
 I1tUyLsFvlVZwg+fH/fbC58zoE2MRreOjlavXnwfyG5HlGEsmZ8G5DVFMJBMMH5AgoW7vRyZVZZ
 ik5s/vb8Q8LYvWtqxG+aciQLMKxKobfxBVtZ3rvXL5QY0wv31EYaYqoFtXS1uv0/rTt7GPeg9VA
 nAi93GXPwy7w/FYnfVLjE+ZeOqa/1m6pN14LdUmcDNIZ373M+INysF1tcCUOq6pK0mRZLVAkGuk
 dTyVjv1aHFirWbiNo9dVEygwkHI+SoURL3oJtnQzwKmpkOLyDJXURVgTxeRiKSO2ASfsWoiWmuE
 mSNQQs7oocaM4SXXbh7Cz79tJeBc235uTfWUPrTQTFBdGlQwDBoJIzZOZI44yguGa8j91Pt6rX5
 HEYVA+qQNcA8QMLRysg==
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a6f5281 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyOCBTYWx0ZWRfX0+6faaIfsybI
 YgEuRAT6TzbCIcWpSx8FvwKir9lVYtczNOBcpMZK9sggG/co9tQqi4MESbzQLF90SZwjfazUDfr
 dQnaw9kdD+zjqHRyxdcVDCdeCLmb+P0=
X-Proofpoint-ORIG-GUID: sDOVY43GYqSAOJm4PBaK_S-kUI60jIYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 31/7/26 20:56, Richard Henderson wrote:
> Use the MemOp parameter to op_st to directly perform a
> little-endian store, rather than a separate byte reverse
> before the store.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 13 -------------
>   target/s390x/tcg/insn-data.h.inc |  6 +++---
>   2 files changed, 3 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

