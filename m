Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A83EC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0dW-00023J-Td; Thu, 20 Aug 2026 07:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0dV-00022l-3P
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:08:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0dT-0002Gi-66
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:08:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8PE882465462
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c31dnXsQ96ljlBIwQbwxQDilZYS8RY79c5MZtrbdzbE=; b=hHUkV2Zo901mwA5b
 QiepYRrtvW7EQW2Xod1M1uPb8ZEPatDadb2TUYvMoaprjdH52MBXTrtq90frBUhi
 FjB1tiBhXy96qRo6SJwwqqs/q2dvOQUpGjHcVZHE4jsWSYomItS/dLOWoOLL1W5q
 uXjPNAKmW58TQMubGwf8ZGxMWSD8NUrl4iWAN9VdTmvjYfRgyWqALMZxJMTEB3z/
 HOMys8vOF+FUvYEuoAW39mkBSlLR82QRlSfrl3jj90i8eToaJT5eZ5wgL5QoVwWP
 xW89aFZHnXRaRDofVvOpl2m6gNd7mJ+dltDDyVDU5EQ+m27BjoOPJhLezt/NtfnH
 cQ213g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29gmm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:08:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e63df032bso91634185a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787224117; x=1787828917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c31dnXsQ96ljlBIwQbwxQDilZYS8RY79c5MZtrbdzbE=;
 b=LOFzUvwbE3ZVB66oa4WWe5a7VQsyOYe/Y2F+XjTBaK17bUiBRaRguvlsoiArGQ5GVa
 /OrbxIFog6qDhJnsgPiG7Hzlkx280oYeuFh5SMXuvI076mMpwGIhPfxKDUMzSEP0TGmR
 WXhzb+H6E58fHzCLnC6fVK1ZcWirIJHQfgDuOL48MfJq8wVs2zYu5FkEmV6uCymAk6Mb
 vDEyt0ssjR0jXVQeuBQ3RYtzD23EledxCoXrVvSNWHRXXr0S/lX9vLDipz2bczbHw7jJ
 RjeMpn7T8dBVmcQxyLpgYXAItc4zjdRzM35Rho67XBOiIwu6gzURiHkAM3/6WNotmuBr
 zQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787224117; x=1787828917;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c31dnXsQ96ljlBIwQbwxQDilZYS8RY79c5MZtrbdzbE=;
 b=B4PxQNBc7MMdomnC+2hwKuoIXkh2x59BtkUb2tWiHGWGC+Xwufy2f9dCxEHjJI3T5T
 Zsukp0PSWONMbMPpWGEJqjZaYR8+1/PtXYiIXdiBK5IwkkFbpWVUmSWvxHGJFy223D+q
 6/+AlSKGeLAi/xiKvNO4bIJMjjAOKrJNkUrt0AmVDMzvFUoS3Q7WMPEAlCyrAqYFdH2q
 R86P+xb2urrF7X6qdRZs3KGDVifSyAj0Vmk32pWti8ZsNNwb9T947vtUVe2hLxjHDEQr
 am8Q20tOCt69QQqPCfJyfCT3I1DymvBEyvZHtuKbKWJ0LpA3sPqKdNpYefsutpyBIxrw
 Eitg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4MiRtZGJNHs3ejyn8YoSRLVdCiXGLKT0UkW2Cw+bjZ3pJwa38vkrik6XgZ6OBNqaerZ+5Pn0aTgNl@nongnu.org
X-Gm-Message-State: AOJu0YwXxWnDucfod22ufIQO66PLtHr31m2UEXTfITntM0jACYS/YxrI
 +NRHtCv6F2cH1NQZvXbTu8zZbP0Xt2ClRtk7/TMJNNyAEqcGrgzxHoIvjgr7DM6+J0qN01DJO/2
 qLncfK6fzGKV7hyBXNsz+7plp7O/LIOxdOUle3wZjJxUlN9MWU4HwtntVNw==
