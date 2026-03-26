Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07FC10AB82A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 22:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5tdn-0001ki-M0; Thu, 26 Mar 2026 18:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1w5tdm-0001kK-DL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:57:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1w5tdk-0001He-3F
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:57:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9f7E3898185
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 22:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ny/HhoUNm/tnHHrTn0jtbaIZMUa51jEYM0HTK49ptHs=; b=lGa6JG1PpDMNpPYx
 5ijEg4vMqve50vttUbNL2i03Cg9EAq0TjzN7xi9sNlxs3UcEjECVgMXqCaBZJEOa
 UH6JNdsmlIAuDwDoVmoF/EgcZ0RtPmKsw+miE5JUuu3Wb+IYrgdk8dT0ht9/TjxH
 CRQHOKOQI2T7V3Yyfel9GhiS36o/B2/qU5K+J1mVqsDBGAynvDBCH4SIt/L/rtps
 IW24FY+eTv4z41okwvjo71DsHo0JQ9iFrhCQ3gDjwFrbqViKcnXMx2tmwIUWbBvH
 zFZykxPhCacGzowfY06MQaRsvdbHmAfYvSveiCKJ8RwoZloHe/CMJQ9Bp295/z3K
 dgkmXA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d50kgb279-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 22:57:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c1030ca85eso1048841eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774565842; x=1775170642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ny/HhoUNm/tnHHrTn0jtbaIZMUa51jEYM0HTK49ptHs=;
 b=PYWWn92sWZ7l+b/MCjNJ+N09VNZ81RsXWFb65Jx4lE2Bv2LKdRCRUNE3t95IrurlDy
 mm5KSZ++GUuWxda4jXakPEMjGTVJThqXXHScvGZDdLJeezqHlCtKWizdh+VakL4+7brh
 LqGaqN3+hcY6WY+0/RwrBDxcCvG0Y+iGlGOA7iiWnefhR7/gvqyxzc2jRMx5kJweEe/a
 obFefZ4fhbw11WpoL5gylRI/Q0yEBnemBcugUJZEH3OpqBI2IbZB/cyok4fqMNsIOG7K
 BD+c2/C5ZE8QlUCyPT+0ohNnYTCYsISMZOKoQia9jmdx/fAUoTejtQ1p8b8myjORibby
 HumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774565842; x=1775170642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ny/HhoUNm/tnHHrTn0jtbaIZMUa51jEYM0HTK49ptHs=;
 b=G/30ylHzZhX9IOe4shNlUw/vqu62xlUh0hGRI7ugxeOTk8yJ60S9Q2CbZqS7rpEgxM
 jjzMimi0yNd7EcfonrRUXf9CTYYSkdm/T+Mga/1PvIRvLoTyZxkoe/+TCRBGjrzAgv/t
 Av1Fb4FDx9hi4IV0GgQQInvxkZtjTgn27JyVTeqI1PCRpO8zrH7BBREcnENsinI6MiYa
 bRfmNejDjS8i8D7E6KjUn7MRFdGZL6AUH4dWMFNNLZZLW0cXxlv+G2U9qZ9laLznmO9f
 rrJ2ucuRHEzHDEWF2009nTLKOHUVZr8dm1apxRzUKBkprtQOrZHqeoqx8BwBCsfMh0W2
 RPmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkGTc8101vd2SDyfwZMLD4iVv18b1GIW9D8IlDOsMlXg98DC6+HzZqc3ueWSxJ2Sn4rzQu/5OyEUEg@nongnu.org
X-Gm-Message-State: AOJu0Yw2UvU/0PiZM1XbJpGRMY0SJHxAabIf7aw/XupoY65OY9opPiSV
 NUkzoOL43Tp7F09xbGM/kVcWk5+c8MYnTZH+AnVnVW0mlzfOFtyqrmZNWDQTWi0Uo1qHn1tr+IU
 Vwx5rzX7bJGXcDj9NlJIr/oYpzFBg7zYhCA9H+qGvk3f3bNXHCLZ0onaaOA==
