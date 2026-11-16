Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207F606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QV4I/fq1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R/FsqcWQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4CL-0001My-6D; Mon, 16 Nov 2026 16:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4CJ-0001J3-DY
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:25:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4CH-0000XY-RH
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:25:07 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJesrF2727738
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yMqdOICA+OpAY/ATGXwEKSukeoHZA4NXxgP8ONGyHgE=; b=QV4I/fq1kzKnlgh5
 7XSJFj/f+aN+ji7421o0hsg/kFciP1JysnbnO677F7CfmclRcY2ZylSYtt0kpvIx
 Yw0UKNJSGiGMtTlwAmGhzM+YdgQcxWy2elvPb40ePrdN3bXUoOqDf3lkqAElRYgU
 t+l5M9PJZgkb1cErkao/FpFCfGQXRlrmB6PodwuTWJPj3+qH7uG0qkaGbSE9mPlf
 vctvg/Ycg7m3y3ikZ/zDDos3+EIMYR61CbnF19+1ptncivqNJVYcne1qxZehyQ9w
 kYp89QaYtesIdzKZt3bY80wy2xEPUxWOwGp+KPrDQaSqmvkKEIyDmpANoHAWiZ43
 wGY3Ig==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07reggbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:25:04 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so5922769c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864304; x=1795469104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yMqdOICA+OpAY/ATGXwEKSukeoHZA4NXxgP8ONGyHgE=;
 b=R/FsqcWQOzRdxvdwqONZ3WX7bG3LVHTvR/+2gAIwE61EXMZtCKkPS2ST6PSY8UW3t9
 VzFYrfbwEE5qRDDtIbHT8GBXyK3p4oa3PCBN/kjAFURjElABl1gd0E6Tfc+UFTukHV57
 8cmRG/JN5QyUEUVbbWxfym83bDKF21f3cph5tm8RFoeeVPIGoe9yN6U94xgJo+uDwCGm
 6Yr86cUhqDdwkuFMjLHboDgfILzkSaGthAEn9hAEq5UX7h46tncbE2leRojqHrPQZaHD
 4vkpaw7BaKRQAb7iDAU63qpmBDYI8EArV3RDYG3qIAcH/7rKFIB8rnCrLEKTVmdtQrkJ
 wjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864304; x=1795469104;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yMqdOICA+OpAY/ATGXwEKSukeoHZA4NXxgP8ONGyHgE=;
 b=OsreDnYQlpyGEKvkIqesw679uyIHdPwF4dXRN6m/FUCz+z1g+VG9AUHdHH1TriO4RO
 l5CoXglXCxi/6+KuQZ/4E/4BIvSH/p79OzrrXvM6LbSDN9F3Qqqw9hx0b4lnGyjPeQfI
 zLhXKYVJIBAmAsw6lNh0aX3Cxa20mWHv7LwnwrZS8QfRZ32+eFNepj7z2O6Pw59gsuiy
 gNUZXjeUr/tRxYTJqVNwkW7TvmXn12Bu0PTOqDOqYk8iGSv8Fzr1z63wLF1Axhj9zMak
 1RA1ver3LMdgiQqpIprGTEI6P2Oc6R0mEjQaPb4y54HWUJe7dcgaz6VuLwoovwCuX/9K
 5IbQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG9NGucHP0pZAqVQdOq6qsCEG+/oqo3wvC4qb3NXx5hr1htF0TOXzYkKl+EXRyen6TpeSuKn8GB9ZGq@nongnu.org
X-Gm-Message-State: APuU4Z/M+BsFPCIaQzK292z9NcGA/wW+rUAuoD9plrrapHEzL4VwVbCd
 h8+o6maxEXl5q8TcCr5plJbLU4aBupp3C8+XNTO9EjzjIwn86qzsxjQPRh2T//Bme+uIVQP+YLZ
 /1PbMF2+yqjNjbjaUBUVV0QiY3HRJBe7qjhRrc66uyJy6m5f1kVdVxR3wYQ==
