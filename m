Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90154C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4kz-00020D-FB; Thu, 20 Aug 2026 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wx4kv-0001zu-PL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:32:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wx4ku-0004zB-7K
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:32:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KE8Jj23147102
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+M3izAXGDSp
 vmvVjLPVlQUluIOyX0ROe+odp0ix6YlE=; b=gKYNjJtX5K8rv2Tjqwc24MFZydb
 UTK1XlPIVTv2VjmlkcR0mHN+URh4gOedr0oJxfMx0ljQWhsb4iY6d7yGLLPyo69G
 3dJAjGctdibRinpILOjAk/zYINUOC8YCr29EWwju1x2MyPcVAIGLX7V37fSN52N+
 GhelDGmimIbC3Z2euBzyJu1qX27cjOwJWCFQewAxsnLcC6kXtUyZwucdztJHNr9+
 Hz/FyzFUq08nlG2VSqp+nlgXO6wJcWAgUWlTAQ6zznMZDv5NI/PTeCwhZzJwbVH3
 AzR4zXzadG6nLbvH6TCB/aRxQe7JNe+YeItJft4FUVMVVHST/PeFGoCjL/A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7t3k3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:32:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so4846117a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787239953; x=1787844753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+M3izAXGDSpvmvVjLPVlQUluIOyX0ROe+odp0ix6YlE=;
 b=O6KYcgI3Pk9LiGcdm/sae7Bauhyhi9JmJBJWjcC2YVGB9VhYyZoZPKRiZfLsRPROUX
 VuVP/mfXDSRuAbXPfv3Gm95i4NH9iLKH1aPVh52CnxX5gc2r7lI5IarOIDdX+lQHjxmq
 VTs8DFcGp7yEp2hVcCI5KaMNtJwND0h9mcciTS1urV5voL+bFdK95d8EGnrB0d7hps1h
 u3sR5qTawxW0dpxi38mgkC0dB+iG9GcGrEweIcR8ApR5lW/OmGZplpqN07MoWbekLxic
 6UrQp8BbdLZTTkhkgRTE3I2Bnj6riGVIrPwVCZ9ig69YmX5vBvRbBLadBHXfRglyRjv9
 3DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787239953; x=1787844753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+M3izAXGDSpvmvVjLPVlQUluIOyX0ROe+odp0ix6YlE=;
 b=NtHqb6xTHg4hqe+3tsivukhLEe5pziyuMzMgFa3zQonzauIDVeiraQNFz1wfcJeWoo
 l7YUARCYRpkPCNJ4M52o2A/mXMltP9chqhp8PKegYIxz1Q4vwOZct/OU2bzIZoVSko/S
 tUieRb/oILyu79K9XBSXU2bpQe+H2AhTvAPHTfEuiEJbt0/97hbUipGnSxkZWznsf+Ok
 znIaIyHfkCYrOnsRplxzGzVShzWNrzOMAdp466xbHfOoXEdKaSTJ7/Qx1AdfjDsJxhTa
 AU3jspyoxfajwZX2BHOnAvx90GgfhGEi6cib+I980nI+ZPNeT0+bOYLd76bpTU8ZW8Yg
 S5Ww==
X-Gm-Message-State: AFuF++nUk23QJLimNqVlf8ExPlOTjcodYYMCRjlVifCgLeVKPv1X4LJ5
 U62TqcOAI2U+w1xiAWFdFJEusd1AFzU6yVbJtYmHi2/AZYJXy/On6l4dxbA88nvXsSSv7ysNszM
 8057J+27KB/ogb7hoYVuIgtMxohHmmcAobdqttDFmUSSXLZSA8Rv4+xsqsw==
X-Gm-Gg: AR+sD131eNH/majgTL1Mp/FhqLxg+fRlHUHhLL8aPZnWmJHtbKrRs6kQzkQRoMenUOv
 dEmnpZNDZCR8LpPEqxhh1wO0FPoHUVOhCNbXuG+DHJPPZcuKgfKmEHWCcf64oUSTOXnLjTdfyIG
 r3OxF6UYv0OBdr84deA9vYw3X9k5i8uO9xJO7qYI0dEqMeuD5UmIca0nAC2YdhSm8EmFnX9DUj3
 WqV2ydsaYasPGWVavkajdfk5NRG8T+g2avQ/aBeYvUqZHs/uizWvLbjlCt60hyGsmMGivkvNLW4
 klQC7fHxhS3KW3DMAP1uybHuCrGJ/Kb6Xd520FMZRP0Upnp66LS/NLTddw+hDXGRXEv6JMRdC3K
 oRt8k0hZZ5owx8Mvk7hUzdq9hTX+I6a7PnzmSAO8/kSHgT04gVn2hE2M6iJRwQeE=
