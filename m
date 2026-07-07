Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8711FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8KL-0005eE-Hf; Tue, 07 Jul 2026 12:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8K8-0005cx-7R
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:07:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8K6-00063e-JT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:07:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTDvU018048
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 16:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 msRIME6nGWnCo7DOyR438y2zmJoRfrOYe4zV2WW/KhY=; b=L5uKEKnUxKKtlase
 ILS2PUAqbmApup30E2wEpXfrTBoRPq6LgLSu2dcaYFa5WmNtSogFggYflvR8oYWq
 YUMfggZBhw/sYes8FNdqR70yFCoCu9J3pY8v7y86iTL2TdfE1sAnVw+sMJhO8Jjy
 GGYBern1Nkh+4l8isilnxuQ9BIRgmmel5D0SW5YfXFMoCQpefwW1UV4bb3JicrYj
 w6nB+VtmncryZp/x7KRKfLBVvm22iiAXyIlecaDJw43Is/Jw7Gf1aV+R52JM0cs1
 5ArCASwN+b148r3YscATJC8d4YEs2PZjqWtPw/d2Xk7X5NoyA5wSBzjfIH+6dRM3
 oWv5Lw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep21ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 16:06:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8894570b58so3282520a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783440417; x=1784045217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=msRIME6nGWnCo7DOyR438y2zmJoRfrOYe4zV2WW/KhY=;
 b=i0s5CltV1qo2nwfutK84ZUcyW0WxHEL8yJfZsh7WdNu97WXky6zpNsLfc+9KLXEO09
 vRuc1pTmJbQggLD3qWQFV99cgUb7X1yrFokx/eSt1nZIAnbBhZxAACU5F2vAHv5dectn
 W2EH9tiEx0OZcVsDKay8MDXUNRbJvEKbdoYA3BeYle1M42MbDBAwGw/Be1G73Sy5M3dV
 TQpr5EmYlDviHRX3jUHvrJeRjZZBhTojlOLwpPsm4tiDYU4PBMoen35VRUpU3X6j/G8F
 aEpd7zFu6/o9zJOGwMXwek7ArK+RNLC9cssS5vD+DrT4L/9pAXvDNBFpLr1iK3iSmub2
 ArxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783440417; x=1784045217;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=msRIME6nGWnCo7DOyR438y2zmJoRfrOYe4zV2WW/KhY=;
 b=CZ8dgSObpQvqjVUA2osmSA811nyUnyWJ79RjcnsyZwluR8H5s8oYy87S0Fsc5EAcqh
 S3ZsKz6Cx1uVgNgZ0rcCDQQbeOMpzIbDUoqEwGOUfmTDo79pFG5t9gETlx25UISDOwJS
 nOOOiRsZ16Y2TpmaHFigGfarE9s2vSeKal6Y9CZHah/e7VbLoQmygmX07TpXNfAPItXb
 KCnfZpyrmVN/TWhhbAPfncQNG2HI78NSQKUNfEoBc8UaE/P4O7XWRiP6JueUXbQKqFFp
 lZWGwkvfRCTG0KnTSLFZWyWdVJGi6ZEgPOMnIEREWfFldq/aOdi7ET8uLiD4fxER0IQn
 CrQA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+CR5tt0hPqJm2FWix5yqXKH7zVZEmBZDt6+Nvz/OwgHrf627FcB+1UsUu8PFSKXXvrd+k6ih/zigU@nongnu.org
X-Gm-Message-State: AOJu0Yy7mYZL8ljYakFjFFqJNSQYxBtADTfOZnFN9jJvadx/GgTWcuTN
 e++J6cKlKrtVRWS+Y4wDvNJoLzH9T7kuQIEFfAXdY61/K1uwJrKQw8Kt5dhUrYZOYMDW105At2+
 byEEiK+3Sy81tHGXjbkk6NAGbYxm9B2MMMjWGdw4IGZ7aEWqpXgZnV2Wmzw==