X-Gm-Gg: ATEYQzywUMGXrgJPHBiP3UzK6OW0SvQWgRquRN+DePkAzDUI3AC1KY0KcYAt+wwmz1g
 rMXjtC2dx2CR+AgTRtCkhqCzM0HQpJ05kkwZoIJkWkw9QlnEqegrdQFydjX+OG3qoPs/16pmFDW
 fl3az2AhehnLeCPuxp+/zOb4udCl9WkbbRkbth8JzIBzMB0BzBpAoBmV6xisNJGcJkcuKlOX+fO
 edOvcGe3I2irZ7NPfH4swVrLAxFNtMHD7WzDlv+J300KR6Aspo5u7rkMJ5yYwvdLsNL24j+ZsW4
 gMxxhnH0RbZokEqTTKbdwL5FtJP59jFntbH88+WDw3D3iIgMDLv7RVswIURvWgjmymZG9b6gLEY
 4MQcxI6lLBhjkphSKkp9eDqPWvHp1eRp2pyXU7+HA0jhVU7nap8JbAdwnrgd/NvR+ccuq96h+IG
 2NATg=
X-Received: by 2002:a05:7301:d0b:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2c185ca3a98mr256475eec.5.1774565841929; 
 Thu, 26 Mar 2026 15:57:21 -0700 (PDT)
X-Received: by 2002:a05:7301:d0b:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2c185ca3a98mr256467eec.5.1774565841343; 
 Thu, 26 Mar 2026 15:57:21 -0700 (PDT)
Received: from [10.110.108.41] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ee2a41fsm3584018eec.28.2026.03.26.15.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 15:57:20 -0700 (PDT)
Message-ID: <fd4b0bdd-fb93-48c6-b0f4-228a7abfc8da@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 15:57:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/aspeed_i2c: reset and migrate pending_intr_sts
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260325085450.126595-1-zhaoguohan@kylinos.cn>
 <cbc2f8e2-82d6-426e-b269-4921fa95b219@kaod.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <cbc2f8e2-82d6-426e-b269-4921fa95b219@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMZPlevH c=1 sm=1 tr=0 ts=69c5b9d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=mNGNAPgbdfsAtg9pDooA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NCBTYWx0ZWRfX0Vrc0lxroIAv
 +797jYJY5I16BDSAEbm9x/LLq6gSHaizeOdhFxiTV6q5ANRDvu0xiYEabCgFs88RuwPpzDpERVf
 DY3bTrm846aBbkAKbkxZj+XyOcm5C2XrjojJxi3JtakbeGei/a2zzap9qarrd1Q1vAOwUhXlInC
 LF7E1LIlplRwAtoL0lM69RZGZ4sEHMgdpVSurY1JcK6lWezCmQIXa2N3EFcoQ/B5kkk5agRKH2v
 6NcdyrmYQQiUQmRUc7iopNHouYQ/p/0DApLZuAryi2SvLGV8jmMEZogcx7NwCHx2DX/FZUOwlTv
 qsJud6Dx5pdXW3ExBVL0yc18bkVafHc56VVQ6g2AbZ3VpZHHGIamd0dKM3d4UlmTu5HTH3Rj8Rv
 XF9LULyTJd5/Mx+ENwSL46AZ3/Jki3m6ZhEXFnhqgRWBaXkTwgFqsAk4Q6wkRuLY5zYeqCtgkuS
 so89kMBn6sUUwl1e9JA==
X-Proofpoint-GUID: mZCvZCkZwL83uIJV4m2ulwgK3P-_qNAp
X-Proofpoint-ORIG-GUID: mZCvZCkZwL83uIJV4m2ulwgK3P-_qNAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/25/2026 3:54 AM, Cédric Le Goater wrote:
> +Jithu
> 

Thanks for looping me in Cédric. Will be mindful of these next-time


Thanks
Jithu

