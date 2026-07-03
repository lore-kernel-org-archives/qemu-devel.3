Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F543C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbcn-0002xF-9g; Fri, 03 Jul 2026 07:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbcl-0002wq-PA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:59:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbck-0004gk-9e
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:59:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635ruOt3135377
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 10:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Ke30WT/Hdhy+5p2C61rQwIVcCg2k2Aks67aCbvhbGw=; b=BlOezmq5WG93Kyee
 4qsSbYGPFRITniOB8GLLHJIsNBk84127LaJcJrkY3FMFWvj403Y95ty9aXUS1dAk
 H5l7ABjy3Ey/LoRBAfXTlAkrftL9ttX1UwoIOEFkaPGOAlm5WnZBAdcbEqZgBHdc
 eNgZYkJANgEupbsOMZ1pnIJxeST0t7/fPKPoTvUsnTfWciWhrYv67a5G/EFPEjkI
 LBFw4RFH6vrCT0bR+Hl5CKAcOVm/Q9mZ/Lhm9prRFNjUwcdvUGoWZSmaQU7rFTB4
 j8TDqX4xDnZ0/k2ITum+loOT7jYRdZjmv1v5TzcI+t15zkG4OpAMgG5DgLPt+s67
 mFhTAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qchpkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:59:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e55f0613cso35231585a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783076396; x=1783681196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Ke30WT/Hdhy+5p2C61rQwIVcCg2k2Aks67aCbvhbGw=;
 b=bI/TMW881V923qLscy6GNNNi+l5FZ55sbA/aQiVCJ/qfoIYhzKVntAGtUrt4MqQU81
 4nbbfwS3qE8yMmtVYYt94/Tajc3AizpUmdRHEhoIN84UZti2lKCGjelDyNEJUyHBov/m
 X7sDK/sqF4aCa2b2xhmpXRL7TKb7Z8YwgpxjBjZNiuAL6FnIjjcxLCBkAeOPzoiffvPQ
 9bVpT2W9Ytk/aUeEkA96zZeQ0TO530TtNBqwQx+4a0LhYbhhIbfQY94ocdOODnPKJKb6
 riop7o2oWdKdvGF4lEFoxfaYcIRVjSMaCCe6OWvfQ8xxIHvmwjcUGq7Yhj5EyrVY/6Au
 gDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783076396; x=1783681196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ke30WT/Hdhy+5p2C61rQwIVcCg2k2Aks67aCbvhbGw=;
 b=fGOkZPw2tfl9cHvquq9SJM/xqhP1CfGpU/vOvXpcumGFfizrIeHrINChSL1Nk9cEro
 2xJz7m5waquJiUcGrJQlr7ejC4md2/9sz18YO7ZZrJ6745IZKPzw5vVEk6pI+yCp1rgS
 kY1dOz8qpBbONWA4QYeWfnv0SVy7hpnrV5NB3gy/6xkiFM65Pq2W2pWbJZjNk5ze3t0Y
 evzm9XAdPJedyTZPVD+88wIm0LYhi0NW1aR4K27ftMj2t+wKQ4ctry0jeM3N1BRvy1gz
 YgqxHEnasnQwSFLrJNRXt0gEWnyHC65JEDJVSysdOrAspOogBgbL+Mkzi1rnWJkeegSv
 WCyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bVVE0Kxt46BjjBB/ghycHxVU5A5ZZywPGUt3rF5vtrZob2bS63SJhhrthoMvwybxpl7g4aJspjs2t@nongnu.org
X-Gm-Message-State: AOJu0YyeAFCqxnzaBHNL0Wy+Z6yNpxZzwxHkm+uaS/rVVNgMDlUht5EO
 Jw7F/uL2u0pm2maX7+bFYpIi7r6DvvG5ZOB4oQpmClsHsHev4jJoS/YRqKhZxKieyeIVRwH11lK
 CcKXMnyNBG47T0we0QnlN8rgU3lFBHbllWgf2Kna0f8JzB9gtFbh/EilzuX32n26MiQ==
