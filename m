Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4949BC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5xt-0003dy-Se; Thu, 20 Aug 2026 12:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx5xs-0003dq-Ja
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx5xr-00057z-1Z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KG6oGf3415066
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xsqAzgzZH0ugrMFOrY+bSwF44nujd5DjnpMm+4pKNI4=; b=ZdAY1og6aKppa6hX
 A4bp0DDKvcdUkpqs1Hx4u6sANhEFNYXCDDR5iKRda5Uv2UdE8niT/22XK/MGJldb
 JOK/KnpwK2my8ewsE8bYakPRm0D0SCkX0KBFHBNf5IHPt2lhGDF4oh0V//R7HKVE
 G6X23Ne+6o9SQ+zfXBH0fMRfhc1VnpoqksMkmErEdctYIiKOcBa9AIIXTxNw/OOL
 Mew1d8irYq1UI9PhroaIre3HTbQTAK39l+O7/j6Iz9zYrBQwACpGmjClkw/0n/nz
 xcg7114cwaqdTn84/wz6yZwDIr3PCGbIDLJ/3Pxy3WO+lsv8ZJBmlZ/aDtFKoSkR
 JXsHvg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7then-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:50:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so1230868a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787244600; x=1787849400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xsqAzgzZH0ugrMFOrY+bSwF44nujd5DjnpMm+4pKNI4=;
 b=PseT/m0UnYCN7Qd7xMI25UWRuwSziTekxD9HLQowP7gjlPU4/UAWgRd0ldWacIGont
 HgR0qjg9vVOC8Aeeppn3aUnuFWGsEey/YWu4cvZfBvoup0KBp/aKYSSVizJyeI03ZLci
 5QjfzZIjjpKH7Z9LlDuGYSOV+54BE407Tf4hKvUtsSMmxm8wGwy9xekQ/cuTHtCxtYYi
 ZMy1Qvyz58ElO0aBfjAudqJXlP4edkky2S+Emyxc3mPSV9Jpo+zYpR9gLvlj7Qe5698Y
 sSZHJI0p4DmPWTpz+URXyLN/l4rzT/oq29HaAVqQ7Ed6f9u17FgHQ5LampaVZVtQNRt+
 OmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244600; x=1787849400;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xsqAzgzZH0ugrMFOrY+bSwF44nujd5DjnpMm+4pKNI4=;
 b=kEEDSi3NWTERk9RGVMU41y9sQE+mRh/DF6JZ4gwR64YjPwOwwyLADGx1o3k6Fsk0B5
 hlXe8PNbKWi2W1LSFBRPD5Ra+cbbSZJoUyg9NhhHSLWs5UilzHQ5SatvWii0aZXo+i34
 8yEK/xQsXMYqUFGDW0VAfYNCdFIjpmR8oj0nNDr2gkL2A2eaNLEvozxRO5wFBSH+FbVw
 t1k+kpaWe/thw1lGJoWKijPPNUQX3rllOJxrYoDWKq3KeE/1YdcKOysX1WELKlDm1+jJ
 JvwT38HzPJsjqW24IeN9X1hFrPEuwa5hwX4sUOEec9YlZJSlAReCxedgVKYLZDkaavi/
 JsqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHEH83Eo8eW88Klx4KWknuXBxz6Etskm/0WJj6f8SFMAqaorUbxxdWjmsEXUITLT+G4QaKBEzRgPzZ@nongnu.org
X-Gm-Message-State: AFuF++m2nuHwo359ZG7/fjChrZASTfAALUDFFXuwNFi70A2h85TS28Sy
 lXCWoYYab3LeaW7hRqpSXxEQANLibf+mFLiC1kJBnlV+gBNCkscdmE9GWIcXUS38Zq5jyyHL054
 ZIV4dar6p9C2031oLBbszTNy/uYzySPJ9GBQ3K2xMeWMSILF7JXfqhWEoNQ==
X-Gm-Gg: AR+sD10Uw/9zYx0PSgGOmH0H5iMLc3sPEn3xyUZKVxSWbuBEGpSC2Ti+pcRtA3/VB6A
 pLVGDhPNh0dJsxoqWc3IBFplU5ZpWk8Ni/cYHBGpr6daT2TLBait/ZCCHWxJgheR+hFN36LJTFt
 r0JTvEXWexpFJPaAXkT9+4FPmtkQ/oaFPUHgETyUeqikWQE4tFct2iHy/MXq6gjWRelBrgEAfvF
 XS5Jb4f9U33Qu3iQC1fjRxIAl9s2MTZKq2y7+vowV0ri5ypdYL9XEv+k1s1BI5vsGX6hBs8yJcL
 LJAbkKmggfrLYuhrYaM96jVbow9IChXCWZY6pdwb9o3/6SbZAgfWhlbkEuO4B+xi5E5v5NiiMU0
 osZH5ioKFPsfDZqkb6ZT6zVI3yrTPl5/mz0tW3SfcxdnS00kpTonQv0fFsGEu+RWUFG2D
X-Received: by 2002:a17:90b:3851:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-395a06ac272mr9713286a91.14.1787244599931; 
 Thu, 20 Aug 2026 09:49:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3851:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-395a06ac272mr9713220a91.14.1787244599360; 
 Thu, 20 Aug 2026 09:49:59 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad3dd15sm16275509c88.2.2026.08.20.09.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:49:58 -0700 (PDT)
Message-ID: <0b712649-6576-441d-8d04-c17f5562baa8@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:49:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hexagon: assign a distinct htid to each DSP machine CPU
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260819130341.4076146-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819130341.4076146-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX4Vsoy6Ii2JTd
 WFqHrXn+qg5e2gGoYHuHmiugX94iVXDMFaWfXUVNKxCPsGf36roKBetqexTVu0rhADHztcRuXzQ
 Slx+wZiwQr1BbP7KzKcb0uEMUb/V8lLG+4N+eKOEQesNd7zk6frh607s2KXm3fzS/n0B1grCfUj
 BAvuKmswl0p3qXp6EZljgN1sTlWdFcf8e7VHdSvdnSkCb5Z6HvfvlArEbCoc51to/b+21vEedCY
 K0Go4D0ybm6tLDcG4SwYsjHJ+KU0F8431HkQCzvRm/OGmgbWC5Y2brjzOWChBVNmLxtN2xACLaS
 zcSvozSL+64CwHGUy5ELTk1umTUwwJbHBUzTs1F8gA6F9AsxhHF9nKOjM4BDXIUQH0FtnUN/k//
 m4vb32SfEKVtZ+p3+ukIHCH3+PFcATXScasv44NK6EeQndk7a60FHJqR672i8rd5Z+0t5hIZJ7l
 MR0N7UysOoH3bt+vi2Q==
X-Proofpoint-ORIG-GUID: kCftT7XwOaFFi6qzf7HW6gTLW9_EF-8e
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a873038 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nUo7HOeH8d7B_2DLwsQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX82brAO5U3mJ+
 +7R8PbJH7B6Qj+x6I073bdVrOa+2ktVcIkYkOvB9dMAuP7Fy2WHctEWsfGQ9m1l5cVtP1tJurWC
 DeOduMcwfJi0IC6SMLpfkpusm1kXJeU=
X-Proofpoint-GUID: kCftT7XwOaFFi6qzf7HW6gTLW9_EF-8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200127
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

On 8/19/2026 6:03 AM, Brian Cain wrote:
> The htid property defaults to 0 and hexagon_dsp.c never set it, so every
> CPU on the DSP machines came up as hardware thread 0.
> 
> This bug was causing h2 test failures.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hexagon_dsp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

