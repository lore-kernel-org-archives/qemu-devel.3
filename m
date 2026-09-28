Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C101BCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB80Y-00059a-ID; Mon, 28 Sep 2026 05:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB809-00056U-5y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:50:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB805-00080c-7J
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:50:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MRQ4547174
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hlsrEpErqcLKcWvy2cpLgGv/VsN/eh0F4MZ4m1aBlrg=; b=Df89LYrd8LQuxNP2
 QyiigYutrTSgdvy/17HU/iGj1/AFC8hk6Hm1EbnAtlX2VvJpercBSbNgz2fwmnsk
 2eLUdbiqCK71k1fSq6C9bflbampF1z8dRBDTcFMIAgA0MX34U54ZNJS9C2DxlHOi
 ch/HL+we1x6zYf3OR8LRsfH2LEpkbALY1Sv2KwWV0W3Kol4NhSU36J5mKbB7lTBH
 suq/TVGkUYABAnJeidm4BGj+19//1fq9NQAfzwuL/tAdkd+keGl6vH2gaUic+tOu
 p0U+Tu6MLytOaPAiDp0WTH9FVnKu1SZ8qGuD/NRYswKWGWK5zeaEj1xK3ZktSyy8
 /6S2og==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav49vye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:50:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c57e0436aso188654685a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589018; x=1791193818; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hlsrEpErqcLKcWvy2cpLgGv/VsN/eh0F4MZ4m1aBlrg=;
 b=SBu0hcDZRELXZZFavwVIKVttjFy0nUC1kO0QBw6rbl/y5tiQiyefOR51JevlOyw7X0
 l6V5nrJsNZv5q6X36IjDmI7c/ZsTVNEfl/hsFiqfAvW9EGNdKPOvJyemV3hdwEJuy0P7
 SqWiS7GXSKNjjriV60NmtSMPHeWktvpFl7BvNt/haTheHYq1YX1kR4CbNUCHXJXv4xVY
 jaPvpGN2o0278R0HfGjYtpk0ERqeYXbSNAg07vQMU4gnowuKfrKxMQLBiTkJwYYI3GRI
 AakWQfztBF58Wj6IITVroL6dF6/TdFHLp3KNQnV4J8/Wtc2W/HUit2So4ShBId39u6PG
 JMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589018; x=1791193818;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hlsrEpErqcLKcWvy2cpLgGv/VsN/eh0F4MZ4m1aBlrg=;
 b=1jqHBU9A8qxv6xanVSek7AXiwurQkTeJ9MHonwWSY9CCtFaEuHrrpcVTDQkLzWfqeA
 pl++cPAA0sMOj+BAzkSmVWvsxg0aEZj5yUuHtrzEauNAVB1GQhMbePG5NEtHDj8GcuJ9
 9pVMxxnDUpoxmNGwC68i0bBid25mp3Qr7buaT0sC9N8XBcap+FNMeu6h/1MgKJj4fZ4q
 X0GqaBSIDHBhenyKkYV6ltiPvc1JF88FV1Cx2Pujr37myCgwqoS2LhfzLf7IrLp5uFSX
 a9X31T7xzh7i5aM+P1G35RHVj8uk85+k6Lukw26SzWer9jp2kncpJb25EVeZm/datbaK
 rBPA==
X-Forwarded-Encrypted: i=1;
 AKwUvByc/3tKUTw1/F/k9EHzqL9eRAEn7XC8L9FEW8GpKD5BM+NsZHRCT7mH7/7CRTBVfxDSc+ohxLTAOlXd@nongnu.org
X-Gm-Message-State: AFuF++kVTvZab7uFyIWVC4pjKJCbfe4WtAOqQY97waT1u3DhcmQK+RuH
 WJsdfM8un0CgHF78JvCQGtqR7Pgn+K4RFdoVXiyLc/BdlOe5eAKcna4XM9IagBT+7rNMCClXrml
 aZ/L6aPk8eb7CbJzURWhoL4gu2fdSOk44kqNrn7MuGuKuOpTaMcecbl7o8PEHZRjJOQ==
X-Gm-Gg: AYBFou3xsWrBrcNRM7M5C+8PTm/8ivnIXPRl88RJ6WTARIGgozx1UCegcJFNuEy3ZUd
 BVX7fb9UWUh/nigMvXhmL6dNuIy+boEuSoTWvtFRSt8zLfIfaDyUJsfi0lq93UayeHHQMmBkdoI
 0LRD77WJkRFEHd426l3GtWzB//Zo5OmKS9PaeIx57W/d4wqSkRsESfRNVi3XPIqIfiE9MlkRCT7
 xrIrD6vAEDi6hHXnK8CuWl6LWN/FAVkfYxAdbEJuasQlw4EzOzqCA/CpHUK6ys5a0EV3eIhFN3X
 /Av7kBeNpcaokMDPKSAV5Gd57qlZrvbCs7Ai1X6JEBI9DmFkgIdllfwTUTJgIUqNAQYyCCi/jA6
 caEAxMhNDI0bC2KwYmDc3DvgqGPFxmKHRLg==
X-Received: by 2002:a05:620a:1a15:b0:93b:d7a2:dd25 with SMTP id
 af79cd13be357-93c43cfd94cmr1893636785a.53.1790589018365; 
 Mon, 28 Sep 2026 02:50:18 -0700 (PDT)
X-Received: by 2002:a05:620a:1a15:b0:93b:d7a2:dd25 with SMTP id
 af79cd13be357-93c43cfd94cmr1893634285a.53.1790589017875; 
 Mon, 28 Sep 2026 02:50:17 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a36189bsm25457517f8f.21.2026.09.28.02.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:50:17 -0700 (PDT)
Message-ID: <b6cca9bd-bf45-4cae-853c-804dc90d2146@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 036/101] tcg: Generic expansion of tcg_gen_divu_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-37-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mzbWJOH-ADQa9OGH4G7lRIa6F7kLt6s1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX8Bx3Z3TI/CJH
 kG038/V2+aQgvUMniTR/FO9+Dh7Dk+c9S0smYeOhORBrngEwbxeT/XR4q0h7FmHE8QRQqRPK0Jd
 cbmskiNTB9SBdTV37hBGvLdJUhh8UJJBB6YIkqQCi8RxxeC+JFNGlJoVRxeHWElE2RBO12IqlYB
 slpMOJTV5+7WbQP9Mb09JvDm0sn4cL+Z5VwbweIvYqQWl1yF0scYX/+1YF3HkU1t91X42d3TK2W
 CJYzQmtZyojTrMd0gDwvaknkyO8eSqGoqF2YbmKuh3umwC7sn3wAXfwnBwcgqTOlpg2VVK4wX26
 UikL4Aoh+Q6M7gUSwhZqEytJ89wjuJkTpIl1lLXoNQb22xseylkpYNrq5fzsJsItYeIBCoPlfY5
 2MT9wHFqdrBAX4xFyc9WApVQOfmvDYJMgkBFb2caNbPx0dkT4mD0ermfhAEgCerlKdsrxke+Z2i
 rEWOlWueGWFFcV+SwzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX0ZOWrKdDvl1C
 pu1x3l7Ke6WauaLtkWyU3gnn6b7oNbhjmWrJL2DKUVMgOMtT/KKXWJNH6wWBS4WcFAeuNV05mU7
 +3QUFMl5n2J8Bltk4pLBCJ9UJysf2L4=
X-Proofpoint-ORIG-GUID: mzbWJOH-ADQa9OGH4G7lRIa6F7kLt6s1
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba385b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 42 ++++++++++++------------------------
>   3 files changed, 15 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