X-Received: by 2002:a17:90b:2c8f:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-39580f119d1mr25876476a91.8.1787239953412; 
 Thu, 20 Aug 2026 08:32:33 -0700 (PDT)
X-Received: by 2002:a17:90b:2c8f:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-39580f119d1mr25876354a91.8.1787239952908; 
 Thu, 20 Aug 2026 08:32:32 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad699c9sm17825801c88.8.2026.08.20.08.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 08:32:32 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 2/3] target/hexagon: fix HVX scatter/gather region-length
 check
Date: Thu, 20 Aug 2026 08:32:30 -0700
Message-Id: <20260820153230.3136530-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260819230939.466856-3-brian.cain@oss.qualcomm.com>
References: <20260819230939.466856-3-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfX/QC/iNbzTCTc
 NwFPqIte8R84Oy0jg+k0a0/hn/rgynHyqZ5nA2eiW/SbhpJrff4RRzB4cAJC1EX6mjFFlHFbdNF
 yj4HCfR1suTRBKYF9hmJ4A3WcYpy6AtWeKyW9M+CK7jP9qe9rTeWpL/4DfSGbx1tRqm1WslhjDT
 DU5k0nXW+Ryf8WVNb3UYXTs+5DWZwXuD8SDeIwzvPbjRG+iiwhvkRkBBgEVg9N9ivgoLbzme0f+
 sz2HKtgQoj0gxLIbeGIxaa02FqYU6ts1I78sqDJ6UM+QwmWpbx96hPZ+88kGCLURyiqqAj3Ibql
 lAQRnAX8cIPd/S2G1Xyacfg2Cq05votdkH4GMiwUoL5ht2emghTnzfCBMd0eHL6lgtqq09EWR80
 EHGEHVBsKbLaCiJ0WyqVcHD9KTcSCyr++TgHM3dt5cf7GlJZU27vgvt/MY6Hsk0trOOihTX3Ab8
 CQHUkqBWKFW/76JGUcg==
X-Proofpoint-ORIG-GUID: ikfFyvJav8adu86KirSl5HDuxmYQ2Ybf
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a871e12 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3EDZ3dnHwpz6T12mq5gA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfX9umm1e62h2aJ
 9daPRlIxDdLTMd92NCakbBZw7zZ6YN6GPU+R4GRxUSGlVn6p2UfGFzgU2bkgnCvUqwAT1I2dfH2
 sFNZ82H753wgJpm5CU5kFChAQAZWlTY=
X-Proofpoint-GUID: ikfFyvJav8adu86KirSl5HDuxmYQ2Ybf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200117
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Wed, 19 Aug 2026 16:09:38 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The region-length bounds check compared (EA + i0) <= (EA + LEN),
> which reduces to i0 <= LEN and never actually depends on the region
> base. This let vgather/vscatter keep elements whose offset was
> beyond the declared region instead of dropping them. Compare the
> offset to the region length directly instead.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/macros.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index 0ed35720eea..7ee6f5e62fb 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -170,11 +170,11 @@
>      do { \
>          int i0; \
>          target_ulong va = EA; \
> -        target_ulong va_high = EA + LEN; \
>          uintptr_t ra = GETPC(); \
>          int log_byte = 0; \
> +        int in_region = (OFFSET) <= (LEN); \
>          for (i0 = 0; i0 < ELEMENT_SIZE; i0++) { \
> -            log_byte = ((va + i0) <= va_high) && QVAL; \
> +            log_byte = in_region && QVAL; \
>              uint8_t B; \
>              B = cpu_ldub_data_ra(env, EA + i0, ra); \
>              mmvec_set_byte(&env->tmp_VRegs[0], ELEMENT_SIZE * IDX + i0, B); \

Should we also protect the memory load on what could be an out-of-bounds
access?

            uint8_t B = 0; \
            if (log_byte) { \
                B = cpu_ldub_data_ra(env, va + i0, ra); \
                mmvec_set_byte(&env->tmp_VRegs[0], ELEMENT_SIZE * IDX + i0, B); \
            } \


