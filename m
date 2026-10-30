Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bWBRJyeR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BPmuKrSI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqn8-00058O-SP; Fri, 30 Oct 2026 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqn6-00057e-3v
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:53:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqn4-0007lg-Ea
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:53:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERhtm3207514
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0fG+7UCr+Bks6+qAZ8ROGZtLgDA8by8E0dD1+1hB5GM=; b=bWBRJyeRiXL9MXNW
 uwXWzRsFHFi6mBJUihd+ShdvqocX7hflykcUDx/DOVp/VWKflYQwYSc39BrbzduI
 SsgbNPqFGi8u1alrcRBqcKkYCgBA6ZQfZ4E8blo27PwLhiNRXh/qshU0td2sDFsI
 1l4UBMyQidQGT1LaROFWhwACFKjUeQ53VhftFOeE0ncQm/W9S/toFsYkOYFYspuw
 12p11FXTu2TuJiD8hqKIj8NGfmqUoTocgBDZitYFBPGJD4iEiG+KTyW1mhXGsEc6
 Nf/9hlMRZVAR9RHn8vxf8S4S1HQ7/bZtO/x+xOSZc1XEhh+IKym3NJaZZghl2nnu
 MF8LfQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qma6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:53:21 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so1510703c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382800; x=1793987600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0fG+7UCr+Bks6+qAZ8ROGZtLgDA8by8E0dD1+1hB5GM=;
 b=BPmuKrSIerpQZDHOzs1pwgbgb8l3uHIP+qIHfiR5uxT1KzUw/TR2RlVYgmX1hJc74w
 EDPvysSiVf7KbXJpBjrUxPS/eLVd67AEDH4TdBG7FUaL9LCw/yrteFRi3usice4K61ec
 15XtDGzhG+28TUJrukW/HSN+Rye0dGUFbe9A5qcYBv7HsnfrCAndNDkeOM8LqlhfLwQJ
 NrDnWUiI1p4lzV5L6T9qBWMTNYW0nrvO2ruC6KT7gR2i7FRUQGMJIEh8oKlFKkk7GGrF
 afbmfJ9/aFrOJ9KXv+a6MtHjG+Mh95zKZP4JKpVzo28tIyVxYUWMfwoJqiANwf+bHmeG
 GkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382800; x=1793987600;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0fG+7UCr+Bks6+qAZ8ROGZtLgDA8by8E0dD1+1hB5GM=;
 b=CmUAaqIPlsx4DvegePhxwnvqrmAA5U81o35A+gWEhupUAxlzYXg2ahPBHBEjXQo8vc
 YZDCwosvTukWzCRlV3zg5aAwD1+Zv8D6WomPU475oz0/HbVQlUGlKt0y3sMLTpZudUIt
 VCCuWf6XiJIN+2d819JxLHe7/kBsLSug16alYmM2bj/8a8ZglEozrohwv6lezwRRyU4Y
 cnDrL/rfx1PnuWmmk/Sti8I9u/mSH+WqGU6MnOx3SakUj3hG1XGXMV35hLy+Gz6JyRMM
 /Oagtct64dIjF3TVykkYeIdxcs8cLWZ9taYVw5U2dXZXHBt36Yq4lFir6tzo2KEb/+pV
 aMpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGqwoUYuXq0MW9IyhL1gN7vzGYHPYhFjOw0S0mvxY5gdnkBJ0tGc4sx8efXp8NaNrcK50lFmctIhBW@nongnu.org
X-Gm-Message-State: AFq9FYIWq3O3wGL2eMHGhCPFpy2CIRAMRfA43xypf6uM654AXS0B0dPT
 LN5bKhX9s0NBssj7lZksnoyW6tmmQEND6IAdBPM9ahT0yl3U6aF9XYybep3ZTodTCP7bpLTonvr
 33Kdcl5VbZmsBd4uAU4W5AyXQZGv0DsP2lqMHc9BspArnE8lbCqUYxMvGeg==