X-Gm-Gg: AfdE7ckcVzeqnqgtcuK4vonTPEZLcc2uCZT1IsyvXgV8xAZO7Cben8dBxT+U/tFHUus
 Fme3kBDQa7tzZrEKGD0CP+y6CN6FonZLA7t+cfk7LL5n+aAgs66Pbn2nC0AoKNbm0XqEFDFSqHD
 lNVHgubKwPuwPtPI1GEyJ2b1oFLiVm//h4hHBxyvWv08/kZY+BZS3LFfPeMDWWp/O5vc6SshHmW
 niVhkhMHdGLcFYHFKXKuIALGjcPbCS2uZ80fm9Dp+Vu++VnjucRAuW73C8o4zk+hcHDIAdr6EK8
 m2SDt09XZY9iedDrLe20kY9/hOpr014Zm0YHGrK8WLhwuZ7QsT0UAz0xILYPeDKqIXrEPbhoskC
 QJpgOqwoPpmHij46ONk8DVRjg4gb+KM4dtyXv7gli/VjgxIvG+GHQmMUsjryRrQ==
X-Received: by 2002:a05:620a:7006:b0:915:9e84:85d1 with SMTP id
 af79cd13be357-92e7825b58cmr1484047785a.23.1783076396121; 
 Fri, 03 Jul 2026 03:59:56 -0700 (PDT)
X-Received: by 2002:a05:620a:7006:b0:915:9e84:85d1 with SMTP id
 af79cd13be357-92e7825b58cmr1484045985a.23.1783076395750; 
 Fri, 03 Jul 2026 03:59:55 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94c8ccsm18006721f8f.21.2026.07.03.03.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 03:59:55 -0700 (PDT)
Message-ID: <fde2fd94-ff0f-46c9-bb10-c8ad717798df@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: add LoongArch's maintainers
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, lixianglai@loongson.cn
References: <20260703095538.3211983-1-gaosong@loongson.cn>
 <20260703095538.3211983-3-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703095538.3211983-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0piyGLYBZYaTL09G_4aGIuGgK7u00TLo
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47962c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WNn6Axz0fEoA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 0piyGLYBZYaTL09G_4aGIuGgK7u00TLo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwNiBTYWx0ZWRfX+5THPO/7yR7k
 HoVYvXdvTnIsjyJ8tmZ1m9mWTfTCHqXCRQJxIoISnlr6n7SILyh2+eIV8n8VF58nAYwSv3FkuDp
 HYJKnV9DncYUprwZkxQBaMCsNQvHUV03qoRi9+6s/oQ1NGWNjEr3WAtbTurYfgw1XnVEaZ1Z8M0
 d7CoPqjzlruKZPpghyoppTNmbgG8iJBovSZ0YxHKdQf0cSBt9kzBRoRvdgm33qG3ZmH+XNJAXK+
 rVFAt31LejN6JnapMAF0H/5II+oF2Zv+t45V6oDWFOLe1bxz86U9W7d/6nGlxyg/kg9dyDZiho5
 3el2KvWArXxnYajSkmTH5TwPbR36eO/oJNomfmNcyxmCq6e71j6T6G255KphF4Fp9ZjFgQgQJoT
 DhpqiQrk6eMtUu3ZxQSiKzApPuZls2H8oXEtpjwVhlrfuUshGC/Q0Yr6k0ovJXojT5lUR3rrsjF
 UYq/PpUj+blHZHyW2eA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwNiBTYWx0ZWRfX4KBofbagq2sZ
 VQNu0rbqJi8INb9EeS6czAiQrgH3ktcCi9abZae3Dsv0crMVHyDEoNNG3is2ridg+IgsSH2g4+S
 Xgoijuz/YaM9imLm1RihXoJAEx47eV4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030106
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

On 3/7/26 11:55, Song Gao wrote:
> Add xianglai and bibo as maintainers for the loongarch architecture
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

