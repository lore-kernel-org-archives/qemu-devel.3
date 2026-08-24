Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D34C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycAk-00087Q-Nd; Mon, 24 Aug 2026 17:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycAi-00087I-KP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:25:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycAg-0005qY-2s
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:25:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJGlRE266546
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VNg8bsw2vWQGeqz3Gjihi5OQdO1wjRXRdLtdk0cCY1s=; b=X1IjtAhIxsHektkm
 N/S6uP+iwDCc/Qapop9i0/HY8omVVH1pFpXMBPnmhpsDg6/a+VB1xRcJi1fSToss
 taV4Y94C8LiI6F/iM9umKNDeTgfN051FkjjYUZARbmVq5VoSqwk3xjU9c2UF7glV
 zCZspfTd+2IFdUmaQZ6LAC+Ub+MWko4HN1b9luFjLPkOSO8qtn6SocXOykHGVEVb
 1TDldDBw8Je6Rs4Suma/qT+zqMYqsgw33tYqj99UDOQfVk4XX3biZ1vCLu1OJPDM
 yIMB2P2X6yNn+4S3IU2kyEkBeRkf3vlGt3ryGpfhcz2KOOTTg9xY7QmIWsgLoX9d
 EbSKww==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk3ch6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:25:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283df62d68so53337021cf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787606729; x=1788211529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VNg8bsw2vWQGeqz3Gjihi5OQdO1wjRXRdLtdk0cCY1s=;
 b=Mgl/ZgZ1nGQrpmndYFqF+OW7XMyqNqWRkbjIrPZ55MGBWyMwz2BzrLXHA1ATDxoHQU
 eUpTT2WJERZX533+euNJMW77nKmKxJF3iyr5EJnk+hpfACX4fa8u5m5GaICD4DVwqxpy
 RuCHPw3VeDvBKwM5h7JXJfoWizkYNpM/wzthFUvL5kdDovn41/hQ2K5D2V+ybx0nbsv7
 BAETh5F5DiXCKu9sTnlT4L1UVkTXm7jTbaVpQrUSQHTbXP5oYnLcehudo69mB4+K2Ju2
 z1urNJXvJu3l8wZZeFLd//vX15GlQZ6HW6UKgiEdXK6XfpxutsCEeSGG120LrimO4wxB
 g1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787606729; x=1788211529;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VNg8bsw2vWQGeqz3Gjihi5OQdO1wjRXRdLtdk0cCY1s=;
 b=LvtkJfQoKnQn7UlSTyTm4dVV5TKl5cM4Tg3pH7/Aw2wQshRgDDY4bqhPWu3NaQWe8S
 3+rbftBqyhYbuSzA8QpGwEX7gpWiYObiMCgw3Aza95U3FDdaUEz/9JqJtBi25RrHrPXz
 sv3cx3FPfKBFvfcRBs4ZgwH2qVcFpDlt4qpHgASIqbhDGBY2jpFjGL3TJWbF84mAFYzq
 VdnklITJjdm5eYlQ0rCGUwhZT/9Ib4UHhTDRTxtWKMcNZjABxKbsqpSMwY1LTZGP4Qul
 TSMJOSO+MQjMmJcTWk0BceubjDgn4+d5hhgt7Ije/8YWswKcEnkjzUy10QdA90UHIc5O
 1FkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RodefFMsj1PWYz/rX75tHYauor25w9SDjyGaO1X0jVDoGF3VBE8PIMr5UCDxlxfomP7ZhC4KOHIuT7L@nongnu.org
X-Gm-Message-State: AFuF++lq3VZPtWbLnFWNEr1YEVff9wPMRCHnFLCqFLJ4bT/dHmdpgojq
 aRyxbu8IqP8I0AmdCS2NQocWUsEbObrRVALJmbeHpWdMNzDPdiFmPThiiXEmdsVz86xTFsJawZv
 WXqd48b0aEfzh8H6icrkNrFwlf8Ywo1+gjd8IoyVPlV5Px2wQb9sGG1x94aoyVcDwnmsC