X-Gm-Gg: AYBFou2R1aERYDkaoHAWt9f3qsOXPRSIMYglE387XU+xCstjIVxzmZl40zDQZ0fjMSd
 pCrVfXh+KtimghJXmXdsc1jw/cWTF/rCMk6t2Y01iWin8ip1dHa1aHtI/Lyq4TfQGNp6qeMtaQT
 f7p95m86pLJoPTTlLOPUfVxwKgOmdUrQFXAv3BFse7ZiouOvMDLHJ8PWkyfLSsstAjNCGJ8VH4w
 wDbgqrpG8OKvNNjkhFEmojuQGC+NsLgOefSmU44QzYQtEZJh8weQODwz4yH3dPtcnUTT3Am7MVD
 Qz+JZWpMSR9fi3dkapp70lVVzZ31JhaVFN4C8TQMKbsABVKqdEEdK0nWdf3EWU2lI3Q9H0zuzZ6
 hJTI1F6l26VXNCjVQ8GcwLeyUsia8W0KtSdkYCNEDm0eOlZ3nzhgTU4uyiHaF+XVDY4qzPHD+1Q
 +gmNvhx8hBgmUCwPX3RrvUuKWYi5xPWcJgbAThq4rLD0k=
X-Received: by 2002:a05:701b:42c6:10b0:1b3:ba92:145a with SMTP id
 a92af1059eb24-1b503171008mr12621400c88.19.1794864303695; 
 Mon, 16 Nov 2026 13:25:03 -0800 (PST)
X-Received: by 2002:a05:701b:42c6:10b0:1b3:ba92:145a with SMTP id
 a92af1059eb24-1b503171008mr12621369c88.19.1794864303137; 
 Mon, 16 Nov 2026 13:25:03 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50316e195sm39587025c88.8.2026.11.16.13.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:25:02 -0800 (PST)
Message-ID: <4e102163-d2f9-4533-8aa0-10d75fd7c4a0@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:25:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/48] hw/core: implement TYPE_TARGET_SPECIFIC for machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-35-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-35-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX7UxHWRp2vw3F
 hP0Oxl5nkzD6FvP9ME/gyjndpXls6rxJc1LPLnHObbTkxwOPRw+qorwp6fs35zOLCQ0rmayn3Pp
 4kTHuy463TelDVHKtT8t59SlQyGcFs4=
X-Proofpoint-ORIG-GUID: -wDwggnS_1kYGNhKdVJCtG8Lqeaj5niu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX3BImynAKEZX7
 GDaBFnGK3U3u7ZvJ6WV7MQaTgtfb+k+NbE0k4JCj0Vwu7m6FRqK9zNSH9caIj2I7xiB5g4OJHmy
 QQdy2/NPZNmdq7hUr+A+iLrKU9AYyz2BAfaS2pz59FT/Do0jz93U9vEDQXjW1EyAIyKrWJyI+Bj
 SVqgiAR4ND0e0ZcgYJQPtdgxysb3Q1ObfsN5SpfTHUijarQ+S4nJBYl9iqV+IAx+FNJm6k9wXja
 bYDKZ1iguDFNWLV7XVKbc4HmjpPBRUggm7TPzOjfD4vpKbTlWtkePa9RhTK7qvyu0OarEwZmI8w
 Zj3oD1uqqsuYxtG3TbMnrHMZZT/k607zQ4qePIZHHCpibFWitkSd5W4CNiXpWFj3hCmAp1n81nn
 sy9oGH+oz661QJYD6jP/acPr1O9+OaBZj44dUYWU948q1RRaBxkktA+jH4gsTs69Dg01+EZjfBb
 Hbj3r+ywX20bUe1rRRw==
X-Proofpoint-GUID: -wDwggnS_1kYGNhKdVJCtG8Lqeaj5niu
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb74b0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=qwkxIZFZQYzmEp0n1YwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> The Machine base class implements TYPE_TARGET_SPECIFIC since
> its children will almost all be target specific.
> 
> When the 'targets' field is set to a non-zero value on a
> machine type, it will block creation of an instance of the
> machine unless the current selected target matches. This
> allows the current 'is_available' callback to be removed.
> 
> Eventually only the 'none' machine is likely to leave the
> 'targets' field set to 0, since it is universally creatable.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/core/machine.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