X-Gm-Gg: AR+sD13m5c2hHYH472o6Q8cO1W3QserV2DuEoFTwOADDDN7nCASjLwpJQpcxqB+nAjm
 8BWhnRpHHxZX7jE8H+KwOJc6T1QkWBYW2ey8UXjlCDOxChk8pIKI99WUiB7lpW8xGHeGdEAvJn2
 OrahzRdC7/+UCyeHvF1wvM0JDntt6j7ilSQZHDrbXmBX0pirc5QzjlGO7hgahKvsXfYxScgE+Aa
 gZh2EHF2FLsWiBNH+IM5pCXlmLl3fRKy2oSCLFBoObzSSWxrlxq9uoaHxcgPc+DUi0PqiNNPjGJ
 RVAG8RotF0boTETA4Ok8mehKNLnD+yxCO1trtqIq/XYzwIkEjEh6K3EIA5lUrPcwTGWdRltCFfs
 xujvsIW/s/FvfMxFfaOjuQ/Qm0sF+c/1n6ko=
X-Received: by 2002:a05:620a:6083:b0:930:9533:5e32 with SMTP id
 af79cd13be357-937283bae62mr540404985a.7.1787224116725; 
 Thu, 20 Aug 2026 04:08:36 -0700 (PDT)
X-Received: by 2002:a05:620a:6083:b0:930:9533:5e32 with SMTP id
 af79cd13be357-937283bae62mr540400885a.7.1787224116322; 
 Thu, 20 Aug 2026 04:08:36 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b23a00sm29502815e9.3.2026.08.20.04.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 04:08:35 -0700 (PDT)
Message-ID: <801cdc3e-9afa-4073-87a1-ef030d359751@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 13:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] hw/ide: drop a redundant interrupt from
 INITIALIZE DEVICE PARAMETERS
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260820100844.411717-1-den@openvz.org>
 <20260820100844.411717-18-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260820100844.411717-18-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _pNLUxPAqMvmhHhx3BdJK1x5ZburscQr
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86e035 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=5VAHT5MAFjTCagGqsCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Hx1yvPaMooE3kwe23bt7:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4MiBTYWx0ZWRfX2qQ3QfO2WCNo
 Fm7rPW7KaLFim/wbiZuO+7AUPoqbc0C3QSZ01tmMfbxO2chzCDr2j6pX9s1MwaN54+Kvc892PFK
 TIztiJer+NElKHTG7RK8/rdJNaJk+OohNXg5Hc1311wfk0GB0IveMEZDw9CKMATUjK3LzFwR9tm
 0LuELZSJtYNFFOeEBF7N1UKr1B6ILU26G1AF/ZdU7eo83Wqk2m1ZxRbt3MYAG/hpDgvW+MVgo5j
 tL1YQnkdguBivbrj3nc6UjEY3bNcz1SaW4QXH3YFUpIs4J+J35YwgDyqjuf6gL0NZ+ruWE401t2
 ZJM8C2rpj69VK0oI1oAbcn8Xs6xjNybHUIQ6vo5VYZMM8AfuvUZ7N1q1uSGAX1YyE+wzMftgcds
 nRtkmFrzc/6tkOcDWthZNA/k1zD7psFfzi2OcTa9TXXujKsQ/TtX0ImYu9rF06dnnwlg/8YmGUo
 HRF8sHlFWlAnmKB94gQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4MiBTYWx0ZWRfX8cNwjmNTb2aK
 dX8biwPXxbtDU5zQ7zHQYgfbBMerbpQY1hpffDucl6jY0sB8w3hjh9JV1gawSiXdneo/0lx4VGQ
 q3fc9ETgNuzRmskwZHGMQA03GY5sVrI=
X-Proofpoint-GUID: _pNLUxPAqMvmhHhx3BdJK1x5ZburscQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 20/8/26 12:08, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> ide_bus_exec_cmd() raises the interrupt for every command handler that
> reports the command complete, which cmd_specify() does, so the request it
> raised itself was the first of two. The one from ide_bus_exec_cmd() is the
> one that belongs there, being raised after BSY is cleared and after
> ide_cmd_done() has let the bus master post its own completion.
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/core.c | 1 -
>   1 file changed, 1 deletion(-)

Good catch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