X-Gm-Gg: AfdE7clIBYbenWN6h1GanNmJ9j2mz0gYuv9Qv7g6TttqW5IsRaVGyncA53ETmBURtZ9
 leWiSbmlWamT6slXJC1sJ9hvwvbcmqsboz0UxMcJ3vx5OMka6YCNLMLtSEtwpixp3QwT+VUvU51
 puUkGTb5xwzQCJcrzuJ4RN94pLHUBR14Yp5W2c1nXvKJg11Kw6rgqk8QKSrE6OmPY0mMIVgqGZv
 FbBwf+GJB3v9h36I6KLv12ObWPiuq1IqfEFl8luitOpMbf1EXvUQ8Ug1+7O6HKNwm1jaFBqpOUJ
 JKs+b62W5LN0IhoTVwXWF8pt+uf7JixFXmdCVXUzVFM7Gxvx34gxwsZQLaTkLiG/nnNvKXKwwpU
 RV+to7XLaztx6PSo4zxsTEFfBlzfBhoqD81qik7GdgBpUCqCrUMt48u+rjLCB1DGrWmhzOm3g/c
 HnS/M=
X-Received: by 2002:a05:6a21:7a46:b0:3bf:d1f9:b1dd with SMTP id
 adf61e73a8af0-3c08eed69eamr6210113637.44.1783440416582; 
 Tue, 07 Jul 2026 09:06:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a46:b0:3bf:d1f9:b1dd with SMTP id
 adf61e73a8af0-3c08eed69eamr6210073637.44.1783440416125; 
 Tue, 07 Jul 2026 09:06:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659666e7sm12045177c88.7.2026.07.07.09.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 09:06:55 -0700 (PDT)
Message-ID: <72faad3e-0f94-45d7-b16f-a8aa188112e5@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:06:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/gitdm: Update Qualcomm entries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marco Liebel <quic_mliebel@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260707153003.58914-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260707153003.58914-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SWqBU8RjC5avs6sRa6fqNdIYKh0LYMd1
X-Proofpoint-ORIG-GUID: SWqBU8RjC5avs6sRa6fqNdIYKh0LYMd1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE1NyBTYWx0ZWRfX0B+n1GMRBfFm
 KJu3NvWRYtIZJxTJcBtK1bmTsPxvy+Rc1pONey53hos+5wEt//0C/QWD+ZViTxuhA/CE+GA0NCg
 Tgm7MNqzGT8nXxF7/gQYMPIs2jWF8j3b+XK+BQcJEZjvXqUo7WTDcbuFToVfYdkVexgdEIrCWO7
 IKQ5z2bzzkbGTyXTfh8KQvDbiTRzOLb+eeaPAis3UW17CoH1kRsT7/wsbp/3+iH6Ga0CK+wOb41
 uGIW2rbUCf7tdphvQl7QklE0kMHFcW/xyPxtQyHu2X/rAvXmttwbB3wuKWGCyaMJ8427tynKxDq
 6jzTT43r2OEcJXkY9JLtGm5jaDbktEQpAq1YXe+cVBQz5DBHSIK/QQY5Wa8q8/v3JhSST4hI8o7
 4wGKRrxMZcNWqZ1/yULfOXgML0Dc5hfsqhzbUC2HDMPm+sOLV1WeEoPSrh6WALqJByhb3rtaIWk
 t9aTxiRP776k1b6ol/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE1NyBTYWx0ZWRfX4/26r1tnVNWD
 UaviNsspDLQlc8MMgvFuwTkJJuq/8HxkiX73UL0vcjyMOlvI5CwRYZkmlJGKIQwqAD1/M1AU6w4
 V0c/yCtuu+Toc5oxEHKj/9lOuzRZvYE=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d2421 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qziLYJvLLT2B4hVKgaYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070157
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

On 7/7/2026 8:30 AM, Philippe Mathieu-Daudé wrote:
> Add an entry for Qualcomm Technologies, Inc.,
> include previous quicinc.com contributions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> Cc: Marco Liebel <quic_mliebel@quicinc.com>
> Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Cc: Sid Manning <sidneym@quicinc.com>
> Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
> Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Cc: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  contrib/gitdm/domain-map | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