X-Gm-Gg: AR+sD11314c/n96aIEmgL0pR3jbAgaDls0L7ZM27MaCgn/7vrX0uhijh/pXNdYXKX6r
 69A64K40Neu7IudLZRd8lk12w0aI0JFMebwtWMzV7yCubLu1nrRDDvNwwpEDCIfVQE4efQfyiC/
 PkszDDYbRR03iu4JHnQlkTr5KE7u7RJRqCwWuEnbL5kk+KUuiDVMOLEsnwb4esKM2jHMZlwNXzK
 jWvXDzxIDvr3R09HrajVSi6ZRd8XEhfZC2dBhz4IBsRcmQ9nwmOXPyPvHw1Qne6xzBuomH4heN3
 CPjlbyUID7BJBXb6HcUze36DC1W5qHUCu5ghslJ65Fgyrx8j6v5jVTfB/S1Jr7HEXptBl0siH3k
 3quftRzXnsKhE53/3tFI5vfrXQLHQlqJYNibg7EK+zIrScmZtTZw=
X-Received: by 2002:a05:622a:258d:b0:52d:97cb:b678 with SMTP id
 d75a77b69052e-52df574c96emr332837031cf.18.1787606728967; 
 Mon, 24 Aug 2026 14:25:28 -0700 (PDT)
X-Received: by 2002:a05:622a:258d:b0:52d:97cb:b678 with SMTP id
 d75a77b69052e-52df574c96emr332836471cf.18.1787606728412; 
 Mon, 24 Aug 2026 14:25:28 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d6396109sm7388645e9.12.2026.08.24.14.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 14:25:26 -0700 (PDT)
Message-ID: <bdc0e98c-102a-4aaf-b241-1443b3e29ade@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 23:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/14] python/machine: support routing semihosting
 output to the test console
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
 <abcd31dac2e35f91d306d9d79a7381d073057f60.1787586642.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <abcd31dac2e35f91d306d9d79a7381d073057f60.1787586642.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4BPu1M6FBn64U9dZbxZpdkUXwksFqLBB
X-Proofpoint-GUID: 4BPu1M6FBn64U9dZbxZpdkUXwksFqLBB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MSBTYWx0ZWRfX/b7bwxhECMRe
 1vPo/s/w634rhBt2RWsCunQTrJ/s68+haFJJnWCM304ibyivlcC6LacGnsGAqrPLXoZ7/FGoZ27
 GNKhxCpwHJGYcnfVn+JnCEGKcZ+9fWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MSBTYWx0ZWRfX+hStnRt8sHao
 jUY+gi1tIEa5SGQkx5Jqr+LU04lOnj+IYe3sgNQbIrojOCFmayDJj38PEPTEAUjPHQjXQOcerr+
 GDYo16VD9rkdN0D9vetJ2CXUfy+9oUcKxomBTRsaCRe33UIOVsQp+g9Q9bXnqzcAZGiL4NEc7c+
 UqwFpsBEt9jNw+Ks7G9IisOcndq88yDhljGHllOukPZ3ACTpgNQBGKoW02Pk4mqP+WK1HC0Rbx/
 VvGKtfQbQxn9JE3nrPiCaEybyDothAbmtrbA2hPf65rxyH7/CcVRTaouR4M6pI46mIJOG4fyAu6
 jkdoVus8lER4lZrhZSeI/AMHqJymNEzzuTiRge63/VIChuDnTczLpXyA769zVZhiIWy9An6XZH9
 Hy+CVOJEJeSeRm+om+Yo/JP/wzjXZPWKPaRtiwBvDEhU9r++Iy14y46oFvHxpyzVDIHTOwcEnzM
 v6k55QEwYs4xND656sw==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8cb6ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240181
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

On 24/8/26 17:58, Matheus Tavares Bernardino wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> The hexagon semihosting systests will wait for output on the semihosting
> console.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   python/qemu/machine/machine.py | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