X-Gm-Gg: AYBFou3eUYH6qII86ggQEYlHO3pSEfL5qeaTygVb/rldPaAq3ZmLdKi9coM7QaD4A1k
 fywPYI7NJBjTk+Wv68j//zk9am/Y4ExlvUY+XLSFl7Oy4yjiR8N/LwRB+nL5UDVsPgLEFG+5Trr
 RpMjgD/B3FlwamTAhy7xWGcHcRTUpMZfGiIYkFbO5vbU0upDsJeGJ0w3mxKkgzDEGds1dp7fox3
 lQDnSXfJCS69yVKJVW9lJ2MZULVq0kdShkWlmEf3d5UhUWlU8abgzT0HiqTuvwr7TMtMlI0hnIZ
 3cWKFbhC0L97NCGf86cfF9YxOF6bhxIp7yl5pUn7ETc9T4lv1b/Y34cfOTCa+XTw94kMbOO7dqy
 q9cubvQjVIPFcs4wO15jM1y9VI9/cmo9/MgOJfVr+LbVo4P4s2TQBqJVybaIdS7aQRRZLvxrQV2
 appoqqJS2NfGh85ni0TAq8P6fLMAJ6Kdved4eohWo/bUI=
X-Received: by 2002:a05:7022:2203:b0:18d:c38c:bcc9 with SMTP id
 a92af1059eb24-1ac56e8a821mr6017814c88.3.1793382800257; 
 Fri, 30 Oct 2026 10:53:20 -0700 (PDT)
X-Received: by 2002:a05:7022:2203:b0:18d:c38c:bcc9 with SMTP id
 a92af1059eb24-1ac56e8a821mr6017758c88.3.1793382799677; 
 Fri, 30 Oct 2026 10:53:19 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1abcf67csm8597950c88.21.2026.10.30.10.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:53:19 -0700 (PDT)
Message-ID: <3058e2c4-383a-4726-94d4-7ae01afe19c2@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:53:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] target/hexagon: import HMX instruction definitions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
 <20261030024110.1986536-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030024110.1986536-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4d991 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rvspqOBGsXsvznWzdtoA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: uKnrxCHExh1KASGNM1IV4dhNyhfuN4L4
X-Proofpoint-GUID: uKnrxCHExh1KASGNM1IV4dhNyhfuN4L4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX5lA9/fevSWuv
 1QR7wIh5pDtttT2In2iyD1EaHJC+/BhuctnVCFS50iuAIj7suPzb8uosH9M21hRAdX6wcAxI6dr
 ITtdAk9KWFNi9aXKWiklKCy1Fhw7fyBeYnjcLwRaiqM4o4vy7giQMhQYUlxr8WaQZf9BAxmIs6j
 2NPdoveNvskZcrAveHAeRt3KYoNzBK8qxn0hVJcO1IZjejpBcyjDX7ZVhMVgWA1TeatdM+B6GjO
 8f2w+QLvlKnsfafzb/OFzD8CBEu9KroGSibXqK2ixF3RGhGu17pLmec+CzSRBo3TuXHTEIqovSx
 kgyKJgTSS++OtVCcEl3HZWJJ82CFYKOfsfiHl9nNPRIyaqUnhejVa5Ev53yFoCOb+OKDLWzK1zd
 2HbcJaKr1rAY1jDzSRd7MKmz06dhXQ0IwVTfmhM0Ig8seC3hb6hYdyddOD6Rkv5ibBeI+GOc9Zx
 BZTONVbs7UwCqXcxNDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX3ppnc3n3cIrd
 OXdjRdcuV/HlLkuO2m1VralvRX2D1Hda89FwRWuZ0nhyxOHR9WeCdee6ZN4/AZBRx9a0gITbKBG
 dCDVBHcidSkgQJxM7BFYWf6BEIESDXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 6:41 PM, Brian Cain wrote:
> Import the HMX instruction encodings and definitions.  The semantics are
> no-ops for now.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/tag_rev_info.c.inc          | 349 +++++++++++++++++++++
>  target/hexagon/imported/allext.idef        |   6 +
>  target/hexagon/imported/allextenc.def      |   4 +
>  target/hexagon/imported/hmx/encode_ext.def | 149 +++++++++
>  target/hexagon/imported/hmx/ext.idef       | 175 +++++++++++
>  5 files changed, 683 insertions(+)
>  create mode 100644 target/hexagon/imported/hmx/encode_ext.def
>  create mode 100644 target/hexagon/imported/hmx/ext.idef
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

